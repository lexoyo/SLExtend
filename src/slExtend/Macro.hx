package slExtend;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

/**
 * This class has a macro function used to add
 * a block of code to all the methods with an "extendable"
 * metadata (only one in this prototype)
 * 
 * @author Raphael HARMEL
 * @date   2011-09-11
 */
class Macro 
{

	// define the new method name prefix
	private static inline var methodPrefix:String = "_slExtend_";

	/**
	 * A macro function used to build a class. When it is
	 * called all the class's fields are accessible and editable,
	 * new field can also be created
	 * 
	 * @return an array containing each of the target class fields
	 */
	@:macro public static function build(): Array<Field> {

		// define the new class name
		var classInstanceName:String = "classInstance";
		
		// retrieve the calling class name
		var localClass:Null<Ref<ClassType>> = Context.getLocalClass();
		var localClassName:String = localClass.get().name;
		var localClassPackage:String = localClass.get().pack.join('.');
		
		// retrieve all the fields from the calling class
		var fields:Array<Field> = Context.getBuildFields();
		// fields to be returned
		var retFields:Array<Field> = [];

		// loop in all the fields
		for (i in 0...fields.length)
		{
			var func:Function;
			// check that the field is a function
			switch (fields[i].kind)
			{
				// if it is a function
				case FFun(func):
					// STEP 1:
					// Class extend
					//
					// case 1:
					// in the method's expression (i.e. content), replace all code like:
					// "var x:MyClass = new MyClass(...);" by
					// "var x:class;
					// var class:Class = SLFilter.getInstance().applyFilters("slextend.hook.class.new.MyClass", MyClass);
					// x = new class( ... );"
					//
					// case 2:
					// in the method's expression (i.e. content), replace all code like:
					// "x = new MyClass(...);" by
					// "var class:Class = SLFilter.getInstance().applyFilters("slextend.hook.class.new.MyClass", MyClass);
					// x = new class( ... );"
		
					// if the function content is an EBlock (only possible case). EBlock is a block of code
					switch(func.expr.expr)
					{
						case EBlock(block):
						trace("method: " + fields[i].name);
						//trace("block:");
						//trace(block);
						//var newBlock:Array<Expr> = block.copy();
						var newBlock:Array<Expr> = [];
						//trace(newBlock);
						
						// for each subBlock (=expression), i.e. for each line af code in the EBlock
						//for (subBlock in block)
						for (subBlock in 0...block.length)
						{
							//trace("subBlock: ");
							//trace(block[subBlock]);
							//var position:Position = Context.currentPos();
							//trace("position:");
							//trace(position);
							//newBlock.push(subBlock);
							newBlock.push(block[subBlock]);
							
							// analyse each line of code in the EBlock
/*							switch(block[subBlock].expr)
							{
								// case 1: the expression is the following: "var x:MyClass = new MyClass();"
								// 1.1. check that the expression starts with "var x ="
								case EVars(variableContents):
								//trace("variableContents: ");
								//trace(variableContents);
								for (variableContent in variableContents)
								{
									//trace(variableContent);
									//trace(variableContent.expr);
									//trace(variableContent.expr.expr);
									
									// if variable is set to a value (i.e. "var x = something")
									if (variableContent.expr != null)
									{
										switch(variableContent.expr.expr)
										{
											// 1.2. check that the second part of the expression ends with "new MyClass()"
											case ENew(typePath, params):
											//if (typePath.name == localClass.toString())
											if (typePath.name == localClassName)
											{
												trace("\nnew called in:\n   class: " + localClassName + "\n   method: " + fields[i].name + "\n   position: " + variableContent.expr.pos);
												
												// remove newBlock last element
												newBlock.pop();
												//create the new code expression (code block) from a string
												//var newInstanciationCode:String = '{var toto:Class;}';
												//var newInstanciationCode:String = '{var classInstance:Class;}';
												//var newInstanciationCode:String = '{var ' + classInstanceName + ':Class;}';
												//var newInstanciationCode:String = '{var toto:Class = new Macro();}';
												//var newInstanciationString:String = '{var ' + classInstanceName + ':Class = SLFilter.getInstance().applyFilters("slextend.hook.class.new.MyClass", MyClass);}';
												//var newInstanciationString:String = '{var ' + classInstanceName + ':Class = SLExtend.Macro;}';
												//trace(newInstanciationCode);
												//var newInstanciationExpr:Expr = Context.parse(newInstanciationString, Context.currentPos());
												//newBlock.push(newInstanciationExpr);
												//trace(block);
												//trace(typePath);
												//trace(typePath);
												//typePath.name = classInstanceName;
												//newBlock.push(block[subBlock]);
												//typePath.name = 'SLExtend.Macro';
												//trace(variableContent.expr);
											}
											
											default:
										}
									}
								}

								// case 2: the expression is the following: "x = new MyClass();"
								// 2.1. check that the expression starts with "x ="
								//case EBinop(op : Binop, e1 : Expr, e2 : Expr)
								case EBinop(operation, expr1, expr2):
								//trace(expr2);
								switch(expr2.expr)
								{
									// 2.2. check that the second part of the expression ends with "new MyClass()"
									case ENew(typePath, params):
									//Type.type(localClass);
									//trace(type(typePath.name));
									//trace(type(localClass));
									//if (typePath.name == localClass.toString())
									if (typePath.name == localClassName)
									{
										trace("\nnew called in:\n   class: " + localClassName + "\n   method: " + fields[i].name + "\n   position: " + expr2.pos);	
									}
									
									default:
								}
								
								default:
								//newBlock.push(block[subBlock]);


							}
							//trace("newSubBlock:");
							//trace(newBlock[newBlock.length-2]);
							//trace(newBlock[newBlock.length-1]);
							//this array will store the newly created expression, which will replace the current function expression
							//var block:Array<Expr> = new Array<Expr>();
							//block.push(newCode);
*/
						}
						//trace("newBlock:");
						//trace(newBlock[newBlock.length]);

						//retFields.push(FFun({expr:{expr:EBlock(newBlock), pos:func.expr.pos}, args:func.args, ret:func.ret, params:func.params}));
					//retFields.push({FFun({expr:{expr:EBlock(newBlock), pos:func.expr.pos}, args:func.args, ret:func.ret, params:func.params}}));
					//retFields.push( { name : fields[i].name, doc : fields[i].doc, meta : fields[i].meta, access : fields[i].access, kind : FFun( { expr: { expr:EBlock(newBlock), pos:func.expr.pos }, args:func.args, ret:func.ret, params:func.params } ), pos : fields[i].pos } );
					var returnFunction:FieldType = FFun( { expr: { expr:EBlock(newBlock), pos:func.expr.pos }, args:func.args, ret:func.ret, params:func.params } );
					var returnField:Field = { name : fields[i].name, doc : fields[i].doc, meta : fields[i].meta, access : fields[i].access, kind : returnFunction, pos : fields[i].pos }
					retFields.push( returnField );
					
					//trace(retFields);
					
					default: throw "There should be an EBlock";
					}
					
					// STEP 2:
					// Method extend
					//
					// 1. copy the function and rename the copy to _slExtendOriginalMethodName
					// 2. replace the function content with a call to filter

					// get the metadata of one field, as an array of anonymous objects.
					// each metadata can have parameters, might be useful to add condition to an 
					// extendable method
					var metadata:Array<{ name : String, params : Array<Expr>, pos : Position }> = fields[i].meta;

					// loop in all the metadata, searching for the one with the "extendable" name
					for (j in 0...metadata.length)
					{
						// if metadata in "extendable"
						if (metadata[j].name == "extendable")
						{
							var functionName:String = fields[i].name;
							// 1. copy the function and rename the copy to _slExtendOriginalMethodName
							// newMethod is used to store the orignal function content and is named _slExtendOriginalMethodName
							var newMethod:Field = copyAndRenameMethod(functionName,func);
							// push new method to context
							fields.push(newMethod);
							//retFields.push(newMethod);
							
							// 2. replace the function content with a call to filter
							func.expr = replaceMethodContent(localClassPackage + '.' + localClassName, functionName, func.expr);
						}
					}
				
				default:
			}
		}
		
		//trace(fields);
		//return all the modified class fields
		return fields;
		//return retFields;
	}

