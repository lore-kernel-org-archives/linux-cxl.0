Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341248;
	b=IBgxvLizMizooE0jV5B+dOgzgEVM2gaLk2G4jQX0bPojRIeO8wtx57JODUAAJ6xrNoxU
	 Qp8ebJ9x0fruz003y1Y3RLDrCBk/7wfkGdlbjA2vjiCwwCPIy5H1SvObDHWg3zfjoc/u2
	 GgfbjVJbsd5I5tWXATONa6nUucuYyqjGp1jfYfqHo+jwhoMTBxekbg1Y+eb1nEyewPt+c
	 hoQKTuMDGJau30nubOwU5KRCNhN6iiweAABY8vDJ/Z7rpGNlSAtsz2mpM4vDjH1qdAKhf
	 LpoRX+btTNj+iyeJDJCunovQK4/9p66YPSZUEZqt2YYWGB6AUvWmRoOvrahKcLFReEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341248;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=affVdVsuX3h6wSFz5H0tUyIToFoUahAYuWhw3x+ZP+w=;
	b=vM5h76KE7c8tE4GG1Abf8wUyEEy+iF6NELqVkTEVE1E11fBTHa9mZlZfDrgKhq5+zUO+
	 rmvAjverPzhWZXteWUViIbjm9RqcesTND8M70k59BSYeCWgtQ+9tJ9tnwNFk3f9fGUT9V
	 2RGLoRqoQahFTGpbb5deCmAj6Pk3plEf56ooLiBH7NALxE4Ov3uRG6LpPDV5iWrx3u+aZ
	 KS2MIO2W/c1eBQ0hpogaUnq2TYPbnaVP8+BRB49iCkgpDBPx1W/+3KuiQyu0d2GQrsAJK
	 Vx6k0rM4v5PzhcNQUuZJeS3u1fJsq27lvj5FjLCsLNSf0S+lJpcJNwG7n5tNny9X97Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UeMxqQlq;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239F606A321;
	Tue, 10 Nov 2026 20:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C239F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UeMxqQlq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794341246; x=1825877246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q/tBG+tWmhLMXw0hDFuope8Uw+MxSBs7GKzxJ2X/uzM=;
  b=UeMxqQlqHyPyOMaVf5bCysRbASgg3GjQJ/Gi7ddV5dBldI9oRc/amQvk
   fFRE+b7Sb90evP8NkZwlNe5G+aRuUcUKjt8odzjJi69Rw7R25Tm6vAJdp
   Pqf7tcEe1EwxlH5LC7t1Px3q1VO2Vj/LtFWbUmH2xTI9Ep8vqh1opAMDs
   rcJumIjhwB9TNhHClQAOm+AgATEJySEnNoZV1szLrCEHTrgVCFKRip5lH
   V6jU9F1Zqi3YAebOCAkDs6ibDhULznDLM18mg8xS43CezI060hS3tYdnR
   GCctU/HL7ByhUho1dpyQq9/9k/jg+YBTUVg24RTmcrTCOi00S2+bOrJVI
   g==;
X-CSE-ConnectionGUID: kcSlqwOORMqs3iii4lfEsw==
X-CSE-MsgGUID: /z4NDY8MSU+ndTIAit1yQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3186919"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3186919"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 12:07:25 -0800
X-CSE-ConnectionGUID: u7GF70cvTgqwY+vQ977JaA==
X-CSE-MsgGUID: 0osfdmbURY+0aRCUQEC1mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8216033"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.75]) ([10.125.111.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 12:07:24 -0800
Message-ID: <24df53a1-57a9-4a43-808f-520e70a1e37d@intel.com>
Date: Tue, 10 Nov 2026 13:07:22 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/port: Fix endpoint RAS error unmasking
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kaihengf@nvidia.com, kobak@nvidia.com,
 newtonl@nvidia.com, kristinc@nvidia.com
