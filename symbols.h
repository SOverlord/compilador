int dataOffset = 0;
int dataLoc(){
	dataOffset++;
}

struct symTable{
	char *nombre;
	int offset;
	struct symTable *next;
};
typedef struct symTable symTable;

symTable *id;

symTable *symbolName = (symTable *)0;

symTable * getSymbol (char *sm){
	symTable *ptr;
	printf("Buscando simbolo: %s\n", sm);
	for (ptr = symbolName; ptr != (symTable *) 0; ptr = (symTable *)ptr->next){
		if(strcmp(ptr->nombre, sm) == 0){
			return ptr;
		}
	}
	return 0;
}

symTable * putSymbol (char *sm){
	symTable *ptr;
	ptr = (symTable *) malloc (sizeof(symTable));
	ptr->nombre = (char *) malloc (strlen(sm)+1);
	strcpy (ptr->nombre, sm);
	ptr->offset = dataLoc();
	ptr->next = (struct symTable *)symbolName;
	symbolName = ptr;
	printf("Anadiendo simbolo nuevo: %s\n\n", sm);
	return ptr;
}
