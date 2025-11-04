Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6034D3A7;
	Tue,  4 Nov 2025 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297329; cv=none; b=O62Rndyw7yXquixUQk2zAxYXLyVfp/m75oPfNMzttX9eXsrR/QFrqhkt9Yid1t3sUH/mNzUVVKpRtFJyPPBgdQaVWeAlRVBlHhTGHs00EeoL5SWhi/jivrolIoL57srvdVsaKBEKmJY0uEiPR8Vn7rSVcIFeZ6aygLRmMUNRgP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297329; c=relaxed/simple;
	bh=mMbROos0E6e/tZv7K1MwUb92rSmJvC2aelfvi8a8bAo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EpES9Ilo5eh/GxqWSfMxwQUzMNR/EaeHG68OeKbfrgQRuouJgBOLvtb2ZaLIROyFVb37A9ovFbXTbsMfA4VF1pBnRL9e2OQh+CRRhZUjHoLaHol7r6wQNWlMPuhH1emtd1XC/7AsnfKvoSQN5g/V20RJKt5E3HIXU+RGr+irVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcBGiqcA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcBGiqcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762297327; x=1793833327;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=mMbROos0E6e/tZv7K1MwUb92rSmJvC2aelfvi8a8bAo=;
  b=JcBGiqcApxSN+70Z0BPyDP1eLjJmvcuvUtHdjNH+F3jBGU47/V5sWKBq
   IYiKt9I65VbjnTVLSsLOxNlT3OoQCng4sj+4HOozNpPKTciJC0GIWAjhh
   /lPLqXJGPRPt8F+fbpeA0fvRnbjZuNXjqncXy0gfhgrIhtGwc+AjsrfxF
   Tn1GsExlscomVkaG3Z2rFDnwscax/uP98APJh35zLKjTXVE34F74ciLA/
   hCWW3BH9lyJS235xaajAGbWpV3t6Pr9LINu1nmucvvKtIDKVMK7Oul+aj
   967hYn96DWmRiZI3k8doqtlZd9UOXo1LJGN5RHG9MG7SMMeOsK2RYr/pV
   Q==;
X-CSE-ConnectionGUID: SW0pxD/1TMSD4oaL+7+Y3w==
X-CSE-MsgGUID: qGK60znKRlSU+4BNcS2tqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68242480"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68242480"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:02:07 -0800
X-CSE-ConnectionGUID: giU9D9W6S7W5263XuNnbSg==
X-CSE-MsgGUID: uMUU5UmQROSILreMdUjRyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="187231912"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 15:02:06 -0800
Message-ID: <b361d492-1cc1-4057-8114-851240dd64d6@intel.com>
Date: Tue, 4 Nov 2025 16:02:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/14] cxl: Simplify cxl_root_ops allocation and
 handling
From: Dave Jiang <dave.jiang@intel.com>
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-6-rrichter@amd.com>
 <1ef139d0-2a27-40aa-8b08-09d9ec89791d@intel.com>
Content-Language: en-US
In-Reply-To: <1ef139d0-2a27-40aa-8b08-09d9ec89791d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 2:53 PM, Dave Jiang wrote:
> 
> 
> On 11/3/25 11:47 AM, Robert Richter wrote:
>> A root port's callback handlers are collected in struct cxl_root_ops.
>> The structure is dynamically allocated, though it contains only a
>> single pointer in it. This also requires to check two pointers to
>> check for the existance of a callback.
>>
>> Simplify the allocation, release and handler check by embedding the
>> ops statical in struct cxl_root.
>>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>


Thought about it for a bit, should the callback be with 'cxl_rd_ops' and the rest of the translation functions under the root decoder rather than cxl_root_ops with the cxl root? That seems to be the better fit.

DJ
 >>  drivers/cxl/acpi.c      |  7 ++-----
