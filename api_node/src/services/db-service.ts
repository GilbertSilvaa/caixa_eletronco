import { Connection, Query } from 'mysql';

export class DBService {
  private readonly _conexao: Connection;

  constructor(conexao: Connection){
    this._conexao = conexao;
  }

  public async execute(consulta: string) {
    try {
      return new Promise((resolve, reject) => {
        this._conexao.query(consulta, (error, results, fields) => {
          if(error) return reject(error);
          resolve(results);
        });
      });
    }
    catch(error) {
      throw Error(`erro ao realizar consulta: ${error}`);
    }
  }
}