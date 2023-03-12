#! /usr/bin/python3

"""
Usage: SparseCopyKVMDisks.py <Source Folder> <Destination Folder>

Copies all KVM Sparse Disk files like raw, qcow2 From Source Folder to Destination recursively.
This script will only copy the sparsely occupied space (On-Disk Size), Which will be much lesser
than the Original Virtually Allocated Disk Size (File Size).

i.e The Disk File might be Created with a Virtual Size 100G, but might be allocated only 5G.
In such case only 5G will be copied. If you employ normal CP, rsync commands, The Destination
will hold the entire 100G pre allocated, wasting lot of disk space and takes much longer to complete

The script will report Total Size to Copy, Already Copied Size, and Time Remaining to Copy 
Pending File and Overall Progress

The script uses 'qemu-img convert' commands for this purpose.

We uses this script to backup our KVM Disk Images from NVME/SSD drives to External Backup HDDs
"""

def bash(s):
    import subprocess
    return subprocess.check_output(s,shell=True)

def bashWithInterimMessages(s):
    import subprocess
    process = subprocess.call(s,shell=True)
    return "done"
    
if __name__ == "__main__":
    import os
    import sys
    from pathlib import Path

    walk_dir = sys.argv[1]
    tar_dir = sys.argv[2]
    #walk_dir = "/media/nvme_data/VirtualX/KVM"
    #tar_dir = "/media/abraham/SeaGate-Backup-HDD/Virtuals/Virtualx/KVM"

    totalSize = 0.0
    diskCopyCommands = []

    dskType = { "img": "raw", "raw" : "raw", "qcow2" : "qcow2", "snap" : "qcow2"}

    def CopyKVMDisks(src, dst):
        for root, subdirs, files in os.walk(src):
            for dir in subdirs:
                CopyKVMDisks(dir,dst)

            for filename in files:
                if(str(filename).endswith(".img") or
                   str(filename).endswith(".raw") or
                   str(filename).endswith(".snap") or
                   str(filename).endswith(".qcow2")):
                    ext = str(filename).split(".")[-1]
                    file_path = os.path.join(root, filename)

                    def size_on_disk(path):
                        st = os.stat(path)
                        return st.st_blocks * 512

                    fileSize = round(size_on_disk(file_path) / 1024 / 1024,2)
                    global totalSize  
                    totalSize += fileSize
                    tarPath = tar_dir + "/" + file_path.replace(walk_dir,"")

                    p = Path(tarPath)
                    if not os.path.exists(p.parent): os.makedirs(p.parent, exist_ok=True)

                    shellCmd = f"qemu-img convert -O {dskType[ext]} {file_path} {tarPath} -p"
                    diskCopyCommands.append((shellCmd, fileSize,filename))

                   

    CopyKVMDisks(walk_dir, tar_dir)

    totalSize = round(totalSize,2)
    progress = 0.0 

    import time
    startTime = time.time()
    progressTime = startTime
    progessTimeMsg = ""

    for copyCmd in diskCopyCommands:
        shellCmd =  copyCmd[0]
        fileSize = copyCmd[1]

        os.system('cls' if os.name == 'nt' else 'clear')
        print(progessTimeMsg)
        print("Total Progess->" + str(round(progress / totalSize * 100,2)) + f"%. Copied {str(round(progress/1024,2))} GB Out Of {round(totalSize/1024,2)} GB")
        print(f"Copying {round(fileSize/1024,2)} G, File: " + copyCmd[2])
        bashWithInterimMessages(shellCmd)
        progress += fileSize

        progressTime = time.time()
        elapsedTime = progressTime - startTime
        sizeTransffered = round(progress / elapsedTime,2)
        pendingTimeInSeconds = (totalSize - progress) / sizeTransffered

        import datetime
        completeTime = datetime.datetime.now() + datetime.timedelta(0,pendingTimeInSeconds)

        progessTimeMsg = f"{sizeTransffered} MB/s. Copy will Finish at  {completeTime.strftime('%H:%M:%S')}"
    
    print("Completed")
        