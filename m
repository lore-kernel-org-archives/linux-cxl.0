Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421491DDC37
	for <linux-cxl@vger.kernel.org>; Mon, 14 Apr 2025 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667143; cv=none; b=m5KWF/zMhdS/Xo0mEtgvjQmXnmz+rE/hPH8uKpws6JM9+b0Z6BTvx5cvELzMAxOW8S/9eqG/aH0S2/3ZOxxLSd9n9YZDOXGbXr4zmgvwnx1vfGt5gzHdk9Nu6Lr6FKCVcjBBCIY87JJ+BN57pB/vVSvova+1UO5+WKNzLPW6Hwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667143; c=relaxed/simple;
	bh=PcEpM1TYN/tHLorEAGFUGd3rOOwIE9KA3BFvu8nUskM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Br2W3nPvz56Bdpbn95L57dX/ZOS9i3WLFubjqPyeY+LYibd2XdWF0Mzdx9iSamED4h42EVSMvOZw/aOkWt7yc1l3TcOtVljpzXagyVArx/4WihUF0rVE3x6azc3wdo8VN14wVTt/W676IOBQcs8uFWrobnkjVxqLqYP7AIcEL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3wAEB2L; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3wAEB2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744667141; x=1776203141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PcEpM1TYN/tHLorEAGFUGd3rOOwIE9KA3BFvu8nUskM=;
  b=O3wAEB2Ll9E/Hj1tw7i/KPOl0E2bG3sydOVz2xlVLtlU5TPAtv9utuH+
   OyjIEYHdDSDpUdM2bfRwmpDQDH58BVPU8sfF/cvnRlXzYF1zGvraPpyt4
   xCWzDjetGZG3zmmGHdmyX4vmypF9WQxRSmzj+anb/NNwRI8HCeabBTi/V
   m3kmmsJJBlFgZBS2hhikS+QWG9nL2YLLeYXvg0TZmpBU2lUBD7xCXw9rQ
   ViqBi2ltb/tuFBZgoNF4ZInFQ8WDA6BsL2uxpDfFv/sR7ZsX91przYpae
   7rAmLWbsBK+RxstesrcFR1apJynD5w0B3BctnGAlz0d+goguJgMyyC9Ar
   Q==;
X-CSE-ConnectionGUID: U7i/jshKQ7qsGvzaYvRIDA==
X-CSE-MsgGUID: EWi3ji2BRne0eC33+QKPmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46036935"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="46036935"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 14:45:40 -0700
X-CSE-ConnectionGUID: AszW2RBWS4aS7Narc7r3mQ==
X-CSE-MsgGUID: drtnw1SVSK62BUj7HPnQ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="135101626"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.28]) ([10.125.109.28])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 14:45:39 -0700
Message-ID: <8008c59c-44fb-4c7f-8f7b-da891603ea2a@intel.com>
Date: Mon, 14 Apr 2025 14:45:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cxl: Defer hardware dport->port_id assignment and
 registers probing
To: Li Ming <ming.li@zohomail.com>
Cc: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 linux-cxl@vger.kernel.org
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-3-dave.jiang@intel.com>
 <651172c0-8a5c-4aa4-98cf-073ff425d291@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <651172c0-8a5c-4aa4-98cf-073ff425d291@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/25 7:20 PM, Li Ming wrote:
> On 4/5/2025 6:57 AM, Dave Jiang wrote:
>> Current implementation only enuemrates the dports dupring the port probe.
> s/dupring/during
>> Without an endpoint connected, the dport may not be active during port
>> probe. This scheme may prevent a valid hardware dport id to be retrieved
>> and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
>> dport id assignment and the register probing to behind memdev probe so the
>> endpoint is guaranteed to be connected.
>>
>> The detection of duplicate dport for add_dport() is removed. The port_id
>> is not read from the hw at this point any longer. The port->id will always
>> be unique since it's retrieved from an ida. The dup detection thus become
>> irrelevant.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/core.h |  4 ++
>>  drivers/cxl/core/pci.c  | 74 ++++++++++++++++++++++++++++------
>>  drivers/cxl/core/port.c | 88 ++++++++++++++++++++++-------------------
>>  drivers/cxl/cxl.h       |  1 +
>>  drivers/cxl/port.c      |  2 -
>>  5 files changed, 114 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 15699299dc11..e2822ead6a67 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -134,4 +134,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>>  		    u16 *return_code);
>>  #endif
>>  
>> +int cxl_dport_probe(struct cxl_dport *dport, resource_size_t component_reg_phys,
>> +		    resource_size_t rcrb);
>> +void cxl_port_probe_dports(struct cxl_port *port);
>> +
>>  #endif /* __CXL_CORE_H__ */
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 96fecb799cbc..a47dd032abd7 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -24,6 +24,66 @@ static unsigned short media_ready_timeout = 60;
>>  module_param(media_ready_timeout, ushort, 0644);
>>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>>  
>> +static int probe_dports(struct cxl_dport *dport)
> maybe rename it to probe_dport(), because it just probes one dport.

