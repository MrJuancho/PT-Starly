import {
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TblPpbAlumno } from "./TblPpbAlumno";
import { TblAnalisisDeDatos } from "./TblAnalisisDeDatos";

@Index("PK_TBL_ReporteAnalisisDatos", ["idReporteAnalisis"], { unique: true })
@Entity("TBL_ReporteAnalisisDatos", { schema: "dbo" })
export class TblReporteAnalisisDatos {
  @PrimaryGeneratedColumn({ type: "int", name: "idReporteAnalisis" })
  idReporteAnalisis!: number;

  @ManyToOne(
    () => TblPpbAlumno,
    (tblPpbAlumno) => tblPpbAlumno.tblReporteAnalisisDatos
  )
  @JoinColumn([{ name: "idPPBAlumno", referencedColumnName: "idPpbAlumno" }])
  idPpbAlumno!: TblPpbAlumno;

  @ManyToOne(
    () => TblAnalisisDeDatos,
    (tblAnalisisDeDatos) => tblAnalisisDeDatos.tblReporteAnalisisDatos
  )
  @JoinColumn([
    { name: "idAnalisisDatos", referencedColumnName: "idAnalisisDatos" },
  ])
  idAnalisisDatos!: TblAnalisisDeDatos;
}
