import { type Context, Hono } from 'hono';
import { userService } from '../services/userService';
import { z } from 'zod';

const userRoutes = new Hono();

userRoutes.post('/', async (c: Context) => {
    try {
        const userData = await c.req.json();
        const user = await userService.createUser(userData);
        return c.json(user, 201);
    } catch (error) {
        if (error instanceof z.ZodError) {
            return c.json({ error: 'Invalid user data', details: error.errors }, 400);
        }
        console.error('Error creating user:', error);
        return c.json({ error: 'Internal server error' }, 500);
    }
});

userRoutes.get('/:id', async (c: Context) => {
    const id = c.req.param('id');
    const user = await userService.getUser(id);
    if (!user) {
        return c.json({ error: 'User not found' }, 404);
    }
    return c.json(user);
});

userRoutes.put('/:id', async (c: Context) => {
    const id = c.req.param('id');
    try {
        const userData = await c.req.json();
        const updatedUser = await userService.updateUser(id, userData);
        return c.json(updatedUser);
    } catch (error) {
        if (error instanceof z.ZodError) {
            return c.json({ error: 'Invalid user data', details: error.errors }, 400);
        }
        console.error('Error updating user:', error);
        return c.json({ error: 'Internal server error' }, 500);
    }
});

userRoutes.delete('/:id', async (c: Context) => {
    const id = c.req.param('id');
    await userService.deleteUser(id);
    return c.json({ message: 'User deleted' });
});

export default userRoutes;
