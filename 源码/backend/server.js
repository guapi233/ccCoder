const Koa = require("koa")
const Router = require("koa-router")
const session = require("koa-session")
// const postParser = require("koa-body")
const cors = require("koa2-cors")
const static = require("koa-static")
const path = require("path")
const config = require("./config")

// init
const server = new Koa()
const router = new Router()

// machining
server.use(async (ctx, next) => {
  
  await next()
})

// 允许跨域
server.use(cors({
  credentials: true // 允许携带cookie
}))

// session
server.keys = ["session-key", "you are a gay"]
server.use(session(config.session, server))

// // post parser
// server.use(postParser({
//   multipart: true, // 支持文件上传
//   // encoding: "gzip", // 文件压缩方式，存在问题：如果开启后会无法处理任何post请求(code 415)
//   formidable: {
//     uploadDir: path.join(__dirname, "source/upload/"), // 设置文件上传目录
//     keepExtensions: true, // 保留文件后缀名
//     maxFieldsSize: 20 * 1024 * 1024, // 最大文件大小
//     onFileBegin (name, file) {
//       // 上传规则
//       if (name == "music") {
//         file.path = `${this.uploadDir}music/${file.name}`
//       }
//     },
//     onError (err) {
//       console.log(err)
//     }
//   }
// }))

// 静态资源托管
server.use(static(path.join(__dirname, "source")))

// router
router.use(require("./router/index"))

server.use(router.routes())
server.use(router.allowedMethods()) // 处理访问失败的请求头


server.listen(config.serverPort)