ok

>> +{
>> +	struct device *dport_dev = dport->dport_dev;
>> +	struct cxl_port *port = dport->port;
>> +	struct cxl_register_map map;
>> +	struct pci_dev *pdev;
>> +	u32 lnkcap, port_num;
>> +	int rc;
>> +
>> +	if (!dev_is_pci(dport_dev))
>> +		return 0;
>> +
>> +	/*
>> +	 * dport->port_id is valid means that dport has been probed and is
>> +	 * setup.
>> +	 */
>> +	if (dport->port_id != CXL_PORT_ID_INVALID)
>> +		return 0;
>> +
>> +	pdev = to_pci_dev(dport_dev);
>> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
>> +				  &lnkcap))
>> +		return 0;
>> +
>> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>> +	if (rc) {
>> +		dev_dbg(&port->dev, "failed to find component registers\n");
>> +		return 0;
>> +	}
>> +
>> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
>> +	rc = cxl_dport_probe(dport, map.resource, CXL_RESOURCE_NONE);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/*
>> +	 * port_id is only set if the register block is also probed
>> +	 * successfully.
>> +	 */
>> +	dport->port_id = port_num;
>> +	cxl_switch_parse_cdat(port);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_port_probe_dports - probe downstream ports of the upstream port
>> + * @port: cxl_port whose ->uport_dev is the upstream of dports to be probed
>> + *
>> + */
>> +void cxl_port_probe_dports(struct cxl_port *port)
>> +{
>> +	struct cxl_dport *dport;
>> +	unsigned long index;
>> +
>> +	device_lock_assert(&port->dev);
>> +	xa_for_each(&port->dports, index, dport)
>> +		probe_dports(dport);
>> +}
>> +
> 
> This function is called during each endpoint attaching, I am a little confused that it probes all dports under the port at the same time during a new endpoint attaching to the port.
> 
> Per commit log, hardware dport id and MMIO registers are available only when an endpoint connects, seems like probing other dports which no endpoint connects is redundant. is it possible to just probe the dport which the attaching endpoint is under?
> 
> Maybe I miss some details, please correct me if I am wrong.

No it was a mistake. I'll correct that and only update the dport at hand.

DJ

