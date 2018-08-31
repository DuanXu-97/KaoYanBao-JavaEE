package com.kyb.util;

import java.util.*;

public class AprioriUtil{
	
	private List<Set<String>> Event;//事务数据
	private int minSupport; //最小支持度
	private double minConfidence; // 最小置信度
	private int sum = 0;
	private List<Set<String>> freqItemSet;//频繁N项集
	
	public AprioriUtil(List<Set<String>> Event,int minSup, double minConf){    //构造函数
		this.Event = Event;
		this.minSupport = minSup;
		this.minConfidence = minConf;
		freqItemSet = new ArrayList<Set<String>>();
	}

    public Map<List<String>, List<String>> 	runApriori(){//运行Apriori算法,分为2步：1.挖掘频繁N项集；2.产生关联规则
		/*1.挖掘频繁N项集*/
		List<Set<String>>freqItem = new ArrayList<Set<String>>();
		Map<List<String>, List<String>>  map = new HashMap<List<String>,List<String>>();
        freqItem = Get1Item();//得到频繁一项集   
        freqItem = apriori_gen(freqItem);//得到频繁二项集
        //System.out.println(Event);
        while(freqItem.size() != 0){//得到频繁N项集
        	if(freqItem.size()!=0)
        	    freqItemSet = freqItem;	
        	freqItem = apriori_gen(freqItem);          	           
        }
        System.out.println("频繁项集共有："+freqItemSet.size()+"项");
        for(int i=0;i<freqItemSet.size();i++)
            System.out.println(freqItemSet.get(i));
        
        /*2.产生关联规则*/
        map = apriori_genRule();
        return map;
	}
	
	public List<Set<String>> Get1Item(){//遍历事件集，获得频繁一项集
		Map<String,Integer> candi = new HashMap<String,Integer>();//候选一项集
		List<Set<String>> item = new ArrayList<Set<String>>();//频繁一项集
		
		for(int i=0;i<Event.size();i++){
			Set<String> value = Event.get(i);
			Iterator it = value.iterator();
			while(it.hasNext()){//将set中的值放进候选一项集中，并计算频数
				Object str = it.next();
				if(candi.containsKey(str)){
					candi.put(str.toString(), candi.get(str)+1);
				}
				else
					candi.put(str.toString(), 1);
			}	
		}
		Iterator it3 = candi.entrySet().iterator(); 
		while(it3.hasNext()){ //根据支持度大小通过逐次比较得到频繁一项集
			Map.Entry a = (Map.Entry)it3.next();
			Set<String> b = new TreeSet<String>();
		    Object v = a.getValue(); 
		    Object t = a.getKey();
		    if(Integer.parseInt(v.toString()) >= minSupport){//比较支持度大小，符合要求则加入频繁一项集中
		    	b.add(t.toString());
	        	item.add(b);
		    }
		}
		//System.out.println(item);
		return item;	
	}   
					
	List<Set<String>> apriori_gen(List<Set<String>> preSet){//根据频繁(k-1)项集生成频繁k项集
        List<Set<String>> result = new ArrayList<Set<String>>();   
        int preSetSize = preSet.size(); 
        
        for (int i = 0; i < preSetSize - 1; i++) {   
            for (int j = i + 1; j < preSetSize; j++) {   
                String[] strA1 = preSet.get(i).toArray(new String[0]);   
                String[] strA2 = preSet.get(j).toArray(new String[0]);  
                
                int judge = 1;//连接判断，判断两个k-1项集是否符合连接成k项集的条件，不符合则将判断条件置为0
                if (strA1.length == strA2.length) {   
                    for (int m = 0; m < strA1.length - 1; m++) {   
                        if (!strA1[m].equals(strA2[m])) {   
                            judge = 0;   
                            break;   
                        }   
                    }   
                    if (strA1[strA1.length - 1].equals(strA2[strA2.length - 1]))    
                        judge = 0;   
                } 
                else    
                    judge = 0;                   
                
                if (judge==1) { 
                	Set<String> set = new TreeSet<String>();   
                    for (String str : strA1) {  
                    	set.add(str);  
                    }   
                    set.add((String) strA2[strA2.length - 1]); // 将两个项集连接在一起生成新的k项集   
                    
                  //剪枝步，判断k项集是否需要剪切掉，如果不需要被cut掉，则加入到k项集列表中 
                    List<Set<String>> subSets = getSubset(set); // 获得k项集的所有k-1项集   
                    for (Set<String> subSet : subSets) {  
                        if (isContained(preSet, subSet)) {//判断当前的k-1项集set是否在频繁k-1项集中出现，如出现，则不需要cut;
                        	//若没有出现，则需要被cut 
                        	result.add(set);
                        	break;
                        }   
                    }  
                }   
            }   
        }   
        return checkSupport(result);//将候选N项集转换成频繁N项集   
    }   

