# Calibre (web)

Calibre-Web is a web app that offers a clean and intuitive interface for browsing, reading, and downloading eBooks using a valid Calibre database.

github.com/janeczku/calibre-web

<img src="https://imgur.com/QeWm80K.png" width="30%" height="auto">

## How to use this Makejail

### Standalone

```sh
appjail makejail \
    -j calibreweb \
    -f gh+AppJail-makejails/calibreweb \
    -o virtualnet=":<random> default" \
    -o nat
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

### Arguments

* `calibreweb_tag` (default: `13.3`): See [#tags](#tags).
* `calibreweb_download_metadata` (default: `1`): If set to `1`, the [metadata.db](https://github.com/janeczku/calibre-web/raw/master/library/metadata.db) database will be downloaded to the `/library` directory.
* `calibreweb_admin_pass` (optional): Change the administrator password.

### Volumes

| Name            | Owner | Group | Perm | Type | Mountpoint  |
| --------------- | ----- | ----- | ---- | ---- | ----------- |
| calibreweb-conf | 1001  | 1001  |  -   |  -   | /conf       |

## Tags

| Tag    | Arch    | Version        | Type   | `calibreweb_version` |
| ------ | ------- | -------------- | ------ | -------------------- |
| `13.3` | `amd64` | `13.3-RELEASE` | `thin` | `0.6.23`             |
| `14.1` | `amd64` | `14.1-RELEASE` | `thin` | `0.6.23`             |

## Notes

* The environment variable `OAUTHLIB_RELAX_TOKEN_SCOPE` is set to `1` by default in stage `start`. See [janeczku/calibre-web/issues/1472](https://github.com/janeczku/calibre-web/issues/1472).
