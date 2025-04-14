Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF441E1E16
	for <linux-cxl@vger.kernel.org>; Mon, 14 Apr 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668379; cv=none; b=Ee/l6VbRCUm5i/8ggS+m2kLoOXA7W7OCQlUfQcxAV8COG1j4nRgBoHc5My8qPBACLJLECLtIO87Zu+91RNTxK9pR4nv0stYF2EnpJ+HaDZKac9EbNZiFYqIBKTiTEqg81U+ivrSSSRLNlX9tZkJof7yxumJlF/T8XvK1jjKZmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668379; c=relaxed/simple;
	bh=bm+aTcJvd0H9ypzP2qXXk86STqMl/Y+RLYl16g5BonQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keFC6UTp6QFQa10SusEHhL/XsG8SeVpUyMrenVEGnPr0BdS7fQnL69mColCsu7Vzze2A8f6cvHmCIJaSrm7s0ZtYV1Qcyy3GpHiFQThjXrjR+qBAMt9h8Myt2bqTA11VW/Id0i2jf8QqWJCuIR2YRIiVrfEluoYse3nd0Ua5y7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KbvpqR31; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KbvpqR31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744668379; x=1776204379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bm+aTcJvd0H9ypzP2qXXk86STqMl/Y+RLYl16g5BonQ=;
  b=KbvpqR316JPNZTnuz+wQXilbPRd/xQyT3yFapVOxoeFz6+i/ySePTHgT
   94rft+HwTYKwPeDJRNeYLqc2osiprBAUuQ51FAru0L8+awZK9qsIzeHBo
   s5neOo+VIIw5ynpE0a44oYHO0nXyJdC1gza/Sy5/ouRRhNl1p/RxpjgUM
   ZhyNI6DYaEYkN/AOjZmUiFz404GdaxuFEFKZSe4XfC+/MGj++svdRRgZH
   k19bG3f5XKdyP6iR4M/M0J3F/UhFUZOOaAUud+IoqNJ1PikcSrNg+XZWN
   tSu+r6Gzfkdrat5suu5vXLUA2JnjUGdY8r6BRrCq3TchR46LUeRFslgGA
   A==;
