Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC12370AD7
	for <linux-cxl@vger.kernel.org>; Wed,  7 Oct 2026 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408322; cv=none; b=iMdNJpNzFLJDauL2EN084CMZQz+PTMaB3PXGbe2kkyquxAy4uGlHGChTcJqNWxKQvRVDMs6xClB5SrIxVEtyJhf2npVfkM6psmTotdNrH/YuH8T4jpe3tx3jKnXrFpHUQwyASuQ8T2H5CAb9C/uom0C/iGHqV2fYB833CpK5wQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408322; c=relaxed/simple;
	bh=SXwEfB0YrpC+Z0z4zEHdjXlvVK90EgkZyDvExIl9Ajk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUYeTP4NLksVVJ6/A5J6j0ohtYxoRfdO+sft1zExgxN+vdOPIQsLMzUXzg+2uF3w9sfERmmGxar7lyaRw34bBH5qwzlpMAJYggtMBXW+br4aeOMBnkvPxRKcvNPsx8OsUqA+Jp144xO4TCsuDp8muedM5cLClK5wA04LK7hw3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7rg0ZBl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7rg0ZBl"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a886d6ad51so1587804a91.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 Oct 2026 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791408320; x=1792013120; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLc7Zcf3JAoMm0kGaKtX3+RBEoj68Ac29TOBrDveylo=;
        b=h7rg0ZBlKXfyJ7YJVjNrE2G8bs8OLEVklAgE7Wn9nKwe3DIst55LQr41CRcHvEOdnW
         d/kPLC4VbAk4EDj5/wVTPMq+kN5PntoQLy5GjkAwG1wNGxUEWYyWNgs9Cun4tazxozyL
         gh8F4YwMYjAflREhmWPrAsUNiZfzFrrpRY1lfMCz4A6yyak5QeBxuMbe2sm5va7hGhNm
         6Ky3OYO4i1mgem6vIOQ91j0O9ECsQjkOS9dqEipm9RvJo7WmKjCWhos7xm/fcUeSX4W3
         zlX3+AP/6K7ZRNO7IPrFL1Ia5mrLB+tnPD0FsCkB1y4IwWwzpGAzUE1l0kDFZ4YS8wBs
         4gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791408320; x=1792013120;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TLc7Zcf3JAoMm0kGaKtX3+RBEoj68Ac29TOBrDveylo=;
        b=ZH4Dupv7zJ41jKul4bBkh80rJHnz7uoWWfcM/x8uwEFBn50joDiLMPGw6gTkpTWVM3
         VpFsGq2QjFX4RVpWty0xNCAB85hppFIXmH3VH4H8CdjqGp3ZkFBvY26Rfi/qHjqVWJTB
         1xtUCALMJ3OySvjgnjZrF3injjTvNYtFbr1coxJ7lmacMK/KbAim1nWyZzWnKDghFoMy
         F1g5EnV9oJcoaNcZWEUxVVMlvR/lAhLJW0751Chw1NkZSS9LaImEUHs3NESE2xBtDKuO
         dHphb1BeLvhktze1e04YwfDbMHWzLdUhymeN5gbKSBP5qAABrF2ZSqxiuj44iofn9SV/
         1l+Q==
X-Forwarded-Encrypted: i=1; AKwUvBy1PbMv3lNysOTxm5BB+oJsbdMg4gnmrAU1DPt5N8sGUOI2C0sRa/VCGJVPphxrzmsSJNoztCgGpoo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPh5veDyr57Auc5VXqSu56rQuGEzcPIJ52Z9Aw2VMMXG0X37Al
	prKpoqJb9XYLa+z7T/WXePN3x1jGruiyCOucTlbY7kvJQivuj0ePlPEr
