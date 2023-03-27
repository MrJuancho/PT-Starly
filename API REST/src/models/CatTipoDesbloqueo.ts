import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { CatPropPersonalizacion } from "./CatPropPersonalizacion";

@Index("PK_CAT_TipoDesbloqueo", ["idTipoDesbloqueo"], { unique: true })
@Entity("CAT_TipoDesbloqueo", { schema: "dbo" })
export class CatTipoDesbloqueo {
  @PrimaryGeneratedColumn({ type: "int", name: "idTipoDesbloqueo" })
  idTipoDesbloqueo!: number;

  @Column("nvarchar", {
    name: "Desc_TipoDebloqueo",
    nullable: true,
    length: 15,
  })
  descTipoDebloqueo!: string | null;

  @OneToMany(
    () => CatPropPersonalizacion,
    (catPropPersonalizacion) => catPropPersonalizacion.idTipoDebloqueo
  )
  catPropPersonalizacions!: CatPropPersonalizacion[];
}
