FusionDirectory Docker Container
================================

A docker image for [Fusiondirectory](http://fusiondirectory.org), a
powerful web interface for LDAP.

How to use
----------

This docker image needs an LDAP server which contains
Fusiondirectory's LDAP schemas. You can use
[mcreations/fusiondirectory-ldap](https://hub.docker.com/r/mcreations/fusiondirectory-ldap)
which keeps the persistent data in a Docker volume at `/data`.

```
docker run -d --name ldap -e LDAP_DOMAIN=example.com -e LDAP_ROOTPW=secret mcreations/fusiondirectory-ldap
```

Now you can run this container with a link to that LDAP server, named `ldap-server`:

```
docker run -d -p 12080:80 -e LDAP_DOMAIN=example.com -e LDAP_ROOTPW=secret -e LDAP_ROOTDN="cn=admin,dc=example,dc=com" --link ldap:ldap-server mcreations/fusiondirectory
```

Now open http://localhost:12080 and login as `fd-admin` using `LDAP_ROOTPW` as password.

Connection variables
--------------------

These environment variables are used to connect to the LDAP server:

* `LDAP_HOST`: URL/IP af ldap server (default: `ldap-server`)
* `LDAP_PORT`: Port on ldap server (default: `389`)
* `LDAP_SERVER_URL`: Combination of host, and port (default: `ldap://${LDAP_HOST}:${LDAP_PORT}`)
* `LDAP_DOMAIN`: LDAP domain (default: `example.com`)
* `LDAP_ROOTDN` : ROOT DN of ldap server default is: `cn=Manager,<domain suffix, e.g. dc=example,dc=com`)
* `LDAP_ROOTPW` : Password of the ROOTDN of the ldap server
* `LDAP_TLS` : Encrypt connections with the ldap server [FALSE|TRUE] (default is: `TRUE`) 
* `TLS_REQCERT` : Specifies in ldap.conf what checks to perform on server certificates in a TLS session, if any [never|allow|try|demand] (default is: never)

Web Service Access
------------------

For programmatic access to the FusionDirectory functionality, you can
use the [FusionDirectory web service](http://documentation.fusiondirectory.org/en/documentation/plugin/webservice_plugin).


Github Repo
-----------

https://github.com/m-creations/docker-fusiondirectory
