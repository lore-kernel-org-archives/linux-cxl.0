Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D815E21FF36
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758233227; cv=none; b=aMUEi8naXuJ+6Udl3kRtOtrEEkTFGPjJ5rEOxapqd55tL+nis0AhADvcnGRVhJNPb7LazDH5IqwL8FKjp9WWVyUILKey9dci2Xek60ackpOfv61MOdYKp5FdI0jMGgusCN4JJvT1dSTCKbORiprGDR/TNG8VT9BCmIAvduKwtgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758233227; c=relaxed/simple;
	bh=8H5oSNc1Cas7eJ7GjfrGr3SCaKoXEgZjcYR+OiqJocA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nsELGaDqKnxDLEKW2D6c2ycc2cEv0IiOtJDd1454YSfzj3NWzAu1tsW9A6a7ZbAZRnpcZBMWK4BJkG6Kv6aD2VU47w0y9iMRZZ+PouWJvL7A6JV3RLQ2IsXqEaxMZzBAxzGwPq7n0FAw0DLPHhEhBg9vbvcP5hm9hLMKt3WVzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U50dEJH8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U50dEJH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758233224; x=1789769224;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8H5oSNc1Cas7eJ7GjfrGr3SCaKoXEgZjcYR+OiqJocA=;
  b=U50dEJH8nlAyB9ULzTTNEoCKamf3Fm2hj7rfT0zNjz1ASP6QPVdLYuZ+
   ysr1zosEJFkjVmVU+zDSPkX4aGHRGDBJ40PUjSBXiKm7pbIhQw20N2n4R
   IaI03cwo6lsSWwtlHol78bwycttehmi+9/5WLr5gd4c21kxOCH2lZXzjm
   L4/gAGAWwrfFCCouJG7GxkZoB/H3ZovB0cOeegacsbCDEAYFWyaAWQ6Z1
   Us991/hNPegknft3eljDU7hJETX5jiZ88tOtIxfHws6e7D91n8mW7Yf1p
   kfCOP7VIOoJ6TPAVCjGiexH6tXr04/GQnS/PCD+6kZTxS4MofvVosYA2G
   Q==;
X-CSE-ConnectionGUID: jVuiVE5IQUuWIi42UZeecw==
X-CSE-MsgGUID: Vp8nCPq4QYihFjorh41NKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="60271404"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="60271404"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 15:07:03 -0700
X-CSE-ConnectionGUID: hl7MBgfxQoOL54oMH9mHIg==
X-CSE-MsgGUID: UDilNNILSOy4CPDi7EHlNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175588301"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.28]) ([10.125.108.28])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 15:07:02 -0700
Message-ID: <7b529e9f-062d-4775-a9b4-2c8703d95213@intel.com>
Date: Thu, 18 Sep 2025 15:07:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Move port register setup to when first dport appear
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>
References: <20250911204406.2454689-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250911204406.2454689-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/11/25 1:44 PM, Dave Jiang wrote:
> This patch moves the port register setup to when the first dport appears
> via the memdev probe path. At this point, the CXL link should be
> established and the register access is expected to succeed. This change
> addresses an error message observed when PCIe hotplug is enabled on
> an Intel platform. The error messages "cxl portN: Couldn't locate the
> CXL.cache and CXL.mem capability array header" is observed for the
> host bridge (CHBCR) during cxl_acpi driver probe. If the cxl_acpi module
> probe is running before the CXL link between the endpoint device and the
> RP is established, then the platform may not have exposed DVSEC ID 3
> and/or DVSEC ID 7 blocks which will trigger the error message. This
> behavior is defined by the CXL spec r3.2 9.12.3 for RPs and DSPs, however
> the Intel platform also added this behavior to the host bridge.
> 
> This change also needs the dport enumeration to be moved to the memdev
> probe path in order to address the issue. This change is not a wholly
> contained solution by itself.
> 
> Suggested-by: Dan Williamsn <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
f6ee24913de24dbda8d49213e1a27f5e1a5204cc

> ---
> 
> I pulled this patch out to continue the discussion with Robert and not
> hold up the dport series.
> 
> While the behavior observed on the Intel platform is a quirk, similar
> behavior can exist for RPs and DSPs allowed by the spec. CXL spec r3.2
> 9.12.3 states that CXL DVSEC ID 3 and 7 may or may not be exposed and
> the software can use ID 7 and link status to determine CXL link is
> established. Thus to cover the spec allowance it is reasonable to not
> access the port registers until we are certain the CXL link is initialized.
> And the first dport appearance ensures that. While this issue is
> only observed WRT CHBCR on that platform, the enabling code covers the
> common case for all RPs and switches and the allowance provided by
> the spec for future implementations.
> ---
>  drivers/cxl/core/port.c | 16 +++++++++++++---
>  drivers/cxl/cxl.h       |  2 ++
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 76dd06d282df..416d45516d82 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -867,9 +867,7 @@ static int cxl_port_add(struct cxl_port *port,
>  		if (rc)
>  			return rc;
>  
> -		rc = cxl_port_setup_regs(port, component_reg_phys);
> -		if (rc)
> -			return rc;
> +		port->component_reg_phys = component_reg_phys;
>  	} else {
>  		rc = dev_set_name(dev, "root%d", port->id);
>  		if (rc)
> @@ -1200,6 +1198,18 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  
>  	cxl_debugfs_create_dport_dir(dport);
>  
> +	/*
> +	 * Setup port register if this is the first dport showed up. Having
> +	 * a dport also means that there is at least 1 active link.
> +	 */
> +	if (port->nr_dports == 1 &&
> +	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> +		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> +		if (rc)
> +			return ERR_PTR(rc);
> +		port->component_reg_phys = CXL_RESOURCE_NONE;
> +	}
> +
>  	return dport;
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6c42646f47ba..bdc682a7d60b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -599,6 +599,7 @@ struct cxl_dax_region {
>   * @cdat: Cached CDAT data
>   * @cdat_available: Should a CDAT attribute be available in sysfs
>   * @pci_latency: Upstream latency in picoseconds
> + * @component_reg_phys: Physical address of component register
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -622,6 +623,7 @@ struct cxl_port {
>  	} cdat;
>  	bool cdat_available;
>  	long pci_latency;
> +	resource_size_t component_reg_phys;
>  };
>  
>  /**
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> prerequisite-patch-id: e96001d5ba3459a014f818421b1f771e88775c9f
> prerequisite-patch-id: 8b216a3f53da0be4117ba50a3a8ecbb0dbe61041
> prerequisite-patch-id: 8da2fd3d645d11c1c6cb33aab62590f2533b737b
> prerequisite-patch-id: 04a9b9c9e69bbff4da3917a33e8b7c1d77059c1f
> prerequisite-patch-id: c0accfef8f5a037fa7456d2517eb197eb910739c
> prerequisite-patch-id: 0f3f0698af3958b2e4cabf66dd2268132c2c51fb
> prerequisite-patch-id: 3f47d2470e1c7bd34fd509a27331d72c45d33847
> prerequisite-patch-id: 434177b7f4f808aeeace5d7d1e17108f66a7d6cb
> prerequisite-patch-id: 6a6f4dbe624e00865bb1e087dcbd8bc9c8807a18
> prerequisite-patch-id: 95e0c0aa6d4589772e6c38780eaed739d54ee755