> 
>>  struct cxl_walk_context {
>>  	struct pci_bus *bus;
>>  	struct cxl_port *port;
>> @@ -37,10 +97,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>>  	struct cxl_walk_context *ctx = data;
>>  	struct cxl_port *port = ctx->port;
>>  	int type = pci_pcie_type(pdev);
>> -	struct cxl_register_map map;
>>  	struct cxl_dport *dport;
>> -	u32 lnkcap, port_num;
>> -	int rc;
>>  
>>  	if (pdev->bus != ctx->bus)
>>  		return 0;
>> @@ -48,16 +105,9 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>>  		return 0;
>>  	if (type != ctx->type)
>>  		return 0;
>> -	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
>> -				  &lnkcap))
>> -		return 0;
>>  
>> -	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>> -	if (rc)
>> -		dev_dbg(&port->dev, "failed to find component registers\n");
>> -
>> -	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
>> -	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
>> +	dport = devm_cxl_add_dport(port, &pdev->dev, CXL_PORT_ID_INVALID,
>> +				   CXL_RESOURCE_NONE);
>>  	if (IS_ERR(dport)) {
>>  		ctx->error = PTR_ERR(dport);
>>  		return PTR_ERR(dport);
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index e90e55bc11ac..1c772c516dbe 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1059,18 +1059,9 @@ static struct cxl_dport *find_dport(struct cxl_port *port, int port_id)
>>  
>>  static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>>  {
>> -	struct cxl_dport *dup;
>>  	int rc;
>>  
>>  	device_lock_assert(&port->dev);
>> -	dup = find_dport(port, dport->port_id);
>> -	if (dup) {
>> -		dev_err(&port->dev,
>> -			"unable to add dport%d-%s non-unique port id (%s)\n",
>> -			dport->port_id, dev_name(dport->dport_dev),
>> -			dev_name(dup->dport_dev));
>> -		return -EBUSY;
>> -	}
>>  
>>  	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
>>  		       GFP_KERNEL);
>> @@ -1120,6 +1111,45 @@ static void cxl_dport_unlink(void *data)
>>  	sysfs_remove_link(&port->dev.kobj, link_name);
>>  }
>>  
>> +int cxl_dport_probe(struct cxl_dport *dport, resource_size_t component_reg_phys,
>> +		    resource_size_t rcrb)
>> +{
>> +	struct device *dport_dev = dport->dport_dev;
>> +	struct cxl_port *port = dport->port;
>> +	int rc;
>> +
>> +	if (rcrb == CXL_RESOURCE_NONE) {
>> +		rc = cxl_dport_setup_regs(&port->dev, dport,
>> +					  component_reg_phys);
>> +		if (rc)
>> +			return rc;
>> +	} else {
>> +		dport->rcrb.base = rcrb;
>> +		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
>> +							 CXL_RCRB_DOWNSTREAM);
>> +		if (component_reg_phys == CXL_RESOURCE_NONE) {
>> +			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
>> +			return -ENXIO;
>> +		}
>> +
>> +		/*
>> +		 * RCH @dport is not ready to map until associated with its
>> +		 * memdev
>> +		 */
>> +		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
>> +		if (rc)
>> +			return rc;
>> +
>> +		dport->rch = true;
>> +	}
>> +
>> +	if (component_reg_phys != CXL_RESOURCE_NONE)
>> +		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
>> +			&component_reg_phys);
>> +
>> +	return 0;
>> +}
>> +
>>  static struct cxl_dport *
>>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  		     int port_id, resource_size_t component_reg_phys,
>> @@ -1162,40 +1192,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>>  	dport->port = port;
>>  	dport->id = id;
>>  
>> -	if (rcrb == CXL_RESOURCE_NONE) {
>> -		rc = cxl_dport_setup_regs(&port->dev, dport,
>> -					  component_reg_phys);
>> -		if (rc) {
>> -			ida_free(&port->dport_ida, id);
>> -			return ERR_PTR(rc);
>> -		}
>> -	} else {
>> -		dport->rcrb.base = rcrb;
>> -		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
>> -							 CXL_RCRB_DOWNSTREAM);
>> -		if (component_reg_phys == CXL_RESOURCE_NONE) {
>> -			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
>> -			ida_free(&port->dport_ida, id);
>> -			return ERR_PTR(-ENXIO);
>> -		}
>> -
>> -		/*
>> -		 * RCH @dport is not ready to map until associated with its
>> -		 * memdev
>> -		 */
>> -		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
>> -		if (rc) {
>> -			ida_free(&port->dport_ida, id);
>> -			return ERR_PTR(rc);
>> -		}
>> -
>> -		dport->rch = true;
>> +	rc = cxl_dport_probe(dport, component_reg_phys, rcrb);
>> +	if (rc) {
>> +		ida_free(&port->dport_ida, id);
>> +		return ERR_PTR(rc);
>>  	}
>>  
>> -	if (component_reg_phys != CXL_RESOURCE_NONE)
>> -		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
>> -			&component_reg_phys);
>> -
>>  	cond_cxl_root_lock(port);
>>  	rc = add_dport(port, dport);
>>  	cond_cxl_root_unlock(port);
>> @@ -1684,6 +1686,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  				"found already registered port %s:%s\n",
>>  				dev_name(&port->dev),
>>  				dev_name(port->uport_dev));
>> +
>> +			scoped_guard(device, &port->dev)
>> +				cxl_port_probe_dports(port);
> Just like above comment, is it possible to be cxl_port_probe_dport(port, dport) here?
>> +
>>  			rc = cxl_add_ep(dport, &cxlmd->dev);
>>  
>>  			/*
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index c942fa40c869..0e61b76f5c13 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -345,6 +345,7 @@ enum cxl_decoder_type {
>>  #define CXL_DECODER_MAX_INTERLEAVE 16
>>  
>>  #define CXL_QOS_CLASS_INVALID -1
>> +#define CXL_PORT_ID_INVALID -1
>>  
>>  /**
>>   * struct cxl_decoder - Common CXL HDM Decoder Attributes
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index a35fc5552845..30c0335089b9 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -69,8 +69,6 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  	if (rc < 0)
>>  		return rc;
>>  
>> -	cxl_switch_parse_cdat(port);
>> -
>>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>>  	if (!IS_ERR(cxlhdm))
>>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> 
> 

