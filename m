Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BCC386C2D;
	Thu, 14 May 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778778654; cv=none; b=OJp+n8xVSf+64BKzlkteZwaaLfOmCfDBURMuMAaBVi2f6pIKmjBP6MRJiFDXCBru6C1kn67Zro7QZ3bhx7lQwEKfN/pGB1ABUoRD2nqccalmKXrdmwG7lbMGfvn6TMVxHnsoNyiFI8lkJqG3svjZce46uqkUOSLOX7Ui00Ilbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778778654; c=relaxed/simple;
	bh=uh4KhWeA/dAKaJzDF1UM7rw1diVC7QXouk9+kXu5160=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oekv9MxpBQN70dIqE6G7U3wI5bAipR4flSvIgZaIZwqsMSgunvRpzh7UqS97k6fw9fqg3tdlhDh90quwqFIFU9i+W+RrHOcp871HQPNwnrrw/iCp+wnSC+foyg8LR1lXQUIS7kn+/lmgGOjUrzVo60K0KT7eNonVHq6AW1sbpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6G1kf5q; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6G1kf5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778778653; x=1810314653;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uh4KhWeA/dAKaJzDF1UM7rw1diVC7QXouk9+kXu5160=;
  b=K6G1kf5qXolMOjVL/xkKJMM/yDHdy1xo+SsKJI+UyOrznTVGvLsHEDVi
   4mOhZ+mdXKUeIvabaiJi2x3iQSVOdzAb7nJuTqbGUs6Kb9C87v53Pk4XW
   bIRlddpLtSRrvGJ1A/CDvdyA5CxMaB73wPx88xpay5rpM1TNYP3Shsr5Z
   EjbOmSSp+qmi5SF/w3+i2tT3RrCC6z7z04NhhNLE98K7wysLcInuoIpon
   L9MBnsRXQ7R5pG7mLpe+ARxaQ/G5Lto/OzANReWiGLWmr7MJKPq51wAq1
   cSa7I7Q/+xe5RB1kmj/HUXZTETZ2C0m3FkvSPexYQ21mSEjGSyT5gV4BH
   w==;
X-CSE-ConnectionGUID: GIa/PMuiT+qCCeHy7Mmtcg==
X-CSE-MsgGUID: yUfWqlkRSCS9OSNjpsxd6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79584796"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79584796"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 10:10:52 -0700
X-CSE-ConnectionGUID: iwNVOvCySIarA2uTnddKvg==
X-CSE-MsgGUID: YpUWyxSbTHyQy1JVzNjLpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="238542684"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.122]) ([10.125.108.122])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 10:10:52 -0700
Message-ID: <f7f2e06e-e8a5-46b2-8516-235be474251e@intel.com>
Date: Thu, 14 May 2026 10:10:50 -0700
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

I don't believe this check in add_host_bridge_uport() is necessary. add_host_bridge_dport() happens first and the check should've been done there. There is no reason to do it again and you'll never reach here if it's not ready. 

DJ

> +
> +	hb = to_cxl_host_bridge(host, match);
>  	if (!hb)
>  		return 0;
>  

