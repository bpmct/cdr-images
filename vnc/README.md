# VNC in Coder

Coder works well with VNC to access graphical programs on the Coder workspace. This can also be useful if you need to run applications (ex. Postman) against a secure network. See our docs: https://coder.com/docs/guides/customization/vnc

Unlike VNC-only solutions, [Coder](https://coder.com/docs) allows developers to code with a web IDE or even a local editor. Coder also enables developers to SSH into their remote workspaces, without the need to manage keys.

A [sample image](https://github.com/cdr/enterprise-images/tree/main/images/vnc) for Coder that uses [noVNC](https://github.com/novnc/noVNC) as the client and [TigerVNC](https://tigervnc.org) as the server.

## To connect

- Option 1 (Web): Create a dev URL on port `6081` and navigate to it
- Option 2 (SSH Tunneling): Use SSH tunneling to expose the VNC server to your local machine. You will need the [coder-cli](https://github.com/cdr/coder-cli) and a VNC client installed on your local machine.

    ```sh
    coder config-ssh
    # Forward the remote VNC server to your local machine
    ssh -L -N 5901:localhost:localhost:5901 coder.[env-name]
    
    # You will not see any output if it succeeds, but you
    # will be able to connect your VNC client to localhost:5901
    ```
    
## Shell alias

VNC support may be added to the Coder CLI. In the meantime, this alias can be used to VNC into a compatable workspace.

Change the path to your VNC viewer. I used TigerVNC on OSX.

```sh
coder-vnc() {
    coder config-ssh
    local VNC_PORT="${2:-5990}"
    ssh -N -L "$VNC_PORT:\localhost:$VNC_PORT" coder.$1&
    sleep 2
    print "Forwarding VNC to localhost:$VNC_PORT"
    /Applications/TigerVNC.app/Contents/MacOS/"TigerVNC Viewer" "localhost:$VNC_PORT"
}
```
