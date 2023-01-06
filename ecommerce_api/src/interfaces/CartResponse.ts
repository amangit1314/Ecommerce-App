/* eslint-disable @typescript-eslint/indent */
export default interface CartResponse {
    userId: string;
    products: {
        productId: string;
        productName: string;
        price: number;
        quantity: number;
    }[];
}
