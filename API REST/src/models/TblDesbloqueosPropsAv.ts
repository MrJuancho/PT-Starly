import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TblAsistenteVirtual } from "./TblAsistenteVirtual";
import { CatPropPersonalizacion } from "./CatPropPersonalizacion";

@Index("PK_TBL_DesbloqueosPropsAV", ["idDesbloqueosAv"], { unique: true })
@Entity("TBL_DesbloqueosPropsAV", { schema: "dbo" })
export class TblDesbloqueosPropsAv {
  @PrimaryGeneratedColumn({ type: "int", name: "idDesbloqueosAV" })
  idDesbloqueosAv!: number;

  @Column("datetime", { name: "FechaDesbloqueo", nullable: true })
  fechaDesbloqueo!: Date | null;

  @Column("bit", { name: "Desbloqueado", nullable: true })
  desbloqueado!: boolean | null;

  @OneToMany(
    () => TblAsistenteVirtual,
    (tblAsistenteVirtual) => tblAsistenteVirtual.idCara
  )
  tblAsistenteVirtuals!: TblAsistenteVirtual[];

  @OneToMany(
    () => TblAsistenteVirtual,
    (tblAsistenteVirtual) => tblAsistenteVirtual.idColor
  )
  tblAsistenteVirtuals2!: TblAsistenteVirtual[];

  @OneToMany(
    () => TblAsistenteVirtual,
    (tblAsistenteVirtual) => tblAsistenteVirtual.idPatron
  )
  tblAsistenteVirtuals3!: TblAsistenteVirtual[];

  @OneToMany(
    () => TblAsistenteVirtual,
    (tblAsistenteVirtual) => tblAsistenteVirtual.idPrenda
  )
  tblAsistenteVirtuals4!: TblAsistenteVirtual[];

  @OneToMany(
    () => TblAsistenteVirtual,
    (tblAsistenteVirtual) => tblAsistenteVirtual.idSpecial
  )
  tblAsistenteVirtuals5!: TblAsistenteVirtual[];

  @ManyToOne(
    () => CatPropPersonalizacion,
    (catPropPersonalizacion) => catPropPersonalizacion.tblDesbloqueosPropsAvs
  )
  @JoinColumn([
    {
      name: "idPropsPersonalizacion",
      referencedColumnName: "idPropPersonalizacion",
    },
  ])
  idPropsPersonalizacion!: CatPropPersonalizacion;

  @ManyToOne(
    () => TblAsistenteVirtual,
    (tblAsistenteVirtual) => tblAsistenteVirtual.tblDesbloqueosPropsAvs
  )
  @JoinColumn([{ name: "idAV", referencedColumnName: "idAv" }])
  idAv!: TblAsistenteVirtual;
}
