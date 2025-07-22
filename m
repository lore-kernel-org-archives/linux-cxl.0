Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72A17C224
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199250; cv=none; b=ZMpw0UrhUmhZtepJmax40FvkRA95+ZOil2P7E5bnYiZwqhTT8Y3N87BuOZkqCN7xcp4SBkzX2jveYQeDGiRa2OrRJ4zE4v6eK4LvLgFQwUn5Gr2v4EymqR9oWwNpDumWdN6cDHdX5C19KbfwsnG2WGtywVtHmiL2pZyVk/zLySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199250; c=relaxed/simple;
	bh=9RsOUEvbmcbaOoaBhTadfa6kcuKshi2Sljbdg98w7a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAiN3W4Nmc1LICXzrRX4ThSRk1jYl1Q3xmmD6oHlcAZWj4h5JlpJnM8CqkRZ13ZStMEZGLILeHNEvOcIjEk0P8j4OkNDwdfLxFgSGDWksQSgXSKSoI3b7tDDt5gsRV9qVVC5Lcz99rZhJFCC6lfh4YcbaE+5mgaevCa64AWAExE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBlhULRs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBlhULRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753199238; x=1784735238;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9RsOUEvbmcbaOoaBhTadfa6kcuKshi2Sljbdg98w7a8=;
  b=SBlhULRs9uX2gikAmZOwnqIHyh5QEE91gW4l6gC7V/0RDk62HXjCsjAs
   iiUBk/PDdrHvjyVN4+v7GqqpL9G3jgKmOC+jNC0fdxa3ATWtjKgmHWFon
   HEss9ADsfOAfAZnoUxpAzXBMMeo6yAkwQJgpAL9+nUeZlLDANHpald137
   ceGTMbKvW41bLoFvW0A8Jqu2vyATcOHMA7P1COtkfngCIWhGAntrlEXu1
   yB59VRST/1w5zXd6zHEyX1gQhOPNX+YSoBqel4c+Ynp61LygtBs3yZxQ0
   Wz01UCXK4068bH5XfGOD0baSEnL75uTasxT3EBdXWnCJ/6NBvi58E/FMJ
   A==;
X-CSE-ConnectionGUID: Lox9GPN/Q36gSmzkTqS/1Q==
X-CSE-MsgGUID: 4xa49bNAQc2OhA4w8PxgVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54559580"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="54559580"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:47:17 -0700
X-CSE-ConnectionGUID: i8UkGCX0SHuXVvg8w6Ycew==
X-CSE-MsgGUID: Rap+xnqDRnqMoSKFEfhrFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163228710"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.166]) ([10.247.118.166])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 08:47:12 -0700
Message-ID: <307a1f92-11ca-452f-9bc4-f2689dadeec7@intel.com>
Date: Tue, 22 Jul 2025 08:47:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/10] cxl: Defer dport allocation for switch ports
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-5-dave.jiang@intel.com>
 <aH7JvK-67RgV8fP0@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aH7JvK-67RgV8fP0@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/25 4:14 PM, Robert Richter wrote:
