import { Connection } from 'mysql';
import { ITransacaoRepository } from '../repositories/transacao-repository';
import { IClinteRepository } from '../repositories/cliente-repository';
import { TipoTransacao } from '../enums/tipo-transacao-enum';
import { Conexao } from '../database/conexao';
import { ClienteDAO } from './cliente-dao';
import { TransacaoFactory } from '../factories/transacao-factory';
import { TransacaoProps } from '../models/transacao-model';

export class TransacaoDAO implements ITransacaoRepository {
  private readonly _conexao: Connection;
  private readonly _clienteRepository: IClinteRepository;
  private readonly _transacaoFactory: ITransacaoRepository;

  constructor(tipo: TipoTransacao) {
    this._conexao = Conexao.getInstance().conexao();
    this._clienteRepository = new ClienteDAO();
    this._transacaoFactory = TransacaoFactory.criarTransacao(
      tipo, this._conexao, this._clienteRepository
    );
  }

  public async executarTransacao(params: TransacaoProps) {
    return this._transacaoFactory.executarTransacao(params);
  }

  public async buscarTransacoes(idCliente: number) {
    return this._transacaoFactory.buscarTransacoes(idCliente);
  }
}