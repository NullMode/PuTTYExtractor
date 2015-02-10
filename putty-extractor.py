# -*- coding: utf-8 -*-

from _winreg import *

output_formats = [
    'ssh {hostname} -p {port} {options}',
    'telnet {hostname} {port} {options}',
]

defined_options = [
    {'identifier': 'PublicKeyFile', 'option_switch': '-i'},
    {'identifier': 'RemoteCommand', 'option_switch': '-t'},
]

def set_format(protocol):
    if protocol == "ssh":
    	return 0
    if protocol == "telnet":
	return 1


# Returns an empty string if not set
def set_option(option, value):
    if value != "":
        return '{option} "{value}"'.format(option=option, value=value)
    return ""


def main():
    reg = ConnectRegistry(None, HKEY_CURRENT_USER)
    key = OpenKey(reg, r"Software\SimonTatham\Putty\Sessions")

    # Go through all the sessions (unless you have more than 1024 sessions)
    for i in range(1024):
        try:
            sub_key_name = EnumKey(key, i)
            sub_key = OpenKey(key, sub_key_name)

            protocol = QueryValueEx(sub_key, "Protocol")[0]
            hostname = QueryValueEx(sub_key, "HostName")[0]
            port     = QueryValueEx(sub_key, "PortNumber")[0]

            if (protocol == "ssh" or protocol == "telnet") and hostname != "":
                format_type = set_format(protocol)
                options = []
                for opt in defined_options:
                    options.append(set_option(opt['option_switch'],
                                              QueryValueEx(sub_key,
                                              opt['identifier'])[0]))

                print output_formats[format_type].format(hostname=hostname,
                                               port=port,
                                               options=" ".join(options))
        except EnvironmentError:
            break


if __name__ == "__main__":
    main()
