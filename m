Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D88C1E87B;
	Mon, 15 Sep 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933182; cv=none; b=VFI61odWw8K1O8+JbDwFDEppFRovwN2Ky3ptzXmDjKZqcezg3CXjjEOL8njzNAZ2T7js2qtgyf2YZnNkwkSF9eJT+MhwU2i9O8G1c5oct0kCF1BRu1Vx7R29x64Delk1N+DHpREJgvkblsWqYvGJy3mcsyppSBXjtDpa3A1j6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933182; c=relaxed/simple;
	bh=FhnEPNIMRkzIGOksggj4Z5MBpCvP5ojagYiNxuMGBfU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/aE+ZIYdvp7x5yUB59B+d+i/oCM/qo309LxyuPb+8MW5yyRyCIDCKPaLTS5obZ+8a30d7sQnB3TbGlJWS3Ds7bG9dAGKrgxQtDu8iKex8pQq6j3ZIGZdRDLYbAMQSQJ4nyUkx7yDLqdUfwCcE/QoGIofc3tC5VGAYX33IDhBMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQM826nt4z6M5gY;
	Mon, 15 Sep 2025 18:43:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C1811402FB;
	Mon, 15 Sep 2025 18:46:16 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 12:46:15 +0200
Date: Mon, 15 Sep 2025 11:46:14 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 08/11] cxl/region: Implement endpoint decoder address
 translation
Message-ID: <20250915114614.000053f1@huawei.com>
In-Reply-To: <20250912144514.526441-9-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
	<20250912144514.526441-9-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 12 Sep 2025 16:45:10 +0200
Robert Richter <rrichter@amd.com> wrote:

> Systems that need address translation have the endpoint decoders
> programmed for a different address space. Host physical addresses
> (HPA) are different from their system physical addresses (SPA). The
> decoder's address range and interleaving configuration of such
> endpoints cannot be used to determine the region parameters. The
> region's address range must be SPA which the decoder does not
> provide. In addition, an endpoint's incoming HPA is already converted
> to the devices physical address (DPA). Thus it has interleaving
> disabled.
> 
> Address translation may provide different ways to determine an
> endpoint's SPA, e.g. it may support a firmware call. This allows the
> determination of the region's parameters without inspecting the
> endpoint decoders.
> 
> Implement the setup of address translation given there is a function
> to convert an endpoint's HPA (which is identical to its DPA) to an
> SPA. Use the previously introduced cxl_to_hpa_fn callback for this.
> Convert the decoder's address range and ensure it is 256MB aligned.
> 
> Identify the region's interleaving ways by inspecting the address
> ranges. Also determine the interleaving granularity using the address
> translation callback. Note that the position of the chunk from one
> interleaving block to the next may vary and thus cannot be considered
> constant. Address offsets larger than the interleaving block size
> cannot be used to calculate the granularity. Thus, probe the
> granularity using address translation for various HPAs in the same
> interleaving block.
> 
> Note that this patch does not yet enable address translation as
> callbacks have not been initialized.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 95 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 57697504410b..9fb1e9508213 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3422,16 +3422,109 @@ struct cxl_region_context {
>  	int interleave_granularity;
>  };
>  
> +static int setup_address_translation(struct cxl_endpoint_decoder *cxled,
> +				     struct cxl_region_context *ctx)
> +{
> +	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent->parent);

When there is a parent->parent it always makes me nervous that I haven't
reasoned out what port this actually is. A comment would help or
a more specific macro where the name lets us know what we are getting.

> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct range range = ctx->hpa_range;
> +	u64 spa_len, len = range_len(&range);
> +	u64 addr, base = range.start;
> +	int ways, gran;
> +
> +	if (!len || !port->to_hpa)
> +		return 0;
> +
> +	if (!IS_ALIGNED(range.start, SZ_256M) ||
> +	    !IS_ALIGNED(range.end + 1, SZ_256M)) {
> +		dev_warn(&port->dev,
> +			"CXL address translation: Unaligned decoder HPA range: %#llx-%#llx(%s)\n",
> +			range.start, range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	/* Translate HPA range to SPA. */
> +	range.start = port->to_hpa(cxld, range.start);

This is where the generic naming as 'range' gets really confusing.
hpa_range etc with separate struct range for each would definitely help

For the checks and inputs maybe just use ctx->hpa_range directly.


> +	range.end = port->to_hpa(cxld, range.end);
Perhaps use the DEFINE_RANGE macro or 
	range = (struct range) {
		.start = ...
style as per earlier patches.

> +
> +	if (range.start == ULLONG_MAX || range.end == ULLONG_MAX) {
> +		dev_warn(&port->dev,
> +			"CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			range.start, range.end, ctx->hpa_range.start,
> +			ctx->hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Since translated addresses include the interleaving
> +	 * offsets, align the range to 256 MB.

So we pass in an HPA range without interleaving offsets and get back
one with them?  Is that unavoidable, or can we potentially push
this bit into the callback?  Probably with separate callbacks to
get the interleave details.

Overall I'm not really following what is going on here.  Maybe
some ascii art would help?

> +	 */
> +	range.start = ALIGN_DOWN(range.start, SZ_256M);
> +	range.end = ALIGN(range.end, SZ_256M) - 1;
> +
> +	spa_len = range_len(&range);
> +	if (!len || !spa_len || spa_len % len) {
> +		dev_warn(&port->dev,
> +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			range.start, range.end, ctx->hpa_range.start,
> +			ctx->hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	ways = spa_len / len;
> +	gran = SZ_256;
> +
> +	/*
> +	 * Determine interleave granularity
> +	 *
> +	 * Note: The position of the chunk from one interleaving block
> +	 * to the next may vary and thus cannot be considered
> +	 * constant. Address offsets larger than the interleaving
> +	 * block size cannot be used to calculate the granularity.
> +	 */
> +	while (ways > 1 && gran <= SZ_16M) {
> +		addr = port->to_hpa(cxld, base + gran);
> +		if (addr != base + gran)
> +			break;
> +		gran <<= 1;
> +	}
> +
> +	if (gran > SZ_16M) {
> +		dev_warn(&port->dev,
> +			"CXL address translation: Cannot determine granularity: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			range.start, range.end, ctx->hpa_range.start,
> +			ctx->hpa_range.end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	ctx->hpa_range = range;
> +	ctx->interleave_ways = ways;
> +	ctx->interleave_granularity = gran;
> +
> +	dev_dbg(&cxld->dev,
> +		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
> +		dev_name(ctx->cxlmd->dev.parent), base, len, range.start,
> +		spa_len, ways, gran);
> +
> +	return 0;
> +}
> +
>  static int setup_region_params(struct cxl_endpoint_decoder *cxled,
>  			       struct cxl_region_context *ctx)
>  {
> +	int rc;
> +
>  	ctx->cxled = cxled;
>  	ctx->cxlmd = cxled_to_memdev(cxled);
>  	ctx->hpa_range = cxled->cxld.hpa_range;
>  	ctx->interleave_ways = cxled->cxld.interleave_ways;
>  	ctx->interleave_granularity = cxled->cxld.interleave_granularity;
>  
> -	return 0;
> +	rc = setup_address_translation(cxled, ctx);

A quick search suggested nothing new gets added after this. As such
	return setup_address_translation(...);
is probably appropriate here.


> +	if (rc)
> +		return rc;
> +
> +	return rc;
>  }
>  
>  static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,

