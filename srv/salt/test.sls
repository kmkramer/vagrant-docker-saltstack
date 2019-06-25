{% set python_pip = 'python-pip' %}

{% if grains['os_family'] in ('Debian') %}

{% set docker_pkg_name = 'docker-ce==18.06*' %}

debian-reqs:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common
      - nfs-common

docker-repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ salt['grains.get']('oscodename') }} stable
    - keyserver: https://download.docker.com/linux/ubuntu/gpg
    - keyid: 0EBFCD88
    - refresh: True

{% elif grains['os_family'] in ('RedHat') %}

{% set docker_pkg_name = 'docker-ce-18.06.3.ce' %}
{% set python_pip = 'python2-pip' %}

redhat-reqs:
  pkg.installed:
    - pkgs:
      - lvm2
      - yum-utils
      - device-mapper-persistent-data

redhat-repo:
  pkgrepo.managed:
    - name: Docker
    - baseurl: https://download.docker.com/linux/centos/7/x86_64/stable
    - gpgkey: https://download.docker.com/linux/centos/gpg

{% endif %}

docker-host-pkgs:
  pkg.installed:
    - pkgs:
      - {{ python_pip }}
      - {{ docker_pkg_name }}

docker-host-pip:
  pip.installed:
    - pkgs:
      - setuptools
      - docker==3.7.2
    - reload_modules: true

wait-for-docker:
  service.running:
    - name: docker

test-volume-create:
  docker_volume.present:
    - name: test-volume
