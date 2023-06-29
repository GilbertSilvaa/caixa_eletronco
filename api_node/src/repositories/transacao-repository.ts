import { Transacao, TransacaoProps } from '../models/transacao-model';

export interface ITransacaoProps extends TransacaoProps {
  idClienteTransf?: number;
  nomeClienteTransf?: string;
}

export interface ITransacaoRepository {
  executarTransacao(dados: ITransacaoProps): Transacao | null;
  buscarTransacoes(idCliente: number): ITransacaoProps[] | null
}