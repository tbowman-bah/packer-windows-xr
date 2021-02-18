[![pipeline status](https://gitlab.com/rstuff/vms/packer-windows-r/badges/master/pipeline.svg)](https://gitlab.com/rstuff/vms/packer-windows-r/-/commits/master)

# Packer Windows (templates) and R environment

Packer templates for Windows OS VMs creation as Vagrant Boxes.  
Include R, Rtools,shh server, MiKTeX, Pandoc, GitLabRunner.   

> Currently only virtualbox and Windows10 are available

## Requirements

* [Packer](https://www.packer.io/downloads)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (>= 6.1.14)
* [Packer](https://www.packer.io/)
* [ansible](https://www.ansible.com/) (>= 2.9)
* [Vagrant](https://www.vagrantup.com/) (optional)

### Files

* [answer\_file/](answer\_file/) : auto unattented install files
* [main\_template.json](main\_template.json) : packer template
* [scripts/](scripts/): configuration scripts
* [playbook.yml](playbook.yml): ansible playbook
* [roles/](roles/): ansible roles
* [Vagrantfile](Vagrantfile): for provision debug

### Variables

* [windows10.json](windows10.json) : variable for windows10 
* [windows10ENTERPRISE.json](windows10.json) : variable for windows10 Enterprise Evaluation 

## Build Vagrant Boxes

> edit [build.sh](build.sh)

Build a VM VirtualBox with Windows 10 and R environment.  

```
packer build --only=virtual-iso --var-file=windows10.json main_template.json
```

## License

[MIT](LICENSE)

## Authors

* [Jean-François Rey](https://gitlab.com/_jfrey_)

## Contributions

All contributions are welcome.

## Acknowledgments

Thanks to [StefanScherer](https://github.com/StefanScherer/packer-windows) for his work by providing the code on which some of this repository is based.
