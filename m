Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14137F00B;
	Thu,  8 Oct 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476299; cv=none; b=ftcgejmgdDGu5+cFdMNv3yNKo/4S+oHQsMIOqRR5AnwAhV0LHg4PVPaq3oCVXO5oEzTrYZDKPBRLXQyM0OBbJ4oShQEzdcTKPxHh7Ym0Z0LNCpkA4EF9Hz17oqlKsXdv9S0QB/twbQH0ODanulseBA2uOTYcX07UP3xwtodJ0Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476299; c=relaxed/simple;
	bh=V9KEGIQDVBuZ8OD5FgpaIy/tGPbePODNma5JNNtXxgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9GWYg+qJe2xaH8KHQ38kJb648iNJCVwyQ5RQDKBsCC0M7OUUrclBjYzkLEmimydujbBx34eJBCSQBTStFN0fkGttr5YYl1QPwBDFsMCh/nkTCR81t06CeFpbX51CT8vC76CS6pJwKuKXz2bkaMFhvMhKi8lzDWx0UhRY571tXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC7JM6uw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC7JM6uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791476291; x=1823012291;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V9KEGIQDVBuZ8OD5FgpaIy/tGPbePODNma5JNNtXxgA=;
  b=XC7JM6uwTouwJxDXixOdUvci3bNkSWR9urp4Bdt7YJYOF5GMfq7HocDf
   mqSFBfhNPfN62ZArdtMLKbHTzfD4ZQ5RmvUfwvmHoK0zomcPXdSsFaKNn
   pXo9lOjexbUTnrSCgAmhrizwFvUvJW4LFM8iMj9aKpcvoZaKNekxHS8Cd
   XOKSewdDwMitm4tkymR0QFtNUTRjZpOLQH74jtNoWOFZaw8Sn+I7dhMwq
   WbWR2eVvrOmd4RbrGTtUHGcoTLvaSCE8P+ZFjXlN5dpGNVNz0bwbbxs0B
   Wkp7+LXPNUcJyXEPUP7eqClOuYacF4QlPkuUtboPW4l5KEwOE3dqAHbwL
   g==;
