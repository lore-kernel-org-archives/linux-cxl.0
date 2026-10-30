Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380097;
	b=Evplfl0SXSsjufFTsn8SFrQaPiYn9TrebeKnBAbs4jFsse0OPRdwhH9LyvpwQLAVFpfY
	 c8eAEe3I6ciiUh3wwi+bODWOVBFpzvmT3w8ztD4R+mFfjvTtdfALknTE3JSK2WYCE1skk
	 TmOQPuSBJh0tWvfhFbhFTuhxOmIegqkBW4CwNUN3Asotf2OpfVUT3VcbxKA74iDqhqZsb
	 s1euyDEgqb8Bc6QJ+jzHsxqm/wwEeC8QPEMV9WxjsyUAv3Zq24wjvIB1MyVXZmBCYb9Rw
	 Mlf3jfkSL9nqBoxPyxwBV9gSMcpGALigEiRGhr1dUqbHmO2kX3HQS7qja+GTNppojXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380097;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MxTNcFovyeUvNcbkqmtArfTu7j98UPGtZOH5XMgUOCs=;
	b=GtHKtkA9OyqZSMFhOObYQdPdd356ESNW3fCyoyjEuvKRvO8Yigv+q72hYYhjn6aG1pC5
	 DxxV1R4IlFuipewi6pfd/5Sw8HTPCAA8Khdct2MFW6iuIvXEbmbgjEALjPOkmC57ANVdR
	 wdLVRuEeGm8u9iwSTVR4vM5AkCetoLt+Q2A8rW7OKpMMUqeOF5D0IoEXl5pLHzQO+vfch
	 AZU9EEKlZcpqSbMNCo9Iwngk9ElnxkNmaajyDlNfwiNMbhfDGCVbUW2rTWEp4ugd3g1Kb
	 7Ol+3ESIjv6WcpNuqxUcXhR9cJ0Wz1W1tUtjnLHSAgqQ/0NI9EUp4QyeRcHWPtu+AVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DuwCMLGa;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1113606A31D;
	Fri, 30 Oct 2026 17:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1113606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DuwCMLGa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793380097; x=1824916097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aUI5eh52NNsqWKRcNFvW4Cmvnj+EOLZmBgtljE5pYJA=;
  b=DuwCMLGah0Gc/H7wWBT+hSTOleLV+rgz/4TlAdR6jqVZ5pTURcrhGVrh
   niVaNtam273+TA3Tk007bfL9op3GnuRRdo9tjFV/ssWF5MgLUyehlOESW
   C7lq7s6nBJdRZUy3ySOH60Vbwz8iWmMbhQTNPDZzRZ+EmN1mK/OXY3zYy
   yTWDhasNquG/netfSujG/YU6yh/pquLoaFXyf2lBcvmetyuhrmLlV5z7B
   ijELFQiNcQhxBLLXOWXwmH1mn6QQHS3OBxpoHhzirCJWUhzzjGpmH0k/Q
   8eOS40l/KA3UzBLJK+HVIUJQT+hfaHN3z7Ro9ZSifs0nEwx9Kzg4KRTrz
   A==;
X-CSE-ConnectionGUID: NL+6DPJuQXGKXAKhp5ieeg==
X-CSE-MsgGUID: uqDw+bccQO69435ePBQZUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2166570"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2166570"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:08:16 -0700
X-CSE-ConnectionGUID: FS20cj/BT1m6um7dSnznlQ==
X-CSE-MsgGUID: MkZ1mWf0R9CCr+KttFsBTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5615077"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.85]) ([10.125.109.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:08:14 -0700
Message-ID: <b9539a2c-fbe3-4043-9347-b60cbc375fe1@intel.com>
Date: Fri, 30 Oct 2026 10:08:13 -0700
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
Subject: Re: [PATCH] cxl/port: Fix endpoint RAS error unmasking
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kaihengf@nvidia.com, kobak@nvidia.com,
 newtonl@nvidia.com, kristinc@nvidia.com
References: <20261030095923.46051-1-icheng@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261030095923.46051-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/26 2:59 AM, Richard Cheng wrote:
> Commit dab7162d0ae7 ("cxl/port: Move endpoint component register
> management to cxl_port") moved EP RAS handling from cxl_pci to cxl_port,
> while cxl_ras_unmask() have the assumption that port->uport_dev is a PCI

s/have/has/

> device.
> If the topology use cxl_memdev as uport_dev, the PCI check will fail and
> CXL RAS masks remain set.

Endpoint ports always use memdev as uport_dev right? Maybe we can say the unmask has never run.

> 
> Resolve memdev uports to their parent dev and verify the device is PCI.
> 
> Fixes: dab7162d0ae7 ("cxl/port: Move endpoint component register management to cxl_port")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
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
>  drivers/cxl/port.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index c12fd0b89883..c48216e5078f 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -74,15 +74,18 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  
>  static int cxl_ras_unmask(struct cxl_port *port)
>  {
> +	struct device *host = port->uport_dev;
>  	struct pci_dev *pdev;
>  	void __iomem *addr;
>  	u32 orig_val, val, mask;
>  	u16 cap;
>  	int rc;
>  
> -	if (!dev_is_pci(port->uport_dev))
> +	if (is_cxl_memdev(host))
> +		host = host->parent;
> +	if (!host || !dev_is_pci(host))
>  		return 0;
> -	pdev = to_pci_dev(port->uport_dev);
> +	pdev = to_pci_dev(host);

Can we simplify this to something like:
	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
	struct device *parent = cxlmd->dev.parent;

	if (!dev_is_pci(parent))
		return 0;
	pdev = to_pci_dev(parent));

Also, maybe we should rename it to cxl_endpoint_ras_unmask(struct cxl_port *endpoint) to be intentionally clear?

>  
>  	if (!port->regs.ras) {
>  		pci_dbg(pdev, "No RAS registers.\n");
> 
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e

