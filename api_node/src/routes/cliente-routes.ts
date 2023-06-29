import { Router } from 'express';
import { ClienteDAO } from '../dao/cliente-dao';
import { ClienteController } from '../controllers/cliente-controller';

export const clienteRoutes = Router();

const clienteRepository = new ClienteDAO();
const clienteController = new ClienteController(clienteRepository);

clienteRoutes.post('/login', (req, res) => 
  clienteController.login(req, res)
);
clienteRoutes.get('/buscarPorId', (req, res) => 
  clienteController.buscarPorId(req, res)
);
clienteRoutes.get('/buscarPorConta', (req, res) => 
  clienteController.buscarPorConta(req, res)
);