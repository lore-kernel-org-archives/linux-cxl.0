Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4575B21C199;
	Thu,  5 Dec 2024 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733422791; cv=none; b=H9QLjxC4yftfISlqeyheHDRKbMOaaBEVPkO7V++KEXaJji0+kbQ2WH/YuWdFgmCbHeFwirgVB63W1zcb4cxX8P7Bwk4O8qofruiEgx/Zis6GYVMVKMja79to3EOqrMlR0j2F2Uj90SKPtr1x6PjMfX2ImmnDEJOAKo7BtWZaeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733422791; c=relaxed/simple;
	bh=Jb0FZs/6tEaSe6N/baRH3pNDpZvG73bWsNNPlA5VQPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puUdkcZpjOkeAF4toqb/mXxOYs+rklQL7NOSs/98lKkj+Q4TlMVxTGHpx6n4++Akp9bsmbDEPWQu2mYhsXHspxw8H4IKXWaeTorGyW9RAWEZBCiUOxFvV9rFKkNPXyDQteGZFo2ox5WDZBqTN2W6FCTM4LyoIIZZj4C3YMiSBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCaVSzU5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCaVSzU5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733422790; x=1764958790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jb0FZs/6tEaSe6N/baRH3pNDpZvG73bWsNNPlA5VQPI=;
  b=aCaVSzU5fMcIP+lbwtmxAllL0+JBkfpmHK1RaLJ8a4aU1vcJB/0dvTMS
   oaYKRF74IzVW1tTe+dwj5E45nc6nV9K7vSPJ2YuKHhoPLhoYOuTAmA2Et
   lOARNTk+xzUyHroj6KL/uI897wTO4h7SCkr1FWEgKqCYOM82+83Cc6Nn7
   SGnBrmeIpcE+MzFOxi3o8ubVkSyg0XFXjDyKdly60LHYTxWVmN2HPvbK2
   CQ20Aw+mqZFSil5Gu5cnUMn8XQLXewRfg4sth9DlmWFThKlNXCQXzmf5E
   mejb+yfL/ti2eSYOvP+K6f2UZ1Tmk6pqXHu24bp0Dd3JLmOcFMA+4Myep
   A==;
X-CSE-ConnectionGUID: OxteymY0RZOb5Zn4bzyBGQ==
X-CSE-MsgGUID: gHSeP4OiTOGbJqaeoDbS7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33493331"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33493331"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 10:19:49 -0800
X-CSE-ConnectionGUID: wc7u1Gk1Qrac1rsF7uxroA==
X-CSE-MsgGUID: /wWG80sCSbGD7P2h7U57+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="93989388"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.157])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 10:19:48 -0800
Date: Thu, 5 Dec 2024 10:19:46 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: kobayashi.da-06@fujitsu.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/pci: Check dport->regs.rcd_pcie_cap availability
 before accessing
Message-ID: <Z1HuwuKf7CYu-7K8@aschofie-mobl2.lan>
References: <20241129132825.569237-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129132825.569237-1-ming.li@zohomail.com>

On Fri, Nov 29, 2024 at 09:28:25PM +0800, Li Ming wrote:
> RCD Upstream Port's PCI Express Capability is a component registers
> block stored in RCD Upstream Port RCRB. CXL PCI driver helps to map it
> during the RCD probing, but mapping failure is allowed for component
> registers blocks in CXL PCI driver.
> 
> dport->regs.rcd_pcie_cap is used to store the virtual address of the RCD
> Upstream Port's PCI Express Capability, add a dport->regs.rcd_pcie_cap
> checking in rcd_pcie_cap_emit() just in case user accesses a invalid
> address via RCD sysfs.

I traced this enough to convince myself that dport cannot be NULL if
cxl_mem_find_port() succeeds. So, LGTM -

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Fixes: c5eaec79fa43 ("cxl/pci: Add sysfs attribute for CXL 1.1 device link status")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/pci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b2cb81f6d9e7..e53b1c95a248 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -836,6 +836,9 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
>  	if (!root_dev)
>  		return -ENXIO;
>  
> +	if (!dport->regs.rcd_pcie_cap)
> +		return -ENXIO;
> +
>  	guard(device)(root_dev);
>  	if (!root_dev->driver)
>  		return -ENXIO;
> -- 
> 2.34.1
> 
