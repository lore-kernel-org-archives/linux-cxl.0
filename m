Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55515B966
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642375; cv=none; b=dyjw7tKnxmLWSzckrwhkySQo8qA8MVhtH/cPZCx/3WPKEpQU1BD4uMr1qPvrNCa8OuUJeWfqoec0kO0CNhVLtyqgy+hQBbLg9/bq5t1SlOfVicKivumu4ufB7fy2pLP8LwJ2goJgadgcPKz38rI6ZybBTReju+2ETQNRExVqv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642375; c=relaxed/simple;
	bh=WHveyJ20wxhfoESLpsERR5XVOJOTO0WYH3E4mLe02Zw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6ecg6E7hC68q2tBjLyJe87E/bqcOgHwdcb3R16Iu37/4SwKEbKUPLS88ZTo/4BARk15SnKn4YqUOPgX7VThz9zsjCBbuniLzj6z5D53LBFwAt9zwTuT9o4SvuZ0MSfayjFh7SzrfybFfRIibidRv3eAAsxbX1+IPZ2jEBMpQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W2wT664fNz6JBSP;
	Tue, 18 Jun 2024 00:34:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 01A22140B3C;
	Tue, 18 Jun 2024 00:39:28 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 17 Jun
 2024 17:39:27 +0100
Date: Mon, 17 Jun 2024 17:39:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v13 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Message-ID: <20240617173926.00003b84@Huawei.com>
In-Reply-To: <20240617043702.62028-2-kobayashi.da-06@fujitsu.com>
References: <20240617043702.62028-1-kobayashi.da-06@fujitsu.com>
	<20240617043702.62028-2-kobayashi.da-06@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 17 Jun 2024 13:37:01 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1 
> device link status information. By caching it, avoid the walking 
> memory map area to find the offset when output the register value.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Hi.

One minor style change inline. With that done,
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..a5d1ae09bded 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -505,6 +505,67 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb)
>  	return offset;
>  }
>  
> +resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct cxl_dport *dport)
> +{
> +	resource_size_t rcrb = dport->rcrb.base;
> +	void __iomem *addr;
> +	u32 cap_hdr;
> +	u16 offset;
> +
> +	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
> +		return CXL_RESOURCE_NONE;
> +
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr) {
> +		dev_err(dev, "Failed to map region %pr\n", addr);
> +		release_mem_region(rcrb, SZ_4K);
> +		return CXL_RESOURCE_NONE;
> +	}
> +
> +	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));
> +	cap_hdr = readl(addr + offset);
> +	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) != PCI_CAP_ID_EXP) {
> +		offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
> +		if (offset == 0 || offset > SZ_4K) {
> +			offset = 0;
> +			break;
> +		}
> +		cap_hdr = readl(addr + offset);
> +	}
> +
> +	iounmap(addr);
> +	release_mem_region(rcrb, SZ_4K);
> +	if (offset > 0)
> +		return offset;
> +	else
> +		return CXL_RESOURCE_NONE;

Have the error handling case first

	if (!offset)
		return CXL_RESOURCE_NONE;

	return offset; 
> +}

