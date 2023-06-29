import { Transacao } from '../models/transacao-model';
import { IClinteRepository } from '../repositories/cliente-repository';
import { ITransacaoProps, ITransacaoRepository } from '../repositories/transacao-repository';

export class ValidadeTransacaoDecorator implements ITransacaoRepository {
  constructor(
    private transacaoRepository: ITransacaoRepository, 
    private clienteRepository: IClinteRepository
  ) {}

  public async executarTransacao(params: ITransacaoProps) {
    if(await this.verificarSaldo(params.idCliente, params.valor)) {
      return this.transacaoRepository.executarTransacao(params);
    }
    return null;
  }

  public async buscarTransacoes(idCliente: number) {
    return this.transacaoRepository.buscarTransacoes(idCliente);
  }

  private async verificarSaldo(idCliente: number, valor: number) {
    const saldoCliente = (await this.clienteRepository.buscarPorId(idCliente))?.saldo ?? 0;

    if(saldoCliente >= valor) 
      return true;
    return false;
  }

  public static ordenarTrasacoesByData(transacoes: ITransacaoProps[][]) {
    const registros : ITransacaoProps[] = [];
    transacoes.forEach(res => res.forEach(tr => registros.push(tr)));
    
    return registros.sort((a, b) => Number(b.dtTransacao) - Number(a.dtTransacao));
  }
}