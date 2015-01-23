
import os

from farnsworth.settings import *

DEBUG = False
TEMPLATE_DEBUG = None

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'docker',
        'USER': 'postgres',
        'PASSWORD': os.environ.get('POSTGRESQL_PASS', ''),
        'HOST': os.environ.get('DB_1_PORT_5432_TCP_ADDR'),
        'PORT': os.environ.get('DB_1_PORT_5432_TCP_PORT'),
    },
}

HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'haystack.backends.elasticsearch_backend.ElasticsearchSearchEngine',
        'URL': 'http://{0}:{1}/'.format(
            os.environ.get('ELASTICSEARCH_1_PORT_9200_TCP_ADDR'),
            os.environ.get('ELASTICSEARCH_1_PORT_9200_TCP_PORT'),
        ),
        'INDEX_NAME': 'docker',
    },
}

# Change the base URL to "/" (By default it is "/<house>")
BASE_URL = ""
MEDIA_URL = BASE_URL + '/media/'
STATIC_URL = BASE_URL + '/static/'

LOGIN_URL = BASE_URL + "/login/"
LOGOUT_URL = BASE_URL + "/logout/"
LOGIN_REDIRECT_URL = BASE_URL
LOGIN_ERROR_URL = BASE_URL
