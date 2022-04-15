import { EntityRepository, Repository } from 'typeorm';
import { User } from '../entity/user.entity';
import { Request, Response } from 'express';

@EntityRepository(User)
export class UserRepository extends Repository<User> {
    // Create a new user
    async createUser(req: Request, res: Response) {
        try {
            let user = new User();
        user.username = "Aman";
        user.useremail = "amansoni53453@gmail.com";
        user.userpassword = "aman53453";

        let userData = await this.save(user);
        return res.send(userData);
        }
        catch (error) {
            res.send(error);
        }
    }
}