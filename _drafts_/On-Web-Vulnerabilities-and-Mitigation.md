---
layout: post
title:  "Top Web Vulnerabilities and Mitigations"
date:   2022-02-12 21:03:36 -0500
categories: Web Vulnerability OWASP
---

## SQL Injection (SQLi)
* Prepared Statements & Parametrize queries (Separate Data from query)
* Input Sanitization


## Cross Site Scripting (XSS)
### Stored XSS
* a Javascript Script post on my facebook page - that executes something in visitor's machine
### Reflected XSS
* Reflected attacks are more common.
* Reflected attacks do not have the same reach as stored XSS attacks.
* While visiting a forum site that requires users to log in to their account, a perpetrator executes this search query 
```HTML
  <script type=’text/javascript’>alert(‘xss’);</script>
```

It should be noted that, unlike in a stored attack, where the perpetrator’s malicious requests to a website are blocked, in a reflected XSS attack, it’s the user’s requests that are blocked. This is done to protect the user, as well as to prevent collateral damage to all other website visitors.

#### Mitigation
* WAF
* Input Sanitization

### Blind XSS
### DOM-Based XSS

## Deserialization Attack
#### Mitigation
* Integration Check to prevent tamering
* Strict Type constraint before deserialization within definite sets of classes
* Isolation and lower-privelege running
* Monitoring deserialization and restricting it

## Cross-Site Request Forgery (XSRF)

## Server-Side Request Forgery

## File Inclusion