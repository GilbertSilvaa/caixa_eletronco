import { TipoTransacao } from '../enums/tipo-transacao-enum';

export interface TransacaoProps {
  id?: number;
  idCliente: number;
  tipo: TipoTransacao
  valor: number;
  dtTransacao?: Date
  clienteTransf?: string;
}

export class Transacao {
  id?: number;
  idCliente: number;
  tipo: TipoTransacao
  valor: number;
  dtTransacao?: Date;
  clienteTransf?: string;

  constructor(props: TransacaoProps) {
    this.id = props.id;
    this.idCliente = props.idCliente;
    this.tipo = props.tipo;
    this.valor = props.valor;
    this.dtTransacao = props.dtTransacao;
    this.clienteTransf = props.clienteTransf;
  }

  public static convertMap(objs: any[]) {
    return objs.map(obj=> new Transacao({
      id: obj['id'],
      idCliente: obj['cliente_id'],
      tipo: obj['tipo'],
      valor: obj['valor'],
      dtTransacao: obj['dt_transacao']
    }));
  }
}