Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD619F11B
	for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981889; cv=none; b=nIxy4UVytS1P+6RiCO6K12sZbtTbtyEo1t2xXPkJpc2IeB2JjKluL1NVrdx00d8Bm+6JK5o0l55UFcGEC/cF09fQVu4y5GggbRDMTZ33S+gUK4gGrXkG1LML87RT2MmB/QK+kC6i3o5JS+R+u6PGbpV4Oqf+31Xc+G3NGJwSpyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981889; c=relaxed/simple;
	bh=ZNVjTyzbRzs1sQj2DU+KtTg3NZp0Gvrrx+gLkZ7jzmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBxkehVzussscWD0JndyIoj5Sesp1a4XAo2zDdm3BAHMDR/otIQfe4Iq7L5QIpgzqyLNc61YzxfeVyHIOT4SIe60nBNVHZXbJLmkiucgIoRGomyGvVMSs5f7CwsjpPHb6N5nrmYtaJWvFuIW5M5GJQ9pnr8aBDv/cbHXbR/lmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=STR/Ta9M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="STR/Ta9M"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso225ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779981889; x=1780586689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WNOzcXMScA76uJWwzh9BJczyYeIHAq55KZT2qzZwpSA=;
        b=STR/Ta9MMZ6VbpRH8tTohckxGXVnZXsZnpYt+lpomwV/2woOX0yjxzZwJ0T2wfnowQ
         LwA46kr6bhdhcLXTzOqdg2+ZYOuMD4Dx9zRGdBXP9FdDnHjNKO8ja7CH/Xdzor9r77GJ
         yR7M2se3jPVxSMdjQ4KBBQAhm1hDtL5Qe2gV1WlB9LmzbIqObkPEHRyGKBel4jGJEix0
         jP+sjso3mSoC3drUDhFot25SX+CgMC4BD59KIYnZrCGtskf79mq6QmSwoUIGPR2O6gOF
         O5OSNpavUcHCdOqHVvARbuNKVdjXO2suKcQXmVbjHtdW++xE3F0wGF7S9f/beTiGC7Tb
         dfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779981889; x=1780586689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNOzcXMScA76uJWwzh9BJczyYeIHAq55KZT2qzZwpSA=;
        b=rhDHe2gr8ui/UFn/pFl6Xp799Ym4V2jeEJKOXbP81JsOPcr9S/MC+NEdum1Wu+9Uui
         EVRA30PEp6pMCW4kg00R461/i9dHUKo3eMqIWSOUVZ+Itt2x7NCgTvqc9FIeKeOGCICZ
         I7AlACZ6LL8OAWnPYHATKSZ8sksntD+i36ZIvY2X8DUdIF9iArSh/wWEl5rJ94XoNI4Y
         K/K5uembp3i0JEJ/PwwTwzfqnRzsd41UCp/7qQvHqkucnHieKZUtDcsfCWA8cJuy8e0I
         7pko8izMI32qiRsWDUJToy18NpCdn7BvPrmaelQjdfdhfUiXJ9rAlVkQVSz5XkOhfUx3
         B9Hw==
X-Forwarded-Encrypted: i=1; AFNElJ9r+6Axc8fM6OUpXHfHxd6lVHkSzbF0y0hfNQ1m2dSk/JnDCAyWh501I2JYb/xlhjrET19hZerZ6Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+oEPPGVPkdS6W9uZwhGqXQJcHgmF4VyZjSF1oreKZvnOUqY69
	aAg4ARS6hwx2h9DOqpfkuKJhZxUBpK5eZkbTShaFMvw8AUPNGMKNVwpZ8YyaQ2B9lQ==
X-Gm-Gg: Acq92OG7nObxr0B5v5A9iLeJexOcK3BQJOYKVtvBUudwE8tLP0Hdj3qG9AbJ/uPDOtx
	EeTVLhRsUi5PAfdXxzDCG1z9AEFB+hyWpY7caDn5CT1ipSRlVZAXnuiVv4yVilRj0qiGrLg5cuv
	7xkYnYkyjIE8okWYkcL4mU4cO8ddsLdrhAafSmRcx+piLCFKbhUudwgc6FkzVVGp7JrpOvjEDIo
	XdpZBaGyqGzjaHvF4dWSsjVJ+sitl9AJlyFjniqeIerukoIuirWULwCciuHEEoMC5oMwfTJaK0K
	kuvPMU1x3NaQj9FKrqevMw7oXec+b7V8UeSkEpc2wlmKS0Lo+lV8C0QlhNw4IkBw6REaYXSwXYc
	BrGeYEOB7vOWdA+Ww8Gn5fOheu7s+zvU8GhhCd4LrCb0sf17CF+YL7Xfe2zMz4ng6SOIxSTw2Wl
	v5k7V4mNF1r0G+iFtnPQoUsgUtl1/H7wpnDQEh/bOALYwOFDOSlouni56AaTcW8oScy3nd
