
from farnsworth.house_settings import SHORT_HOUSE_NAME, POSTGRES_PASSWORD

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': SHORT_HOUSE_NAME.lower(),
        'USER': SHORT_HOUSE_NAME.lower() + '_admin',
        'PASSWORD': POSTGRES_PASSWORD,
        'HOST': 'db',
        'PORT': '',
    },
}

HAYSTACK_CONNECTIONS = {
    'default': {
        'ENGINE': 'haystack.backends.elasticsearch_backend.ElasticsearchSearchEngine',
        'URL': 'http://elasticsearch:9200/',
        'INDEX_NAME': SHORT_HOUSE_NAME.lower(),
    },
}

BASE_URL = ""
MEDIA_URL = BASE_URL + '/media/'
STATIC_URL = BASE_URL + '/static/'

LOGIN_URL = BASE_URL + "/login/"
LOGOUT_URL = BASE_URL + "/logout/"
LOGIN_REDIRECT_URL = BASE_URL
LOGIN_ERROR_URL = BASE_URL

DEBUG=True
