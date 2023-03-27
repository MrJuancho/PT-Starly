import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TblDesafioDiarioAlumno } from "./TblDesafioDiarioAlumno";

@Index("PK_CAT_DesafioDiario", ["idDesafio"], { unique: true })
@Entity("CAT_DesafioDiario", { schema: "dbo" })
export class CatDesafioDiario {
  @PrimaryGeneratedColumn({ type: "int", name: "idDesafio" })
  idDesafio!: number;

  @Column("nvarchar", {
    name: "DescripcionDesafio",
    nullable: true,
    length: 150,
  })
  descripcionDesafio!: string | null;

  @Column("int", { name: "Monedas", nullable: true })
  monedas!: number | null;

  @Column("int", { name: "Estrellas", nullable: true })
  estrellas!: number | null;

  @OneToMany(
    () => TblDesafioDiarioAlumno,
    (tblDesafioDiarioAlumno) => tblDesafioDiarioAlumno.idDesafioDiario
  )
  tblDesafioDiarioAlumnos!: TblDesafioDiarioAlumno[];
}
