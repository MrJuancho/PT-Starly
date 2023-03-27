import { DataSource } from "typeorm";
import { CatMateria, CatActividad,
        CatActividadPpb, CatContenidoMaterias,
        CatDatoCurioso, CatDesafioDiario,
        CatEscuela, CatPropPersonalizacion,
        CatTareaDiaria, CatTipoDesbloqueo,
        CatTipoPersonalizacion, TblAlumno,
        TblAsistenteVirtual, TblAnalisisDeDatos,
        TblDesafioDiarioAlumno, TblDesbloqueosPropsAv,
        TblPpbAlumno, TblRegistroDiarioActividades,
        TblReporteAnalisisDatos, TblResultadosActividad,
        TblTareasDiariasAlumno } from "../models";

export const AV_DB = new DataSource({
    type: "mssql",
    host: "localhost",
    port: 1433,
    username: "Admin",
    password: "Haru&Wero14",
    schema : "dbo",
    database: "AV_Development",
    entities: [CatMateria, CatActividad, CatActividadPpb, CatContenidoMaterias, CatDatoCurioso, CatDesafioDiario,
              CatEscuela, CatPropPersonalizacion, CatTareaDiaria, CatTipoDesbloqueo, CatTipoPersonalizacion, TblAlumno,
              TblAsistenteVirtual, TblAnalisisDeDatos, TblDesafioDiarioAlumno, TblDesafioDiarioAlumno, TblDesbloqueosPropsAv,
              TblPpbAlumno, TblRegistroDiarioActividades, TblReporteAnalisisDatos, TblResultadosActividad, TblTareasDiariasAlumno],
    synchronize: false,
    extra:{
    trustServerCertificate: true,
    options: {
      trustedConnection: true,
      enableArithAbort: true
    }
  }
})

export default AV_DB