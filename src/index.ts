import { Hono } from 'hono';
import userRoutes from './routes/userRoutes';

const app = new Hono();
app.route('/users', userRoutes);

Bun.serve({
    fetch: app.fetch,
    port: 8080,
});
