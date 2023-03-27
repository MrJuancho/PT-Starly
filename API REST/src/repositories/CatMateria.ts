import { AV_DB } from "../config/database"
import { CatMateria } from "../models"

export const getMaterias = async () : Promise<Array<CatMateria>> => {
    const materiasRepo = AV_DB.getRepository(CatMateria)
    return materiasRepo.find();
}

export const getMateria = async (name : string): Promise<CatMateria | null> => {
    const materiaRepo = AV_DB.getRepository(CatMateria);
    const materia = await materiaRepo.findOne({ where: { descripcionMateria : name } })

    if(!materia) return null
    return materia
}