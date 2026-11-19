import pathlib, re, subprocess, json
text = pathlib.Path('Dockerfile').read_text()
users = re.findall(r'^\s*USER\s+(\S+)', text, re.M | re.I)
if not users or users[-1].split(':')[0].lower() in ('root', '0'):
    raise SystemExit('SECURITY GATE: Dockerfile must use a non-root user')
config = json.loads(subprocess.check_output(['docker','compose','config','--format','json']))
for name, svc in config['services'].items():
    if svc.get('privileged') or not svc.get('read_only') or 'ALL' not in svc.get('cap_drop', []):
        raise SystemExit(f'SECURITY GATE: insecure Compose service {name}')
    if 'no-new-privileges:true' not in svc.get('security_opt', []):
        raise SystemExit(f'SECURITY GATE: missing no-new-privileges in {name}')
    if any(p.get('host_ip') != '127.0.0.1' for p in svc.get('ports', [])):
        raise SystemExit(f'SECURITY GATE: exposed staging port in {name}')
print('Docker and Compose security policies passed')
