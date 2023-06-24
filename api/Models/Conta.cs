using MySql.Data.MySqlClient;

namespace api.Models
{
    public class Conta
    {
        public int? Id { get; set; }
        public string? Nome { get; set; }

        public static List<Conta> DataReaderConvert(MySqlDataReader dr)
        {
            List<Conta> contas = new();

            while(dr.Read())
            {
                Conta newConta = new()
                {
                    Id = Int32.Parse(dr["id"].ToString()!),
                    Nome = dr["nome"].ToString()
                };
                contas.Add(newConta);
            }

            return contas;
        }
    }
}
