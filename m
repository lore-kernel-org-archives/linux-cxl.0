Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6924DE71E;
	Thu,  1 Oct 2026 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894521; cv=none; b=MFmjiF35CJNxoLR414jH05zhNnGdaV8bF+52x+by6pheQexG7fRMUNBDANFedV8iYs1Y7MMeGkOK5EApFQo3itQJXs9Z+UYKdtZzl0ShbDholCjFQ4BxHkINGpzFqGuNFWEH2A8iRx766FbTwlRz3b7RrRUxr3xNEtx/u8IxLz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894521; c=relaxed/simple;
	bh=aWruIjG1mDDT5kHThWN27yof/bVvV9TKuHjQbNxDjPA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EvdwpMBImAAm43g8x1UbJfjxsVQFReNX8ZsiffsLoVy/4YDCIvbzwaiMk+uoZKp/WM3Z2FZYAOGK2aqqxn4BinGdSWa9yzawWZq7lblAHiz3nIyAfXfHIlLQAnHwLepkQ678Ya7kp5jV3U0S5rcTcOYkYlAw3nOv/C634ZzEY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxXRoG98; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxXRoG98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790894519; x=1822430519;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=aWruIjG1mDDT5kHThWN27yof/bVvV9TKuHjQbNxDjPA=;
  b=YxXRoG98p7GvnAuaukFfGlaFjDbTZInZyXI/lLj7bHifBJuyltWIqI/X
   YaadXNTfHcyM2+Xzf3OFZhnVT5mNVKuPN8Wt4XtV40R2q1grV2l/UwtZ3
   p/Jja5F4iBKlBxE2H3nfOizPWdY2JR4YHCA8BlR1j9S2CdyucFSIXh4Wt
   cmxfyJrK5y2Ma4XKknn4T0cXiIPXeZKsyyBIvp8Jm+9gh+xSYp+jZnKoK
   Zj3L6crJzTZ/Jg+74lyu0gXqekMHYyxg07g9Su3edLrf6EInPPW3hcNgC
   olrYrHhceUJN8alhIplzv8YhE2O2WHathf/TlE+ShqABro3MdUXZk42wE
   A==;
X-CSE-ConnectionGUID: nelDeEc2T8CnG6eZ1Rvu0Q==
X-CSE-MsgGUID: OSR39DqwSfClvj/eiLx+zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90878115"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90878115"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:41:58 -0700
X-CSE-ConnectionGUID: 1PRZpPv7T/ee00yyvyb51w==
X-CSE-MsgGUID: fQRjjfX2TTO+ujFSkst7pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="280860882"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.241]) ([10.125.111.241])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:41:57 -0700
Message-ID: <d2ae4c4a-ee61-4b3a-b3a5-9f071c078af6@intel.com>
Date: Thu, 1 Oct 2026 15:41:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] cxl/memdev: Add support for multi PF devices
From: Dave Jiang <dave.jiang@intel.com>
To: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-4-alucerop@amd.com>
 <13d92409-727b-43e7-a027-086c9a332f44@intel.com>
