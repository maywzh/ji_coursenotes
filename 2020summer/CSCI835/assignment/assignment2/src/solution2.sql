SET ECHO ON
SET FEEDBACK ON
SET LINESIZE 100
SET PAGESIZE 200
SET SERVEROUTPUT ON

CREATE PROCEDURE INSERT_ORDER_DETAIL(order_id_ IN ORDER_DETAIL.ORDER_ID%TYPE, product_name_ IN ORDER_DETAIL.PRODUCT_NAME%TYPE, unit_price_ IN ORDER_DETAIL.UNIT_PRICE%TYPE, quantity_ IN ORDER_DETAIL.QUANTITY%TYPE, discount_ IN ORDER_DETAIL.DISCOUNT%TYPE) IS pd_state PRODUCT.DISCONTINUED%TYPE;
BEGIN
  SELECT DISCONTINUED INTO pd_state FROM PRODUCT WHERE PRODUCT_NAME = product_name_;
  IF pd_state = 'N' THEN
    INSERT INTO ORDER_DETAIL VALUES(order_id_, product_name_, unit_price_, quantity_, discount_);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Product is discontinued!');
  END IF;
  COMMIT;
END INSERT_ORDER_DETAIL;

EXEC INSERT_ORDER_DETAIL(383, 'Perth Pasties', 32.8, 10, 0);
EXEC INSERT_ORDER_DETAIL(383, 'Lakkalikoori', 16.2, 10, 0.1);