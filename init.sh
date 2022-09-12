#!/usr/bin/env bash

set -ex
set -o pipefail

# Get current running script dir
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "${SCRIPT_DIR}"

# Setup clickhouse infomation
cp clickhouse_credentials.yml ansible/roles/docker-compose/vars

##
curl -sfL https://direnv.net/install.sh | bash
eval "$(direnv hook bash)"

# Check OSTYPE
_os_id=$(awk '/^ID=/' /etc/os-release| awk -F"=" '{print $2}'|awk '{gsub("\"",""); print}')

case "${_os_id,,}" in
  centos|redhat)
    echo "Install requisition packages RedHat|CentOS"
    yum update -y
    yum install -y make cmake python3-pip python3
    # pip3 install ansible
    pip install -r ansible/requirements.txt
    
    echo "Install dependency packages"
    cd "${SCRIPT_DIR}"/ansible && direnv allow && eval "$(direnv export bash)"
    which ansible
    make bootstrap-rpm
    make run playbook=common
    make run playbook=docker-ce
    
    echo "Start services"
    make run playbook=docker-compose
  ;;
  amzn)
    echo "Install requisition packages RedHat|CentOS"
    yum update -y
    yum install -y make cmake amazon-linux-extras python-pip python3-pip python3
    # Get python version
    # _py_version=$(python --version |awk '{print $2}'|awk -F. '{print $1}')
    # if [[ ${_py_version} -lt 3 ]]; then
    #   amazon-linux-extras enable python3.8
    #   yum install -y python38 python38-pip
    #   update-alternatives --install /usr/bin/python python /usr/bin/python38 1
    #   update-alternatives --install /usr/bin/pip pip /usr/bin/pip3.8 1
    #   update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.8 1
    # fi
    pip install -r ansible/requirements.txt
    echo "Install dependency packages"
    cd "${SCRIPT_DIR}"/ansible && direnv allow && eval "$(direnv export bash)"
    make bootstrap-amz
    make run playbook=common
    make run playbook=docker-ce
    
    echo "Start services"
    make run playbook=docker-compose
  ;;
  debian|ubuntu)
    echo "Install requisition packages Debian|Ubuntu"
    apt update -y
    apt install -y make cmake python3-pip python3 python3-venv python-is-python3
    # pip install ansible
    pip install -r ansible/requirements.txt
    
    echo "Install dependency packages"
    cd "${SCRIPT_DIR}"/ansible && direnv allow && eval "$(direnv export bash)"
    which ansible
    make bootstrap-deb
    make run playbook=common
    make run playbook=docker-ce
    
    echo "Start services"
    make run playbook=docker-compose
  ;;
  *)
    echo "OS is not supported yet!!"
    exit 1
  ;;
esac
