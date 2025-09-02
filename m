Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AEC31CA71
	for <linux-cxl@vger.kernel.org>; Tue,  2 Sep 2025 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827644; cv=none; b=alWdfpRYorCloEVPSerZ7wEHDO3pZ4OlGhZkC4yci3Xwx8gsREkZhqKRqzgOko32FoJvvAymCEMtylega7jMAKsCcFOxpTLaHHwx5mbJlTIkXDw5Ih498R7HYIvpLtSJisevgARrfap0JHCM/tdZ45YOyVwc9BxkwZE+RrJM91A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827644; c=relaxed/simple;
	bh=thcPm9Nu2OfSP4B+t2ocI7hpsAYtBfNL2ur+k817e3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQqb20LJBvOO3ZxSTJ9763+fCjCAQl4x16309N0rfnHZRYNzwnA03kYqAfDvXYncKzH9Ya2+Gu9OmV82+pnaBCCmAFSWbYlak6vYH968Y/gCJObkTyHa6mKbJzdrSh8RjdhQ4goocdNXdXUlr5tNXXEXHrlEmBxvWg7YWltZeAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T3p3rQ+s; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T3p3rQ+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756827641; x=1788363641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=thcPm9Nu2OfSP4B+t2ocI7hpsAYtBfNL2ur+k817e3c=;
  b=T3p3rQ+s+/trtC66yFOCDOrnMY1BMrGpvMfq79z6TZ3vkU5gCAyUU+0p
   3enIWOIQDgykIjED3S5+vcwm0DPXOpj0oxiXbMdq9zZJXUSooeVIIIlAc
   38xHt3wv8qkdyElp0AHKLu7v2sY0wz4P5R5MgAlhMZR4nr40UEFxlHjhx
   XqgzWnJR/CmtbsvKhwm6+5g0fptY3wBeHIKPslDQ8+Hril+nR8UTPjjDm
   8DTYp4JcPp3/AvQzfMAENxs0QXv0zkwqzNeCNmeEl/ILfMScy8huh/icf
   OzMFzZz/iQe5T6jMYvrzzV4F2gmuItFvMGIcfzoHfz/Ks/1h1AzdkZ408
   A==;
X-CSE-ConnectionGUID: K8nH0GLNSduDu7fHoML1rQ==
X-CSE-MsgGUID: HmZzNroNRqONRd6ugjl5sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59218995"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59218995"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:40:41 -0700
X-CSE-ConnectionGUID: wsV9edZ2R+6zwB3SzmxGtQ==
X-CSE-MsgGUID: +WDDyXFGQv+KKf3FuJVqew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171277413"
Received: from unknown (HELO [10.247.118.75]) ([10.247.118.75])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:40:36 -0700
Message-ID: <12b3c97a-9463-4c95-8757-e306d4aea14d@intel.com>
Date: Tue, 2 Sep 2025 08:40:30 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/11] cxl: Defer dport allocation for switch ports
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-6-dave.jiang@intel.com>
 <aKXCid-m65ou2WVV@rric.localdomain>
 <b47901d8-1578-41ed-9a89-62f39cd34d5b@intel.com>
 <aLXYBcBJNV-9Lt30@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aLXYBcBJNV-9Lt30@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/1/25 10:29 AM, Robert Richter wrote:
