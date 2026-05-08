# Infect Script — Educational Malware Demonstration

This batch script demonstrates how a Windows machine can be infected and how malware achieves persistence on a compromised system. It is intended **strictly for educational and research purposes**.

> **WARNING:** This script simulates real infection techniques. Do **not** run it on any system you do not own or have explicit permission to test. The authors are not responsible for any misuse or damage caused by this code.

## Techniques Demonstrated

- **Payload download** — Retrieves an executable from a remote server via `curl`
- **File placement** — Hides the payload in `%LOCALAPPDATA%\Microsoft\Windows\NetworkSvc\` (mimics a legitimate Windows service path)
- **Persistence via Startup folder** — Adds a script to the Windows Startup directory so the payload runs at every user logon
- **Persistence via Registry Run key** — Registers the payload under `HKCU\...\Run` for automatic execution at boot
- **Persistence via secondary startup script** — Creates a launcher script in the payload directory as a redundant mechanism
- **Execution with hidden window** — Uses PowerShell to launch the payload invisibly with `-WindowStyle Hidden`

## Usage

```cmd
infect.cmd
```

The script requires an actual executable URL to be placed in the source at line 2 before it will function. In its current form it is a **template** — the `<download exe url>` placeholder must be replaced with a real payload URL. also `<exe execution arguments>` must be replaced with exe execution arguments.

## License

GNU General Public License v3.0. See [LICENSE](LICENSE).
