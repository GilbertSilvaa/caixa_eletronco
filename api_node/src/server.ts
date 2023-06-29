import express from 'express';
import { clienteRoutes } from './routes/cliente-routes';

const app = express();

app.use(express.json());

app.use('/cliente', clienteRoutes);

const PORT = 5000;
app.listen(PORT, () => console.log(`servidor rodando na porta ${PORT}`));