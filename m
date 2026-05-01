Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F93BFE3E;
	Fri,  1 May 2026 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645333; cv=none; b=sP4REurgFiKIcJp6z+7Sno0yQJ564zWYknBdLzJiq8vn9uH3Ggw/rvdPTTBREexFDw7IFXTl5d6tXdMcAO5DggvDIpLho9kLcPNdgqEv8MyKmX0KScFNDozitNBPice1M3QIQndXytYJp+s9+W9xpDfuluFl0bvz37pSHizA4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645333; c=relaxed/simple;
	bh=yE75gpZ2PfXt5gFIZcgx0txl//8xRpFiuTlutRfxOFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYeFjwstIWim9juHggF2vwNdDbhCDOQWyPKIgDv1GJBodJqKzNxabiU4FeEC6cBUBwDx9y5GJNzwF/hxNoPnlGpeOmPv2PSnYKs1eSPL0QHNgSwtMj0HdU42To4nqeZM4oSjMXRVFWrDPNqDswPFw+Ib4phVRRsjj+x1gHMYlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mYrtdElD; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mYrtdElD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=WCtCeJH9YqsNjqonqKGq9p4NsH9uLbv8xmqKESwgF9M=;
	b=mYrtdElDHbzd317hQvpKtI0nFsoKIKbUzN69qUfGO3fbnisMbvVPULhXXfMha4
	iAze9bodGL0tKUCTzHKHs/CSrwBKtdeFAFbL/IJNqgIPmXFiSL+5RxMaH8+wbxil
	/LGZqflaFJlOSz6fl1fDViclXzqHfqcSGEd1Rk3t/MYXc=
Received: from [IPV6:240e:b8f:927e:5900:a6da:de99:5aab:66f2] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCXHCbstvRpdlxgCw--.40948S2;
	Fri, 01 May 2026 22:21:33 +0800 (CST)
Message-ID: <e8194607-c888-4c36-8303-c245315ac2c1@163.com>
Date: Fri, 1 May 2026 22:21:33 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core: Use FIELD_MODIFY()
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430162718.43536-1-18255117159@163.com>
 <6bc8cd86-e37e-4742-994c-6781e8f4ce50@intel.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <6bc8cd86-e37e-4742-994c-6781e8f4ce50@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCXHCbstvRpdlxgCw--.40948S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4kuFW5Ar18Ww1DJF1fWFg_yoW8WF4UpF
	4UCFWjkFW8ta1fuFZFqF48KF1Fqa9rtFWkWa4jqas8Zrn8XryDXryIyay3uwn8CFyfWF18
	X3W2vasxCay5GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR038OUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6w2AJGn0tu2uFwAA39



On 5/1/26 04:21, Dave Jiang wrote:
> 
> 
> On 4/30/26 9:27 AM, Hans Zhang wrote:
>> Use FIELD_MODIFY() to remove open-coded bit manipulation.
>> No functional change intended.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
> 
> Hi Hans. Thank you for the submission. For the CXL sub-system, we basically have agreed that we will only take cleanups if there are additional work in the area in order to avoid excessive churn in the code for ease of maintenance and debugging (i.e. git bisect). Appreciate the work though.

Hi Dave,

Thank you for you reply. I see.

Best regards,
Hans

> 
> DJ
>   
>> ---
>>   drivers/cxl/core/edac.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
>> index b321971fef58..a374e8ebac87 100644
>> --- a/drivers/cxl/core/edac.c
>> +++ b/drivers/cxl/core/edac.c
>> @@ -717,8 +717,7 @@ static int cxl_set_ecs_count_mode(struct device *dev, u8 *log_cap, u16 *config,
>>   		return -EINVAL;
>>   	}
>>   
>> -	*config &= ~CXL_ECS_COUNT_MODE_MASK;
>> -	*config |= FIELD_PREP(CXL_ECS_COUNT_MODE_MASK, val);
>> +	FIELD_MODIFY(CXL_ECS_COUNT_MODE_MASK, config, val);
>>   
>>   	return 0;
>>   }
>> @@ -729,8 +728,7 @@ static int cxl_set_ecs_reset_counter(struct device *dev, u8 *log_cap,
>>   	if (val != CXL_ECS_RESET_COUNTER)
>>   		return -EINVAL;
>>   
>> -	*config &= ~CXL_ECS_RESET_COUNTER_MASK;
>> -	*config |= FIELD_PREP(CXL_ECS_RESET_COUNTER_MASK, val);
>> +	FIELD_MODIFY(CXL_ECS_RESET_COUNTER_MASK, config, val);
>>   
>>   	return 0;
>>   }
>>
>> base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b

