Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46D314D13;
	Thu,  1 Oct 2026 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892688; cv=none; b=gaDGvndH/171B60k/ruwEGDu/055kARox2w+1FS6zIWZkcVtP9yemvpwj3rPRDTAmWs8+2tIeNwjbRfPnGZrsJY4kckXxcy+/7Gzsc4g279RAzzhPSsHVuG+OTEfUw0seXaLUjFV9hhioPcW10N9KCf6xL1i6rOa/gob0y2RwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892688; c=relaxed/simple;
	bh=0koZ/OdakwdRQfNzYvVvdOX16dMsPnSTT45Brw5V45A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnigXTnc10amzDFlaZNHL7R3lcr7VSdyuthiov9UCwH563V1sF/W5rTDnvJLCi/H4JSeN1nDiYI7P+w1awoL3MW5/Tqx4G/KCGBFq65CYdK5iNOYuWjlw1xmpfhlROfeIU4ocrL0YSC+QCBmaZd4vLXksdAy3Ogi1YMRzwE+Tt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMU9xOra; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMU9xOra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790892687; x=1822428687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0koZ/OdakwdRQfNzYvVvdOX16dMsPnSTT45Brw5V45A=;
  b=TMU9xOraRdiBLYN+76fIT5DF3xDfL2Hu8nTE9r5DbB9hv7sDUHR9gPRC
   +vVIRp7dihdjqHLMTySd25e6Tvej5pD6PiRWQdR/IIx+bshSWMJH55def
   pxdAMAiWYeuNnrAPZfSgCAJJstNDESAwxNpMNDa2r4xj9hBlZiFxU0Lqw
   f4/8LGMXQ+qkcwQN9Q3vay79rsqpJSBq0r3b1Iz2pY+7J9ifHpcvAAwhh
   s14LphxS5C2MkuXALq4X/neRLLXzzlkuGd6zXDGzrtIBkPg8zva8PM5Y4
   uMBqnXd8yIeS54nuFxp41aJCt13nwrJg4H2QxT24SnSxtFmcnhqRaZ4/u
   Q==;
X-CSE-ConnectionGUID: RJjM8IhXQ4uI2VcLkDdieA==
X-CSE-MsgGUID: m0c6W5ggQlKMzuDmrH9kJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94376131"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="94376131"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:11:26 -0700
X-CSE-ConnectionGUID: Xx025VsMTPuPFglBA9dKJw==
X-CSE-MsgGUID: fUT9oETlQ4KJusg7EZhykg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="273927514"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.241]) ([10.125.111.241])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:11:25 -0700
Message-ID: <13d92409-727b-43e7-a027-086c9a332f44@intel.com>
Date: Thu, 1 Oct 2026 15:11:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] cxl/memdev: Add support for multi PF devices
To: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-4-alucerop@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001132023.17032-4-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 6:20 AM, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A PCI device can present multiple Physical Functions(PFs) but the CXL
> specs restrict to the first one, PF0, the discovery and management of
> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
> obtain the CXL.mem range to work with somehow.
> 
> Add a device link between the cxl region a PF0 memdev is attached to and
> the non-PF0 wanting to use the CXL region. A CXL region release will
> trigger such a PF to be released from its driver first.
> 
> PF0 being unbound from its driver triggers memdev and region release
> leading to non-PF0s being unbound first keeping the CXL memory use safe.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c | 92 +++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h         |  2 +
>  2 files changed, 94 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..799cb6e75639 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -802,6 +802,98 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	return ERR_PTR(rc);
>  }
>  
> +static int match_memdev_by_parent_device(struct device *dev, const void *data)
> +{
> +	const struct device *pf_dev = data;
> +	struct cxl_memdev *cxlmd;
> +
> +	if (!is_cxl_memdev(dev))
> +		return 0;
> +
> +	cxlmd = to_cxl_memdev(dev);
> +	return (cxlmd->cxlds->dev == pf_dev);

cxlmd->cxlds can be NULL? How about just do dev->parent == pf_dev instead?

> +}
> +
> +static int __cxl_get_range_and_link(struct device *pf0, struct device *pfx,
> +				    struct range *range)
> +{
> +	struct device *mem_dev __free(put_device) =
> +		bus_find_device(&cxl_bus_type, NULL, pf0,
> +				match_memdev_by_parent_device);
> +	struct cxl_attach_region *attach;
> +	struct cxl_memdev *cxlmd;
> +
> +	if (!mem_dev)
> +		return -ENODEV;
> +
> +	cxlmd = to_cxl_memdev(mem_dev);
> +	attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);

