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
        private readonly IClienteRepository _clienteDAO;

        public TransacaoController()
        {
            _clienteDAO = new ClienteDAO();
        }

        [Route("deposito")]
        [HttpPost]
        public ActionResult<Transacao> Depositar([FromForm]int idCliente, [FromForm]double valor)
        {
            TransacaoDados dados = new() 
            {
                IdCliente = idCliente,
                Valor = valor,
            };

            var _transacaoDAO = new TransacaoDAO(TipoTransacao.deposito);
            var transacaoResponse = _transacaoDAO.ExecutarTransacao(dados);

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
            };

            var _transacaoDAO = new TransacaoDAO(TipoTransacao.saque);
            var _transacaoDecorator = new VerificarSaldoDecorator(_transacaoDAO, _clienteDAO);
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
            };

            var _transacaoDAO = new TransacaoDAO(TipoTransacao.tranferencia);
            var _transacaoDecorator = new VerificarSaldoDecorator(_transacaoDAO, _clienteDAO);
            var transacaoResponse = _transacaoDecorator.ExecutarTransacao(dados);

            if (transacaoResponse == null) return BadRequest();

            return Ok(transacaoResponse);
        }

        [Route("buscar")]
        [HttpGet]
        public ActionResult<List<TransacaoRegistro>> BuscarTransacoes([FromQuery] int idCliente)
        {
            var _transacaoTransf = new TransacaoDAO(TipoTransacao.tranferencia);
            var _transacaoSaque = new TransacaoDAO(TipoTransacao.saque);
            var _transacaoDeposito = new TransacaoDAO(TipoTransacao.deposito);

            List<List<TransacaoRegistro>?> responses = new()
            { 
                _transacaoTransf.BuscarTransacoesCliente(idCliente),
                _transacaoSaque.BuscarTransacoesCliente(idCliente),
                _transacaoDeposito.BuscarTransacoesCliente(idCliente)
            };
            

            List<TransacaoRegistro> registros = new();
            responses.ForEach(response =>
            {
                if (response != null)
                    registros.AddRange(response);
            });

            if (registros == null) return BadRequest();

            return Ok(registros);
        }
    }
}
