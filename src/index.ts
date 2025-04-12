import { Hono } from 'hono';
import { db } from './db/db.ts';
import { zValidator } from '@hono/zod-validator';
import { userSchema } from './schemas/user.schema.ts';

const app = new Hono();

app.get('/users', async (c) => {
    const users = await db.getAll();
    return c.json(users);
});

app.get('/users/:id', async (c) => {
    const id = c.req.param('id');
    const user = await db.getById(id);

    if (!user) {
        return c.json({ error: 'User not found' }, 404);
    }

    return c.json(user);
});

app.post('/users', zValidator('json', userSchema.omit({ id: true })), async (c) => {
    const userData = await c.req.json();
    const newUser = await db.create(userData);
    return c.json(newUser, 201);
});

app.patch('/users/:id', zValidator('json', userSchema.partial()), async (c) => {
    const id = c.req.param('id');
    const userData = await c.req.json();

    const updatedUser = await db.update(id, userData);

    if (!updatedUser) {
        return c.json({ error: 'User not found' }, 404);
    }

    return c.json(updatedUser);
});

app.delete('/users/:id', async (c) => {
    const id = c.req.param('id');
    const success = await db.delete(id);

    if (!success) {
        return c.json({ error: 'User not found' }, 404);
    }

    return c.json({ message: 'User deleted successfully' });
});

Bun.serve({
    fetch: app.fetch,
    port: 8080,
});

console.log('Server running on port 8080');
