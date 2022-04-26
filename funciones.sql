USE Northwind;

/*
    Construya una función que reciba como parámetro el año de contratación  de un empleado (HireDate) de la tabla employees 
    y devuelva una tabla con todos los registros asociados.
*/
    CREATE FUNCTION f_EmployeesByYear(@YEAR INT)
    RETURNs TABLE
    AS
        RETURN (
            SELECT * FROM employees WHERE YEAR(HireDate) = @YEAR;
        )
    ;


/*
    Cree una función que reciba como parámetro el id de la tabla producto (products) y retorne el precio (UnitPrice) 
    aplicando el 10% de descuento.
*/
    CREATE FUNCTION ProductDiscount (@ProductID)
    RETURNs MONEY
    AS
        RETURN (SELECT CONVERT(MONEY, (UnitPrice - UnitPrice*0.1)) FROM products WHERE products.ProductID = @ProductID);
    ;

/*
    Cree una función que reciba como parámetro el OrderId y muestre información de la orden (Order) y de su detalle 
    (Order Details) mostrando ProductName, UnitPrice y Quantitiy, OrderDate, CustomerID.
*/
    CREATE FUNCTION OrderInfo (@OrderID INT)
    RETURNS TABLE
    AS
        RETURN (
            SELECT product.ProductName, [Order Details].UnitPrice, [Order Details].Quantity, Orders.OrderDate, Orders.CustomerID
            FROM product, [Order Details], Orders
            WHERE product.ProductID = [Order Details].ProductID AND Orders.OrderID = [Order Details].OrderID AND [Order Details].OrderID = @OrderID 
        );
    ;

/*
    Construya una función que reciba la fecha de nacimiento (BirthDate) de un empleado (Employees)  y retorne el 
    nombre del mes en el que nació el empleado considere el uso de la sentencia case.
*/
    CREATE FUNCTION MonthByBirthDate (@BirthDate DATETIME)
    RETURNS VARCHAR(15)
    AS
        DECLARE @MONTH INT; 
        @MONTH = MONTH(@BirthDate);

        DECLARE @MONTHNAME VARCHAR(15);
        SET @MONTHNAME = (
            CASE @MONTH
                WHEN @MONTH = 1 THEN 'Enero'
                WHEN @MONTH = 2 THEN 'Febrero'
                WHEN @MONTH = 3 THEN 'Marzo'
                WHEN @MONTH = 4 THEN 'Abril'
                WHEN @MONTH = 5 THEN 'Mayo'
                WHEN @MONTH = 6 THEN 'Junio'
                WHEN @MONTH = 7 THEN 'Julio'
                WHEN @MONTH = 8 THEN 'Agosto'
                WHEN @MONTH = 9 THEN 'Septiembre'
                WHEN @MONTH = 10 THEN 'Ocubre'
                WHEN @MONTH = 11 THEN 'Noviembre'
                WHEN @MONTH = 11 THEN 'Diciembre'
            END;
        RETURN (@MONTHNAME);
        )

    ;

/*
    Construya una función que reciba el código de un cliente y retorne todos los pedidos (Orders) ordenados por fecha.
*/
    CREATE FUNCTION OrdersByCustomer(@CustomerID nchar(5))
    RETURNS TABLE
    AS
        RETURN (
            SELECT * FROM Orders WHERE Orders.CustomerID = @CustomerID ORDER BY Orders.OrderDate DESC;
        );
    ;