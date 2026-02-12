Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DE3EBF23
	for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854441; cv=none; b=CQSgETZXwJLuDxQoGePQcsB3X4lTZBQ5FNGo+TmWBGZosENXngTb2QtL2EQ8AksUoO6IDi33jh+zr6K8nQoiD+D9995hhk/vRZgMk4MhSIjn4VxRP9RHwv/JwAGqMskEkortgTGBg+yKBbFO7U0obg8xYSlB2uSa5DN/L0AaG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854441; c=relaxed/simple;
	bh=B/FjDDFXKKn6puRg6WFywHKA75XuUXWFeEP3rQd2ur4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFXcSmvKgKZBi+TNK8a8L/VH6E7whAd/9uMXU8KdaSDh4QkALLz/aaPjJhMb+X0eOPAyWfjnwJgfuMgr09+GyanOaKK+T19ZLieaqYOHuAsoBIphhQOkv4KVkL4ZBSDvrmUTbn01cFpKDuG5zq2y9D2k5s4mxpBpff0wxqDfvnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWhFy4Y5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWhFy4Y5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770854440; x=1802390440;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B/FjDDFXKKn6puRg6WFywHKA75XuUXWFeEP3rQd2ur4=;
  b=fWhFy4Y5jK0qNOx/HoRfkAg32MhY3RqzavRgdZaBo5tV3iYApogOwZ5s
   U9ZtCi+Px+x/P0sYg8zmhLpTcI3F4C4KQsULejyQv4oLZ2HtOY3+9A1CZ
   qEUO4oAL1fndhiyN1dW6gFbXWtCMakzJ5AFhuJ0zSKDr6VwTt3brCJooA
   We/OtJU6jXrZ2LUprRWivQIt5hqhDW4xskhk6qRLiV9CnXuhRgZd+hdaJ
   lwtJGKs02uComZer3NuH+Kdh7GanPEs/JL/JbdAV3cvY24ShUZLVuaR8c
   /WAAJ0HQX1/GRujc+nlFguErnyoxiq000WUubANHAoPpX0TZ6/DWqow9I
   A==;
X-CSE-ConnectionGUID: gWrPpAckSDyHz1mR4cuxow==
X-CSE-MsgGUID: XDRl5Qp0TS+NUIrafTADYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71730237"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="71730237"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 16:00:39 -0800
X-CSE-ConnectionGUID: w+MktAMtTtOalIQQk9+3TQ==
X-CSE-MsgGUID: zJBzpQ5kQRmO71+9hBwTcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="211736827"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.126]) ([10.125.108.126])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 16:00:37 -0800
Message-ID: <4f0b321d-0f4a-41e8-9e84-9db66f3cb16c@intel.com>
Date: Wed, 11 Feb 2026 17:00:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cxl: Fix race of nvdimm_bus object when creating
 nvdimm objects
To: dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
References: <20260211232630.480509-1-dave.jiang@intel.com>
 <20260211232630.480509-3-dave.jiang@intel.com>
 <698d170d45750_8c3210044@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <698d170d45750_8c3210044@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/26 4:55 PM, dan.j.williams@intel.com wrote:
