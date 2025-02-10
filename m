Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC2256C6B
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207042; cv=none; b=AdhWnErg78tIsCrWaZHAOVDquy9XwzNUSzoXNmS7R4vhOJvaZ3JjAeK7fqbSA21gWalSRBqIBt3nz7kf/B3bZKH+d+8h/Tg3y6ksQJ5D5L6yoBCslnmjot82ZtMbDs3DI4DTXfmU8zINovZNogLTusVBAjQNzuhLLIP87Nuk5qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207042; c=relaxed/simple;
	bh=z0GQbOnJOuQeMDlt6+UnJSsrIzXVJzd+gP24W1MGhAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JN/u1zWXWnFnrt+9A3EFEzQdIsMs8e157bbbZmfGD8wJHEjW5h5BmLV/xtGkHURt2k13c8PEbbsqPFDdQ8/F+gfMFxm192Mwb9Ity3cDm/258jLaTkRRW+4Sr46j5eMprxyarP3BmkoVbf8r7qFNgic7CFa2t3meBkdtBWA3yGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfiNNRw5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfiNNRw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739207041; x=1770743041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z0GQbOnJOuQeMDlt6+UnJSsrIzXVJzd+gP24W1MGhAc=;
  b=bfiNNRw5SbTni/rx6RrqZDeHSYBJ2xkc2lHr+V/PuRJ7Lr5GWVQ4TYW4
   nWwNw/Akkehuw/DDFFu54Df90fg7mr00nHG7cu8Yv9RN3ZX2hiPPsfdcX
   8WoaxIsvcq2bq2MfBxFUzR0O+tdRb1ci7FfC9uRF6/ZKFxmRBoNxk9JbE
   AXZi7fllDukJn0w4RxMrnQ2PAQ1/USamG81QLg+8+ebVJPMRD6QQ3Hpwh
   vPfCDMQVV8DfAfJefZ0XGW3YfxaJPI4EHSpN0SsD/VppMxIlFz2Uje4Kf
   TEKk9SMLsp0dyim7nYQ2z6VKTVh5plETICXo5ZKHswu6Pm0VGLVd1ri1M
   w==;
X-CSE-ConnectionGUID: uy1xAOhkR7KyY9ul+osdxQ==
X-CSE-MsgGUID: H83YwnOMQA2KzX3IufL9gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39712334"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="39712334"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 09:04:00 -0800
X-CSE-ConnectionGUID: xcMFtuArRoC6Ssp+Kj387w==
X-CSE-MsgGUID: pRRwhqFmRqe6uk0MUULPgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113120512"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.192]) ([10.125.111.192])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 09:03:59 -0800
Message-ID: <8b271a9e-2576-42d5-af84-b7ddac01f67b@intel.com>
Date: Mon, 10 Feb 2025 10:03:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] cxl: Add Get Supported Features command for
 kernel usage
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250207233914.2375110-1-dave.jiang@intel.com>
 <20250207233914.2375110-3-dave.jiang@intel.com>
 <67a69dc5c3cd5_2d1e294fc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <67a69dc5c3cd5_2d1e294fc@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/25 4:56 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h)
>> The command retrieve the list of supported device-specific features
>> (identified by UUID) and general information about each Feature.
>>
>> The driver will retrieve the Feature entries in order to make checks and
>> provide information for the Get Feature and Set Feature command. One of
>> the main piece of information retrieved are the effects a Set Feature
>> command would have for a particular feature. The retrieved Feature
>> entries are stored in the cxl_mailbox context.
>>
>> The setup of Features is initiated via devm_cxl_setup_features() during the
>> pci probe function before the cxl_memdev is enumerated.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> [..]
>> +/**
>> + * devm_cxl_setup_features() - Allocate and initialize features context
>> + * @cxlds: CXL device context
>> + *
>> + * Return 0 on success or -errno on failure.
>> + */
>> +int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
>> +{
>> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>> +	int rc;
>> +
>> +	if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
>> +		return -ENODEV;
>> +
>> +	struct cxl_features_state *cxlfs __free(kfree) =
>> +		kzalloc(sizeof(*cxlfs), GFP_KERNEL);
>> +	if (!cxlfs)
>> +		return -ENOMEM;
>> +
>> +	cxlfs->cxlds = cxlds;
>> +
>> +	cxlfs->entries = get_supported_features(cxlfs);
>> +	if (!cxlfs->entries)
>> +		return -ENOMEM;
>> +
>> +	cxlds->cxlfs = cxlfs;
>> +	rc = devm_add_action_or_reset(cxlds->dev, free_cxlfs, no_free_ptr(cxlfs));
>> +	if (rc)
>> +		return rc;
>> +
>> +	return 0;
> 
> One small cleanup you can do here when applying is reduce these last 5
> lines to:
> 
>         return devm_add_action_or_reset(cxlds->dev, free_cxlfs,
>                                         no_free_ptr(cxlfs));
> 
> [..]
>> +/**
>> + * struct cxl_features_state - The Features state for the device
>> + * @cxlds: Pointer to CXL device state
>> + * @cap: Feature commands capability
>> + * @entries: CXl feature entry context
>> + *	@num_features: total Features supported by the device
>> + *	@ent: Flex array of Feature detail entries from the device
>> + */
>> +struct cxl_features_state {
>> +	struct cxl_dev_state *cxlds;
>> +	struct cxl_feat_entries {
>> +		int num_features;
>> +		struct cxl_feat_entry ent[] __counted_by(num_features);
>> +	} *entries;
>> +};
>> +
>> +#ifdef CONFIG_CXL_FEATURES
>> +inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
> 
> Shouldn't this be:
> 
> static inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
> {
> 	return cxlds->cxlfs;
> }
> 
> ...no need to do an out of line function for this.

So the reason it is an out of line function is to not expose 'struct cxl_dev_state' globally. Otherwise it needs to be in a public header in include/cxl/ to work.

DJ

> 
> Another small fixup you can do when applying.
> 
> Otherwise, this now all looks good to me:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

