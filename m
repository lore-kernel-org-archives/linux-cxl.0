Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA7E33471B
	for <linux-cxl@vger.kernel.org>; Tue,  2 Sep 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828709; cv=none; b=tlZwn2Is8/w/82ceMpW679M2RgfO3iFR9EvrOcBwPmKGMP2a49EpeYnd0UgH4Xmyb+ePROW8+26AgbYea+EFcASyi7C4KdUmzyASYbP7WuDilZNb18+29PlQZp8sVUZx7oJqsQordSNipBu8iNDdMxq1IhyItSOKRid+EG3eaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828709; c=relaxed/simple;
	bh=jIcUtU/A71d19V63mVdv1riSpAql1LsOoIduONrvFe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKz7KtLeqwnW0+yOjhQmifxUy3/BjEO+ljELlUpQBBoV+MoZ/eO2AXRk51TRVSdx4a1LSBtLb6HSiMswphndDkKN8JO0+ogBhlLU0QVGUqA8x9Fyb87SHKPMCTsfmaqs4r0w64x/N80wWTagBTYJV+vcNhFmCLXAk5+sXDvlqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYU/f3Pv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYU/f3Pv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756828708; x=1788364708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jIcUtU/A71d19V63mVdv1riSpAql1LsOoIduONrvFe0=;
  b=WYU/f3PvyRj/niMRFiiz0nK2NrTxunWLdWwsSeA/v2vbZL+ik2rkDiqT
   fZOjrBhM8qBo1IYHDvqtYNkxIlcTDfO0d+eo5jx5oT3Ir8iheYVpGTxef
   5qFeGVCQXcFhK/DyUYmx8r2UY9TNudeI351UAnuoKax/VQvWYxsFOCYOE
   qNSBu9JsP2No+Js2lfiYZovHre4HyymnuzBL2IfvNjmc/JpW9YHoj+IUL
   iiYqr1aWeZ+miC0PfdTvbdn+mD877HNGABiYsmvHkUJL19Uc7X7pHvHnv
   p2Lt10/y/TbB+6fJRgrbSKJo0VbKM+63EJ1UGgMk5SJwZEKPrv5uV1Pev
   A==;
X-CSE-ConnectionGUID: GDXUhry8TPm40YspSbtZ8A==
X-CSE-MsgGUID: J/iuimvMRTiyjFXQ1CKYEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58316802"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="58316802"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:58:27 -0700
X-CSE-ConnectionGUID: 5f7NetxeQDS2wU4CFTrgPw==
X-CSE-MsgGUID: 8GMPieGGT/qVjo1JitcJ1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170568947"
Received: from unknown (HELO [10.247.118.75]) ([10.247.118.75])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:58:22 -0700
Message-ID: <dc95c3b0-14a5-45b4-805b-4006a61e405f@intel.com>
Date: Tue, 2 Sep 2025 08:58:17 -0700
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
 <a5eeaa15-9ef7-4b9a-88dc-10de9f1cb551@intel.com>
 <aKg_gBw1Q29BaXdp@rric.localdomain>
 <0d4c1766-d966-43bd-abec-b1a8a4592a1b@intel.com>
 <aK1niOntTRwwZhhv@rric.localdomain>
 <780adfd8-7d3d-4acd-a34b-0e88abb40041@intel.com>
 <aLHBG5j8rVYhi9cg@rric.localdomain>
 <2f52ad40-7e85-4466-8d42-190c846fd37c@intel.com>
 <aLWyIlyMgZUzO5Oa@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aLWyIlyMgZUzO5Oa@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/1/25 7:48 AM, Robert Richter wrote:
