Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A82219A86
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326814; cv=none; b=L1ZHFx2sO0Veqi+0ySXToY7CpqTSOdykrr9SktSRA/bhQ46B8nMgFwUT6qQb3cftpMdohCBRv2ul+CxvIEisUqnwmF80HzgrXvrRZ8kY+XsnwvWz5sTxcUBlS3a/zMY79KOd0JdmPPLuoQv6eN1xFIQTsd/8kkWYbAo6rQZBmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326814; c=relaxed/simple;
	bh=rC4eOcL0thIOe0Apc4YHwQNpvdG4wUUpE3BA5azvn7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJeOkWpPWPVpHIPWDJ5DyNtEN8dq7r5rurgjO1USLJRUlB074qzEVnGrDNsGM/ua9crF3zEtXDf0DSbeRNfLc/txDU0/THFCrSNZ9POevsOqoDJgbM8taBD86+53az0yKwLctwsv5bS9VpoWFAZmpQY/uorVSPM+ypJFQfrJjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnY4Ik/5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnY4Ik/5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747326812; x=1778862812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rC4eOcL0thIOe0Apc4YHwQNpvdG4wUUpE3BA5azvn7M=;
  b=YnY4Ik/5B6bhVVMvHiSWoCItjA4FvhtLTwTdr8TVHVdJYz21lwMOK4eK
   Fm0GKWFYDqfD5hLshsMZ/siLu+LAj3zW8mfD7voC5TkDnksvh0/p4WhEo
   OyKX4TXa8K2ILCP2B1YmJFYmCDOm+Yn89oVb4E610XoZdDo/5l2QyddBQ
   AStijQN6rReuTgMsf0toeETLB1jqsgw041ryVQGNNhYbTt07wVQXIv0J+
   Czy/3kROhiuOa/3oCp+hGxybmy/YRxy67lchc5tKLiGnGvtW6l1LDONdD
   LAZAnJ0uLA252MffXxYkzDH2DBRKanHv1hPzSTfpBeTrcZCvuhCu/idkV
   Q==;
X-CSE-ConnectionGUID: ODHlwFSVTHO3khtd7+bF7w==
X-CSE-MsgGUID: gwoWgPTHTO+6jSGPMKR9tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49345342"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="49345342"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 09:33:32 -0700
X-CSE-ConnectionGUID: Vb7dXuerQLC/Lp1D1CP4LQ==
X-CSE-MsgGUID: pcBfHhPaSl205dMt1Hhbog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138299122"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.47]) ([10.125.109.47])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 09:33:31 -0700
Message-ID: <8613b81d-a8ba-4e0e-baff-df022e3a1c4c@intel.com>
Date: Thu, 15 May 2025 09:33:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
To: Li Ming <ming.li@zohomail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, linux-cxl@vger.kernel.org
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-3-dave.jiang@intel.com>
 <399c1afb-35be-4706-b4d8-43260cf6743f@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <399c1afb-35be-4706-b4d8-43260cf6743f@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/25 5:51 PM, Li Ming wrote:
> On 5/7/2025 8:43 AM, Dave Jiang wrote:
>> In preparation to allow dport to be allocated without being active, make
>> dport->id to be Linux id that enumerates the dport objects per port.
>> Keep the hardware id under dport->port_num to maintain compatibility and
>> introduce a dport->id as the enumeration id.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v2:
>> - Rename port_id to port_num. (Dan)
>> - Use a dport allocator to deal with ida allocation. (Dan, Jonathan)
>> ---
>>  drivers/cxl/core/cdat.c |  2 +-
>>  drivers/cxl/core/hdm.c  | 18 +++++-----
>>  drivers/cxl/core/port.c | 73 ++++++++++++++++++++++++++++++-----------
>>  drivers/cxl/cxl.h       | 12 ++++---
>>  4 files changed, 71 insertions(+), 34 deletions(-)
>>
> [snip]
>>  static struct cxl_dport *
>>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>> -		     int port_id, resource_size_t component_reg_phys,
>> +		     int port_num, resource_size_t component_reg_phys,
>>  		     resource_size_t rcrb)
>>  {
>>  	char link_name[CXL_TARGET_STRLEN];
>> @@ -1139,17 +1170,19 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  		return ERR_PTR(-ENXIO);
>>  	}
>>  
>> -	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
>> +	dport = cxl_alloc_dport(port, dport_dev);
>> +	if (!dport)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	rc = devm_add_action_or_reset(&port->dev, free_dport, dport);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", dport->id) >=
>>  	    CXL_TARGET_STRLEN)
>>  		return ERR_PTR(-EINVAL);
> Is it better to call devm_release_action(&port->dev, free_dport, dport) here if snprintf() failed?

