Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9A198823
	for <linux-cxl@vger.kernel.org>; Fri, 25 Apr 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745621356; cv=none; b=Kar1UGlCWATd2Exl5hTQjte37XNFLFTH8qgDXYx2s7BlqHrYN4qdsj5uZIAxIJbNnSBW8U2o4gkLAJsYo2eFIkrepV8XIxW/wwjr6YWekvdyTcqnCQbHt6nSj19jb8qZLq3UnNBQKow7AOt9VvOAKokdKL2oLoH/TF26EaPMvw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745621356; c=relaxed/simple;
	bh=d1LwZje/uKFMIX5YON7dYLrBr6B1Va2M6E/vGjuNLxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGxdnULsJWHbU9mtrHl4qxnpwKAt4Xa+3WEFnvMuje8dhNX+MBFQElWMruU0OPTePYrP7KkOFFQRcLDPFCep5p0iuWP5ClH7VdyfsApXk2MlZsqT2HeOapCAZ4lmh2P/YnepgWXyKe3Zuyh3wcJ2aZZXTKUpd4p3f7f6BsqnwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUm0xM9o; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUm0xM9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745621355; x=1777157355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d1LwZje/uKFMIX5YON7dYLrBr6B1Va2M6E/vGjuNLxQ=;
  b=UUm0xM9oiv9Bkpl29hhq0Bz2ANlcG8tjbXfnTuMOkqW5gLtUn5hOsQo+
   leXDXC3SZPSQoe0oTItKXNB8y4Wo7kzhZb14UobBBMCZMuFyDoev3FXgC
   u3beDBHmFwEmiXMxNYB6Tlib4n9Mbsou65sgPK1La+XdJx6S9552ZLgcS
   sNJ6Ocz/OPHeFocvFbIRURySBgMBcZxgRDOaWSkdGyTffDIeUNMduhfJ/
   P3xUZ6rDwdt7azwVA1yE6dPeWWIOi6FXFmErL7hJPhIdnTbRh1oxQt6ao
   WIPRT/zXvL5EcuMRlQO1PtbPaSevLh60ohNHid/Us4vF/Ftq8DiZpQTH7
   w==;
X-CSE-ConnectionGUID: MorC/xcxRJ2seQTHwGv6fg==
X-CSE-MsgGUID: hIKLkFKUQse2hL/f6cSIYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="64711862"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="64711862"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:49:10 -0700
X-CSE-ConnectionGUID: nNUTDT5JRh+ijqdePS3+oQ==
X-CSE-MsgGUID: rVvAQWiNRLKIYdUEdg0Mag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="133536949"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.211]) ([10.125.108.211])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:49:09 -0700
Message-ID: <b99752af-0c52-464b-a968-4c8145f18f7f@intel.com>
Date: Fri, 25 Apr 2025 15:49:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cxl: Defer hardware dport->port_id assignment and
 registers probing
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 ming.li@zohomail.com
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-3-dave.jiang@intel.com>
 <20250422180505.0000036a@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250422180505.0000036a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 10:05 AM, Jonathan Cameron wrote:
> On Fri, 4 Apr 2025 15:57:34 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Current implementation only enuemrates the dports dupring the port probe.
>> Without an endpoint connected, the dport may not be active during port
>> probe. This scheme may prevent a valid hardware dport id to be retrieved
>> and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
>> dport id assignment and the register probing to behind memdev probe so the
>> endpoint is guaranteed to be connected.
> A few additional comments from me.
> 
> 
> Can we point at anything in the PCI spec to say whether those IDs not being
> valid is allowed or not?  I always like to know whether to grump at hardware
> folk or not if it they manage to duplicate something unexpected :)

Nothing I can find. The thinking was stemmed from this series [1] by Robert.

[1]: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/

Mainly the intention of the current series is to enumerate ports triggered by memdev probe(). At that point we know there's an endpoint device and the link is established from EP to RP.

> 
> 
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
> 
> Given return value is always ignored, maybe don't return anything?

ok

> 
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
> 
> I'd be tempted to return an error that means come back later and eat it
> at next level up if possible (though currently you eat all errors so
> that is fine ;)
> >> +
>> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>> +	if (rc) {
>> +		dev_dbg(&port->dev, "failed to find component registers\n");
>> +		return 0;
> 
> Likewise. Something called probe_dports() to me should be returning an erorr
> if this happens and caller be responsible for ignoring that or not rather
> than errors being eaten down here.
> 
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
> 
> Bonus blank line doesn't add anything.

will remove

> 
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
> 
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index e90e55bc11ac..1c772c516dbe 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
> 
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
> 
> Maybe do this factoring out as a precursor patch?

ok will do
> 
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

