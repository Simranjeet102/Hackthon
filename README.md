# DevSecOps Hackathon (.NET) – Shift‑Left Security Sprint

Welcome to the .NET edition of the 60‑minute DevSecOps challenge.

## Your Objectives

1. **Fork** this repo.
2. Identify and remove **hard‑coded secrets** in code, configs, Git history.
3. Integrate secret scanning (e.g., Gitleaks) in GitHub Actions.
4. Upgrade **outdated NuGet packages** and the Docker base image to eliminate critical/high CVEs.
5. Add container/dep scanning (Trivy, Grype, Dependabot, etc.) to the pipeline.
6. Document fixes in `SECURITY_FIXES.md`.
7. Open a pull request – CI must pass.

### Seeded Problems

* Hard-coded database password in `Program.cs`.
* `appsettings.json` stores an API key in plain text.
* Uses **.NET 5** (EOL) and an outdated `Newtonsoft.Json` package.
* Dockerfile built from `mcr.microsoft.com/dotnet/aspnet:5.0-alpine` (known CVEs).
* CI workflow lacks any security scanning.

Happy hacking!