X-Gm-Gg: AYBFou1dqrlaHgw4vtztZE6B7hpUONb86WitaLXEDLSP+pxJs2J8/g0dqEdRjMwboRC
	YwkGSs4qZWzeEj3cvrRUy3xrRycCQ4wwO+nhSTvgtS/uKivC882xUQnEx33sgYrakPEGmBLBVT6
	IHNP5MJg2+XDbQrFoc06KRLY5yOGK8sVJU/pQ/m7NtVvhYc09/3OR2W9ppQz3UrnTRciIr8Qfom
	jTRKLn8e7if/c+AEyCu3NrneMsrD8syeRfBlwrgBTFVlsD3WjsTCI8KCJtP79txpMGPFtcWgUsv
	ELS0/sTJQfTsttbrdxg/QykqnO6K4AXpspqyY1SW0dU6xq+2kugskKusGZ7tWcRYRmnZ/Px5XNF
	1qESc3LY7IqyvWTgwBIVA8wCngJYuSjHi8UBMVYta0YR9+u6rNPA5eHujLyPxj8Avp6VzPN/OgF
	+ucLPZ4eaPdb8LdEvHVeGC+lL/CKgqtb19I2OxrQ6pnXGvJUA/rfdb3afwFshdy8CC5lQGm/98G
	99hIy0XHVEU3X3svQM7sFNZxl9+dxFJ+MHlizTRfuzf5cb6IVHNDBVSrLdhfXJNqxqmeKVbf3aO
	QLW+UHsVjrqpQ2apwYhrDvaZ
X-Received: by 2002:a17:90b:48c7:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-3a8a04ba071mr2767269a91.9.1791408320344;
        Wed, 07 Oct 2026 14:25:20 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-24-19-224-150.hsd1.wa.comcast.net. [24.19.224.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1a7e9e4sm1196231a91.7.2026.10.07.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 14:25:19 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 7 Oct 2026 14:25:18 -0700
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v15 2/8] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <asa4vh2RaQyoVorj@4470NRD-ASU.ssi.samsung.com>
References: <20261007201828.952-1-anisa.su@samsung.com>
 <20261007201828.952-3-anisa.su@samsung.com>
 <sashiko-outbox-163339@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163339@kernel.org>

On Wed, Oct 07, 2026 at 08:29:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] cxl: cxl_configure_dcd() falsely fails overlap check and double-counts total DPA capacity

False Positive
> --
> 
> commit e491a6175f0241ed507a397807a28860fd54aadf
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/mem: Read dynamic capacity configuration from the device
> 
> This commit implements Dynamic Capacity (DC) mailbox commands to read and
> store DCD configuration information. It validates the first dynamic capacity
> partition and configures it as dynamic ram, disabling DCD if the
> configuration is invalid.
> 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index b3419df586b9c..def26c490dfe4 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> [ ... ]
> > @@ -643,6 +643,53 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
> >  
> > +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> > +{
> [ ... ]
> > +	if (dc_info.start < info->size) {
> > +		dev_err(dev,
> > +			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n",
> > +			dc_info.start, info->size);
> > +		return -EINVAL;
> > +	}
> 
> [Severity: High]
> Will this overlap check unconditionally fail for any valid DCD configuration?
> 
> Earlier in the execution flow, cxl_mem_dpa_fetch() initializes info->size to
> the total DPA capacity (including both static and dynamic capacity):
> 
info->size does not include dynamic capacity.

>     info->size = mds->total_bytes;
> 
> Since the DC partition is placed within this total space, dc_info.start will
> always be strictly less than the total info->size. This appears to cause a
> regression where cxl_pci_probe() silently disables DCD support.
> 
> [ ... ]
> > +	if (check_add_overflow(info->size, dc_info.size, &total)) {
> > +		dev_err(dev,
> > +			"DC partition 0 size %#llx overflows DPA space ending at %#llx\n",
> > +			dc_info.size, info->size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	info->size = total;
> 
> [Severity: High]
> If the above overlap check were bypassed, would this assignment double-count
> the dynamic capacity size?
> 
> Since info->size already includes the dynamic capacity initialized from

info->size does not include dynamic capacity.

> cxl_mem_dpa_fetch(), adding dc_info.size again to the total could cause
> cxl_dpa_setup() to allocate a dpa_res root resource larger than the physical
> device limit.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261007201828.952-1-anisa.su@samsung.com?part=2
