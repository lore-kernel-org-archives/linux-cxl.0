Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43533D890F;
	Mon, 29 Jun 2026 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750777; cv=none; b=ItizPH1u4QXm29Vu282ayd5aI/mGbXFJZe0RlTZlJPORORtBOlPpwvORtGndV7RvdbOo44nGcfCHGa892kOYjmi0sP1JtRdFBfqgML2iyv92uVk+/U7uG2lBKPeejHBYU03w/I/df4Ttmcg3rnTHzZWOYFad8smi+kPwbHMz1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750777; c=relaxed/simple;
	bh=Q9JDyAJtpFJ/2R5jYMNgmfmsAZ2Zr1cw0IVJL22+ULc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0TNNqk8G4XMrVqs6uQAQ8gHOhFy4orbBqG3M2ZhOLZhFe6Q4VBkjhDhdZeezZpOFVGd0LeTGfVNGfOWDpCCtW4zYJ+IqgupJxQqkeyRjkvXhNWx1fp/zbiaQtwqBG/A89YR5oTRDplrlr2z1fNM3/7ALjXP1/asJ3wn90zptoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWuyAwaz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWuyAwaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782750776; x=1814286776;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q9JDyAJtpFJ/2R5jYMNgmfmsAZ2Zr1cw0IVJL22+ULc=;
  b=JWuyAwazrtSgRquCYlI+XHBAANzCOoYNKn4CC9g1CoCNTfBNWAAVjR6p
   eTt0tE41jy0m1KS6uOGBtdcd4vT7Sh7akCXg/b/b+1SY2041+2SJ5mCJ5
   ge+IzW3BUMWXaGva8b9LNBRiKLlNdDWEn5Lfof/rZuPu879eJU9Beo61j
   qm2bhjsr8ZXJ2/jhWGGo+yURTY4GYNNsnxV5cV9/P4YoKLYGrnZgLP3Ja
   DXewFMjFr5XU01U1nOdqDtg6FBpUudR4/a8QQbufv9o1Rgs3GcD4EKiSJ
   YoB1DcTl7cX4miUJLhvlPXTo0go35OmQ0kvR9tgCdPmBco0Y+hRhrPb/2
   Q==;
X-CSE-ConnectionGUID: u/aTbc4hR2yd6KNhkQ8f+A==
X-CSE-MsgGUID: ARerVSeNRWu+8whUZboaLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="106240160"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="106240160"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:32:55 -0700
X-CSE-ConnectionGUID: 7l1oUJJORgOTldMkGIw4Sw==
X-CSE-MsgGUID: FIGGnykITI+5b5gdMQ2wmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="247546404"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.194]) ([10.125.109.194])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:32:54 -0700
Message-ID: <211e6322-58e3-4c7d-bc46-2b5acf93cdfb@intel.com>
Date: Mon, 29 Jun 2026 09:32:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/pci: Remove incorrect mbox.valid check in
 cxl_pci_type3_init_mailbox()
To: Wei Hou <wei.hou@scaleflux.com>, Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Ming Li <ming.li@zohomail.com>, linux-kernel@vger.kernel.org,
 Kobayashi <koba@nvidia.com>, Kaiheng Feng <kaihengf@nvidia.com>,
 Newton Liu <newtonl@nvidia.com>, Kristin Chen <kristinc@nvidia.com>,
 Mochs <mochs@nvidia.com>, Dan Williams <danwilliams@nvidia.com>,
 Richard Cheng <icheng@nvidia.com>
References: <20260618170356.25382-1-wei.hou@scaleflux.com>
 <20260628155857.239866-1-wei.hou@scaleflux.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260628155857.239866-1-wei.hou@scaleflux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/28/26 8:58 AM, Wei Hou wrote:
> The driver's design intent is that missing or malformed component
> registers should not prevent mailbox initialization. cxl_pci_probe()
> already reflects this: the CXL_REGLOC_RBI_COMPONENT setup path only
> emits a dev_warn() and continues when component registers are absent,
> rather than returning an error.
> 
> The check 'if (!cxlds->reg_map.device_map.mbox.valid)' violates this
> intent and is also technically incorrect for two reasons:
> 
> 1. Wrong struct: the MEMDEV register block is enumerated into a local
>    variable 'map', not into 'cxlds->reg_map'. The device_map.mbox.valid
>    field inside cxlds->reg_map is never written by the MEMDEV probe and
>    will always read as zero regardless of actual hardware capability.
> 
> 2. Already validated: cxl_pci_setup_regs(CXL_REGLOC_RBI_MEMDEV) calls
>    cxl_probe_regs() which explicitly checks mbox.valid and returns
>    -ENXIO if the mailbox is absent. If that check passes, the mailbox is
>    guaranteed to be present by the time cxl_pci_type3_init_mailbox() is
>    called.
> 
> The value that the check actually reads is component_map.ras.valid,
> which aliases device_map.mbox.valid in the union. This is populated by
> the COMPONENT probe, not the MEMDEV probe. On devices where the
> component register BAR does not implement a CXL Component Capability
> Array (e.g. certain DCD devices), cxl_probe_component_regs() returns
> early leaving ras.valid=false. Through the union, this makes mbox.valid
> read as false, causing cxl_pci_type3_init_mailbox() to return -ENODEV
> (-19) even though the mailbox hardware is fully functional.
> 
> Remove the check. Mailbox presence has already been validated by
> cxl_pci_setup_regs(CXL_REGLOC_RBI_MEMDEV). The presence or absence of
> component registers is irrelevant to mailbox initialization.
> 
> Fixes: 8d8081cecfb9 ("cxl: Move mailbox related bits to the same context")
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Signed-off-by: Wei Hou <wei.hou@scaleflux.com>

Applied to cxl/next
d79b81893d0c

Next time please post v2 as a separate post instead of having it reply to v1. Thanks.

> ---
>  drivers/cxl/pci.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bace662dc988..e44e5d209900 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -691,12 +691,6 @@ static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
>  {
>  	int rc;
>  
> -	/*
> -	 * Fail the init if there's no mailbox. For a type3 this is out of spec.
> -	 */
> -	if (!cxlds->reg_map.device_map.mbox.valid)
> -		return -ENODEV;
> -
>  	rc = cxl_mailbox_init(&cxlds->cxl_mbox, cxlds->dev);
>  	if (rc)
>  		return rc;

