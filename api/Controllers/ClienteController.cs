using api.DAO;
using api.Models;
using api.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json.Nodes;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClienteController : ControllerBase
    {
        private readonly ClienteDAO _clienteDAO;

        public ClienteController()
        {
            _clienteDAO = new ClienteDAO();
        }

        [Route("cadastro")]
        [HttpPost]
        public void Cadastrar([FromBody] Cliente cliente)
        {
            _clienteDAO.Cadastrar(cliente);
        }

        [Route("login")]
        [HttpPost]
        public ActionResult<Cliente> Login([FromBody] LoginDados _params)
        {
            var cliente = _clienteDAO.Login(_params);

            if (cliente == null) return BadRequest("email ou senha incorreta");

            return Ok(cliente);
        }

        [Route("buscarPorConta")]
        [HttpGet]
        public ActionResult<Cliente> BuscaPorConta([FromQuery] long conta)
        {
            var cliente = _clienteDAO.BuscaPorConta(conta);

            if (cliente == null) return BadRequest("conta inválida");

            return Ok(cliente);
        }
    }
}
