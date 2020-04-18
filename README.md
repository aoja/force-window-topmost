# Force a Window to be the Topmost

This simple script can force any window to be the topmost. It was initially conceived to fix a simple problem with tool and undocked windows sometimes not staying on top.

## Usage

First you need to allow PowerShell to execute scripts on your system if you haven't done so. To do this, you need a PowerShell prompt with elevated privileges. Type `powershell` into the Windows taskbar search, and **right click on it**, then select **Run as administrator**.

The UAC prompt will ask you for your consent. Accept and the PowerShell prompt will open.

By default, Windows PowerShell is configured to function in `Restricted`  mode. This means that PowerShell will not load configuration files or run any scripts. You cannot run this script while PowerShell is in *Restricted* mode.

To continue, configure your PowerShell into `Bypass` by typing in the following command:

```
Set-ExecutionPolicy Bypass
```

Now simply run the script with PowerShell, click to focus any window and wait for the PowerShell console window to disappear. There is a five second timeout from running the script to the changes being committed.

**Note**: For now there is no way to revert the changes. However, these are runtime changes only, and can be reverted by re-running the program (unless the program itself adjusts the window state).
