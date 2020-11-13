
package main
import (
	"gonum.org/v1/gonum/stat/distuv"
	"golang.org/x/exp/rand"
	gorand "math/rand"
	"fmt"
	"time"
)
//生成0-1之间的随机数
func randNumGen(seed int64) float64{
	gorand.Seed(seed)
	return float64(gorand.Intn(100000))/100000
}
//返回排好序的映射
func ranGenAndSort(arriveInterval int) map[int]float64{
	if arriveInterval==0{
		return nil
	}
	mappping := make(map[int]float64)
	for j := 0; j<arriveInterval; j++ {
		mappping[j] = randNumGen(rand.Int63())
	}
	//对map中的值进行排序
	var temp float64
	for i := 0; i < len(mappping)-1; i++ {
		for j := 0; j < len(mappping)-1-i; j++ {
			if (mappping[j] > mappping[j+1]) { // 相邻元素两两对比
				temp = mappping[j+1] // 元素交换
				mappping[j+1] = mappping[j]
				mappping[j] = temp
			}
		}
	}
	return mappping
}
 
func main(){
	var num int =  100000   //模拟数量（总时间段数）
	const serviceNum int = 5 //服务台数量
	var Lambda float64 = 2   //到达流强度,用作到达间隔，强度越大，固定时间间隔中到达数量更多
	var miu float64 = 3     //服务时间强度，强度越大，服务时间越小
 
	srcArrive := rand.New(rand.NewSource(uint64(time.Now().UnixNano())))
	time.Sleep(1) //sleep 1 ns
	srcServ := rand.New(rand.NewSource(uint64(time.Now().UnixNano())))
	pArriv := distuv.Poisson{Lambda,srcArrive} //顾客到达服从泊松分布
	pServ := distuv.Exponential{miu,srcServ}        //服务时间服从指数分布
 
	var flag bool
	var arriveInterval int
	var N, TotalArrive, arriveTime,arriveTimeBase, serviceTime, serviceTimeRate float64
	var serviceEndTime [serviceNum]float64
	var arriveTimeMap map[int]float64
 
	//共循环测试num个时间段
	for i:=0;i<num;i++{
		flag = false
		arriveInterval = int(pArriv.Rand())
		if arriveInterval==0 {
			arriveTime += 10
			continue
		}
		arriveTimeMap = ranGenAndSort(arriveInterval)
		TotalArrive += float64(arriveInterval)
		arriveTimeBase = float64(i*10)
 
		//循环验证一个时间段内到达的每个顾客是否可以接受服务
		for j := 0; j<arriveInterval; j++ {
			flag = false
			arriveTime = arriveTimeMap[j] * 10 + arriveTimeBase //具体到达时间，每个时间段固定为10个单位
			//在s个服务台中查找空闲的服务台
			for s:=0;s<serviceNum ;s++  {
				if ( arriveTime >= serviceEndTime[s] ){
					serviceTimeRate = pServ.Rand()
					serviceTime = serviceTimeRate*10
					serviceEndTime[s] = arriveTime +serviceTime //若本服务台对其进行服务，则更新服务结束时间
					flag = true
					break
				}
			}
			//fmt.Printf("arriveInterval: %v,  arriveTime:%v,  serviceTime:%v,  serviceEndTime:%v, service: %v\n",arriveInterval,arriveTime,serviceTime,serviceEndTime, flag)
			//s个服务台循环完成后仍未改变flag的值，即未能接受服务，则loss加1
			if !flag {
				N = N + 1
			}
		}
	}
 
	if TotalArrive==0 {
		fmt.Println("Error testing ")
	}else{
		fmt.Println("LossNumber, TotalArrive,and LossRate:",N, TotalArrive, N/TotalArrive)
	}
}