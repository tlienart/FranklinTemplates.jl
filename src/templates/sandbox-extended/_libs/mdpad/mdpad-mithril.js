function minput({
      title = "",
      mdpad = "",
      type = "number",
      step = 1,
      min = 0,
      value = 0,
      groupclass = "",
      labelclass = "",
    }={}) {
    return m(".form-group." + groupclass,
             m("label.control-label." + labelclass, title),
             m("input.form-control", {mdpad:mdpad, type:type, step:step, min:min, value:value}));
}

function mselect({
      title = "",
      mdpad = "",
      options = "",
      selected = "",
      groupclass = "",
      labelclass = "",
    }={}) {
    var options = options.map(x => m("option", (x == selected) ? {selected: "selected"} : {}, x));
    return m(".form-group." + groupclass,
             m("label.control-label." + labelclass, title),
             m("select.form-control", {mdpad:mdpad}, options));
}

function mcheckbox({
      title = "",
      mdpad = "",
      checked = "checked",
      groupclass = "",
      labelclass = "",
    }={}) {
    return m(".form-check" + groupclass,
             m("input.form-check-input", {mdpad:mdpad, type:"checkbox", checked:checked}),
             m("label.form-check-label." + labelclass, title));
}

function mdatatable(tbl, {
      tableclass = "table-striped",
      theadclass = "",
    }={}) {
    var keys = Object.getOwnPropertyNames(tbl);
    var idx = Array(keys.length).fill()
    var rows = []
    for (i = 0; i < tbl[keys[1]].length; i++) {
        var cells = []
        for (j = 0; j < keys.length; j++) {
            cells.push(m("td", tbl[keys[j]][i]))
        }
        rows.push(m("tr", cells))
    }
    return m("table.table." + tableclass,
             m("thead." + theadclass,
               m("tr", keys.map((x) => m("th", x)))),
             m("tbody",
               rows))
}

function mcoltable(tbl, colheadings, rowheadings, {
      tableclass = "table-striped",
      theadclass = "",
    }={}) {
    var keys = Object.getOwnPropertyNames(tbl);
    var rows = []
    var hasrowheadings = rowheadings && rowheadings.length > 0;
    var hascolheadings = colheadings && colheadings.length > 0;
    for (i = 0; i < tbl[0].length; i++) {
        var cells = []
        hasrowheadings &&
            cells.push(m("th", rowheadings[i]))
        for (j = 0; j < tbl.length; j++) {
            cells.push(m("td", tbl[j][i]))
        }
        rows.push(m("tr", cells))
    }
    return m("table.table." + tableclass,
             m("thead." + theadclass,
               hascolheadings && m("tr", hasrowheadings ? m("th") : "", colheadings.map((x) => m("th", x)))),
             m("tbody",
               rows))
}

function mrowtable(tbl, rowheadings, colheadings, {
      tableclass = "table-striped",
      theadclass = "",
    }={}) {
    var keys = Object.getOwnPropertyNames(tbl);
    var rows = [];
    var hasrowheadings = rowheadings && rowheadings.length > 0;
    var hascolheadings = colheadings && colheadings.length > 0;
    for (i = 0; i < tbl.length; i++) {
        var cells = [];
        hasrowheadings &&
            cells.push(m("th", rowheadings[i]))
        for (j = 0; j < tbl[0].length; j++) {
            cells.push(m("td", tbl[i][j]));
        }
        rows.push(m("tr", cells));
    }
    return m("table.table." + tableclass,
             m("thead." + theadclass,
               hascolheadings && m("tr", hasrowheadings ? m("th") : "", colheadings.map((x) => m("th", x)))),
             m("tbody",
               rows));
}

function mplotly(data, layout, config) {
    return m({
        oncreate: function(vnode) {
            Plotly.newPlot(vnode.dom, data, layout, config);
        },
        onremove: function(vnode) {
            Plotly.purge(vnode.dom);
        },
        onupdate: function(vnode) {  // it's not using this
            Plotly.react(vnode.dom, data, layout, config);
        },
        view: function() {
            return m('div')
        }
    })
}
