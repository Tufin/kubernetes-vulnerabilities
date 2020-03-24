# kubernetes-vulnerabilities

[![CircleCI](https://circleci.com/gh/Tufin/kubernetes-vulnerabilities.svg?style=svg)](https://circleci.com/gh/Tufin/kubernetes-vulnerabilities)

This git repo contains information about Kubernetes:
1. Security vulnerabilities
2. Admission controller plugins

## Vulnerabilities
Each file in the folders (vanilla, gke, eks, etc.) contain known vulnerabilities of kubernetes.  
Each file has a list of CVEs.  
Each CVE must have one of the following fields:

- FixedIn: patch numbers that fix each vulnerable minor version (higher versions are assumed fixed)
- ExistsIn: a list of vulnerable versions (ranges or versions)

FirstVulnerableVersion is the first version that exposed this vulnerability.

## Admission Controllers
This file contains a list of kubernetes admission controller plugins.  
Each plugin may have a recommendation (enable/disable) for each kubernetes platform.  