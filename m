Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5138562A
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536208; cv=none; b=eGc0bGN3CCMmDA1qb5y3gWsiVjfASYUF8sasEN0RvjzPr8pgG7ZGQKQQvqPXCjKgGRuBGsXsuB1jiqbrFjkbeBFykaskzIDW52lY1gW6l54lLXUHIaGq1O0mcw/cCuIgv+D4ud09LevUQETVcU5LD+fPDrGPU3XvkKeWCdGQQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536208; c=relaxed/simple;
	bh=fnXB8S5VZJKMcjWqrfZdCFsapJTaey7YRtV0BU9KxBE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4qv4nRfXTo+baPN3jaga4GZKeXm27jpaY2O0VwjGyjxVCFKPZUs/zD+xgm+zhxyhYUhxjhNdcAOEeXK8dTTQ4a7TXYCSt+B8ncGnoJ6HEQRPRWSqqGv39Dgb0cXDcr9lxmnjNXbE6bJCvBV2Dg5yFy2yJ4jyNbit9H2CcWINak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VLcCC3cFPz6K8yR;
	Fri, 19 Apr 2024 22:16:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C03EB140B30;
	Fri, 19 Apr 2024 22:16:40 +0800 (CST)
Received: from localhost (10.48.153.65) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 15:16:40 +0100
Date: Fri, 19 Apr 2024 15:16:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jim.harris@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/core/region: check interleave capability
Message-ID: <20240419151638.000011e3@Huawei.com>
In-Reply-To: <20240409022621.29115-1-yaoxt.fnst@fujitsu.com>
References: <20240409022621.29115-1-yaoxt.fnst@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  8 Apr 2024 22:26:21 -0400
Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:

> Since interleave capability is not checked, a target can be attached to
> region successfully even it does not support the interleave way or
> interleave granularity.
> 
> When accessing the memory, unexpected behavior occurs due to converting
> HPA to an error DPA:
> $ numactl -m 2 ls
> Segmentation fault (core dumped)

I'd drop this comment - a real device should have rejected the capacity.
We don't need the kernel change log to point out the qemu emulation is buggy :)

> 
> Link: https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fujitsu.com
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
A few minor things mostly around naming.

Jonathan

> ---
>  drivers/cxl/core/hdm.c    |  5 ++++
>  drivers/cxl/core/region.c | 51 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  drivers/cxl/cxlmem.h      |  1 +
>  4 files changed, 59 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..5ac79d843a16 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -79,6 +79,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(11, 8);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..abc14fe1717e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1210,6 +1210,41 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	unsigned int interleave_mask;
> +	u8 eiw;
> +	u16 eig;
> +	int rc, start_pos, stop_pos;
> +
> +	rc = ways_to_eiw(iw, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cxlhdm->iw_cap_mask & BIT(iw)))
> +		return -EOPNOTSUPP;
> +
> +	rc = granularity_to_eig(ig, &eig);
> +	if (rc)
> +		return rc;
> +
> +	if (eiw >= 8)
> +		start_pos = eiw + eig - 1;
> +	else
> +		start_pos = eiw + eig + 7;
> +	stop_pos = eig + 8;

I'd like to see a comment with a specification reference for this
maths.  Probably the implementation note which oddly ended up in 
8.2.20.13 Decoder Protection. in r3.1

> +	if (stop_pos > start_pos)
> +		return 0;
> +
> +	interleave_mask = GENMASK(start_pos, stop_pos);

I'd use high_pos and low_pos to avoid ambiguity around start
and stop and which is which (I thought this was backwards at first glance)

> +	if ((interleave_mask & cxlhdm->interleave_mask) != interleave_mask)
This is effectively checking for one not contained in the other. Can use
the perhaps simpler check of is the interleave_mask no overlapping with everything
outside of cxlhdm->interleave_mask

	if (interleave_mask & ~cxlhd->interleave_mask)
I think...

> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1360,6 +1395,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  			return -ENXIO;
>  		}
>  	} else {
> +		rc = check_interleave_cap(cxld, iw, ig);
> +		if (rc) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s iw: %d ig: %d is not supported\n",
> +				dev_name(port->uport_dev),
> +				dev_name(&port->dev), iw, ig);
> +			return rc;
> +		}
>  		cxld->interleave_ways = iw;
>  		cxld->interleave_granularity = ig;
>  		cxld->hpa_range = (struct range) {
> @@ -1796,6 +1839,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_dport *dport;
>  	int rc = -ENXIO;
>  
> +	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> +				  p->interleave_granularity);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
> +			dev_name(&cxled->cxld.dev), p->interleave_ways,
> +			p->interleave_granularity);
> +		return rc;
> +	}
>  	if (cxled->mode != cxlr->mode) {
>  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
>  			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 534e25e2f0a4..da8a487ededa 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -45,6 +45,8 @@
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 20fb3b35e89e..1ec3e6285d41 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -853,6 +853,7 @@ struct cxl_hdm {
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
> +	unsigned int iw_cap_mask;
>  	struct cxl_port *port;
>  };
>  

