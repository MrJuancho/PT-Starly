import { DataSource } from "typeorm";

export const BDMSSQL = new DataSource({
    type: "mssql",
    host: "localhost",
    port: 1433,
    username: "Admin",
    password: "Haru&Wero14",
    database: "AV_Development",
    entities: [],
    synchronize: true,
    extra:{
    trustServerCertificate: true, 
    options: {
      trustedConnection: true,
      enableArithAbort: true
    }
  }
})

export default BDMSSQL