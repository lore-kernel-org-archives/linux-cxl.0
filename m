Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F328B7E9
	for <linux-cxl@vger.kernel.org>; Mon,  7 Jul 2025 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751928540; cv=none; b=nV1c0IIXoni6TZCvfd7qX3dLPVxsKBy1n0FckNbpG1B61qQ2MvyO4uOa3szprwyjLlinawsPrnuUZ9/bzzB6S7IT1QIKIuZq1UPra0lPp2Nu6CUlGRWBDeHJc4GtLrFVbNBesxIepwf/1cHb3wTFYZKTcxKPZDxrqjN3wipY1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751928540; c=relaxed/simple;
	bh=Ejmyqr+AlRPuUsWqrDb3/O5Jp3scfSq1eo06ybmzo5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pvq4XVN5o0PjIarbD75uL6CMcyUQXpX+YqBTbIHyM8S23IrY3Uz2i3aQTaesJmzOBVPrRHn6/s86F2IgH1phHma1tsTU+RTzEzx/eBW7gG3EPb52eYfVxs6Do6rsgp5AiUeZYpYH+bXiPiFptllJ5sV2dMWUdQs3v5nc+tSBD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhBpCmKV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhBpCmKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751928539; x=1783464539;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ejmyqr+AlRPuUsWqrDb3/O5Jp3scfSq1eo06ybmzo5A=;
  b=QhBpCmKVw/Mr1BDYJJIcf5SNKcHzahGBA3BiGnNFVGuLZFY9FOZ+oT8I
   ELOQo0Ok8FtwQtLDxai6MHFugogaubWhZrVxv9LRVQczuY/Egn2xQ8Bkv
   5bhN4YIMGozAc8zgOf6rcrAWrFnBfJ+ygJ/Tm347fcxRHzIOzN/MX4Crg
   MHAjOS3UvCLXXzQ7Zid/f18tprBmXcRnWgwcJVnX72dQS1Hty8/LqwfII
   mzGl1JvDpgN+2G6xndAWUS15Tj3VwtEZ/9g+aSfmp4cObETM0jvU2dAZD
   /p/7NdADlU7LDrzezx47SRQDdivv4zQSKrOYxv8i91CDc1ZkDk4UzzfZS
   w==;
X-CSE-ConnectionGUID: tnHFyYMeRkGN7BLpUyoShQ==
X-CSE-MsgGUID: TJPt80LJRiym2GS8oSdRLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57926848"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="57926848"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 15:48:58 -0700
X-CSE-ConnectionGUID: pGDhvK4nToCr7LECy6RBqg==
X-CSE-MsgGUID: XATsBf+aSEyHeFWHUSK9Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="160981576"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.125]) ([10.125.110.125])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 15:48:58 -0700
Message-ID: <1d3d8708-5736-4d71-9de8-afd94b09599c@intel.com>
Date: Mon, 7 Jul 2025 15:48:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] cxl: Defer dport allocation for switch ports
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250703232710.3141436-1-dave.jiang@intel.com>
 <20250703232710.3141436-5-dave.jiang@intel.com>
 <20250704105255.000039da@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250704105255.000039da@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/4/25 2:52 AM, Jonathan Cameron wrote:
