
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