> Hi Dave,
> 
> see inline.
> 
> On 14.07.25 15:35:21, Dave Jiang wrote:
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
>> before the function calls add_port_attach_ep() where it does the dport
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
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v7:
>> - Return dport instead of -EEXIST (Ming)
>> - Remove extra goto retry (Ming)
>> ---
>>  drivers/cxl/core/core.h |   2 +
>>  drivers/cxl/core/pci.c  |  88 +++++++++++++++++++
>>  drivers/cxl/core/port.c | 185 ++++++++++++++++++++++++++++++++++++----
>>  drivers/cxl/cxl.h       |   5 ++
>>  drivers/cxl/port.c      |   8 +-
>>  5 files changed, 267 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 29b61828a847..8cfead6f3b08 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -122,6 +122,8 @@ void cxl_ras_exit(void);
>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>>  int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>>  					    int nid, resource_size_t *size);
>> +struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>> +					    struct device *dport_dev);
>>  
>>  #ifdef CONFIG_CXL_FEATURES
>>  struct cxl_feat_entry *
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index b50551601c2e..336451b9144a 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -24,6 +24,44 @@ static unsigned short media_ready_timeout = 60;
>>  module_param(media_ready_timeout, ushort, 0644);
>>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>>  
>> +/**
>> + * devm_cxl_add_dport_by_dev - allocate a dport by dport device
>> + * @port: cxl_port that hosts the dport
>> + * @dport_dev: 'struct device' of the dport
>> + *
>> + * Returns the allocate dport on success or ERR_PTR() of -errno on error
>> + */
>> +struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>> +					    struct device *dport_dev)
>> +{
>> +	struct cxl_register_map map;
>> +	struct pci_dev *pdev;
>> +	u32 lnkcap, port_num;
>> +	int type;
>> +	int rc;
>> +
>> +	if (!dev_is_pci(dport_dev))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	device_lock_assert(&port->dev);
>> +
>> +	pdev = to_pci_dev(dport_dev);
>> +	type = pci_pcie_type(pdev);
>> +	if (type != PCI_EXP_TYPE_DOWNSTREAM && type != PCI_EXP_TYPE_ROOT_PORT)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
>> +				  &lnkcap))
>> +		return ERR_PTR(-ENXIO);
>> +
>> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>> +	if (rc)
>> +		dev_dbg(&port->dev, "failed to find component registers\n");
>> +
>> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
>> +	return devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
>> +}
>> +
>>  struct cxl_walk_context {
>>  	struct pci_bus *bus;
>>  	struct cxl_port *port;
>> @@ -1169,3 +1207,53 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>>  
>>  	return 0;
>>  }
>> +
>> +static int match_dport(struct pci_dev *pdev, void *data)
> 
> count_dports()?

ok
> 
>> +{
>> +	struct cxl_walk_context *ctx = data;
>> +	int type = pci_pcie_type(pdev);
> 
> The compiler might optimize this, but better place this after
> pci_is_pcie(). The local variable could be omitted.

ok

> 
>> +
>> +	if (pdev->bus != ctx->bus)
>> +		return 0;
>> +	if (!pci_is_pcie(pdev))
>> +		return 0;
>> +	if (type != ctx->type)
>> +		return 0;
>> +
>> +	ctx->count++;
>> +	return 0;
>> +}
>> +
>> +int cxl_port_update_total_dports(struct cxl_port *port)
> 
> I would prefer to name this cxl_pci_count_dports() or so (if the need
> this at all, see below).

ok
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
> 
> This is not an error, the switch port could be non-pci. I think you
> should add a pci check in front of this and early exit with 0 then.
> This emphasizes also the cxl_pci_*() naming.

cxl_test replaces this function with its own mock function. So unless we are dealing with some other topology, it should be PCI.

> 
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
> 
> match_dport() should be named count_dports().

