import { userSchema } from '../schemas/user.schema';
import { z } from 'zod';

// Export the inferred type
export type User = z.infer<typeof userSchema>;
