#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MAIN_MENU() {
  echo "Please select a service from the list below:"
  
  # Get all services from the database
  SERVICES_OFFERED=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  
  # Display the services
  echo "$SERVICES_OFFERED" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done

  read SERVICE_ID_SELECTED

  # Validate service selection
  SERVICE_ID_SELECTED_LOOKUP=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  
  if [[ -z $SERVICE_ID_SELECTED_LOOKUP ]]
  then
    echo -e "\nInvalid service selection. Please try again.\n"
    MAIN_MENU
  else
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    
    CUSTOMER_NAME_LOOKUP=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    
    if [[ -z $CUSTOMER_NAME_LOOKUP ]]
    then
      echo -e "\nI don't have a record for that phone number. What's your name?"
      read CUSTOMER_NAME
      INSERT_CUSTOMER_INFO=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    else
      CUSTOMER_NAME=$CUSTOMER_NAME_LOOKUP
    fi
    
    SERVICE_TIME
  fi
}

SERVICE_TIME() {
  echo -e "\nWhat time would you like your appointment, $CUSTOMER_NAME?"
  read SERVICE_TIME
  
  CUSTOMER_ID_LOOKUP=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  
  INSERT_APPOINTMENT_INFO=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID_LOOKUP, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  EXIT
}

EXIT() {
  echo -e "\nThank you for stopping in.\n"
  exit
}

MAIN_MENU
pg_dump -cC --inserts -U freecodecamp salon > salon.sql
