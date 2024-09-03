# Google Cloud SDK Cross-Platform Installation Scripts

## Description

This script installs the Google Cloud SDK and its components on multiple operating systems, including Linux, macOS, Windows, Debian/Ubuntu, and Red Hat/Fedora/CentOS. It automatically detects your OS and applies the relevant installation method.

## Supported Operating Systems

-   Linux (64-bit, ARM, and 32-bit)
-   Debian/Ubuntu
-   Red Hat/Fedora/CentOS
-   macOS (Intel and Apple Silicon)
-   Windows

## Prerequisites

-   Python 3.8 to 3.12 (Linux, macOS)
-   Admin/root access to run `sudo` commands (Linux, macOS)
-   Internet connection

## Usage

To run the script, navigate to the directory where the script is located and run:

```bash
./install_gcloud.sh --install
```

### Options

    - `-h, --help`: Show help message and usage instructions.
    - `-i, --install`: Install the Google Cloud SDK and all specified components.
    - `-v, --version`: Show the installed Google Cloud SDK version.

### Installation Instructions per OS

#### Linux

1. The script automatically detects your architecture and downloads the appropriate package.
2. Extracts the archive and installs the SDK.
3. Initializes the Google Cloud SDK.

#### Debian/Ubuntu

1. Uses apt to install the Google Cloud SDK.
2. Initializes the Google Cloud SDK.

#### Red Hat/Fedora/CentOS

1. Uses dnf or yum to install the SDK.
2. Initializes the Google Cloud SDK.

#### macOS

1. Detects the hardware (Intel or Apple Silicon) and downloads the corresponding package.
2. Installs and initializes the Google Cloud SDK.

#### Windows

1. The script provides a PowerShell command to download and run the installer.
2. Follow the on-screen instructions to complete the installation.

## Google Cloud SDK Components

### Optional Components Supported

-   google-cloud-cli-anthos-auth
-   google-cloud-cli-app-engine-go
-   google-cloud-cli-app-engine-grpc
-   google-cloud-cli-app-engine-java
-   google-cloud-cli-app-engine-python
-   google-cloud-cli-app-engine-python-extras
-   google-cloud-cli-bigtable-emulator
-   google-cloud-cli-cbt
-   google-cloud-cli-cloud-build-local
-   google-cloud-cli-cloud-run-proxy
-   google-cloud-cli-config-connector
-   google-cloud-cli-datastore-emulator
-   google-cloud-cli-firestore-emulator
-   google-cloud-cli-gke-gcloud-auth-plugin
-   google-cloud-cli-kpt
-   google-cloud-cli-kubectl-oidc
-   google-cloud-cli-local-extract
-   google-cloud-cli-minikube
-   google-cloud-cli-nomos
-   google-cloud-cli-pubsub-emulator
-   google-cloud-cli-skaffold
-   google-cloud-cli-spanner-emulator
-   google-cloud-cli-terraform-validator
-   google-cloud-cli-tests
-   kubectl

## Optional Components Installation

Optional components (such as kubectl or App Engine extensions) can be installed using either the gcloud the component manager directly or via the helper script available this repo(install_gcloud_components.sh)

### Direct Approach

-   **Initialization:**

```bash
gcloud init
```

-   **Installation:**

```bash
gcloud components install [COMPONENT_NAME]
```

### Via The Helper Scipt

-   **Install all default components:**

```bash
./install_gcloud_components.sh -a
```

-   **Install specific components:**

```bash
./install_gcloud_components.sh -c "google-cloud-cli,kubectl,google-cloud-cli-app-engine-java"
```

### Options: install_gcloud_components.sh

    - `-c, --components`: list of components to install (comma-separated).
    - `-a ,--all`: (default) install all supported component.

## Additional Notes

-   **Cross-platform support**: The script automatically detects the user's operating system and proceeds with the appropriate installation method.
-   **Linux variations**: Specific handling for different architectures (64-bit, ARM, and 32-bit).
-   **Windows**: Instructions for Windows users to use PowerShell to install the SDK.

For more information, visit the [official Google Cloud SDK documentation](https://cloud.google.com/sdk?hl=en).
