Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD221AACB
	for <linux-cxl@vger.kernel.org>; Tue, 20 Aug 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724161240; cv=none; b=Tf7lcM4Fvu6hDyjtebJLCYygEBtgNWEuJqFhcy60q6Wh3s4ZqWTi+8dcF/UCXlHuSVxSQ3xO92ay+0PesxGhGA+BG8RbrdAPOFskpAl93gqlmuwInKhKpn3dxpJnpXbVip0kGikUVXUfJ4M7z8KArP1ixYuStU+b85No602pK48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724161240; c=relaxed/simple;
	bh=upamO/zsB6rxCI8+LBk1aglbA8pmuHyWtSjpsXZ4qY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOSQ7aqFglP5BmgOj9Dxi02qqYLc9j5OeZ1+DDkcGhmoOFeI7BOZnABoihZgLPrmEDWk3DoNNFV4K3anXmyk1mKnzpzxTtHz4nYmO6Kvaqy2JITryZgHnSkMHmGuegjnIqOlGfx8ydTppXGRuvEHHd7bvk+Zx4HJ98sJB4kh+Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Cb+Hix1/; arc=none smtp.client-ip=17.58.6.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Cb+Hix1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1724161239;
	bh=TT/LBHFFfw+sqeDq9jX/+oamVLetFWgvhvk3Yjmswbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=Cb+Hix1/TL1c++twUnSuWXKWrAsrSpMhHY0xo3hTBVK0IQQL6HGC48SDeSPgpEynM
	 LcyI3b7qGXi56Q4O3AegpN/gTuPtQ71p6tFxEY5L5HNb9nX/QuSUTiUpO2JirxNiel
	 wvGipsD5ERi9fH4ahZ+0MA1jVPW2VVuqSucOEFtVbjzLrwa2wyutCi9idp7TqsBPhp
	 8z6ERTajDMXBRN5vsMJGg8fOcqcDEjkxum0rgaj6ZEL/JuCDFCmQ0AFzSHJk9xrV59
	 n3Hl2sj+9VLS59xH9V2oejrVb41UJah6/5FC+1XxSh/eT9L+uMMyfMSzaDQhIakkFV
	 W3/fh+FzXqoDg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 33BC1180418;
	Tue, 20 Aug 2024 13:40:28 +0000 (UTC)
Message-ID: <2b9fc661-e061-4699-861b-39af8bf84359@icloud.com>
Date: Tue, 20 Aug 2024 21:40:23 +0800
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
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <66c491c32091d_2ddc24294e8@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YdqiHEQoPhOMJYBRg-96x8Cf4_TimD2Z
X-Proofpoint-ORIG-GUID: YdqiHEQoPhOMJYBRg-96x8Cf4_TimD2Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408200101

On 2024/8/20 20:53, Ira Weiny wrote:
> Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> The following API cluster takes the same type parameter list, but do not
>> have consistent parameter check as shown below.
>>
>> device_for_each_child(struct device *parent, ...)  // check (!parent->p)
>> device_for_each_child_reverse(struct device *parent, ...) // same as above
>> device_find_child(struct device *parent, ...)      // check (!parent)
>>
> 
> Seems reasonable.
> 
> What about device_find_child_by_name()?
> 

Plan to simplify this API implementation by * atomic * API
device_find_child() as following:

https://lore.kernel.org/all/20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com
struct device *device_find_child_by_name(struct device *parent,
 					 const char *name)
{
	return device_find_child(parent, name, device_match_name);
}

>> Fixed by using consistent check (!parent || !parent->p) for the cluster.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/base/core.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 1688e76cb64b..b1dd8c5590dc 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4004,7 +4004,7 @@ int device_for_each_child(struct device *parent, void *data,
>>  	struct device *child;
>>  	int error = 0;
>>  
>> -	if (!parent->p)
>> +	if (!parent || !parent->p)
>>  		return 0;
>>  
>>  	klist_iter_init(&parent->p->klist_children, &i);
>> @@ -4034,7 +4034,7 @@ int device_for_each_child_reverse(struct device *parent, void *data,
>>  	struct device *child;
>>  	int error = 0;
>>  
>> -	if (!parent->p)
>> +	if (!parent || !parent->p)
>>  		return 0;
>>  
>>  	klist_iter_init(&parent->p->klist_children, &i);
>> @@ -4068,7 +4068,7 @@ struct device *device_find_child(struct device *parent, void *data,
>>  	struct klist_iter i;
>>  	struct device *child;
>>  
>> -	if (!parent)
>> +	if (!parent || !parent->p)
> 
> Perhaps this was just a typo which should have been.
> 
> 	if (!parent->p)
> ?
> 
maybe, but the following device_find_child_by_name() also use (!parent).

> I think there is an expectation that none of these are called with a NULL
> parent.
>

this patch aim is to make these atomic APIs have consistent checks as
far as possible, that will make other patches within this series more
acceptable.

i combine two checks to (!parent || !parent->p) since i did not know
which is better.

> Ira
> 
>>  		return NULL;
>>  
>>  	klist_iter_init(&parent->p->klist_children, &i);
>>
>> -- 
>> 2.34.1
>>
> 
> 

