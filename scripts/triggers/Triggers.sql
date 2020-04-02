use museuphp;

DROP TRIGGER IF EXISTS `museuphp`.`trigger_RondaExtra_update`;
DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_RondaExtra_update AFTER UPDATE ON `rondaextra` FOR EACH ROW
BEGIN
INSERT INTO log_rondaextra(QuemInseriu,DataInsercao, EmailNovo, DataHoraInicioNova, DataHoraFimNova)
VALUES (current_user(), current_time() , OLD.email, OLD.DataHoraInicio, NEW.DataHoraFim);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `museuphp`.`trigger_sistema_update`;

DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_sistema_update AFTER UPDATE ON `sistema` FOR EACH ROW
BEGIN
DECLARE LimiteTemperaturaAInserir DECIMAL(6,2);
DECLARE LimiteHumidadeAInserir DECIMAL(6,2);
DECLARE LimiteLuminosidadeAInserir DECIMAL(6,2);

IF (NEW.LimiteTemperatura != OLD.LimiteTemperatura) THEN
SET LimiteTemperaturaAInserir = NEW.LimiteTemperatura;
ELSE 
SET LimiteTemperaturaAInserir = OLD.LimiteTemperatura;
END IF;

IF (NEW.LimiteHumidade != OLD.LimiteHumidade) THEN
SET LimiteHumidadeAInserir = NEW.LimiteHumidade;
ELSE 
SET LimiteHumidadeAInserir = OLD.LimiteHumidade;
END IF;

IF (NEW.LimiteLuminosidade != OLD.LimiteLuminosidade) THEN
SET LimiteLuminosidadeAInserir = NEW.LimiteLuminosidade;
ELSE 
SET LimiteLuminosidadeAInserir = OLD.LimiteLuminosidade;
END IF;

INSERT INTO log_updatesistema(QuemAlterou,DataAlteracao,LimiteTemperaturaAntigo,LimiteTemperaturaNovo,LimiteHumidadeAntigo,LimiteHumidadeNovo,LimiteLuminosidadeAntigo,LimiteLuminosidadeNovo)
VALUES (current_user, current_time, OLD.LimiteTemperatura,LimiteTemperaturaAInserir, OLD.LimiteHumidade, LimiteHumidadeAInserir, OLD.LimiteLuminosidade,LimiteLuminosidadeAInserir);

END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `museuphp`.`trigger_diasemana_insert`;

DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_diasemana_insert AFTER INSERT ON `diasemana` FOR EACH ROW
BEGIN
INSERT INTO log_diasemana(QuemAlterou, TipoOperacao,DiaSemanaAntigo, DiaSemanaNovo, HoraRondaInicioAntiga, HoraRondaInicioNova, HoraRondaFimAntiga, HoraRondaFimNova)
VALUES(current_user, "Insert", NULL, NEW.DiaSemana, NULL, NEW.HoraRondaInicio, NULL, NEW.HoraRondaFim);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `museuphp`.`trigger_diasemana_update`;

DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_diasemana_update AFTER UPDATE ON `diasemana` FOR EACH ROW
BEGIN
DECLARE DiaSemanaAInserir VARCHAR(20);
DECLARE HoraRondaInicioAInserir TIME;
DECLARE HoraRondaFimAInserir TIME;

IF (NEW.DiaSemana != OLD.DiaSemana) THEN
SET DiaSemanaAInserir = NEW.DiaSemana;
ELSE 
SET DiaSemanaAInserir = OLD.DiaSemana;
END IF;

IF (NEW.HoraRondaInicio != OLD.HoraRondaInicio) THEN
SET HoraRondaInicioAInserir = NEW.HoraRondaInicio;
ELSE 
SET HoraRondaInicioAInserir = OLD.HoraRondaInicio;
END IF;

IF (NEW.HoraRondaFim != OLD.HoraRondaFim) THEN
SET HoraRondaFimAInserir = NEW.HoraRondaFim;
ELSE 
SET HoraRondaFimAInserir = OLD.HoraRondaFim;
END IF;

INSERT INTO log_diasemana(QuemAlterou,TipoOperacao,DiaSemanaAntigo,DiaSemanaNovo,HoraRondaInicioAntiga,HoraRondaInicioNova, HoraRondaFimAntiga, HoraRondaFimNova)
VALUES (current_user(), 'Update',  OLD.DiaSemana, DiaSemanaAInserir, OLD.HoraRondaInicio, HoraRondaInicioAInserir, OLD.HoraRondaFim,HoraRondaFimAInserir);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `museuphp`.`trigger_diasemana_delete`;

DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_diasemana_delete AFTER DELETE ON `diasemana` FOR EACH ROW
BEGIN
INSERT INTO log_diasemana(QuemAlterou,TipoOperacao,DiaSemanaAntigo,DiaSemanaNovo,HoraRondaInicioAntiga,HoraRondaInicioNova, HoraRondaFimAntiga, HoraRondaFimNova)
VALUES(current_user, "Delete", OLD.DiaSemana, NULL, OLD.HoraRondaInicio, NULL, OLD.HoraRondaFim, NULL);
END$$
DELIMITER ;

DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_utilizador_insert AFTER INSERT ON `utilizador` FOR EACH ROW
BEGIN
INSERT INTO log_utilizador(QuemAlterou, TipoOperacao, DataAlteracao,EmailAntigo,EmailNovo,NomeAntigo,NomeNovo, MoradaAntiga, MoradaNova) 
VALUES(current_user, "Insert", current_time,NULL, NEW.email, NULL, NEW.nome, NULL, NEW.Morada);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `museuphp`.`trigger_utilizador_update`;

DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_utilizador_update after UPDATE ON `utilizador` FOR EACH ROW 
BEGIN
DECLARE EmailUtilizadorAInserir VARCHAR(100);
DECLARE NomeUtilizadorAInserir VARCHAR(100);
DECLARE MoradaAInserir VARCHAR(100);

IF (NEW.email != OLD.email) THEN
SET EmailUtilizadorAInserir = NEW.email;
ELSE 
SET EmailUtilizadorAInserir = OLD.email;
END IF;

IF (NEW.nome != OLD.nome) THEN
SET NomeUtilizadorAInserir = NEW.nome;
ELSE 
SET NomeUtilizadorAInserir = OLD.nome;
END IF;

IF (NEW.Morada != OLD.Morada) THEN
SET MoradaAInserir = NEW.Morada;
ELSE 
SET MoradaAInserir = OLD.Morada;
END IF;

INSERT INTO log_utilizador(QuemAlterou, TipoOperacao, DataAlteracao,EmailAntigo,EmailNovo,NomeAntigo,NomeNovo, MoradaAntiga, MoradaNova) 
VALUES(current_user, "Update", current_time, OLD.email, EmailUtilizadorAInserir, OLD.nome, NomeUtilizadorAInserir, OLD.Morada, MoradaAInserir);

END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `museuphp`.`trigger_utilizador_delete`;

DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_utilizador_delete AFTER DELETE ON `utilizador` FOR EACH ROW
BEGIN
INSERT INTO log_utilizador(QuemAlterou, TipoOperacao, DataAlteracao,EmailAntigo,EmailNovo,NomeAntigo,NomeNovo, MoradaAntiga, MoradaNova) 
VALUES(current_user, "Delete", current_time, OLD.email, NULL, OLD.nome, NULL, OLD.Morada, NULL);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `museuphp`.`trigger_rondaplaneada_insert`;

DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_rondaplaneada_insert AFTER INSERT ON `rondaplaneada` FOR EACH ROW
BEGIN

INSERT INTO log_rondaplaneada(QuemAlterou, TipoOperacao, DataALteracao,EmailAntigo,EmailNovo,DiaSemanaAntigo, DiaSemanaNovo, HoraRondaInicioAntiga, HoraRondaInicioNova, HoraRondaFimAntiga, HoraRondaFimNova)
VALUES(current_user, "Insert", current_time,NULL, NEW.email, NULL, NEW.DiaSemana, NULL, NEW.HoraRondaInicio, NULL, NEW.HoraRondaFim);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `museuphp`.`trigger_rondaplaneada_update`;

DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_rondaplaneada_update AFTER UPDATE ON `rondaplaneada` FOR EACH ROW
BEGIN
DECLARE EmailAInserir VARCHAR(100);
DECLARE DiaSemanaAInserir VARCHAR(20);
DECLARE HoraRondaInicioAInserir TIME;
DECLARE HoraRondaFimAInserir TIME;

IF (NEW.email != OLD.email) THEN
SET EmailAInserir = NEW.email;
ELSE 
SET EmailAInserir = OLD.email;
END IF;

IF (NEW.DiaSemana != OLD.DiaSemana) THEN
SET DiaSemanaAInserir = NEW.DiaSemana;
ELSE 
SET DiaSemanaAInserir = OLD.DiaSemana;
END IF;

IF (NEW.HoraRondaInicio != OLD.HoraRondaInicio) THEN
SET HoraRondaInicioAInserir = NEW.HoraRondaInicio;
ELSE 
SET HoraRondaInicioAInserir = OLD.HoraRondaInicio;
END IF;

IF (NEW.HoraRondaFim != OLD.HoraRondaFim) THEN
SET HoraRondaFimAInserir = NEW.HoraRondaFim;
ELSE 
SET HoraRondaFimAInserir = OLD.HoraRondaFim;
END IF;

INSERT INTO log_rondaplaneada(QuemAlterou,TipoOperacao,DataAlteracao,EmailAntigo,EmailNovo,DiaSemanaAntigo,DiaSemanaNovo,HoraRondaInicioAntiga,HoraRondaInicioNova, HoraRondaFimAntiga, HoraRondaFimNova)
VALUES (current_user(), 'Update', current_time() ,OLD.email, EmailAInserir, OLD.DiaSemana, DiaSemanaAInserir, OLD.HoraRondaInicio, HoraRondaInicioAInserir, OLD.HoraRondaFim,HoraRondaFimAInserir);
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `museuphp`.`trigger_rondaplaneada_delete`;

DELIMITER $$
USE `museuphp`$$
CREATE DEFINER=`root`@`localhost` TRIGGER trigger_rondaplaneada_delete AFTER DELETE ON `rondaplaneada` FOR EACH ROW
BEGIN
INSERT INTO log_rondaplaneada(QuemAlterou,TipoOperacao,DataAlteracao,EmailAntigo,EmailNovo,DiaSemanaAntigo,DiaSemanaNovo,HoraRondaInicioAntiga,HoraRondaInicioNova, HoraRondaFimAntiga, HoraRondaFimNova)
VALUES(current_user, "Delete", current_time, OLD.email, NULL, OLD.DiaSemana, NULL, OLD.HoraRondaInicio, NULL, OLD.HoraRondaFim, NULL);

END$$
DELIMITER ;
