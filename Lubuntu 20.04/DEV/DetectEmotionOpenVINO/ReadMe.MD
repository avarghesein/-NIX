# Gender and Emotion Detection using OpenVINO Framework

## 1. Ensure System Spec as per [OpenVINO recommendation](https://docs.openvinotoolkit.org/latest/openvino_docs_install_guides_installing_openvino_linux.html)

System Spec: Qemu-KVM, host CPU Passthrough [Intel Core i5 7400 CPU]

OS: Ubuntu 20.04

## 2. Download OpenVINO Toolkit, for the given System Spec

[Linux 2021.4 LTS](https://software.intel.com/content/www/us/en/develop/tools/openvino-toolkit/download.html?operatingsystem=linux&distributions=webdownload&version=2021.4%20LTS%20(latest)&options=offline)

## 3. Install OpenVINO Toolkit

[Refer](https://docs.openvinotoolkit.org/latest/openvino_docs_install_guides_install) for detailed instructions.

Below commands have been verified on Ubuntu 20.04 LTS. Run the same in the exact order on terminal.

    
    #NB: Change the values of the below two Variables, as per the OpenVINO Toolkit downloaded in Step#2
    openVinoToolkitVersion="l_openvino_toolkit_p_2021.4.582"
    openVinoVersion="openvino_2021"


    mkdir -p /home/$USER/DEV/Openvino/
    mkdir -p /home/$USER/DEV/Openvino/Models/

    cd ~/Downloads/
    mv ~/Downloads/$openVinoToolkitVersion.tgz /home/$USER/DEV/Openvino/
    cd /home/$USER/DEV/Openvino
    tar -xvzf $openVinoToolkitVersion.tgz
    cd $openVinoToolkitVersion
    sudo ./install_GUI.sh   

    cd /opt/intel/$openVinoVersion/install_dependencies
    sudo -E ./install_openvino_dependencies.sh

    source /opt/intel/$openVinoVersion/bin/setupvars.sh

    #NOTE: Add the value of echo "source /opt/intel/$openVinoVersion/bin/setupvars.sh" to <user_directory>/.bashrc

    cd /opt/intel/$openVinoVersion/deployment_tools/model_optimizer/install_prerequisites

    sudo ./install_prerequisites.sh

## 4. Install Required Pretrained CNN (Neural Networks) Optimized Models for Intel Hardware

[Refer](https://docs.openvinotoolkit.org/2021.2/omz_tools_downloader_README.html) to know more on Pretrained/Public Model Downloads (Tensorflow, Keras etc.)

Below commands have been verified on Ubuntu 20.04 LTS. Run the same in the exact order on terminal.

    cd /opt/intel/$openVinoVersion/deployment_tools/tools/model_downloader    

    python3 -mpip install --user -r ./requirements.in

    ./downloader.py --output_dir /home/$USER/DEV/Openvino/Models/ --precisions FP16-INT8 --name face-detection-adas-0001; \
    ./downloader.py --output_dir /home/$USER/DEV/Openvino/Models/ --precisions FP16-INT8 --name age-gender-recognition-retail-0013; \
    ./downloader.py --output_dir /home/$USER/DEV/Openvino/Models/ --precisions FP16-INT8 --name head-pose-estimation-adas-0001; \
    ./downloader.py --output_dir /home/$USER/DEV/Openvino/Models/ --precisions FP16-INT8 --name emotions-recognition-retail-0003; \
    ./downloader.py --output_dir /home/$USER/DEV/Openvino/Models/ --precisions FP16-INT8 --name facial-landmarks-35-adas-0002;


## 5. Clone, Build and Run the Emotion Detection Demo

Build commands for OpenVINO Samples [reference](https://docs.openvinotoolkit.org/2021.2/openvino_docs_IE_DG_Samples_Overview.html#build_samples_linux)

Below commands have been verified on Ubuntu 20.04 LTS. Run the same in the exact order on terminal.

    cd /home/$USER/DEV/Openvino

    git clone https://github.com/avarghesein/-NIX.git

    cd "./-NIX/Lubuntu 20.04/DEV/DetectEmotionOpenVINO"

    cd build
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make

    cd intel64/Release
    modelPath="/home/$USER/DEV/Openvino/Models/intel"

    ./interactive_face_detection_demo -i ../../image.jpg \
    -m $modelPath/face-detection-adas-0001/FP16-INT8/face-detection-adas-0001.xml \
    -m_ag $modelPath/age-gender-recognition-retail-0013/FP16-INT8/age-gender-recognition-retail-0013.xml \
    -m_hp $modelPath/head-pose-estimation-adas-0001/FP16-INT8/head-pose-estimation-adas-0001.xml \
    -m_em $modelPath/emotions-recognition-retail-0003/FP16-INT8/emotions-recognition-retail-0003.xml \
    -m_lm $modelPath/facial-landmarks-35-adas-0002/FP16-INT8/facial-landmarks-35-adas-0002.xml
  
 
 NOTE: The code is an edited version of [OpenVINO Demo code](https://docs.openvinotoolkit.org/2018_R5/_samples_interactive_face_detection_demo_README.html)
