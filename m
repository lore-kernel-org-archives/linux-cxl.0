Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6C28B517
	for <linux-cxl@vger.kernel.org>; Wed, 23 Apr 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423350; cv=none; b=cg/iNbJoFIvXdROtjnTNJDVyIbmJj5liNi/SahGKWQWJbX7Fu0zlOsyVVRO34VHR+izE9CwWsJjD2sCPdp8bWX3QZGBB6UXI8YqD3WO99RjlK2MZXhtkkXTr9Q6VTUeGtccds6y+R9kwjN5WMEbD+zemiCREQJ84XgTF5DP4nc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423350; c=relaxed/simple;
	bh=kxAkEWyecuw4VJmD6htVQLXhvJUrGnzW+IRVpMpyDcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GV1x8rd27MgTEelOokef45nyqrwBAAq81Fc89gQbrTUi6QNkEzf9xnljSCA9V4jPVrbcYgwbC+LzbQglgMK2o2OJeYgGTF9OXuALl0Rk5p0xfDF77GIVEQd64sNo/19auc+iIqoWyiqxRZduIQrl1lB0McAGXrMSUFqeDSXVljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIru+WOg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIru+WOg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745423348; x=1776959348;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kxAkEWyecuw4VJmD6htVQLXhvJUrGnzW+IRVpMpyDcA=;
  b=NIru+WOgMhoEMLXPxR3MoMpTiGL11Jmo2/xfgN299Wzq0Eir6VghnHwI
   agB2V4BFTQr80ovs30uBHCeMvnRxQnm7SGab8h008UBVNAP2GeFXDmg67
   G72bgfxG1Et3UNKrjrctiSyRJ5Up/K3dIHPh049YUYADl+RjOo7f64/2l
   x2NL2NvbgIKgSA+DtYE/KTqnsrA0tUwYM8poNnyMHTG39svYCYNOAL5y8
   q6AlorqDMbfLSBeUurYIfRFnEAruyNAJ0EmZgfIGgyRN0Va6NvC3Orua6
   yTknXqPQXNs20bqSpEIGNEfCt1Zzpgpar6g+Kh2qgv4cXOt5N6wsVHNpb
   Q==;
X-CSE-ConnectionGUID: da2Dd3meQea8SGQFNKPkyg==
X-CSE-MsgGUID: PVz7kl9aQvWNBZw+WXD/pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="57678333"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57678333"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 08:49:03 -0700
X-CSE-ConnectionGUID: 6sgVutgPRq6nqbwcbe6XDQ==
X-CSE-MsgGUID: 93yfG6ZKSFuyn9dqRL5nsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="136424243"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.20]) ([10.125.108.20])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 08:49:01 -0700
Message-ID: <d3be2435-3967-44d1-bf02-8c796c564b12@intel.com>
Date: Wed, 23 Apr 2025 08:49:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cxl: Add late host bridge uport mapping update
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 ming.li@zohomail.com
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-4-dave.jiang@intel.com>
 <6808843fe48e2_71fe294c4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6808843fe48e2_71fe294c4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/22/25 11:10 PM, Dan Williams wrote:
> Dave Jiang wrote:
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
> 
> This looks racy. How do you know the cxl_mem_probe() path is not messing
> with the reg_map here?
> 
> I feel like the rules about when component_reg_phys is valid to pass to
> devm_cxl_add_port() are getting complicated pass the point of
> maintainability.
> 
> I would be happier if the rule is always "component registers are only
> probed and cxl_ports are only created when a memdev is present".
> 
> What is currently missing for that is that devm_cxl_enumerate_ports()
> does not know how to create the cxl_port instances beneath the cxl_root.
> I think the time has come for that. So cxl_acpi only creates the
> cxl_root and the host-bridges dports, and devm_cxl_enumerate_ports()
> does the rest.
> 
> I do not see anything fundamentally difficult about doing one more level
> of iteration in devm_cxl_enumerate_ports() to check that a host-bridge
> is registered as a dport of the cxl_root and then register a cxl_port
> (if not already created).

Essentially move add_host_bridge_uport() to cxl_core? It looks like we'll have to move some ACPI bits to core then in order to retrieve the CHBS. 
