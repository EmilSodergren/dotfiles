#!/usr/bin/python3

import tempfile
from datetime import datetime
from pathlib import Path
import time
import requests

TOKEN_PATH = Path.home() / '.local/share/token/github.token'
EXPIRY_SOON_DAYS = 7


def check_api_token_expiry():
    if not TOKEN_PATH.exists():
        print(f'No token found at {TOKEN_PATH}, can not check expiry')
        return
    token = TOKEN_PATH.read_text().strip()
    response = requests.get('https://api.github.com/user', headers={'Authorization': f'token {token}'}, timeout=10)
    expiration_header = response.headers.get('GitHub-Authentication-Token-Expiration')
    expiry_days = (datetime.strptime(expiration_header, r'%Y-%m-%d %H:%M:%S %z').replace(tzinfo=None) -
                   datetime.now()).days if expiration_header else None
    if not expiry_days:
        print('Token will never expire')
        return
    if expiry_days <= 0:
        print('TOKEN HAS EXPIRED')
        return
    if expiry_days < EXPIRY_SOON_DAYS:
        print('TOKEN will expire soon...')
        print('Fix here -> https://github.com/settings/personal-access-tokens')
        time.sleep(10)
    print(f"Token expires in {expiry_days} days")


class GithubDownloader:

    def __init__(self, url, file_identifier, quiet=False):
        # pylint: disable=consider-using-with
        self.__temp_dir = tempfile.TemporaryDirectory(ignore_cleanup_errors=True, delete=False)
        self.url = 'https://api.github.com/repos/' + url + '/releases/latest'
        self.file_identifier = file_identifier
        self.quiet = quiet

    def __enter__(self):
        headers = None
        if not TOKEN_PATH.exists():
            print(f'If things fail here... place a token in {TOKEN_PATH}')
        else:
            token = TOKEN_PATH.read_text().strip()
            headers = {"Authorization": f"Bearer {token}"}
        r = requests.get(url=self.url, headers=headers, timeout=10)
        if not r.ok:
            print(r.json()['message'])
            return None
        file_path = ''
        for asset in r.json().get('assets'):
            if asset.get('browser_download_url').endswith(self.file_identifier):
                file_path = Path(self.__temp_dir.name) / asset.get('name')
                r2 = requests.get(asset.get('browser_download_url'), headers=headers, timeout=30)
                if not self.quiet:
                    print(f'Downloading {asset.get("name")}')
                with open(file_path, 'wb') as temp_file:
                    for chunk in r2.iter_content(chunk_size=10240):
                        temp_file.write(chunk)
        return file_path

    def __exit__(self, exc_type, exc_value, traceback):
        self.__temp_dir.cleanup()


# For testing
if __name__ == '__main__':
    with GithubDownloader(url='https://api.github.com/repos/LuaLS/lua-language-server/releases/latest',
                          file_identifier='linux-x64.tar.gz') as d:
        print(d)
