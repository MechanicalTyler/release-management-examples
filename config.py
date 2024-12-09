import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY')
    SQLALCHEMY_DATABASE_URI = f"postgresql://{os.getenv('POSTGRES_USER')}:{os.getenv('POSTGRES_PASSWORD')}@{os.getenv('POSTGRES_HOST')}/{os.getenv('POSTGRES_DB')}"
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # POSTGRES_HOST = os.environ.get("POSTGRES_HOST")
    # POSTGRES_USER = os.environ.get("POSTGRES_USER")
    # POSTGRES_PASSWORD = os.environ.get("POSTGRES_PASSWORD")
    # POSTGRES_DB = os.environ.get("POSTGRES_DB")

    # ENVIRONMENT = os.environ.get("ENVIRONMENT")

    SERVER_PORT = os.environ.get("SERVER_PORT")
    SECRET_KEY = os.environ.get("FLASK_APP_SECRET_KEY")
