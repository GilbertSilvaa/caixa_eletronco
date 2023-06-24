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

        public TransacaoDAO()
        {
            _connection = Connection.GetInstance().GetConnection;
        }

        public Transacao? ExecutarTransacao(TransacaoDados _params)
        {
            var transacao = TransacaoFactory.CriarTransacao(_params.Tipo, _connection);
            return transacao.ExecutarTransacao(_params);
        }
    }
}
