return {
  cmd = { 'sqls' },
  filetypes = { 'sql', 'mysql' },
  root_markers = { 'config.yml' },
  settings = {
    ['sqls'] = {
      connections = {
        {
          driver = "oracle",
          proto = "tcp",
          user = "system",
          passwd = "xaolan",
          host = "127.0.0.1",
          port = 1521,
          dbName = "FREEPDB1",
          params = {
            tls = "skip-verify"
          }
        },
        {
          driver = "oracle",
          proto = "tcp",
          user = "HR",
          passwd = "xaolan",
          host = "127.0.0.1",
          port = 1521,
          dbName = "FREEPDB1",
          params = {
            tls = "skip-verify"
          }
        },
      }
    }
  }
}
