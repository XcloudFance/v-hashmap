// 目前还不知道vlang里面typedef的用法，暂时把size_t 用 uint64 代替
//pow是快速幂
module hashmap
fn pow(A,B u64) u64{
	mut b := B
	mut ans:=u64(1)
	mut res:= A

	for{
			if b == 0 {break}
			if(b & 1 == 1) {ans=ans*res}
			res=res*res
			b>>=1
		}
	return ans
}

fn range(num int) []int{
	if num == 0{
		return []
	}
	mut constant := [0]
	for i:=1; i<num; i++ {constant<<i}
	return constant
}

pub struct Noder{
	pub mut:	
		list []Kv
}

pub struct Kv
{
	pub mut:
		key string
		val string
}

pub fn (u mut Noder) insert(key string,val string){

	for i in range(u.list.len){
		if u.list[i].key == key {
			u.list[i].val = val
			return 
		}
	}
	mut tmp := Kv{}
	tmp.key = key
	tmp.val = val
	u.list << tmp
	
}

fn step (s string)string{
	return '"'+s+'"'
}
pub fn (u hashmap.Noder) find(key string)string{
	mut ret := ""
	if u.list.len == 0{
		return 'The key doesn\'t exist'
	}
	for i in u.list{
		if i.key == key{
			ret = i.val
		}
	}
	return step(ret)
}
pub struct Hashtable {
	pub mut:
		hashlist [99999]hashmap.Noder
}

fn (u Hashtable) gethashcode(s string) u64 {
	mut ret := u64(0)
	for tmp in s
	{
		ret = u64(5*ret + int(tmp))
	}
	return ret
} 
fn (u Hashtable) fnvhash(s string ) u64{
	fnvprime := 16777619 
	mut result := 2166136261
	for tmp in s{
		result *= fnvprime%(pow(2,32))
		result ^= tmp
	}
	result = result % 77
	return result
}
//这里是hashtable的insert，前面那个是list的insert
pub fn (u mut Hashtable) insert(key , val string){
	position := u.gethashcode(key)%99999 //取hash值
	u.hashlist[position].insert(key,val) //这里的insert就是Noder里面list的insert了

}
pub fn (u Hashtable) got(key string) string{
	return u.hashlist[u.gethashcode(key)%99999].find(key)
}

pub fn (u mut Hashtable) initalize(){
		for i in range(99999){
			tmp := Noder{}
			u.hashlist[i] = tmp 
		}
}


fn main()
{
	mut hashmap := Hashtable{}
	hashmap.initalize()
	hashmap.insert('test','233')
	println(hashmap.got('test'))
}