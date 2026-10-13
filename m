Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0097C39890A
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872948; cv=pass; b=lDxo8FcmHq3h97cc1A292h1keK16dv3e8gLCytELVSr/l3NX+QeTSOMTXCUa7FirEyPJVQPzxcRZjBAfAZQP7AZHrk6eU0I2OBWRQ5RWQrie7OcpHPdlFSnoeOWmgrvpAIuLpEThTZGtK+Ep6VwB/FSMJDfSXjLi9arC+fVFiSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872948; c=relaxed/simple;
	bh=sGYMb9c8JBK/Wnc/qcEb9ctEXwxqR8ocT7P/+JzSw54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sg1C7pU0jJ3OXNJb+Pb0Q79zphojc7U0eNun6Tyh8BCP1mtrpJNGxx2kGr8wEfJrHX8XibQZynQvnQo+jq3a2PrXNwWd3Sra+/G4WKeKt6XvW4F0Vd7CIVHiRVrfm4r+UzvtY2lnTgU+FGT56W6VyFTUSvk29oaGMdO+a7Lodgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=VSkEqnla; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="VSkEqnla"
ARC-Seal: i=1; a=rsa-sha256; t=1791872936; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jI/kZHGzlRwEiX8+SYeDRWtJwWCssACODHAcGDa93TDSrzYDvQsP8lsWIQH+SX2anXAoie0GTmLLKCRVnG6VeWi2CqefCP706eAeNqHjb6Hj8B8a4EeXcCILMAh8rVNykOoU8WR047jkeybozaZx0pEp4wTH32D3NeXSAWUHX8s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791872936; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FhWH2AgINojBTGdKh49pWJc8w2n91zEI8f95F074PI4=; 
	b=hglDZqhdMuV6nzxa+NzM/fTvQKjR4hZtRDeXlW5RKIegvbNtqfQ1aygywjgv8fJlg2JQGn9f4YB4QotnwySNsRPkAFbaaDBlAHF3R8W4+B9jX7HN555Rrd8weT2CikLC5A7dVgukGEWvBZ6Yp4zxaF8ZyCeeUZ2yhrPSnOMucUw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791872936;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=FhWH2AgINojBTGdKh49pWJc8w2n91zEI8f95F074PI4=;
	b=VSkEqnlaqebXVCW88Pgx5TMYcxUC9MBtc7R9cma2lY6GOhDISS0Zdrx9SJQYlXES
	yZ8i/XUXSDCKXvFNJHlRK8JVfbA7ctzG0vJBSgevg2Q3aPsXlUwRP46hoYqS05vvUOo
	B18WB3t0GJLyvOahpwi2DM9kKh2dbHJ7P+FXkxY0=
Received: by smtp.zohomail.com with SMTPS id 1791872934927602.0221859735208;
	Mon, 12 Oct 2026 23:28:54 -0700 (PDT)
Message-ID: <71de0f68-6f0c-49c4-ba23-4c2c86577fce@zohomail.com>
Date: Tue, 13 Oct 2026 14:28:50 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] cxl: Add interleave encoding validity helpers
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1791860305.git.alison.schofield@intel.com>
 <17c9c350c9e579cbc059b02e0e22ed513c54d468.1791860305.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <17c9c350c9e579cbc059b02e0e22ed513c54d468.1791860305.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112273fccf60f63b7f016dd0a9b5f000002e98d53070ab786d81c686a470d9f19bbdf7e00eaf5d9e8ee:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/13 12:25, Alison Schofield 写道:
