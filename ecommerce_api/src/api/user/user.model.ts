import * as z from 'zod';

export const User = z.object({
    id: z.string(),
    name: z.string(),
    email: z.string().email().trim().max(18).min(10),
    password: z.string(),
    isAdmin: z.boolean(),
});

type User = z.infer<typeof User>;
module.exports = User;