Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE890165EF8
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699107; cv=none; b=NbeOo57wL5qOUq0idheUAsdGovo4HA21HeowdHw70g9nUI5XeEn7lq/WIe5HOTOON4nUeFOzwqLQgYzfwd01PwEX5ZSOS02l7NV5nJWkMYP52W2bWaUn0ywJADyrO0JpBCi82etEnJMFKTdaQeUvmpkDCU0WV6J95qdLhOIzB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699107; c=relaxed/simple;
	bh=wjOQfgzaFkIZGfkb950aXJ4oKN7pDRAMvwYLJg/wgwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPhT8GRHDJdf+CGq8HoGAYU5CBd1I1whANUYb06ZD2/lwA0jiwjK5WYCb2ZPOWK8yJttGQ9MI0Z1GHdHxzNEnPuSEXkevwk7zDQdfcPeB9TAtC1FRLcjT+AOjocuXcQyClFXfPpASmA1C3p7d/UHbWmHdD1l12+w7MHKFVaHAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIqkxl7E; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIqkxl7E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731699106; x=1763235106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wjOQfgzaFkIZGfkb950aXJ4oKN7pDRAMvwYLJg/wgwQ=;
  b=mIqkxl7EXAYLA1GsHacbT3xEezhZV926V7t2CSpG/R3gLB8BpH3QyWZF
   D2lIuXMWKcA10N883NRLD3nH8aPScuN1l/3DJi9BDy5FhFxx/iyis9d2I
   DDUDaWl/VLHXf7ZVPhGLHUuWuzg/3hm4e4xHyGDAc0VPWZqhIgVUmYgvq
   vxUGi280Xmr9rEzGGGC2JgHdDY1vsury+Q9M6o+arAq6bq2Zm/6XEq8RL
   jIGsb9fxhic1zn4n1G99vskrqifrvSL/8bUXAXvY0T0z4gC6l4xoFMDtH
   yttSxVZtqXJHKQ3D90sMtIUOriK+uf7m1hmToxn+RlU363qP85EG+rXdo
   g==;
X-CSE-ConnectionGUID: juygD76OTCawizPzRzxR5A==
X-CSE-MsgGUID: TMtDng82QbK5oUkh7cbkCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="31475761"
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="31475761"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 11:31:45 -0800
X-CSE-ConnectionGUID: C6PlPIjUQuGtG1eAFUxqMQ==
X-CSE-MsgGUID: dBvh4bAeRYasbOTCKDMvMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,157,1728975600"; 
   d="scan'208";a="88532654"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.129])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 11:31:42 -0800
Date: Fri, 15 Nov 2024 11:31:39 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
	a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/pci: Fix potential bogus return value upon
 successful probing
Message-ID: <ZzehmxLoQ3RJyRah@aschofie-mobl2.lan>
References: <20241115170032.108445-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115170032.108445-1-dave@stgolabs.net>

On Fri, Nov 15, 2024 at 09:00:32AM -0800, Davidlohr Bueso wrote:
> If cxl_pci_ras_unmask() returns non-zero, cxl_pci_probe() will end up
> returning that value, instead of zero.
> 
> Fixes: 248529edc86 (cxl: add RAS status unmasking for CXL)
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Changes from v1:
>  - Picked up Fan's review tag.
>  - Continue to return rc (Alison).

I thought I said opposite - 
	"I agree that the return value should be 0 if we get this far,
	because all rc's that need to be returned, are returned immediately."

Regardless - it fixes what it said it will fix, as did v1.

> 
>  drivers/cxl/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b2cb81f6d9e7..2012301fcfbf 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1032,8 +1032,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_pci_ras_unmask(pdev);
> -	if (rc)
> +	if (cxl_pci_ras_unmask(pdev))
>  		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
>  
>  	pci_save_state(pdev);
> -- 
> 2.47.0
> 
