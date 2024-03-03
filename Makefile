.PHONY: venv install-deps run

# Define the name of your virtual environment
VENV_NAME := venv

# Define the path to the Python interpreter inside the virtual environment
VENV_PYTHON := $(VENV_NAME)/bin/python

# Define the command to activate the virtual environment
ACTIVATE_VENV := . $(VENV_NAME)/bin/activate

# Define the command to install dependencies
INSTALL_DEPS := $(VENV_PYTHON) -m pip install -r requirements.txt

# Target to create the virtual environment
venv:
	python3 -m venv $(VENV_NAME)

# Target to upgrade pip
upgrade-pip:
	$(ACTIVATE_VENV) && pip install --upgrade pip

# Target to install dependencies into the virtual environment
install-deps: venv upgrade-pip
	$(ACTIVATE_VENV) && $(INSTALL_DEPS)

# Target to install browsers for Playwright
install-browsers:
	$(ACTIVATE_VENV) && playwright install

# Target to run the Playwright script
run: install-deps install-browsers
	$(ACTIVATE_VENV) && $(VENV_PYTHON) test-userale-plugin.py