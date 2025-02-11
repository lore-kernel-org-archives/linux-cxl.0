Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8852627E0;
	Tue, 11 Feb 2025 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309100; cv=none; b=BFMlbCeO0gVAJ2JGH9JdH7+2D85BSmU8zX1bKK6VDN/brz7SUgW6EK4knOMPEbovK+5tHqoxUDpVI51jApKCYifd64yKv3q2C+Ipuyk57wEEQw+g9Ywlxb1s1OMWGhsR8GlNguZUWmaZv4lSLzD40gMgJcRGAxgaYU9DpIIE4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309100; c=relaxed/simple;
	bh=ZJQOpFPaMYgJBqfBhK2doEaiich/YCB5XCXwWRVyOIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDJJ0tYxbxy4scyH5E4HJPrHYS7LIhssILx1D/b926qRWG2R2z+K6NgiuqKBTCdbR8hj9ZoY6ST5pkI7pySLT+avfc35Fen65XSMg4pcKsG6qXjEK4F/ZaU3MhUqx+bXPmgHO09Wvyqx1xGcfcrUxbcSte70mOfPArgDYdP7kLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBL1EkHt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBL1EkHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739309098; x=1770845098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZJQOpFPaMYgJBqfBhK2doEaiich/YCB5XCXwWRVyOIY=;
  b=kBL1EkHtLSH9AMd7JrUNnm3+o/pR6Ce8PqQbwY8w9J2z+9l/degGw+d7
   CT7CqHfpastzFUEgHueMICHoz6YgBImwGGse5+CW0oKMbpUh3StWUUs/Y
   7I7Iik1u9NmVPwHqVtQH+kRXhDknmaeOihH2039+NEgcpMCJl+ePlutGI
   hx3G/zsmualxIoie8nWoSn8GG3ubdo2xdpics76bkPk/OGA4xXecErFtR
   V07B2P4XFrQIsMiJncyLdeVUE/nI0RLPKK5rJXNIZ+XlVGgx3Vrvx1Hfv
   658oXG/OM4TApe4RtvbjH4T7rH1flWplGM81co0b+ERLUb7QgCPZuG/0V
   Q==;
X-CSE-ConnectionGUID: OALbNRn6Rtucc2lgEfFNSA==
X-CSE-MsgGUID: iEtQ5o9EQO+N8QR94fOeBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43875407"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="43875407"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:24:56 -0800
X-CSE-ConnectionGUID: p9dCfIwGRgOoN5xCVK5tng==
X-CSE-MsgGUID: uQ485qtrQqenItwLlPX5YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112612093"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:24:56 -0800
Message-ID: <d848f0ab-5055-4cda-8531-258c6fa7280e@intel.com>
Date: Tue, 11 Feb 2025 14:24:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] cxl/region: Drop goto pattern of
 construct_region()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250211075727.351895-1-ming.li@zohomail.com>
 <20250211075727.351895-8-ming.li@zohomail.com>
 <20250211173606.00004d33@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211173606.00004d33@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 10:36 AM, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 15:57:27 +0800
> Li Ming <ming.li@zohomail.com> wrote:
> 
>> Some operations need to be procted by the cxl_region_rwsem in construct
>> region(). Currently, construct_region() uses down_write() and up_write()
>> for the cxl_region_rwsem, so there is a goto pattern after down_write()
>> invoked to release cxl_region_rwsem.
>>
>> construct region() can be optimized to remove the goto pattern. The
>> changes are creating a new function called __construct_region() which
>> will include all checking and operations protected by the
>> cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
>> and up_write() in __construct_region().
>>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>>  drivers/cxl/core/region.c | 71 +++++++++++++++++++++------------------
>>  1 file changed, 39 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 36f3771818d3..170278bdcedc 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3217,49 +3217,31 @@ static int match_region_by_range(struct device *dev, const void *data)
>>  	return rc;
>>  }
>>  
>> -/* Establish an empty region covering the given HPA range */
>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> -					   struct cxl_endpoint_decoder *cxled)
>> +static int __construct_region(struct cxl_region *cxlr,
> 
> This is only factoring out part, so I'm not sure the naming makes sense.
> I don't have a better name however as this is doing various different things...
> setup_region() doesn't feel right either...

setup_auto_region()? construct_auto_region()?

DJ

> 
> 
>> +			      struct cxl_root_decoder *cxlrd,
>> +			      struct cxl_endpoint_decoder *cxled)
>>  {
>>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>>  	struct range *hpa = &cxled->cxld.hpa_range;
>>  	struct cxl_region_params *p;
>> -	struct cxl_region *cxlr;
>>  	struct resource *res;
>>  	int rc;
>>  
>> -	do {
>> -		cxlr = __create_region(cxlrd, cxled->mode,
>> -				       atomic_read(&cxlrd->region_id));
>> -	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>> -
>> -	if (IS_ERR(cxlr)) {
>> -		dev_err(cxlmd->dev.parent,
>> -			"%s:%s: %s failed assign region: %ld\n",
>> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>> -			__func__, PTR_ERR(cxlr));
>> -		return cxlr;
>> -	}
>> -
>> -	down_write(&cxl_region_rwsem);
>> +	guard(rwsem_write)(&cxl_region_rwsem);
>>  	p = &cxlr->params;
>>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>>  		dev_err(cxlmd->dev.parent,
>>  			"%s:%s: %s autodiscovery interrupted\n",
>>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>  			__func__);
>> -		rc = -EBUSY;
>> -		goto err;
>> +		return -EBUSY;
>>  	}
>>  
>>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>>  
>>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
>> -	if (!res) {
>> -		rc = -ENOMEM;
>> -		goto err;
>> -	}
>> +	if (!res)
>> +		return -ENOMEM;
>>  
>>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>>  				    dev_name(&cxlr->dev));
>> @@ -3282,7 +3264,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  
>>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>>  	if (rc)
>> -		goto err;
>> +		return rc;
>>  
>>  	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
>>  		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
>> @@ -3291,14 +3273,39 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  
>>  	/* ...to match put_device() in cxl_add_to_region() */
>>  	get_device(&cxlr->dev);
>> -	up_write(&cxl_region_rwsem);
>>  
>> -	return cxlr;
>> +	return 0;
>> +}
>>  
>> -err:
>> -	up_write(&cxl_region_rwsem);
>> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> -	return ERR_PTR(rc);
>> +/* Establish an empty region covering the given HPA range */
>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> +					   struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +	struct cxl_region *cxlr;
>> +	int rc;
>> +
>> +	do {
>> +		cxlr = __create_region(cxlrd, cxled->mode,
>> +				       atomic_read(&cxlrd->region_id));
>> +	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>> +
>> +	if (IS_ERR(cxlr)) {
>> +		dev_err(cxlmd->dev.parent,
>> +			"%s:%s: %s failed assign region: %ld\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>> +			__func__, PTR_ERR(cxlr));
>> +		return cxlr;
>> +	}
>> +
>> +	rc = __construct_region(cxlr, cxlrd, cxled);
>> +	if (rc) {
>> +		devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +		return ERR_PTR(rc);
>> +	}
>> +
>> +	return cxlr;
>>  }
>>  
>>  int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
> 

