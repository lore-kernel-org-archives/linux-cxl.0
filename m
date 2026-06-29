Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063C831715A;
	Mon, 29 Jun 2026 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782709834; cv=pass; b=hFCBC1D6CGgZBy5qMXfuLOOnkcVBM0thAAbv32/pku0wUXkXjPZMcmGizVb19/DL0Y8H2WpQ2+JDis8fTVe2ebFXOYOB3C4yrYIZ51GbKjLNs7f0A3x+5UrOtx9qTQORefyQiMAHkc4670Y2jkbnyBgaul2l7sBnBHhCvPNMb5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782709834; c=relaxed/simple;
	bh=bD9f57xsAiVfOtbHUiaWC1q8I0l1c2o7RTn86YDVQg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSalqfkj4iRQJ+6+mN/D5XNqqG6qyPHXDuinfqyxIM7RgY8H9Pl6/GiXT4CCW0FvlW/MIAGm6gtmmWOqzV5pR7Oo7ciW1BNOeFneT6T7e+T0CkViEwSA5RIMgJXEOahLv982R3IjhereYZkcgfXv2bx5gOW+tfZKjqSr8Y+ENTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=IXYWzFhV; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="IXYWzFhV"
ARC-Seal: i=1; a=rsa-sha256; t=1782709822; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U5W71jgHCKaLHJ61aSweRcneuNBL5b6xpUFMrPxdiHFk1tVOI9ku5R/cCebGXPkFmVZWSYUu2kExxo3pTa595aqJblgdupq5ju6HKj2eqS4Fkvq0qxJ7vVkWGbM4gebGCx/jyq3DygZYK6NrmCPMaPKMyLyxm+ZZJ4FUtLHk9JY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782709822; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UiZXRfdEnCmADAn4fSbmIQX/bxz1A97Cgn4UDy+uALY=; 
	b=LLAWF6BYMKkv3H6iXwksBamGdkb8+59ZlmtLMgtGir1FANRZzdgeauNo/z5iyepwz1FvNamdjqaMBHrJQcDfZs9n6597lGI/5V/tHQH+P7GtHojmlUUdlchPdGivQtMuLYi+JanusGuZtDKDjIIiXMRh6uagG7jsOwmShtCU2XU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782709822;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=UiZXRfdEnCmADAn4fSbmIQX/bxz1A97Cgn4UDy+uALY=;
	b=IXYWzFhVqK/AIsqWc3lFNk+HgLMoD5vco9MG/qW5mS6oqTOTbjMDQC4+TMmrFaUo
	ZJT1WagvzobdxJJQbAPq3K2Ke0voF1FRSIqJNC+3kLihO6Ih8Jdcj02eR/jybvv4ZVK
	FwcidoQLV3P+9S5mzLqx7r/j9nTtbf3lU4STotak=
Received: by mx.zohomail.com with SMTPS id 1782709819953752.1714346267053;
	Sun, 28 Jun 2026 22:10:19 -0700 (PDT)
Message-ID: <6563cbc0-22c9-44a7-bb9f-59cdc0c717c5@zohomail.com>
Date: Mon, 29 Jun 2026 13:10:13 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/pci: Remove incorrect mbox.valid check in
 cxl_pci_type3_init_mailbox()
To: Wei Hou <wei.hou@scaleflux.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 linux-kernel@vger.kernel.org, Kobayashi <koba@nvidia.com>,
 Kaiheng Feng <kaihengf@nvidia.com>, Newton Liu <newtonl@nvidia.com>,
 Kristin Chen <kristinc@nvidia.com>, Mochs <mochs@nvidia.com>,
 Dan Williams <danwilliams@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>
References: <20260618170356.25382-1-wei.hou@scaleflux.com>
 <20260628155857.239866-1-wei.hou@scaleflux.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260628155857.239866-1-wei.hou@scaleflux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227a5687ee7626781f4f69da85100002ac443d5a5b67f7ebfbc3283d36ac8231a2f2561e63dfe350d:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 6/28/2026 11:58 PM, Wei Hou wrote:
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

Good catch!

Reviewed-by: Li Ming <ming.li@zohomail.com>

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


