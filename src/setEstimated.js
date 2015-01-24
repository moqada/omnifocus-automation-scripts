'use strict'
/**
 * Set Estimated minutes to selected tasks
 */
var app, doc;
app = Application('OmniFocus');
doc = app.defaultDocument();
app.includeStandardAdditions = true;

(function () {
    var trees, minutes;
    trees = doc.documentWindows[0].content().selectedTrees;
    if(trees.length === 0) return null;
    minutes = app.displayDialog('Input estimated minutes', {defaultAnswer: ''})['textReturned'] || null;
    Array.apply(null, trees).forEach(function(tree){
        var task = tree.value();
        task.estimatedMinutes = minutes;
    });
}());
