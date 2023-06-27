using api.Helpers;
using api.Models;
using api.Repositories;
using MySql.Data.MySqlClient;

namespace api.Factories
{
    public static class TransacaoFactory
    {
        public static ITransacaoRepository CriarTransacao(TipoTransacao tipo, MySqlConnection conn, IClienteRepository _cli)
        {
            return tipo switch
            {
                TipoTransacao.tranferencia => new Transferencia(conn, _cli),
                _ => new TransacaoPadrao(conn, tipo),
            };
        }
    }

    public class TransacaoPadrao : ITransacaoRepository
    {
        private readonly MySqlConnection _connection;
        private readonly TipoTransacao _tipoTransacao;

        public TransacaoPadrao(MySqlConnection conn, TipoTransacao tipo)
        {
            _connection = conn;
            _tipoTransacao= tipo;
        }

        public Transacao? ExecutarTransacao(TransacaoDados _params)
        {
            var valorFormat = _params.Valor.ToString().Replace(",", ".");
            string query = $"call SP_TRANSACAO_COMUM({_params.IdCliente}, {valorFormat}, {(int)_tipoTransacao})";
            SqlHelper sql = new(_connection);

            var rm_transacoes = sql.Query(query);
            var transacoes = Transacao.DataTableConvert(rm_transacoes);

            if (transacoes.Count == 0) return null;

            return transacoes[0];
        }

        public List<TransacaoRegistro>? BuscarTransacoesCliente(int idCliente)
        {
            string query = $"select * from Transacao where cliente_id={idCliente} and tipo={(int)_tipoTransacao}";
            SqlHelper sql = new(_connection);

            var rm_transacoes = sql.Query(query);
            var transacoes = Transacao.DataTableConvert(rm_transacoes);

            if (transacoes.Count == 0) return null;

            List<TransacaoRegistro> registros = 
            (from transacao in transacoes 
                select new TransacaoRegistro() { 
                    Id = transacao.Id,
                    IdCliente = transacao.IdCliente,
                    DtTransacao = transacao.DtTransacao,
                    Tipo = transacao.Tipo,
                    Valor = transacao.Valor
                }
            ).ToList();

            return registros;
        }
    }

    public class Transferencia : ITransacaoRepository
    {
        private readonly MySqlConnection _connection;
        private readonly IClienteRepository _clienteRepository;

        public Transferencia(MySqlConnection conn, IClienteRepository clienteRepository)
        {
            _connection = conn;
            _clienteRepository = clienteRepository;
        }

        public Transacao? ExecutarTransacao(TransacaoDados _params)
        {
            var valorFormat = _params.Valor.ToString().Replace(",", ".");
            string query = $"call SP_TRANSFERENCIA({_params.IdCliente}, {_params.IdClienteTransf}, {valorFormat})";
            SqlHelper sql = new(_connection);

            var rm_transacoes = sql.Query(query);
            var transacoes = Transacao.DataTableConvert(rm_transacoes);

            if (transacoes.Count == 0) return null;

            return transacoes[0];
        }

        public List<TransacaoRegistro>? BuscarTransacoesCliente(int idCliente)
        {
            string query = $"call SP_BUSCAR_TRANSFERENCIAS({idCliente})";

            SqlHelper sql = new(_connection);

            var rm_transacoes = sql.Query(query);
            var transacoes = Transacao.DataTableConvert(rm_transacoes);

            if (transacoes.Count == 0) return null;

            List<TransacaoRegistro> registros =
            (from transacao in transacoes
                select new TransacaoRegistro()
                {
                    Id = transacao.Id,
                    IdCliente = transacao.IdCliente,
                    DtTransacao = transacao.DtTransacao,
                    Tipo = transacao.Tipo,
                    Valor = transacao.Valor,
                    ClienteTransf = _clienteRepository.BuscaPorId(transacao.IdCliente)?.Nome
                }
            ).ToList();

            return registros; 
        }
    }
}