	/**
	 * This method replaces the extendable's method content with a a call to SLFilter::applyFilters()
	 * 
	 * @param	functionExpression
	 * @param	nameSpace
	 * @param	functionName
	 * @return	the new expression (i.e. the new code)
	 */
	private static function replaceMethodContent(classPath:String, functionName:String, functionExpression:Expr):Expr
	{
		var methodPath:String = classPath + '.' + functionName;
		
		// add the core method to its corresponding filter with lowest priority: -1
		//var codeString1:String = 'slExtend.SLExtend.extend("' + methodPath + '",' + methodPrefix + functionName +',-1);';
		var codeString1:String = 'SLFilter.getInstance().addFilter("' + methodPath + '",' + methodPrefix + functionName + ',-1);';
		
		// call SLFilter.getInstance().applyFilters to execute the method with highest priority
		var codeString2:String = 'var args:Dynamic = slExtend.SLFilter.getInstance().applyFilters("' + methodPath + '",[]);';
		
		// create the new code string, which will replace the current function expression
		var newCodeString:String = '{' + codeString1 + codeString2 + '}';
		var newCode:Expr = Context.parse(newCodeString, Context.currentPos());
		
		// create the array which will store the newly created expression
		var block:Array<Expr> = new Array<Expr>();
		block.push(newCode);

		// return the new block of expression at the same position
		// in the code than the original expression (it replaces it)
		return {expr:EBlock(block), pos:functionExpression.pos};
	}

	/**
	 * This method creates a new method, called _slExtendOriginalMethodName, and containing the original method content 
	 * 
	 * @param	functionExpression
	 * @return	the new expression (i.e. the new code)
	 */
	private static function copyAndRenameMethod(functionName:String, originalFunc:Function):Field
	{
		// initialise new function
		var newFunc : Function;
		newFunc = { args : null, ret : null , expr : null , params : null };
		// set arguments
		newFunc.args = originalFunc.args;
		// set return value type
		newFunc.ret = originalFunc.ret;
		// set expression (content)
		newFunc.expr = originalFunc.expr;
		// set type parameters
		newFunc.params = originalFunc.params;
		
		// newMethod is used to store the orignal method content and is named _slExtendOriginalMethodName
		var pos = haxe.macro.Context.currentPos();
		var tint = TPath({ pack : [], name : "Int", params : [], sub : null });
		var newMethod:Field = { name : methodPrefix + functionName, doc : null, meta : [], access : [APublic], kind : FFun(newFunc), pos : pos };
		return newMethod;
	}

	private static function replaceClassInstanciation()
	{
		
	}
}