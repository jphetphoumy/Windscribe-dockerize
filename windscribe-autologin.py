#!/usr/bin/env python3

import pexpect
import os
import subprocess

subprocess.call(['/etc/init.d/windscribe-cli', 'start'])
child = pexpect.spawn('windscribe login')
child.expect('Windscribe Username:')
child.sendline(os.getenv('VPN_USERNAME')+"\n")
child.expect('Windscribe Password: ')
child.sendline(os.getenv('VPN_PASSWORD'))
child.wait()
child = pexpect.spawn('windscribe connect best')
child.wait()
child.expect("Your IP changed from*")
print("Windscribe Connection done")
