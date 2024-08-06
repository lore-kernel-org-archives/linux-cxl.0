Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E401C32
	for <linux-cxl@vger.kernel.org>; Tue,  6 Aug 2024 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722922181; cv=none; b=YSh3uVPudfgryrJIrunFVzKamhsd94aWwMJogkWxOihOt+UZ8mWjy6QH4lK3KbposBpj7eur/RW/pY2Lc7v9qEsd6G3P5ku+8stMqUSbiutNqzPeWq9UJqDU0bwecPcV5fS9B6uUz8DFgzUD7uMd7suh8bfug1VH/P2xvrQ6Y+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722922181; c=relaxed/simple;
	bh=NrurBa4eDIiWoNZJViv2ObUTDzaEHpUTfrGzfKjB44g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=God1SIlZ9NKrqz1otaZDDGM0tcWM4suL6mQUG0+u2chCtu9q4RJdNn/JHUz51G8Pduq7o6mK+Uo+b4f9YgbvtlF5v4hf0vPDTT/GUWp4Nlthsmt33LznIL/JqREFegdUuIcZGEof1hgQ9iLrb3Hst5LgT8YWbyc546MlJiUOyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQB8euXg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQB8euXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722922179; x=1754458179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NrurBa4eDIiWoNZJViv2ObUTDzaEHpUTfrGzfKjB44g=;
  b=VQB8euXguW/VyNwwOVnYmbuDSrSIp+icCR81ANWUnRScgTRC/ab2wy9L
   GoNxB5zniJlMqweCk/EMasthuw/uVIU2Fif74CbfDtX4xpQ0tOr7aBXd4
   juB+xA4H3zLDBlqgQLfdHGav6G4ie+grsaoGKWYEdJb7w+Vbu+pN46zEw
   ZE1T3+OU/jb/sSKFuensFAKH+RxTiWyhtztRqEv3UApfRYZ09IQno+w/h
   30i9Vg3DwU/5o8AZyyLJMjUS0z7qq9CWgsZmY5MpOl6iGwfYo596o7Nx/
   eOMRS//PppTDRnijtjFeu11c9u/yCjSEE0oFg40zqd6Sd2QuDhxkIriqB
   A==;
X-CSE-ConnectionGUID: JGIgFWTbTYSBXK8rcAXMmA==
X-CSE-MsgGUID: eKaQeIkSTmeiOlbh1L+Yuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="46318022"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="46318022"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 22:29:38 -0700
X-CSE-ConnectionGUID: QY5zQoOAQG6vFB0y/uO0AA==
X-CSE-MsgGUID: nNA7wCBjTpetE6XiS6cyNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56479400"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.27.59])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 22:29:39 -0700
Date: Mon, 5 Aug 2024 22:29:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming4.li@intel.com>
Cc: linux-cxl@vger.kernel.org, rrichter@amd.com, terry.bowman@amd.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 1/1] cxl/pci: Get AER capability address from RCRB only
 for RCH dport
Message-ID: <ZrG0wKU1XgEutEO/@aschofie-mobl2>
References: <20240806041547.1958787-1-ming4.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806041547.1958787-1-ming4.li@intel.com>

On Tue, Aug 06, 2024 at 04:15:47AM +0000, Li Ming wrote:
> cxl_setup_parent_dport() needs to get RCH dport AER capability address
> from RCRB to disable AER interrupt. The function does not check if dport
> is RCH dport, it will get a wrong pci_host_bridge structure by dport_dev
> in VH case because dport_dev points to a pci device(RP or switch DSP)
> rather than a pci host bridge device.

Ming,

Please add that this leads to a page fault. (from off-list chat)

> 
> Besides, cxl_setup_parent_dport() can exit simply if a RCH dport in the
> RCH topology created by cxl-test, in the case, the RCH dport's dport_dev
> is a platform device, and RCH dport with an available RCRB and AER
> Capability is not supported yet.
> 
> Fixes: f05fd10d138d ("cxl/pci: Add RCH downstream port AER register discovery")
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/cxl/core/pci.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a663e7566c48..f8a3188f5b17 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -4,6 +4,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <linux/platform_device.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> @@ -834,11 +835,16 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>  void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>  {
>  	struct device *dport_dev = dport->dport_dev;
> -	struct pci_host_bridge *host_bridge;
>  
> -	host_bridge = to_pci_host_bridge(dport_dev);
> -	if (host_bridge->native_aer)
> -		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
> +	if (dev_is_platform(dport_dev))
> +		return;

The above, dev_is_plaform(), is the cxl-test only case - right?
I'm wondering if we need to mock something differently in cxl-test
because it is unusual to have a cxl-test special case in the driver.

Let's see what others say.

--Alison



> +
> +	if (dport->rch) {
> +		struct pci_host_bridge *host_bridge  = to_pci_host_bridge(dport_dev);
> +
> +		if (host_bridge->native_aer)
> +			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
> +	}
>  
>  	dport->reg_map.host = host;
>  	cxl_dport_map_regs(dport);
> -- 
> 2.40.1
> 
> 
