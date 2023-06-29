import { Cliente } from '../models/cliente-model';

export interface LoginProps {
  conta: number;
  senha: string;
}

export interface IClinteRepository {
  buscarPorId(idCliente: number): Promise<Cliente|null>;
  buscarPorConta(conta: number): Promise<Cliente|null>;
  login(dados: LoginProps): Promise<Cliente|null>;
}