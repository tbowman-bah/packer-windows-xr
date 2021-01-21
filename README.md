# Packer Windows (templates)

Packer templates for Windows OS VMs creation as Vagrant Boxes.

> Currently only virtualbox and Windows10 are available

## Requirements

* [Packer](https://www.packer.io/downloads)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)


## Current templates

* [windows10.json](windows10.json) : variable for windows10 

### Files

* [answer\_file/](answer\_file/) : auto unattented install files
* [main\_template.json](main\_template.json) : packer template
* [scripts/](scripts/): configuration scripts

### Variables

* [windows10.json](windows10.json) : variable for windows10 

## Build Vagrant Boxes

Build a VM virtualbox with windows 10.  

```
packer build --only=virtual-iso --var-file=windows10.json main_template.json
```

## License

[MIT](LICENSE)

## Contributions

All contributions are welcome.

## Acknowledgments

Thanks to [StefanScherer](https://github.com/StefanScherer/packer-windows) for his work by providing the code on which some of this repository is based.