References: <20261103063409.18275-1-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261103063409.18275-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/26 11:34 PM, Richard Cheng wrote:
> Moving endpoint RAS handling from cxl_pci to cxl_port left
> cxl_ras_unmask() checking whether port->uport_dev is a PCI device.
> Endpoint ports always use a cxl_memdev as uport_dev, so this check
> returns early and leaves the CXL RAS error masks unchanged.
> 
> Resolve the PCI device directly through the memdev's parent. Rename
> helper to cxl_endpoint_ras_unmask() and its param to endpoint to make
> its endpoint-only scope explicit.
> 
> Fixes: dab7162d0ae7 ("cxl/port: Move endpoint component register management to cxl_port")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Applied to cxl/next:
ed574daa568d cxl/port: Fix endpoint RAS error unmasking

> ---
> Changelog:
> 
> v1 -> v2:
> - Clarify that endpoint ports always use a cxl_memdev as uport_dev, so
>   the PCI device check always skips endpoint RAS unmasking
> - Simplify the PCI device lookup to use the memdev's parent directly
> - Rename cxl_ras_unmask() to cxl_endpoint_ras_unmask() and its param to
>   endpoint to make the endpoint-only scope explicitly
> - Rephrase commit messages.
> 
> Reproducer is a QEMU Type-3 guest
> 
> 1. Ensure no CXL region is active and PCIe AER is enabled.
> 2. Restore the emulated RAS registers to their reset masks.
> 3. Reprobe cxl_pci and read the masks again.
> 
> ```
> BDF=$(basename "$(dirname "$(readlink -f /sys/bus/cxl/devices/mem0)")")
> BAR0=$(awk 'NR == 1 { print $1 }' /sys/bus/pci/devices/$BDF/resource)
> UNC_MASK=$(printf '0x%x' $((BAR0 + 0x1084)))
> COR_MASK=$(printf '0x%x' $((BAR0 + 0x1090)))
> 
> busybox devmem "$UNC_MASK" 32 0x1cfff
> busybox devmem "$COR_MASK" 32 0x7f
> 
> echo "$BDF" > /sys/bus/pci/drivers/cxl_pci/unbind
> echo "$BDF" > /sys/bus/pci/drivers/cxl_pci/bind
> udevadm settle
> 
> busybox devmem "$UNC_MASK" 32
> busybox devmem "$COR_MASK" 32
> ```
> 
> Before the fix, the masks remain 0x1cfff and 0x7f. After the fix,
> both masks read as zero.
> 
> Best regards,
> Richard Cheng.
> ---
>  drivers/cxl/port.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index c12fd0b89883..7b4726c7276d 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -72,19 +72,21 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	return 0;
>  }
>  
> -static int cxl_ras_unmask(struct cxl_port *port)
> +static int cxl_endpoint_ras_unmask(struct cxl_port *endpoint)
>  {
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct device *parent = cxlmd->dev.parent;
>  	struct pci_dev *pdev;
>  	void __iomem *addr;
>  	u32 orig_val, val, mask;
>  	u16 cap;
>  	int rc;
>  
> -	if (!dev_is_pci(port->uport_dev))
> +	if (!dev_is_pci(parent))
>  		return 0;
> -	pdev = to_pci_dev(port->uport_dev);
> +	pdev = to_pci_dev(parent);
>  
> -	if (!port->regs.ras) {
> +	if (!endpoint->regs.ras) {
>  		pci_dbg(pdev, "No RAS registers.\n");
>  		return 0;
>  	}
> @@ -98,7 +100,7 @@ static int cxl_ras_unmask(struct cxl_port *port)
>  		return rc;
>  
>  	if (cap & PCI_EXP_DEVCTL_URRE) {
> -		addr = port->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> +		addr = endpoint->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
>  		orig_val = readl(addr);
>  
>  		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK |
> @@ -110,7 +112,7 @@ static int cxl_ras_unmask(struct cxl_port *port)
>  	}
>  
>  	if (cap & PCI_EXP_DEVCTL_CERE) {
> -		addr = port->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
> +		addr = endpoint->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
>  		orig_val = readl(addr);
>  		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
>  		writel(val, addr);
> @@ -152,7 +154,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  		devm_cxl_dport_rch_ras_setup(dport);
>  
>  	devm_cxl_port_ras_setup(port);
> -	if (cxl_ras_unmask(port))
> +	if (cxl_endpoint_ras_unmask(port))
>  		dev_dbg(&port->dev, "failed to unmask RAS interrupts\n");
>  
>  	/*
> 
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e

