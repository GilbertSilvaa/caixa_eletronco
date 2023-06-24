using api.DAO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ContaController : ControllerBase
    {
        private static readonly List<string> Summaries = new();

        public ContaController()
        {
            Summaries.Add("teste-1");
            Summaries.Add("teste-2");
            Summaries.Add("teste-3");
        }

        [HttpGet(Name = "GetSaldo")]
        public List<Teste> Get()
        {
            ClienteDAO clienteDAO = new();
            clienteDAO.BuscaById(3);

            List<Teste> testes = new();

            foreach (string summ in Summaries)
            {
                testes.Add(new Teste { Id = 9, Name = summ });
            }

            return testes;
        }

        [Route("teste")]
        [HttpGet]
        public List<Teste> GetTeste()
        {
            List<Teste> testes = new();

            foreach (string summ in Summaries)
            {
                testes.Add(new Teste { Id = 3, Name = summ });
            }

            return testes;
        }
    }

    public class Teste
    {
        public int Id { get; set; }
        public string? Name { get; set; }
    }
}
