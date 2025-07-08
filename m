Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE0017C21E
	for <linux-cxl@vger.kernel.org>; Tue,  8 Jul 2025 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011229; cv=none; b=NyYwzX5vGvQPWXQaMlIfNUcjww4A49fAeuLt7bNsK/VcUfXPwPQMOxYlYRkLGAxkWGsbrQyqic8V02Tlatjo6q6OhUY4dYBUOXb8pXzg6FWuQwNo3U4bJ71i2839pshbxfcHovbFB/2Ko+wcUh0mtsSBqqFe7bmfGXhDawRRzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011229; c=relaxed/simple;
	bh=dMofc4/cIvXNZV6tLM4P+SOZJSZMdLyJ/Wv6SHgMUGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdvpPMGDcrNB80Eet4DO156EQMCRGyijCi7qRPc8sSobo0BNNbdHHHcWqnIakSr1fE+a7bWqnsXtaXOTgnRJbrkmOnwb1ZQvnZE3/pur72DKrInRrjZdzfben/9+ccZybuLgc31kGpDJFNHzgqvvn1XijRBaMKOC0FXX5GgQeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMIdG5r/; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMIdG5r/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752011228; x=1783547228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dMofc4/cIvXNZV6tLM4P+SOZJSZMdLyJ/Wv6SHgMUGw=;
  b=YMIdG5r/xEKjauAD4Le9Wcj3AHKUPB5VS5E6y966PEe/nf0hTK9gjswy
   wLPPQEnoZijn31K1tJkV98L1IG0YTYQkBLk8FIRLV/x833R93WELC/jGg
   7hGU+JpMDD4Sl7d5H2Im/OXdIfJeFxMzQ8RSSYpk+lj+N4nl7/87OfwKB
   7W6k0Dio7oReia5mbCQMKvZ/z3jmQUJElk4nPGx9TvFQFQNhovspoGiQp
   bUz7CWPaJsH74mtiw87D9hf52FxgsSpfrcnyqTTwPth6Bgu6OdLUpf3Lk
   wlNs19tuYfrQC3f0cLAAMetOM2xR4nbvKEC1aA9lOt4vDCzQq+YPCBySk
   g==;
X-CSE-ConnectionGUID: /5io2DNUQHGrTUTARHIeaQ==
X-CSE-MsgGUID: wpFlUTJZSCaizps1lGntnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54357077"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54357077"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 14:47:07 -0700
X-CSE-ConnectionGUID: l91DBM3VRz2+/vIObqfTvA==
X-CSE-MsgGUID: wEHsmKBzSqqwjTtYz4pgOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155929077"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.152]) ([10.125.110.152])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 14:47:06 -0700
Message-ID: <a54c83fc-a0d2-449d-903c-2cc42e07d8b6@intel.com>
Date: Tue, 8 Jul 2025 14:47:05 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] cxl: Defer dport allocation for switch ports
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250703232710.3141436-1-dave.jiang@intel.com>
 <20250703232710.3141436-5-dave.jiang@intel.com>
 <32e809fe-ff98-4b27-96e3-119b8e83414f@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <32e809fe-ff98-4b27-96e3-119b8e83414f@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/7/25 11:21 PM, Li Ming wrote:
> On 7/4/2025 7:27 AM, Dave Jiang wrote:
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
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v5:
>> - Change cxl_port_get_total_dports() to cxl_port_update_total_dports(). (Jonathan)
>> - Return dport for the devm_cxl_port_add_dport() and friends. (Jonathan)
>> ---
>>  drivers/cxl/core/core.h |   2 +
>>  drivers/cxl/core/pci.c  |  88 +++++++++++++++++++
>>  drivers/cxl/core/port.c | 184 ++++++++++++++++++++++++++++++++++++++--
>>  drivers/cxl/cxl.h       |   5 ++
>>  drivers/cxl/port.c      |   8 +-
>>  5 files changed, 273 insertions(+), 14 deletions(-)
>>
> [snip]
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
>> @@ -1643,7 +1787,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  	 * attempt fails.
>>  	 */
>>  retry:
>> -	for (iter = dev; iter; iter = grandparent(iter)) {
>> +	for (i = 0, iter = dev; iter; i++, iter = grandparent(iter)) {
>>  		struct device *dport_dev = grandparent(iter);
>>  		struct device *uport_dev;
>>  		struct cxl_dport *dport;
>> @@ -1686,9 +1830,28 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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
> should be "if (!pport)" here?

Yes. Great catch!

>> +			}
>> +
>>  			return 0;
>>  		}
>>  
>> +		dport = devm_cxl_add_dport_for_rp(uport_dev, dport_dev);
>> +		/* Added a dport, restart enumeration */
>> +		if (!IS_ERR_OR_NULL(dport))
>> +			goto retry;
>> +		if (IS_ERR(dport))
>> +			return PTR_ERR(dport);
>> +
> 
> This part is a little bit complicated. My understanding is that devm_cxl_add_dport_for_rp() is invoked only for uport_dev == cxl host bridge case, and below add_port_attach_ep() is invoked only for uport_dev == cxl switch USP case, is it?
> 
> If yes, maybe it is better to use a if {} else {} block here? like
> 
> if (uport_dev is host bridge) {
> 
>     devm_cxl_add_dport_for_rp();
> 
> } else {
> 
>     add_switch_port_attach_ep();
> 
> }

Yes I'll change to that. I can also drop devm_cxl_add_dport_for_rp() and directly call devm_cxl_add_dport_by_uport().

DJ

> 
> 
> Ming
> 
> [snip]
> 

