# DevSecOps Secure API
Projeto academico: Node/Express, GitHub Actions, Gitleaks, Semgrep, Trivy, Docker Compose e OWASP ZAP.

## Antes do primeiro push
Instale Node.js e Git. Execute `npm install` para gerar package-lock.json (obrigatorio). Revise e versione o lockfile. Execute `npm start` e abra http://localhost:3000/health. Pare com Ctrl+C.

## GitHub
Crie um repositorio vazio, sem README. Execute `git init -b main`, `git add .`, `git commit -m "feat: secure API and pipeline"`, `git remote add origin URL`, `git push -u origin main`. Abra Actions. Aguarde homologacao completa antes da aula.

## Demo
Crie branch demo-security-gate. Altere USER node para USER root no Dockerfile, commit e push. Mostre a falha da etapa IaC. Corrija USER node, commit e push. Mostre os logs e artefatos SBOM e DAST. Nao use segredos reais. Nao publique a branch insegura como release.

## Escopo
Deploy temporario no runner, nao producao. ZAP baseline e passivo; testes HTTP complementam os endpoints. HSTS desativado apenas porque staging usa HTTP. Tags de ferramentas mutaveis para facilitar o laboratorio: em producao fixe versoes/digests e SHAs. Configure protecao de branch e checks obrigatorios para impedir merge. O scan de segredos cobre historico; remocao em novo commit nao elimina segredo historico. CVEs e regras podem mudar; rode a pipeline antes da apresentacao. Caso uma vulnerabilidade real apareca, atualize a dependencia/imagem e reexecute, sem desativar os gates.
