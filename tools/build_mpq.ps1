param (
    [Parameter(Mandatory=$true)]
    [string]$MpqPath,

    [Parameter(Mandatory=$true)]
    [string]$SourceFolder,

    [string]$DllPath = ""
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $DllPath -or -not (Test-Path $DllPath)) {
    $DllPath = Join-Path $scriptDir "StormLib.dll"
}

if (-not (Test-Path $DllPath)) {
    Write-Error "StormLib.dll not found at: $DllPath"
    exit 1
}

[Environment]::SetEnvironmentVariable("PATH", $scriptDir + ";" + [Environment]::GetEnvironmentVariable("PATH"))

$csharpSource = @"
using System;
using System.IO;
using System.Runtime.InteropServices;

public class StormLibPackerRel
{
    public const uint MPQ_CREATE_ARCHIVE_V1 = 0x00000000;
    public const uint MPQ_FILE_COMPRESS = 0x00000200;
    public const uint MPQ_FILE_REPLACEEXISTING = 0x80000000;
    public const uint MPQ_COMPRESSION_ZLIB = 0x02;

    [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    public static extern IntPtr LoadLibrary(string dllToLoad);

    [DllImport("StormLib.dll", CharSet = CharSet.Unicode, SetLastError = true)]
    public static extern bool SFileCreateArchive(string szMpqName, uint dwFlags, uint dwMaxFileCount, out IntPtr phMpq);

    [DllImport("StormLib.dll", SetLastError = true)]
    public static extern bool SFileAddFileEx(
        IntPtr hMpq,
        [MarshalAs(UnmanagedType.LPWStr)] string szFileName,
        [MarshalAs(UnmanagedType.LPStr)] string szArchivedName,
        uint dwFlags,
        uint dwCompression,
        uint dwCompressionNext
    );

    [DllImport("StormLib.dll", SetLastError = true)]
    public static extern bool SFileCloseArchive(IntPtr hMpq);

    public static bool CreateArchiveFromFolder(string mpqPath, string sourceFolder, string dllPath)
    {
        LoadLibrary(dllPath);

        if (File.Exists(mpqPath))
        {
            File.Delete(mpqPath);
        }

        string dir = Path.GetDirectoryName(mpqPath);
        if (!string.IsNullOrEmpty(dir) && !Directory.Exists(dir))
        {
            Directory.CreateDirectory(dir);
        }

        IntPtr hMpq;
        if (!SFileCreateArchive(mpqPath, MPQ_CREATE_ARCHIVE_V1, 4096, out hMpq))
        {
            Console.WriteLine("SFileCreateArchive failed: " + Marshal.GetLastWin32Error());
            return false;
        }

        string[] files = Directory.GetFiles(sourceFolder, "*.*", SearchOption.AllDirectories);
        int added = 0;
        foreach (string file in files)
        {
            string relPath = file.Substring(sourceFolder.Length).TrimStart('\\', '/');
            bool res = SFileAddFileEx(hMpq, file, relPath, MPQ_FILE_REPLACEEXISTING | MPQ_FILE_COMPRESS, MPQ_COMPRESSION_ZLIB, MPQ_COMPRESSION_ZLIB);
            if (res)
            {
                added++;
            }
            else
            {
                Console.WriteLine("Failed to add file: " + relPath + ", err: " + Marshal.GetLastWin32Error());
            }
        }

        SFileCloseArchive(hMpq);
        Console.WriteLine("Packed " + added + " files into " + mpqPath);
        return true;
    }
}
"@

Add-Type -TypeDefinition $csharpSource -Language CSharp
$success = [StormLibPackerRel]::CreateArchiveFromFolder($MpqPath, $SourceFolder, $DllPath)
if (-not $success) {
    exit 1
}
