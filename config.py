import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    DEBUG = False
    TESTING = True
    CSRF_ENABLED = True
    #Database URL
    SQLALCHEMY_DATABASE_URI = 'sqlite:///database.db'
    #SQLALCHEMY_DATABASE_URI = 'mysql://root:mypass@192.168.33.10:3306/demo_01'


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = 'sqlite:///database.db'
