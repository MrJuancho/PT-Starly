import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { CatActividadPpb } from "./CatActividadPpb";
import { CatDatoCurioso } from "./CatDatoCurioso";
import { TblResultadosActividad } from "./TblResultadosActividad";

@Index("PK_CAT_Actividad", ["idActividad"], { unique: true })
@Entity("CAT_Actividad", { schema: "dbo" })
export class CatActividad {
  @PrimaryGeneratedColumn({ type: "int", name: "idActividad" })
  idActividad!: number;

  @Column("nvarchar", { name: "NombreActividad", length: 150 })
  nombreActividad!: string;

  @Column("nvarchar", { name: "Descripcion", nullable: true })
  descripcion?: string | null;

  @OneToMany(
    () => CatActividadPpb,
    (catActividadPpb) => catActividadPpb.idActividad
  )
  catActividadPpbs!: CatActividadPpb[];

  @OneToMany(
    () => CatDatoCurioso,
    (catDatoCurioso) => catDatoCurioso.idActividad
  )
  catDatoCuriosos!: CatDatoCurioso[];

  @OneToMany(
    () => TblResultadosActividad,
    (tblResultadosActividad) => tblResultadosActividad.idActividad
  )
  tblResultadosActividads!: TblResultadosActividad[];
}
