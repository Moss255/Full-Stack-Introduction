uvicorn app.main:app --reload

Remember to setup a virtual environment

https://fastapi.tiangolo.com/virtual-environments/#run-your-program

# First Setup (Linux)
python -m venv .venv

source .venv/bin/activate

which python

python -m pip install --upgrade pip

echo "*" > .venv/.gitignore

pip install -r requirements.txt

# First time setup (Windows)

python -m venv .venv

.venv\Scripts\Activate.ps1

Get-Command python

python -m pip install --upgrade pip

echo "*" > .venv/.gitignore

pip install -r requirements.txt

## Running the app

uvicorn app.main:app --reload