X-CSE-ConnectionGUID: IjXg0OieQKKVkmoIYCikVg==
X-CSE-MsgGUID: kaVZKT0KSw2XHrDRjjUcww==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="148148"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="148148"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 09:18:10 -0700
X-CSE-ConnectionGUID: Bz3P1x3hS+yUUlL99z+i8Q==
X-CSE-MsgGUID: QXE+2O5sQmSi7/nsijVx8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="407372"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.51]) ([10.125.109.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 09:18:08 -0700
Message-ID: <40fc791c-c03c-42f0-88be-7a97938ebe1c@intel.com>
Date: Thu, 8 Oct 2026 09:18:07 -0700
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
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <9114ec71-060f-48ae-a6e5-0b46a881c259@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/8/26 6:50 AM, Lucero Palau, Alejandro wrote:
> 
> On 02/10/2026 16:52, Dave Jiang wrote:
>>
>> On 10/1/26 9:41 PM, Lucero Palau, Alejandro wrote:
>>> On 01/10/2026 22:38, Dave Jiang wrote:
>>>> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>>
>>>>> Use a new field in cxl_attach_region struct for easily link it with the
>>>>> region the memdev is attached to.
>>>>>
>>>>> This facilitates device links creation where such a region is the supplier
>>>>> with non-PF0 physical functions wanting to use the CXL region being the
>>>>> consumers.
>>>>>
>>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>>> ---
>>>>>    drivers/cxl/core/region.c | 1 +
>>>>>    drivers/cxl/cxlmem.h      | 2 ++
>>>>>    2 files changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>>> index 27e63e6dab7c..78ca7ebc3e55 100644
>>>>> --- a/drivers/cxl/core/region.c
>>>>> +++ b/drivers/cxl/core/region.c
>>>>> @@ -4132,6 +4132,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>>>>        if (rc)
>>>>>            return rc;
>>>>>    +    attach->cxlr = cxlr;
>>>>>        attach->hpa_range = (struct range) {
>>>>>            .start = cxlr->params.res->start,
>>>>>            .end = cxlr->params.res->end,
>>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>>> index c401e3a1af06..c598561b8e5f 100644
>>>>> --- a/drivers/cxl/cxlmem.h
>>>>> +++ b/drivers/cxl/cxlmem.h
>>>>> @@ -104,6 +104,7 @@ struct cxl_memdev_attach {
>>>>>    /**
>>>>>     * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>>>>     * @attach: common core attachment descriptor
>>>>> + * @cxlr: cxl region the memdev is attached to.
>>>>>     * @hpa_range: physical address range of the region
>>>>>     *
>>>>>     * For the common simple case of a CXL device with private (non-general purpose
>>>>> @@ -112,6 +113,7 @@ struct cxl_memdev_attach {
>>>>>     */
>>>>>    struct cxl_attach_region {
>>>>>        struct cxl_memdev_attach attach;
>>>>> +    struct cxl_region *cxlr;
>>>>>        struct range hpa_range;
>>>>>    };
>>>>>    
>>>> attach->cxlr is never cleared when the region goes away. Unbinding the endpoint port runs endpoint_unregister_region(), which unregisters the region and drops its reference. PF0 stays bound until the detach work runs.
>>>>
>>>> A non-PF0 probe in that window still finds the memdev and calls device_link_add() on the freed region.
>>>
>>> I do not think so. This version, see next patch, relies on locking the supplier, PF0, before getting the memdev and potentially using the attach region. Only on PF0 release can such a memdev and region disappear, so I think this is enough.
>>>
> 
> Hi Dave,
> 
> 
>> The memdev, yes. It's devm on PF0. The region, no. Unbinding the endpoint port, or cxl_mem from the memdev, runs endpoint_unregister_region() under the endpoint's lock, not PF0's. PF0's release is only queued (schedule_detach() -> detach_memdev()). Until that work runs, PF0 is bound, the memdev is found, hpa_range is valid, and attach->cxlr points at a freed region. Root teardown (kill_regions()) and delete_region also unregister the region without touching PF0.
> 
> 
> You are partially right. The problem is not that async detach_memdev() but the fact the region can be removed without the PF0 being aware ...
> 
> 
> I was relying on the memdev being unregister first then the related device released later on, with the important part being the memdev being unregister making it unavailable to the other PFs because it can not be found in the cxl bus. I'm pretty sure about that scenario but I was not counting on sysfs unbinds for the endpoint device ...
> 
> 
> I need to think further about this because I think it is wrong to remove the region in this case without PF0 or the memdev owner and original region consumer still unaware of it. One thing I tried to discuss with Dan was why we have the unbinding options for cxl_mem and cxl_port drivers. What is the point? I know this is standard linux device model, but the unbinding could do nothing if we decide so. Couldn't we? Otherwise, If there is a good reason for having this functionality where the unwinding can happen through different starting points, we should document it.
> 
> 
> What I'm going to try is to link the region removal to Type2 driver removal as well, not necessarily with device links but through devm_action_or_reset links as we are already doing for other cases. And I think to document the different objects/devices involved and its lifetime depending on the current unwinding supported would be good to have, so I will work on that as well.
> 
> 

So there are multiple paths a region can go away without PF0 knowing and sysfs is only one of the triggers.
1. endpoint port teardown -> endpoint_unregister_region()
2. root decoder teardown -> kill_regions()
3. userspace delete region
4. some other places calling unregister_region(). 

Using suppress_bind_attrs only hides the sysfs files. There's also device hot-remove and module unload in addition to root decoder action and user action. So doing that is definitely the wrong way to go.

The path of PF0 going first is fine. The memdev goes with it. The bug path is region going first. Something needs to deal with the stale attach->cxlr. You need a region-side teardown clearing attach->cxlr under the cxl_rwsem.region before unregistering. And readers need to check under the same lock. The endpoint_detach_attach_region() proposal does close that hole.

DJ

> Thank you,
> 
> Alejandro
> 
> 
>>
>> I attached an LLM generated test kernel module you can use to reproduce the KASAN complaint. Commit log provides instructions.
>> BUG: KASAN: slab-use-after-free in device_link_add+0x521/0xa80
>>   cxl_get_range_and_link+0xa9/0x120 [cxl_core]
>>
>> DJ
>>
>>> I added comments in the exported function, cxl_get_range_and_link() which does the locking before calling the internal function __cxl_get_range_and_link() which looks for the memdev and the attach region. In fact, it should not be possible to obtain the PF0 memdev reference and the attach region not there yet, but the code is still checking that possibility as a sanity check.
>>>
>>>
>>> Thank you,
>>>
>>> Alejandro.
>>>
>>>
>>>> How about something like this?
>>>>
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 27e63e6dab7c..38ca73f12b84 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -4076,6 +4076,23 @@ static int first_mapped_decoder(struct device *dev, const void *data)
>>>>        return 0;
>>>>    }
>>>>    +/*
>>>> + * Invalidate @attach before the region goes away so that
>>>> + * cxl_get_range_and_link() can not pick up a stale region.
>>>> + */
>>>> +static void endpoint_detach_attach_region(void *_attach)
>>>> +{
>>>> +    struct cxl_attach_region *attach = _attach;
>>>> +    struct cxl_region *cxlr;
>>>> +
>>>> +    scoped_guard(rwsem_write, &cxl_rwsem.region) {
>>>> +        cxlr = attach->cxlr;
>>>> +        WRITE_ONCE(attach->cxlr, NULL);
>>>> +        attach->hpa_range = DEFINE_RANGE(0, -1);
>>>> +    }
>>>> +    endpoint_unregister_region(cxlr);
>>>> +}
>>>> +
>>>>    /*
>>>>     * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
>>>>     * simple case of single mapped decoder per memdev.
>>>> @@ -4127,15 +4144,23 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>>>          /* Only teardown regions that pass validation, ignore the rest */
>>>>        get_device(&cxlr->dev);
>>>> -    rc = devm_add_action_or_reset(&endpoint->dev,
>>>> -                      endpoint_unregister_region, cxlr);
>>>> -    if (rc)
>>>> +    /*
>>>> +     * Not devm_add_action_or_reset(): the reset path would take
>>>> +     * cxl_rwsem.region for write while it is held for read here. The
>>>> +     * endpoint lock keeps the action from running before @attach is set.
>>>> +     */
>>>> +    rc = devm_add_action(&endpoint->dev, endpoint_detach_attach_region,
>>>> +                 attach);
>>>> +    if (rc) {
>>>> +        put_device(&cxlr->dev);
>>>>            return rc;
>>>> +    }
>>>>          attach->hpa_range = (struct range) {
>>>>            .start = cxlr->params.res->start,
>>>>            .end = cxlr->params.res->end,
>>>>        };
>>>> +    WRITE_ONCE(attach->cxlr, cxlr);
>>>>        return 0;
>>>>    }
>>>>    EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>> index c401e3a1af06..7cd3a69cd5f5 100644
>>>> --- a/drivers/cxl/cxlmem.h
>>>> +++ b/drivers/cxl/cxlmem.h
>>>> @@ -104,6 +104,8 @@ struct cxl_memdev_attach {
>>>>    /**
>>>>     * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>>>     * @attach: common core attachment descriptor
>>>> + * @cxlr: cxl region the memdev is attached to, cleared under cxl_rwsem.region
>>>> + *    before the region is unregistered
>>>>     * @hpa_range: physical address range of the region
>>>>     *
>>>>     * For the common simple case of a CXL device with private (non-general purpose
>>>> @@ -112,6 +114,7 @@ struct cxl_memdev_attach {
>>>>     */
>>>>    struct cxl_attach_region {
>>>>        struct cxl_memdev_attach attach;
>>>> +    struct cxl_region *cxlr;
>>>>        struct range hpa_range;
>>>>    };
>>>>    

