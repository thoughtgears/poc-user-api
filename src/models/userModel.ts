import { z } from 'zod';

export const userSchema = z.object({
    name: z.string(),
    email: z.string().email(),
});

export type UserModel = z.infer<typeof userSchema>;
