import re

from urllib.parse import urlparse

def extract_features(url):

    # Tambahkan scheme jika tidak ada
    if not url.startswith((
        'http://',
        'https://'
    )):
        url = 'http://' + url

    parsed = urlparse(url)

    # URL Length
    url_length = len(url)

    # Domain Length
    domain_length = len(parsed.netloc)

    # Path Length
    path_length = len(parsed.path)

    # Subdomain Count
    subdomain_count = max(
        parsed.netloc.count('.') - 1,
        0
    )

    # Dot Count
    dot_count = url.count('.')

    # Slash Count
    slash_count = url.count('/')

    # Dash Count
    dash_count = url.count('-')

    # Special Character Count
    special_char_count = len(
        re.findall(r'[@?=&_%]', url)
    )

    # Digit Count
    digit_count = sum(
        c.isdigit()
        for c in url
    )

    # @ Count
    at_count = url.count('@')

    # IP Detection
    has_ip = 1 if re.search(
        r'(\d{1,3}\.){3}\d{1,3}',
        parsed.netloc
    ) else 0

    return {
        'url_length': url_length,
        'domain_length': domain_length,
        'path_length': path_length,
        'subdomain_count': subdomain_count,
        'dot_count': dot_count,
        'slash_count': slash_count,
        'dash_count': dash_count,
        'special_char_count': special_char_count,
        'digit_count': digit_count,
        'at_count': at_count,
        'has_ip': has_ip
    }