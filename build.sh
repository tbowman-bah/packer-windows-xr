#!/bin/bash -eux


OS="windows"
VERSION="10"
HEADLESS=false
ISO="19042.631.201119-0144.20h2_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
CHECKSUM="32C7B0A51A48CC4F67C250BE4FE2B384FEBB9CC864C5B77A052D4E2845394EAC"

VM_NAME="${OS}${VERSION}"

packer build \
  -only=virtualbox-iso \
  -force \
  -var "vm_name=${VM_NAME}" \
  -var "headless=${HEADLESS}" \
	-var "iso_url=${ISO}" \
	-var "iso_checksum=${CHECKSUM}" \
	-var "autounattend=./answer_file/win10Enterprise/autounattend.xml" \
  -var-file="windows10ENTERPRISE.json" \
  main_template.json 


