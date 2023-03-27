import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TblReporteAnalisisDatos } from "./TblReporteAnalisisDatos";

@Index("PK_TBL_AnalisisDeDatos", ["idAnalisisDatos"], { unique: true })
@Entity("TBL_AnalisisDeDatos", { schema: "dbo" })
export class TblAnalisisDeDatos {
  @PrimaryGeneratedColumn({ type: "int", name: "idAnalisisDatos" })
  idAnalisisDatos!: number;

  @Column("int", { name: "idActividadPPBAlumno" })
  idActividadPpbAlumno!: number;

  @Column("datetime", { name: "FechaAnalisis" })
  fechaAnalisis!: Date;

  @OneToMany(
    () => TblReporteAnalisisDatos,
    (tblReporteAnalisisDatos) => tblReporteAnalisisDatos.idAnalisisDatos
  )
  tblReporteAnalisisDatos!: TblReporteAnalisisDatos[];
}
