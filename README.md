# docker-letsencrrypt-dns-companion
----

# Beta Status (master branch)

If you track `kyleondy/docker-letsencrypt-dns-companion:stable` the earth may crumble from below you.
I make no guarantees at this point about any stability.
Once I settle on something I will push a stable version to `kyleondy/kyleondy/docker-letsencrypt-dns-companion:v1`

-----------

`dns-certbot` is a sidekick docker image to make creation of [LetsEncrypt](https://letsencrypt.org/) certifications as easy as possible using [dehydrated](https://github.com/lukas2511/dehydrated) to interact with LetsEncrypt and [lexicon](https://github.com/AnalogJ/lexicon) to update DNS.
----
#### Config

```yaml
# docker-compose.yml
...
image: kyleondy/docker-letsencrypt-dns-companion:stable
...
enviroment:
  - PROVIDER=digitalocean
  - LEXICON_DIGITALOCEAN_TOKEN=xxxxxxxxxxx
  - CERTBOT_DOMAIN=www.example.com
  - LETSENCRYPT_EMAIL=john@doe.com
...
```

### Environmental Variables

Required: `LETSENCRYPT_EMAIL`
Optional: `LETSENCRYPT_CA`. Defaults to production server. Set to `https://acme-staging.api.letsencrypt.org/directory` for testing.
Optional: `CERTBOT_OUTPUT` - where the certs are output. Defaults to `/certs`. Should probably be a volume mount somewhere
Optional: `CERTBOT_INTERVAL`: The interval certbot will sleep between attempting to renew certs. use standard Linux sleep amounts. (s)econds, (m)inutes, (h)ours, (d)ays. Default to 1day

## To make it work

The DNS is taken care of by [lexicon](https://github.com/AnalogJ/lexicon). Visit that project to see supported DNS providers.
