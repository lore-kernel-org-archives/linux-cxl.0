Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738D19D8A8
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593398; cv=none; b=UuvOUu7w34OulTp3mTU9D65ExrE+6AsMSUvZiFbg1XWcFiZOn3w0el73n1tvnprbk/WnyseAFxUeWGh+Gji6fAspN5crlirb+94jBZgg5I0OPH5PgPRcLkwM1d393gBiaSY/vo4/hV7u+31dv01OGDlp8o3Z2vdMhPda9svutmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593398; c=relaxed/simple;
	bh=ysE/bHWLAhgqeWElnMLEx+akh2fdF5hh+GHnVq9y3d4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9rwxaOOSEJcKszH/y9ngKJArmwGPtLp6r3XGz3+TancHBunsXMMYA9tR7sLwNXdYIWE2qxfGnoK6Z2XD/g5QiDn7MHiI13o96SEcIcjjuO51rIDR5y3kTLroc/TK83HOOXsz7dAYjnepcboSVfqTQE6k2guge0LwMEqHRUIYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvSYB02KNz6JBT5;
	Wed,  5 Jun 2024 21:12:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 715461409EA;
	Wed,  5 Jun 2024 21:16:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 14:16:32 +0100
Date: Wed, 5 Jun 2024 14:16:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <jim.harris@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5] cxl/region: check interleave capability
Message-ID: <20240605141631.00006b54@Huawei.com>
In-Reply-To: <20240524092740.4260-1-yaoxt.fnst@fujitsu.com>
References: <20240524092740.4260-1-yaoxt.fnst@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 24 May 2024 05:27:40 -0400
Yao Xingtao <yaoxt.fnst@fujitsu.com> wrote:

> Since interleave capability is not verified, if the interleave
> capability of a target does not match the region need, committing decoder
> should have failed at the device end.
> 
> In order to checkout this error as quickly as possible, driver needs
> to check the interleave capability of target during attaching it to
> region.
> 
> According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
> Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
> Capability Register' indicate the capability to establish interleaving
> in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
> be attached to a region utilizing such interleave ways.
> 
> Additionally, bits 8 and 9 in the same register represent the capability
> of the bits used for interleaving in the address, Linux tracks this in the
> cxl_port interleave_mask.
> 
> Regarding 'Decoder Protection':
> If IW is less than 8 (for interleave ways of 1, 2, 4, 8, 16), the
> interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1.
> 
> If the IW is greater than or equal to 8 (for interleave ways of 3, 6, 12),
> the interleave bits start at bit position IG + 8 and end at IG + IW - 1.
> 
> If the interleave mask is insufficient to cover the required interleave
> bits, the target cannot be attached to the region.
> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Hi Yao,

A few comments inline.
Jonathan

> ---
>  drivers/cxl/core/hdm.c    | 10 +++++
>  drivers/cxl/core/region.c | 83 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 +
>  drivers/cxl/cxlmem.h      |  1 +
>  4 files changed, 96 insertions(+)

>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..6b7400313cb2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1054,6 +1054,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  	struct cxl_decoder *cxld;
>  	unsigned long index;
>  	int rc = -EBUSY;
> +	struct cxl_switch_decoder *cxlsd;
Could reduces scope of this...
>  
>  	lockdep_assert_held_write(&cxl_region_rwsem);
>  
> @@ -1101,6 +1102,23 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  	}
>  	cxld = cxl_rr->decoder;
>  
> +	/*
> +	 * the number of targets should not exceed the target_count
> +	 * of the decoder
> +	 */
> +	if (is_switch_decoder(&cxld->dev)) {

		struct cxl_switch_decoder *cxlsd =
			to_switch_decoder(&cxld->dev);

> +		cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +		if (cxl_rr->nr_targets > cxlsd->nr_targets) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s %s add: %s:%s @ %d overflows targets: %d\n",
> +				dev_name(port->uport_dev), dev_name(&port->dev),
> +				dev_name(&cxld->dev), dev_name(&cxlmd->dev),
> +				dev_name(&cxled->cxld.dev), pos,
> +				cxlsd->nr_targets);

set rc?

> +			goto out_erase;
> +		}
> +	}
> +
>  	rc = cxl_rr_ep_add(cxl_rr, cxled);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev,
> @@ -1210,6 +1228,53 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
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
> +	int rc, high_pos, low_pos;
> +
> +	rc = ways_to_eiw(iw, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
> +		return -ENXIO;
> +
> +	rc = granularity_to_eig(ig, &eig);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Per CXL specification (8.2.3.20.13 Decoder Protection in r3.1)

8.2.4.20.13 I think

> +	 * if eiw < 8, the interleave bits start at bit position eig + 8, and
> +	 * end at eig + eiw + 8 - 1.
> +	 * if eiw >= 8, the interleave bits start at bit position eig + 8, and
> +	 * end at eig + eiw - 1.
> +	 */
> +	if (eiw >= 8)
> +		high_pos = eiw + eig - 1;
> +	else
> +		high_pos = eiw + eig + 7;
> +	low_pos = eig + 8;
> +	/*
> +	 * when the eiw is 0 or 8 (interlave way is 1 or 3), the num of

interleave

> +	 * interleave bits is 0, there is no interleaving, the following
> +	 * check is ignored.

If the interleave is 3 there is no interleave?  That seems an odd statement
perhaps make that comment more detailed.
My understanding is that it's just more complex and all bits are relevant.

> +	 */
> +	if (low_pos > high_pos)
> +		return 0;
> +
> +	interleave_mask = GENMASK(high_pos, low_pos);
> +	if (interleave_mask & ~cxlhdm->interleave_mask)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1360,6 +1425,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
> +
>  		cxld->interleave_ways = iw;
>  		cxld->interleave_granularity = ig;
>  		cxld->hpa_range = (struct range) {
> @@ -1796,6 +1870,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
> +
>  	if (cxled->mode != cxlr->mode) {
>  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
>  			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);