> Some callers of ways_to_eiw(), granularity_to_eig(), and
> eig_to_granularity() only need to determine whether an input is valid,
> but must provide storage for a converted value that is then discarded.
> This obscures the purpose of the call and requires unnecessary temporary
> variables.
>
> Define and use new helpers that provide a validation-only interface for
> those callers.
>
> cxl_port_setup_targets() also encodes and then decodes its calculated
> granularity solely to validate it. Calculate the granularity directly
> and validate it instead, making the calculation explicit and removing
> the encode/decode round trip.
>
> No functional change.
>
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/region.c | 49 +++++++++++++--------------------------
>   drivers/cxl/cxl.h         | 21 +++++++++++++++++
>   2 files changed, 37 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb..bc087ca63946 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -493,11 +493,9 @@ static int set_interleave_ways(struct cxl_region *cxlr, int val)
>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>   	struct cxl_region_params *p = &cxlr->params;
>   	int save, rc;
> -	u8 iw;
>   
> -	rc = ways_to_eiw(val, &iw);
> -	if (rc)
> -		return rc;
> +	if (!ways_valid(val))
> +		return -EINVAL;
>   
>   	/*
>   	 * Even for x3, x6, and x12 interleaves the region interleave must be a
> @@ -566,12 +564,9 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>   	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>   	struct cxl_region_params *p = &cxlr->params;
> -	int rc;
> -	u16 ig;
>   
> -	rc = granularity_to_eig(val, &ig);
> -	if (rc)
> -		return rc;
> +	if (!granularity_valid(val))
> +		return -EINVAL;
>   
>   	/*
>   	 * When the host-bridge is interleaved, disallow region granularity !=
> @@ -1451,8 +1446,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   	struct cxl_decoder *cxld = cxl_rr->decoder;
>   	struct cxl_switch_decoder *cxlsd;
>   	struct cxl_port *iter = port;
> -	u16 eig, peig;
> -	u8 eiw, peiw;
>   
>   	/*
>   	 * While root level decoders support x3, x6, x12, switch level
> @@ -1524,48 +1517,38 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   		parent_iw = parent_cxld->interleave_ways;
>   	}
>   
> -	rc = granularity_to_eig(parent_ig, &peig);
> -	if (rc) {
> +	if (!granularity_valid(parent_ig)) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
>   			dev_name(parent_port->uport_dev),
>   			dev_name(&parent_port->dev), parent_ig);
> -		return rc;
> +		return -EINVAL;
>   	}
>   
> -	rc = ways_to_eiw(parent_iw, &peiw);
> -	if (rc) {
> +	if (!ways_valid(parent_iw)) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
>   			dev_name(parent_port->uport_dev),
>   			dev_name(&parent_port->dev), parent_iw);
> -		return rc;
> +		return -EINVAL;
>   	}
>   
>   	iw = cxl_rr->nr_targets;
> -	rc = ways_to_eiw(iw, &eiw);
> -	if (rc) {
> +	if (!ways_valid(iw)) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
>   			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> -		return rc;
> +		return -EINVAL;
>   	}
>   
>   	/*
>   	 * Interleave granularity is a multiple of @parent_port granularity.
>   	 * Multiplier is the parent port interleave ways.
>   	 */
> -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> -	if (rc) {
> +	ig = parent_ig * parent_iw;
> +
> +	if (!granularity_valid(ig)) {
>   		dev_dbg(&cxlr->dev,
>   			"%s: invalid granularity calculation (%d * %d)\n",
>   			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return rc;
> -	}
> -
> -	rc = eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> +		return -EINVAL;
>   	}
>   
>   	if (iw > 8 || iw > cxlsd->nr_targets) {
> @@ -3131,13 +3114,13 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
>    */
>   int cxl_validate_translation_params(u8 eiw, u16 eig, int pos)
>   {
> -	int ways, gran;
> +	int ways;
>   
>   	if (eiw_to_ways(eiw, &ways)) {
>   		pr_debug("%s: invalid eiw=%u\n", __func__, eiw);
>   		return -EINVAL;
>   	}
> -	if (eig_to_granularity(eig, &gran)) {
> +	if (!eig_valid(eig)) {
>   		pr_debug("%s: invalid eig=%u\n", __func__, eig);
>   		return -EINVAL;
>   	}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d96210b8f147..8f0a79e7b8ab 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -146,6 +146,27 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>   	return 0;
>   }
>   
> +static inline bool eig_valid(u16 eig)
> +{
> +	int granularity;
> +
> +	return eig_to_granularity(eig, &granularity) == 0;
> +}
> +
> +static inline bool granularity_valid(int granularity)
> +{
> +	u16 eig;
> +
> +	return granularity_to_eig(granularity, &eig) == 0;
> +}
> +
> +static inline bool ways_valid(unsigned int ways)
> +{
> +	u8 eiw;
> +
> +	return ways_to_eiw(ways, &eiw) == 0;
> +}
> +
>   /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
>   #define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
>   #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
