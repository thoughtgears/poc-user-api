import { describe, expect, it } from 'bun:test';
import { userSchema } from '../schemas/user.schema';

// Example test for your user schema
describe('User API', () => {
    it('validates a correct user object', () => {
        const validUser = {
            firstName: 'John',
            lastName: 'Doe',
            email: 'john@example.com',
            address: {
                street: 'Main St',
                buildingNumber: '123',
                city: 'New York',
                state: 'NY',
                postcode: '10001',
                country: 'USA',
            },
        };

        const result = userSchema.safeParse(validUser);
        expect(result.success).toBe(true);
    });

    it('rejects invalid user data', () => {
        const invalidUser = {
            firstName: 'John',
            // Missing lastName
            email: 'invalid-email', // Invalid email format
            address: {
                street: 'Main St',
                // Missing buildingNumber and other required fields
            },
        };

        const result = userSchema.safeParse(invalidUser);
        expect(result.success).toBe(false);
    });
});
