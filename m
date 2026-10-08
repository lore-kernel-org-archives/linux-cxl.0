Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73BA37204C;
	Thu,  8 Oct 2026 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493512; cv=none; b=QSiXxl3EilSeMABi7HYkZRg8rPZs9aiGBJitCTbMCFYAlTV81T1tVgMCPeDLiuXTHXPh9XkfJjfMngmlCMzd3kPRoKUajz2CoYNvCN0HQitL1nOI0UYWC07x0jfbOABpobMe3goLjLpIo7s6C6aUApsk+VNMik5tRkCNvcdQ98A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493512; c=relaxed/simple;
	bh=TuVojh4DaVLaPMV5QsmM9zrzY3BDBck5IQ24RL5aS7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYJLZ1DR/BcGlk+NVPXL6YwuaqxFU8WcCPlVU33/K6LM1+gmNbDvSqak2LYd/8G68m6JGjX4gAziwmErcuu1E8PcKmcnqCIHu+GneEKmgs9FqdigrHvOLIuqcohusSLU/3s0Q+jrbzNK+3HU9Thit0oRKWaiGHi8U8ys0Bvjh8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1aWOY6R; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1aWOY6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791493511; x=1823029511;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TuVojh4DaVLaPMV5QsmM9zrzY3BDBck5IQ24RL5aS7o=;
  b=Y1aWOY6R+nJ5i4y5+7jHn2FcXk/QxbJQE8uC8CuTN/0T18ggEYb77/iI
   lZPoeKqo3sg2Uw/VcQKT4ArTvpNXqB/g9GF5jcZVOzuI0RwyBKTh4Ek7R
   wkX1FUgnuGsiw6KKVdF57ZrUGMpQcKqzZU+Nsy3C2QgSaVQD/iEX5JzxD
   yV9YsYOdHszuiKy7286E/bP3lFZ//5ju5T2ecC2S35fyqNcJ74fFcuxlS
   cU4Oj+JsB6wuGJPEwvxVVeoOwYnfCWq7UGlOeKAm6u9G7pGj0B+E+TK+3
   +TfvNj8QYeIZZJhwxqToc0vf6k2QZQsQYU/Iq9LkJFyActiLU7rybxass
   w==;
