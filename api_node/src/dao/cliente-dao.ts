import { Connection } from 'mysql';
import { Conexao } from '../database/conexao';
import { DBService } from '../services/db-service';
import { Cliente, ClienteProps } from '../models/cliente-model';
import { IClinteRepository, LoginProps } from '../repositories/cliente-repository';

export class ClienteDAO implements IClinteRepository {
  private readonly _conexao: Connection;

  constructor() {
    this._conexao = Conexao.getInstance().conexao();
  }

  async login({ conta, senha }: LoginProps) {
    const consulta = `select * from Cliente where conta=${conta} and senha=${senha}`;
    const dbService = new DBService(this._conexao);
    const resposta = await dbService.execute(consulta) as ClienteProps[];
    
    if(!resposta.length) return null;
    
    return Cliente.convertMap(resposta)[0];
  }

  async buscarPorId(idCliente: number) {
    const consulta = `select * from Cliente where id=${idCliente}`;
    const dbService = new DBService(this._conexao);
    const resposta = await dbService.execute(consulta) as ClienteProps[];
    
    if(!resposta.length) return null;
    
    return Cliente.convertMap(resposta)[0];
  }

  async buscarPorConta(conta: number) {
    const consulta = `select * from Cliente where conta=${conta}`;
    const dbService = new DBService(this._conexao);
    const resposta = await dbService.execute(consulta) as ClienteProps[];
    
    if(!resposta.length) return null;
    
    return Cliente.convertMap(resposta)[0];
  }
}