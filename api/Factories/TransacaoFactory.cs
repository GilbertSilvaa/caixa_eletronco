using api.Helpers;
using api.Models;
using api.Repositories;
using MySql.Data.MySqlClient;

namespace api.Factories
{
    public static class TransacaoFactory
    {
       public static ITransacaoRepository CriarTransacao(TipoTransacao tipo, MySqlConnection conn)
       {
            return tipo switch
            {
                TipoTransacao.saque => new Saque(conn),
                TipoTransacao.deposito => new Deposito(conn),
                TipoTransacao.tranferencia => new Transferencia(conn),
                _ => throw new ArgumentException("Tipo de transação inválido"),
            };
        }
    }

    public class Saque : ITransacaoRepository
    {
        private readonly MySqlConnection _connection;

        public Saque(MySqlConnection conn)
        {
            _connection = conn;
        }

        public Transacao? ExecutarTransacao(TransacaoDados _params)
        {
            string query = $"call SP_TRANSACAO_COMUM({_params.IdCliente}, {_params.Valor}, 1)";
            SqlHelper sql = new(_connection);

            var rm_transacoes = sql.Query(query);
            var transacoes = Transacao.DataTableConvert(rm_transacoes);

            if (transacoes.Count == 0) return null;

            return transacoes[0];
        }
    }

    public class Deposito : ITransacaoRepository
    {
        private readonly MySqlConnection _connection;

        public Deposito(MySqlConnection conn)
        {
            _connection = conn;
        }

        public Transacao? ExecutarTransacao(TransacaoDados _params)
        {
            string query = $"call SP_TRANSACAO_COMUM({_params.IdCliente}, {_params.Valor}, 2)";
            SqlHelper sql = new(_connection);

            var rm_transacoes = sql.Query(query);
            var transacoes = Transacao.DataTableConvert(rm_transacoes);

            if (transacoes.Count == 0) return null;

            return transacoes[0];
        }
    }

    public class Transferencia : ITransacaoRepository
    {
        private readonly MySqlConnection _connection;

        public Transferencia(MySqlConnection conn)
        {
            _connection = conn;
        }

        public Transacao? ExecutarTransacao(TransacaoDados _params)
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
