Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C171E0DCB
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747778381; cv=none; b=FgGdAD/MSSuNVWdQhskG9qrBqDg+lNcv+QLfQgFYs0BYnXtTdysu4+U9Z45OMGqGKNGdVrkGxzUwfsG+0O831cWtxUB6M8RpD8bKpcVTWpPjekceOQNAzstd2cYJjWojkKAiGK72xxvXMDPmnSLxcTeZOw3My+r7zV8SMI8qehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747778381; c=relaxed/simple;
	bh=uIqW4uzMskYhMyGIEgsoqR3RHHCvR4GN8RHflazrNSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APwBSkqnDHe2RVqe145XFMUn3Z8KlDsvoBvv7yvFmpETUY9nJi8LrdLyRoIRNDA/y5AllZ9b5C0cLuLGD1YAnkAO9Ia+u0uEn3AtXbwhMv7M5PwYGIyfKZCKGW9HVp3FAuqafqlUzhDMJ2M2hUKvirhw9dgYEl8/OomNQmm7qcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLDSdcxB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLDSdcxB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747778379; x=1779314379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uIqW4uzMskYhMyGIEgsoqR3RHHCvR4GN8RHflazrNSY=;
  b=gLDSdcxBAFBedOdyRYPylPNBwiZD5CQiqZVnfbJzjqR37hzPXjb7XKqE
   KpdB6cMtYS2oCRaOYPA1TJO4JO+M2sgQCIJZC7DR1gmHfvczJaby8IgS0
   H/d2aGwLpJH5ARyRyFwAr2dbxHci6mD7tlUUOIQBL+0K0s5zeTd4bDRMZ
   YY5GnljLuB+Mor1v23oAdn/GTCTNw0X1JvQ6Rmm+jcivJVsec2fXKM1dG
   3j4c5TL9ZlSQxrcqhZDnODnPWavz+IXBP24YNg4hlkmfJ33jHEM4vDoeW
   zLoFD3TGNgbP5ihJtIDx7FQiNgVCVmjMLaHkt1PECzom6/mjSR7BCRZaN
   A==;
X-CSE-ConnectionGUID: WlrqtKmkTDO7HnL74HfV4A==
X-CSE-MsgGUID: ZYfIWDcjSaaNWyL+pjN2wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60390154"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="60390154"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:59:39 -0700
X-CSE-ConnectionGUID: mqFpwr0HTXqIVrvfw6E+pA==
X-CSE-MsgGUID: 3RN6ArfIQx6zxK6PHIavtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140349977"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.92]) ([10.125.109.92])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:59:37 -0700
Message-ID: <14ec3f11-a488-43a0-bdfb-880f8b1223c1@intel.com>
Date: Tue, 20 May 2025 14:59:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] cxl: Move enumeration of hostbridge ports to the
 memdev probe path
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com,
 rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-11-dave.jiang@intel.com>
 <20250520141131.00003633@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250520141131.00003633@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/20/25 6:11 AM, Jonathan Cameron wrote:
> On Tue, 6 May 2025 17:43:10 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Current enuemration scheme in cxl_acpi module creates the ports under the
>> root port by enumerating the hostbridges after the dports under the root
>> port is created. However error messages "cxl portN: Couldn't locate the
>> CXL.cache and CXL.mem capability array header" is observed when certain
>> platform has PCIe hotplug option turned on in BIOS. If the cxl_acpi module
>> probe is running before the CXL link between the endpoint device and the
>> RP is established, then the platform may not have exposed DVSEC ID 3 and/or
>> DVSEC ID 7 blocks which will trigger the error message.
> 
> I think we should call out that this bit (unlike port numbers) is valid
> under the CXL spec.  Whilst I think that statement in the spec is something
> I'd rather wasn't there we should reflect this one isn't a hardware bug
> work around (unlike port number which I think is :)

