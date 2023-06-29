import { Request, Response } from 'express';
import { TipoTransacao } from '../enums/tipo-transacao-enum';
import { TransacaoDAO } from '../dao/transacao-dao';

export class TransacaoController {

  public async depositar(req: Request, res: Response) {
    const transacaoRepository = new TransacaoDAO(TipoTransacao.deposito);

    try {
      const { ...data } = req.body;
      const resposta = await transacaoRepository.executarTransacao({ 
        tipo: TipoTransacao.deposito,
        ...data
      });
      res.status(200).json(resposta);
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }

  public async sacar(req: Request, res: Response) {
    const transacaoRepository = new TransacaoDAO(TipoTransacao.saque);

    try {
      const { ...data } = req.body;
      const resposta = await transacaoRepository.executarTransacao({ 
        tipo: TipoTransacao.saque,
        ...data
      });
      res.status(200).json(resposta);
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }

  public async transferir(req: Request, res: Response) {
    const transacaoRepository = new TransacaoDAO(TipoTransacao.transferencia);

    try {
      const { ...data } = req.body;
      const resposta = await transacaoRepository.executarTransacao({ 
        tipo: TipoTransacao.transferencia,
        ...data
      });
      res.status(200).json(resposta);
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }

  public async buscar(req: Request, res: Response) {
    const transacaoDeposito = new TransacaoDAO(TipoTransacao.transferencia);

    try {
      const idCliente = req.query.idCliente as string;
      const resposta = await transacaoDeposito.buscarTransacoes(parseInt(idCliente));
      res.status(200).json(resposta);
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }
}