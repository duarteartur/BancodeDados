CREATE or replace FUNCTION MascaraCPF() returns text as $$ --formata o CPF corretamente para o formato 000.000.000-00
DECLARE
result RECORD;
var_saida text;

BEGIN

RAISE INFO 'CNPJ';
var_saida := 'Finalizado';

FOR result IN select nr_controle,substr(nr_doc_cpf, 1, 3) || '.' ||
       substr(nr_doc_cpf, 4, 3) || '.' ||
       substr(nr_doc_cpf, 7, 3) || '-' ||
       substr(nr_doc_cpf, 10) as formatado_cpf from pessoa_doc where length(nr_doc_cpf) = 11
LOOP

update pessoa_doc set nr_doc_cpf = result.formatado_cpf where nr_controle = result.nr_controle;


END LOOP;
return var_saida;
END;
$$ language 'plpgsql';
