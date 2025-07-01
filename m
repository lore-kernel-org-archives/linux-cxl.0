Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C887E289364
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401103; cv=none; b=IAIJaexphGYORBDn0l0MlEu9z5CsGKM7CqB5sfmRenNuKnX/34O5vnlxDbD0cjHgyGZ8RZvc/ttEFefu16MqE6vzugNezEhB1/vKV5fnKqUHv01oVKZWDuA25WbKG5OlwSU1hjKNDNKrKwEB1uVGtmt+ZnOaPkNPLSNaSMinVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401103; c=relaxed/simple;
	bh=aLimmAyNmHb/a7W8bN/eoswxL2yJHSYV/tToKJRklyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgKiujvtdO0ifevkdvgKKXwFnUB7rBHHVCECO/fCLzFWFc57PSAXeePj1uh64PuujBJhByQI7twrEM39hkI22NW48EDrSF2iTq2gb13q9LLGI538XKP+7UNCB3ALw0ilWkmm3WrPEcEauGDnpg7n/7RZst39P5DOnZWEx0R0/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LheJN3Ct; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LheJN3Ct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751401101; x=1782937101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aLimmAyNmHb/a7W8bN/eoswxL2yJHSYV/tToKJRklyk=;
  b=LheJN3Ct6Twn+C1MWXLDe9zAJH3MukdrvVvYpmh7jcctiQmcE6tr75fk
   zNVNjItvIl0RE11tJotxKbQbpxEWzxz/NN8HO2MkzO+o6HL/akC02WeqG
   1xz6p1COncmyQ+I4cdN0cYTzHiGIDQPiWVFj1lblPqX8kjm6NrJ5B8sTW
   eBrSI1cxmiKB7WOWNKBdHerep5vn3cpP58Oql6fViypZlk2UAOK0SUugw
   BMYzIm2WD1XUm6ValbklxOZP6AufKqZdNrL7ysEpM9b/0g+OCPrpZ7wvl
   P/0VT2GDBpnLOYayw2s6XXECADzny4xKHiik1vjw97HKNh4/KhgSUJuxP
   w==;
X-CSE-ConnectionGUID: VSJ/USc9TOeSfbcTiJHMYQ==
X-CSE-MsgGUID: LhWcEKCgSwezY/SXH0RCcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71247432"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71247432"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 13:18:20 -0700
X-CSE-ConnectionGUID: fu0bMV5+Q1mBm4fwTgo81g==
X-CSE-MsgGUID: ylLB589lQQyET2i45ncRXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153495923"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 13:18:19 -0700
Message-ID: <69efff01-1fff-488c-8bea-496a56cb057d@intel.com>
Date: Tue, 1 Jul 2025 13:18:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] cxl: Defer dport allocation for switch ports
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 rrichter@amd.com
References: <20250624213916.1665889-1-dave.jiang@intel.com>
 <20250624213916.1665889-5-dave.jiang@intel.com>
 <20250701121022.000035d1@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250701121022.000035d1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/25 4:10 AM, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 14:39:11 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> The current implementation enumerates the dports during the cxl_port
