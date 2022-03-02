import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/books_provider.dart';

class BookEditScreen extends StatefulWidget {
  static const routeName = 'book-edit';

  @override
  State<StatefulWidget> createState() => _BookEditScreen();
}

class _BookEditScreen extends State<BookEditScreen> {
  final _authorFocusNode = FocusNode();
  final _categoryFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Book _editedBook = Book(id: 0, title: '', author: '', category: '', description: '', unitPrice: 0, imageUrl: '');
  bool _isInit = true;

  var _initValues = {
    'title': '',
    'author': '',
    'category': '',
    'description': '',
    'unitPrice': '',
    'imageUrl': '',
  };

  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)!.settings.arguments != null){
      var bookId = ModalRoute.of(context)!.settings.arguments as int;
      if(bookId != 0){
        _editedBook = Provider.of<BooksProvider>(context, listen: false).findById(bookId);
        _imageUrlController.text = _editedBook.imageUrl;
        _initValues = {
          'title': _editedBook.title,
          'author': _editedBook.author,
          'category': _editedBook.category,
          'description': _editedBook.description,
          'unitPrice': _editedBook.unitPrice.toString(),
        };
      }
    }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') && !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') && !_imageUrlController.text.endsWith('.jpg') && !_imageUrlController.text.endsWith('.jpeg'))) {
            return;
          }
      setState(() { });
    }
  }

  void _saveForm() {
    bool isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    print(_editedBook.id);
    if (_editedBook.id !=0) {
      Provider.of<BooksProvider>(context, listen: false).updateBook(_editedBook.id, _editedBook);
    } else {
      Provider.of<BooksProvider>(context, listen: false).addBook(_editedBook);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product'), actions: <Widget>[IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(key: _form, child: SingleChildScrollView(child: Column(children: [
          TextFormField(decoration: InputDecoration(labelText: 'Title'), textInputAction: TextInputAction.next,
            initialValue: _initValues['title'],
            onFieldSubmitted: (ctx) => FocusScope.of(context).requestFocus(_authorFocusNode),
            onSaved: (value) => _editedBook = Book(title: value!, author: _editedBook.author, category: _editedBook.category, description: _editedBook.description, unitPrice: _editedBook.unitPrice, imageUrl: _editedBook.imageUrl, id: _editedBook.id),
            validator: (value) {
              if(value!.isEmpty) { return 'Please provide a value'; }
              return null;
            },
            ),
            TextFormField(decoration: InputDecoration(labelText: 'Author'), focusNode: _authorFocusNode,textInputAction: TextInputAction.next,
            initialValue: _initValues['author'],
            onFieldSubmitted: (ctx) => FocusScope.of(context).requestFocus(_categoryFocusNode),
            onSaved: (value) => _editedBook = Book(title: _editedBook.title, author: value!, category: _editedBook.category, description: _editedBook.description, unitPrice: _editedBook.unitPrice, imageUrl: _editedBook.imageUrl, id: _editedBook.id),
            validator: (value) {
              if(value!.isEmpty) { return 'Please provide a value'; }
              return null;
            },
            ),
            TextFormField(decoration: InputDecoration(labelText: 'Category'), focusNode: _categoryFocusNode,textInputAction: TextInputAction.next,
            initialValue: _initValues['category'],
            onFieldSubmitted: (ctx) => FocusScope.of(context).requestFocus(_priceFocusNode),
            onSaved: (value) => _editedBook = Book(title: _editedBook.title, author: _editedBook.author, category: value!, description: _editedBook.description, unitPrice: _editedBook.unitPrice, imageUrl: _editedBook.imageUrl, id: _editedBook.id),
            validator: (value) {
              if(value!.isEmpty) { return 'Please provide a value'; }
              return null;
            },
            ),
          TextFormField(decoration: InputDecoration(labelText: 'Price'), focusNode: _priceFocusNode, textInputAction: TextInputAction.next, keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
            initialValue: _initValues['unitPrice'],
            onFieldSubmitted: (ctx) => FocusScope.of(context).requestFocus(_descriptionFocusNode),
            onSaved: (value) => _editedBook = Book(title: _editedBook.title, author: _editedBook.author, category: _editedBook.category, description: _editedBook.description, unitPrice: double.parse(value!), imageUrl: _editedBook.imageUrl, id: _editedBook.id),
            validator: (value) {
              if(value!.isEmpty) { return 'Please provide a value'; }
              if(double.tryParse(value) == null) { return 'Please enter a number'; }
              if(double.parse(value) <= 0) { return 'Please enter a number greater than 0'; }
              return null;
            },
            ),
          TextFormField(decoration: InputDecoration(labelText: 'Description'), focusNode: _descriptionFocusNode, maxLines: 3, textInputAction: TextInputAction.next, keyboardType: TextInputType.multiline,
            initialValue: _initValues['description'],
            onFieldSubmitted: (ctx) => FocusScope.of(context).requestFocus(_imageFocusNode),
            onSaved: (value) => _editedBook = Book(title: _editedBook.title, author: _editedBook.author, category: _editedBook.category, description: value!, unitPrice: _editedBook.unitPrice, imageUrl: _editedBook.imageUrl, id: _editedBook.id),
            validator: (value) {
              if(value!.isEmpty) { return 'Please provide a value'; }
              return null;
            },
            ),
          Row(children: [
            Container(width: 100, height: 100, margin: EdgeInsets.only(top: 10, right: 10),
                child: _imageUrlController.text.isEmpty ? Text('Enter an URL') : FittedBox(child: Image.network(_imageUrlController.text), fit: BoxFit.cover,)
            ),
            Expanded(child: TextFormField(decoration: InputDecoration(labelText: 'Image URL'), focusNode: _imageFocusNode,
              controller: _imageUrlController, textInputAction: TextInputAction.done, keyboardType: TextInputType.url,
              onEditingComplete: () => setState(() { }),
              onSaved: (value) => _editedBook = Book(title: _editedBook.title, author: _editedBook.author, category: _editedBook.category, description: _editedBook.description, unitPrice: _editedBook.unitPrice, imageUrl: value!, id: _editedBook.id),
              validator: (value) {
                  if(value!.isEmpty) { return 'Please provide a value'; }
                  if(!value.startsWith('http') && !value.startsWith('https')) { return 'Please enter a valid URL'; }
                  if(!value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('.jpeg')) { return 'Please enter a valid image URL'; }
                  return null;
                }
            ),),
          ],), 
        ],),),),
      ),
    );
  }

  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }
}