using NUnit.Framework;
using System.Threading.Tasks;

namespace BusinessAppCodeGenerator.BusinessLogic.UnitTests
{
    public class SqlScriptDecomposerTests
    {
        SqlScriptDecomposerTests sut = new SqlScriptDecomposerTests();

        [SetUp]
        public void Setup()
        {
        }

        [TestCase("sql\\Scenario1.sql")]
        public async Task TestScriptDecomposition(string sqlScriptPath)
        {
            await sut.TestScriptDecomposition(sqlScriptPath);

            Assert.Pass();
        }
    }
}