Not sure I follow why this error path is different than the others and needs release_action().

> 
>>  
>> -	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
>> -	if (!dport)
>> -		return ERR_PTR(-ENOMEM);
>> -
>> -	dport->dport_dev = dport_dev;
>> -	dport->port_id = port_id;
>> -	dport->port = port;
>> +	dport->port_num = port_num;
>>  
>>  	if (rcrb == CXL_RESOURCE_NONE) {
>>  		rc = cxl_dport_setup_regs(&port->dev, dport,
>> @@ -1211,7 +1244,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>   * devm_cxl_add_dport - append VH downstream port data to a cxl_port
>>   * @port: the cxl_port that references this dport
>>   * @dport_dev: firmware or PCI device representing the dport
>> - * @port_id: identifier for this dport in a decoder's target list
>> + * @port_num: identifier for this dport in a decoder's target list
>>   * @component_reg_phys: optional location of CXL component registers
>>   *
>>   * Note that dports are appended to the devm release action's of the
>> @@ -1219,12 +1252,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>   * switch ports)
>>   */
>>  struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>> -				     struct device *dport_dev, int port_id,
>> +				     struct device *dport_dev, int port_num,
>>  				     resource_size_t component_reg_phys)
>>  {
>>  	struct cxl_dport *dport;
>>  
>> -	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
>> +	dport = __devm_cxl_add_dport(port, dport_dev, port_num,
>>  				     component_reg_phys, CXL_RESOURCE_NONE);
>>  	if (IS_ERR(dport)) {
>>  		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
>> @@ -1455,7 +1488,7 @@ static void reap_dports(struct cxl_port *port)
>>  	xa_for_each(&port->dports, index, dport) {
>>  		devm_release_action(&port->dev, cxl_dport_unlink, dport);
>>  		devm_release_action(&port->dev, cxl_dport_remove, dport);
>> -		devm_kfree(&port->dev, dport);
>> +		devm_release_action(&port->dev, free_dport, dport);
>>  	}
>>  }
>>  
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index a9ab46eb0610..f4fe523aaf12 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -583,6 +583,7 @@ struct cxl_dax_region {
>>   * @regions: cxl_region_ref instances, regions mapped by this port
>>   * @parent_dport: dport that points to this port in the parent
>>   * @decoder_ida: allocator for decoder ids
>> + * @dport_ida: allocator for dport ids
>>   * @reg_map: component and ras register mapping parameters
>>   * @nr_dports: number of entries in @dports
>>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>> @@ -603,6 +604,7 @@ struct cxl_port {
>>  	struct xarray regions;
>>  	struct cxl_dport *parent_dport;
>>  	struct ida decoder_ida;
>> +	struct ida dport_ida;
>>  	struct cxl_register_map reg_map;
>>  	int nr_dports;
>>  	int hdm_end;
>> @@ -655,7 +657,8 @@ struct cxl_rcrb_info {
>>   * struct cxl_dport - CXL downstream port
>>   * @dport_dev: PCI bridge or firmware device representing the downstream link
>>   * @reg_map: component and ras register mapping parameters
>> - * @port_id: unique hardware identifier for dport in decoder target list
>> + * @id: Linux id to enumerate dport instances per port
>> + * @port_num: unique hardware identifier for dport in decoder target list
>>   * @rcrb: Data about the Root Complex Register Block layout
>>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>>   * @port: reference to cxl_port that contains this downstream port
>> @@ -667,7 +670,8 @@ struct cxl_rcrb_info {
>>  struct cxl_dport {
>>  	struct device *dport_dev;
>>  	struct cxl_register_map reg_map;
>> -	int port_id;
>> +	int id;
>> +	int port_num;
>>  	struct cxl_rcrb_info rcrb;
>>  	bool rch;
>>  	struct cxl_port *port;
>> @@ -750,10 +754,10 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>>  bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
>>  
>>  struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>> -				     struct device *dport, int port_id,
>> +				     struct device *dport, int port_num,
>>  				     resource_size_t component_reg_phys);
>>  struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>> -					 struct device *dport_dev, int port_id,
>> +					 struct device *dport_dev, int port_num,
>>  					 resource_size_t rcrb);
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
> 
> 
> 

