#!/bin/bash

# Function to create a Python virtual environment and install dependencies
create_virtualenv() {
    apt install python3.12-venv
    # Check if Python is installed
    if ! command -v python3 &> /dev/null; then
        echo "Python3 is not installed. Please install Python3 and try again."
        exit 1
    fi

    # Check if a virtual environment already exists
    if [ -d "venv" ]; then
        echo "A virtual environment named 'venv' already exists in this directory."
        exit 1
    fi

    # Create the virtual environment
    echo "Creating Python virtual environment 'venv'..."
    python3 -m venv venv

    # Check if the virtual environment was created successfully
    if [ $? -eq 0 ]; then
        echo "Virtual environment 'venv' created successfully."
    else
        echo "Failed to create the virtual environment."
        exit 1
    fi

    # Activate the virtual environment
    echo "Activating virtual environment..."
    source venv/bin/activate

    # Check if requirements.txt exists
    if [ -f "requirements.txt" ]; then
        echo "Installing dependencies from requirements.txt..."
        pip install -r requirements.txt

        # Check if the installation was successful
        if [ $? -eq 0 ]; then
            echo "Dependencies installed successfully."
        else
            echo "Failed to install dependencies."
            exit 1
        fi
    else
        echo "No requirements.txt file found. Skipping dependency installation."
    fi

    # Deactivate the virtual environment
    deactivate
    echo "Virtual environment setup complete. To activate it, run: source venv/bin/activate"
}

# Call the function
create_virtualenv