using api.Models;

namespace api.Repositories
{
    public class LoginDados
    {
        public long Conta { get; set; }
        public string? Senha { get; set; }
    }

    public interface IClienteRepository
    {
        void Cadastrar(Cliente cliente);
        Cliente? BuscaPorConta(long conta);
        Cliente? BuscaPorId(int id);
        Cliente? Login(LoginDados dados);
    }
}
