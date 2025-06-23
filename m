Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954281DD543;
	Mon, 23 Jun 2025 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675919; cv=none; b=LTPnc1fcK0wjskH8y6F1JbjiaLuJyqExO9//vkhCAufW6j01R1ogu4zm6EsQpglNA2tdpW4aiksF4jVC2XeV/MNe+h+AC5RwR9165rjHb3U9mPRPFxlGkmpnlgqOWqEkx4w+f90RpGJTD0aUGhDPrlyfKh5/kAgbSxn+2Br/+YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675919; c=relaxed/simple;
	bh=0XU8MvGtflyTb8Qyclt6Swc20R9/zSrAQiqlaey2a84=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0e063cyUqO9wtWQaz/tZn3f4YfB5ShsDisRiiyPQR/8LBrNwZHz9FAI4JLuTQuOfcAvD8UGZLr3t7yCKesk35n9iCVNb1bbAcWFVJnBYardiyUQl8BoQ3JLsASoMZq+BozsP2FvlGBXP+WFWsFCn7Rg+I9CLclJ1r/gxYMmiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQlFg6yrxz6HJtS;
	Mon, 23 Jun 2025 18:49:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C7F8E1404C5;
	Mon, 23 Jun 2025 18:51:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 12:51:54 +0200
Date: Mon, 23 Jun 2025 11:51:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/8] cxl/decoder: Move decoder register programming
 to a helper
Message-ID: <20250623115152.00005aba@huawei.com>
In-Reply-To: <20250619050416.782871-4-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
	<20250619050416.782871-4-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 18 Jun 2025 22:04:11 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for converting to rw_semaphore_acquire semantics move the
> contents of an open-coded {down,up}_read(&cxl_dpa_rwsem) section to a
> helper function.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Seems reasonable.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c | 77 +++++++++++++++++++++++-------------------
>  1 file changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index ab1007495f6b..81556d12e9b8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -764,14 +764,53 @@ static int cxld_await_commit(void __iomem *hdm, int id)
>  	return -ETIMEDOUT;
>  }
>  
> +static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
> +{
> +	int id = cxld->id;
> +	u64 base, size;
> +	u32 ctrl;
> +
> +	/* common decoder settings */
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +	cxld_set_interleave(cxld, &ctrl);
> +	cxld_set_type(cxld, &ctrl);
> +	base = cxld->hpa_range.start;
> +	size = range_len(&cxld->hpa_range);
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +
> +	if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> +		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> +		u64 targets;
> +
> +		cxlsd_set_targets(cxlsd, &targets);
> +		writel(upper_32_bits(targets), tl_hi);
> +		writel(lower_32_bits(targets), tl_lo);
> +	} else {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> +		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> +
> +		writel(upper_32_bits(cxled->skip), sk_hi);
> +		writel(lower_32_bits(cxled->skip), sk_lo);
> +	}
> +
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +}
> +
>  static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  {
>  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	int id = cxld->id, rc;
> -	u64 base, size;
> -	u32 ctrl;
>  
>  	if (cxld->flags & CXL_DECODER_F_ENABLE)
>  		return 0;
> @@ -804,39 +843,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  	}
>  
>  	down_read(&cxl_dpa_rwsem);
> -	/* common decoder settings */
> -	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> -	cxld_set_interleave(cxld, &ctrl);
> -	cxld_set_type(cxld, &ctrl);
> -	base = cxld->hpa_range.start;
> -	size = range_len(&cxld->hpa_range);
> -
> -	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> -	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> -	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> -
> -	if (is_switch_decoder(&cxld->dev)) {
> -		struct cxl_switch_decoder *cxlsd =
> -			to_cxl_switch_decoder(&cxld->dev);
> -		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> -		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> -		u64 targets;
> -
> -		cxlsd_set_targets(cxlsd, &targets);
> -		writel(upper_32_bits(targets), tl_hi);
> -		writel(lower_32_bits(targets), tl_lo);
> -	} else {
> -		struct cxl_endpoint_decoder *cxled =
> -			to_cxl_endpoint_decoder(&cxld->dev);
> -		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> -		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> -
> -		writel(upper_32_bits(cxled->skip), sk_hi);
> -		writel(lower_32_bits(cxled->skip), sk_lo);
> -	}
> -
> -	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	setup_hw_decoder(cxld, hdm);
>  	up_read(&cxl_dpa_rwsem);
>  
>  	port->commit_end++;