>> driver probe. Without an endpoint connected, the dport may not be
>> active during port probe. This scheme may prevent a valid hardware
>> dport id to be retrieved and MMIO registers to be read when an endpoint
>> is hot-plugged. Move the dport allocation and setup to behind memdev
>> probe so the endpoint is guaranteed to be connected.
>>
>> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
>> switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
>> ACPI0017.N device. Through that it enumerate downstream ports composed
>> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
>> use add_host_bridge_uport() to create the ports that enumerates the PCI
>> RPs as the dports of these ports. Every time a port is created, the port
>> driver is attached and drv->probe() is called and
>> devm_cxl_port_enumerate_dports() is envoked to enumerate and probe
>> the dports.
>>
>> The second phase is if there are any CXL switches. When the pci endpoint
>> device driver (cxl_pci) calls probe, it will add a mem device and triggers
>> the cxl_mem->probe(). cxl_mem->probe() calls devm_cxl_enumerate_ports()
>> and attempts to discovery and create all the ports represent CXL switches.
>> During this phase, a port is created per switch and the attached dports
>> are also enumerated and probed.
>>
>> The last phase is creating endpoint port which happens for all endpoint
>> devices.
>>
>> In this commit, the port create and its dport probing in cxl_acpi is not
>> changed. That will be handled in a different patch later on. The behavior
>> change is only for CXL switch ports. Only the dport that is part of the
>> path for an endpoint device to the RP will be probed. This happens
>> naturally by the code walking up the device hierarchy and identifying the
>> upstream device and the downstream device.
>>
>> There are two points where the interception of dport creation happens
>> during the devm_cxl_enumerate_ports() path. The first location is right
>> before the function calls add_port_attch_ep() where it does the dport
> 
> attach_ep()
> 
>> allocation for the RP. Once the dport is allocated, the iteration path
>> is reset to the beginning to try again. The second location happens
>> in add_port_attach_ep() after the location where either the port is
>> discovered or allocated new if it does not exist.
>>
>> Locking of port device during __cxl_port_add_dport() protects modifications
>> against the port and its dports while multiple endpoints can be probing at
>> the same time and the same port is being modified concurrently.
>>
>> While the decoders are allocated during the port driver probe,
>> The decoders must also be updated since previously it's all done when all
>> the dports are setup and now every time a dport is setup per endpoint, the
>> switch target listing need to be updated with new dport. A
>> guard(rwsem_write) is used to update decoder targets. This is similar to
>> when decoder_populate_target() is called and the decoder programming
>> must be protected.
>>
>> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v4:
>> - Allocate dport when they are found via endpoint probe. (Robert)
> 
> A few comments inline. 
> 
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index b50551601c2e..6e9b5ab69de0 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -24,6 +24,44 @@ static unsigned short media_ready_timeout = 60;
>>  module_param(media_ready_timeout, ushort, 0644);
>>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
> 
>>  struct cxl_walk_context {
>>  	struct pci_bus *bus;
>>  	struct cxl_port *port;
>> @@ -1169,3 +1207,53 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>>  
>>  	return 0;
>>  }
>> +
>> +static int match_dport(struct pci_dev *pdev, void *data)
>> +{
>> +	struct cxl_walk_context *ctx = data;
>> +	int type = pci_pcie_type(pdev);
>> +
>> +	if (pdev->bus != ctx->bus)
>> +		return 0;
>> +	if (!pci_is_pcie(pdev))
>> +		return 0;
>> +	if (type != ctx->type)
> 
> I'm lost.  How would bus have matched, but type not?
> Add a comment.

I don't follow. It could be PCI bus but not the right device type (i.e. not a downstream port or root port). Or do you mean explain that? Sure. 

> 
>> +		return 0;
>> +
>> +	ctx->count++;
>> +	return 0;
>> +}
>> +
>> +int cxl_port_get_total_dports(struct cxl_port *port)
> 
> See comment below on renaming this given it doesn't return
> the number.
> 
>> +{
>> +	struct pci_bus *bus = cxl_port_to_pci_bus(port);
>> +	struct cxl_walk_context ctx;
>> +	int type;
>> +
>> +	if (!bus) {
>> +		dev_err(&port->dev, "No PCI bus found for port %s\n",
>> +			dev_name(&port->dev));
>> +		return -ENXIO;
>> +	}
>> +
>> +	if (pci_is_root_bus(bus))
>> +		type = PCI_EXP_TYPE_ROOT_PORT;
>> +	else
>> +		type = PCI_EXP_TYPE_DOWNSTREAM;
>> +
>> +	ctx = (struct cxl_walk_context) {
>> +		.bus = bus,
>> +		.type = type,
>> +	};
>> +	pci_walk_bus(bus, match_dport, &ctx);
>> +
>> +	port->total_dports = ctx.count;
>> +	if (port->total_dports == 0) {
>> +		dev_warn(&port->dev, "No dports found for port %s on bus %s\n",
>> +			 dev_name(&port->dev), bus->name);
>> +		return -ENXIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_total_dports, "CXL");
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 9691da831224..3872638c439b 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1551,6 +1551,134 @@ static resource_size_t find_component_registers(struct device *dev)
>>  	return map.resource;
>>  }
> 
> 
> 
>> +
>> +static int devm_cxl_add_dport_by_uport(struct device *uport_dev,
>> +				       struct device *dport_dev,
>> +				       struct cxl_dport **dport)
>> +{
>> +	*dport = NULL;
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		find_cxl_port_by_uport(uport_dev);
>> +	if (!port)
>> +		return -ENODEV;
>> +
>> +	guard(device)(&port->dev);
>> +	return devm_cxl_port_add_dport(port, dport_dev, dport);
>> +}
>> +
>> +static int devm_cxl_add_dport_for_rp(struct device *uport_dev,
>> +				     struct device *dport_dev,
>> +				     struct cxl_dport **dport)
> 
> That this sets *dport = NULL lead me to get confused at the caller.
> Perhaps instead these could return a dport *, NULL or ERR_PTR()
> instead?

Yeah I went back and forth a bit on this one. I needed a way to distinguish between returning an existing dport vs a newly allocated dport. I suppose I could return PTR_ERR(-EEXIST) and then try to retrieve that dport again. Thoughts?

