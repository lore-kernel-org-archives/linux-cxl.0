Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E529476
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257318; cv=none; b=qV62zLk3+nOpunbWtByZqrm0dXV5jJ7dtFPCTAQevuvp2Ynt8w/0k699OiIFJody/Cznavh/QNk5GqoTEe7sOUycJCVpvtqr8xb+aVcerarVrGNUl4nhSINrdju6ZgApy18vFLVk8GmjZupXGey7EQVKBpOmd7lmGaasgVmxZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257318; c=relaxed/simple;
	bh=eT0enr+Wa5dbehPf9UgRBs56jiv67DicyhWI44FwBSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfOqvOG1nR/0M8Cbms09aUYmEz97JtUw9WqzHXS/U3bGEV0hIrH2VzHKBXfUtxsW2EcTxfPa7YcdH3E4Hn0wTUKGTda7bupKDtIkzRTqP4LRmsFqjKt0szxhFLRaHtdnj8yytkjNZQnw8gKDggTSfo8L1XHt/9ZgKAplC7Ctwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=l8MLCtkh; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="l8MLCtkh"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-888bd3bd639so68710356d6.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 14:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768257316; x=1768862116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj3bgO5QxeDNWt7UDFC2P0u0orpRe5HxdiRqAEujEbk=;
        b=l8MLCtkhKrIMYzsMs+whwXHrn/WvGaJque1vzLbiZ9LdPSRtaFjdLB6WfZtAJ+4fDb
         sgnZ44cgZn4nTmWWQ96PNVW31Ank31EqDVaLnk/MaKjHS1I44B/oShPdVzl4fso4Eovu
         ue04ZAZWc1uX5mBZI08cLsCb/Rw0+CnpJ0UqPu1KRXBL7rOlJNwo4HxsEHFXlM6lgdhD
         xMxP5n+25Q539imy7D7p/fmjMQo2EXjGj/1xxA4YeUyo2AUiC1CGlb2T1gS0gbKzru/A
         6PzcyAjX/PtVbel2edC1PVUgjHMXdKf+dguh4jzm08TALELna1riapxzAmr7+aDTQr4M
         ad+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768257316; x=1768862116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hj3bgO5QxeDNWt7UDFC2P0u0orpRe5HxdiRqAEujEbk=;
        b=cpA+rDLjo8oW/tA3HXP/Qj89sHPxCgswUiJtplI0prP0vq7mIOCX4HWvEUEV3xFSqe
         y0+r2l2FUx2p9o+OSd8UWCGB/zbOQa4x7YEUlk/36ObTB276ijaMgK7JJ+oa6QzkYZqh
         VlPTy7yoBZYwwT6bEvdilKX5xEW51Pt7EvG+Nl+7JNrGRTNayOdLnaL1y8/0DCYsRTiL
         dZzKJ4nvUOxBPVnmwW+BvA4uRNOkmh1keOJuPl2mFBjs62Z04xSI2LmuFYpikefRtO3k
         BY7wq7hqlhTvLkwkBy6Ss90aBq/B7IMcAEaYk/kb98cIcnxdwZ5LJB16uTBOoWV2ku4t
         XI1g==
X-Gm-Message-State: AOJu0YwgKsQ2kzoeIj3DogkLRkjxgYIUFrnT2wzxgrmgUCVM7+oGS1rw
	XLZGHLVnM5CtwD1Mpkbc9GSo0SGvCWM6mZ++nzQid37GhMn0Mn72HrC/sqjl1dCLqZqwsgIOcH4
	9Olil
X-Gm-Gg: AY/fxX4Hcodad53K9e7/hIrPZTgJA1uXrXsj9NcMJa0TpHEbFpAtCeK5C1Xr3VUVVNj
	XeAdOslO4rm3CQYOpAcy5k6E9j7ObwlOaVrNm7L9OqAn11pcD0iKw+deZhbmb95pxdzDlWGir8J
	KWfSTus3vPL67OY2/1V2OIISn1pUNql/wPjwtbSr/s1mQtTNSqYDB0yTahwo8Pp3yt3JGMPxC9Z
	BAVCmtLs9PX643Qo5BGAx2m6KBYjfwNHkF7OpWPgQj91+aU2yEA+f+1jRYWV0zjmbgfGT6oGqlz
	T62Q0wFkExRAbS61zpEdlEagUonGee6wSlbUPe7YAj4hSV2YzbLeiUfSPG1XQZS5h0CE/oR/R+s
	DU6dlvOpnUm7B0cKT26ehyt8T7iYVBL+c7yHyje6guDyjiAtTksJV73qwiLrVaifkJAV5mSb25I
	67HSx2B0iU4HIgNBH4udYPXhwQ8iiIwTxQr4jR+5+WaGyu2LgFx1Tetp8wp+IDShnnMU1jtA==
