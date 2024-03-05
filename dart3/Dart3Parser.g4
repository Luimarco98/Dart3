/* Generated Mon, Jun 13, 2022 8:11:58 AM EST
 *
 * Copyright (c) 2022, 2023 Ken Domino
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 *
 * This grammar is generated from the CFG contained in:
 * https://github.com/dart-lang/language/blob/70eb85cf9a6606a9da0de824a5d55fd06de1287f/specification/dartLangSpec.tex
 *
 * The bash script used to scrape and the refactor the gramamr is here:
 * https://github.com/kaby76/ScrapeDartSpec/blob/master/refactor.sh
 *
 * Note: the CFG in the Specification is in development, and is for approximately
 * Dart version 2.15. The Specification is not up-to-date vis-a-vis the actual
 * compiler code, located here:
 * https://github.com/dart-lang/sdk/tree/main/pkg/_fe_analyzer_shared/lib/src/parser
 * Some of the refactorings that are applied are to bring the code into a working
 * Antlr4 parser. Other refactorings replace some of the rules in the Spec because
 * the Spec is incorrect, or incomplete.
 *
 * This grammar has been checked against a large subset (~370 Dart files) of the Dart SDK:
 * https://github.com/dart-lang/sdk/tree/main/sdk/lib
 * A copy of the SDK is provided in the examples for regression testing.
 */

// $antlr-format alignTrailingComments true, columnLimit 150, minEmptyLines 1, maxEmptyLinesToKeep 1, reflowComments false, useTab false
// $antlr-format allowShortRulesOnASingleLine false, allowShortBlocksOnASingleLine true, alignSemicolons hanging, alignColons hanging

parser grammar Dart3Parser;

options {
    tokenVocab = Dart3Lexer;
}
letExpression
    : LET_ staticFinalDeclarationList IN_ letExpression 
    ;
staticFinalDeclarationList
    : staticFinalDeclaration (C staticFinalDeclaration)*
    ;
staticFinalDeclaration
    : identifier EQ expr
    ;
identifier
    : IDENTIFIER
    | ABSTRACT_
    | AS_
    | COVARIANT_
    | DEFERRED_
    | DYNAMIC_
    | EXPORT_
    | EXTERNAL_
    | EXTENSION_
    | FACTORY_
    | FUNCTION_
    | GET_
    | IMPLEMENTS_
    | IMPORT_
    | INTERFACE_
    | LATE_
    | LIBRARY_
    | MIXIN_
    | OPERATOR_
    | PART_
    | REQUIRED_
    | SET_
    | STATIC_
    | TYPEDEF_
    | FUNCTION_
    | ASYNC_
    | HIDE_
    | OF_
    | ON_
    | SHOW_
    | SYNC_
    | AWAIT_
    | YIELD_
    | DYNAMIC_
    | NATIVE_
    ;
expr
    : assignableExpression assignmentOperator expr
    | conditionalExpression
    | cascade
    | throwExpression
    ;
finalConstVarOrType
    : LATE_? FINAL_ type?
    | CONST_ type?
    | LATE_? varOrType
    ;
initializedVariableDeclaration
    : declaredIdentifier (EQ expr)? (C initializedIdentifier)*
    ;
initializedIdentifier
    : identifier (EQ expr)?
    ;
initializedIdentifierList
    : initializedIdentifier (C initializedIdentifier)*
    ;
functionSignature
    : type? identifier formalParameterPart
    ;
formalParameterPart
    : typeParameters? formalParameterList
    ;
block
    : OBC statements CBC
    ;
formalParameterList
    : OP CP
    | OP normalFormalParameters C? CP
    | OP normalFormalParameters C optionalOrNamedFormalParameters CP
    | OP optionalOrNamedFormalParameters CP
    ;
normalFormalParameters
    : normalFormalParameter (C normalFormalParameter)*
    ;
optionalOrNamedFormalParameters
    : optionalPositionalFormalParameters
    | namedFormalParameters
    ;
optionalPositionalFormalParameters
    : OB defaultFormalParameter (C defaultFormalParameter)* C? CB
    ;
namedFormalParameters
    : OBC defaultNamedParameter (C defaultNamedParameter)* C? CBC
    ;
normalFormalParameter
    : metadata normalFormalParameterNoMetadata
    ;
normalFormalParameterNoMetadata
    : functionFormalParameter
    | fieldFormalParameter
    | simpleFormalParameter
    ;
functionFormalParameter
    : COVARIANT_? type? identifier formalParameterPart QU?
    ;
simpleFormalParameter
    : declaredIdentifier
    | COVARIANT_? identifier
    ;
declaredIdentifier
    : COVARIANT_? finalConstVarOrType identifier
    ;
