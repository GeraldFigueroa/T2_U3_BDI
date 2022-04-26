USE Northwind;

/*
    Cree un trigger que se active cuando se inserte o actualice un registro de la tabla Territories recuerde tomar el registro 
    actual desde la tabla inserted y concatene al nombre del Territorio (TerritoryDescription) el prefijo “_try” al final del 
    mismo.
        Ejecute el siguiente comando para cambiar el tipo de dato del campo ya que es el que tiene produce un error  

*/
    ALTER TABLE territories ALTER column TerritoryDescription VARCHAR(100)

    CREATE TRIGGER tg_ChangeTerritoryDescription ON territories
    AFTER UPDATE, INSERT
    AS
        (
            UPDATE territories SET TerritoryDescription = CONCAT(TerritoryDescription, '_try') 
            FROM inserted i 
            WHERE i.TerritoryID = territories.TerritoryID
        )
    ;

/*
    Cree un trigger para la tabla CustomerDemographics que se active cuando se inserte o actualice un registro y calcule el 
    campo CustomerDesc multiplicando el valor proveído en el insert *  0.25 y sumando 150
*/

    CREATE TRIGGER tg_CalcCustomerDesc ON CustomerDemographics
    AFTER UPDATE, INSERT
    AS
        (
            UPDATE CustomerDemographics SET CustomerDesc = ((i.CustomerDesc * 0.25) + 150)
            FROM inserted i
            WHERE i.CustomerTypeID = CustomerDemographics.CustomerTypeID
        )
    ;

/*
    Cree un trigger a la tabla CustomerDemographics que se active cuando un registro es eliminado y que muestre un mensaje 
    que diga “registro eliminado” y muestre un select de la tabla deleted.
*/
    CREATE TRIGGER tg_DeletedCalcCustomerDesc ON CustomerDemographics
    AFTER DELETE
    AS
        (
            PRINT 'Registro Eliminado';
            SELECT * FROM deleted;
        )
    ;