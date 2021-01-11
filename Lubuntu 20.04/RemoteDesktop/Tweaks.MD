## XRDP (How to Enable Sound)

Build and Install XRDP plugin for Pulse Audio from Source

[Build Reference](https://c-nergy.be/blog/?p=13655)

Run [pulseaudio -k](https://askubuntu.com/questions/1228980/trouble-with-audio-in-remote-desktop-session-with-xrdp), from your RDP Session


## XRDP (GUI Apps with SUDO)

By default GUI app will compain about lxqt, while invoking as root.
Setting up proper display parameter will fix this issue.

[Reference](https://unix.stackexchange.com/questions/118811/why-cant-i-run-gui-apps-from-root-no-protocol-specified)

Add the below to ~/.bashrc

    export XAUTHORITY=~/.Xauthority

## Alternate Light Weight RDP Server (freerdp2-shadow-x11)

    sudo apt install freerdp2-shadow-x11 winpr-utils
    freerdp-shadow-cli -auth

NB: Use 32 bit as color depth, if you're using mstsc, otherwise client will crash !


For running with NLA Authentication 
  
First create Hash for your credentials

    winpr-hash -u {username} -p {password}

Set the Hash in a SAM file, in [proper format](https://miloserdov.org/?p=4508)

    echo "[user]:::[user-password-hash]:::" > ./sam

Run Server. Note that, specify your sam file directly (current folder). Path notation will not work !
  
    freerdp-shadow-cli /sam-file:sam /sec:nla /monitors:0 /port:3389
   
