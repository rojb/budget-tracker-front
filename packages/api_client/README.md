# api_client

Dio client for the Budget Tracker API. **Generated** from `openapi.yaml` (repo
`budget-tracker-specs`) with OpenAPI Generator (`dart-dio`, built_value serialization). Never edit
`lib/` by hand: change the contract or the generator options and regenerate.

Regenerate from the front repo root (Java and the sibling `2do` checkout are required; the
generator version is pinned in `openapitools.json`):

```bash
npx @openapitools/openapi-generator-cli generate
# equivalent to:
# npx @openapitools/openapi-generator-cli generate -g dart-dio -i ../2do/openapi.yaml -o packages/api_client
cd packages/api_client && dart pub get && dart run build_runner build --delete-conflicting-outputs
```

`.openapi-generator-ignore` keeps `test/`, `doc/`, `pubspec.yaml` and this README out of the
generator output (the repo has no test files). The generated `*.g.dart` files are committed so the
app builds without running `build_runner`.
