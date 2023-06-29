import { Router } from 'express';
import { TransacaoController } from '../controllers/transacao-controller';

export const transacaoRoutes = Router();

const transacaoController = new TransacaoController();

transacaoRoutes.post('/deposito', (req, res) => 
  transacaoController.depositar(req, res)
);
transacaoRoutes.post('/saque', (req, res) => 
  transacaoController.sacar(req, res)
);
transacaoRoutes.post('/transferencia', (req, res) => 
  transacaoController.transferir(req, res)
);
transacaoRoutes.get('/buscar', (req, res) => 
  transacaoController.buscar(req, res)
);