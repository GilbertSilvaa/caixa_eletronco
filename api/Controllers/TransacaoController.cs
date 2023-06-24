using api.DAO;
using api.Decorators;
using api.Models;
using api.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MySqlX.XDevAPI;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TransacaoController : ControllerBase
    {
        private readonly ITransacaoRepository _transacaoDAO;
        private readonly ITransacaoRepository _transacaoDecorator;

        public TransacaoController()
        {
            _transacaoDAO = new TransacaoDAO();
            _transacaoDecorator = new VerificarSaldoDecorator(_transacaoDAO);
        }

        [Route("deposito")]
        [HttpPost]
        public ActionResult<Transacao> Depositar([FromForm]int idCliente, [FromForm]double valor)
        {
            TransacaoDados dados = new() 
            {
                IdCliente = idCliente,
                Valor = valor,
                Tipo = TipoTransacao.deposito
            };

            var transacaoResponse = _transacaoDecorator.ExecutarTransacao(dados);

            if (transacaoResponse == null) return BadRequest(); 

            return Ok(transacaoResponse);
        }

        [Route("saque")]
        [HttpPost]
        public ActionResult<Transacao> Sacar([FromForm] int idCliente, [FromForm] double valor)
        {
            TransacaoDados dados = new()
            {
                IdCliente = idCliente,
                Valor = valor,
                Tipo = TipoTransacao.saque
            };

            var transacaoResponse = _transacaoDecorator.ExecutarTransacao(dados);

            if (transacaoResponse == null) return BadRequest();

            return Ok(transacaoResponse);
        }

        [Route("transferencia")]
        [HttpPost]
        public ActionResult<Transacao> Transferir([FromForm] int idCliente, [FromForm] int idClienteTransf, [FromForm] double valor)
        {
            TransacaoDados dados = new()
            {
                IdCliente = idCliente,
                IdClienteTransf = idClienteTransf,
                Valor = valor,
                Tipo = TipoTransacao.tranferencia
            };

            var transacaoResponse = _transacaoDecorator.ExecutarTransacao(dados);

            if (transacaoResponse == null) return BadRequest();

            return Ok(transacaoResponse);
        }
    }
}
