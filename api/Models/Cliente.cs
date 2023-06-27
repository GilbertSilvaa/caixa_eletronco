using MySql.Data.MySqlClient;
using System.Data;

namespace api.Models
{
    public class Cliente
    {
        public int? Id { get; set; }
        public string Nome { get; set; } = "";
        public long Conta { get; set; }
        public string Senha { get; set; } = "";
        public double Saldo { get; set;}

        public static List<Cliente> DataTableConvert(DataTable tb)
        {
            List<Cliente> clientes = 
            (from row in tb.AsEnumerable()
            select new Cliente()
                {
                    Id = int.Parse(row["id"].ToString()!),
                    Nome = row["nome"].ToString()!,
                    Conta = long.Parse(row["conta"].ToString()!),
                    Senha = row["senha"].ToString()!,
                    Saldo = double.Parse(row["saldo"].ToString()!)
                }
            ).ToList();

            return clientes;
        }
    }
}
