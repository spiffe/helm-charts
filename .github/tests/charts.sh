REPOS=$(jq -r '.[] | "export " + ("HELM_REPO_" + .name | ascii_upcase | gsub("-";"_")) + "=" + .repo' .github/tests/charts.json  | tr '-' '_')
VERSIONS=$(jq -r '.[] | "export " + ("VERSION_" + .name | ascii_upcase | gsub("-";"_")) + "=" + .version' .github/tests/charts.json  | tr '-' '_')
eval "$REPOS"
eval "$VERSIONS"
