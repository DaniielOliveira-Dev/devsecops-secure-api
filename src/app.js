const express = require('express');
const helmet = require('helmet');
const app = express();
app.use(helmet({ strictTransportSecurity: false })); // staging HTTP local
app.disable('x-powered-by');
app.get('/', (_, res) => res.json({ name: 'DevSecOps Secure API', endpoints: ['/health', '/api/products'] }));
app.get('/health', (_, res) => res.json({ status: 'ok' }));
app.get('/api/products', (_, res) => res.json([{ id: 1, name: 'Notebook' }]));
app.use((_, res) => res.status(404).json({ error: 'Not found' }));
app.listen(3000, '0.0.0.0');
