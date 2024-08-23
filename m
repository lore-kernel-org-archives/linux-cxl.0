Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFD1C8245
	for <linux-cxl@vger.kernel.org>; Fri, 23 Aug 2024 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451554; cv=none; b=d5cL86d6uayIlKm9IS1A1eph1yJxakLaKHZp8SZdCGI0RiPXDitFjC5zhZgDofm+fRqdjRlUPzOX7uWRZIwKjQiMjQTsHgRs0BlQ5Z3snXZfrx/MBQXzKVVJ5F4ZYpGTH5KJh0phgN8oI2M+LHVqEi9KuvSOMRDCWqzppwqerCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451554; c=relaxed/simple;
	bh=wE5MeZ/TfiicdYafgD6Teglz+CEKSXVRhEU2cDL5wL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGyBwfrCvhd+bjbaW+bRaQaNLyE8UrLpjc+OOgegjgAsuAh5G7GoPemzFT1kaziU/PY4Cm3wTQd6djtc0RUIlYdn3lJUzp+8GQyZvVEDvIuRMMG0DxIeJZiIMvI/UvEI78wWeGE9Ui0EhxTPGP1klW/NTa+aPu7XrIsqHZm9EbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=mUN+84QF; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="mUN+84QF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724451552;
	bh=hK2bUFwzHVU9grr2BqVFrLx3aTZWAKPQfP4qaJ8H2Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=mUN+84QFaZuSrBcDE9KTp4A3/ubk9jWcEov5iVmtmM6h6xBwf15zvolDvSXWWLtrQ
	 86vqzxGJBjJw5uh5FD1QaLq7tSgHIot/gj/g1gw4r0w9OTHDHjvsN5l8zCG+ZptDla
	 sqVSCNZ6AAsBFy7e+qsxnYI4QWtra5UUK53dKpKOIb4in98eSAzWfSCuMyhWJ+O12i
	 N2ky9emoOvUF9PnJG/PK6FWe9KSxfQts+Tm+bqrOFuZREKUSE4kOw1hS17SH595Bqw
	 /KuoC9kaJYtAnQc5nZtgFeerd64r96WvjibGPj99vGbm0YSBRZ4ALz2BDHyiseci2a
	 VQO8sYNphLOHw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id E7E2BDC024C;
	Fri, 23 Aug 2024 22:19:01 +0000 (UTC)
Message-ID: <9030e7e9-7255-497e-be4c-5bba3a373a54@icloud.com>
Date: Sat, 24 Aug 2024 06:18:56 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/region: Prevent device_find_child() from
 modifying caller's match data
To: Ira Weiny <ira.weiny@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-2-8316b87b8ff9@quicinc.com>
 <66c4a136d9764_2ddc2429435@iweiny-mobl.notmuch>
 <dec374a6-073d-4b7f-9e83-adcfcf672852@icloud.com>
 <66c8d0a7eddc5_a87cd294e1@iweiny-mobl.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <66c8d0a7eddc5_a87cd294e1@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OEcYKCeKl2lrSiKKOvGo38JYgj9Rul2W
X-Proofpoint-GUID: OEcYKCeKl2lrSiKKOvGo38JYgj9Rul2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408230165

