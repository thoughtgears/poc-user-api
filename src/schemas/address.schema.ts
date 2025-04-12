import { z } from 'zod';

export const addressSchema = z.object({
    street: z.string(),
    buildingNumber: z.string(),
    city: z.string(),
    state: z.string(),
    postcode: z.string(),
    country: z.string(),
});
