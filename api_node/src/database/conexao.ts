import mysql, { Connection } from 'mysql';

export class Conexao {
  private readonly _conexao: Connection;
  private static _instance: Conexao;

  private constructor() {
    this._conexao = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      password: 'ifsp',
      database: 'caixa'
    });
  }

  public conexao(): Connection {
    return this._conexao;
  }

  public static getInstance(): Conexao {
    this._instance ??= new Conexao();
    return this._instance;
  }
}