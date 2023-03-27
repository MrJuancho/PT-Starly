import { Get, Route, Tags, Body, Path, Post } from "tsoa"
import { CatMateria } from "../models"
import {
    getMaterias,
    getMateria
} from "../repositories/CatMateria"

@Route("materias")
@Tags("CatMateria")
export default class CatMateriaController {
    @Get("/")
    public async getMaterias(): Promise<Array<CatMateria>> {
        return getMaterias()
    }

    @Get("/:name")
    public async getMateria(@Path() name: string): Promise<CatMateria | null>{
        return getMateria(name)
    }
}