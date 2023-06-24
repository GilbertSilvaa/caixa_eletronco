using api.DAO;
using api.Models;
using api.Repositories;

namespace api.Decorators
{
    public class VerificarSaldoDecorator : ITransacaoRepository
    {
        private readonly ITransacaoRepository _transacaoRepository;

        public VerificarSaldoDecorator(ITransacaoRepository transacaoRepository)
        {
            _transacaoRepository = transacaoRepository;
        }

        public Transacao? TransacaoComum(TransacaoDados _params)
        {
            if (_params.Tipo == TipoTransacao.saque && !VerificaSaldo(_params.IdCliente, _params.Valor))
                return null;

            return _transacaoRepository.TransacaoComum(_params);
        }

        public Transacao? Transferencia(TransferenciaDados _params)
        {
            if (VerificaSaldo(_params.IdCliente, _params.Valor))
                return _transacaoRepository.Transferencia(_params);

            return null;
        }

        public bool VerificaSaldo(int idCliente, double valor)
        {
            ClienteDAO _clienteDAO = new();
            var saldoCliente = _clienteDAO.BuscaPorId(idCliente)?.Saldo ?? 0;

            if (saldoCliente >= valor) return true;

            return false;
        }
    }
}