ok
> 
>> +
>> +	port->total_dports = ctx.count;
>> +	if (port->total_dports == 0) {
>> +		dev_warn(&port->dev, "No dports found for port %s on bus %s\n",
>> +			 dev_name(&port->dev), bus->name);
>> +		return -ENXIO;
> 
> This isn't an error either, there just could be no dports online.

The dports should exist even if it's not online. This counts total possible dports and not total online dports. We don't try to access it. Just checking if the dport has be enumerated by the PCI subsystem. If we encounter a port with no dports at all, this should be an error. 

> 
> Why do you count this at all? An empty number of dports is possible
> and not an error.
> 
> I see, you are using total_dports only to setup passthrough
> decoders. I think we should allow to setup the first dport with a
> passthrough decoder if cxlhdm->decoder_count of the port is zero, but
> later fail if a 2nd dport is found.

So we should know how many possible dports there can be, just some may not be online yet. But it is easier to just get that count and create the passthrough decoder if the count is 1 rather than do the dance of seeing if a second dport shows up later and try to kill the passthrough decoder. Maybe it's not necessary to store a total_dports in cxl_port. 

DJ
  
> 
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_port_update_total_dports, "CXL");
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 9691da831224..c1de6872e57f 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1551,6 +1551,116 @@ static resource_size_t find_component_registers(struct device *dev)
>>  	return map.resource;
>>  }
>>  
>> +static int match_port_by_uport(struct device *dev, const void *data)
>> +{
>> +	const struct device *uport_dev = data;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +	return uport_dev == port->uport_dev;
>> +}
>> +
>> +/*
>> + * Function takes a device reference on the port device. Caller should do a
>> + * put_device() when done.
>> + */
>> +static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>> +{
>> +	struct device *dev;
>> +
>> +	dev = bus_find_device(&cxl_bus_type, NULL, uport_dev, match_port_by_uport);
>> +	if (dev)
>> +		return to_cxl_port(dev);
>> +	return NULL;
>> +}
>> +
>> +static int update_switch_decoder(struct device *dev, void *data)
>> +{
>> +	struct cxl_dport *dport = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_decoder *cxld;
>> +	int i;
>> +
>> +	if (!is_switch_decoder(dev))
>> +		return 0;
>> +
>> +	cxlsd = to_cxl_switch_decoder(dev);
>> +	cxld = &cxlsd->cxld;
>> +	guard(rwsem_write)(&cxl_region_rwsem);
>> +	for (i = 0; i < cxld->interleave_ways; i++) {
>> +		if (cxlsd->target_map[i] == dport->port_id) {
>> +			cxlsd->target[i] = dport;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	dev_dbg(dev, "Updating decoder target_map with %s and none found\n",
>> +		dev_name(dport->dport_dev));
> 
> I that message really needed for debugging? It does not seem an error
> to me. The success path is much more interesting, e.g.:
> 
>    	dev_dbg(dev, "dport%d found in target list, index %d\n", ...);
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int update_decoders_with_dport(struct cxl_port *port, struct cxl_dport *dport)
>> +{
>> +	device_lock_assert(&port->dev);
> 
> Already checked in cxl_port_setup_with_dport().
> 
>> +	return device_for_each_child(&port->dev, dport, update_switch_decoder);
> 
> Can be squashed into cxl_port_setup_with_dport().
> 
> update_target_map() 
> 
>> +}
>> +
>> +static int cxl_port_setup_with_dport(struct cxl_port *port,
>> +				     struct cxl_dport *dport)
>> +{
> 
> Argument port can be removed, it is dport->port.
> 
>> +	device_lock_assert(&port->dev);
>> +
>> +	cxl_switch_parse_cdat(port);
>> +
>> +	return update_decoders_with_dport(port, dport);
>> +}
>> +
>> +static struct cxl_dport *devm_cxl_port_add_dport(struct cxl_port *port,
> 
> The name is misleading as an existing dport could be reused. Name it
> cxl_port_get_dport()?
> 
>> +						 struct device *dport_dev)
>> +{
>> +	struct cxl_dport *dport;
>> +	int rc;
>> +
>> +	device_lock_assert(&port->dev);
> 
> Why don't you move guard() here?
> 
>> +
>> +	/* Port driver not attached yet, wait for cxl_acpi reprobe */
>> +	if (!port->dev.driver)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	dport = cxl_find_dport_by_dev(port, dport_dev);
>> +	if (dport)
>> +		return dport;
>> +
>> +	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
>> +	if (IS_ERR(dport))
>> +		return dport;
>> +
>> +	rc = cxl_port_setup_with_dport(port, dport);
> 
> With the removal of the port arg this could be:
> 
> 	rc = cxl_dport_update_target_maps(dport);
> 
> 
> That could be moved to devm_cxl_add_dport() along with the cleanup
> below.
> 
>> +	if (rc) {
>> +		reap_dport(port, dport);
> 
> Same here port, could be removed from the arg list.
> 
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
>>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  			      struct device *uport_dev,
>>  			      struct device *dport_dev)
>> @@ -1584,6 +1694,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  	 */
>>  	struct cxl_port *port __free(put_cxl_port) = NULL;
>>  	scoped_guard(device, &parent_port->dev) {
>> +		struct cxl_dport *new_dport;
> 
> Why don't you use dport directly?
> 
>> +
>>  		if (!parent_port->dev.driver) {
>>  			dev_warn(&cxlmd->dev,
>>  				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
>> @@ -1592,6 +1704,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  		}
>>  
>>  		port = find_cxl_port_at(parent_port, dport_dev, &dport);
> 
> That call could be removed as the find_cxl_port_by_uport() will find
> it.
> 
>> +		if (!port)
>> +			port = find_cxl_port_by_uport(uport_dev);
>>  		if (!port) {
>>  			component_reg_phys = find_component_registers(uport_dev);
>>  			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>> @@ -1599,11 +1713,21 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
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
> 
> I would prefer the retry approach that would use
> find_cxl_port_by_uport() here.
> 
>>  		}
>> +
>> +		guard(device)(&port->dev);
>> +		new_dport = devm_cxl_port_add_dport(port, dport_dev);
> 
> I first thought, how do you ensure that dport was not yet added to
> port already. But then saw the function that does something else. It
> should be renamed.
> 
>> +		if (IS_ERR(new_dport))
>> +			return PTR_ERR(new_dport);
>> +
>> +		dport = new_dport;
>>  	}
>>  
>>  	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
>> @@ -1620,11 +1744,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>  	return rc;
>>  }
>>  
>> +#define CXL_ITER_LEVEL_SWITCH	1
>> +
>>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  {
>>  	struct device *dev = &cxlmd->dev;
>> +	struct device *dgparent;
>>  	struct device *iter;
>> -	int rc;
>> +	int rc, i;
>>  
>>  	/*
>>  	 * Skip intermediate port enumeration in the RCH case, there
>> @@ -1643,7 +1770,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  	 * attempt fails.
>>  	 */
>>  retry:
>> -	for (iter = dev; iter; iter = grandparent(iter)) {
>> +	for (i = 0, iter = dev; iter; i++, iter = grandparent(iter)) {
>>  		struct device *dport_dev = grandparent(iter);
>>  		struct device *uport_dev;
>>  		struct cxl_dport *dport;
>> @@ -1686,16 +1813,39 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  			if (!dev_is_cxl_root_child(&port->dev))
>>  				continue;
>>  
>> +			/*
>> +			 * This is a corner case where the rootport is setup but
> 
> "root port"
> 
>> +			 * the switch dport is not. It needs to go back to the
>> +			 * beginning to setup the switch port.
>> +			 */
>> +			if (i >= CXL_ITER_LEVEL_SWITCH) {
> 
> Even after reading your comment I still don't know what
> "CXL_ITER_LEVEL_SWITCH" means nor why this is a magic 1 ...
> 
>> +				struct cxl_port *pport __free(put_cxl_port) =
>> +					cxl_mem_find_port(cxlmd, &dport);
>> +				if (!pport)
>> +					goto retry;
> 
> ... and why retrying all this until dport is found for cxlmd all
> solves this. Could this end up in an infinite loop?
> 
> I think that means if i > 0 (the root port is not found with the first
> attempt) then there must be a switch port between EP and root port.
> 
> A better check would be:
> 
> 	if (dev != &cxlmd->dev)
> 		...
> 
> It looks like there is no dport yet for cxlmd. Could you explain this?
> 
> 
>> +			}
>> +
>>  			return 0;
>>  		}
>>  
>> -		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
>> -		/* port missing, try to add parent */
>> -		if (rc == -EAGAIN)
>> -			continue;
>> -		/* failed to add ep or port */
>> -		if (rc)
>> -			return rc;
>> +		dgparent = grandparent(dport_dev);
>> +		/* Only go down this path if we are at the root port */
>> +		if (is_cxl_hierarchy_head(dgparent)) {
>> +			dport = devm_cxl_add_dport_by_uport(uport_dev,
>> +							    dport_dev);
>> +			/* Added a dport, restart enumeration */
>> +			if (IS_ERR(dport))
>> +				return PTR_ERR(dport);
> 
> Move that check to add_port_attach_ep() and return early.
> 
> But, you could move that block to the check above at the beginning of
> the loop before returning 0.
> 
> I don't see much sense in the is_cxl_hierarchy_head() helper. It is
> used only in this function and possibly can reduced to the one already
> existing check.
> 
> Please explain why that path is different? Isn't uport_dev attached to
> a root port here and can't the dports just be added on creation?
> 
>> +		} else {
>> +			rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
>> +			/* port missing, try to add parent */
>> +			if (rc == -EAGAIN)
>> +				continue;
>> +			/* failed to add ep or port */
>> +			if (rc)
>> +				return rc;
>> +		}
>> +
>>  		/* port added, new descendants possible, start over */
>>  		goto retry;
>>  	}
>> @@ -1727,16 +1877,19 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
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
> 
> Could the target map update here be removed at all as that is also
> done in the new function update_switch_decoder()?
> 
>>  	}
>>  
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 3f1695c96abc..de7883747555 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -403,6 +403,7 @@ struct cxl_endpoint_decoder {
>>   * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
>>   * @cxld: base cxl_decoder object
>>   * @nr_targets: number of elements in @target
>> + * @target_map: map of target dport ids to interleave positions
>>   * @target: active ordered target list in current decoder configuration
>>   *
>>   * The 'switch' decoder type represents the decoder instances of cxl_port's that
>> @@ -414,6 +415,7 @@ struct cxl_endpoint_decoder {
>>  struct cxl_switch_decoder {
>>  	struct cxl_decoder cxld;
>>  	int nr_targets;
>> +	int target_map[CXL_DECODER_MAX_INTERLEAVE];
>>  	struct cxl_dport *target[];
>>  };
>>  
>> @@ -584,6 +586,7 @@ struct cxl_dax_region {
>>   * @parent_dport: dport that points to this port in the parent
>>   * @decoder_ida: allocator for decoder ids
>>   * @reg_map: component and ras register mapping parameters
>> + * @total_dports: total possible dports in this port
>>   * @nr_dports: number of entries in @dports
>>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>   * @commit_end: cursor to track highest committed decoder for commit ordering
>> @@ -604,6 +607,7 @@ struct cxl_port {
>>  	struct cxl_dport *parent_dport;
>>  	struct ida decoder_ida;
>>  	struct cxl_register_map reg_map;
>> +	int total_dports;
>>  	int nr_dports;
>>  	int hdm_end;
>>  	int commit_end;
>> @@ -902,6 +906,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>>  			     struct access_coordinate *c2);
>>  
>>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>> +int cxl_port_update_total_dports(struct cxl_port *port);
>>  
>>  /*
>>   * Unit test builds overrides this to __weak, find the 'strong' version
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index fe4b593331da..ee7dcd7c4f24 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -65,12 +65,10 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  	/* Cache the data early to ensure is_visible() works */
>>  	read_cdat_data(port);
>>  
>> -	rc = devm_cxl_port_enumerate_dports(port);
>> -	if (rc < 0)
>> +	rc = cxl_port_update_total_dports(port);
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
> 
> See my comment above on enabling a passthrough decoder.
> 
> Removing total_dports would simplify the implementation.
> 
>>  		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
>>  		return devm_cxl_add_passthrough_decoder(port);
>>  	}
>> -- 
>> 2.50.0
>>
> 
> -Robert