> On 29.08.25 10:23:38, Dave Jiang wrote:
>>
>>
>> On 8/29/25 8:02 AM, Robert Richter wrote:
>>> On 27.08.25 10:05:05, Dave Jiang wrote:
>>>>
>>>>
>>>> On 8/26/25 12:51 AM, Robert Richter wrote:
>>>>> On 22.08.25 08:52:39, Dave Jiang wrote:
>>>>>>
>>>>>>
>>>>>> On 8/22/25 2:59 AM, Robert Richter wrote:
>>>>>>> On 20.08.25 08:20:04, Dave Jiang wrote:
>>>>>>>> On 8/20/25 5:41 AM, Robert Richter wrote:
>>>>>>>>> Hi Dave,
>>>>>>>>>
>>>>>>>>> see my comments below.
>>>>>>>>>
>>>>>>>>> On 14.08.25 15:21:45, Dave Jiang wrote:
>>>>>>>>
>>>>>>>> <--snip-->
>>>>>>>>  
>>>>>>>>>> +	if (IS_ERR(new_dport))
>>>>>>>>>> +		return new_dport;
>>>>>>>>>> +
>>>>>>>>>> +	cxl_switch_parse_cdat(port);
>>>>>>>>>> +
>>>>>>>>>> +	/*
>>>>>>>>>> +	 * First instance of dport appearing, need to setup the port, including
>>>>>>>>>> +	 * allocating decoders.
>>>>>>>>>> +	 */
>>>>>>>>>> +	if (port->nr_dports == 1) {
>>>>>>>>>> +		rc = cxl_switch_port_setup(port);
> 
> I want to come back to my previous comment that port setup should be
> done as part of the port enumeration in devm_cxl_enumerate_ports().
> No need to make this a special case here. The link should be up
> already once the mem dev is visible.

IFF the port enumeration is done via devm_cxl_enumerate_ports() and through endpoint bring up. But we also do port enumeration during cxl_acpi probe and thus is the issue. cxl_switch_port_probe() also happens at that time when cxl_acpi_probe() add ports. And the link may not be up at that time. Anyhow, this is what it looks like in v9:

	if (ida_is_empty(&port->decoder_ida)) {
		rc = devm_cxl_switch_port_decoders_setup(port);
		if (rc)
			return ERR_PTR(rc);
		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
			new_dport->port_id, dev_name(dport_dev));
		return no_free_ptr(new_dport);
	}