X-Received: by 2002:a17:902:d50f:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bf0bb6f798mr1375375ad.0.1779981888366;
        Thu, 28 May 2026 08:24:48 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beff36894dsm28676365ad.37.2026.05.28.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 08:24:47 -0700 (PDT)
Date: Thu, 28 May 2026 15:24:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	bhelgaas@google.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <ahheOF8L0aGMttcI@google.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>

On Thu, May 21, 2026 at 01:34:22PM -0700, Nicolin Chen wrote:
> When a device's default substream attaches to an identity domain, the SMMU
> driver currently sets the device's STE between two modes:
> 
>   Mode 1: Cfg=Translate, S1DSS=Bypass, EATS=1
>   Mode 2: Cfg=bypass (EATS is ignored by HW)
> 
> When there is an active PASID (non-default substream), mode 1 is used. And
> when there is no PASID support or no active PASID, mode 2 is used.
> 
> The driver will also downgrade an STE from mode 1 to mode 2, when the last
> active substream becomes inactive.
> 
> However, there are PCIe devices that demand ATS to be always on. For these
> devices, their STEs have to use the mode 1 as HW ignores EATS with mode 2.
> 
> Change the driver accordingly:
>   - always use the mode 1
>   - never downgrade to mode 2
>   - allocate and retain a CD table (see note below)
> 
> Note that these devices might not support PASID, i.e. doing non-PASID ATS.
> In such a case, the ssid_bits is set to 0. However, s1cdmax must be set to
> a !0 value in order to keep the S1DSS field effective. Thus, when a master
> requires ats_always_on, set its s1cdmax to at least 1, meaning that the CD
> table will have a dummy entry (SSID=1) that will never be used.
> 
> Now for these devices, arm_smmu_cdtab_allocated() will always return true,
> v.s. false prior to this change. When its default substream is attached to
> an IDENTITY domain, its first CD is NULL in the table, which is a totally
> valid case. Thus, add "!master->ats_always_on" to the condition.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
> Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 81 ++++++++++++++++++---
>  2 files changed, 73 insertions(+), 9 deletions(-)
>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

>  
> +static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
> +{
> +	bool s1p = master->smmu->features & ARM_SMMU_FEAT_TRANS_S1;
> +	unsigned int stu = __ffs(master->smmu->pgsize_bitmap);
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (!dev_is_pci(master->dev))
> +		return 0;
> +	pdev = to_pci_dev(master->dev);
> +
> +	if (!arm_smmu_ats_supported(master)) {
> +		if (pci_ats_required(pdev)) {
> +			dev_err_once(master->dev, "SMMU doesn't support ATS\n");
> +			return -EOPNOTSUPP;
> +		}
> +		return 0;
> +	}
> +
> +	ret = pci_prepare_ats(pdev, stu);
> +	if (ret || !pci_ats_required(pdev))
> +		return ret;
> +
> +	/*
> +	 * S1DSS is required for ATS to be always on for identity domain cases.
> +	 * However, the S1DSS field is ignored if !IDR0_S1P or !IDR1_SSIDSIZE.
> +	 */
> +	if (!s1p || !master->smmu->ssid_bits) {
> +		dev_err_once(master->dev,
> +			     "SMMU doesn't support ATS to be always on\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	master->ats_always_on = true;
> +
> +	return arm_smmu_alloc_cd_tables(master);

Nit: I'm not sure if I'm getting this right, are we saying we *need* to
allocate CDs for CXL.cache cases in the probe itself because STE.EATS
requires Config=Translate with S1DSS in bypass?

Does this imply that active transactions can be occurring *before* the
first domain attach? Are 

Thanks,
Praan
