using api.DAO;
using api.Factories;
using api.Models;
using api.Repositories;

namespace api.Decorators
{
    public class VerificarSaldoDecorator : ITransacaoRepository
    {
        private readonly ITransacaoRepository _transacaoRepository;
        private readonly IClienteRepository _clienteRepository;

        public VerificarSaldoDecorator(ITransacaoRepository transacaoRepository, IClienteRepository clienteRepository)
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
    }
}
