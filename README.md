# 🐉 Dragon Tunnel

<p align="center">
  <img src="https://github.com/user-attachments/assets/2588dfb1-8b0e-453d-9d48-02df94405f4c" alt="DRAGON_EYE Logo" width="600"/>
  <br>
  <em>DRAGON TUNNEL</em>

**Dragon Tunnel** is a sleek and stylish WireGuard-based tunnel tool that allows you to expose a local HTTP server to the internet with a temporary Pyjam link. It comes with a **start** and **stop** script, both fully stylized for terminal usage.  

---

## Features

- Automatically checks and installs **wireguard-tools** if missing.
- Custom HTTP port support for your tunnel.
- Detects active tunnels and prevents multiple instances.
- Easily start and stop tunnels with simple commands.

---

## Files

| File | Description |
|------|-------------|
| `dragontunnel` | Main script to start a tunnel. Prompts for a custom port, downloads Pyjam config, and brings the tunnel up. |
| `stop` | Stops the currently active tunnel, showing the active Pyjam link before shutting it down. |
| `installer.sh` | Installs both scripts globally, sets executable permissions, and ensures `wireguard-tools` are installed. |

---

## Installation

1. Clone or download the repository:

```bash
git clone https://github.com/YourUsername/DragonTunnel.git
cd DragonTunnel
```
Run the installer (requires root privileges):

```bash
sudo bash installer.sh
```
The scripts will be installed globally

# Usage
## Start a Tunnel
```bash
dragontunnel
```
***You will be prompted for an HTTP port (default is 8080).***
**The script will download the Pyjam configuration and bring up the WireGuard tunnel.**
**The terminal will display your local access link and the Pyjam public link.**

## Stop a Tunnel
```bash
stop
```
*****Stops the currently active tunnel.*****

### Notes
- If a tunnel is already active, dragontunnel will prevent starting a new one and display the active Pyjam link.
- If you cancel the sudo password prompt or the tunnel fails to start, the scripts handle this gracefully and do not show false success messages.
- Works on Linux distributions with apt, yum, or pacman package managers.

  # Created by
### ***INDIAN CYBER ARMY***
#### ***YT CHANNEL: [INDIAN CYBER ARMY](https://www.youtube.com/@webdragon63)***
