import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { CatPropPersonalizacion } from "./CatPropPersonalizacion";

@Index("PK_CAT_TipoPersonalizacion", ["idTipoPersonalizacion"], {
  unique: true,
})
@Entity("CAT_TipoPersonalizacion", { schema: "dbo" })
export class CatTipoPersonalizacion {
  @PrimaryGeneratedColumn({ type: "int", name: "idTipoPersonalizacion" })
  idTipoPersonalizacion!: number;

  @Column("nvarchar", {
    name: "Desc_TipoPersonalizacion",
    nullable: true,
    length: 100,
  })
  descTipoPersonalizacion!: string | null;

  @OneToMany(
    () => CatPropPersonalizacion,
    (catPropPersonalizacion) => catPropPersonalizacion.idTipoPersonalizacion
  )
  catPropPersonalizacions!: CatPropPersonalizacion[];
}
