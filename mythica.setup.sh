#Install pre-requisites
sudo apt-update
sudo apt install wget git python3 python3-venv libgl1 libglib2.0-0
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt install git-lfs
git lfs install

#create user and setup chroot 
sudo apt update
sudo apt install debootstrap schroot
sudo adduser --disabled-password --gecos "" stablediffuser

sudo mkdir /var/local/stablediff
sudo chown stablediff:stablediff /var/local/stablediff

sudo su - stablediff
cd /var/local/stablediff


#Clone required repos
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
git clone https://github.com/Mikubill/sd-webui-controlnet.git stable-diffusion-webui/extensions/sd-webui-controlnet
git clone https://huggingface.co/lllyasviel/ControlNet-v1-1
git clone https://huggingface.co/lllyasviel/sd_control_collection

#Move models into the requisite directories
mv ControlNet-v1-1/*.pth stable-diffusion-webui/extensions/sd-webui-controlnet/models
mv ControlNet-v1-1/*.yaml stable-diffusion-webui/extensions/sd-webui-controlnet/models
mv sd_control_collection/*.safetensors stable-diffusion-webui/extensions/sd-webui-controlnet/models

#Run the service
cd stable-diffusion-webui/
./webui.sh --share=True