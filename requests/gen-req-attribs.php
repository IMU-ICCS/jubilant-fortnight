<?php

for ($i=0;$i<10;$i++) {
    for ($j=0;$j<10;$j++) {
        for ($k=0;$k<10;$k++) {
	        $id = sprintf("%02d%02d%02d", $i, $j, $k);
?>
		<Attribute IncludeInResult="false" AttributeId="urn:my-test:attributes:attr-req-<?=$id?>" DataType="http://www.w3.org/2001/XMLSchema#string">
			<AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">attr-db-<?=$id?></AttributeValue>
		</Attribute>
<?php
        }
    }
}

?>