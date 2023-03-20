using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer.Interfaces
{
    public interface IDbConnectionProvider
    {
        DbConnection GetConnection(string databaseName);
    }
}