X-CSE-ConnectionGUID: 8jvHxQmaTaijLjE9Sxwo4w==
X-CSE-MsgGUID: TIjbQvGVQuiM5C5zOgGxhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="283675"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="283675"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:05:11 -0700
X-CSE-ConnectionGUID: VuIRcOEPQSO67HuKVoja5A==
X-CSE-MsgGUID: ROwWPS3qSzyPrupSZmyNug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="1954753"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.51]) ([10.125.109.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 14:05:09 -0700
Message-ID: <3f40d953-2e91-4492-b100-c851fdb143b5@intel.com>
Date: Thu, 8 Oct 2026 14:05:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/region: Add region reference in memdev attach
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-3-alucerop@amd.com>
 <6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com>
 <8ebaae42-a0c6-4e9c-be1b-ca68a4769ed7@amd.com>
 <bd412198-8a25-436c-b6d6-6b6730e8c28e@intel.com>
 <9114ec71-060f-48ae-a6e5-0b46a881c259@amd.com>
 <40fc791c-c03c-42f0-88be-7a97938ebe1c@intel.com>
 <ba7731fe-f916-4e51-977b-95a0197bf52d@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <ba7731fe-f916-4e51-977b-95a0197bf52d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/8/26 11:07 AM, Lucero Palau, Alejandro wrote:
> 
> On 08/10/2026 17:18, Dave Jiang wrote:
>>
>> On 10/8/26 6:50 AM, Lucero Palau, Alejandro wrote:
>>> On 02/10/2026 16:52, Dave Jiang wrote:
>>>> On 10/1/26 9:41 PM, Lucero Palau, Alejandro wrote:
>>>>> On 01/10/2026 22:38, Dave Jiang wrote:
>>>>>> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>>>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>>>
>>>>>>> Use a new field in cxl_attach_region struct for easily link it with the
>>>>>>> region the memdev is attached to.
>>>>>>>
>>>>>>> This facilitates device links creation where such a region is the supplier
>>>>>>> with non-PF0 physical functions wanting to use the CXL region being the
>>>>>>> consumers.
>>>>>>>
>>>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>>>> ---
>>>>>>>     drivers/cxl/core/region.c | 1 +
>>>>>>>     drivers/cxl/cxlmem.h      | 2 ++
>>>>>>>     2 files changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>>>>> index 27e63e6dab7c..78ca7ebc3e55 100644
>>>>>>> --- a/drivers/cxl/core/region.c
>>>>>>> +++ b/drivers/cxl/core/region.c
>>>>>>> @@ -4132,6 +4132,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>>>>>>         if (rc)
>>>>>>>             return rc;
>>>>>>>     +    attach->cxlr = cxlr;
>>>>>>>         attach->hpa_range = (struct range) {
>>>>>>>             .start = cxlr->params.res->start,
>>>>>>>             .end = cxlr->params.res->end,
>>>>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>>>>> index c401e3a1af06..c598561b8e5f 100644
>>>>>>> --- a/drivers/cxl/cxlmem.h
>>>>>>> +++ b/drivers/cxl/cxlmem.h
>>>>>>> @@ -104,6 +104,7 @@ struct cxl_memdev_attach {
>>>>>>>     /**
>>>>>>>      * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>>>>>>      * @attach: common core attachment descriptor
>>>>>>> + * @cxlr: cxl region the memdev is attached to.
>>>>>>>      * @hpa_range: physical address range of the region
>>>>>>>      *
>>>>>>>      * For the common simple case of a CXL device with private (non-general purpose
>>>>>>> @@ -112,6 +113,7 @@ struct cxl_memdev_attach {
>>>>>>>      */
>>>>>>>     struct cxl_attach_region {
>>>>>>>         struct cxl_memdev_attach attach;
>>>>>>> +    struct cxl_region *cxlr;
>>>>>>>         struct range hpa_range;
>>>>>>>     };
>>>>>>>     
>>>>>> attach->cxlr is never cleared when the region goes away. Unbinding the endpoint port runs endpoint_unregister_region(), which unregisters the region and drops its reference. PF0 stays bound until the detach work runs.
>>>>>>
>>>>>> A non-PF0 probe in that window still finds the memdev and calls device_link_add() on the freed region.
>>>>> I do not think so. This version, see next patch, relies on locking the supplier, PF0, before getting the memdev and potentially using the attach region. Only on PF0 release can such a memdev and region disappear, so I think this is enough.
>>>>>
>>> Hi Dave,
>>>
>>>
>>>> The memdev, yes. It's devm on PF0. The region, no. Unbinding the endpoint port, or cxl_mem from the memdev, runs endpoint_unregister_region() under the endpoint's lock, not PF0's. PF0's release is only queued (schedule_detach() -> detach_memdev()). Until that work runs, PF0 is bound, the memdev is found, hpa_range is valid, and attach->cxlr points at a freed region. Root teardown (kill_regions()) and delete_region also unregister the region without touching PF0.
>>>
>>> You are partially right. The problem is not that async detach_memdev() but the fact the region can be removed without the PF0 being aware ...
>>>
>>>
>>> I was relying on the memdev being unregister first then the related device released later on, with the important part being the memdev being unregister making it unavailable to the other PFs because it can not be found in the cxl bus. I'm pretty sure about that scenario but I was not counting on sysfs unbinds for the endpoint device ...
>>>
>>>
>>> I need to think further about this because I think it is wrong to remove the region in this case without PF0 or the memdev owner and original region consumer still unaware of it. One thing I tried to discuss with Dan was why we have the unbinding options for cxl_mem and cxl_port drivers. What is the point? I know this is standard linux device model, but the unbinding could do nothing if we decide so. Couldn't we? Otherwise, If there is a good reason for having this functionality where the unwinding can happen through different starting points, we should document it.
>>>
>>>
>>> What I'm going to try is to link the region removal to Type2 driver removal as well, not necessarily with device links but through devm_action_or_reset links as we are already doing for other cases. And I think to document the different objects/devices involved and its lifetime depending on the current unwinding supported would be good to have, so I will work on that as well.
>>>
>>>
>> So there are multiple paths a region can go away without PF0 knowing and sysfs is only one of the triggers.
>> 1. endpoint port teardown -> endpoint_unregister_region()
>> 2. root decoder teardown -> kill_regions()
>> 3. userspace delete region
>> 4. some other places calling unregister_region().
>>
>> Using suppress_bind_attrs only hides the sysfs files. There's also device hot-remove and module unload in addition to root decoder action and user action. So doing that is definitely the wrong way to go.
>>
>> The path of PF0 going first is fine. The memdev goes with it. The bug path is region going first. Something needs to deal with the stale attach->cxlr. You need a region-side teardown clearing attach->cxlr under the cxl_rwsem.region before unregistering. And readers need to check under the same lock. The endpoint_detach_attach_region() proposal does close that hole.
> 
> 
> I tried to discuss this with Dan unsuccessfully, so I hope I can make my point clear: having so many ways of cxl objects/devices being destroyed is, IMO, wrong. Moreover, some user actions on things created by a Type2 driver should not be so easy accessed, and definitely, having a region unregistered and released with its main consumer and owner completely unaware, should not be happening.
> 
> 
> Dan and I addressed some concerns with "these options" but it is worse after realising now port and region can also suffer from unbinding actions. We contemplated memdev unbinding and that is supported, and acpi module removal as well (all the unwinding is hopefully right for sfc driver removal), but the fact is, current Type2 support is unsound. It is likely good enough with current usage expectations but something to improve/fix.

Removing the acpi module will also cause the issue I pointed out. So that isn't safe either. The only path that's good right now is sfc driver removal or the device going away.

> 
> 
> All this user space potential actions were implemented mainly for testing (I guess you know this). I did ask Dan about it, and I was expecting use cases where HDM decoders and regions are dynamically created, which makes a lot of sense to me, but the fact is all is relying on firmware/BIOS configuration. Richard is working on adding this functionality for Type2 and pmems, and Jonathan considers it theoretically useful as well, but the way is going to be handled requires, IMO, further thinking and maybe a change before someone starts using it (does anyone know about users now?).
> 
> 
> As a summary, if we allow user space actions (at least for Type2) they need to be consistent and somehow protected.
> 
> 
> Finally, you did not answer my question: what is the point user space removing and endpoint port handled by a Type2 driver? What about the cxl region? Maybe I am missing a necessity I can not see here, so please, help me to understand this if that is the case.

Shouldn't does not mean does not exist. Sure I can agree with you that under normal operations, certain things a sane user should avoid doing for type2. But it is possible currently and those issues can be triggered. However you feel about the current CXL architecture, here we are with where it is. You can either consider the smaller changes I suggested to keep the attach->cxlr sane (or with some other means) and make what you need working now with raised the issue addressed, and come back with hashing out the larger grievances later, or keep beating this horse.... "It's silly for users to do that and therefore the issue can be ignored" is not a good enough reason for me look the other way and merge the code.

> 
> 
> Thanks,
> 
> Alejandro.
> 
> 
>>
>> DJ
>>
>>> Thank you,
>>>
>>> Alejandro
>>>
>>>
>>>> I attached an LLM generated test kernel module you can use to reproduce the KASAN complaint. Commit log provides instructions.
>>>> BUG: KASAN: slab-use-after-free in device_link_add+0x521/0xa80
>>>>    cxl_get_range_and_link+0xa9/0x120 [cxl_core]
>>>>
>>>> DJ
>>>>
>>>>> I added comments in the exported function, cxl_get_range_and_link() which does the locking before calling the internal function __cxl_get_range_and_link() which looks for the memdev and the attach region. In fact, it should not be possible to obtain the PF0 memdev reference and the attach region not there yet, but the code is still checking that possibility as a sanity check.
>>>>>
>>>>>
>>>>> Thank you,
>>>>>
>>>>> Alejandro.
>>>>>
>>>>>
>>>>>> How about something like this?
>>>>>>
>>>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>>>> index 27e63e6dab7c..38ca73f12b84 100644
>>>>>> --- a/drivers/cxl/core/region.c
>>>>>> +++ b/drivers/cxl/core/region.c
>>>>>> @@ -4076,6 +4076,23 @@ static int first_mapped_decoder(struct device *dev, const void *data)
>>>>>>         return 0;
>>>>>>     }
>>>>>>     +/*
>>>>>> + * Invalidate @attach before the region goes away so that
>>>>>> + * cxl_get_range_and_link() can not pick up a stale region.
>>>>>> + */
>>>>>> +static void endpoint_detach_attach_region(void *_attach)
>>>>>> +{
>>>>>> +    struct cxl_attach_region *attach = _attach;
>>>>>> +    struct cxl_region *cxlr;
>>>>>> +
>>>>>> +    scoped_guard(rwsem_write, &cxl_rwsem.region) {
>>>>>> +        cxlr = attach->cxlr;
>>>>>> +        WRITE_ONCE(attach->cxlr, NULL);
>>>>>> +        attach->hpa_range = DEFINE_RANGE(0, -1);
>>>>>> +    }
>>>>>> +    endpoint_unregister_region(cxlr);
>>>>>> +}
>>>>>> +
>>>>>>     /*
>>>>>>      * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
>>>>>>      * simple case of single mapped decoder per memdev.
>>>>>> @@ -4127,15 +4144,23 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>>>>>           /* Only teardown regions that pass validation, ignore the rest */
>>>>>>         get_device(&cxlr->dev);
>>>>>> -    rc = devm_add_action_or_reset(&endpoint->dev,
>>>>>> -                      endpoint_unregister_region, cxlr);
>>>>>> -    if (rc)
>>>>>> +    /*
>>>>>> +     * Not devm_add_action_or_reset(): the reset path would take
>>>>>> +     * cxl_rwsem.region for write while it is held for read here. The
>>>>>> +     * endpoint lock keeps the action from running before @attach is set.
>>>>>> +     */
>>>>>> +    rc = devm_add_action(&endpoint->dev, endpoint_detach_attach_region,
>>>>>> +                 attach);
>>>>>> +    if (rc) {
>>>>>> +        put_device(&cxlr->dev);
>>>>>>             return rc;
>>>>>> +    }
>>>>>>           attach->hpa_range = (struct range) {
>>>>>>             .start = cxlr->params.res->start,
>>>>>>             .end = cxlr->params.res->end,
>>>>>>         };
>>>>>> +    WRITE_ONCE(attach->cxlr, cxlr);
>>>>>>         return 0;
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
>>>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>>>> index c401e3a1af06..7cd3a69cd5f5 100644
>>>>>> --- a/drivers/cxl/cxlmem.h
>>>>>> +++ b/drivers/cxl/cxlmem.h
>>>>>> @@ -104,6 +104,8 @@ struct cxl_memdev_attach {
>>>>>>     /**
>>>>>>      * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>>>>>      * @attach: common core attachment descriptor
>>>>>> + * @cxlr: cxl region the memdev is attached to, cleared under cxl_rwsem.region
>>>>>> + *    before the region is unregistered
>>>>>>      * @hpa_range: physical address range of the region
>>>>>>      *
>>>>>>      * For the common simple case of a CXL device with private (non-general purpose
>>>>>> @@ -112,6 +114,7 @@ struct cxl_memdev_attach {
>>>>>>      */
>>>>>>     struct cxl_attach_region {
>>>>>>         struct cxl_memdev_attach attach;
>>>>>> +    struct cxl_region *cxlr;
>>>>>>         struct range hpa_range;
>>>>>>     };
>>>>>>     

