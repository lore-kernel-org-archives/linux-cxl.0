Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5452192EB
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747346589; cv=none; b=hEtC+Nwk3xFzKU/WSZsuosEBlMOtkwt4RXJAZ1wNUqSu0dIuhNkZTcO3Se2nYq12l/xodkBYkXGjV2ctdBgq5VPjwFOxIwS7EF6MLyaUFWlLdpoanXssPXa4elhaG8iH+QT93+eSi9LD0dAmL/CtJdMBtzxK61uuIFPLupOYAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747346589; c=relaxed/simple;
	bh=MbiTkgKYoLeNh/RO2vu2WRk+hUusNMsbp1FGjD2kciY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNzUpImroP3LLqC4F6a086Fd476/VkWZ3QywaXEzZmLPzbhsOBC0Jzjv38qmvJHsY9dmZxr7lPPMGkfeCxnSVy6XB4E2NJskjiC2b7QrfyriHQO262KZCmNQ2d/7XLkmR8jSK29L4QvAxPgG0Eo6fXDQGtOS7uuAsJ3lbskl8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtgIxyr/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtgIxyr/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747346588; x=1778882588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MbiTkgKYoLeNh/RO2vu2WRk+hUusNMsbp1FGjD2kciY=;
  b=DtgIxyr/3I9rpq3NXePZy49GJ3N0T+6LbWjDWHV5cI7A67rHJlcUO8St
   3K4vJU/tsbe9Z23umVEdeS6+v5r0svf7K+yStylKtTTZmoMVh1zdvxtRV
   Qwmi+RdUV8O2wtyR0luuuQT04+hGrwcR+KCnc4+kPpTPpKwP9ARR1+6+i
   wLopBq/PahNVW7458e9+fOdNkna23ciyxBTqIUhkIohdfDYLq185Ua8j7
   JJ3BIX/NcdGDHKx7/fVKOEiSCR1Pskfeaw+i0UHNKUsWAoX6ChcM1LGLe
   3VkGgFgrV2sBm78gXD1WtzEwrsCIePit9orGvoiC7aTjFYbvOW0VudBRM
   A==;
X-CSE-ConnectionGUID: UvWfLXrlQiSG90M/zFhJZQ==
X-CSE-MsgGUID: bJh4gc2iT2iBJoF/vT0hYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49464072"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="49464072"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 15:03:07 -0700
X-CSE-ConnectionGUID: EweDo9CdT9GcAS/kdGn+TQ==
X-CSE-MsgGUID: cWYfe94gQZq6f6K0lIG+8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="143385564"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.47]) ([10.125.109.47])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 15:03:06 -0700
Message-ID: <4ab4a497-e1e2-4e64-90dd-08c489cc52a7@intel.com>
Date: Thu, 15 May 2025 15:03:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] cxl: Defer hardware dport->port_id assignment
 and registers probing
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-6-dave.jiang@intel.com>
 <aCNopruv5rUV2PBr@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aCNopruv5rUV2PBr@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/25 8:43 AM, Gregory Price wrote:
> On Tue, May 06, 2025 at 05:43:05PM -0700, Dave Jiang wrote:
>> Current implementation only enumerates the dports during the port probe.
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
>> The decoders must also be updated since previously it's all done when all
>> the dports are setup and now every time a dport is setup per endpoint, the
>> switch target listing need to be updated with new dport.
>>
> 
> I'm finding the changes a little difficult to follow, can you lay out
> the expected order of operations before and after?
> 
> Specifically there's two new guard() calls, can you explain under what
> conditions those can be contended?

I'll add more to the commit log and explain.
> 
> ~Gregory
> 
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 70173d23139c..04e18a102d26 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
> ... snip ...
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
>> +		if (cxlsd->target_map[i] == dport->port_num) {
>> +			cxlsd->target[i] = dport;
>> +			return 0;
>> +		}
>> +	}
> ... snip ...
>> @@ -1695,6 +1798,19 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>>  				"found already registered port %s:%s\n",
>>  				dev_name(&port->dev),
>>  				dev_name(port->uport_dev));
>> +
>> +			/*
>> +			 * Attempt to do single pass dport setup by checking here
>> +			 * instead of doing it during port creation. Otherwise
>> +			 * it still needs to check here for dports that are
>> +			 * being probed with a port already created.
>> +			 */
>> +			scoped_guard(device, &port->dev) {
>> +				rc = cxl_switch_port_dport_setup(port, dport_dev);
>> +				if (rc)
>> +					return rc;
>> +			}
>> +
> ... snip ...
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index a35fc5552845..4d840a6ef802 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
> ... snip ...
>>  	/* Cache the data early to ensure is_visible() works */
>> @@ -69,24 +68,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  	if (rc < 0)
>>  		return rc;
>>  
> ... snip ...
>> -	return -ENXIO;
>> +	return 0;
>>  }
> 
> 	return devm_cxl_port_enumerate_dports(port);

This was actually done on purpose. devm_cxl_port_enumerate_dports() returns the number of dports enumerated. So usually the return value is greater than 0. in drivers/base/dd.c, call_driver_probe() throws the return value into a switch() where any value not 0 are errors. So the probe() call would fail. Here we are intercepting the return value and return a 0 if it's positive. I got bitten here during this series's debug. I should add a comment and explain why.  


> 
> 
> ~Gregory

