fx_version "bodacious"
game "gta5"
lua54 "yes"

author "neast | GitHub: @neasthetic"
description "Useful Database Integrity resource"
version "1.0.0"

server_scripts {
  "server-side/*.lua",
}

exports {
  'DatabaseTableExist', 
  'DatabaseIntegrity',
  'DatabaseIntegrityMultiple',
}
