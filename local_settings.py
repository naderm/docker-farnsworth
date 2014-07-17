
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

