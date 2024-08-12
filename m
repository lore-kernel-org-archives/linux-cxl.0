Received: from pv50p00im-ztbu10011701.me.com (pv50p00im-ztbu10011701.me.com [17.58.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968C13E022
	for <linux-cxl@vger.kernel.org>; Mon, 12 Aug 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476784; cv=none; b=ggXRWvtWHqp7xRuTdyirNsLbo34MrgKZ8Y9CERp2U2AT4RxhX7ioeSFmb8uQbR2u3NnkatpK2gpMupsScDwAerEoBX98ld1BjMlGLFrSSMWeBWCmoy4BIW5idD0k95mlU+p2yHpDHLxIyU/6tW8kZXPJzK8NDKl3vffsV7Jwj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476784; c=relaxed/simple;
	bh=Z8keleVQaZSPYFwF4RDgglZjRMhM2lbfzOkGzyC1PHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faTKVRYP3fNNEtW865REe+9pDCI+8hXGL6B3CzL1PtqmIKUn5Dr//xJYB2tnfq2+HJYm85tGwaC8hWOqAJf7UyVhW04Cl9plP0qKFB3gEFrw0vQiRmkdDqT7JytNrZs9zMrfYSy4PNff2MMeg6U3ND9mHNaSu2tb4Bt0aHkv+tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MLGWhQXr; arc=none smtp.client-ip=17.58.6.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MLGWhQXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723476781;
	bh=1ygoIY34DpHpdiG93Vm93P4CtKs9wFvzJlP3kZKA0zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	b=MLGWhQXrRrtEmUM+3HR4kjVzQE4DGEIjk3W7wSMIQjAFWm7sY6j1AVLnin//GnPGX
	 U3iJGrmmtEv3FeZcKDtanpHlrfX42F2KSvfcj5qBa+OvKR0EJTmGc12BPDQlGP0ZFD
	 dK3x5iSHWgTuyMV+d6XgivQ+tuYL1V6ozvJBo9z2VZuBDGyTxW2cUR8NJ5pvun7EOu
	 A2vIxzmJQEXvRhRRO3ulSJx5qz2rDtwM/tjqvjLSRSJ13hNGqBrXnfbKkCIF/zcdXU
	 FnJOMHwCwc8VoXglYrE+7xZdFyH/Mmfyi/Fn26Glbkdb/w2VfaakUURcBWWg+XlU/m
	 7/pp5f3TGhidA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 13EC774033A;
	Mon, 12 Aug 2024 15:32:49 +0000 (UTC)
Message-ID: <8b8ce122-f16b-4207-b03b-f74b15756ae7@icloud.com>
Date: Mon, 12 Aug 2024 23:32:44 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cxl/region: Prevent device_find_child() from
 modifying caller's match data
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com>
 <20240811-const_dfc_prepare-v1-3-d67cc416b3d3@quicinc.com>
 <f057f74b-07fa-433d-b906-011186eb86a7@intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <f057f74b-07fa-433d-b906-011186eb86a7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: O7I-WFbO3x8gLaTs8JuaLOQ3i5K4AsDc
X-Proofpoint-ORIG-GUID: O7I-WFbO3x8gLaTs8JuaLOQ3i5K4AsDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_04,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408120115

On 2024/8/12 20:54, Przemek Kitszel wrote:
> On 8/11/24 02:18, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> It does not make sense for match_free_decoder() as device_find_child()'s
>> match function to modify caller's match data, 
> 
> match_free_decoder() is just doing that, treating caller's match data as
> a piece of memory to store their int.
> (So it is hard to tell it does not make sense "for [it] ... to").
> 

Thanks for reply (^^)

The ultimate goal is to make device_find_child() have below prototype:

struct device *device_find_child(struct device *dev, const void *data,
		int (*match)(struct device *dev, const void *data));

Why ?

(1) It does not make sense, also does not need to, for such device
finding operation to modify caller's match data which is mainly
used for comparison.

(2) It will make the API's match function parameter have the same
signature as all other APIs (bus|class|driver)_find_device().


My idea is that:
use device_find_child() for READ only accessing caller's match data.

use below API if need to Modify caller's data as
constify_device_find_child_helper() does.
int device_for_each_child(struct device *dev, void *data,
                    int (*fn)(struct device *dev, void *data));


So match_free_decoder() is not proper as device_find_child()'s
match function.

>> fixed by using
>> constify_device_find_child_helper() instead of device_find_child().
> 
> I don't like the constify... name, I would go with something like
> device_find_child_mut() or similar.
> 

What about below alternative option i ever thought about ?

Don't introduce API constify_device_find_child_helper() at all, and
change in involved driver such as cxl/core/region.c directly.

>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>   drivers/cxl/core/region.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..266231d69dff 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -849,7 +849,8 @@ cxl_region_find_decoder(struct cxl_port *port,
>>           dev = device_find_child(&port->dev, &cxlr->params,
>>                       match_auto_decoder);
>>       else
>> -        dev = device_find_child(&port->dev, &id, match_free_decoder);
>> +        dev = constify_device_find_child_helper(&port->dev, &id,
>> +                            match_free_decoder);
>>       if (!dev)
>>           return NULL;
>>       /*
>>
> 

