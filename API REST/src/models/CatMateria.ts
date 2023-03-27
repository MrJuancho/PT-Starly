import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { CatContenidoMaterias } from "./CatContenidoMaterias";

@Index("PK_CAT_Materia", ["idMateria"], { unique: true })
@Entity("CAT_Materia", { schema: "dbo" })
export class CatMateria {
  @PrimaryGeneratedColumn({ type: "int", name: "idMateria" })
  idMateria!: number;

  @Column("nvarchar", { name: "DescripcionMateria", length: 60 })
  descripcionMateria!: string;

  @OneToMany(
    () => CatContenidoMaterias,
    (catContenidoMaterias) => catContenidoMaterias.idMateria
  )
  catContenidoMaterias?: CatContenidoMaterias[];
}
