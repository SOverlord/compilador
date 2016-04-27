int dataOffset = 0;
int dataLoc(){
	dataOffset++;
}

struct symTable{
	char	*nombre;
	char	*type;
	int		value;
	int		offset;
	struct 	symTable *next;
};
typedef struct symTable symTable;

symTable *id;

symTable *symbolName = (symTable *)0;

symTable * getSymbol (char *sm){
	symTable *ptr;
	//printf("Buscando simbolo: %s\n", sm);
	for (ptr = symbolName; ptr != (symTable *) 0; ptr = (symTable *)ptr->next){
		if(strcmp(ptr->nombre, sm) == 0){
			return ptr;
		}
	}
	return 0;
}

symTable * putSymbol (char *sm, char *tipo){
	symTable *ptr;
	ptr = (symTable *) malloc (sizeof(symTable));

	ptr->nombre = (char *) malloc (strlen(sm)+1);
	ptr->type 	= (char *) malloc (strlen(tipo)+1);

	strcpy(ptr->nombre, sm);
	strcpy(ptr->type, tipo);

	if(tipo == "float"){
		ptr->value 	= malloc (sizeof(float));
	}
	else if(tipo == "int"){
		ptr->value 	= malloc (sizeof(int));
	}
	else {
		return 0;
	}

	ptr->offset = dataLoc();
	ptr->next = (struct symTable *)symbolName;
	symbolName = ptr;
	printf("Anadiendo simbolo nuevo: %s\n", ptr->nombre);
	printf("Tipo: %s\n", ptr->type);
	printf("\n\n\n");
	return ptr;
}