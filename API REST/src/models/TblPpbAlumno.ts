import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TblReporteAnalisisDatos } from "./TblReporteAnalisisDatos";

@Index("PK_TBL_PPBAlumno", ["idPpbAlumno"], { unique: true })
@Entity("TBL_PPBAlumno", { schema: "dbo" })
export class TblPpbAlumno {
  @PrimaryGeneratedColumn({ type: "int", name: "idPPBAlumno" })
  idPpbAlumno!: number;

  @Column("int", { name: "idAlumno" })
  idAlumno!: number;

  @Column("int", { name: "IndiceAtencion" })
  indiceAtencion!: number;

  @Column("int", { name: "IndiceMemoria" })
  indiceMemoria!: number;

  @Column("int", { name: "IndicePercepcion" })
  indicePercepcion!: number;

  @OneToMany(
    () => TblReporteAnalisisDatos,
    (tblReporteAnalisisDatos) => tblReporteAnalisisDatos.idPpbAlumno
  )
  tblReporteAnalisisDatos!: TblReporteAnalisisDatos[];
}
