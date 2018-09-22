# Dev SSL

Generate an SSL cert for development use.

```
docker run --rm -v "$PWD/data":/cert --env "DOMAIN=m.com" lightster/dev-ssl
```

## Options

If you want to use a different domain or name your cert files differently, the following environment variables can override the defaults:

 - `DOMAIN` defaults to `b.com`
 - `CERT_DIR` defaults to `/cert`
 - `FILE_NAME` defaults to `dev`
 - `KEY_PATH` defaults to `${CERT_DIR}/${FILE_NAME}.key`
 - `CSR_PATH` defaults to `${CERT_DIR}/${FILE_NAME}.csr`
 - `CRT_PATH` defaults to `${CERT_DIR}/${FILE_NAME}.crt`

## Trusting the cert

The cert is self-signed, so web browsers will give warnings about the cert being invalid.  If you want to bypass these notifications, on macOS you can add the cert to the system keychain using:

```
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain data/dev.crt
```
