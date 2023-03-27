import AV_DB from "../config/database"
import { TblAlumno } from "../models"

export interface AlumnoDataPayload {
    nombre : string,
    apellidoPaterno: string,
    apellidoMaterno: string,
    noLista: number,
    fechaNac: string,
    nombreUsuario: string,
    claveAcceso: string,
    balanceMonedas: number,
    balanceEstrellas: Number
}

export interface AlumnoBasicDataPayload {
    nombre: string,
    apellidoPaterno: string,
    apellidoMaterno: string
}

export const getAlumnos = async () : Promise<Array<TblAlumno>> => {
    const alumnoRepository = AV_DB.getRepository(TblAlumno)
    return alumnoRepository.find()
}

export const getAlumnoByBasicData = async (payload: AlumnoBasicDataPayload) : Promise<TblAlumno | null> => {
    const alumnoRepository = AV_DB.getRepository(TblAlumno)
    const alumno = await alumnoRepository.findOne({ where: {
        nombre : payload.nombre,
        apellidoMaterno : payload.apellidoMaterno,
        apellidoPaterno : payload.apellidoPaterno
    }})

    if(!alumno) return null
    return alumno
}

export const getAlumnoByUsername = async (username : string) : Promise<TblAlumno | null> => {
    const alumnoRepository = AV_DB.getRepository(TblAlumno)
    const alumno = await alumnoRepository.findOne({ where: { nombreUsuario : username}})

    if(!alumno) return null
    return alumno
}