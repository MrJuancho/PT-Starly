import { Column, Entity, Index, OneToMany } from "typeorm";
import { TblAlumno } from "./TblAlumno";

@Index("PK_CAT_Escuela", ["cct"], { unique: true })
@Entity("CAT_Escuela", { schema: "dbo" })
export class CatEscuela {
  @Column("nvarchar", { primary: true, name: "CCT", length: 10 })
  cct!: string;

  @Column("nvarchar", { name: "Nombre", nullable: true, length: 150 })
  nombre!: string | null;

  @OneToMany(() => TblAlumno, (tblAlumno) => tblAlumno.cct)
  tblAlumnos!: TblAlumno[];
}