> Dave Jiang wrote:
>> Found issue during running of cxl-translate.sh unit test. Adding a 3s
>> sleep right before the test seems to make the issue reproduce fairly
>> consistently. The cxl_translate module has dependency on cxl_acpi and
>> causes orphaned nvdimm objects to reprobe after cxl_acpi is removed.
>> The nvdimm_bus object is registered by the cxl_nvb object when
>> cxl_acpi_probe() is called. With the nvdimm_bus object missing,
>> __nd_device_register() will trigger NULL pointer dereference when
>> accessing the dev->parent that points to &nvdimm_bus->dev.
>>
> 
> Please trim backtraces of useless info, something like:
> 
>  BUG: kernel NULL pointer dereference, address: 000000000000006c
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20250812-19.fc42 08/12/2025
>  Workqueue: cxl_port cxl_bus_rescan_queue [cxl_core]
>  RIP: 0010:kobject_get+0xc/0x90
>  Call Trace:
>   <TASK>
>   ? pm_runtime_init+0xb9/0xe0
>   __nd_device_register.part.0+0x4d/0xc0 [libnvdimm]
>   __nvdimm_create+0x206/0x290 [libnvdimm]
>   cxl_nvdimm_probe+0x119/0x1d0 [cxl_pmem]
>   cxl_bus_probe+0x1a/0x60 [cxl_core]
>   really_probe+0xde/0x380
>>
>> 1. Set probe_type of cxl_nvb to PROBE_FORCE_SYNCHRONOUS to ensure the
>>    driver is probed synchronously when add_device() is called.
>> 2. Add a check after add_device() for cxl_nvb to ensure the driver is
>>    bound, which also means the nvdimm_bus object is registered.
>> 3. Add a check in __nd_device_register() to avoid NULL pointer
>>    dereference when nvdimm_bus is not registered.
> 
> This is not done in this patch and not needed.
> 
>>    Hold the uport_dev
>>    lock of the cxl rootport to sychronize between cxl_acpi_probe() and
>>    cxl_devm_cxl_add_nvdimm(). Also hold the cxl_nvb->dev lock to ensure
>>    a consistent state of if the driver is bound (or not).
>> 4. Add a check for nvdimm_bus in cxl_nvdimm_probe() to avoid accessing
>>    without nvdimm_bus for unbound nvdimm object reprobes.
> 
> See below, I would have expected that deleting stale nvdimm devices
> would also be part of this patch.
> 
>>
>> This fix also requies the commit that moves devm_cxl_add_nvdimm_bridge()
>> from core/pmem.c to pmem.c.
>>
>> Fixes: 21083f51521f ("cxl/pmem: Register 'pmem' / cxl_nvdimm devices")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/pmem.c | 13 +++++++++++++
>>  drivers/cxl/pmem.c      | 13 +++++++++++++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
>> index 50557d71a45f..f7f784047450 100644
>> --- a/drivers/cxl/core/pmem.c
>> +++ b/drivers/cxl/core/pmem.c
>> @@ -175,6 +175,19 @@ int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
>>  	if (!cxl_nvb)
>>  		return -ENODEV;
>>  
>> +	/*
>> +	 * Take the uport_dev lock to guard against race of nvdimm_bus object.
>> +	 * cxl_acpi_probe() registers the nvdimm_bus and is done under the
>> +	 * root port uport_dev lock.
>> +	 *
>> +	 * Take the cxl_nvb device lock to ensure that cxl_nvb driver is in a
>> +	 * consistent state. And the driver registers nvdimm_bus.
>> +	 */
>> +	guard(device)(cxl_nvb->port->uport_dev);
>> +	guard(device)(&cxl_nvb->dev);
>> +	if (!cxl_nvb->nvdimm_bus)
>> +		return -ENODEV;
>> +
>>  	cxl_nvd = cxl_nvdimm_alloc(cxl_nvb, cxlmd);
>>  	if (IS_ERR(cxl_nvd)) {
>>  		rc = PTR_ERR(cxl_nvd);
>> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
>> index 6f010b3cce44..0b200be1fd36 100644
>> --- a/drivers/cxl/pmem.c
>> +++ b/drivers/cxl/pmem.c
>> @@ -85,6 +85,15 @@ struct cxl_nvdimm_bridge *devm_cxl_add_nvdimm_bridge(struct device *host,
>>  	if (rc)
>>  		goto err;
>>  
>> +	/* Ensure that cxl_nvb driver has been bound since it is synchronous. */
>> +	device_lock(dev);
>> +	if (!dev->driver) {
>> +		device_unlock(dev);
>> +		unregister_nvb(cxl_nvb);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +	device_unlock(dev);
> 
> This can be a cxl_nvdimm_bridge_failed_attach() helper what uses
> guard().
> 
>> +
>>  	rc = devm_add_action_or_reset(host, unregister_nvb, cxl_nvb);
>>  	if (rc)
>>  		return ERR_PTR(rc);
>> @@ -213,6 +222,9 @@ static int cxl_nvdimm_probe(struct device *dev)
>>  	struct nvdimm *nvdimm;
>>  	int rc;
>>  
>> +	if (!cxl_nvb->nvdimm_bus)
>> +		return -ENODEV;
> 
> If I understand the failure scenario correctly, this is racy. What keeps
> nvdimm_bus valid for the duration of cxl_nvdimm probe?

With patch 3 merged into this one, we can drop this check as there wouldn't be any devices to probe.

> 
> This is why I think the cxl_nvdimm_bridge disable path needs to evacuate
> all prior cxl_nvdimm objects that saw nvdimm_bus live at their
> registration time.

Right I split that out because I was worried about patch size for review. I'll squash the two.

