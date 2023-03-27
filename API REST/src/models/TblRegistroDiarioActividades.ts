import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TblTareasDiariasAlumno } from "./TblTareasDiariasAlumno";
import { TblDesafioDiarioAlumno } from "./TblDesafioDiarioAlumno";

@Index("PK_TBL_RegistroDiarioActividades", ["idRegistroActividades"], {
  unique: true,
})
@Entity("TBL_RegistroDiarioActividades", { schema: "dbo" })
export class TblRegistroDiarioActividades {
  @PrimaryGeneratedColumn({ type: "int", name: "idRegistroActividades" })
  idRegistroActividades!: number;

  @Column("int", { name: "TareasCompletadas", nullable: true })
  tareasCompletadas!: number | null;

  @Column("int", { name: "Fecha", nullable: true })
  fecha!: number | null;

  @ManyToOne(
    () => TblTareasDiariasAlumno,
    (tblTareasDiariasAlumno) =>
      tblTareasDiariasAlumno.tblRegistroDiarioActividades
  )
  @JoinColumn([
    {
      name: "idActividadesDiariasAlumno",
      referencedColumnName: "idTareasAlumno",
    },
  ])
  idActividadesDiariasAlumno!: TblTareasDiariasAlumno;

  @ManyToOne(
    () => TblDesafioDiarioAlumno,
    (tblDesafioDiarioAlumno) =>
      tblDesafioDiarioAlumno.tblRegistroDiarioActividades
  )
  @JoinColumn([
    { name: "idDesafioDiario", referencedColumnName: "idDesafioAlumno" },
  ])
  idDesafioDiario!: TblDesafioDiarioAlumno;
}
