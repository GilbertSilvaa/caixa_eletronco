import { Connection } from 'mysql';
import { ITransacaoRepository } from '../repositories/transacao-repository';
import { IClinteRepository } from '../repositories/cliente-repository';
import { TipoTransacao } from '../enums/tipo-transacao-enum';
import { Conexao } from '../database/conexao';
import { ClienteDAO } from './cliente-dao';
import { TransacaoFactory } from '../factories/transacao-factory';
import { TransacaoProps } from '../models/transacao-model';

export class TransacaoDAO implements ITransacaoRepository {
  private readonly _transacaoFactory: ITransacaoRepository;

  constructor(tipo: TipoTransacao) {
    const conexao = Conexao.getInstance().conexao();
    const clienteRepository = new ClienteDAO();
    this._transacaoFactory = TransacaoFactory.criarTransacao(
      tipo, conexao, clienteRepository
    );
  }

  public async executarTransacao(params: TransacaoProps) {
    return this._transacaoFactory.executarTransacao(params);
  }

  public async buscarTransacoes(idCliente: number) {
    return this._transacaoFactory.buscarTransacoes(idCliente);
  }
}