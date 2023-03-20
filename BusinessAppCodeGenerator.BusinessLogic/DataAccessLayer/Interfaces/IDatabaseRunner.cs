using BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer.Models;

namespace BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer.Interfaces
{
    public interface IDatabaseRunner
    {
        public Task RunScript();

        public MsSqlDbSchemaDomainModel ReadSchema(string databaseName);
    }
}