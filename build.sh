#!/bin/bash -eux

OS="Windows10_64_EntEval"
VERSION="4.0.3"
R_VERSION="4.0.3"
HEADLESS=true
ISO="19042.631.201119-0144.20h2_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
CHECKSUM="32C7B0A51A48CC4F67C250BE4FE2B384FEBB9CC864C5B77A052D4E2845394EAC"
AUTOUNATTEND="./answer_file/win10Enterprise/autounattend.xml"
BOX_TAG="VMR/${OS}-R"
DESCRIPTION="${OS} + R ${R_VERSION} + Rtools"

VM_NAME="${OS}-R${R_VERSION}"

usage() { echo "Usage: $0 [-h] [-c <vagrantcloudtoken>]" 1>&2; exit 1; }

while getopts c:h flag
do
    case "${flag}" in
        c) VAGRANTCLOUD_TOKEN=${OPTARG};;
        h) usage;;
    esac
done

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
  -var-file="windows10ENTERPRISE.json" \
  main_template.json 


