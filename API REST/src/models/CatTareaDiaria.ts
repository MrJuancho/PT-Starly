import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TblTareasDiariasAlumno } from "./TblTareasDiariasAlumno";

@Index("PK_CAT_TareaDiaria", ["idTareaDiaria"], { unique: true })
@Entity("CAT_TareaDiaria", { schema: "dbo" })
export class CatTareaDiaria {
  @PrimaryGeneratedColumn({ type: "int", name: "idTareaDiaria" })
  idTareaDiaria!: number;

  @Column("nvarchar", { name: "DescripcionTarea", nullable: true, length: 250 })
  descripcionTarea!: string | null;

  @Column("int", { name: "Monedas", nullable: true })
  monedas!: number | null;

  @Column("int", { name: "Estrellas", nullable: true })
  estrellas!: number | null;

  @OneToMany(
    () => TblTareasDiariasAlumno,
    (tblTareasDiariasAlumno) => tblTareasDiariasAlumno.idTarea
  )
  tblTareasDiariasAlumnos!: TblTareasDiariasAlumno[];

  @OneToMany(
    () => TblTareasDiariasAlumno,
    (tblTareasDiariasAlumno) => tblTareasDiariasAlumno.idTarea2
  )
  tblTareasDiariasAlumnos2!: TblTareasDiariasAlumno[];

  @OneToMany(
    () => TblTareasDiariasAlumno,
    (tblTareasDiariasAlumno) => tblTareasDiariasAlumno.idTarea3
  )
  tblTareasDiariasAlumnos3!: TblTareasDiariasAlumno[];
}
