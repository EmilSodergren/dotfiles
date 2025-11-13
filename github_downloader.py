#!/usr/bin/python3

import tempfile
from pathlib import Path
import requests


class GithubDownloader:

    def __init__(self, url, file_identifier, quiet=False):
        # pylint: disable=consider-using-with
        self.__temp_dir = tempfile.TemporaryDirectory(ignore_cleanup_errors=True, delete=False)
        self.url = url
        self.file_identifier = file_identifier
        self.quiet = quiet

    def __enter__(self):
        token_path = Path.home() / '.local/share/token/github.token'
        headers = None
        if not token_path.exists():
            print(f'If things fail here... place a token in {token_path}')
        else:
            token = token_path.read_text().strip()
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
