jq -r '.[] | ("HELM_REPO_" + .name | ascii_upcase | gsub("-";"_")) + "=" + .repo' .github/tests/charts.json  | tr '-' '_' | eval
jq -r '.[] | ("VERSION_" + .name | ascii_upcase | gsub("-";"_")) + "=" + .version' .github/tests/charts.json  | tr '-' '_' | eval
