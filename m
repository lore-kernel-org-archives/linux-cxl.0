Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDC3209
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211855; cv=none; b=Opft6qRub0G0HxF/CIYxQnMovZ1F1QE9Yv75Zs+n6chDxyYettjV8s774ep6xDg92MUQezS4Y5iH2coDL5fawfvOk60VHeD83ow0c4c9ZIowTU/WdZVXLNhU+fr/vegz/HKZOBjyFIggKvFeXy9jgN36EHQYcQydixaBKSuID1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211855; c=relaxed/simple;
	bh=Une8fDI2LFHObDgLO7UtuEIBq49iBlsstc7APLm2siY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XenDv4GcZEFJmIcy0rREsn3VDJeZKoekElghlGSgdLQoo/egy3/tQFUOOEeDB5CL/bGQqeMYXwYexhT8potZg7T7VRdJZikaOtEJK88rQZvZoLp6ZLmnyOYTIFM9REIrNSZcAt+5LOjwrntTIXWiXEVhqJYGGtoSeQD+WkrNLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iilwh/Vd; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iilwh/Vd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718211854; x=1749747854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Une8fDI2LFHObDgLO7UtuEIBq49iBlsstc7APLm2siY=;
  b=iilwh/VdrPCAwW2F83HX+q2rkVA1PiqIfme6Y8+adOb/Nf1uVQgfvPh4
   G70BYizRqhbeeOuQds2MUd54hgryOyDQxnI6aK6vbqe7m7C/46Dhm1h28
   Cao0+oMsmZRM/bCAoFUdHGT8tF9VwNCy4RO7yb0CgAiQ99FtnRNgWnvkV
   PTUJy4CLHFv9KgokZTW8t6anYB/CU0qFa2YGIeFRVnYpB49ZNsUxcsfrs
   j4GJVRb2ga7Yh7+SudxxpCSDDQQyP9ChjmSTnOYdKlCD/53v77vzc4sbD
   gzvq8Ljqr4nR4/iJuAiTUaMvsC7j9k2daz9ZlfPWSCTO7gHUK6XCW1DpR
   A==;
X-CSE-ConnectionGUID: OJhLeVpVSzet3p0IvldftQ==
X-CSE-MsgGUID: iD8CtVI4QBGC8RExW83e/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15118164"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="15118164"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 10:04:14 -0700
X-CSE-ConnectionGUID: NTdIKMWcQf6jsxZS6DZGBQ==
X-CSE-MsgGUID: 6pyEvUF7SFS9iGhsjvOfaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="39959463"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.20.178])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 10:04:12 -0700
Date: Wed, 12 Jun 2024 10:04:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, jim.harris@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7] cxl/region: check interleave capability
Message-ID: <ZmnVCxoMissgIPxA@aschofie-mobl2>
References: <20240612032544.39149-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612032544.39149-1-yaoxt.fnst@fujitsu.com>

On Tue, Jun 11, 2024 at 11:25:44PM -0400, Yao Xingtao wrote:
> Since interleave capability is not verified, if the interleave
> capability of a target does not match the region need, committing decoder
> should have failed at the device end.

This needs some fixups to pass the cxl unit tests. 

snip...

>  
> +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);

Tried this out with cxl-test and NULL ptr deref trying to load
the cxl-test module. Needs something like this:

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3482248aa344..f7ed3dd19992 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -630,11 +630,13 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port,
                                          struct cxl_endpoint_dvsec_info *info)
 {
        struct cxl_hdm *cxlhdm = devm_kzalloc(&port->dev, sizeof(*cxlhdm), GFP_KERNEL);
+       struct device *dev = &port->dev;

        if (!cxlhdm)
                return ERR_PTR(-ENOMEM);

        cxlhdm->port = port;
+       dev_set_drvdata(dev, cxlhdm);
        return cxlhdm;
 }


After that, we do load the cxl-test module but the autoconf region
fails to set up and other unit tests fail trying to setup regions.
I didn't go further into those, seems all failing here:

cxl_region_attach()
	dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
                       dev_name(&cxled->cxld.dev), p->interleave_ways,
                       p->interleave_granularity);


-- Alison

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
> +	 * Per CXL specification r3.1(8.2.4.20.13 Decoder Protection),
> +	 * if eiw < 8:
> +	 *   DPAOFFSET[51: eig + 8] = HPAOFFSET[51: eig + 8 + eiw]
> +	 *   DPAOFFSET[eig + 7: 0]  = HPAOFFSET[eig + 7: 0]
> +	 *
> +	 *   when the eiw is 0, all the bits of HPAOFFSET[51: 0] are used, the
> +	 *   interleave bits are none.
> +	 *
> +	 * if eiw >= 8:
> +	 *   DPAOFFSET[51: eig + 8] = HPAOFFSET[51: eig + eiw] / 3
> +	 *   DPAOFFSET[eig + 7: 0]  = HPAOFFSET[eig + 7: 0]
> +	 *
> +	 *   when the eiw is 8, all the bits of HPAOFFSET[51: 0] are used, the
> +	 *   interleave bits are none.
> +	 */
> +	if (eiw == 0 || eiw == 8)
> +		return 0;
> +
> +	if (eiw > 8)
> +		high_pos = eiw + eig - 1;
> +	else
> +		high_pos = eiw + eig + 7;
> +	low_pos = eig + 8;
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
> @@ -1360,6 +1431,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
> @@ -1796,6 +1876,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 036d17db68e0..dc8e46a1fe82 100644
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
> index 36cee9c30ceb..7fe617122d33 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -848,11 +848,21 @@ static inline void cxl_mem_active_dec(void)
>  
>  int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>  
> +/*
> + * struct cxl_hdm - HDM Decoder registers and cached / decoded capabilities
> + * @regs: mapped registers, see devm_cxl_setup_hdm()
> + * @decoder_count: number of decoders for this port
> + * @target_count: for switch decoders, max downstream port targets
> + * @interleave_mask: interleave granularity capability, see check_interleave_cap()
> + * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
> + * @port: mapped cxl_port, see devm_cxl_setup_hdm()
> + */
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
> +	unsigned long iw_cap_mask;
>  	struct cxl_port *port;
>  };
>  
> -- 
> 2.37.3
> 