> On 27.08.25 14:15:21, Dave Jiang wrote:
>>
>>
>> On 8/20/25 5:41 AM, Robert Richter wrote:
>>> Hi Dave,
>>>
>>> see my comments below.
>>>
>>> On 14.08.25 15:21:45, Dave Jiang wrote:
>>>> The current implementation enumerates the dports during the cxl_port
>>>> driver probe. Without an endpoint connected, the dport may not be
>>>> active during port probe. This scheme may prevent a valid hardware
>>>> dport id to be retrieved and MMIO registers to be read when an endpoint
>>>> is hot-plugged. Move the dport allocation and setup to behind memdev
>>>> probe so the endpoint is guaranteed to be connected.
>>>>
>>>> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
>>>> switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
>>>> ACPI0017.N device. Through that it enumerates downstream ports composed
>>>> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
>>>> uses add_host_bridge_uport() to create the ports that enumerate the PCI
>>>> RPs as the dports of these ports. Every time a port is created, the port
>>>> driver is attached, cxl_switch_porbe_probe() is called and
>>>> devm_cxl_port_enumerate_dports() is invoked to enumerate and probe
>>>> the dports.
>>>>
>>>> The second phase is if there are any CXL switches. When the pci endpoint
>>>> device driver (cxl_pci) calls probe, it will add a mem device and triggers
>>>> the cxl_mem_probe(). cxl_mem_probe() calls devm_cxl_enumerate_ports()
>>>> and attempts to discovery and create all the ports represent CXL switches.
>>>> During this phase, a port is created per switch and the attached dports
>>>> are also enumerated and probed.
>>>>
>>>> The last phase is creating endpoint port which happens for all endpoint
>>>> devices.
>>>>
>>>> In this commit, the port create and its dport probing in cxl_acpi is not
>>>> changed. That will be handled later. The behavior change is only for CXL
>>>> switch ports. Only the dport that is part of the path for an endpoint
>>>> device to the RP will be probed. This happens naturally by the code
>>>> walking up the device hierarchy and identifying the upstream device and
>>>> the downstream device.
>>>>
>>>> The new sequence is instead of creating all possible dports at initial
>>>> port creation, defer port instantiation until a memdev beneath that
>>>> dport arrives. Introduce devm_cxl_create_or_extend_port() to centralize
>>>> the creation and extension of ports with new dports as memory devices
>>>> arrive. As part of this rework, switch decoder target list is amended
>>>> at runtime as dports show up.
>>>>
>>>> While the decoders are allocated during the port driver probe,
>>>> The decoders must also be updated since previously it's all done when all
>>>> the dports are setup and now every time a dport is setup per endpoint, the
>>>> switch target listing need to be updated with new dport. A
>>>> guard(rwsem_write) is used to update decoder targets. This is similar to
>>>> when decoder_populate_target() is called and the decoder programming
>>>> must be protected.
>>>>
>>>> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
>>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>> ---
>>>> v8:
>>>> - grammar and spelling fixups (Dan)
>>>> - Clarify commit log story. (Dan)
>>>> - Move register mapping and decoder enumeration to when first dport shows up (Dan)
>>>> - Fix kdoc indentation issue with devm_cxl_add_dport_by_dev()
>>>> - cxl_port_update_total_dports() -> cxl_probe_possible_dports(). (Dan)
>>>> - Remove failure path for possible dports == 0. (Dan, Robert)
>>>> - update_switch_decoder() -> update_decoder_targets(). (Dan)
>>>> - Remove lock asserts where not needed. (Dan)
>>>> - Add support for passthrough decoder init. (Dan)
>>>> - Return -ENXIO when no driver attached. (Dan)
>>>> - Move guard() from devm-cxl_add_dport_by_uport. (Dan, Robert)
>>>> - Add devm_cxl_create_or_extend_port() helper. (Dan)
>>>> - Remove shortcut for the port iteration path. Find better way to deal. (Dan, Robert)
>>>> - Remove 'new_dport' local var. (Robert)
>>>> - Use find_cxl_port_by_uport() instead of find_cxl_port(). (Robert)
>>>> - Move port check logic to add_port_attach_ep(). (Robert)
>>>> ---
>>>>  drivers/cxl/core/cdat.c   |   2 +-
>>>>  drivers/cxl/core/core.h   |   2 +
>>>>  drivers/cxl/core/hdm.c    |   6 -
>>>>  drivers/cxl/core/pci.c    |  81 +++++++++++
>>>>  drivers/cxl/core/port.c   | 287 +++++++++++++++++++++++++++++++-------
>>>>  drivers/cxl/core/region.c |   4 +-
>>>>  drivers/cxl/cxl.h         |   3 +
>>>>  drivers/cxl/port.c        |  29 +---
>>>>  8 files changed, 331 insertions(+), 83 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>>>> index c0af645425f4..b156b81a9b20 100644
>>>> --- a/drivers/cxl/core/cdat.c
>>>> +++ b/drivers/cxl/core/cdat.c
>>>> @@ -338,7 +338,7 @@ static int match_cxlrd_hb(struct device *dev, void *data)
>>>>  
>>>>  	guard(rwsem_read)(&cxl_rwsem.region);
>>>>  	for (int i = 0; i < cxlsd->nr_targets; i++) {
>>>> -		if (host_bridge == cxlsd->target[i]->dport_dev)
>>>> +		if (cxlsd->target[i] && host_bridge == cxlsd->target[i]->dport_dev)
>>>>  			return 1;
>>>>  	}
>>>>  
>>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>>> index 2669f251d677..2ac71eb459e6 100644
>>>> --- a/drivers/cxl/core/core.h
>>>> +++ b/drivers/cxl/core/core.h
>>>> @@ -146,6 +146,8 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>>>>  int cxl_ras_init(void);
>>>>  void cxl_ras_exit(void);
>>>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>>>> +struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>>>> +					    struct device *dport_dev);
>>>>  
>>>>  #ifdef CONFIG_CXL_FEATURES
>>>>  struct cxl_feat_entry *
>>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>>> index cee68bbc7ff6..5263e9eba7d0 100644
>>>> --- a/drivers/cxl/core/hdm.c
>>>> +++ b/drivers/cxl/core/hdm.c
>>>> @@ -52,8 +52,6 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld)
>>>>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>>>>  {
>>>>  	struct cxl_switch_decoder *cxlsd;
>>>> -	struct cxl_dport *dport = NULL;
>>>> -	unsigned long index;
>>>>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>>>>  
>>>>  	/*
>>>> @@ -69,10 +67,6 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>>>>  
>>>>  	device_lock_assert(&port->dev);
>>>>  
>>>> -	xa_for_each(&port->dports, index, dport)
>>>> -		break;
>>>> -	cxlsd->cxld.target_map[0] = dport->port_id;
>>>> -
>>>
>>> The change of initialization of cxlsd->cxld.target_map[] could have
>>> been a separate patch to reduce size of this patch.
>>>
>>>>  	return add_hdm_decoder(port, &cxlsd->cxld);
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, "CXL");
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index b50551601c2e..b9d770f1aa7b 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -24,6 +24,44 @@ static unsigned short media_ready_timeout = 60;
>>>>  module_param(media_ready_timeout, ushort, 0644);
>>>>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>>>>  
>>>> +/**
>>>> + * devm_cxl_add_dport_by_dev - allocate a dport by dport device
>>>> + * @port: cxl_port that hosts the dport
>>>> + * @dport_dev: 'struct device' of the dport
>>>> + *
>>>> + * Returns the allocate dport on success or ERR_PTR() of -errno on error
>>>> + */
>>>> +struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>>>
>>> This function only determines the port_num. How about only implement
>>> this in a function cxl_pci_get_port_num() and call devm_cxl_add_dport
>>> directly?
>>
> 
>> I can split out the code to get the port_num locally, but we can't
>> call devm_cxl_add_dport() directly in core/port.c because we need
>> the map.resource and in order to retrieve that cxl_find_regblock()
>> requires a pci dev.
> 
> I mean the following:
> 
> In the mock case, there is always a decoder. That is,
> devm_cxl_add_passthrough_decoder() will only be used for pci devs.
> 
> Create cxl_port_has_multiple_dports() which contains:
> 
>   if (!dev_is_pci(...))
>     return false;
>   /* pci_walk_bus() and inspect dports: */
>   ...
> 
> In cxl_switch_port_setup():
> 
>   rc = devm_cxl_enumerate_decoders(...)
>   if (!rc)
>     return 0;
>   if (cxl_port_has_multiple_dports(...))
>     rc = devm_cxl_add_passthrough_decoder(...);

ok, I can update this part with the function rename. v9 is mostly there with passthrough decoder eliminated in cxl_test.

> 
> You don't need function devm_cxl_add_dport_by_dev() any longer, just
> use devm_cxl_add_dport() instead.

I'm not seeing how the decoder enumeration is related to devm_cxl_add_dport_by_dev(). devm_cxl_add_dport() needs a port_id and a component_reg_phys. Retrieving those require more help from core/pci.c and can't be done in core/port.c.
  
> 
>>>
>>> That would nicely fit into core/pci.c.
>>>
>>>> +					    struct device *dport_dev)
>>>> +{
>>>> +	struct cxl_register_map map;
>>>> +	struct pci_dev *pdev;
>>>> +	u32 lnkcap, port_num;
>>>> +	int type;
>>>> +	int rc;
>>>> +
>>>> +	if (!dev_is_pci(dport_dev))
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	device_lock_assert(&port->dev);
>>>> +
>>>> +	pdev = to_pci_dev(dport_dev);
>>>> +	type = pci_pcie_type(pdev);
>>>> +	if (type != PCI_EXP_TYPE_DOWNSTREAM && type != PCI_EXP_TYPE_ROOT_PORT)
>>>> +		return ERR_PTR(-EINVAL);
>>>> +
>>>> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
>>>> +				  &lnkcap))
>>>> +		return ERR_PTR(-ENXIO);
>>>> +
>>>> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>>>> +	if (rc)
>>>> +		dev_dbg(&port->dev, "failed to find component registers\n");
>>>> +
>>>> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
>>>
>>> So, just return port_num instead.
>>>
>>>> +	return devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
>>>> +}
>>>> +
>>>>  struct cxl_walk_context {
>>>>  	struct pci_bus *bus;
>>>>  	struct cxl_port *port;
>>>> @@ -1169,3 +1207,46 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>>>>  
>>>>  	return 0;
>>>>  }
>>>> +
>>>> +static int count_dports(struct pci_dev *pdev, void *data)
>>>> +{
>>>> +	struct cxl_walk_context *ctx = data;
>>>> +	int type = pci_pcie_type(pdev);
>>>> +
>>>> +	if (pdev->bus != ctx->bus)
>>>> +		return 0;
>>>> +	if (!pci_is_pcie(pdev))
>>>> +		return 0;
>>>> +	if (type != ctx->type)
>>>> +		return 0;
>>>> +
>>>> +	ctx->count++;
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int cxl_port_get_possible_dports(struct cxl_port *port)
>>>> +{
>>>> +	struct pci_bus *bus = cxl_port_to_pci_bus(port);
>>>> +	struct cxl_walk_context ctx;
>>>> +	int type;
>>>> +
>>>> +	if (!bus) {
>>>> +		dev_err(&port->dev, "No PCI bus found for port %s\n",
>>>> +			dev_name(&port->dev));
>>>> +		return -ENXIO;
>>>> +	}
>>>> +
>>>> +	if (pci_is_root_bus(bus))
>>>> +		type = PCI_EXP_TYPE_ROOT_PORT;
>>>> +	else
>>>> +		type = PCI_EXP_TYPE_DOWNSTREAM;
>>>> +
>>>> +	ctx = (struct cxl_walk_context) {
>>>> +		.bus = bus,
>>>> +		.type = type,
>>>> +	};
>>>> +	pci_walk_bus(bus, count_dports, &ctx);
>>>
>>> Don't walk the whole bus, just check children of port->uport_dev.
>>
> 
>> cxl_port_to_pci_bus() gets the pdev->subordinate of the
>> port->uport_dev. So I think that's equivalent of checking the
>> children of port->uport_dev and not actually walking the whole pci
>> bus no?
> 
> pci_walk_bus() also calls subordinates. So it is equivalent, but
> count_dports is called for other devices too that are not children.
> And it is not obvious that only direct children are counted. Use
> device_for_each_child()?
>

ok I can see about switch to that.

 
>>>
>>>> +
>>>> +	return ctx.count;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_possible_dports, "CXL");
>>>
>>> See below for my comment on possible_dports.
>>>
>>> Since we only check for count > 1 the implemntation could be
>>> simplified and renamed to e.g. cxl_port_has_multiple_dports which
>>> could easily be used to call devm_cxl_add_passthrough_decoder().
>>
> 
>> This would be possible if the function can return a bool. However,
>> it is possible to encounter errors. And errors should not be
>> equivalent to a false (0) return value and resulting in a
>> passthrough decoder creation. Thus I think we should stay with the
>> current function name.
> 
> Ok, but see also above.
> 
>>>
>>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>>> index 25209952f469..877f888ee8f5 100644
>>>> --- a/drivers/cxl/core/port.c
>>>> +++ b/drivers/cxl/core/port.c
>>>> @@ -1367,21 +1367,6 @@ static struct cxl_port *find_cxl_port(struct device *dport_dev,
>>>>  	return port;
>>>>  }
>>>>  
>>>> -static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
>>>> -					 struct device *dport_dev,
>>>> -					 struct cxl_dport **dport)
>>>> -{
>>>> -	struct cxl_find_port_ctx ctx = {
>>>> -		.dport_dev = dport_dev,
>>>> -		.parent_port = parent_port,
>>>> -		.dport = dport,
>>>> -	};
>>>> -	struct cxl_port *port;
>>>> -
>>>> -	port = __find_cxl_port(&ctx);
>>>> -	return port;
>>>> -}
>>>> -
>>>>  /*
>>>>   * All users of grandparent() are using it to walk PCIe-like switch port
>>>>   * hierarchy. A PCIe switch is comprised of a bridge device representing the
>>>> @@ -1557,24 +1542,221 @@ static resource_size_t find_component_registers(struct device *dev)
>>>>  	return map.resource;
>>>>  }
>>>>  
>>>> +static int match_port_by_uport(struct device *dev, const void *data)
>>>> +{
>>>> +	const struct device *uport_dev = data;
>>>> +	struct cxl_port *port;
>>>> +
>>>> +	if (!is_cxl_port(dev))
>>>> +		return 0;
>>>> +
>>>> +	port = to_cxl_port(dev);
>>>> +	return uport_dev == port->uport_dev;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Function takes a device reference on the port device. Caller should do a
>>>> + * put_device() when done.
>>>> + */
>>>> +static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
>>>> +{
>>>> +	struct device *dev;
>>>> +
>>>> +	dev = bus_find_device(&cxl_bus_type, NULL, uport_dev, match_port_by_uport);
>>>> +	if (dev)
>>>> +		return to_cxl_port(dev);
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +static int update_decoder_targets(struct device *dev, void *data)
>>>> +{
>>>> +	struct cxl_dport *dport = data;
>>>> +	struct cxl_switch_decoder *cxlsd;
>>>> +	struct cxl_decoder *cxld;
>>>> +	int i;
>>>> +
>>>> +	if (!is_switch_decoder(dev))
>>>> +		return 0;
>>>> +
>>>> +	cxlsd = to_cxl_switch_decoder(dev);
>>>> +	cxld = &cxlsd->cxld;
>>>> +	guard(rwsem_write)(&cxl_rwsem.region);
>>>> +
>>>> +	/* Short cut for passthrough decoder */
>>>> +	if (cxlsd->nr_targets == 1) {
>>>
>>> I think we should still check port_id. That is, remove the shortcut.
>>> If nr_targets == 1, then interleave_ways should be one too, so you
>>> gain nothing. Plus, you also see the dev_dbg().
>>
>> ok
>>
>>>
>>>> +		cxlsd->target[0] = dport;
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < cxld->interleave_ways; i++) {
>>>> +		if (cxld->target_map[i] == dport->port_id) {
>>>> +			cxlsd->target[i] = dport;
>>>> +			dev_dbg(dev, "dport%d found in target list, index %d\n",
>>>> +				dport->port_id, i);
>>>> +			return 0;
>>>
>>> Only one target exists, right? Stop the iteration by returning a
>>> non-zero here (caller needs to be adjusted then).
>>
>> ok
>>
>>>
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int cxl_decoders_dport_update(struct cxl_dport *dport)
>>>> +{
>>>> +	return device_for_each_child(&dport->port->dev, dport,
>>>> +				     update_decoder_targets);
>>>
>>> Might need changes if update_decoder_targets returns 1 to stop the
>>> iterator.
>>
>> ok
>>
>>>
>>>> +}
>>>> +
>>>> +static int cxl_switch_port_setup(struct cxl_port *port)
>>>> +{
>>>
>>> Could you factor out that function in a separate patch?
>>>
>>> The function only sets up decoders. Name it
>>> cxl_switch_port_setup_decoders()?
>>>
>>>> +	struct cxl_hdm *cxlhdm;
>>>> +
>>>> +	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>>>> +	if (!IS_ERR(cxlhdm))
>>>> +		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>>>> +
>>>> +	if (PTR_ERR(cxlhdm) != -ENODEV) {
>>>> +		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
>>>> +		return PTR_ERR(cxlhdm);
>>>> +	}
>>>> +
>>>> +	if (port->possible_dports == 1) {
>>>> +		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
>>>> +		return devm_cxl_add_passthrough_decoder(port);
>>>
>>> Imo, the possible_dports handling should be removed as it only
>>> introduces dead code. mock_cxl_setup_hdm() always returns a valid
>>> cxlhdm (unless for -ENOMEM) and the mock case never reaches this code
>>> here.
>>>
>>> So how about moving (the "real") devm_cxl_add_passthrough_decoder()
>>> and cxl_port_get_possible_dports() to devm_cxl_enumerate_decoders()?
>>> devm_cxl_add_passthrough_decoder() would be static then and
>>> cxl_port_get_possible_dports() will be a core.h function only. Then,
>>> mock_cxl_add_passthrough_decoder() could be removed too.
>>>
>>> I really would like to have a clean core module interface that allows
>>> an easy implementation of cxl_test and avoid too much impact to the
>>> driver code.
>>
>> So after looking at this a bit, it looks like we need a bigger refactor than just devm_cxl_enumerate_decoders(). I have an attempt in the next rev you can take a look. It reduces from 3-4 mock functions down to 2. 
>>  
>>>
>>>> +	}
>>>> +
>>>> +	dev_err(&port->dev, "HDM decoder capability not found\n");
>>>> +	return -ENXIO;
>>>> +}
>>>> +
>>>> +DEFINE_FREE(put_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) reap_dport(_T))
>>>> +static struct cxl_dport *cxl_port_get_or_add_dport(struct cxl_port *port,
>>>> +						   struct device *dport_dev)
>>>> +{
>>>> +	struct cxl_dport *dport;
>>>> +	int rc;
>>>> +
>>>> +	guard(device)(&port->dev);
>>>> +
>>>> +	if (!port->dev.driver)
>>>> +		return ERR_PTR(-ENXIO);
>>>> +
>>>> +	dport = cxl_find_dport_by_dev(port, dport_dev);
>>>> +	if (dport)
>>>> +		return dport;
>>>
>>> What is the case if there is already a dport bound to the port? Since
>>> there is a 1:1 mapping downstream, there is only one allocation and I
>>> would expect that dport never exists and an -EBUSY should be returned
>>> otherwise.
>>
>> ok
>>
>>>
>>>> +
>>>> +	struct cxl_dport *new_dport __free(put_cxl_dport) =
>>>> +		devm_cxl_add_dport_by_dev(port, dport_dev);
>>>
>>> See my comment on devm_cxl_add_dport_by_dev() above.
>>>
>>>> +	if (IS_ERR(new_dport))
>>>> +		return new_dport;
>>>> +
>>>> +	cxl_switch_parse_cdat(port);
>>>> +
>>>> +	/*
>>>> +	 * First instance of dport appearing, need to setup the port, including
>>>> +	 * allocating decoders.
>>>> +	 */
>>>> +	if (port->nr_dports == 1) {
>>>> +		rc = cxl_switch_port_setup(port);
>>>
>>> Can't this be done with port creation? I don't see a reason doing this
>>> late at this point.
>>>
>>>> +		if (rc)
>>>> +			return ERR_PTR(rc);
>>>> +		return no_free_ptr(new_dport);
>>>> +	}
>>>> +
>>>> +	rc = cxl_decoders_dport_update(new_dport);
>>>> +	if (rc)
>>>> +		return ERR_PTR(rc);
>>>
>>> Maybe unfold cxl_decoders_dport_update() here?
>>
>> ok
>>
>>>
>>>> +
>>>> +	return no_free_ptr(new_dport);
>>>> +}
>>>> +
>>>> +static struct cxl_dport *devm_cxl_add_dport_by_uport(struct device *uport_dev,
>>>> +						     struct device *dport_dev)
>>>> +{
>>>> +	struct cxl_port *port __free(put_cxl_port) =
>>>> +		find_cxl_port_by_uport(uport_dev);
>>>> +
>>>> +	if (!port)
>>>> +		return ERR_PTR(-ENODEV);
>>>> +
>>>> +	return cxl_port_get_or_add_dport(port, dport_dev);
>>>> +}
>>>
>>> That function can be removed, see below.
>>
>> ok
>>
>>>
>>>> +
>>>> +static struct cxl_dport *
>>>> +devm_cxl_create_or_extend_port(struct device *ep_dev,
>>>> +			       struct cxl_port *parent_port,
>>>> +			       struct cxl_dport *parent_dport,
>>>> +			       struct device *uport_dev,
>>>> +			       struct device *dport_dev)
>>>> +{
>>>> +	resource_size_t component_reg_phys;
>>>> +
>>>> +	guard(device)(&parent_port->dev);
>>>> +
>>>> +	if (!parent_port->dev.driver) {
>>>> +		dev_warn(ep_dev,
>>>> +			 "port %s:%s disabled, failed to enumerate CXL.mem\n",
>>>> +			 dev_name(&parent_port->dev), dev_name(uport_dev));
>>>> +		return ERR_PTR(-ENXIO);
>>>> +	}
>>>> +
>>>> +	struct cxl_port *port __free(put_cxl_port) =
>>>> +		find_cxl_port_by_uport(uport_dev);
>>>> +
>>>> +	if (!port) {
>>>> +		component_reg_phys = find_component_registers(uport_dev);
>>>> +		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>>>> +					 component_reg_phys, parent_dport);
>>>> +		if (IS_ERR(port))
>>>> +			return (struct cxl_dport *)port;
>>>> +
>>>> +		/*
>>>> +		 * retry to make sure a port is found. a port device
>>>> +		 * reference is taken.
>>>> +		 */
>>>> +		port = find_cxl_port_by_uport(uport_dev);
>>>> +		if (!port)
>>>> +			return ERR_PTR(-ENODEV);
>>>> +
>>>> +		dev_dbg(ep_dev, "created port %s:%s\n",
>>>> +			dev_name(&port->dev), dev_name(port->uport_dev));
>>>> +	}
>>>> +
>>>> +	return cxl_port_get_or_add_dport(port, dport_dev);
>>>> +}
>>>> +
>>>>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>>>  			      struct device *uport_dev,
>>>>  			      struct device *dport_dev)
>>>>  {
>>>>  	struct device *dparent = grandparent(dport_dev);
>>>>  	struct cxl_dport *dport, *parent_dport;
>>>> -	resource_size_t component_reg_phys;
>>>>  	int rc;
>>>>  
>>>>  	if (is_cxl_host_bridge(dparent)) {
>>>> +		struct cxl_port *port __free(put_cxl_port) =
>>>> +			find_cxl_port_by_uport(uport_dev);
>>>>  		/*
>>>>  		 * The iteration reached the topology root without finding the
>>>>  		 * CXL-root 'cxl_port' on a previous iteration, fail for now to
>>>>  		 * be re-probed after platform driver attaches.
>>>>  		 */
>>>> -		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>>> -			dev_name(dport_dev));
>>>> -		return -ENXIO;
>>>> +		if (!port) {
>>>> +			dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>>> +				dev_name(dport_dev));
>>>> +			return -ENXIO;
>>>> +		}
>>>> +
>>>> +		/*
>>>> +		 * While the port is found, there may not be a dport associated
>>>> +		 * yet. Try to associate the dport to the port. On return success,
>>>> +		 * the iteration will restart with the dport now attached.
>>>> +		 */
>>>> +		dport = devm_cxl_add_dport_by_uport(uport_dev,
>>>> +						    dport_dev);
>>>
>>> port is known here, use cxl_port_get_or_add_dport(port, dport_dev)
>>> instead. Remove devm_cxl_add_dport_by_uport().
>>
>> ok
>>
>>>
>>>> +		if (IS_ERR(dport))
>>>> +			return PTR_ERR(dport);
>>>> +
>>>> +		return 0;
>>>>  	}
>>>>  
>>>>  	struct cxl_port *parent_port __free(put_cxl_port) =
>>>> @@ -1584,36 +1766,12 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>>>>  		return -EAGAIN;
>>>>  	}
>>>>  
>>>> -	/*
>>>> -	 * Definition with __free() here to keep the sequence of
>>>> -	 * dereferencing the device of the port before the parent_port releasing.
>>>> -	 */
>>>> -	struct cxl_port *port __free(put_cxl_port) = NULL;
>>>> -	scoped_guard(device, &parent_port->dev) {
>>>> -		if (!parent_port->dev.driver) {
>>>> -			dev_warn(&cxlmd->dev,
>>>> -				 "port %s:%s disabled, failed to enumerate CXL.mem\n",
>>>> -				 dev_name(&parent_port->dev), dev_name(uport_dev));
>>>> -			return -ENXIO;
>>>> -		}
>>>> +	dport = devm_cxl_create_or_extend_port(&cxlmd->dev, parent_port,
>>>> +					       parent_dport, uport_dev,
>>>> +					       dport_dev);
>>>
>>> You expand add_port_attach_ep() here. This function was originally
>>> called if there is no *port* at all. Now, as the dport_dev is not yet
>>> registered, the port may already exist, but it is not found since the
>>> dport_dev is not yet registered and add_port_attach_ep() is called now
>>> even if the port exists. I think we should move that dport_dev
>>> registration a level higher to devm_cxl_enumerate_ports(). That might
>>> need a cleanup of the iterator and the removal of
>>> add_port_attach_ep().
>>
>> Yes. The new rev will move the dport registration a level up. No need to remove add_port_attach_ep(). devm_cxl_create_or_extend_port() will be devm_cxl_create_port().
>>
>>>
>>>> +	if (IS_ERR(dport))
>>>> +		return PTR_ERR(dport);
>>>>  
>>>> -		port = find_cxl_port_at(parent_port, dport_dev, &dport);
>>>> -		if (!port) {
>>>> -			component_reg_phys = find_component_registers(uport_dev);
>>>> -			port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>>>> -						 component_reg_phys, parent_dport);
>>>> -			if (IS_ERR(port))
>>>> -				return PTR_ERR(port);
>>>> -
>>>> -			/* retry find to pick up the new dport information */
>>>> -			port = find_cxl_port_at(parent_port, dport_dev, &dport);
>>>> -			if (!port)
>>>> -				return -ENXIO;
>>>> -		}
>>>> -	}
>>>> -
>>>> -	dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
>>>> -		dev_name(&port->dev), dev_name(port->uport_dev));
>>>>  	rc = cxl_add_ep(dport, &cxlmd->dev);
>>>>  	if (rc == -EBUSY) {
>>>>  		/*
>>>> @@ -1630,6 +1788,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>>>  {
>>>>  	struct device *dev = &cxlmd->dev;
>>>>  	struct device *iter;
>>>> +	int ports_need_create = 0;
>>>>  	int rc;
>>>>  
>>>>  	/*
>>>> @@ -1654,6 +1813,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>>>  		struct device *uport_dev;
>>>>  		struct cxl_dport *dport;
>>>>  
>>>> +		ports_need_create++;
>>>> +
>>>>  		if (is_cxl_host_bridge(dport_dev))
>>>>  			return 0;
>>>>  
>>>> @@ -1688,10 +1849,28 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>>>  
>>>>  			cxl_gpf_port_setup(dport);
>>>>  
>>>> +			ports_need_create--;
>>>>  			/* Any more ports to add between this one and the root? */
>>>>  			if (!dev_is_cxl_root_child(&port->dev))
>>>>  				continue;
>>>>  
>>>> +			/*
>>>> +			 * The 'ports_need_create' variable tracks a port being
>>>> +			 * created as it goes through this iterative loop. It's
>>>> +			 * incremented when it first enters the loop and decremented
>>>> +			 * when the port is found. If at the root of the hierarchy
>>>> +			 * and the variable is not 0, then it's missing a port
>>>> +			 * creation somewhere in the hierarchy and should restart.
>>>> +			 * For example in a setup where there's a PCI root port, a
>>>> +			 * switch, and an endpoint, it is possible to get to the
>>>> +			 * PCI root port and its creation, and the switch port is
>>>> +			 * still missing because the root port didn't exist. This
>>>> +			 * triggers a restart of the loop to create the switch port
>>>> +			 * now with a present root port.
>>>> +			 */
>>>> +			if (ports_need_create)
>>>
>>> Uh, that becomes hard. Isn't the iterator much simpler:
>>>
>>>  * Start the iter = endpoint.
>>>
>>>  * Find first existing parent port up to the root.
>>>
>>>  * If that is the direct parent of the endpoint, attach it to the
>>>    parent (add dport etc.). Exit loop without errors.
>>>
>>>  * Else, create port and attach it to the found parent port (including
>>>    dport handling).
>>>
>>>  * Fail on errors or retry otherwise.
>>>
>>> So, devm_cxl_enumerate_ports() should be reworked better, also address
>>> my other comments regarding add_port_attach_ep() and
>>> devm_cxl_create_or_extend_port().
>>
>> So I reworked this whole path a bit. Maybe not exactly what you are envisioning here but it is a lot cleaner. You can take a look at the next rev.
>>
>>>
>>>> +				goto retry;
>>>> +
>>>>  			return 0;
>>>>  		}
>>>>  
>>>> @@ -1700,8 +1879,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>>>  		if (rc == -EAGAIN)
>>>>  			continue;
>>>>  		/* failed to add ep or port */
>>>> -		if (rc)
>>>> +		if (rc < 0)
>>>>  			return rc;
>>>> +
>>>> +		ports_need_create = 0;
>>>>  		/* port added, new descendants possible, start over */
>>>>  		goto retry;
>>>>  	}
>>>> @@ -1733,14 +1914,16 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>>>>  	device_lock_assert(&port->dev);
>>>>  
>>>>  	if (xa_empty(&port->dports))
>>>> -		return -EINVAL;
>>>> +		return 0;
>>>>  
>>>>  	guard(rwsem_write)(&cxl_rwsem.region);
>>>>  	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
>>>>  		struct cxl_dport *dport = find_dport(port, cxld->target_map[i]);
>>>>  
>>>> -		if (!dport)
>>>> -			return -ENXIO;
>>>> +		if (!dport) {
>>>> +			/* dport may be activated later */
>>>> +			continue;
>>>> +		}
>>>>  		cxlsd->target[i] = dport;
>>>>  	}
>>>
>>> Should that be dropped entirely as the target setup is done somewhere
>>> else?
>>>
>> No. This is still needed for root ports.
> 
> Root ports are dport_devs and don't have a target list, host bridges
> have. I did not follow the entire code flow, but shouldn't
> cxl_decoders_dport_update() handle that?

Sorry I see where I mislead you. I should have said cxl_root(s) and not the root ports under the host bridge. __cxl_parse_cfmws() calls cxl_decoder_add() for the root decoder and that's where decoder_populate_targets() needs to populate the targets and cxl_decoders_dport_update() does not hit the root decoder. 

DJ


