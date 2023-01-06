import { Router } from 'express';
import UserResponse from '../../interfaces/UserResponse';

const router = Router();
let userName = 'user';

router.get<{}, UserResponse>(`/${userName}`, (req, res) => {
    res.json({
        id: '1',
        name: userName,
        email: '',
        password: '',
        isAdmin: false,
    });
});

export default router;