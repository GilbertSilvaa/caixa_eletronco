export interface ClienteProps {
  id?: number;
  nome: string; 
  conta: number; 
  saldo: number;
}

export class Cliente {
  id?: number;
  nome: string; 
  conta: number; 
  saldo: number;

  constructor(props: ClienteProps) {
    this.id = props.id;
    this.nome = props.nome;
    this.conta = props.conta;
    this.saldo = props.saldo;
  }

  public static convertMap(maps: ClienteProps[]) {
    return maps.map(m => new Cliente(m));
  }
}