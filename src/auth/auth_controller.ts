import { getManager } from "typeorm";
import { Request, Response } from "express";
import { UserRepository } from "./repository/user.repo";


export class AuthController {
    static async createUser(req: Request, res: Response) {
        let manager = await getManager().getCustomRepository(UserRepository);
        await manager.createUser(req, res);
    }
}