fieldFormalParameter
    : finalConstVarOrType? THIS_ D identifier (formalParameterPart QU?)?
    ;
defaultFormalParameter
    : normalFormalParameter (EQ expr)?
    ;
defaultNamedParameter
    : metadata REQUIRED_? normalFormalParameterNoMetadata (( EQ | CO) expr)?
    ;
classDeclaration
    : ABSTRACT_? CLASS_ typeIdentifier typeParameters? superclass? interfaces? OBC (
        metadata classMemberDeclaration
    )* CBC
    | ABSTRACT_? CLASS_ mixinApplicationClass
    ;
classMemberDeclaration
    : declaration SC
    | methodSignature functionBody
    ;
declaration
    :   EXTERNAL_ factoryConstructorSignature
        | EXTERNAL_ constantConstructorSignature
        | EXTERNAL_ constructorSignature
        | ( EXTERNAL_ STATIC_?)? getterSignature
        | ( EXTERNAL_ STATIC_?)? setterSignature
        | ( EXTERNAL_ STATIC_?)? functionSignature
        | EXTERNAL_? operatorSignature
        | STATIC_ CONST_ type? staticFinalDeclarationList
        | STATIC_ FINAL_ type? staticFinalDeclarationList
        | STATIC_ LATE_ FINAL_ type? initializedIdentifierList
        | STATIC_ LATE_? varOrType initializedIdentifierList
        | COVARIANT_ LATE_ FINAL_ type? identifierList
        | COVARIANT_ LATE_? varOrType initializedIdentifierList
        | LATE_? FINAL_ type? initializedIdentifierList
        | LATE_? varOrType initializedIdentifierList
        | redirectingFactoryConstructorSignature
        | constantConstructorSignature ( redirection | initializers)?
        | constructorSignature ( redirection | initializers)?
    
    ;
methodSignature
    : constructorSignature initializers?
    | factoryConstructorSignature
    | STATIC_? functionSignature
    | STATIC_? getterSignature
    | STATIC_? setterSignature
    | operatorSignature
    ;
typeNotVoidList
    : typeNotVoid (C typeNotVoid)*
    ;
functionBody
    : ASYNC_? EG expr SC
    | ( ASYNC_ ST? | SYNC_ ST)? block
    ;
staticFinalDeclarationList
    : staticFinalDeclaration (C staticFinalDeclaration)*
    ;
staticFinalDeclaration
    : identifier EQ expr
    ;
operatorSignature
    : type? OPERATOR_ operator formalParameterList
    ;
operator
    : SQUIG
    | binaryOperator
    | OB CB
    | OB CB EQ
    ;
binaryOperator
    : multiplicativeOperator
    | additiveOperator
    | shiftOperator
    | relationalOperator
    | EE
    | bitwiseOperator
    ;
getterSignature
    : type? GET_ identifier
    ;
setterSignature
    : type? SET_ identifier formalParameterList
    ;
constructorName
    : typeIdentifier (D identifier)?
    ;
constructorSignature
    : constructorName formalParameterList
    ;
redirection
    : CO THIS_ (D identifier)? arguments
    ;
initializers
    : CO initializerListEntry (C initializerListEntry)*
    ;
initializerListEntry
    : SUPER_ arguments
    | SUPER_ D identifier arguments
    | fieldInitializer
    | assertion
    ;
fieldInitializer
    : (THIS_ D)? identifier EQ initializerExpression
    ;
conditionalExpression
    : assignableExpression assignmentOperator expression
    | conditionalExpression
    | cascade
    | throwExpression
    ;
factoryConstructorSignature
    : CONST_? FACTORY_ constructorName formalParameterList
    ;
constructorDesignation
    : typeIdentifier
    | qualifiedName
    | typeName typeArguments ( D identifier)?
    ;
redirectingFactoryConstructorSignature
    : CONST_? FACTORY_ constructorName formalParameterList EQ constructorDesignation
    ;
constantConstructorSignature
    : CONST_ constructorName formalParameterList
    ;
superclass
    : EXTENDS_ typeNotVoid mixins?
    | mixins
    ;
mixins
    : WITH_ typeNotVoidList
    ;

interfaces
    : IMPLEMENTS_ typeNotVoidList
    ;
mixinApplicationClass
    : identifier typeParameters? EQ mixinApplication SC
    ;
mixinApplication
    : typeNotVoid mixins interfaces?
    ;
mixinDeclaration
    : MIXIN_ typeIdentifier typeParameters? (ON_ typeNotVoidList)? interfaces? OBC (
        metadata classMemberDeclaration
    )* CBC
    ;
extensionDeclaration
    : EXTENSION_ identifier? typeParameters? ON_ type OBC (metadata classMemberDeclaration)* CBC
    ;