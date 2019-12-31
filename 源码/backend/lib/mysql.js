const mysql = require("mysql")
const config = require("../config")
const db = mysql.createConnection({
  host: config.database.host,
  user: config.database.user,
  password: config.database.password,
  database: config.database.database,
  port: config.database.port
})

let selectDefault = {
  groupBy: ``,
  having: ``,
  orderBy: ``,
  limit: `` 
}

module.exports = {
  /**
   * 
   * @param sql 字符串::sql语句 
   */

  query (sql) {
    return new Promise ((resolve, reject) => {
      db.query(sql, (err, res) => {
        if (err) {reject(err)}

        resolve(res)
      })
    })
  },

  /**
   * 
   * @param  data 数组::数据 
   * @param  table 字符串::表格
   * @param  where 对象::条件
   * @param  extra 对象::额外参数，键为sql功能，值为字符串
   */

  cSelect (data, table, where, extra = selectDefault) {
    if (data !== "*") {data = data.join(",")}
    extra.groupBy = extra.groupBy ? `group by ${extra.groupBy}` : ``
    extra.having = extra.having ? `having ${extra.having}` : ``
    extra.orderBy = extra.orderBy ? `order by ${extra.orderBy}` : ``
    extra.limit = extra.limit ? `limit ${extra.limit}` : ``
    let sql = ``
    if (where) {
      for (let key in where) {
        sql += ` ${key} = '${where[key]}' and`
      }
      sql = sql.replace(/and$/, " ")
    }else { sql = `1=1` }

    // console.log(`select ${data} from ${table} where ${sql} ${extra.groupBy} ${extra.having} ${extra.orderBy} ${extra.limit}`)

    return this.query(`select ${data} from ${table} where ${sql} ${extra.groupBy} ${extra.having} ${extra.orderBy} ${extra.limit}`, (err, res) => {
      if (err) {reject(err)}
    })
  },

  /**
   * 
   * @param  data 对象::需要更新的数据
   * @param  table 字符串::表格
   * @param  where 字符串::条件
   */

  cUpdate (data, table ,where=`1=1`) {
    let sql = ``
    for (let key in data) {
      sql += `${key} = '${data[key]}',`
    }
    sql = sql.replace(/,$/, " ")

    return this.query(`update ${table} set ${sql} where ${where}`, (err, res) => {
      if (err) {reject(err)}
    })
  },

  /**
   * 
   * @param table 字符串::表格 
   * @param where 字符串::条件
   */

  cDelete (table, where=`1=1`) {
    return this.query(`delete from ${table} where ${where}`, (err) => {
      if (err) {reject(err)}
    })
  },

  /**
   * 
   * @param data 对象::需要插入的数据 
   * @param table 字符串::表格
   */

  cInsert (data, table) {
    let key = `(`, value = `(`
    
    for (let k in data) {
      key += `${k},`
      value += `'${data[k]}',`
    } 
    key = key.replace(/,$/, ")")
    value = value.replace(/,$/, ")")

    return this.query(`insert into ${table} ${key} values${value}`, (err) => {
      if (err) {reject(err)}
    })
  }
}