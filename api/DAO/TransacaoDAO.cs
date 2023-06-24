using api.DataBase;
using api.Factories;
using api.Helpers;
using api.Models;
using api.Repositories;
using MySql.Data.MySqlClient;

namespace api.DAO
{
    public class TransacaoDAO : ITransacaoRepository
    {
        private readonly MySqlConnection _connection;
        private readonly IClienteRepository _clienteRepository;
        private readonly ITransacaoRepository _transacaoFactory;

        public TransacaoDAO(TipoTransacao tipo)
        {
            _connection = Connection.GetInstance().GetConnection;
            _clienteRepository = new ClienteDAO();
            _transacaoFactory = TransacaoFactory.CriarTransacao(tipo, _connection, _clienteRepository);
        }

        public Transacao? ExecutarTransacao(TransacaoDados _params)
        {
            return _transacaoFactory.ExecutarTransacao(_params);
        }

        public List<TransacaoRegistro>? BuscarTransacoesCliente(int idCliente)
        {
            return _transacaoFactory.BuscarTransacoesCliente(idCliente); 
        }
    }
}
