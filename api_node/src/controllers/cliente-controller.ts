import { Request, Response } from 'express';
import { IClinteRepository } from '../repositories/cliente-repository';
import { ClienteDAO } from '../dao/cliente-dao';

export class ClienteController {
  private readonly _clienteRepository: IClinteRepository;

  constructor(){
    this._clienteRepository = new ClienteDAO();
  }

  public async login(req: Request, res: Response) {
    try {
      const data = req.body;
      const resposta = await this._clienteRepository.login(data);

      if(resposta)
        return res.status(200).json(resposta);

      return res.status(400).json({ mensagem: 'conta ou senha inválida' })
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }

  public async buscarPorId(req: Request, res: Response) {
    try {
      const idCliente = req.query.idCliente as string;
      const resposta = await this._clienteRepository.buscarPorId(parseInt(idCliente));
      res.status(200).json(resposta);
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }

  public async buscarPorConta(req: Request, res: Response) {
    try {
      const conta = req.query.conta as string;
      const resposta = await this._clienteRepository.buscarPorConta(parseInt(conta));
      
      if(resposta)
        return res.status(200).json(resposta);

      return res.status(400).json({ mensagem: 'conta inválida' })
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }
}