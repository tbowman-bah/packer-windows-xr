#!/bin/bash -eux


OS="windows"
VERSION="10"
HEADLESS=true
ISO="Win10_20H2_v2_EnglishInternational_x64.iso"
CHEKSUM="BD9E41BDF9E23DCF5A0592F3BFE794584C80F1415727ED234E8929F656221836"

VM_NAME="${OS}${VERSION}"

packer build \
  -force \
  -var "vm_name=${VM_NAME}" \
  -var "headless=${HEADLESS}" \
	-var "iso_url=${ISO}" \
	-var "iso_checksum=${CHECKSUM}" \
	-var "autounattend=./answer_file/autounattend.xml" \
  packer_template.json 


