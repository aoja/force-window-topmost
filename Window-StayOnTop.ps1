# MIT License

# Copyright (c) 2020 Antti J. Oja <a.oja@outlook.com>

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Build the Win32 API import section.
$apiImports = @"
    [DllImport("user32.dll")]
    public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X,int Y, int cx, int cy, uint uFlags);

    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();

    static readonly IntPtr HWND_TOPMOST = new IntPtr(-1);
    static readonly IntPtr HWND_NOTOPMOST = new IntPtr(-2);

    const UInt32 SWP_NOSIZE = 0x0001;
    const UInt32 SWP_NOMOVE = 0x0002;

    const UInt32 TOPMOST_FLAGS = SWP_NOMOVE | SWP_NOSIZE;

    public static void MakeTopMost (IntPtr fHandle) {
        SetWindowPos(fHandle, HWND_TOPMOST, 0, 0, 0, 0, TOPMOST_FLAGS);
    }

    public static void MakeNormal (IntPtr fHandle) {
        SetWindowPos(fHandle, HWND_NOTOPMOST, 0, 0, 0, 0, TOPMOST_FLAGS);
    }
"@;

# Import the necessary Win32 API functions and IDs we need.
$app = Add-Type -MemberDefinition $apiImports -Name Win32Window -Namespace Sandbox -ReferencedAssemblies System.Windows.Forms -PassThru;

try
{
    # Write basic instructions.
    Write-Host "Select a window to pin on top by clicking on it and wait for 5 seconds...";

    # Initiate the 5 second sleep timer.
    Start-Sleep -Seconds 5;

    # Get the current foreground window handle.
    $activeHandle = $app::GetForegroundWindow();

    # Set that as the topmost window using the Win32 API.
    $null = $app::MakeTopMost($activeHandle);
    
    # Debug output for the active handle.
    Write-Verbose "Setting handle: $activeHandle to TOPMOST state...";
}
catch
{
    # In case of an error, print out the basic details.
    Write-Error "Failed to get active Window details. More info: $_";    
}