Probably not likely for a type2 device, but is there any possibility that attach == NULL?

> +
> +	/*
> +	 * The cxlmd object does exist and it can be found in the cxl bus after
> +	 * creation but before attach probe setting the proper HPA range. If so,
> +	 * the caller will need to try later.
> +	 */
> +	if (attach->hpa_range.end == CXL_RESOURCE_NONE)
> +		return -EPROBE_DEFER;


Maybe you'll need something like this below to ensure that the region is valid still. And you can drop the above with the below code.

      scoped_guard(rwsem_read, &cxl_rwsem.region) {
              cxlr = READ_ONCE(attach->cxlr);
              if (!cxlr)
                      return -EPROBE_DEFER;
              get_device(&cxlr->dev);
      }
      struct device *region_dev __free(put_device) = &cxlr->dev;

      /*
       * Region deletion holds regions_lock across xa_erase() and device_del().
       * Being in the xarray under regions_lock means the region is still
       * registered, and a link added now is torn down by its deletion. Drop
       * cxl_rwsem.region above first: regions_lock nests outside it.
       */
      cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
      guard(mutex)(&cxlrd->regions_lock);
      if (xa_load(&cxlrd->regions, cxlr->id) != cxlr)
              return -ENODEV;

      /* A decommit releases the region driver after dropping the rwsem */
      guard(rwsem_read)(&cxl_rwsem.region);
      if (cxlr->params.state != CXL_CONFIG_COMMIT)
              return -ENODEV;

DJ

> +
> +	/*
> +	 * Create the device link between the region and the consumer device.
> +	 * AUTOREMOVE_CONSUMER means the link implicitly to be removed if the
> +	 * consumer unbinds first with no consequences for the supplier.
> +	 */
> +	if (!device_link_add(pfx, &attach->cxlr->dev,
> +			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +		dev_err(pfx, "device link creation failed\n");
> +		return -ENODEV;
> +	}
> +
> +	range->start = attach->hpa_range.start;
> +	range->end = attach->hpa_range.end;
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_range_and_link - register a device link with the region PF0 memdev
> + * is attached to. The region release will imply the link consumer to be unbound
> + * from its driver first. Return the cxl region range to work with related to
> + * PF0 memdev initialization.
> + *
> + * @pf0: device to use for finding target memdev and supplier for the link
> + * @pfx: device to link to PF0's memdev region, the link consumer.
> + * @range: to be set with the PF0's memdev attach region range.
> + *
> + * Return: 0 or error.
> + */
> +int cxl_get_range_and_link(struct device *pf0, struct device *pfx,
> +			   struct range *range)
> +{
> +	int rc;
> +
> +	if (!pf0 || !pfx)
> +		return -EINVAL;
> +
> +	/*
> +	 * PF0 cxl memdev once created and region attached can only be removed
> +	 * when PF0 unbinds from its driver which implies to obtain the device
> +	 * lock before the unwinding starts. If this call from other PF races
> +	 * with such unbinding:
> +	 *
> +	 * 1) if this next lock is obtained first, the device link is
> +	 *    created and the later unwinding will trigger consumer (PF
> +	 *    calling here) unbinding first.
> +	 *
> +	 *  2) if it is the unbinding the one getting the lock first, the
> +	 *    memdev will not be there aymore.
> +	 */
> +	device_lock(pf0);
> +	rc = __cxl_get_range_and_link(pf0, pfx, range);
> +	device_unlock(pf0);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_range_and_link, "CXL");
> +
>  static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>  			       unsigned long arg)
>  {
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..b28dce1f6f76 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -228,4 +228,6 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>  				      struct range *range);
>  
>  int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
> +int cxl_get_range_and_link(struct device *pf0, struct device *pfx,
> +			   struct range *range);
>  #endif /* __CXL_CXL_H__ */

