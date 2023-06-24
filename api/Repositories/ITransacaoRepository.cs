using api.Models;

namespace api.Repositories
{
    public class TransacaoDados
    {
        public int IdCliente { get; set; }
        public int? IdClienteTransf { get; set; }
        public double Valor { get; set; }
    }
    public class TransacaoRegistro : Transacao
    {
        public string? ClienteTransf { get; set; }
    }

    public interface ITransacaoRepository
    {
        Transacao? ExecutarTransacao(TransacaoDados dados);
        List<TransacaoRegistro>? BuscarTransacoesCliente(int idCliente);
    }
}
