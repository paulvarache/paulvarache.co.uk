const https = require('https');
const fs = require('fs');

https.get('https://storage.googleapis.com/pv-binaries/terraform-provider-gandi/0.11/win32/terraform-provider-gandi.exe', (res) => {
    res.pipe(fs.createWriteStream('terraform/terraform-provider-gandi.exe'));
});
