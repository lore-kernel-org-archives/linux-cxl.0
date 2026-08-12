Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFC41A504
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535864; cv=pass; b=NTbLww7gigmULQ+2sCRqW779kiDoKUlJ6HdF6XSkSBamPyR4LqVbZ9MYp4wlznqbPDMismWB6n1ROs1IwxILrTlFc0stwPIgrIpekj9LHPQu485ltZCOdKZ25TTnDGm9O6L1+sqELW/mpyZDkZKyVEeIJM/2GlSiwh5lDU2zGmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535864; c=relaxed/simple;
	bh=GvpdE7D6qJ5TVTCsLq1mfgmDE3v/TqJZG3W1x53mIaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Se+o+pf2rQhcyzAYJc1DWp7QvZd0rby4J2bGbLt3byRWloIunt7hzcywnVsN9ni/ZGTy4ht/iqiH02mL97PCdVy32VE0Ki7OznXzO76/t/vV5PcKLPnADrYCCShp78BRjypDfjxqC7WC4x7R6ooQNjEyngP9alVM9cXpYzUz7Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=RNWpHcp2; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="RNWpHcp2"
ARC-Seal: i=1; a=rsa-sha256; t=1786535849; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=asHSRhsbL9br+vDR2Sksdi0T3m4/evo0K7XvyIVZds1EeJsGefNVugdFVqGS1xOFttjcj/oIHOCN/csn/jAUvdFKA3Jpyo3Tm6UMl4J8Rrk2qp7lC4vKRVowEmn/SBN9Efd1Y7oRqNznLzllOow3aHD+j5FfTI5KC3GUPrtENTY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786535849; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UVcQmTNJ21god7+C7V2rmBe84Dd3/TNI8fyfme9c8Fk=; 
	b=k1DAWnqrtQcB/+X8Vqb3NRvMU/Fd1cYLWEAAugDzvdVJ5qADQ4+FAVbG9prh3nvnakgxTKCAdljWl2wrw5AV2gHXzC49g2LK8zSDwlO+8KRSitQNToGvS+gQG18oInju5UgPl61HwhL8F7a8mqsQC4UM0cbnYMOtkzAm3L0eJtw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786535849;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=UVcQmTNJ21god7+C7V2rmBe84Dd3/TNI8fyfme9c8Fk=;
	b=RNWpHcp2UvMldR2dlmK4uFifNkmmsYsH54bJ5a4mhkULPprXQcB/4LENyDLU6qad
	ZRM9KcDlinVF1/IiTa38+lGrrpuGo+NO5dPcopZ/8Cih2mjPZnDbf7OFIhEp1mU5O5/
	p5NxiQt4XlRH7pawYvdp+X8YetltftLWpQw3swsk=
Received: by mx.zohomail.com with SMTPS id 1786535847312909.0031718743978;
	Wed, 12 Aug 2026 04:57:27 -0700 (PDT)
Message-ID: <b23308d4-05e2-47bb-941d-df5ea584b052@zohomail.com>
Date: Wed, 12 Aug 2026 19:57:21 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/region: Unregister the pmem region bridge on setup
 failure
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <20260812061043.57319-1-kanie@linux.alibaba.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260812061043.57319-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227b7783cee2692afd1136319a800000adf425de1e3a39c573b0aa856ac472000a572e22947ca2fbb:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/8/12 14:10, Guixin Liu 写道:
> devm_cxl_add_pmem_region() publishes the cxl_pmem_region with device_add()
> and only afterwards, under the nvdimm bridge's device lock, arranges for
> its removal - and only if the bridge has a driver bound. If it does not,
> the function sets -ENXIO and leaves through err_bridge, which drops the
> reference this function took on the bridge and returns. The device that
> was just added has no owner at that point: no device_del(), no
> put_device(), and no devm action to do either later. The sibling failure,
> a devm_add_action_or_reset() that cannot allocate, is already covered,
> because devm_add_action_or_reset() runs cxlr_pmem_unregister() itself on
> that path.
>
> An unbound bridge is a normal state, not an error state. The bridge is
> unbound whenever cxl_pmem is unloaded or its device is detached through
> sysfs, and a region can be probed in that window.
>
> The added device then stays in sysfs, along with the reference it holds on
> the region, until the module is unloaded. cxlr->cxlr_pmem still points at
> it, and worse, the name is still taken: a later probe of the same region
> allocates a second cxl_pmem_region and fails in device_add() on the
> duplicate "pmem_region%d", so once this has happened the region can no
> longer be brought up at all.
>
> Call cxlr_pmem_unregister() on that branch. It is invoked from inside the
> scoped_guard() that holds the bridge's device lock, which is what its
> device_lock_assert() requires, and it performs the same teardown the devm
> action would have performed, including clearing cxlr->cxlr_pmem, so
> err_bridge is left with only the bridge reference to drop.
>
> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
> This was patch 8/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
> issues are already fixed in cxl/next.
>
> v1->v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>    the code change (Alison Schofield)
>
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
>
>   drivers/cxl/core/region_pmem.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/region_pmem.c b/drivers/cxl/core/region_pmem.c
> index 23d97e3d78b6..7ab1373a95e0 100644
> --- a/drivers/cxl/core/region_pmem.c
> +++ b/drivers/cxl/core/region_pmem.c
> @@ -168,12 +168,14 @@ int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>   		dev_name(dev));
>   
>   	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxl_nvb->dev.driver)
> +		if (cxl_nvb->dev.driver) {
>   			rc = devm_add_action_or_reset(&cxl_nvb->dev,
>   						      cxlr_pmem_unregister,
>   						      cxlr_pmem);
> -		else
> +		} else {
>   			rc = -ENXIO;
> +			cxlr_pmem_unregister(cxlr_pmem);
> +		}
>   	}
>   
>   	if (rc)
>
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
