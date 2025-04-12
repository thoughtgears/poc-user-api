import { z } from 'zod';

import { addressSchema } from './address.schema';

export const userSchema = z.object({
    id: z.string().optional(),
    firstName: z.string(),
    middleName: z.string().optional(),
    lastName: z.string(),
    email: z.string().email(),
    phone: z.string().optional(),
    address: addressSchema,
});
