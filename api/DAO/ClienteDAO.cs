using api.DataBase;
using api.Helpers;
using api.Models;
using api.Repositories;
using MySql.Data.MySqlClient;

namespace api.DAO
{
    public class ClienteDAO : IClienteRepository
    {
        private readonly MySqlConnection _connection;

        public ClienteDAO()
        {
            _connection = Connection.GetInstance().GetConnection;
        }

        public void Cadastrar(Cliente cliente)
        {
            string saldoFormat = cliente.Saldo.ToString().Replace(",", ".");
            string query = $"insert into Cliente (nome, conta, senha, saldo) values ('{cliente.Nome}', {cliente.Conta}, '{cliente.Senha}', {saldoFormat})";
            SqlHelper sql = new(_connection);
            sql.Execute(query);
        }

        public Cliente? BuscaPorConta(long conta)
        {
            string query = $"select * from Cliente where conta={conta}";
            SqlHelper sql = new(_connection);

            var tb_clientes = sql.Query(query);
            var clientes = Cliente.DataTableConvert(tb_clientes);

            if (clientes.Count == 0) return null;

            return clientes[0];
        }

        public Cliente? BuscaPorId(int id)
        {
            string query = $"select * from Cliente where id={id}";
            SqlHelper sql = new(_connection);

            var tb_clientes = sql.Query(query);
            var clientes = Cliente.DataTableConvert(tb_clientes);

            if (clientes.Count == 0) return null;

            return clientes[0];
        }

        public Cliente? Login(LoginDados _params) 
        {
            string query = $"select * from Cliente where conta={_params.Conta} and senha='{_params.Senha}'";
            SqlHelper sql = new(_connection);

            var tb_clientes = sql.Query(query);
            var clientes = Cliente.DataTableConvert(tb_clientes);

            if (clientes.Count == 0) return null;

            return clientes[0];
        }
    }
}
