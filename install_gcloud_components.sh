#!/bin/bash

# Default components to install
DEFAULT_COMPONENTS=(
  "google-cloud-cli"
  "google-cloud-cli-anthos-auth"
  "google-cloud-cli-app-engine-go"
  "google-cloud-cli-app-engine-grpc"
  "google-cloud-cli-app-engine-java"
  "google-cloud-cli-app-engine-python"
  "google-cloud-cli-app-engine-python-extras"
  "google-cloud-cli-bigtable-emulator"
  "google-cloud-cli-cbt"
  "google-cloud-cli-cloud-build-local"
  "google-cloud-cli-cloud-run-proxy"
  "google-cloud-cli-config-connector"
  "google-cloud-cli-datastore-emulator"
  "google-cloud-cli-firestore-emulator"
  "google-cloud-cli-gke-gcloud-auth-plugin"
  "google-cloud-cli-kpt"
  "google-cloud-cli-kubectl-oidc"
  "google-cloud-cli-local-extract"
  "google-cloud-cli-minikube"
  "google-cloud-cli-nomos"
  "google-cloud-cli-pubsub-emulator"
  "google-cloud-cli-skaffold"
  "google-cloud-cli-spanner-emulator"
  "google-cloud-cli-terraform-validator"
  "google-cloud-cli-tests"
  "kubectl"
)

# Function to display usage instructions
usage() {
    echo "Usage: $0 [-c <component1,component2,...>] [-a]"
    echo "  -c  "
    echo "  -a  Install all components (default)."
    exit 1
}

# Function to display help message
usage() {
    echo "Usage: ./install_gcloud_components.sh [OPTIONS]"
    echo
    echo "This script installs Google Cloud SDK on Linux, Debian/Ubuntu, Red Hat/Fedora/CentOS, macOS, or Windows."
    echo
    echo "Options:"
    echo "  -c, --components    List of components to install, separated by commas.."
    echo "  -a, --all           Install all components (default)."
    echo
    echo "Examples:"
    echo "  ./install_gcloud_components.sh -c google-cloud-cli,kubectl,google-cloud-cli-app-engine-java"
    echo "  ./install_gcloud_components.sh -a"
    echo
}


# Parse command-line options
COMPONENTS=()
INSTALL_ALL=false

while getopts ":c:a" opt; do
  case $opt in
    c)
      IFS=',' read -r -a COMPONENTS <<< "$OPTARG"
      ;;
    a)
      INSTALL_ALL=true
      ;;
    *)
      usage
      ;;
  esac
done

# If no components provided, use default
if [ ${#COMPONENTS[@]} -eq 0 ]; then
  INSTALL_ALL=true
fi

# Install components function
install_components() {
    if [ "$INSTALL_ALL" = true ]; then
        echo "Installing all default components..."
        COMPONENTS=("${DEFAULT_COMPONENTS[@]}")
    fi

    # Check platform and install components
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/debian_version ]; then
            echo "Detected Debian/Ubuntu."
            for component in "${COMPONENTS[@]}"; do
                sudo apt-get install -y "$component"
            done
        elif [ -f /etc/redhat-release ]; then
            echo "Detected Red Hat/Fedora/CentOS."
            for component in "${COMPONENTS[@]}"; do
                sudo dnf install -y "$component"
            done
        else
            echo "Detected Linux."
            for component in "${COMPONENTS[@]}"; do
                ./google-cloud-sdk/bin/gcloud components install "$component" --quiet
            done
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Detected macOS."
        for component in "${COMPONENTS[@]}"; do
            ./google-cloud-sdk/bin/gcloud components install "$component" --quiet
        done
    else
        echo "Unsupported platform: $OSTYPE"
        exit 1
    fi

    echo "Google Cloud CLI components installation completed."
}

# Run the installation
install_components