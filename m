Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0E213E67
	for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952085; cv=none; b=ObEFLlq9iYGYTgmQjmQSanjfSb8eSZeja/KMVc/FlBvuspW0c6rNEzNJ7zAnHRkSzG6SzgV3fG4eF3qlGB8NQwKowMWUEEN+NDWbWUJGvmVk5DRlhyrdSJ/TQtVPp8Xn6kv+j85b/bulNMIuMrbNqyii+cpFJa2Y3544zErlYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952085; c=relaxed/simple;
	bh=qvU4d4uKOrwGJ450PBexvYJ9wKf6bNzZlwB+XMCzKzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZCt/KwQHmA+a9/V2kgbsTATlW8Y8S2BvEumc0S6SnnGqHhpg244ka/6ZCsPgZd/y3bRM5L2YUekSe6fuAlVxsth0/QT3Ayz8Dam79qA1INF5JhaWlYlYgVo6inHlyP4C7/Z0ytJTf6u8d7TsZDlfXXxtCsqrBplecosjbqoLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+VRR7Wc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+VRR7Wc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745952083; x=1777488083;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qvU4d4uKOrwGJ450PBexvYJ9wKf6bNzZlwB+XMCzKzo=;
  b=W+VRR7WcnbgSBe1oIAU56ClaSHpe40WraOAXOaXsFSkdEYM+JVVVmUxa
   WNkBJ2KCvfafSR9SaZ1f37+gOshHAGhnbQBN2j2Nk3Llcffczj+C0s3vR
   2JUtc692FzsuD/uFxBa8kRhaN8mBfGZnuwjJsr916vjSKjEswRvALNJ8I
   43ikCLoyQxFdDsIctNw63mMZ+v2FIggmfDffle/Gpj/AQwoZAis/2Wx4A
   ZfAmtUullKyDDM2pZefAEYTy6QaxfL28BuDtsaF1t8xVvD2xYyLqyZSQ/
   lQAcvvt1+0EB7HXITzfRwFRbxnTNPAkZDghwhEe8+AjAaxnyEoyJgRk/l
   w==;
X-CSE-ConnectionGUID: r8T1bK/5QwGVng31jHL9Ag==
X-CSE-MsgGUID: eewbtLmcT5qoj5sjWqRzJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47745315"
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="47745315"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 11:41:22 -0700
X-CSE-ConnectionGUID: 15QP8DKvQJeFyoc+nXDWKw==
X-CSE-MsgGUID: QzsqyyUBRf6Heqs6m2WKAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,249,1739865600"; 
   d="scan'208";a="171139201"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.191]) ([10.125.109.191])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 11:41:21 -0700
Message-ID: <640c0395-a5c6-44b2-9474-7a23ce3abca0@intel.com>
Date: Tue, 29 Apr 2025 11:41:20 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cxl: Defer hardware dport->port_id assignment and
 registers probing
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 ming.li@zohomail.com
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-3-dave.jiang@intel.com>
 <6807f82b60c6_71fe294e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6807f82b60c6_71fe294e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 1:12 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> Current implementation only enuemrates the dports dupring the port probe.
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
> 
> Some commentary on why it is safe to re-run this over and over again for
> each found port might help future readers. For example might this
> disturb already published data for this port?

Rerun this multiple times is harmless as it only updates the switch perf numbers for all the dports. The dport perf numbers from CDAT are static and does not change. I will create a follow on patch to only update the specific dport we are probing to make the code more efficient. 

> 
> That comment likely belongs as cxl_switch_parse_cdat() kdoc to clarify
> how it is used and re-entered for a given port multiple times.
> 
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
> 
> This also needs to check if port->dev.driver is non-null otherwise it
> could be mapping resources onto an idle port.

ok

> 
>> +	xa_for_each(&port->dports, index, dport)
>> +		probe_dports(dport);
>> +}
>> +
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
> 
> Hm, why pass in an invalid id for the common case vs make the static
> case just manually "probe" after add_dport?

ok

> 
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
> 
> It seems a little bit awkward to maintain the RCRB code in this path.
> The whole dport mapping problem is a CXL 2.0 complexity. The CXL 1.1 path
> should probably be separated from all this deferral logic to keep it
> cleaner.
> 
> Keep in mind that devm_cxl_enumerate_ports() early exits in the RCD
> case, so I do not expect this code ever runs if cxl_port_probe_dports()
> late in devm_cxl_enumerate_ports() is the only caller.

ok

> 
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
> 
> A comment here would be nice to indicate why this port did not probe
> dports before.
> 
> The comment would likely also answer why this is only called in the
> "already registered" case, and not the initial port creation case in
> add_port_attach_ep().

I think that if we do it at port creation, we also would need to do it here anyways for a port that's already created for the other dports. I think we can just do all of the dports here in a single location. Did I miss something?

DJ

> 
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
>> -- 
>> 2.49.0
>>
> 
> 