> 
> Hi Dave,
> 
>> ---
>> v5:
>> - Change cxl_port_get_total_dports() to cxl_port_update_total_dports(). (Jonathan)
>> - Return dport for the devm_cxl_port_add_dport() and friends. (Jonathan)
> I'm not following how the code around this works.  See below.
> 
> If I'm reading it right and it should just be a return ERR_PTR(-EEXIST)
> where noted, with that fixed:
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> 
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 9691da831224..ffd39c5b7222 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1551,6 +1551,128 @@ static resource_size_t find_component_registers(struct device *dev)
> 
>> +
>> +static struct cxl_dport *devm_cxl_port_add_dport(struct cxl_port *port,
>> +						 struct device *dport_dev)
>> +{
>> +	struct cxl_dport *dport;
>> +	int rc;
>> +
>> +	device_lock_assert(&port->dev);
>> +
>> +	/* Port driver not attached yet, wait for cxl_acpi reprobe */
>> +	if (!port->dev.driver)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	dport = cxl_find_dport_by_dev(port, dport_dev);
>> +	if (dport)
>> +		return dport;
> 
> I was expecting this to return -EEXIST.
> Only going to be visible in the devm_cxl_add_dport_for_rp()
> though so maybe test isn't hitting that?
> 
>> +
>> +	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
>> +	if (IS_ERR(dport))
>> +		return dport;
>> +
>> +	rc = cxl_port_setup_with_dport(port, dport);
>> +	if (rc) {
>> +		reap_dport(port, dport);
>> +		return ERR_PTR(rc);
>> +	}
>> +
>> +	return dport;
>> +}
>> +
>> +static struct cxl_dport *devm_cxl_add_dport_by_uport(struct device *uport_dev,
>> +						     struct device *dport_dev)
>> +{
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		find_cxl_port_by_uport(uport_dev);
>> +
>> +	if (!port)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	guard(device)(&port->dev);
>> +	return devm_cxl_port_add_dport(port, dport_dev);
>> +}
>> +
>> +static struct cxl_dport *devm_cxl_add_dport_for_rp(struct device *uport_dev,
>> +						   struct device *dport_dev)
>> +{
>> +	struct device *dparent = grandparent(dport_dev);
>> +
>> +	/* Only go down this path if we are at the root port */
>> +	if (!is_cxl_hierarchy_head(dparent))
>> +		return NULL;
>> +
>> +	return devm_cxl_add_dport_by_uport(uport_dev, dport_dev);
>> +}
>> +
>>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			      struct device *uport_dev,
>>  			      struct device *dport_dev)
>> @@ -1584,6 +1706,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  	 */
>>  	struct cxl_port *port __free(put_cxl_port) = NULL;
>>  	scoped_guard(device, &parent_port->dev) {
>> +		struct cxl_dport *new_dport;
>> +
>>  		if (!parent_port->dev.driver) {
>>  			dev_warn(&cxlmd->dev,
>>  				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
>> @@ -1592,6 +1716,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  		}
>>  
>>  		port = find_cxl_port_at(parent_port, dport_dev, &dport);
>> +		if (!port)
>> +			port = find_cxl_port_by_uport(uport_dev);
>>  		if (!port) {
>>  			component_reg_phys = find_component_registers(uport_dev);
>>  			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>> @@ -1599,11 +1725,27 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			if (IS_ERR(port))
>>  				return PTR_ERR(port);
>>  
>> -			/* retry find to pick up the new dport information */
>> -			port = find_cxl_port_at(parent_port, dport_dev, &dport);
>> -			if (!port)
>> -				return -ENXIO;
>> +			/*
>> +			 * The port holds a device reference via find_cxl_port_at()
>> +			 * if the port is valid. But if the port is newly created
>> +			 * via devm_cxl_add_port(), no reference is held. Therefore
>> +			 * the driver needs to get a device reference here.
>> +			 */
>> +			get_device(&port->dev);
>>  		}
>> +
>> +		guard(device)(&port->dev);
>> +		new_dport = devm_cxl_port_add_dport(port, dport_dev);
>> +		if (IS_ERR(new_dport)) {
>> +			if (PTR_ERR(new_dport) != -EEXIST)
>> +				return PTR_ERR(new_dport);
> 
> I think we never get here currently due to lack of returning -EEXIST.
> 
>> +
>> +			new_dport = cxl_find_dport_by_dev(port, dport_dev);
>> +			if (!new_dport)
>> +				return -ENODEV;
>> +		}
>> +
>> +		dport = new_dport;
>>  	}
>>  
>>  	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
>> @@ -1620,11 +1762,13 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  	return rc;
>>  }
>>  
>> +#define CXL_ITER_LEVEL_SWITCH	1
>> +
>>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  {
>>  	struct device *dev = &cxlmd->dev;
>>  	struct device *iter;
>> -	int rc;
>> +	int rc, i;
>>  
>>  	/*
>>  	 * Skip intermediate port enumeration in the RCH case, there
>> @@ -1643,7 +1787,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  	 * attempt fails.
>>  	 */
>>  retry:
>> -	for (iter = dev; iter; iter = grandparent(iter)) {
>> +	for (i = 0, iter = dev; iter; i++, iter = grandparent(iter)) {
>>  		struct device *dport_dev = grandparent(iter);
>>  		struct device *uport_dev;
>>  		struct cxl_dport *dport;
>> @@ -1686,9 +1830,28 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  			if (!dev_is_cxl_root_child(&port->dev))
>>  				continue;
>>  
>> +			/*
>> +			 * This is a corner case where the rootport is setup but
>> +			 * the switch dport is not. It needs to go back to the
>> +			 * beginning to setup the switch port.
>> +			 */
>> +			if (i >= CXL_ITER_LEVEL_SWITCH) {
>> +				struct cxl_port *pport __free(put_cxl_port) =
>> +					cxl_mem_find_port(cxlmd, &dport);
>> +				if (!port)
>> +					goto retry;
>> +			}
>> +
>>  			return 0;
>>  		}
>>  
>> +		dport = devm_cxl_add_dport_for_rp(uport_dev, dport_dev);
>> +		/* Added a dport, restart enumeration */
>> +		if (!IS_ERR_OR_NULL(dport))
>> +			goto retry;
> 
> As above. I think if this finds a already existing dport we loop for ever.

Actually it is the opposite. If we found an existing dport, we will want to start the hierarchy walk from the beginning. If we allow it to drop through, things don't work properly during testing. It ends up being something like:

+               dport = devm_cxl_add_dport_for_rp(uport_dev, dport_dev);
+               /* Added a dport, restart enumeration */
+               if (!IS_ERR_OR_NULL(dport) || PTR_ERR(dport) == -EEXIST)
+                       goto retry;
+               if (IS_ERR(dport))
+                       return PTR_ERR(dport);

DJ

> 
>> +		if (IS_ERR(dport))
>> +			return PTR_ERR(dport);
>> +
>>  		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
>>  		/* port missing, try to add parent */
>>  		if (rc == -EAGAIN)
> }
> 

