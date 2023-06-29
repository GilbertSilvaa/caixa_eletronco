import { TipoTransacao } from '../enums/tipo-transacao-enum';

export interface TransacaoProps {
  id?: number;
  idCliente: number;
  tipo: TipoTransacao
  valor: number;
  dtTransacao?: Date
}

export class Transacao {
  id?: number;
  idCliente: number;
  tipo: TipoTransacao
  valor: number;
  dtTransacao?: Date;

  constructor(props: TransacaoProps) {
    this.id = props.id;
    this.idCliente = props.idCliente;
    this.tipo = props.tipo;
    this.valor = props.valor;
    this.dtTransacao = props.dtTransacao;
  }

  public static convertMap(maps: TransacaoProps[]) {
    return maps.map(m => new Transacao(m));
  }
}