X-Received: by 2002:a05:6214:408:b0:890:5841:8551 with SMTP id 6a1803df08f44-89266195bfemr13143886d6.7.1768257315664;
        Mon, 12 Jan 2026 14:35:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346f8sm145988036d6.35.2026.01.12.14.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:35:14 -0800 (PST)
Date: Mon, 12 Jan 2026 17:34:41 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and region->memctrl
Message-ID: <aWV3AQeITU5oNbUX@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-2-gourry@gourry.net>
 <4fc3ee3e-d764-46c7-ae45-a835e0080c98@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc3ee3e-d764-46c7-ae45-a835e0080c98@amd.com>

On Mon, Jan 12, 2026 at 03:10:29PM -0600, Cheatham, Benjamin wrote:
> On 1/12/2026 10:35 AM, Gregory Price wrote:
> > The CXL driver presently hands policy management over to DAX subsystem
> > for sysram regions, which makes building policy around the entire region
> > clunky and at time difficult (e.g. multiple actions to offline and
> > hot-unplug memory reliably).
> > 
> > To support multiple backend controllers for memory regions (for example
> > dax vs direct hotplug), implement a memctrl field in cxl_region allows
> > switching uncomitted regions between different "memory controllers".
> > 
> > CXL_CONTROL_NONE: No selected controller, probe will fail.
> > CXL_CONTROL_AUTO: If memory is already online as SysRAM, no controller
> >                   otherwise register a dax_region
> 
> I think you can streamline this to get rid of CXL_CONTROL_AUTO. If BIOS set up
> the memory you can just set the mode to CXL_CONTROL_NONE, otherwise use CXL_CONTROL_DAX.
> This patch would be a bit less complicated at the very least, and I don't think it
> would require much reworking of later patches.
>

I suppose if it's an auto-region (CXL_REGION_F_AUTO) we can default to
DAX if the SP bit is set (memory is soft-reserved).

I was hoping to quietly convert our systems from the dax driver to the
sysram driver without too much hubub, but this would require our old
systems to implement a udev or chef thing to online the memory after
boot.  Otherwise I can't ditch the MHP_ auto-online flags to
auto-online.

But yeah I won't fight this too much, just need to think about it.  I
can always ditch it and bring auto back later if there's something that
breaks unexpectedly.

> > +	switch (cxlr->memctrl) {
> > +	case CXL_MEMCTRL_AUTO:
> > +		/*
> > +		 * The region can not be manged by CXL if any portion of
> 
> s/manged/managed. May as well fix it since it's being moved.

ack.

> > +		 * it is already online as 'System RAM'
> > +		 */
> > +		if (walk_iomem_res_desc(IORES_DESC_NONE,
> > +					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> > +					p->res->start, p->res->end, cxlr,
> > +					is_system_ram) > 0)
> > +			return 0;
> > +		return devm_cxl_add_dax_region(cxlr);
> 
> If you take my suggestion at the top about removing MEMCTRL_AUTO, this case become
> the MEMCTRL_DAX case.
>

ack.

> > +	default:
> > +		desc = "";
> 
> Nit: I would prefer this say "none" instead of being blank to match the code.

reasonable

> > @@ -3579,6 +3558,9 @@ static int __construct_region(struct cxl_region *cxlr,
> >  
> >  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
> >  
> > +	/* Auto-regions will either be static sysram (onlined by BIOS) or DAX */
> > +	cxlr->memctrl = CXL_MEMCTRL_AUTO;
> 
> And this would be set to CXL_MEM_CTRL_DAX instead.
> 

Mmmm, hm.  I guess if the region is already online, we'll revert this to
none at probe time, so yeah that should work.

There may be some kind of management we want to add to auto-regions
onlined by BIOS (e.g. no SP bit), but we can add AUTO in if we ever
discover that use-case and argue for it then.

Thanks,
~Gregory
