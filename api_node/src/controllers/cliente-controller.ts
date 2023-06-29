import { Request, Response } from 'express';
import { IClinteRepository, LoginProps } from '../repositories/cliente-repository';

export class ClienteController {
  constructor(private clienteRepository: IClinteRepository){}

  async login(req: Request, res: Response) {
    try {
      const data = req.body;
      const resposta = await this.clienteRepository.login(data);
      res.status(200).json(resposta);
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }

  async buscarPorId(req: Request, res: Response) {
    try {
      const idCliente = req.query.idCliente as string;
      const resposta = await this.clienteRepository.buscarPorId(parseInt(idCliente));
      res.status(200).json(resposta);
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }
  
  async buscarPorConta(req: Request, res: Response) {
    try {
      const conta = req.query.conta as string;
      const resposta = await this.clienteRepository.buscarPorConta(parseInt(conta));
      res.status(200).json(resposta);
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }
}