import express, { response } from "express"
import CatMateriaController from "../controllers/CatMateria.controller"

const router =  express.Router()

router.get("/", async ( _req , res ) => {
    const controller = new CatMateriaController()
    const response = await controller.getMaterias()
    return res.send(response)
})

router.get("/:name",async (req, res) => {
    const controller = new CatMateriaController();
    const response = await controller.getMateria(req.params.name);

    if(!response) res.status(404).send({ message: "No existe la materia especificada"})
    return res.send(response)
})

export default router;