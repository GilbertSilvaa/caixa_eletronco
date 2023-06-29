import { Router } from 'express';
import { ClienteController } from '../controllers/cliente-controller';

export const clienteRoutes = Router();

const clienteController = new ClienteController();

clienteRoutes.post('/login', (req, res) => 
  clienteController.login(req, res)
);
clienteRoutes.get('/buscarPorId', (req, res) => 
  clienteController.buscarPorId(req, res)
);
clienteRoutes.get('/buscarPorConta', (req, res) => 
  clienteController.buscarPorConta(req, res)
);