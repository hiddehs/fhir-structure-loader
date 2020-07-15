# fhir-structure-loader
Adminstration endpoint FHIR StructureDefintion `shellscript` loader from Simplifier packages.

## Requirements

- `curl` installed (Mac OSX: `brew install curl`)
- `jq` [installed](https://stedolan.github.io/jq/download/) (Mac OSX: `brew install jq`)

## Getting started

```bash
# clone repo & make structureloader executable
git clone https://github.com/hiddehs/fhir-structure-loader.git
cd fhir-structure-loader && chmod +x structureloader.sh
```

Download your Resources JSON zip from Simplifier and unpack it into the package directory.

## Usage
```bash
./structureloader.sh --url={administration_endpoint_url}
```

## Arguments

| Argument | Value |
| :------- | :---- |
| `--url -u`   | `/Administration` endpoint url (default: `http://localhost:8080/Administration`) |
| `--package -p`    | package directory that contains subdirectory with Simplifier Package extracted (default: `package`) |
