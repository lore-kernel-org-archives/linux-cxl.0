Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A151D14A0B5
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691458; cv=none; b=UQ6rl0wXZcBtQVMLpAcdkGK0GUGXuU29rnZ8Ak222WzG2Z7IRf3j3t/c0muiNMKn8ts60CE/RoLqw43sDkO+l+7tsIV0LGWDM5A3VrJ4aWZKLrHjXL1KeeZhwBZZHWchz1HRL0Hdjd9JG3pANMO3Mv4/yuAsM5SSIm8G9tVaoak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691458; c=relaxed/simple;
	bh=g70fGEddO1z25y21tWcEj6XwdWfUtaki4zt7L2ZA+i4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq2abviO9CMd8zk4osXWVZ6ETKNzT2oPYv+ByrhVG9JQQPzxOnXNYUBiP8vXFZjiT41+//SIyUP1ROWQN+F3h7Dv0j494TmGsYv9myKFzSTDaYcf92Nc8ZfJqKmzpn77MtxBYr5XiE6K16O+r+tQolRuFrbYz24KwX5wF1Vnxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACoqjMmL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACoqjMmL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f0444b478so15041105ad.0
        for <linux-cxl@vger.kernel.org>; Tue, 04 Feb 2025 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738691456; x=1739296256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7XQVFK4MVHFsURN/wvackj5qXpAtPHa2T2XmMDEuAPE=;
        b=ACoqjMmLhjcFXFAipoQJ+QRa45iN9iqpmqqYopmgU2VbZPbTfTFC7IR5Zp7scbz2JQ
         VmmQBkBQ298293KRepuJ5Rd7r92wS1KjPgX3WBYUwyy7n8VPG9dPjqhjMhucs55GBIhY
         JS+76g0+Za64hxF9oqYi6PHYJiCu8OEOQfVlAA1nln6tkvCYhcXXStn3TuSQpjVAyXGq
         z2VcmRSdJOSx690uD2fAQUW7i4kVS8PwoBOpUhEcrhMQygrljHTrOuwD0DHG5N63TH0q
         0WLvkqHovHEktAOUPZBBgG9zr6kcA94LWxX4rqRI1ROMdX6u6FBs+gUuQPdjbP5GvysN
         xS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738691456; x=1739296256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XQVFK4MVHFsURN/wvackj5qXpAtPHa2T2XmMDEuAPE=;
        b=eqDj+r8zAkZGrj9AGNEzAEP8MIWR3dAqnxe38YhWSvRiwaxylQp1pP1u1Bof0yp9wx
         GJ+TfQY8fUY1k3u8wsuP3eHDST/fODD/Fsury9edvtsfqxZW/UPu6BpLHw9v+94XCadZ
         4iIL1+MESlZUbmlQJFGQOJZ+PGtlgaRgi/nyDvyFFAocm8vR96GLyY/FXfGgC+qOTO1d
         QNsZGAyIyvFg8jbfC4tr+zjlwHOdXbD6piKkozeQ9SSIb2MstlifNEgcX+I6fDGZwBtq
         cN2p1uBsxxMGIJCkmF/fw85H1A8JAl+BqhHOsl6YsPgDvICOTHmdccYY6/UthQdprIGU
         0mXA==
X-Gm-Message-State: AOJu0Yw/Zk58Zxnli9rHE+46dCR5FMmqd+5nUrwAc5LJ8A2jH73PzMY+
	egx6p78fFI4u8d1AQNS8HI9y1U0NDwW/Z5JC4PhHwaZB/BhoL7JF
X-Gm-Gg: ASbGncvAHdzGNjil7fPQR1YCWxGFrGuF0YxUN8BAuAxFB2PDzgidpoRoZxMkAVr+2Rr
	p/uE3yxhEahNSp6H8ULLMCsWDu56c/4ZoTKcb0s+bmQvPGusBEqpW1PJ/xysAaGdiOxpGD9DplW
	19MoctYZCp4D6/+VNOdT6oPFaDNRcwfJbd66uR3kKplSDcW3VsaLi8892MNSJbtrbqqbBS6QDdn
	pCYlUgnpCx/RnAOekXWS/puGpdjehCho4av1a4/mHXdQ7apayDZ+U3ZHQTUydKIUhop3SfeDji/
	qrIF
