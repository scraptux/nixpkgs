{
  fetchFromGitHub,
  lib,
  postgresql,
  postgresqlBuildExtension,
}:

with {
  "13" = {
    version = "1.4";
    hash = "sha256-1cyvVEC9MQGMr7Tg6EUbsVBrMc8ahdFS3+CmDkmAq4Y=";
  };
  "14" = {
    version = "1.5";
    hash = "sha256-RRSpkWLFuif+6RCncnsb1NnjKnIIRY9KgebKkjCN5cs=";
  };
  "15" = {
    version = "1.5";
    hash = "sha256-RRSpkWLFuif+6RCncnsb1NnjKnIIRY9KgebKkjCN5cs=";
  };
  "16" = {
    version = "1.5";
    hash = "sha256-RRSpkWLFuif+6RCncnsb1NnjKnIIRY9KgebKkjCN5cs=";
  };
  "17" = {
    version = "1.5";
    hash = "sha256-RRSpkWLFuif+6RCncnsb1NnjKnIIRY9KgebKkjCN5cs=";
  };
}
."${lib.versions.major postgresql.version}"
  or (throw "pg_safeupdate: version specification for pg ${postgresql.version} missing.");

postgresqlBuildExtension rec {
  pname = "pg-safeupdate";
  inherit version;

  src = fetchFromGitHub {
    owner = "eradman";
    repo = "pg-safeupdate";
    tag = version;
    inherit hash;
  };

  meta = {
    description = "Simple extension to PostgreSQL that requires criteria for UPDATE and DELETE";
    homepage = "https://github.com/eradman/pg-safeupdate";
    changelog = "https://github.com/eradman/pg-safeupdate/raw/${src.rev}/NEWS";
    platforms = postgresql.meta.platforms;
    maintainers = with lib.maintainers; [ wolfgangwalther ];
    license = lib.licenses.postgresql;
  };
}
