import { Connection } from 'mysql';
import { 
  ITransacaoProps, 
  ITransacaoRepository 
} from '../repositories/transacao-repository';
import { DBService } from '../services/db-service';
import { TipoTransacao } from '../enums/tipo-transacao-enum';
import { Transacao, TransacaoProps } from '../models/transacao-model';
import { IClinteRepository } from '../repositories/cliente-repository';

export class TransacaoFactory {
  public static criarTransacao(
    tipo: TipoTransacao, 
    conn: Connection, 
    cli: IClinteRepository
  ){
    switch(tipo) {
      case TipoTransacao.transferencia:
        return new Transferencia(conn, cli);
      default:
        return new TransacaoPadrao(conn, tipo);
    }
  }
}

class TransacaoPadrao implements ITransacaoRepository {
  constructor(
    private readonly conexao: Connection, 
    private readonly tipoTransacao: TipoTransacao
  ){}

  public async executarTransacao({ idCliente, valor }: ITransacaoProps) {
    const consulta = `call SP_TRANSACAO_COMUM(${idCliente},${valor},${this.tipoTransacao})`;
    const dbService = new DBService(this.conexao);
    const resposta = (await dbService.execute(consulta) as any[])[0] as TransacaoProps[];

    if(!resposta.length) return null;

    return Transacao.convertMap(resposta)[0];
  }

  public async buscarTransacoes(idCliente: number) {
    const consulta = `select * from Transacao where cliente_id=${idCliente} and tipo=${this.tipoTransacao}`;
    const dbService = new DBService(this.conexao);
    const resposta = await dbService.execute(consulta) as TransacaoProps[];

    if(!resposta.length) return null;

    return Transacao.convertMap(resposta);
  }
}

class Transferencia implements ITransacaoRepository {
  constructor(
    private readonly conexao: Connection, 
    private readonly clienteRepository: IClinteRepository
  ){}

  public async executarTransacao({ idCliente, idClienteTransf, valor }: ITransacaoProps) {
    const consulta = `call SP_TRANSFERENCIA(${idCliente},${idClienteTransf},${valor})`;
    const dbService = new DBService(this.conexao);
    const resposta = (await dbService.execute(consulta) as any[])[0] as TransacaoProps[];
    
    if(!resposta.length) return null;

    return Transacao.convertMap(resposta)[0];
  }

  public async buscarTransacoes(idCliente: number) {
    const consulta = `call SP_BUSCAR_TRANSFERENCIAS(${idCliente})`;
    const dbService = new DBService(this.conexao);
    const resposta = (await dbService.execute(consulta) as any[])[0] as TransacaoProps[];
    
    if(!resposta.length) return null;

    const transacoesConvert = Transacao.convertMap(resposta);

    const transacoes = await Promise.all(
      transacoesConvert.map(async (tr) => {
        const clienteTransfe = await this.clienteRepository.buscarPorId(tr.idCliente);
        const transacao = new Transacao(tr);
        transacao.clienteTransf = clienteTransfe?.nome;
        return transacao;
      })
    ); 
    
    return transacoes;
  }
}