X-CSE-ConnectionGUID: uuTya6OKR+uJSOfV1qeVBA==
X-CSE-MsgGUID: atRfQFPdRQykck156jAozQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46243551"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46243551"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 15:06:18 -0700
X-CSE-ConnectionGUID: GvczA7yBTiCRGeZUT5PMkQ==
X-CSE-MsgGUID: ZCgqkoq8TL6zps/A8jJ8Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="160894031"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.28]) ([10.125.109.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 15:06:17 -0700
Message-ID: <74d7b124-a612-43b9-ba9e-db75e245642d@intel.com>
Date: Mon, 14 Apr 2025 15:06:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cxl: Add late host bridge uport mapping update
To: Li Ming <ming.li@zohomail.com>
Cc: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 linux-cxl@vger.kernel.org
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-4-dave.jiang@intel.com>
 <85986bda-6a0e-41e6-8ddd-e8ea442eff92@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <85986bda-6a0e-41e6-8ddd-e8ea442eff92@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/25 7:32 PM, Li Ming wrote:
> On 4/5/2025 6:57 AM, Dave Jiang wrote:
>> Error message "cxl portN: Couldn't locate the CXL.cache and CXL.mem
>> capability array header" is reported through testing when a platform is
>> enabled with PCIe hotplug. The cxl_acpi module is responsible for
>> enumerating the host bridges through ACPI objects. During the enumeration
>> of the host bridge upstream ports (uports), the root port (RP) registers
>> are mapped. The enumeration can happen as soon as the cxl_acpi module
>> probe() function is called. However if the CXL link between the endpoint
>> device and the RP is not established before the enumeration happens,
>> the platform may not expose DVSEC ID 3 and/or DVSEC ID 7 blocks which
>> triggers the error message.
>>
>> Add an attempt to map the register block under the memdev probe() port
>> enumeration. When the PCI probe of the device endpoint is called, the
>> driver is now communicating with the CXL device and the CXL link is
>> considered established. Doing the register block mapping at that point
>> guarantees that the mandatory DVSEC blocks are present.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/acpi.c      | 17 +++++++++-
>>  drivers/cxl/core/port.c | 72 +++++++++++++++++++++++++++++++++++++++--
>>  drivers/cxl/cxl.h       |  4 +++
>>  drivers/cxl/port.c      | 19 ++---------
>>  4 files changed, 93 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index cb14829bb9be..3c8f04bee9a3 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -662,9 +662,24 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>>  	if (rc)
>>  		return rc;
>>  
>> -	port = devm_cxl_add_port(host, bridge, component_reg_phys, dport);
>> +	/*
>> +	 * While there is a chance the uport gets mapped when the probe
>> +	 * function gets called, it is not a guarantee due to acpi driver
>> +	 * can be probed before the root port has established the CXL
>> +	 * connection to the endpoint device. Bypass mapping during
>> +	 * port creation by pass in CXL_RESOURCE_NONE for the
>> +	 * component_reg_phys parameter. After, set the 'resource'
>> +	 * parameter of port->map to allow a setup via the endpoint
>> +	 * memdev probe.
>> +	 */
>> +	port = devm_cxl_add_port(host, bridge, CXL_RESOURCE_NONE, dport);
>>  	if (IS_ERR(port))
>>  		return PTR_ERR(port);
>> +	port->reg_map = (struct cxl_register_map) {
>> +		.host = host,
>> +		.reg_type = CXL_REGLOC_RBI_EMPTY,
>> +		.resource = component_reg_phys,
>> +	};
>>  
>>  	dev_info(bridge, "host supports CXL\n");
>>  
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 1c772c516dbe..8c29db214d60 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -758,6 +758,10 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>>  static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map,
>>  			       resource_size_t component_reg_phys)
>>  {
>> +	/* Skip the setup if the map has been setup previously. */
>> +	if (map->reg_type != CXL_REGLOC_RBI_EMPTY)
>> +		return 0;
>> +
>>  	*map = (struct cxl_register_map) {
>>  		.host = host,
>>  		.reg_type = CXL_REGLOC_RBI_EMPTY,
>> @@ -773,7 +777,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>>  	return cxl_setup_regs(map);
>>  }
>>  
>> -static int cxl_port_setup_regs(struct cxl_port *port,
>> +int cxl_port_setup_regs(struct cxl_port *port,
>>  			resource_size_t component_reg_phys)
>>  {
>>  	if (dev_is_platform(port->uport_dev))
>> @@ -781,6 +785,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>>  	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>>  				   component_reg_phys);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(cxl_port_setup_regs, "CXL");
>>  
>>  static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>  				resource_size_t component_reg_phys)
>> @@ -1004,7 +1009,7 @@ int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, "CXL");
>>  
>> -static bool dev_is_cxl_root_child(struct device *dev)
>> +bool dev_is_cxl_root_child(struct device *dev)
>>  {
>>  	struct cxl_port *port, *parent;
>>  
>> @@ -1021,6 +1026,7 @@ static bool dev_is_cxl_root_child(struct device *dev)
>>  
>>  	return false;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(dev_is_cxl_root_child, "CXL");
>>  
>>  struct cxl_root *find_cxl_root(struct cxl_port *port)
>>  {
>> @@ -1565,6 +1571,57 @@ static resource_size_t find_component_registers(struct device *dev)
>>  	return map.resource;
>>  }
>>  
>> +int devm_cxl_decoders_setup(struct cxl_port *port)
>> +{
>> +	struct cxl_dport *dport;
>> +	struct cxl_hdm *cxlhdm;
>> +	unsigned long index;
>> +	int dports = 0;
>> +
>> +	/* Make sure that no decoders have been allocated before proceeding. */
>> +	if (!ida_is_empty(&port->decoder_ida))
>> +		return 0;
>> +
>> +	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>> +	if (!IS_ERR(cxlhdm))
>> +		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>> +
>> +	if (PTR_ERR(cxlhdm) != -ENODEV) {
>> +		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
>> +		return PTR_ERR(cxlhdm);
>> +	}
>> +
>> +	xa_for_each(&port->dports, index, dport)
>> +		dports++;
>> +
>> +	if (dports == 1) {
>> +		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
>> +		return devm_cxl_add_passthrough_decoder(port);
>> +	}
>> +
>> +	dev_err(&port->dev, "HDM decoder capability not found\n");
>> +	return -ENXIO;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(devm_cxl_decoders_setup, "CXL");
>> +
>> +static int cxl_hb_port_setup(struct cxl_port *port)
>> +{
>> +	int rc;
>> +
>> +	device_lock_assert(&port->dev);
>> +
>> +	if (!dev_is_cxl_root_child(&port->dev))
>> +		return 0;
>> +
>> +	cxl_port_probe_dports(port);
>> +
>> +	rc = cxl_port_setup_regs(port, port->reg_map.resource);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return devm_cxl_decoders_setup(port);
>> +}
>> +
>>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			      struct device *uport_dev,
>>  			      struct device *dport_dev)
>> @@ -1605,6 +1662,17 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			return -ENXIO;
>>  		}
>>  
>> +		/*
>> +		 * Initiate delayed host bridge setup here in the path of memdev probe
>> +		 * to ensure that the CXL link is established.
>> +		 */
>> +		rc = cxl_hb_port_setup(parent_port);
>> +		if (rc) {
>> +			dev_warn(&cxlmd->dev, "Failed HB port setup of %s.\n",
>> +				 dev_name(&parent_port->dev));
>> +			return rc;
>> +		}
>> +
> 
> My understanding is that add_port_attach_ep() is only called for cxl switch port adding. cxl hb ports are already added during cxl acpi probing, they can be found in devm_cxl_enumerate_ports().
> 
> So if an endpoint directly connects to a root port, seems like no chance to call cxl_hb_port_setup() in add_port_attach_ep().

Thanks for pointing that out. I need to modify my qemu setup to test this scenario.

DJ

> 
> 
>>  		port = find_cxl_port_at(parent_port, dport_dev, &dport);
>>  		if (!port) {
>>  			component_reg_phys = find_component_registers(uport_dev);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 0e61b76f5c13..b27e9d3306fe 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -906,6 +906,10 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>>  			     struct access_coordinate *c2);
>>  
>>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>> +int devm_cxl_decoders_setup(struct cxl_port *port);
>> +bool dev_is_cxl_root_child(struct device *dev);
>> +int cxl_port_setup_regs(struct cxl_port *port,
>> +			resource_size_t component_reg_phys);
>>  
>>  /*
>>   * Unit test builds overrides this to __weak, find the 'strong' version
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 30c0335089b9..dc532ee9065f 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -59,7 +59,6 @@ static int discover_region(struct device *dev, void *root)
>>  
>>  static int cxl_switch_port_probe(struct cxl_port *port)
>>  {
>> -	struct cxl_hdm *cxlhdm;
>>  	int rc;
>>  
>>  	/* Cache the data early to ensure is_visible() works */
>> @@ -69,22 +68,10 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  	if (rc < 0)
>>  		return rc;
>>  
>> -	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>> -	if (!IS_ERR(cxlhdm))
>> -		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>> +	if (dev_is_cxl_root_child(&port->dev))
>> +		return 0;
>>  
>> -	if (PTR_ERR(cxlhdm) != -ENODEV) {
>> -		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
>> -		return PTR_ERR(cxlhdm);
>> -	}
>> -
>> -	if (rc == 1) {
>> -		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
>> -		return devm_cxl_add_passthrough_decoder(port);
>> -	}
>> -
>> -	dev_err(&port->dev, "HDM decoder capability not found\n");
>> -	return -ENXIO;
>> +	return devm_cxl_decoders_setup(port);
>>  }
>>  
>>  static int cxl_endpoint_port_probe(struct cxl_port *port)
> 
> 

