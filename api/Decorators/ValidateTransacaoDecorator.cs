using api.DAO;
using api.Factories;
using api.Models;
using api.Repositories;

namespace api.Decorators
{
    public class ValidateTransacaoDecorator : ITransacaoRepository
    {
        private readonly ITransacaoRepository _transacaoRepository;
        private readonly IClienteRepository _clienteRepository;

        public ValidateTransacaoDecorator(ITransacaoRepository transacaoRepository, IClienteRepository clienteRepository)
        {
            _transacaoRepository = transacaoRepository;
            _clienteRepository = clienteRepository;
        }

        public Transacao? ExecutarTransacao(TransacaoDados _params)
        {
            if (!VerificaSaldo(_params.IdCliente, _params.Valor))
                return null;

            return _transacaoRepository.ExecutarTransacao(_params);
        }

        public List<TransacaoRegistro>? BuscarTransacoesCliente(int idCliente)
        {
            return _transacaoRepository.BuscarTransacoesCliente(idCliente);
        }
          
        public bool VerificaSaldo(int idCliente, double valor)
        {
            var saldoCliente = _clienteRepository.BuscaPorId(idCliente)?.Saldo ?? 0;

            if (saldoCliente >= valor) return true;

            return false;
        }

        public static IEnumerable<TransacaoRegistro>? OrderTransacoesPorData(List<List<TransacaoRegistro>>? transacoes)
        {
            List<TransacaoRegistro> registros = new();
            transacoes?.ForEach(response =>
            {
                if (response != null)
                    registros.AddRange(response);
            });

            if (registros == null) return null;

            return registros.OrderBy(x => x.DtTransacao).Reverse();
        }
    }
}
