namespace BusinessAppCodeGenerator.BusinessLogic.DataAccessLayer.Models
{
    public class MsSqlDbSchemaDomainModel
    {
        public ICollection<TableDomainModel> Tables { get; set; }
    }

    public class TableDomainModel
    {
        public string Name { get; set; }

        public ICollection<ColumnDomainModel> Columns { get; set; }

        public ICollection<ForeignKeyDomainModel> ForeignKeys { get; set; }
    }

    public class ForeignKeyDomainModel
    {
        public string ColumnName { get; set; }
        public string ReferencedTable { get; set; }
        public string ReferencedColumn { get; set; }
    }

    public class ColumnDomainModel
    {
        public string Name { get; set; }
        public int OrdinalPosition { get; set; }
        public string DefaultValue { get; set; }
        public bool IsNullable { get; set; }
        public MsSqlDataType DataType { get; set; }
        public int CharacterMaximumLenght { get; set; }
        public int NumericPrecision { get; set; }        
    }

    public enum MsSqlDataType
    {
        Int,
        BigInt,
        Nvarchar,
        Bit,
        Date
    }
}