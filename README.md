# dns-certbot

----

# STILL IN ALPHA

If you track `kyleondy/dns-certbot:latest` the earth may crumble from below you.
I make no guarantees at this point about any stability.
Once I settle on something I will push a stable version to `kyleondy/dns-certbot:v1`

----

`dns-certbot` is a sidekick docker image to make creation of [LetsEncrypt](https://letsencrypt.org/) certifications as easy as possible using [dehydrated](https://github.com/lukas2511/dehydrated) to interact with LetsEncrypt and [lexicon](https://github.com/AnalogJ/lexicon) to update DNS.


## Notes

I recommend using the config file to set your email address. That way you can stay informed.
The config file also lets you set the testing serer so you don't use all your LetsEncrypt API calls.


`CONTACT_EMAIL=`: set to your email address

`CA="https://acme-staging.api.letsencrypt.org/directory`: use this CA for testing


## To make it work

As I use [Route53](https://aws.amazon.com/route53/) to manage my DNS that is all this image is currently tested with, however by using Lexicon, additional DNS providers should be able to be added with no or minimal configuration. Pull requests are very welcome.

### Minimal Config

To get this image running you need to define at *LEAST* the following environmental variables. Using `docker-compose.yml` is easiest.

`PROVIDER=route53`: I use Route53. Other possible values can be found [here](https://github.com/AnalogJ/lexicon/tree/master/lexicon/providers).

`LEXICON_ROUTE53_ACCESS_KEY=AAAAAAAAAAAAAAAAAAAA`

`AEXICON_ROUTE53_ACCESS_SECRET=BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB`

`CERTBOT_DOMAIN`: what domain are we making certs for?

### Optional config

`CERTBOT_OUTPUT` - where the certs are output. Defaults to `/certs`. Should probably be a volume mount somewhere

`CERTBOT_INTERVAL`: The interval certbot will sleep between attempting to renew certs. use standard Linux sleep amounts. (s)econds, (m)inutes, (h)ours, (d)ays. Default to 1day