DJ
>  
>> +{
>> +	struct device *dparent = grandparent(dport_dev);
>> +
>> +	*dport = NULL;
>> +	/* Only go down this path if we are at the root port */
>> +	if (!is_cxl_hierarchy_head(dparent))
>> +		return 0;
>> +
>> +	return devm_cxl_add_dport_by_uport(uport_dev, dport_dev, dport);
>> +}
>> +
>>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			      struct device *uport_dev,
>>  			      struct device *dport_dev)
>> @@ -1584,6 +1712,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  	 */
>>  	struct cxl_port *port __free(put_cxl_port) = NULL;
>>  	scoped_guard(device, &parent_port->dev) {
>> +		struct cxl_dport *new_dport;
>> +
>>  		if (!parent_port->dev.driver) {
>>  			dev_warn(&cxlmd->dev,
>>  				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
>> @@ -1592,6 +1722,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  		}
>>  
>>  		port = find_cxl_port_at(parent_port, dport_dev, &dport);
>> +		if (!port)
>> +			port = find_cxl_port_by_uport(uport_dev);
>>  		if (!port) {
>>  			component_reg_phys = find_component_registers(uport_dev);
>>  			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>> @@ -1599,11 +1731,17 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			if (IS_ERR(port))
>>  				return PTR_ERR(port);
>>  
>> -			/* retry find to pick up the new dport information */
>> -			port = find_cxl_port_at(parent_port, dport_dev, &dport);
>> -			if (!port)
>> -				return -ENXIO;
>> +			get_device(&port->dev);
> 
> Not immediately obvious to me why a reference needs to be grabbed here. PErhaps
> a comment?
> 
>>  		}
>> +
>> +		guard(device)(&port->dev);
>> +		/* Existing dport is checked with no action done if exists */
>> +		rc = devm_cxl_port_add_dport(port, dport_dev, &new_dport);
> 
> Similar comment to below. Would prefer
> 
> 		new_dport = devm_cxl_port_add_dport(port, dprot_dev);
> 		if (IS_ERR(new_dport))
> 			return PTR_ERR(new_dport);
> 
> 
> Similar approach already used for devm_cxl_add_port()
> 
> 
>> +		if (rc)
>> +			return rc;
>> +
>> +		if (new_dport)
>> +			dport = new_dport;
>>  	}
>>  
>>  	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
>> @@ -1620,11 +1758,13 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
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
>> @@ -1643,7 +1783,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  	 * attempt fails.
>>  	 */
>>  retry:
>> -	for (iter = dev; iter; iter = grandparent(iter)) {
>> +	for (i = 0, iter = dev; iter; i++, iter = grandparent(iter)) {
>>  		struct device *dport_dev = grandparent(iter);
>>  		struct device *uport_dev;
>>  		struct cxl_dport *dport;
>> @@ -1686,9 +1826,28 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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
>> +		rc = devm_cxl_add_dport_for_rp(uport_dev, dport_dev, &dport);
> 
> As above, I'd prefer to see
> 		dport = devm_cxl_add_dport_for_rp(uport_dev, dport_dev);
> 		if (IS_ERR(dport))
> 			return PTR_ERR(dport);
> 
> 		if (dport)
> 			goto retry;
> 
> That way it's explicit that dport is going to be updated in all cases within
> devm_cxl_add_dport_for_rp()
> 
>> +		if (rc)
>> +			return rc;
>> +		/* Added a dport, restart enumeration */
>> +		if (dport)
>> +			goto retry;
>> +
>>  		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
>>  		/* port missing, try to add parent */
>>  		if (rc == -EAGAIN)
>> @@ -1727,16 +1886,19 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>>  		return 0;
>>  
>>  	device_lock_assert(&port->dev);
>> +	memcpy(cxlsd->target_map, target_map, sizeof(cxlsd->target_map));
>>  
>>  	if (xa_empty(&port->dports))
>> -		return -EINVAL;
>> +		return 0;
>>  
>>  	guard(rwsem_write)(&cxl_region_rwsem);
>>  	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
>>  		struct cxl_dport *dport = find_dport(port, target_map[i]);
>>  
>> -		if (!dport)
>> -			return -ENXIO;
>> +		if (!dport) {
>> +			/* dport may be activated later */
>> +			continue;
>> +		}
>>  		cxlsd->target[i] = dport;
>>  	}
> 
> 
> 
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index fe4b593331da..354e134793c3 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -65,12 +65,10 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  	/* Cache the data early to ensure is_visible() works */
>>  	read_cdat_data(port);
>>  
>> -	rc = devm_cxl_port_enumerate_dports(port);
>> -	if (rc < 0)
>> +	rc = cxl_port_get_total_dports(port);
> 
> A function called cxl_port_get_total_dports() to my thinking should return
> the number of them not fill in a value embedded in port.
> 
> cxl_port_update_total_dports() perhaps?
> 
>> +	if (rc)
>>  		return rc;
>>  
>> -	cxl_switch_parse_cdat(port);
>> -
>>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>>  	if (!IS_ERR(cxlhdm))
>>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>> @@ -80,7 +78,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  		return PTR_ERR(cxlhdm);
>>  	}
>>  
>> -	if (rc == 1) {
>> +	if (port->total_dports == 1) {
>>  		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
>>  		return devm_cxl_add_passthrough_decoder(port);
>>  	}
> 

