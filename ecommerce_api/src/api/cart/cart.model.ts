/* eslint-disable @typescript-eslint/indent */
import * as z from 'zod';
// zod is an schema validation library for typescript
export const Cart = z.object({
    userId: z.string(),
    products: z.array(z.object({
        productId: z.string().min(1),
        productName: z.string(),
        price: z.number(),
        quantity: z.number(),
    })),
});

//export default Cart;
module.exports = Cart;