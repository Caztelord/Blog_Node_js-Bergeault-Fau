require("dotenv").config();
const mysql = require('mysql');
const express = require('express');
const hbs = require('express-handlebars');
const app = express();
const {promisify} = require('util');
const bodyParser = require('body-parser');
let sha256=require('js-sha256');
const sanitize = require('xss');

// view engine setup
app.use(bodyParser.urlencoded({extended : true}));
app.engine('hbs', hbs({extname:'hbs', defaultLayout:'layout'}));
app.set('view engine', 'hbs');

const con = mysql.createConnection({
    host: "localhost",
    user: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    database:"blog_node"
});
con.connect()
const query = promisify(con.query).bind(con);

async function get_pass_client(username) {
    let storedpassword = await query("SELECT mdp_client FROM client WHERE Nom_C=(?)", [username]);
    let string = JSON.stringify(storedpassword);
    let json = JSON.parse(string);
    let result = [];
    json.forEach(element => result.push(element["mdp_client"]));
    console.log(result);
    return await result;
}
//affichage nom du client
async function get_email_clients(user) {
    let mail_client = await query("SELECT mail_c FROM client where Nom_C=(?)",[user]);
    let string = JSON.stringify(mail_client);
    let json = JSON.parse(string);
    let result = [];
    json.forEach(element => result.push(element["mail_c"]));
    return await result;
}
//création d'un compte
async function create_new_client(Nom_C, mdp,mail){
    mdp=sha256(mdp);
    await query("INSERT into client(Nom_C,mdp_client,mail_c) VALUES(?,?,?)",[Nom_C,mdp,mail]);
}
//affichage de l'article'
async function get_article_data(id_A) {
    let articles = await query("SELECT data_articles FROM articles WHERE id=(?)",[id_A]);
    let string = JSON.stringify(articles);
    let json = JSON.parse(string);
    let result = [];
    json.forEach(element => result.push(element["data_articles"]));
    return await result;
}
//affichage de la date de l'article.
async function get_article_date(id_A){
    let date_A = await query("SELECT DATE_FORMAT(date_parution,' %d/%m/%Y')FROM articles WHERE id=(?)",[id_A]);
    let string = JSON.stringify(date_A);
    let json = JSON.parse(string);
    let result = [];
    json.forEach(element => result.push(element["DATE_FORMAT(date_parution,' %d/%m/%Y')"]));
    return await result;
}
//affichage du titre de l'article
async function get_article_titre(id_A){
    let titre_A = await query("SELECT titre_A FROM articles WHERE id=(?)",[id_A]);
    let string = JSON.stringify(titre_A);
    let json = JSON.parse(string);
    let result = [];
    json.forEach(element => result.push(element["titre_A"]));
    return await result;
}
//affichage de l'auteur de l'article
async function get_article_Auteur(id_A){
    let auteur_A = await query("SELECT auteur_A FROM articles WHERE id=(?)",[id_A]);
    let string = JSON.stringify(auteur_A);
    let json = JSON.parse(string);
    let result = [];
    json.forEach(element => result.push(element["auteur_A"]));
    return await result;
}
async function get_numberOf_articles(){
    let maxpas=await query("SELECT COUNT(*) FROM articles");
    let string = JSON.stringify(maxpas);
    let json = JSON.parse(string);
    let result = [];
    json.forEach(element => result.push(element["COUNT(*)"]));
    return await result;
}
async function get_numberof_tag(){
    let maxtags=await query("SELECT COUNT(*) FROM tags");
    let string = JSON.stringify(maxtags);
    let json = JSON.parse(string);
    let result = [];
    json.forEach(element => result.push(element["COUNT(*)"]));
    return await result;
}
async function get_all_tags(){
    let many_tags=await query("SELECT name_tags FROM tags");
    let string = JSON.stringify(many_tags);
    let json = JSON.parse(string);
    console.log(json);
    let result = [];
    json.forEach(element => result.push(element["name_tags"]));
    return await result;
}
async function get_tag(id){
    let A_tag=await query("SELECT name_tags FROM tags WHERE id_T=(?)",[id]);
    let string = JSON.stringify(A_tag);
    let json = JSON.parse(string);
    console.log(json);
    let result = [];
    json.forEach(element => result.push(element["name_tags"]));
    return await result;
}
async function get_status_Clients(username){
    let status=await query("SELECT attribut FROM client WHERE Nom_C=(?)",[username]);
    let string = JSON.stringify(status);
    let json = JSON.parse(string);
    console.log(json);
    let result = [];
    json.forEach(element => result.push(element["attribut"]));
    return await result;
}

async function get_liste_tag(id_A){
    let auteur_A = await query("SELECT TAG_A FROM articles WHERE id=(?)",[id_A]);
    let string = JSON.stringify(auteur_A);
    let json = JSON.parse(string);
    let result = [];
    json.forEach(element => result.push(element["auteur_A"]));
    console.log("entre ici");
    console.log(json);
    console.log("et ici");
    return await result;
}
async function create_article(auteur,data,date,tag,titre){
    await query("INSERT INTO articles(auteur_A,data_articles,date_parution,TAG_A,titre_A) VALUES(?,?,?,?,?)",[auteur,data,date,tag,titre]);
}


app.get('/page_inscription',async function(req,res){

    res.render("page_inscription");
});
app.post('/page_inscription',async function(req,res){
    let user=req.body.user;
    let mail=req.body.mail;
    let password=req.body.password;
    await create_new_client(user,password,mail);

    res.render('page_inscription');
})

app.get('/create_article',async function(req,res){

    res.render('create_article.hbs');
});
app.post('/create_article',async function(req,res){
    let titre=req.body.articlename;
    let auteur=req.body.autheur;
    let article=req.body.article;
    let date=req.body.date;
    let tag=req.body.tag;
    await create_article(auteur,article,date,tag,titre);
    res.render('create_article');
})
app.get('/', async function(req, res){
    const ctx={};
    res.render("index",ctx);
});

app.post('/', async function(req,res){
    let ctx ={};
    let mdp=req.body.password;
    mdp= sha256(mdp);
    let user= req.body.username;
    if (mdp==await get_pass_client(user)) {
        ctx.logged_in = true;
        ctx.info= [];
        if (await get_status_Clients(user)=="admin") {
            ctx.logged_as_admin= true;
        }
        else if(await get_status_Clients(user)=="publisher"){
            ctx.logged_as_publisher = true;
        }
        let maxpas=await get_numberOf_articles();
        let maxtag=await get_numberof_tag();
        ctx.user = user;
        ctx.email= await get_email_clients(user);
        ctx.status= await get_status_Clients(user);
        ctx.date = new Date().toDateString();

        for( let pas=1; pas <= maxpas; pas++){
            ctx.info.push({

                listetag: await get_liste_tag(pas),

                Articles: await get_article_data(pas),
                Date: await get_article_date(pas),
                Auteur: await get_article_Auteur(pas),
                Titre: await get_article_titre(pas)
            });
        }
        ctx.tags= await get_all_tags();
        console.log(ctx.info);
    }
    else{
        console.log("wrong password");
    }
    res.render('index',ctx);
});


console.log("Connected!");
app.listen(2000);
