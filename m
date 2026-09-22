Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13BD37F8BA;
	Tue, 22 Sep 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095149; cv=none; b=SgJqDa1duNS7FQW7WYgh/MLMCREusGYlRmoCKtLEnximQhVFP25hMZh5Ve07oITWjbvoLJXhOdXd/QSl7W2jIWHrUugMVLB+iNGRWBSBzLpCTDRqhbXEKM0IRArvg1wRjA15ukbBctexbiMoTbysxjtueOzH6zkAsIjhf9apfes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095149; c=relaxed/simple;
	bh=0q+iXM3q3dNlbUpXp5MSHzA5xSsSfZA2ZhdlYhgeKKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uME3TesvYQCeyTuLgsofL+SgY0VayOEx5b/QmY164t1dZPR95+IZOvujpuYusOVH9+fUY27NhMJgkRp5t4E487Yl/o8fjCecAr3vrAn527K5q69lD7mn+aGB+AremN9L8lzcSlMHo8s6sG8Xy+hQdXeyJ6a8Kwa/0MWc9e0MRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVAXCzrw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVAXCzrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790095145; x=1821631145;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0q+iXM3q3dNlbUpXp5MSHzA5xSsSfZA2ZhdlYhgeKKc=;
  b=mVAXCzrwA+MGW+Vw6X+W2k+oLcYM0Ctiwg7csg4N/7cMCMg9ZNA7dZer
   HGn/WA0n01R5sCQfLhaM6DCmNsnKwZHBItU+5+CI2sNr0vCGb5ILyNZAE
   nj+1yVt7ChrSBOhfxY2HmOWCEVeUHf8hEnju8xwHByiIU/RxJE3u3PDtx
   u37wCTVM9J8q2O9OOp/t1w0GjFdspPXXwEYL3+MPml7uP5TQOJ2AM/+PA
   Ol8PX1d6BWr/1iPHMwXKirtFuccBdVQAlMgb4T0zpY4Zhhr5f6TXFKmCo
   E2qypl5y4nO00nvIGIpWWHKZq9UyfIKIuin3Yk9Ovm2nj8vShe9++jWVZ
   g==;
X-CSE-ConnectionGUID: /d5vy5/WT4a/u3Wn83wssA==
X-CSE-MsgGUID: Zm4OOcsMQU6RtmM0g2m8Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="102071237"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="102071237"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 09:39:03 -0700
X-CSE-ConnectionGUID: XzQduwz0RcmChT5NYtD+ew==
X-CSE-MsgGUID: CiBnVaBBQuenZVn/H5gcRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="272684654"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.110.50]) ([10.125.110.50])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 09:39:02 -0700
Message-ID: <283b728c-911c-43d1-a2dc-e33f89e3b180@intel.com>
Date: Tue, 22 Sep 2026 09:39:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] cxl/memdev: Add support for multi PF devices
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20260921191239.4249-1-alucerop@amd.com>
 <20260921191239.4249-4-alucerop@amd.com>
 <4d46bd37-1016-41a9-a810-66144be71ed4@intel.com>
 <ef577cb3-a89f-4918-9c26-312ed220eab0@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <ef577cb3-a89f-4918-9c26-312ed220eab0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/22/26 7:07 AM, Lucero Palau, Alejandro wrote:
> 
> On 22/09/2026 00:07, Dave Jiang wrote:
>>
>> On 9/21/26 12:12 PM, alucerop@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> A PCI device can present multiple Physical Functions(PFs) but the CXL
>>> specs restrict to the first one, PF0, the discovery and management of
>>> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
>>> obtain the CXL.mem range to work with somehow.
>>>
>>> Add a device link between the cxl region a PF0 memdev is attached to and
>>> the non-PF0 wanting to use the CXL region. A CXL region release will
>>> trigger such a PF to be released from its driver first.
>>>
>>> PF0 being unbound from its driver triggers memdev and region release
>>> leading to non-PF0s being unbound first keeping the CXL memory use safe.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/memdev.c | 66 +++++++++++++++++++++++++++++++++++++++
>>>   include/cxl/cxl.h         |  1 +
>>>   2 files changed, 67 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index b3419df586b9..67be02faa7e1 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -802,6 +802,72 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>>       return ERR_PTR(rc);
>>>   }
>>>   +static int match_memdev_by_parent_device(struct device *dev, const void *data)
>>> +{
>>> +    const struct device *pf_dev = data;
>>> +    struct cxl_memdev *cxlmd;
>>> +
>>> +    if (!is_cxl_memdev(dev))
>>> +        return 0;
>>> +
>>> +    cxlmd = to_cxl_memdev(dev);
>>> +    return (cxlmd->cxlds->dev == pf_dev);
>>> +}
>>> +
>>> +/**
>>> + * cxl_get_pf0_memdev - register a device link with the region PF0 memdev is
>>> + * attached to. The region release will imply the link consumer to be unbound
>>> + * from its driver first.
>>> + *
>>> + * @pf0: device to use for finding target memdev.
>>> + * @pfx: device to link to PF0's memdev region, the link consumer.
>>> + * @range: to be set with the PF0's memdev range.
>>> + *
>>> + * Return: PF0 memdev pointer or error.
>>> + */
>>> +struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx,
>> cxl_link_to_pf0_region() may be a better name? cxl_get_pf0_memdev() hides the intention of linking.
> 
> 
> Uhmm. Not sure. It does hide the linking, but the main point is to get the CXL HPA range to work with, an in kernel parlance to get versus put is what I had in mind. The device link is how safely the PF can use the CXL memory. Noting now that the function description forgot to say about the HPA range ...

Ok just bike shedding here. cxl_link_and_retrieve_pf0_region()?

> 
> 
>>> +                      struct range *range)
>>> +{
>>> +    struct cxl_attach_region *attach;
>>> +    struct cxl_memdev *cxlmd;
>>> +    struct device *mem_dev __free(put_device) =
>>> +        bus_find_device(&cxl_bus_type, NULL, pf0,
>>> +                match_memdev_by_parent_device);
>>> +
>>> +    if (!mem_dev)
>>> +        return ERR_PTR(-ENODEV);
>>> +
>>> +    cxlmd = to_cxl_memdev(mem_dev);
>>> +
>>> +    /*
>>> +     * we got the cxl_memdev and the implicit get_device in bus_find_device
>>> +     * makes the next steps safe.
>>> +     */
>>> +    attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);
>>> +
>>> +    /*
>>> +     * The cxlmd object does exist and it can be found in the cxl bus after
>>> +     * creation but before attach probe setting the proper HPA range. If so,
>>> +     * the caller will need to try later.
>>> +     */
>>> +    if (attach->hpa_range.end == -1)
>> CXL_RESOURCE_NONE instead of -1?
> 
> 
> OK.
> 
> 
>>
>>> +        return ERR_PTR(-EPROBE_DEFER);
>>> +
>>> +    /*
>>> +     * Create the device link between the region and the consumer device.
>>> +     * AUTOREMOVE_CONSUMER means the link implicitly to be removed if the
>>> +     * consumer unbinds first with no consequences for the supplier.
>>> +     */
>>> +    if (!device_link_add(pfx, &attach->cxlr->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
>>> +        return ERR_PTR(-ENODEV);
>>> +
>>> +    range->start = attach->hpa_range.start;
>>> +    range->end = attach->hpa_range.end;
>>> +
>>> +    return to_cxl_memdev(mem_dev);
>> Should we bother returning cxl_memdev? Does the SFC driver consumer it at all?
> 
> 
> It does not consume the pointer but it uses the memdev indirectly ... this supports my previous comment about "getting" the memdev, but you are right, the pointer does not need to be given.
> 
> 
> Maybe to return the HPA instead, but the call needs to support EPROBE_DEFER, so returning an int would work. What do you think?

Yeah returning an int would work. Standard errno/success return.

DJ

> 
> 
> Thanks,
> 
> Alejandro.
> 
> 
>> DJ
>>
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_get_pf0_memdev, "CXL");
>>> +
>>>   static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>>>                      unsigned long arg)
>>>   {
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> index 802b143de83d..e3b1e5be95f8 100644
>>> --- a/include/cxl/cxl.h
>>> +++ b/include/cxl/cxl.h
>>> @@ -228,4 +228,5 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>>>                         struct range *range);
>>>     int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>> +struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx, struct range *range);
>>>   #endif /* __CXL_CXL_H__ */