> 
>>>>>>>>>
>>>>>>>>> Can't this be done with port creation? I don't see a reason doing this
>>>>>>>>> late at this point.
>>>>>>>>
>>>>>>>
>>>>>>>> The main reason we are doing this is to move the port register
>>>>>>>> probing until we know the CXL link is established. Otherwise when
>>>>>>>> cxl_acpi does probe and calls add_host_bridge_uport(), that
>>>>>>>> devm_cxl_add_port() can trigger errors if the platform BIOS enables
>>>>>>>> PCI hotplug support on Intel platforms. The error messages "cxl
>>>>>>>> portN: Couldn't locate the CXL.cache and CXL.mem capability array
>>>>>>>> header" is observed. Essentially we can be trying to map registers
>>>>>>>> while DVSEC ID 3 and/or 7 has not appeared yet. And in turn because
>>>>>>>> that got pushed out, so did the decoder enumeration.
>>>>>>>
>>>>>>> The code suggests the Component Registers of the CXL Host Bridge are
>>>>>>> not yet ready. Is this delayed after the first Root Port is connected
>>>>>>> to a CXL Endpoint/Switch? PCIe DVSEC ID 3 and 7
>>>>>>> (CXL_DVSEC_PORT_EXTENSIONS, CXL_DVSEC_PCIE_FLEXBUS_PORT) are part of
>>>>>>> the pcie config space, which is enumerated not before a CXL endpoint
>>>>>>> becomes active. I haven't found a spec refs here. Please explain.
>>>>>>
>>>>>
>>>>>> So the behavior is observed when PCIe hotplug support is turned on
>>>>>> in BIOS for the Intel platform. A CXL device is plugged in to a RP
>>>>>> without CXL switches. The thinking is that the CXL link is not fully
>>>>>> established at the time when cxl_acpi_probe() is running and the
>>>>>> ports are being added. And the only way to 100% be sure the link is
>>>>>> established is when we are enumerating the memdev just like the
>>>>>> dports. Not sure what spec ref are you looking for. Table 8-2
>>>>>> indicates that those 2 DVSECs are mandatory for CXL root ports. Lack
>>>>>> of presence means either the RP isn't CXL or the CXL link isn't
>>>>>> established yet. I would assume this would also be true if a CXL
>>>>>> memdev is hot-plugged into a slot post boot.
>>>>>
>>>>> But add_host_bridge_uport() only creates ports for the host bridge
>>>>> (ACPI0016) devices and enumerates their component registers (CHBCR).
>>>>
>>>> And I think that's where the issue is. The component registers via CHBCR isn't there. When I removed this change, this is the signature I get:
>>>>
>>>> [ 37.423882] cxl_acpi:cxl_get_chbs:589: acpi ACPI0016:03: UID found: 35  
>>>> [ 37.424180] cxl_acpi:add_host_bridge_uport:726: acpi ACPI0016:03: CHBCR found for UID 35: 0x00000  
>>>> 000aabf0000  
>>>> [ 37.424186] cxl_core:cxl_port_alloc:741: pci0000:3a: host-bridge: pci0000:3a  
>>>> [ 37.424210] cxl_core:cxl_map_regblock:426: cxl port2: Mapped CXL Memory Device resource 0x0000000  
>>>> 0aabf0000  
>>>> [ 37.424213] cxl_core:cxl_probe_component_regs:55: cxl port2: Couldn't locate the CXL.cache and CXL.mem capability array header.
>>>
>>> Hmm, hot-added Host Bridges (and I would count this case to those)
>>> should use the ACPI _CBR method. That is, else the host bridge should
>>> be enumerated during boot.
>>
>> host bridges are there, just not the component registers in the CHBCR it appears.
>>
>>>
>>> Is it just a delay, or does the CHBCR come up not earlier than the
>>> root port link is up?
>>
>> Let me get that clarification from the BIOS people.
>>
>>>
>>> Can -EAGAIN be used to reload the driver later if CHBCR init fails?
>>> IMO, the Component Registers cannot be initialized later as that would
>>> delay the enablement of the root decoders too. At least only bridges
>>> that fail to init the CHBCR should be delayed.
>>
> 
>> I don't follow why this is an issue. Auto region assembly doesn't
>> start until the port hierarchy is established via the first
>> endpoint. So by the time the region code pokes at the decoder
>> registers during region assembly, the component register for CHBCR
>> should have been probed. It seems reasonable to setup the component
>> registers when we find the first dport and thus indicate that
>> everything should be there. Are you observing an issue on a
>> platform?
> 
> It would be good to see the bridges in the system regardless of the
> link status of the root ports, which I think is possible. Same with
> the chbcr and the hb decoders. Only defer it if not yet available and,
> let's mark it as a quirk or workaround. Btw, this is not a delayed
> dport enablement any longer.

ok. I can take out the delayed register probing patch while we discuss this. No reason to hold up the rest of the series.

> 
> I am also a bit worried about the conditions to run the setup. What if
> there are multiple hotplug ports, why should the CHBCR be ready with
> the first one already? Shouldn't all connected ports come up first?

I see what you are saying. Let me get the exact behavior from the BIOS guys first. 

> 
>>>
>>> The issue and the changes for this are not obvious, please make a
>>> separate patch for that separate change.
>>
>> It was in this [1] patch.
>>
>> https://lore.kernel.org/linux-cxl/20250814222151.3520500-5-dave.jiang@intel.com/
>>
>> I think the name of the function being discussed confused things. It is now renamed to setup decoders instead of just setup.
> 
> Yes, but there is this additional change that calls
> cxl_switch_port_setup() in this patch.
> 
> -Robert
> 
>>
>> DJ
>>
>>>
>>> Thanks,
>>>
>>> -Robert

