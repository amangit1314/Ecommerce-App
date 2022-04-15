import Router from 'express'
import { AuthController } from './auth_controller'

const router = Router()
router.post("/add", AuthController.createUser);

export default router