X-Google-Smtp-Source: AGHT+IFPMJRyLPyUxqbpNGqlNt/9G7sbJq9MlyCEPSt2HQZYtEZFIK8W/4LydyMiQ8zLCc8+aKc6uQ==
X-Received: by 2002:a05:6a21:6b02:b0:1e1:bf3d:a191 with SMTP id adf61e73a8af0-1ed7a6b7a37mr42378858637.33.1738691455565;
        Tue, 04 Feb 2025 09:50:55 -0800 (PST)
Received: from fan ([2601:646:8f03:9fee:3af:557f:e46f:e624])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6427548sm11106509b3a.60.2025.02.04.09.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:50:55 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 4 Feb 2025 09:50:50 -0800
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Alejandro Lucero <alucerop@amd.com>,
	Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v3 2/6] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Message-ID: <Z6JTep2iMQZiGTaF@fan>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
 <173864305238.668823.16553986866633608541.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173864305238.668823.16553986866633608541.stgit@dwillia2-xfh.jf.intel.com>

On Mon, Feb 03, 2025 at 08:24:12PM -0800, Dan Williams wrote:
> In preparation for consolidating all DPA partition information into an
> array of DPA metadata, introduce helpers that hide the layout of the
> current data. I.e. make the eventual replacement of ->ram_res,
> ->pmem_res, ->ram_perf, and ->pmem_perf with a new DPA metadata array a
> no-op for code paths that consume that information, and reduce the noise
> of follow-on patches.
> 
> The end goal is to consolidate all DPA information in 'struct
> cxl_dev_state', but for now the helpers just make it appear that all DPA
> metadata is relative to @cxlds.
> 
> As the conversion to generic partition metadata walking is completed,
> these helpers will naturally be eliminated, or reduced in scope.
> 
> Cc: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/cdat.c      |   71 +++++++++++++++++++++++++++---------------
>  drivers/cxl/core/hdm.c       |   26 ++++++++-------
>  drivers/cxl/core/mbox.c      |   18 ++++++-----
>  drivers/cxl/core/memdev.c    |   42 +++++++++++++------------
>  drivers/cxl/core/region.c    |   10 ++++--
>  drivers/cxl/cxlmem.h         |   58 ++++++++++++++++++++++++++++++----
>  drivers/cxl/mem.c            |    2 +
>  tools/testing/cxl/test/cxl.c |   25 ++++++++-------
>  8 files changed, 162 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 8153f8d83a16..797baad483cb 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -258,27 +258,36 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>  static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
>  				     struct xarray *dsmas_xa)
>  {
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	struct device *dev = cxlds->dev;
> -	struct range pmem_range = {
> -		.start = cxlds->pmem_res.start,
> -		.end = cxlds->pmem_res.end,
> -	};
> -	struct range ram_range = {
> -		.start = cxlds->ram_res.start,
> -		.end = cxlds->ram_res.end,
> -	};
>  	struct dsmas_entry *dent;
>  	unsigned long index;
> +	const struct resource *partition[] = {
> +		to_ram_res(cxlds),
> +		to_pmem_res(cxlds),
> +	};
> +	struct cxl_dpa_perf *perf[] = {
> +		to_ram_perf(cxlds),
> +		to_pmem_perf(cxlds),
> +	};
>  
>  	xa_for_each(dsmas_xa, index, dent) {
> -		if (resource_size(&cxlds->ram_res) &&
> -		    range_contains(&ram_range, &dent->dpa_range))
> -			update_perf_entry(dev, dent, &mds->ram_perf);
> -		else if (resource_size(&cxlds->pmem_res) &&
> -			 range_contains(&pmem_range, &dent->dpa_range))
> -			update_perf_entry(dev, dent, &mds->pmem_perf);
> -		else
> +		bool found = false;
> +
> +		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> +			const struct resource *res = partition[i];
> +			struct range range = {
> +				.start = res->start,
> +				.end = res->end,
> +			};
> +
> +			if (range_contains(&range, &dent->dpa_range)) {
> +				update_perf_entry(dev, dent, perf[i]);
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found)
>  			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
>  				&dent->dpa_range);
>  	}
> @@ -304,6 +313,9 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
>  
>  static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>  {
> +	if (!dpa_perf)
> +		return;
> +
>  	*dpa_perf = (struct cxl_dpa_perf) {
>  		.qos_class = CXL_QOS_CLASS_INVALID,
>  	};
> @@ -312,6 +324,9 @@ static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>  static bool cxl_qos_match(struct cxl_port *root_port,
>  			  struct cxl_dpa_perf *dpa_perf)
>  {
> +	if (!dpa_perf)
> +		return false;
> +
>  	if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
>  		return false;
>  
> @@ -346,7 +361,8 @@ static int match_cxlrd_hb(struct device *dev, void *data)
>  static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_dpa_perf *ram_perf = to_ram_perf(cxlds),
> +			    *pmem_perf = to_pmem_perf(cxlds);
>  	struct cxl_port *root_port;
>  	int rc;
>  
> @@ -359,17 +375,17 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  	root_port = &cxl_root->port;
>  
>  	/* Check that the QTG IDs are all sane between end device and root decoders */
> -	if (!cxl_qos_match(root_port, &mds->ram_perf))
> -		reset_dpa_perf(&mds->ram_perf);
> -	if (!cxl_qos_match(root_port, &mds->pmem_perf))
> -		reset_dpa_perf(&mds->pmem_perf);
> +	if (!cxl_qos_match(root_port, ram_perf))
> +		reset_dpa_perf(ram_perf);
> +	if (!cxl_qos_match(root_port, pmem_perf))
> +		reset_dpa_perf(pmem_perf);
>  
>  	/* Check to make sure that the device's host bridge is under a root decoder */
>  	rc = device_for_each_child(&root_port->dev,
>  				   cxlmd->endpoint->host_bridge, match_cxlrd_hb);
>  	if (!rc) {
> -		reset_dpa_perf(&mds->ram_perf);
> -		reset_dpa_perf(&mds->pmem_perf);
> +		reset_dpa_perf(ram_perf);
> +		reset_dpa_perf(pmem_perf);
>  	}
>  
>  	return rc;
> @@ -574,20 +590,23 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>  					       enum cxl_decoder_mode mode)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_dpa_perf *perf;
>  
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
> -		perf = &mds->ram_perf;
> +		perf = to_ram_perf(cxlds);
>  		break;
>  	case CXL_DECODER_PMEM:
> -		perf = &mds->pmem_perf;
> +		perf = to_pmem_perf(cxlds);
>  		break;
>  	default:
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	if (!perf)
> +		return ERR_PTR(-EINVAL);
> +
>  	if (!dpa_perf_contains(perf, cxled->dpa_res))
>  		return ERR_PTR(-EINVAL);
>  
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index b7f6a2d69f78..48b26d3dad26 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,9 +327,9 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> -	if (resource_contains(&cxlds->pmem_res, res))
> +	if (resource_contains(to_pmem_res(cxlds), res))
>  		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(&cxlds->ram_res, res))
> +	else if (resource_contains(to_ram_res(cxlds), res))
>  		cxled->mode = CXL_DECODER_RAM;
>  	else {
>  		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
> @@ -442,11 +442,11 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	 * Only allow modes that are supported by the current partition
>  	 * configuration
>  	 */
> -	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
> +	if (mode == CXL_DECODER_PMEM && !cxl_pmem_size(cxlds)) {
>  		dev_dbg(dev, "no available pmem capacity\n");
>  		return -ENXIO;
>  	}
> -	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
> +	if (mode == CXL_DECODER_RAM && !cxl_ram_size(cxlds)) {
>  		dev_dbg(dev, "no available ram capacity\n");
>  		return -ENXIO;
>  	}
> @@ -464,6 +464,8 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	struct device *dev = &cxled->cxld.dev;
>  	resource_size_t start, avail, skip;
>  	struct resource *p, *last;
> +	const struct resource *ram_res = to_ram_res(cxlds);
> +	const struct resource *pmem_res = to_pmem_res(cxlds);
>  	int rc;
>  
>  	down_write(&cxl_dpa_rwsem);
> @@ -480,37 +482,37 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  		goto out;
>  	}
>  
> -	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
> +	for (p = ram_res->child, last = NULL; p; p = p->sibling)
>  		last = p;
>  	if (last)
>  		free_ram_start = last->end + 1;
>  	else
> -		free_ram_start = cxlds->ram_res.start;
> +		free_ram_start = ram_res->start;
>  
> -	for (p = cxlds->pmem_res.child, last = NULL; p; p = p->sibling)
> +	for (p = pmem_res->child, last = NULL; p; p = p->sibling)
>  		last = p;
>  	if (last)
>  		free_pmem_start = last->end + 1;
>  	else
> -		free_pmem_start = cxlds->pmem_res.start;
> +		free_pmem_start = pmem_res->start;
>  
>  	if (cxled->mode == CXL_DECODER_RAM) {
>  		start = free_ram_start;
> -		avail = cxlds->ram_res.end - start + 1;
> +		avail = ram_res->end - start + 1;
>  		skip = 0;
>  	} else if (cxled->mode == CXL_DECODER_PMEM) {
>  		resource_size_t skip_start, skip_end;
>  
>  		start = free_pmem_start;
> -		avail = cxlds->pmem_res.end - start + 1;
> +		avail = pmem_res->end - start + 1;
>  		skip_start = free_ram_start;
>  
>  		/*
>  		 * If some pmem is already allocated, then that allocation
>  		 * already handled the skip.
>  		 */
> -		if (cxlds->pmem_res.child &&
> -		    skip_start == cxlds->pmem_res.child->start)
> +		if (pmem_res->child &&
> +		    skip_start == pmem_res->child->start)
>  			skip_end = skip_start - 1;
>  		else
>  			skip_end = start - 1;
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 548564c770c0..3502f1633ad2 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1270,24 +1270,26 @@ static int add_dpa_res(struct device *dev, struct resource *parent,
>  int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct resource *ram_res = to_ram_res(cxlds);
> +	struct resource *pmem_res = to_pmem_res(cxlds);
>  	struct device *dev = cxlds->dev;
>  	int rc;
>  
>  	if (!cxlds->media_ready) {
>  		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> -		cxlds->ram_res = DEFINE_RES_MEM(0, 0);
> -		cxlds->pmem_res = DEFINE_RES_MEM(0, 0);
> +		*ram_res = DEFINE_RES_MEM(0, 0);
> +		*pmem_res = DEFINE_RES_MEM(0, 0);
>  		return 0;
>  	}
>  
>  	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
>  
>  	if (mds->partition_align_bytes == 0) {
> -		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
>  				 mds->volatile_only_bytes, "ram");
>  		if (rc)
>  			return rc;
> -		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
> +		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
>  				   mds->volatile_only_bytes,
>  				   mds->persistent_only_bytes, "pmem");
>  	}
> @@ -1298,11 +1300,11 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  		return rc;
>  	}
>  
> -	rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> +	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
>  			 mds->active_volatile_bytes, "ram");
>  	if (rc)
>  		return rc;
> -	return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
> +	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
>  			   mds->active_volatile_bytes,
>  			   mds->active_persistent_bytes, "pmem");
>  }
> @@ -1450,8 +1452,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->cxlds.reg_map.host = dev;
>  	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> -	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
> -	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
> +	to_ram_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
> +	to_pmem_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
>  
>  	return mds;
>  }
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index ae3dfcbe8938..c5f8320ed330 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -80,7 +80,7 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(&cxlds->ram_res);
> +	unsigned long long len = resource_size(to_ram_res(cxlds));
>  
>  	return sysfs_emit(buf, "%#llx\n", len);
>  }
> @@ -93,7 +93,7 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	unsigned long long len = resource_size(&cxlds->pmem_res);
> +	unsigned long long len = cxl_pmem_size(cxlds);
>  
>  	return sysfs_emit(buf, "%#llx\n", len);
>  }
> @@ -198,16 +198,20 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  	int rc = 0;
>  
>  	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
> -	if (resource_size(&cxlds->pmem_res)) {
> -		offset = cxlds->pmem_res.start;
> -		length = resource_size(&cxlds->pmem_res);
> +	if (cxl_pmem_size(cxlds)) {
> +		const struct resource *res = to_pmem_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>  		if (rc)
>  			return rc;
>  	}
> -	if (resource_size(&cxlds->ram_res)) {
> -		offset = cxlds->ram_res.start;
> -		length = resource_size(&cxlds->ram_res);
> +	if (cxl_ram_size(cxlds)) {
> +		const struct resource *res = to_ram_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>  		/*
>  		 * Invalid Physical Address is not an error for
> @@ -409,9 +413,8 @@ static ssize_t pmem_qos_class_show(struct device *dev,
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  
> -	return sysfs_emit(buf, "%d\n", mds->pmem_perf.qos_class);
> +	return sysfs_emit(buf, "%d\n", to_pmem_perf(cxlds)->qos_class);
>  }
>  
>  static struct device_attribute dev_attr_pmem_qos_class =
> @@ -428,9 +431,8 @@ static ssize_t ram_qos_class_show(struct device *dev,
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  
> -	return sysfs_emit(buf, "%d\n", mds->ram_perf.qos_class);
> +	return sysfs_emit(buf, "%d\n", to_ram_perf(cxlds)->qos_class);
>  }
>  
>  static struct device_attribute dev_attr_ram_qos_class =
> @@ -466,11 +468,11 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf = to_ram_perf(cxlmd->cxlds);
>  
> -	if (a == &dev_attr_ram_qos_class.attr)
> -		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
> -			return 0;
> +	if (a == &dev_attr_ram_qos_class.attr &&
> +	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> +		return 0;
>  
>  	return a->mode;
>  }
> @@ -485,11 +487,11 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_dpa_perf *perf = to_pmem_perf(cxlmd->cxlds);
>  
> -	if (a == &dev_attr_pmem_qos_class.attr)
> -		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
> -			return 0;
> +	if (a == &dev_attr_pmem_qos_class.attr &&
> +	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> +		return 0;
>  
>  	return a->mode;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 34aa3d45fafa..6706a1b79549 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2701,7 +2701,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  
>  	if (ctx->mode == CXL_DECODER_RAM) {
>  		offset = ctx->offset;
> -		length = resource_size(&cxlds->ram_res) - offset;
> +		length = cxl_ram_size(cxlds) - offset;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>  		if (rc == -EFAULT)
>  			rc = 0;
> @@ -2713,9 +2713,11 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
>  		length = resource_size(&cxlds->dpa_res) - offset;
>  		if (!length)
>  			return 0;
> -	} else if (resource_size(&cxlds->pmem_res)) {
> -		offset = cxlds->pmem_res.start;
> -		length = resource_size(&cxlds->pmem_res);
> +	} else if (cxl_pmem_size(cxlds)) {
> +		const struct resource *res = to_pmem_res(cxlds);
> +
> +		offset = res->start;
> +		length = resource_size(res);
>  	} else {
>  		return 0;
>  	}
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..78e92e24d7b5 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -423,8 +423,8 @@ struct cxl_dpa_perf {
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
> - * @pmem_res: Active Persistent memory capacity configuration
> - * @ram_res: Active Volatile memory capacity configuration
> + * @_pmem_res: Active Persistent memory capacity configuration
> + * @_ram_res: Active Volatile memory capacity configuration
>   * @serial: PCIe Device Serial Number
>   * @type: Generic Memory Class device or Vendor Specific Memory device
>   * @cxl_mbox: CXL mailbox context
> @@ -438,13 +438,41 @@ struct cxl_dev_state {
>  	bool rcd;
>  	bool media_ready;
>  	struct resource dpa_res;
> -	struct resource pmem_res;
> -	struct resource ram_res;
> +	struct resource _pmem_res;
> +	struct resource _ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
>  	struct cxl_mailbox cxl_mbox;
>  };
>  
> +static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> +{
> +	return &cxlds->_ram_res;
> +}
> +
> +static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> +{
> +	return &cxlds->_pmem_res;
> +}
> +
> +static inline resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
> +{
> +	const struct resource *res = to_ram_res(cxlds);
> +
> +	if (!res)
> +		return 0;
> +	return resource_size(res);
> +}
> +
> +static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
> +{
> +	const struct resource *res = to_pmem_res(cxlds);
> +
> +	if (!res)
> +		return 0;
> +	return resource_size(res);
> +}
> +
>  static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>  {
>  	return dev_get_drvdata(cxl_mbox->host);
> @@ -471,8 +499,8 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
> - * @ram_perf: performance data entry matched to RAM partition
> - * @pmem_perf: performance data entry matched to PMEM partition
> + * @_ram_perf: performance data entry matched to RAM partition
> + * @_pmem_perf: performance data entry matched to PMEM partition
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -496,8 +524,8 @@ struct cxl_memdev_state {
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
>  
> -	struct cxl_dpa_perf ram_perf;
> -	struct cxl_dpa_perf pmem_perf;
> +	struct cxl_dpa_perf _ram_perf;
> +	struct cxl_dpa_perf _pmem_perf;
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> @@ -505,6 +533,20 @@ struct cxl_memdev_state {
>  	struct cxl_fw_state fw;
>  };
>  
> +static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> +
> +	return &mds->_ram_perf;
> +}
> +
> +static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
> +
> +	return &mds->_pmem_perf;
> +}
> +
>  static inline struct cxl_memdev_state *
>  to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>  {
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 2f03a4d5606e..9675243bd05b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -152,7 +152,7 @@ static int cxl_mem_probe(struct device *dev)
>  		return -ENXIO;
>  	}
>  
> -	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> +	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>  		rc = devm_cxl_add_nvdimm(parent_port, cxlmd);
>  		if (rc) {
>  			if (rc == -ENODEV)
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index cc8948f49117..9654513bbccf 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1000,25 +1000,28 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  		find_cxl_root(port);
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
> -	struct range pmem_range = {
> -		.start = cxlds->pmem_res.start,
> -		.end = cxlds->pmem_res.end,
> +	const struct resource *partition[] = {
> +		to_ram_res(cxlds),
> +		to_pmem_res(cxlds),
>  	};
> -	struct range ram_range = {
> -		.start = cxlds->ram_res.start,
> -		.end = cxlds->ram_res.end,
> +	struct cxl_dpa_perf *perf[] = {
> +		to_ram_perf(cxlds),
> +		to_pmem_perf(cxlds),
>  	};
>  
>  	if (!cxl_root)
>  		return;
>  
> -	if (range_len(&ram_range))
> -		dpa_perf_setup(port, &ram_range, &mds->ram_perf);
> +	for (int i = 0; i < ARRAY_SIZE(partition); i++) {
> +		const struct resource *res = partition[i];
> +		struct range range = {
> +			.start = res->start,
> +			.end = res->end,
> +		};
>  
> -	if (range_len(&pmem_range))
> -		dpa_perf_setup(port, &pmem_range, &mds->pmem_perf);
> +		dpa_perf_setup(port, &range, perf[i]);
> +	}
>  
>  	cxl_memdev_update_perf(cxlmd);
>  
> 

-- 
Fan Ni
