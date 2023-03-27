import {
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TblAlumno } from "./TblAlumno";
import { TblDesbloqueosPropsAv } from "./TblDesbloqueosPropsAv";

@Index("PK_TBL_AsistenteVirtual", ["idAv"], { unique: true })
@Entity("TBL_AsistenteVirtual", { schema: "dbo" })
export class TblAsistenteVirtual {
  @PrimaryGeneratedColumn({ type: "int", name: "idAV" })
  idAv!: number;

  @OneToMany(() => TblAlumno, (tblAlumno) => tblAlumno.idAv)
  tblAlumnos!: TblAlumno[];

  @ManyToOne(
    () => TblDesbloqueosPropsAv,
    (tblDesbloqueosPropsAv) => tblDesbloqueosPropsAv.tblAsistenteVirtuals
  )
  @JoinColumn([{ name: "idCara", referencedColumnName: "idDesbloqueosAv" }])
  idCara!: TblDesbloqueosPropsAv;

  @ManyToOne(
    () => TblDesbloqueosPropsAv,
    (tblDesbloqueosPropsAv) => tblDesbloqueosPropsAv.tblAsistenteVirtuals2
  )
  @JoinColumn([{ name: "idColor", referencedColumnName: "idDesbloqueosAv" }])
  idColor!: TblDesbloqueosPropsAv;

  @ManyToOne(
    () => TblDesbloqueosPropsAv,
    (tblDesbloqueosPropsAv) => tblDesbloqueosPropsAv.tblAsistenteVirtuals3
  )
  @JoinColumn([{ name: "idPatron", referencedColumnName: "idDesbloqueosAv" }])
  idPatron!: TblDesbloqueosPropsAv;

  @ManyToOne(
    () => TblDesbloqueosPropsAv,
    (tblDesbloqueosPropsAv) => tblDesbloqueosPropsAv.tblAsistenteVirtuals4
  )
  @JoinColumn([{ name: "idPrenda", referencedColumnName: "idDesbloqueosAv" }])
  idPrenda!: TblDesbloqueosPropsAv;

  @ManyToOne(
    () => TblDesbloqueosPropsAv,
    (tblDesbloqueosPropsAv) => tblDesbloqueosPropsAv.tblAsistenteVirtuals5
  )
  @JoinColumn([{ name: "idSpecial", referencedColumnName: "idDesbloqueosAv" }])
  idSpecial!: TblDesbloqueosPropsAv;

  @OneToMany(
    () => TblDesbloqueosPropsAv,
    (tblDesbloqueosPropsAv) => tblDesbloqueosPropsAv.idAv
  )
  tblDesbloqueosPropsAvs!: TblDesbloqueosPropsAv[];
}
