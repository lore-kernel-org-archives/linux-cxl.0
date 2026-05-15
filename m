Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907FE305661;
	Fri, 15 May 2026 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859484; cv=none; b=C4dVvT1anPyfDkgW04rH1E7DscX1iF/VVp64xjBtXbjZKAmrLcZnBA9Hmy76bG08Nsz2gRnUIr7dawpf5YCJiPuBPLx2I0GHQsCmXDFbhAJk7qTxzwvJLOjGdiUA5Jlw/PKe0czrlftdq+FQrPub7xtrFT7LTHVm3J4BhVcFK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859484; c=relaxed/simple;
	bh=e1j+WnYtb6u2FHkCnrsgbYvWRsOQ3cYPjN0DP6hilwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlUSBoWBQaRfX8ltn3WNR3l76O2GEeVR0zgakcLJDClBq4yaYoHhSbuoaj15356LbyITBBMQ9Uk1FSGvhFos4g3DU71iLFzNxotYRh0zCb+EgKxW7f4zrORXZZcdy0+8x2o2AcO1/3PaIORFHTrJq0ZhUnPlAxXNXaNjEWhljvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLqCM1kd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLqCM1kd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778859483; x=1810395483;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e1j+WnYtb6u2FHkCnrsgbYvWRsOQ3cYPjN0DP6hilwI=;
  b=bLqCM1kdYFb7aC2SLxeAubwRfWy0jr+TVH8vYCUTHjjcat2LHJNzW00d
   cf8bdgL5z2Zus6MYGHzqlr5SZhpD0J3V7BALUZDV84dMDbTgP7VWyR+MZ
   Ai75tba460H/9HinSu821OKqMVQyP63S1V2FcXRJxrIHVokyI+b8X201m
   cRK2aXXSz+ZU6mQiOlWQl5Ti1ChwzpX+rLZMJQcNAyMnztVhFCS6qtP58
   n3SKhq0/EG2NAPMZDPVKWw4xCj5CPh+U7qnX1lvF72WkygKkBlkVxytjL
   3Hvzwj1afq3T4e4yEezmzxp9AuFyJbhq4clsdo805qoEnhz+ZxXTcqgYo
   Q==;
X-CSE-ConnectionGUID: Iiy7BX25RnqWqLaV2sAkAQ==
X-CSE-MsgGUID: l0tupulrR4OrK88PdBVsJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79936084"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79936084"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 08:38:03 -0700
X-CSE-ConnectionGUID: +wWv4+uCS5uWU610mYmnDA==
X-CSE-MsgGUID: v2WsUoZPTSWsG9zgEVT66A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243064129"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 08:38:03 -0700
Message-ID: <4ad8feae-6fc7-4e9d-8509-c9cc365d1c53@intel.com>
Date: Fri, 15 May 2026 08:38:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is
 not ready
To: Chen Pei <cp0613@linux.alibaba.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, guoren@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260514023238.49984-1-cp0613@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260514023238.49984-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/26 7:32 PM, Chen Pei wrote:
> On some platforms (e.g., RISC-V and ARM64) that use the generic
> pci_acpi_scan_root() implementation, cxl_acpi_probe may run before
> acpi_pci_root driver has bound to ACPI0016 (CXL host bridge) devices.
> In this case, acpi_pci_find_root() returns NULL, causing
> to_cxl_host_bridge() to skip the device silently. This results in
> incomplete CXL port enumeration on first boot.
> 
> Fix this by detecting the case where an ACPI0016 device exists but its
> PCI root bridge is not yet ready, and returning -EPROBE_DEFER to trigger
> a deferred probe retry.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  drivers/cxl/acpi.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 127537628817..9952d0cff903 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -631,8 +631,21 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  	struct acpi_pci_root *pci_root;
>  	struct cxl_port *root_port = arg;
>  	struct device *host = root_port->dev.parent;
> -	struct acpi_device *hb = to_cxl_host_bridge(host, match);
> +	struct acpi_device *adev = to_acpi_device(match);
> +	struct acpi_device *hb;
>  
> +	/*
> +	 * If this is an ACPI0016 device but acpi_pci_find_root() hasn't
> +	 * found the PCI root yet (driver not probed), defer the probe
> +	 * to allow acpi_pci_root to bind first.
> +	 */
> +	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
> +	    !acpi_pci_find_root(adev->handle)) {

I would leave the assignment of 'hb' as is above and just what's below after looking at to_cxl_host_bridge() function.

if (!hb) {
	if (!acpi_pci_find_root(adev->handle)) {
		...
		return -EPROBE_DEFER;
	}
	return 0;
}

I am concerned of other failure cases that causes acpi_pci_find_root() to fail beyond the driver not being attached. Will cxl_acpi probe() be stuck permanently in the defer probe queue when that happens? This is also something that Sashiko raised. Is there no way to adjust the RISCV ACPI setup to go around subsys_initcall()? That would be preferred solution.

DJ

> +		dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	hb = to_cxl_host_bridge(host, match);
>  	if (!hb)
>  		return 0;
>  
> @@ -688,7 +701,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  {
>  	struct cxl_port *root_port = arg;
>  	struct device *host = root_port->dev.parent;
> -	struct acpi_device *hb = to_cxl_host_bridge(host, match);
> +	struct acpi_device *adev = to_acpi_device(match);
> +	struct acpi_device *hb;
>  	struct acpi_pci_root *pci_root;
>  	struct cxl_dport *dport;
>  	struct cxl_port *port;
> @@ -697,6 +711,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	resource_size_t component_reg_phys;
>  	int rc;
>  
> +	/* Same deferral check as in add_host_bridge_dport() */
> +	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
> +	    !acpi_pci_find_root(adev->handle)) {
> +		dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	hb = to_cxl_host_bridge(host, match);
>  	if (!hb)
>  		return 0;
>  

