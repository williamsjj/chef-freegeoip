freegeoip Cookbook
==================
Installs the freegeoip server: [https://github.com/fiorix/freegeoip](https://github.com/fiorix/freegeoip)

Requirements
------------

Works on Ubuntu 10.04 or later. Depends on the `logrotate` cookbook version 1.0.2 or newer.

#### packages
- `logrotate` - Needed to rotate log file

Attributes
----------

#### freegeoip::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['freegeoip']['version']</tt></td>
    <td>String</td>
    <td>Version of freegeoip to install.</td>
    <td><tt>3.0.2</tt></td>
  </tr>
  <tr>
    <td><tt>['freegeoip']['download_path']</tt></td>
    <td>String</td>
    <td>Base URL to download freegeoip package. `/[version]/[package_filename]` will be appended to it.</td>
    <td><tt>https://github.com/fiorix/freegeoip/releases/download/</tt></td>
  </tr>
  <tr>
    <td><tt>['freegeoip']['install_path']</tt></td>
    <td>String</td>
    <td>Where to install freegeoip. (this path will be created if missing)</td>
    <td><tt>/opt/freegeoip</tt></td>
  </tr>
  <tr>
    <td><tt>['freegeoip']['log_path']</tt></td>
    <td>String</td>
    <td>Where to store freegeoip log files. (this path will be created if missing)</td>
    <td><tt>/var/log/freegeoip</tt></td>
  </tr>
  <tr>
    <td><tt>['freegeoip']['user']</tt></td>
    <td>String</td>
    <td>UNIX user to run freegeoip under.</td>
    <td><tt>www-data</tt></td>
  </tr>
  <tr>
    <td><tt>['freegeoip']['listen']['address']</tt></td>
    <td>String</td>
    <td>IP address freegeoip should listen on. (0.0.0.0 means listen on all interfaces)</td>
    <td><tt>0.0.0.0</tt></td>
  </tr>
  <tr>
    <td><tt>['freegeoip']['listen']['port']</tt></td>
    <td>String</td>
    <td>Portfreegeoip should listen on.</td>
    <td><tt>8080</tt></td>
  </tr>
  <tr>
    <td><tt>['freegeoip']['use_xforwardedfor']</tt></td>
    <td>Boolean</td>
    <td>Enable freegeoip to use the X-Forwarded-For header as the IP for lookup. Useful when running behind a proxy like nginx or HAProxy.</td>
    <td><tt>false</tt></td>
  </tr>
</table>

Usage
-----
#### freegeoip::default
Just include `freegeoip` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[freegeoip]"
  ]
}
```

License and Authors
-------------------

Distributed under the BSD license.

Redistribution and use in source and binary forms, with or without modification,  are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of DigiTar nor the names of its contributors may be used to endorse or promote products derived from this software without  specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Copyright
--------------------
&copy;2014 DigiTar Inc., All Rights Reserved
