# Routinator module for Puppet.

## INSTALLING OR UPGRADING

This module manages Routinator configuration.

### Requirements

* Puppet 7.19.0 or later.

### Install and bootstrap an Routinator instance

```puppet
---
classes:
  - routinator
```

### RTR bind configuration

```puppet
routinator::rtr_bind: '0.0.0.0'
```

### RTR port configuration

```puppet
routinator::rtr_port: 3323
```

### HTTP bind configuration

```puppet
routinator::http_bind: '0.0.0.0'
```

### HTTP port configuration

```puppet
routinator::http_port: 8323
```
