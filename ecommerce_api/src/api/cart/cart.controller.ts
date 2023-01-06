import { Response } from 'express';
import { CartResponse } from '../../interfaces/CartResponse';
import { Cart } from '../../models/Cart';
import { Product } from '../../models/Product';
import { User } from '../../models/User';

export const getCart = async (req: any, res: Response) => {
    const user
        = await User.findOne({ where: { id: req.user.id } });
    const cart
        = await Cart.findOne({ where: { userId: user.id } });
    const products
        = await Product.findAll({ where: { cartId: cart.id } });
    const cartResponse: CartResponse = {
        id: cart.id,
        products: products,
    };
    res.json(cartResponse);
};