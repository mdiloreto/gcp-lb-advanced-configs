defaultService: projects/$PROJECT_ID/regions/$REGION/backendServices/$backend
name: path-matcher-1
pathRules:
- paths:
  - /$dest_path/
  service: projects/$PROJECT_ID/regions/$REGION/backendServices/$backend
- paths:
  - $source_path
  urlRedirect:
    pathRedirect: /$dest_path/
    httpsRedirect: true
    stripQuery: true
