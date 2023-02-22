## Optimize Systemd-Journald Service

[Remove old logs, disable logging to disk/memory](https://askubuntu.com/questions/1094389/what-is-the-use-of-systemd-journal-flush-service)

    sudo rm -rf /var/log/journal

Edit /etc/systemd/journald.conf, 

    Storage=none
    SystemMaxFileSize=5M
    ForwardToSyslog=no
    ForwardToWall=no
    MaxLevelStore=warning
    MaxLevelSyslog=warning
    MaxLevelKMsg=warning
    MaxLevelConsole=notice
    MaxLevelWall=crit

This ensures boot speed and overall increase in performance.

 [Disable the service. Not Recommended](https://forums.fedoraforum.org/showthread.php?292543-how-to-permanently-disable-systemd-journald-service)
 
    systemctl mask systemd-journald.service


## Use Right IO-Schedulers for SSD/HDD Drives

[Refer Multi Queue-IO Schedulers](https://avarghesein.blogspot.com/2019/10/enable-high-performance-block-multi.html)