>>  drivers/cxl/core/cdat.c |  8 ++++----
>>  drivers/cxl/core/port.c |  9 ++-------
>>  drivers/cxl/cxl.h       | 19 ++++++++++---------
>>  4 files changed, 18 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index bd2e282ca93a..1ab780edf141 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -299,10 +299,6 @@ static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
>>  	return cxl_acpi_evaluate_qtg_dsm(handle, coord, entries, qos_class);
>>  }
>>  
>> -static const struct cxl_root_ops acpi_root_ops = {
>> -	.qos_class = cxl_acpi_qos_class,
>> -};
>> -
>>  static void del_cxl_resource(struct resource *res)
>>  {
>>  	if (!res)
>> @@ -914,9 +910,10 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>>  	cxl_res->end = -1;
>>  	cxl_res->flags = IORESOURCE_MEM;
>>  
>> -	cxl_root = devm_cxl_add_root(host, &acpi_root_ops);
>> +	cxl_root = devm_cxl_add_root(host);
>>  	if (IS_ERR(cxl_root))
>>  		return PTR_ERR(cxl_root);
>> +	cxl_root->ops.qos_class = cxl_acpi_qos_class;
>>  	root_port = &cxl_root->port;
>>  
>>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index c4bd6e8a0cf0..b84a9b52942c 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -213,7 +213,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  	if (!cxl_root)
>>  		return -ENODEV;
>>  
>> -	if (!cxl_root->ops || !cxl_root->ops->qos_class)
>> +	if (!cxl_root->ops.qos_class)
>>  		return -EOPNOTSUPP;
>>  
>>  	xa_for_each(dsmas_xa, index, dent) {
>> @@ -221,9 +221,9 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  
>>  		cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
>>  		dent->entries = 1;
>> -		rc = cxl_root->ops->qos_class(cxl_root,
>> -					      &dent->coord[ACCESS_COORDINATE_CPU],
>> -					      1, &qos_class);
>> +		rc = cxl_root->ops.qos_class(cxl_root,
>> +					     &dent->coord[ACCESS_COORDINATE_CPU],
>> +					     1, &qos_class);
>>  		if (rc != 1)
>>  			continue;
>>  
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 8128fd2b5b31..2338d146577c 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -459,7 +459,6 @@ static void cxl_root_decoder_release(struct device *dev)
>>  	if (atomic_read(&cxlrd->region_id) >= 0)
>>  		memregion_free(atomic_read(&cxlrd->region_id));
>>  	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
>> -	kfree(cxlrd->ops);
>>  	kfree(cxlrd);
>>  }
>>  
>> @@ -955,19 +954,15 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, "CXL");
>>  
>> -struct cxl_root *devm_cxl_add_root(struct device *host,
>> -				   const struct cxl_root_ops *ops)
>> +struct cxl_root *devm_cxl_add_root(struct device *host)
>>  {
>> -	struct cxl_root *cxl_root;
>>  	struct cxl_port *port;
>>  
>>  	port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
>>  	if (IS_ERR(port))
>>  		return ERR_CAST(port);
>>  
>> -	cxl_root = to_cxl_root(port);
>> -	cxl_root->ops = ops;
>> -	return cxl_root;
>> +	return to_cxl_root(port);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_root, "CXL");
>>  
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index b57cfa4273b9..9a381c827416 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -638,6 +638,14 @@ struct cxl_port {
>>  	resource_size_t component_reg_phys;
>>  };
>>  
>> +struct cxl_root;
>> +
>> +struct cxl_root_ops {
>> +	int (*qos_class)(struct cxl_root *cxl_root,
>> +			 struct access_coordinate *coord, int entries,
>> +			 int *qos_class);
>> +};
>> +
>>  /**
>>   * struct cxl_root - logical collection of root cxl_port items
>>   *
>> @@ -646,7 +654,7 @@ struct cxl_port {
>>   */
>>  struct cxl_root {
>>  	struct cxl_port port;
>> -	const struct cxl_root_ops *ops;
>> +	struct cxl_root_ops ops;
>>  };
>>  
>>  static inline struct cxl_root *
>> @@ -655,12 +663,6 @@ to_cxl_root(const struct cxl_port *port)
>>  	return container_of(port, struct cxl_root, port);
>>  }
>>  
>> -struct cxl_root_ops {
>> -	int (*qos_class)(struct cxl_root *cxl_root,
>> -			 struct access_coordinate *coord, int entries,
>> -			 int *qos_class);
>> -};
>> -
>>  static inline struct cxl_dport *
>>  cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>>  {
>> @@ -755,8 +757,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>>  				   struct device *uport_dev,
>>  				   resource_size_t component_reg_phys,
>>  				   struct cxl_dport *parent_dport);
>> -struct cxl_root *devm_cxl_add_root(struct device *host,
>> -				   const struct cxl_root_ops *ops);
>> +struct cxl_root *devm_cxl_add_root(struct device *host);
>>  struct cxl_root *find_cxl_root(struct cxl_port *port);
>>  
>>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
> 
> 

