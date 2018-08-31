package com.kyb.util;

import java.util.*;

public class AprioriUtil{
	
	private List<Set<String>> Event;//��������
	private int minSupport; //��С֧�ֶ�
	private double minConfidence; // ��С���Ŷ�
	private int sum = 0;
	private List<Set<String>> freqItemSet;//Ƶ��N�
	
	public AprioriUtil(List<Set<String>> Event,int minSup, double minConf){    //���캯��
		this.Event = Event;
		this.minSupport = minSup;
		this.minConfidence = minConf;
		freqItemSet = new ArrayList<Set<String>>();
	}

    public Map<List<String>, List<String>> 	runApriori(){//����Apriori�㷨,��Ϊ2����1.�ھ�Ƶ��N���2.������������
		/*1.�ھ�Ƶ��N�*/
		List<Set<String>>freqItem = new ArrayList<Set<String>>();
		Map<List<String>, List<String>>  map = new HashMap<List<String>,List<String>>();
        freqItem = Get1Item();//�õ�Ƶ��һ�   
        freqItem = apriori_gen(freqItem);//�õ�Ƶ�����
        //System.out.println(Event);
        while(freqItem.size() != 0){//�õ�Ƶ��N�
        	if(freqItem.size()!=0)
        	    freqItemSet = freqItem;	
        	freqItem = apriori_gen(freqItem);          	           
        }
        System.out.println("Ƶ������У�"+freqItemSet.size()+"��");
        for(int i=0;i<freqItemSet.size();i++)
            System.out.println(freqItemSet.get(i));
        
        /*2.������������*/
        map = apriori_genRule();
        return map;
	}
	
	public List<Set<String>> Get1Item(){//�����¼��������Ƶ��һ�
		Map<String,Integer> candi = new HashMap<String,Integer>();//��ѡһ�
		List<Set<String>> item = new ArrayList<Set<String>>();//Ƶ��һ�
		
		for(int i=0;i<Event.size();i++){
			Set<String> value = Event.get(i);
			Iterator it = value.iterator();
			while(it.hasNext()){//��set�е�ֵ�Ž���ѡһ��У�������Ƶ��
				Object str = it.next();
				if(candi.containsKey(str)){
					candi.put(str.toString(), candi.get(str)+1);
				}
				else
					candi.put(str.toString(), 1);
			}	
		}
		Iterator it3 = candi.entrySet().iterator(); 
		while(it3.hasNext()){ //����֧�ֶȴ�Сͨ����αȽϵõ�Ƶ��һ�
			Map.Entry a = (Map.Entry)it3.next();
			Set<String> b = new TreeSet<String>();
		    Object v = a.getValue(); 
		    Object t = a.getKey();
		    if(Integer.parseInt(v.toString()) >= minSupport){//�Ƚ�֧�ֶȴ�С������Ҫ�������Ƶ��һ���
		    	b.add(t.toString());
	        	item.add(b);
		    }
		}
		//System.out.println(item);
		return item;	
	}   
					
	List<Set<String>> apriori_gen(List<Set<String>> preSet){//����Ƶ��(k-1)�����Ƶ��k�
        List<Set<String>> result = new ArrayList<Set<String>>();   
        int preSetSize = preSet.size(); 
        
        for (int i = 0; i < preSetSize - 1; i++) {   
            for (int j = i + 1; j < preSetSize; j++) {   
                String[] strA1 = preSet.get(i).toArray(new String[0]);   
                String[] strA2 = preSet.get(j).toArray(new String[0]);  
                
                int judge = 1;//�����жϣ��ж�����k-1��Ƿ�������ӳ�k������������������ж�������Ϊ0
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
                    set.add((String) strA2[strA2.length - 1]); // �������������һ�������µ�k�   
                    
                  //��֦�����ж�k��Ƿ���Ҫ���е����������Ҫ��cut��������뵽k��б��� 
                    List<Set<String>> subSets = getSubset(set); // ���k�������k-1�   
                    for (Set<String> subSet : subSets) {  
                        if (isContained(preSet, subSet)) {//�жϵ�ǰ��k-1�set�Ƿ���Ƶ��k-1��г��֣�����֣�����Ҫcut;
                        	//��û�г��֣�����Ҫ��cut 
                        	result.add(set);
                        	break;
                        }   
                    }  
                }   
            }   
        }   
        return checkSupport(result);//����ѡN�ת����Ƶ��N�   
    }   

	List<Set<String>> checkSupport(List<Set<String>> setList) {/*ɨ�����ݼ���ȷ��ÿ����ѡ���֧�ֶȣ�
	���֧�ֶȴ���Ҫ���������ؽ��*/
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

	public  Map<List<String>, List<String>> checkConfidence(List<Set<String>> setList) {  /*ɨ�����ݼ���ȷ��������С���Ŷȵ����ݼ���������*/   
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
				System.out.println("���Ŷ�Ϊ��"+(float)counter[setList.size()-1]/counter[i] + 
						"     ��������"+setList.get(i)+"->"+difference(setList.get(setList.size()-1),setList.get(i)));  
				List<String> result1 = new ArrayList<String>(setList.get(i));
				List<String> result2 = new  ArrayList<String>(difference(setList.get(setList.size()-1),setList.get(i)));
				map.put(result1, result2);
			}   			
		}
		return map;
	}
	
	public <T> Set<T> difference(Set<T> setA, Set<T> setB) { //��2�����ϵĲ 
	    Set<T> tmp = new TreeSet<T>(setA);  
	    tmp.removeAll(setB);  
	    return tmp;  
	  }

    boolean isContained(List<Set<String>> setList, Set<String> set) {//�ж�k���ĳk-1��Ƿ������Ƶ��k-1��б���
        boolean flag = false;   
        int position = 0;   
        for (Set<String> s : setList) {   
  
            String[] sArr = s.toArray(new String[0]);   
            String[] setArr = set.toArray(new String[0]);   
            for (int i = 0; i < sArr.length; i++) {   
                if (sArr[i].equals(setArr[i])) { // �����Ӧλ�õ�Ԫ����ͬ����positionΪ��ǰλ�õ�ֵ   
                    position = i;   
                } else {   
                    break;   
                }   
            }// ���position����������ĳ��ȣ�˵�����ҵ�ĳ��setList�еļ����� set������ͬ�ˣ��˳�ѭ�������ذ���   
             // ���򣬰�position��Ϊ0������һ���Ƚ�   
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
  
    List<Set<String>> getSubset(Set<String> set) {//��ȡk�������k-1�   
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
    
   public Map<List<String>, List<String>>  apriori_genRule(){//���ɹ�������
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
    
    List<Set<String>> getAllSet(Set<String> set){//�õ�һ��Ƶ��k����������Ӽ�
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
        result.remove(0);//ȥ�����Ӽ�
    	return result;
    }
    


}
