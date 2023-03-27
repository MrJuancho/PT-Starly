import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { TblAsistenteVirtual } from "./TblAsistenteVirtual";
import { CatEscuela } from "./CatEscuela";
import { TblDesafioDiarioAlumno } from "./TblDesafioDiarioAlumno";
import { TblResultadosActividad } from "./TblResultadosActividad";
import { TblTareasDiariasAlumno } from "./TblTareasDiariasAlumno";

@Index("PK_TBL_Alumno", ["idAlumno"], { unique: true })
@Entity("TBL_Alumno", { schema: "dbo" })
export class TblAlumno {
  @PrimaryGeneratedColumn({ type: "int", name: "idAlumno" })
  idAlumno!: number;

  @Column("nvarchar", { name: "Nombre", length: 50 })
  nombre!: string;

  @Column("nvarchar", { name: "ApellidoMaterno", length: 50 })
  apellidoMaterno!: string;

  @Column("nvarchar", { name: "ApellidoPaterno", length: 50 })
  apellidoPaterno!: string;

  @Column("smallint", { name: "NoLista" })
  noLista!: number;

  @Column("date", { name: "FechaNacimiento", nullable: true })
  fechaNacimiento!: Date | null;

  @Column("nvarchar", { name: "NombreUsuario", nullable: true, length: 50 })
  nombreUsuario!: string | null;

  @Column("nvarchar", { name: "ClaveAcceso", nullable: true, length: 50 })
  claveAcceso!: string | null;

  @Column("int", { name: "BalanceEstrellas", default: () => "(0)" })
  balanceEstrellas!: number;

  @Column("int", { name: "BalanceMonedas", default: () => "(0)" })
  balanceMonedas!: number;

  @ManyToOne(
    () => TblAsistenteVirtual,
    (tblAsistenteVirtual) => tblAsistenteVirtual.tblAlumnos
  )
  @JoinColumn([{ name: "idAV", referencedColumnName: "idAv" }])
  idAv!: TblAsistenteVirtual;

  @ManyToOne(() => CatEscuela, (catEscuela) => catEscuela.tblAlumnos)
  @JoinColumn([{ name: "CCT", referencedColumnName: "cct" }])
  cct!: CatEscuela;

  @OneToMany(
    () => TblDesafioDiarioAlumno,
    (tblDesafioDiarioAlumno) => tblDesafioDiarioAlumno.idAlumno
  )
  tblDesafioDiarioAlumnos!: TblDesafioDiarioAlumno[];

  @OneToMany(
    () => TblResultadosActividad,
    (tblResultadosActividad) => tblResultadosActividad.idAlumno
  )
  tblResultadosActividads!: TblResultadosActividad[];

  @OneToMany(
    () => TblTareasDiariasAlumno,
    (tblTareasDiariasAlumno) => tblTareasDiariasAlumno.idAlumno
  )
  tblTareasDiariasAlumnos!: TblTareasDiariasAlumno[];
}