	List<Set<String>> checkSupport(List<Set<String>> setList) {/*扫描数据集，确定每个候选项集的支持度，
	求出支持度大于要求的项集并返回结果*/
        List<Set<String>> result = new ArrayList<Set<String>>();   
        boolean flag = true;   
        int[] counter = new int[setList.size()];   
        for (int i = 0; i < setList.size(); i++) { 
        	for (Set<String> dSets : Event) {   
            	//System.out.println(Event);
                if (setList.get(i).size() > dSets.size()) {   
                    flag = true;     
                } 
                else {     
                    for (String str : setList.get(i)) {   
                        if (!dSets.contains(str)) {   
                            flag = false;   
                            break;   
                        }   
                    }   
                    if (flag) {   
                        counter[i] += 1;   
                    } 
                    else {   
                        flag = true;   
                    }   
                }   
            }   
        }   
  
        for (int i = 0; i < setList.size(); i++) { 
        	//System.out.println(counter[i]);
            if (counter[i] >= minSupport) {   
                result.add(setList.get(i));   
            }   
        }   
        return result;   
    } 

	public  Map<List<String>, List<String>> checkConfidence(List<Set<String>> setList) {  /*扫描数据集，确定符合最小置信度的数据集并输出结果*/   
		Map<List<String>, List<String>>  map = new HashMap<List<String>,List<String>>();
		boolean flag = true;  
		int[] counter = new int[setList.size()]; 
		for (int i = 0; i < setList.size(); i++) { 
			for (Set<String> dSets : Event) {
				if (setList.get(i).size() > dSets.size()) {   
					flag = true;     					
				} 
				else {     
					for (String str : setList.get(i)) {  
						if (!dSets.contains(str)) {   
							flag = false;   
							break;   							
						}   						
					}   
					if (flag) {   
						counter[i] += 1;  						
					} 
					else {   
						flag = true; 						
					}   					
				}  				
			}   			
		}   
		for (int i = 0; i < setList.size()-1; i++) { 
			if ((float)counter[setList.size()-1]/counter[i] >= minConfidence) { 
				sum++;
				System.out.println("置信度为："+(float)counter[setList.size()-1]/counter[i] + 
						"     关联规则"+setList.get(i)+"->"+difference(setList.get(setList.size()-1),setList.get(i)));  
				List<String> result1 = new ArrayList<String>(setList.get(i));
				List<String> result2 = new  ArrayList<String>(difference(setList.get(setList.size()-1),setList.get(i)));
				map.put(result1, result2);
			}   			
		}
		return map;
	}
	
	public <T> Set<T> difference(Set<T> setA, Set<T> setB) { //求2个集合的差集 
	    Set<T> tmp = new TreeSet<T>(setA);  
	    tmp.removeAll(setB);  
	    return tmp;  
	  }

    boolean isContained(List<Set<String>> setList, Set<String> set) {//判断k项集的某k-1项集是否包含在频繁k-1项集列表中
        boolean flag = false;   
        int position = 0;   
        for (Set<String> s : setList) {   
  
            String[] sArr = s.toArray(new String[0]);   
            String[] setArr = set.toArray(new String[0]);   
            for (int i = 0; i < sArr.length; i++) {   
                if (sArr[i].equals(setArr[i])) { // 如果对应位置的元素相同，则position为当前位置的值   
                    position = i;   
                } else {   
                    break;   
                }   
            }// 如果position等于了数组的长度，说明已找到某个setList中的集合与 set集合相同了，退出循环，返回包含   
             // 否则，把position置为0进入下一个比较   
            if (position == sArr.length - 1) {   
                flag = true;   
                break;   
            } 
            else {   
                flag = false;   
                position = 0;   
            }   
  
        }   
        return flag;   
    }   
  
    List<Set<String>> getSubset(Set<String> set) {//获取k项集的所有k-1项集   
        List<Set<String>> result = new ArrayList<Set<String>>();   
        String[] setArr = set.toArray(new String[0]);   
        for (int i = 0; i < setArr.length; i++) {   
            Set<String> subSet = new TreeSet<String>();   
            for (int j = 0; j < setArr.length; j++) {   
                if (i != j){   
                    subSet.add((String) setArr[j]);   
                }   
            }   
            result.add(subSet);   
        }   
        return result;   
    } 
    
   public Map<List<String>, List<String>>  apriori_genRule(){//生成关联规则
    	List<Set<String>> tSubSet = new ArrayList<Set<String>>();
    	Map<List<String>, List<String>> map =  new HashMap<List<String>,List<String>>();
    	Map<List<String>, List<String>> result_map =  new HashMap<List<String>,List<String>>();
    	int size = freqItemSet.size();
        for(int i = 0;i<size;i++){
        	map = checkConfidence(getAllSet(freqItemSet.get(i)));
        	result_map.putAll(map);
        }
        return result_map;     
    }
    
    List<Set<String>> getAllSet(Set<String> set){//得到一个频繁k项集的所有真子集
    	List<Set<String>> result = new ArrayList<Set<String>>();
        String [] setArr = set.toArray(new String[0]);
    	int length = set.size();
        int i;
        
        for(i=0;i<(1<<length);i++){
            Set<String> subSet = new TreeSet<String>();
            for(int j=0;j<length;j++){                
                if((i&(1<<j))!=0 ){
                    subSet.add(setArr[j]);       
                }
            }
            result.add(subSet);                 
        }
        result.remove(0);//去除空子集
    	return result;
    }
    


}
