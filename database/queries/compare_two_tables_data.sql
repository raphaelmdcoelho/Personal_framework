SELECT 
    LOWER(CONVERT(VARCHAR(64), 
        HASHBYTES('SHA2_256', (
            SELECT
                CONCAT(
                    --Id is not a good comparison, because can be different across databases
                    ISNULL(UPPER(LTRIM(RTRIM(TextValue))), ''), '|',
                    CAST(NumericValue AS NVARCHAR(MAX))
                )
            FROM Database.Schema.Table1
            ORDER BY Id
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)')), 2)) AS TableHash;

        --FOR XML PATH(''), TYPE
        --It is used to concatenate the string representations of all the rows in your table into a single, continuous string, which is then passed to the HASHBYTES function to generate a hash value representing the entire table's data
        --FOR XML Clause: Converts the result set of a SELECT statement into XML format.
        --PATH(''): Specifies that each row in the result set should be transformed into an XML element with the name specified in the single quotes. By providing an empty string '', we eliminate the element tags, effectively concatenating the values.
        --The TYPE directive tells SQL Server to return the result as XML data type rather than as plain text. This is important because it preserves special characters (like <, >, &, etc.) in the data, ensuring that they are not misinterpreted as XML markup.