#!/bin/bash 

OS="Windows10_64_EntEval"
VERSION="4.0.4"
R_VERSION="4.0.4"
HEADLESS=true
ISO="19042.631.201119-0144.20h2_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
CHECKSUM="32C7B0A51A48CC4F67C250BE4FE2B384FEBB9CC864C5B77A052D4E2845394EAC"
AUTOUNATTEND="./answer_file/win10Enterprise/autounattend.xml"


usage() { echo "Usage: $0 [-h] [-c <vagrantcloudtoken>] [-i <iso>] [-s <checksum>] [-v <windows_version>]" 1>&2; exit 1; }

#### OPTIONS ####
while getopts c:i:s:v:h flag
do
    case "${flag}" in
        c) VAGRANTCLOUD_TOKEN=${OPTARG};;
        i) ISO=${OPTARG};;
        s) CHECKSUM=${OPTARG};;
        v) WIN_VERSION=${OPTARG};;
        h) usage;;
    esac
done

#### Which windows version ####
if [[ ${WIN_VERSION} == "Pro" ]]
then
  OS="Windows10_64_Pro"
  AUTOUNATTEND="./answer_file/win10/autounattend.xml"
  TEMPLATE_FILE="windows10.json"
fi

# Default
if [[ ${WIN_VERSION} == "Enterprise" ]]
then
  OS="Windows10_64_EntEval"
  AUTOUNATTEND="./answer_file/win10Enterprise/autounattend.xml"
  TEMPLATE_FILE="windows10ENTERPRISE.json"
fi

BOX_TAG="VMR/${OS}-R"
DESCRIPTION="${OS} + R ${R_VERSION} + Rtools"
VM_NAME="${OS}-R${R_VERSION}"


packer build \
  -only=virtualbox-iso \
  -force \
  -var "vm_name=${VM_NAME}" \
  -var "headless=${HEADLESS}" \
	-var "iso_url=${ISO}" \
	-var "iso_checksum=${CHECKSUM}" \
	-var "autounattend=${AUTOUNATTEND}" \
  -var "boxtag=${BOX_TAG}" \
  -var "vagrantcloud_token=${VAGRANTCLOUD_TOKEN}" \
  -var "version=${VERSION}" \
  -var "version_description=${DESCRIPTION}" \
  -var-file=${TEMPLATE_FILE} \
  main_template.json 