Content-Language: en-US
In-Reply-To: <13d92409-727b-43e7-a027-086c9a332f44@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 3:11 PM, Dave Jiang wrote:
> 
> 
> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A PCI device can present multiple Physical Functions(PFs) but the CXL
>> specs restrict to the first one, PF0, the discovery and management of
>> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
>> obtain the CXL.mem range to work with somehow.
>>
>> Add a device link between the cxl region a PF0 memdev is attached to and
>> the non-PF0 wanting to use the CXL region. A CXL region release will
>> trigger such a PF to be released from its driver first.
>>
>> PF0 being unbound from its driver triggers memdev and region release
>> leading to non-PF0s being unbound first keeping the CXL memory use safe.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>  drivers/cxl/core/memdev.c | 92 +++++++++++++++++++++++++++++++++++++++
>>  include/cxl/cxl.h         |  2 +
>>  2 files changed, 94 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index b3419df586b9..799cb6e75639 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -802,6 +802,98 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>  	return ERR_PTR(rc);
>>  }
>>  
>> +static int match_memdev_by_parent_device(struct device *dev, const void *data)
>> +{
>> +	const struct device *pf_dev = data;
>> +	struct cxl_memdev *cxlmd;
>> +
>> +	if (!is_cxl_memdev(dev))
>> +		return 0;
>> +
>> +	cxlmd = to_cxl_memdev(dev);
>> +	return (cxlmd->cxlds->dev == pf_dev);
> 
> cxlmd->cxlds can be NULL? How about just do dev->parent == pf_dev instead?
> 
>> +}
>> +
>> +static int __cxl_get_range_and_link(struct device *pf0, struct device *pfx,
>> +				    struct range *range)
>> +{
>> +	struct device *mem_dev __free(put_device) =
>> +		bus_find_device(&cxl_bus_type, NULL, pf0,
>> +				match_memdev_by_parent_device);
>> +	struct cxl_attach_region *attach;
>> +	struct cxl_memdev *cxlmd;
>> +
>> +	if (!mem_dev)
>> +		return -ENODEV;
>> +
>> +	cxlmd = to_cxl_memdev(mem_dev);
>> +	attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);
> 
> Probably not likely for a type2 device, but is there any possibility that attach == NULL?
> 
>> +
>> +	/*
>> +	 * The cxlmd object does exist and it can be found in the cxl bus after
>> +	 * creation but before attach probe setting the proper HPA range. If so,
>> +	 * the caller will need to try later.
>> +	 */
>> +	if (attach->hpa_range.end == CXL_RESOURCE_NONE)
>> +		return -EPROBE_DEFER;
> 
> 
> Maybe you'll need something like this below to ensure that the region is valid still. And you can drop the above with the below code.
> 
>       scoped_guard(rwsem_read, &cxl_rwsem.region) {
>               cxlr = READ_ONCE(attach->cxlr);
>               if (!cxlr)
>                       return -EPROBE_DEFER;
>               get_device(&cxlr->dev);
>       }
>       struct device *region_dev __free(put_device) = &cxlr->dev;
> 
>       /*
>        * Region deletion holds regions_lock across xa_erase() and device_del().
>        * Being in the xarray under regions_lock means the region is still
>        * registered, and a link added now is torn down by its deletion. Drop
>        * cxl_rwsem.region above first: regions_lock nests outside it.
>        */
>       cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>       guard(mutex)(&cxlrd->regions_lock);
>       if (xa_load(&cxlrd->regions, cxlr->id) != cxlr)
>               return -ENODEV;
And also

      /*
       * The link only unbinds @pfx when the region driver is released, so a
       * region without a driver would leave @pfx bound past region removal.
       * Hold the device lock so the driver can not go away underneath.
       */
      guard(device)(&cxlr->dev);
      if (!cxlr->dev.driver)
              return -ENODEV;

> 
>       /* A decommit releases the region driver after dropping the rwsem */
>       guard(rwsem_read)(&cxl_rwsem.region);
>       if (cxlr->params.state != CXL_CONFIG_COMMIT)
>               return -ENODEV;
> 
> DJ
> 
>> +
>> +	/*
>> +	 * Create the device link between the region and the consumer device.
>> +	 * AUTOREMOVE_CONSUMER means the link implicitly to be removed if the
>> +	 * consumer unbinds first with no consequences for the supplier.
>> +	 */
>> +	if (!device_link_add(pfx, &attach->cxlr->dev,
>> +			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
>> +		dev_err(pfx, "device link creation failed\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	range->start = attach->hpa_range.start;
>> +	range->end = attach->hpa_range.end;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_range_and_link - register a device link with the region PF0 memdev
>> + * is attached to. The region release will imply the link consumer to be unbound
>> + * from its driver first. Return the cxl region range to work with related to
>> + * PF0 memdev initialization.
>> + *
>> + * @pf0: device to use for finding target memdev and supplier for the link
>> + * @pfx: device to link to PF0's memdev region, the link consumer.
>> + * @range: to be set with the PF0's memdev attach region range.
>> + *
>> + * Return: 0 or error.
>> + */
>> +int cxl_get_range_and_link(struct device *pf0, struct device *pfx,
>> +			   struct range *range)
>> +{
>> +	int rc;
>> +
>> +	if (!pf0 || !pfx)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * PF0 cxl memdev once created and region attached can only be removed
>> +	 * when PF0 unbinds from its driver which implies to obtain the device
>> +	 * lock before the unwinding starts. If this call from other PF races
>> +	 * with such unbinding:
>> +	 *
>> +	 * 1) if this next lock is obtained first, the device link is
>> +	 *    created and the later unwinding will trigger consumer (PF
>> +	 *    calling here) unbinding first.
>> +	 *
>> +	 *  2) if it is the unbinding the one getting the lock first, the
>> +	 *    memdev will not be there aymore.
>> +	 */
>> +	device_lock(pf0);
>> +	rc = __cxl_get_range_and_link(pf0, pfx, range);
>> +	device_unlock(pf0);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_range_and_link, "CXL");
>> +
>>  static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>>  			       unsigned long arg)
>>  {
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 802b143de83d..b28dce1f6f76 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -228,4 +228,6 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>>  				      struct range *range);
>>  
>>  int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>> +int cxl_get_range_and_link(struct device *pf0, struct device *pfx,
>> +			   struct range *range);
>>  #endif /* __CXL_CXL_H__ */
> 
> 

