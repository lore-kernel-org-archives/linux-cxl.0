Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44039AD2A;
	Fri, 11 Sep 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120263; cv=pass; b=ITUXMLwQqTIhg0m5LaJ5sDdDIBsimTh6FqSFihPVeSJ9y0S/UqGS7jkPWD9hd74XhBjecynwxmHa9Iz0RcKRxSzA8+VNLNRKuWcGYMMTOeR/EeLryOngydDv2m/qOTsjim7e+FUZ5RsVCM+ap73D8gYEwfp1bsN/CL/hIbZgQR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120263; c=relaxed/simple;
	bh=ToSVAIOQ9BC3QgFJPxIVZSwDrQK6srPp9Y+SoFGbvbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkTVIlxjLmy/3HsAwVGT0T7V6ykglMkZoLpRCtkJuqpYIeM+XJkchTdxJd7nwEyS2OA+pDtz+OS7BmxADHj8D5C5hCZT9uTGCywPU+XilxrMn4dKKu2RsbXLQa9UBi5VVbgX1WrEnxi72yVtIFsvs1AQzM2nZ57jeIYq3QCQmSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=bpH8OpiT; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="bpH8OpiT"
ARC-Seal: i=1; a=rsa-sha256; t=1789120253; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TE/+1xwb0UhDQVst8myEPTFr9Vo3XHK5MAO2u90+CrweI0kmgU1hgSUwwyOOh0czRl/styCleZrrGBslVEdOc/VK1CCy7eB8woLhVRnQLYPnXv/UZ6oxvKXVH5Hqd9oMfGkrJPSmVEzSp7y0kDgzZ9I0wIsv6pzhHJ3Y9AOyrj0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789120253; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lciQTe9UDdV/aafHBwwSVe5o+VCuUmC035ZCR1bmSQ0=; 
	b=JoCrJRFzqPuesnkHsDLxEQuDVa/7RpaG1bsoJtVr0IJI1ajJsZcodSHRWIGZhfvtYJr7DmdqUZck/RxYXRuH6A6J03iVQr/5CadwI23kizjXrp4uF40lCr6Of2nEoHwuH0hNy3T/rCHiFrXzifSeUWeGR+jTit5bzLNkKCAuaqY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789120253;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=lciQTe9UDdV/aafHBwwSVe5o+VCuUmC035ZCR1bmSQ0=;
	b=bpH8OpiTsDbWCTI/RvHX4yfHe3rdtAeHp/NSbgvNbe+0bSeImjz1uNv9XaKB6QJf
	CQ95ieFyK2rvALL22zCFeEwmdLgI/dMCuSsaMyjIa69KHdwErw9yMsCd65r5gcBUiX1
	CnQMbvxEKJFkx7O9Oy/CejEUc3IfEl+H0jYADphk=
Received: by smtp.zohomail.com with SMTPS id 1789120252323130.23435788505003;
	Fri, 11 Sep 2026 02:50:52 -0700 (PDT)
Message-ID: <21cef59d-89e7-4dcc-80b6-3bba7a366b38@zohomail.com>
Date: Fri, 11 Sep 2026 17:50:49 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/regs: Reject register blocks in an unassigned BAR
To: Junjie Cao <junjie.cao@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 linux-cxl@vger.kernel.org
Cc: Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20260910093858.535969-1-junjie.cao@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260910093858.535969-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227e24a6a543f044932f81502300000faabd16482f197873deacd4e7b6abc1c6568c6dd901bf30ef7:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 9/10/2026 5:38 PM, Junjie Cao wrote:
> cxl_decode_regblock() only checks that the Register Locator offset fits
> pci_resource_len().  A BAR the PCI core could not place is reset to zero
> start, end and flags while config space keeps the firmware value, so a
> zero offset passes and the block is mapped at physical address 0.  On
> x86 ioremap() of the reserved low megabyte succeeds, the component
> register header does not match, and a switch port fails with "HDM
> decoder capability not found", pointing at the HDM decoders rather than
> at the BAR.
>
> Reject a BAR with no length or still unassigned, next to the existing size
> check.  Skip empty Register Locator entries first: they decode as BAR0
> offset 0 and would trip the check, and nothing looks them up.
>
> Seen with edk2-stable202602 (f6489621b8ae, reverted in stable202605),
> which places 64-bit non-prefetchable BARs behind a bridge in the
> prefetchable window.  Linux refuses to claim them and the switch
> upstream and downstream port BAR0s find no room in the 32-bit window.
> QEMU q35 with a CXL switch, Fedora 43 edk2-ovmf-20260213, before:
>
> pci 0000:0d:00.0: BAR 0 [mem size 0x00010000 64bit]: can't assign; no space
> cxl_port port2: HDM decoder capability not found
>
> after:
>
> pcieport 0000:0d:00.0: BAR0: not assigned (type: 1)
> cxl_port port2: No component registers mapped
> cxl_port port2: Failed to map HDM decoder capability
>
> Link: https://github.com/tianocore/edk2/issues/13104
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/regs.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 20c2d9fbcfe7..41416fa2ce4a 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -277,6 +277,20 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  	u64 offset = ((u64)reg_hi << 32) |
>  		     (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW);
>  
> +	if (reg_type == CXL_REGLOC_RBI_EMPTY)
> +		return false;
> +
> +	/*
> +	 * A BAR the PCI core could not place is reset to zero; decoding it
> +	 * would map the block at physical address 0.
> +	 */
> +	if (!pci_resource_len(pdev, bar) ||
> +	    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
> +		dev_warn(&pdev->dev, "BAR%d: not assigned (type: %d)\n", bar,
> +			 reg_type);
> +		return false;
> +	}
> +
>  	if (offset > pci_resource_len(pdev, bar)) {
>  		dev_warn(&pdev->dev,
>  			 "BAR%d: %pr: too small (offset: %pa, type: %d)\n", bar,


