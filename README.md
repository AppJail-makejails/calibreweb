# Calibre (web)

Calibre-Web is a web app that offers a clean and intuitive interface for browsing, reading, and downloading eBooks using a valid Calibre database.

github.com/janeczku/calibre-web

<img src="https://i.ibb.co/nsDkhqY/calibre-web.png" width="30%" height="auto">

## How to use this Makejail

### Standalone

```sh
appjail makejail \
    -j calibreweb \
    -f gh+AppJail-makejails/calibreweb \
    -o virtualnet=":<random> default" \
    -o nat \
    -o expose=8083
```

### Deploy using appjail-director

**appjail-director.yml**:

```yaml
options:
  - virtualnet: ':<random> default'
  - nat:

services:
  calibreweb:
    name: calibreweb
    makejail: gh+AppJail-makejails/calibreweb
    options:
      - expose: 8083
    volumes:
      - conf: calibreweb-conf
      - library: /library

default_volume_type: '<volumefs>'

volumes:
  conf:
    device: .volumes/cw-conf
  library:
    device: .volumes/cw-library
    type: nullfs
    owner: 1001
    group: 1001
```

**.env**:

```
DIRECTOR_PROJECT=calibreweb
```

### Arguments (stage: build)

* `calibreweb_tag` (default: `13.4`): See [#tags](#tags).
* `calibreweb_download_metadata` (default: `1`): If set to `1`, the [metadata.db](https://github.com/janeczku/calibre-web/raw/master/library/metadata.db) database will be downloaded to the `/library` directory.
* `calibreweb_admin_pass` (optional): Change the administrator password.

### Check current status

The custom stage `calibre_status` can be used to run `top(1)` to check the status of MeTube.

```sh
appjail run -s calibre_status calibreweb
```

### Log

To view the log generated by the web application, run the custom stage `calibre_log`.

```sh
appjail run -s calibre_log calibreweb
```

### Volumes

| Name            | Owner | Group | Perm | Type | Mountpoint  |
| --------------- | ----- | ----- | ---- | ---- | ----------- |
| calibreweb-conf | 1001  | 1001  |  -   |  -   | /conf       |

## Tags

| Tag    | Arch    | Version        | Type   | `calibreweb_version` |
| ------ | ------- | -------------- | ------ | -------------------- |
| `13.4` | `amd64` | `13.4-RELEASE` | `thin` | `0.6.23`             |
| `14.2` | `amd64` | `14.2-RELEASE` | `thin` | `0.6.23`             |

## Notes

* The environment variable `OAUTHLIB_RELAX_TOKEN_SCOPE` is set to `1` by default in stage `start`. See [janeczku/calibre-web/issues/1472](https://github.com/janeczku/calibre-web/issues/1472).
