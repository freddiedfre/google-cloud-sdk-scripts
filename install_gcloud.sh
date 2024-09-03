#!/bin/bash

# Google Cloud SDK cross-platform installation script

# Function to display help message
show_help() {
    echo "Usage: ./install_gcloud.sh [OPTIONS]"
    echo
    echo "This script installs Google Cloud SDK on Linux, Debian/Ubuntu, Red Hat/Fedora/CentOS, macOS, or Windows."
    echo
    echo "Options:"
    echo "  -h, --help       Show this help message and exit."
    echo "  -i, --install    Install Google Cloud SDK."
    echo "  -v, --version    Show Google Cloud SDK version after installation."
    echo
    echo "Examples:"
    echo "  ./install_gcloud.sh --install"
    echo "  ./install_gcloud.sh --version"
    echo
}

# Function to detect the OS
detect_os() {
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=macOS;;
        CYGWIN*|MINGW*|MSYS_NT*) machine=Windows;;
        *)          machine="UNKNOWN:${unameOut}"
    esac
    echo ${machine}
}

# Function to install Google Cloud SDK on Linux
install_gcloud_linux() {
    echo "Installing Google Cloud SDK on Linux..."
    arch=$(uname -m)
    case "${arch}" in
        x86_64)
            echo "64-bit detected."
            url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz"
            ;;
        arm*)
            echo "ARM architecture detected."
            url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-arm.tar.gz"
            ;;
        i686|i386)
            echo "32-bit detected."
            url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86.tar.gz"
            ;;
        *)
            echo "Unsupported architecture: ${arch}"
            exit 1
            ;;
    esac

    curl -O ${url}
    tar -xf google-cloud-cli-linux-*.tar.gz
    ./google-cloud-sdk/install.sh --quiet
    ./google-cloud-sdk/bin/gcloud init
}

# Function to install Google Cloud SDK on Debian/Ubuntu
install_gcloud_debian() {
    echo "Installing Google Cloud SDK on Debian/Ubuntu..."
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates gnupg curl
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt-get update && sudo apt-get install google-cloud-cli -y
    gcloud init
}

# Function to install Google Cloud SDK on Red Hat/Fedora/CentOS
install_gcloud_redhat() {
    echo "Installing Google Cloud SDK on Red Hat/Fedora/CentOS..."
    sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el9-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
    sudo dnf install google-cloud-cli -y
    gcloud init
}

# Function to install Google Cloud SDK on macOS
install_gcloud_macos() {
    echo "Installing Google Cloud SDK on macOS..."
    arch=$(uname -m)
    if [[ "${arch}" == "x86_64" ]]; then
        url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-x86_64.tar.gz"
    elif [[ "${arch}" == "arm64" ]]; then
        url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-arm.tar.gz"
    else
        echo "Unsupported architecture: ${arch}"
        exit 1
    fi

    curl -O ${url}
    tar -xf google-cloud-cli-darwin-*.tar.gz
    ./google-cloud-sdk/install.sh --quiet
    ./google-cloud-sdk/bin/gcloud init
}

# Function to show instructions for Windows
show_windows_instructions() {
    echo "The Google Cloud CLI works on Windows 8.1 and later and Windows Server 2012 and later."
    echo "1. Download the Google Cloud CLI installer."
    echo "Alternatively, open a PowerShell terminal and run the following PowerShell commands:"
    echo '   (New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/", "$env:Temp\GoogleCloudSDKInstaller.exe")'
    echo '   & $env:Temp\GoogleCloudSDKInstaller.exe'
    echo "2. Launch the installer and follow the prompts."
}

# Function to show Google Cloud SDK version
show_version() {
    gcloud --version
}

# Function to install based on OS
install_gcloud() {
    os=$(detect_os)
    case "${os}" in
        Linux)
            install_gcloud_linux
            ;;
        macOS)
            install_gcloud_macos
            ;;
        Windows)
            show_windows_instructions
            ;;
        *)
            echo "Unsupported OS: ${os}"
            exit 1
            ;;
    esac
}

# Parse command-line arguments
if [[ $# -eq 0 ]]; then
    echo "No arguments provided. Use -h or --help for usage instructions."
    exit 1
fi

while [[ $# -gt 0 ]]
do
    case "$1" in
        -h|--help)
            show_help
            exit 0
            ;;
        -i|--install)
            install_gcloud
            shift
            ;;
        -v|--version)
            show_version
            shift
            ;;
        *)
            echo "Invalid option: $1. Use -h or --help for usage instructions."
            exit 1
            ;;
    esac
done
