import {
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TblRegistroDiarioActividades } from "./TblRegistroDiarioActividades";
import { TblAlumno } from "./TblAlumno";
import { CatTareaDiaria } from "./CatTareaDiaria";

@Index("PK_TBL_TareasDiariasAlumno", ["idTareasAlumno"], { unique: true })
@Entity("TBL_TareasDiariasAlumno", { schema: "dbo" })
export class TblTareasDiariasAlumno {
  @PrimaryGeneratedColumn({ type: "int", name: "idTareasAlumno" })
  idTareasAlumno!: number;

  @OneToMany(
    () => TblRegistroDiarioActividades,
    (tblRegistroDiarioActividades) =>
      tblRegistroDiarioActividades.idActividadesDiariasAlumno
  )
  tblRegistroDiarioActividades!: TblRegistroDiarioActividades[];

  @ManyToOne(() => TblAlumno, (tblAlumno) => tblAlumno.tblTareasDiariasAlumnos)
  @JoinColumn([{ name: "idAlumno", referencedColumnName: "idAlumno" }])
  idAlumno!: TblAlumno;

  @ManyToOne(
    () => CatTareaDiaria,
    (catTareaDiaria) => catTareaDiaria.tblTareasDiariasAlumnos
  )
  @JoinColumn([{ name: "idTarea1", referencedColumnName: "idTareaDiaria" }])
  idTarea!: CatTareaDiaria;

  @ManyToOne(
    () => CatTareaDiaria,
    (catTareaDiaria) => catTareaDiaria.tblTareasDiariasAlumnos2
  )
  @JoinColumn([{ name: "idTarea2", referencedColumnName: "idTareaDiaria" }])
  idTarea2!: CatTareaDiaria;

  @ManyToOne(
    () => CatTareaDiaria,
    (catTareaDiaria) => catTareaDiaria.tblTareasDiariasAlumnos3
  )
  @JoinColumn([{ name: "idTarea3", referencedColumnName: "idTareaDiaria" }])
  idTarea3!: CatTareaDiaria;
}
