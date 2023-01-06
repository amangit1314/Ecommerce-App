/* eslint-disable @typescript-eslint/indent */
import { Request, Response, Router } from 'express';
import CartResponse from '../../interfaces/CartResponse';

const router = Router();

router.get<{}, CartResponse>('/cart', (req: Request, res: Response) => {
    res.json(
        [{
            userId: '1',
            products: [{
                id: '1',
                name: 'Tooth Brush',
                price: 56,
                quantity: 1,
            }],
        }],
    );
});

export default router;