ok
> 
> 
>>
>> Setup an association in cxl_port to tie the host bridge device to the
>> associated cxl_root. The cxl_root provides a callback that's setup
>> by the cxl_acpi probe function in order to create a port per host bridge
>> that was previously done during cxl_acpi probe. Add the calling of the
>> callback in devm_cxl_enumerate_ports(). The observed behavior is that
>> ports that are not connected to endpoint device(s) are no longer
>> enumerated. This should also remove any excessive noise of port probe
>> failing on those inactive ports.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> This is a fairly fiddly change but it looks reasonable.
> 
> Just trivial style comments inline.
> 
> J
>> ---
>>  drivers/cxl/acpi.c      | 136 ++++++++++++++++++++++++----------------
>>  drivers/cxl/core/port.c |  58 +++++++++++++++++
>>  drivers/cxl/cxl.h       |   2 +
>>  3 files changed, 141 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 6f8630e50800..1db4d308b4b7 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -298,8 +298,79 @@ static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
>>  	return cxl_acpi_evaluate_qtg_dsm(handle, coord, entries, qos_class);
>>  }
>>  
>> +/* Note, @dev is used by mock_acpi_table_parse_cedt() */
>> +struct cxl_chbs_context {
>> +	struct device *dev;
>> +	unsigned long long uid;
>> +	resource_size_t base;
>> +	u32 cxl_version;
>> +	int nr_versions;
>> +	u32 saved_version;
>> +};
>> +
>> +static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
>> +			struct cxl_chbs_context *ctx);
>> +
>> +/*
>> + * A host bridge is a dport to a CFMWS decode and it is a uport to the
> 
> decoder maybe?

yes

> 
>> + * dport (PCIe Root Ports) in the host bridge.
>> + */
>> +static int cxl_acpi_setup_hostbridge_uport(struct cxl_root *cxl_root,
> 
> Pity this doesn't sit in similar place to original add_host_bridge_uport
> as we'd get a much nicer diff if it could.
> I suppose it would be a bit too ugly to preceded this patch with
> a code move patch just for that diff.  Ah well. I'll cope ;)
> 
>> +					   struct device *bridge_dev)
>> +{
>> +	struct cxl_port *root_port = &cxl_root->port;
>> +	struct device *host = root_port->dev.parent;
>> +	struct acpi_device *hb = ACPI_COMPANION(bridge_dev);
>> +	resource_size_t component_reg_phys;
>> +	struct acpi_pci_root *pci_root;
>> +	struct cxl_chbs_context ctx;
>> +	struct cxl_dport *dport;
>> +	struct cxl_port *port;
>> +	int rc;
>> +
>> +	pci_root = acpi_pci_find_root(hb->handle);
>> +	dport = cxl_find_dport_by_dev(root_port, bridge_dev);
>> +	if (!dport) {
>> +		dev_dbg(host, "Host bridge expected and not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (dport->rch) {
>> +		dev_info(bridge_dev, "host supports CXL (restricted)\n");
>> +		return 0;
>> +	}
>> +
>> +	rc = cxl_get_chbs(&hb->dev, hb, &ctx);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
>> +		dev_warn(bridge_dev,
>> +			 "CXL CHBS version mismatch, skip port registration\n");
>> +		return 0;
>> +	}
>> +
>> +	component_reg_phys = ctx.base;
>> +	if (component_reg_phys != CXL_RESOURCE_NONE)
>> +		dev_dbg(&hb->dev, "CHBRC found for UID %lld: %pa\n",
>> +			ctx.uid, &component_reg_phys);
>> +
>> +	rc = devm_cxl_register_pci_bus(host, bridge_dev, pci_root->bus);
>> +	if (rc && rc != -EBUSY)
>> +		return rc;
>> +
>> +	port = devm_cxl_add_port(host, bridge_dev, component_reg_phys, dport);
>> +	if (IS_ERR(port))
>> +		return PTR_ERR(port);
>> +
>> +	dev_info(bridge_dev, "host supports CXL\n");
>> +
>> +	return 0;
>> +}
> 
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index a5a673d789f3..bbecbb04b6be 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1808,6 +1808,60 @@ static int cxl_switch_port_dport_setup(struct cxl_port *port,
>>  	return 0;
>>  }
>>  
>> +static int get_hostbridge_port_devices(struct cxl_memdev *cxlmd,
>> +				       struct device **uport_dev,
>> +				       struct device **dport_dev)
>> +{
>> +	struct device *dev = &cxlmd->dev;
>> +	struct device *iter;
>> +
>> +	for (iter = dev; iter; iter = grandparent(iter)) {
>> +		struct device *ddev = grandparent(iter);
>> +		struct device *udev;
>> +
>> +		udev = ddev->parent;
> 
> Odd to have ddev set at declaration and udev set here.
> Pick a style - either is fine.

ok

> 
>> +		if (is_cxl_hierarchy_head(udev->parent)) {
>> +			*uport_dev = udev;
>> +			*dport_dev = ddev;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -ENODEV;
>> +}
>> +
>> +static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
>> +{
>> +	struct device *uport_dev, *dport_dev;
>> +	struct cxl_dport *dport;
>> +	struct cxl_port *port;
>> +	int rc;
>> +
>> +	rc = get_hostbridge_port_devices(cxlmd, &uport_dev, &dport_dev);
>> +	if (rc)
>> +		return -ENODEV;
>> +
>> +	struct cxl_root *cxl_root __free(put_cxl_root) = cxl_udev_to_root(uport_dev);
>> +	if (!cxl_root)
>> +		return -ENODEV;
>> +
>> +	guard(device)(&cxl_root->port.dev);
> 
>> +	port = find_cxl_port(dport_dev, &dport);
> 
> I vaguely wonder if a __free() make sense on this. It'll autofree the NULL
> much later than needed but maybe it's cleaner code?

Given we are intentionally looking for a port and will return immediate if found, and later on port isn't used, having a __free() is probably overkill.

> 
>> +	if (port) {
>> +		put_device(&port->dev);
>> +		return 0;
>> +	}
>> +
>> +	if (!cxl_root->ops || !cxl_root->ops->setup_hostbridge_uport)
>> +		return -EOPNOTSUPP;
>> +
>> +	rc = cxl_root->ops->setup_hostbridge_uport(cxl_root, uport_dev);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return 0;
> 
> return cxl_root->ops....

ok

> 
>> +}
> 

