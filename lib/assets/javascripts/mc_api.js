if(!window.Mailchimp) Mailchimp = {};
Mailchimp.API = {};
$.ajaxSetup({
  contentType: 'text/plain'
});
Mailchimp.API.call = function(method,params,cb, error_cb){
    var jqxhr = $.post('/mailchimp/api',JSON.stringify({method: method,params: params}),function(data,text,xhr){
      console.log(data);
      cb ? cb(data,text,xhr) : '';
    },'json');
    if(error_cb) jqxhr.error(error_cb);
};
Mailchimp.ExportAPI = {};
Mailchimp.ExportAPI.list = function(id,cb){
  $.get('/mailchimp/export/list/'+id,function(data){
    cb ? cb(data) : '';
  },'text')
}
