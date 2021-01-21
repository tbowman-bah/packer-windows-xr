#!/bin/bash -eux


OS="windows"
VERSION="10"
HEADLESS=true
ISO="19041.264.200511-0456.vb_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_fr-fr.iso"
CHECKSUM="2965FD214FE77D3C80BADCF0B907399DA6636675422C64AE3C0D5DABB2B90C66"

VM_NAME="${OS}${VERSION}"

packer build \
  -only=virtualbox-iso \
  -force \
  -var "vm_name=${VM_NAME}" \
  -var "headless=${HEADLESS}" \
	-var "iso_url=${ISO}" \
	-var "iso_checksum=${CHECKSUM}" \
	-var "autounattend=./answer_file/autounattend.xml" \
  -var-file="windows10ENTERPRISE.json" \
  main_template.json 


