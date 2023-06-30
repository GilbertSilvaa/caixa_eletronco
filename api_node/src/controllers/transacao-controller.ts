import { Request, Response } from 'express';
import { TipoTransacao } from '../enums/tipo-transacao-enum';
import { TransacaoDAO } from '../dao/transacao-dao';
import { ValidadeTransacaoDecorator } from '../decorators/validate-transacao-decorator';
import { ClienteDAO } from '../dao/cliente-dao';

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
    const clienteRepository = new ClienteDAO();
    const transacaoDecorator = new ValidadeTransacaoDecorator(
      transacaoRepository, 
      clienteRepository
    );
    try {
      const { ...data } = req.body;
      const resposta = await transacaoDecorator.executarTransacao({ 
        tipo: TipoTransacao.saque,
        ...data
      });

      if(resposta)
        return res.status(200).json(resposta);

      return res.status(400).send('saldo insuficiente');
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }

  public async transferir(req: Request, res: Response) {
    const transacaoRepository = new TransacaoDAO(TipoTransacao.transferencia);
    const clienteRepository = new ClienteDAO();
    const transacaoDecorator = new ValidadeTransacaoDecorator(
      transacaoRepository, 
      clienteRepository
    );
    try {
      const { ...data } = req.body;
      const resposta = await transacaoDecorator.executarTransacao({ 
        tipo: TipoTransacao.transferencia,
        ...data
      });
      
      if(resposta)
        return res.status(200).json(resposta);

      return res.status(400).send('saldo insuficiente');
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }

  public async buscar(req: Request, res: Response) {
    const transacaoSaque = new TransacaoDAO(TipoTransacao.saque);
    const transacaoDeposito = new TransacaoDAO(TipoTransacao.deposito);
    const transacaoTransferencia = new TransacaoDAO(TipoTransacao.transferencia);
    try {
      const idCliente = req.query.idCliente as string;

      const [resSaque, resDeposito, resTransferencia] = await Promise.all([
        await transacaoSaque.buscarTransacoes(parseInt(idCliente)),
        await transacaoDeposito.buscarTransacoes(parseInt(idCliente)),
        await transacaoTransferencia.buscarTransacoes(parseInt(idCliente))
      ]);

      const respostas = [resSaque?? [], resDeposito?? [], resTransferencia?? []];
      const registros = ValidadeTransacaoDecorator.ordenarTrasacoesByData(respostas);

      res.status(200).json(registros);
    }
    catch(error) {
      res.status(400).json({ error });
    }
  }
}