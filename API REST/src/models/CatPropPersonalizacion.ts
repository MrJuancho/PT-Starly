import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { CatTipoPersonalizacion } from "./CatTipoPersonalizacion";
import { CatTipoDesbloqueo } from "./CatTipoDesbloqueo";
import { TblDesbloqueosPropsAv } from "./TblDesbloqueosPropsAv";

@Index("PK_CAT_PropPersonalizacion", ["idPropPersonalizacion"], {
  unique: true,
})
@Entity("CAT_PropPersonalizacion", { schema: "dbo" })
export class CatPropPersonalizacion {
  @PrimaryGeneratedColumn({ type: "int", name: "idPropPersonalizacion" })
  idPropPersonalizacion!: number;

  @Column("nvarchar", { name: "Nom_Prop", length: 150 })
  nomProp!: string;

  @Column("nvarchar", { name: "Desc_Prop", nullable: true, length: 250 })
  descProp?: string | null;

  @Column("int", { name: "Costo" })
  costo!: number;

  @ManyToOne(
    () => CatTipoPersonalizacion,
    (catTipoPersonalizacion) => catTipoPersonalizacion.catPropPersonalizacions
  )
  @JoinColumn([
    {
      name: "idTipoPersonalizacion",
      referencedColumnName: "idTipoPersonalizacion",
    },
  ])
  idTipoPersonalizacion!: CatTipoPersonalizacion;

  @ManyToOne(
    () => CatTipoDesbloqueo,
    (catTipoDesbloqueo) => catTipoDesbloqueo.catPropPersonalizacions
  )
  @JoinColumn([
    { name: "idTipoDebloqueo", referencedColumnName: "idTipoDesbloqueo" },
  ])
  idTipoDebloqueo!: CatTipoDesbloqueo;

  @OneToMany(
    () => TblDesbloqueosPropsAv,
    (tblDesbloqueosPropsAv) => tblDesbloqueosPropsAv.idPropsPersonalizacion
  )
  tblDesbloqueosPropsAvs!: TblDesbloqueosPropsAv[];
}