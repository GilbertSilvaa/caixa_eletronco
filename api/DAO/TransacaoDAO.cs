using api.DataBase;
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

        public Transacao? TransacaoComum(TransacaoDados _params)
        {
            string query = $"call SP_TRANSACAO_COMUM({_params.IdCliente}, {_params.Valor}, {(int)_params.Tipo})";
            SqlHelper sql = new(_connection);

            var rm_transacoes = sql.Query(query);
            var transacoes = Transacao.DataTableConvert(rm_transacoes);

            if (transacoes.Count == 0) return null;

            return transacoes[0];
        }

        public Transacao? Transferencia(TransferenciaDados _params) 
        {
            string query = $"call SP_TRANSFERENCIA({_params.IdCliente}, {_params.IdClienteTransf}, {_params.Valor})";
            SqlHelper sql = new(_connection);

            var rm_transacoes = sql.Query(query);
            var transacoes = Transacao.DataTableConvert(rm_transacoes);

            if (transacoes.Count == 0) return null;

            return transacoes[0];
        }
    }
}
