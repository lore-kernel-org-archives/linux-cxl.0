Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813B19993B
	for <linux-cxl@vger.kernel.org>; Wed, 21 Aug 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251483; cv=none; b=olDISC1rxslC7voWAU0kPlfS9OY+8jn06yrrJDw1DYIeAdyF+Zws0xnPT/12gNrvuNe8arIJpOiGIeDpNXdh5jhrMZclXHb8cGkrtOJN9kojGTb8WxHbSTUa5zVO8OwBm9w19KFhtgusSPYurnnKWDMVOKeYPL6bPJ8z4/a1D2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251483; c=relaxed/simple;
	bh=2tKIiKfoZ8VghTQB5t1Hh7d6soUoOkPtHP3FiyiTcw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFBrbrI2LxBUd0PxFq2I3qIPT++xKCNVzWnrRnq0/ErXiGvNvwJfI4Z529MBzhLQMy3q7zTd1avPJ5r3vgo/aGXxQCdn4oE7CHXinQtsXZf0TuE4uVWdj5HR3qQZunHaHp/UW9b12sQLd4LhXib91MSk75TDByyD7tvM2xLFzjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=VgnJ6WaC; arc=none smtp.client-ip=17.58.6.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="VgnJ6WaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724251480;
	bh=+IlZOsCHpIR8J4pUdNx8yhJpA5oS3nbEe6dWBspH5WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=VgnJ6WaCejYFIQC+3I04YUhkx2CcHjHu2Xgj98WH/gX1l5O4d3yfi58k92jahNYtP
	 bCoauqLc2L4EeUbJEdMOWSTa1Odf2Z/rz7UjSh1jIFWiZnOD0bGRtpjTLHCjUr7Fgv
	 sAPXiKP7ayI8vLeomELKx2FgHtHRQ0ofS2ZE/tsPCejaiXnfIR8+APTFtuqBdi3mnI
	 YDwNYd/BRxzdi44/3Y/y52i0xF5KitAFa2WIoloNQP9VXi9UuYA7luFCL+whHPb8Dd
	 uzMbEc8eibco46DHABY8R5NONBpP2P7eFOjpgI9YnFgf/fO9oHMYITtefe8snxgHko
	 kzVVph21UqY7Q==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 9CFC7DC00C0;
	Wed, 21 Aug 2024 14:44:31 +0000 (UTC)
Message-ID: <e30eac3b-4244-460d-ab0b-baaa659999fe@icloud.com>
Date: Wed, 21 Aug 2024 22:44:27 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] driver core: Make parameter check consistent for
 API cluster device_(for_each|find)_child()
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
 <20240815-const_dfc_prepare-v2-1-8316b87b8ff9@quicinc.com>
 <66c491c32091d_2ddc24294e8@iweiny-mobl.notmuch>
 <2b9fc661-e061-4699-861b-39af8bf84359@icloud.com>
 <66c4a4e15302b_2f02452943@iweiny-mobl.notmuch>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <66c4a4e15302b_2f02452943@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2ijc-wPiu7wQ-kCijDGnu9IB_Y5Izig2
X-Proofpoint-GUID: 2ijc-wPiu7wQ-kCijDGnu9IB_Y5Izig2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408210107

On 2024/8/20 22:14, Ira Weiny wrote:
> Zijun Hu wrote:
>> On 2024/8/20 20:53, Ira Weiny wrote:
>>> Zijun Hu wrote:
>>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>
>>>> The following API cluster takes the same type parameter list, but do not
>>>> have consistent parameter check as shown below.
>>>>
>>>> device_for_each_child(struct device *parent, ...)  // check (!parent->p)
>>>> device_for_each_child_reverse(struct device *parent, ...) // same as above
>>>> device_find_child(struct device *parent, ...)      // check (!parent)
>>>>
>>>
>>> Seems reasonable.
>>>
>>> What about device_find_child_by_name()?
>>>
>>
>> Plan to simplify this API implementation by * atomic * API
>> device_find_child() as following:
>>
>> https://lore.kernel.org/all/20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com
>> struct device *device_find_child_by_name(struct device *parent,
>>  					 const char *name)
>> {
>> 	return device_find_child(parent, name, device_match_name);
>> }
> 
> Ok.  Thanks.
> 
>>
>>>> Fixed by using consistent check (!parent || !parent->p) for the cluster.
>>>>
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>>  drivers/base/core.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>> index 1688e76cb64b..b1dd8c5590dc 100644
>>>> --- a/drivers/base/core.c
>>>> +++ b/drivers/base/core.c
>>>> @@ -4004,7 +4004,7 @@ int device_for_each_child(struct device *parent, void *data,
>>>>  	struct device *child;
>>>>  	int error = 0;
>>>>  
>>>> -	if (!parent->p)
>>>> +	if (!parent || !parent->p)
>>>>  		return 0;
>>>>  
>>>>  	klist_iter_init(&parent->p->klist_children, &i);
>>>> @@ -4034,7 +4034,7 @@ int device_for_each_child_reverse(struct device *parent, void *data,
>>>>  	struct device *child;
>>>>  	int error = 0;
>>>>  
>>>> -	if (!parent->p)
>>>> +	if (!parent || !parent->p)
>>>>  		return 0;
>>>>  
>>>>  	klist_iter_init(&parent->p->klist_children, &i);
>>>> @@ -4068,7 +4068,7 @@ struct device *device_find_child(struct device *parent, void *data,
>>>>  	struct klist_iter i;
>>>>  	struct device *child;
>>>>  
>>>> -	if (!parent)
>>>> +	if (!parent || !parent->p)
>>>
>>> Perhaps this was just a typo which should have been.
>>>
>>> 	if (!parent->p)
>>> ?
>>>
>> maybe, but the following device_find_child_by_name() also use (!parent).
>>
>>> I think there is an expectation that none of these are called with a NULL
>>> parent.
>>>
>>
>> this patch aim is to make these atomic APIs have consistent checks as
>> far as possible, that will make other patches within this series more
>> acceptable.
>>
>> i combine two checks to (!parent || !parent->p) since i did not know
>> which is better.
> 
> I'm not entirely clear either.  But checking the member p makes more sense
> to me than the parent parameter.  I would expect that iterating the
> children of a device must be done only when the parent device is not NULL.
> 
> parent->p is more subtle.  I'm unclear why the API would need to allow
> that to run without error.
> 
i prefer (!parent || !parent->p) with below reasons:

1)
original API authors have such concern that either (!parent) or
(!parent->p) maybe happen since they are checked, all their concerns
can be covered by (!parent || !parent->p).

2)
It is the more robust than either (!parent) or (!parent->p)

3)
it also does not have any negative effect.

> Ira