On 2024/8/24 02:10, Ira Weiny wrote:
> Zijun Hu wrote:
>> On 2024/8/20 21:59, Ira Weiny wrote:
>>> Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> To prepare for constifying the following old driver core API:
>>>>
>>>> struct device *device_find_child(struct device *dev, void *data,
>>>> 		int (*match)(struct device *dev, void *data));
>>>> to new:
>>>> struct device *device_find_child(struct device *dev, const void *data,
>>>> 		int (*match)(struct device *dev, const void *data));
>>>>
>>>> The new API does not allow its match function (*match)() to modify
>>>> caller's match data @*data, but match_free_decoder() as the old API's
>>>> match function indeed modifies relevant match data, so it is not
>>>> suitable for the new API any more, fixed by implementing a equivalent
>>>> cxl_device_find_child() instead of the old API usage.
>>>
>>> Generally it seems ok but I think some name changes will make this more
>>> clear.  See below.
>>>
>>
>> okay.
>>
>>> Also for those working on CXL I'm questioning the use of ID here and the
>>> dependence on the id's being added to the parent in order.  Is that a
>>> guarantee?
>>>
>>>>
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>>  drivers/cxl/core/region.c | 36 +++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 35 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 21ad5f242875..8d8f0637f7ac 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -134,6 +134,39 @@ static const struct attribute_group *get_cxl_region_access1_group(void)
>>>>  	return &cxl_region_access1_coordinate_group;
>>>>  }
>>>>  
>>>> +struct cxl_dfc_data {
>>>
>>> struct cxld_match_data
>>>
>>> 'cxld' == cxl decoder in our world.
>>>
>>
>> make sense.
>>
>>>> +	int (*match)(struct device *dev, void *data);
>>>> +	void *data;
>>>> +	struct device *target_device;
>>>> +};
>>>> +
>>>> +static int cxl_dfc_match_modify(struct device *dev, void *data)
>>>
>>> Why not just put this logic into match_free_decoder?
>>>
>>
>> Actually, i ever considered solution B as you suggested in the end.
>>
>> For this change, namely, solution A:
>> 1) this change is clearer and easier to understand.
>> 2) this change does not touch any existing cxld logic
>>
>> For solution B:
>> it is more reasonable
>>
>> i finally select A since it can express my concern and relevant solution
>> clearly.
> 
> Understood.
> 
>>
>>>> +{
>>>> +	struct cxl_dfc_data *dfc_data = data;
>>>> +	int res;
>>>> +
>>>> +	res = dfc_data->match(dev, dfc_data->data);
>>>> +	if (res && get_device(dev)) {
>>>> +		dfc_data->target_device = dev;
>>>> +		return res;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * I have the same function as device_find_child() but allow to modify
>>>> + * caller's match data @*data.
>>>> + */
>>>
>>> No need for this comment after the new API is established.
>>>
>>
>> i have given up the idea within v1 to introduce a new API which *should
>> ONLY* be used by this patch series, so it is not worthy of a new API
>> even if it can bring convenient for this patch series.
> 
> I'm not clear on this.  Are you still proposing to change the parameter to
> const?
> 
yes.
>>
>>>> +static struct device *cxl_device_find_child(struct device *parent, void *data,
>>>> +					    int (*match)(struct device *dev, void *data))
>>>> +{
>>>> +	struct cxl_dfc_data dfc_data = {match, data, NULL};
>>>> +
>>>> +	device_for_each_child(parent, &dfc_data, cxl_dfc_match_modify);
>>>> +	return dfc_data.target_device;
>>>> +}
>>>> +
>>>>  static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
>>>>  			 char *buf)
>>>>  {
>>>> @@ -849,7 +882,8 @@ cxl_region_find_decoder(struct cxl_port *port,
>>>>  		dev = device_find_child(&port->dev, &cxlr->params,
>>>>  					match_auto_decoder);
>>>>  	else
>>>> -		dev = device_find_child(&port->dev, &id, match_free_decoder);
>>>> +		dev = cxl_device_find_child(&port->dev, &id,
>>>> +					    match_free_decoder);
>>>
>>> This is too literal.  How about the following (passes basic cxl-tests).
>>>
>>
>> it is reasonable.
>>
>> do you need me to submit that you suggest in the end and add you as
>> co-developer ?
> 
> You can submit it with Suggested-by:
> 
okay.
>>
>> OR
>>
>> you submit it by yourself ?
>>
>> either is okay for me.
>>
>>> Ira
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c              
>>> index 21ad5f242875..c1e46254efb8 100644                                         
>>> --- a/drivers/cxl/core/region.c                                                 
>>> +++ b/drivers/cxl/core/region.c                                                 
>>> @@ -794,10 +794,15 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>>>         return rc;                                                              
>>>  }                                                                              
>>>                                                                                 
>>> +struct cxld_match_data {                                                       
>>> +       int id;                                                                 
>>> +       struct device *target_device;                                           
>>> +};                                                                             
>>> +                                                                               
>>>  static int match_free_decoder(struct device *dev, void *data)                  
>>>  {                                                                              
>>> +       struct cxld_match_data *match_data = data;                              
>>>         struct cxl_decoder *cxld;                                               
>>> -       int *id = data;                                                         
>>>                                                                                 
>>>         if (!is_switch_decoder(dev))                                            
>>>                 return 0;                                                       
>>> @@ -805,17 +810,30 @@ static int match_free_decoder(struct device *dev, void *data)
>>>         cxld = to_cxl_decoder(dev);                                             
>>>                                                                                 
>>>         /* enforce ordered allocation */                                        
>>> -       if (cxld->id != *id)                                                    
>>> +       if (cxld->id != match_data->id)                                         
>>>                 return 0;                                                       
>>>                                                                                 
>>> -       if (!cxld->region)                                                      
>>> +       if (!cxld->region && get_device(dev)) {                                 
>>
>> get_device(dev) failure may cause different logic against existing
>> but i think it should be impossible to happen normally.
> 
> Indeed this is slightly different.  :-/
> 
> Move the get_device() to find_free_decoder()?
> 
i think we can keep your change. so ignore this slight difference.
i also notice that you have done some verification for this change.
> Ira
> 
>>
>>> +               match_data->target_device = dev;                                
>>>                 return 1;                                                       
>>> +       }                                                                       
>>>                                                                                 
>>> -       (*id)++;                                                                
>>> +       match_data->id++;                                                       
>>>                                                                                 
>>>         return 0;                                                               
>>>  }                                                                              
>>>                                                                                 
>>> +static struct device *find_free_decoder(struct device *parent)                 
>>> +{                                                                              
>>> +       struct cxld_match_data match_data = {                                   
>>> +               .id = 0,                                                        
>>> +               .target_device = NULL,                                          
>>> +       };                                                                      
>>> +                                                                               
>>> +       device_for_each_child(parent, &match_data, match_free_decoder);         
>>> +       return match_data.target_device;                                        
>>> +}                                                                              
>>> +                                                                               
> 
> [snip]

