import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { CatActividadPpb } from "./CatActividadPpb";
import { CatMateria } from "./CatMateria";

@Index("PK_CAT_ContenidoMaterias", ["idContenidoMateria"], { unique: true })
@Entity("CAT_ContenidoMaterias", { schema: "dbo" })
export class CatContenidoMaterias {
  @PrimaryGeneratedColumn({ type: "int", name: "idContenidoMateria" })
  idContenidoMateria!: number;

  @Column("int", { name: "Bloque" })
  bloque!: number;

  @Column("nvarchar", { name: "Descripcion", nullable: true })
  descripcion!: string | null;

  @OneToMany(
    () => CatActividadPpb,
    (catActividadPpb) => catActividadPpb.idContenido
  )
  catActividadPpbs!: CatActividadPpb[];

  @ManyToOne(() => CatMateria, (catMateria) => catMateria.catContenidoMaterias)
  @JoinColumn([{ name: "idMateria", referencedColumnName: "idMateria" }])
  idMateria!: CatMateria;
}
