Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253F826E71E
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291888; cv=none; b=C4mZsZ+WOXnTX00ZDf17R3nhxCjKhHKCrmMHuxAxizqRflhDjtKOW8BgVx0oPDt1b1+MbzA4KPjpOjJsy7aPGG1xgql4DYL7w1OedJYcjmvg9DjJF0iXJ0L8Vtoro1cA8TGva6JQG45xcpEqvUF8/jZW9O8nX/RP6DTqq1/6ajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291888; c=relaxed/simple;
	bh=wgdmngmQ/G9YBBGIMbPCdpgCFH3fXTQExaX2DEjg4do=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnDv22XZozygTBAvPxo7mlInS/IuqhkyPcDiv12TaTfk36yDDmjW7BBAKVnDmAq8eSUBKTLuw7czrXGjClm3UUhFbC+OyRAEZFGqVenEqs0nrZ2rLWokusrYBwANMmP+ZCg2Ff1PgexmKShtlpDL/4aA/xE5t3oSWHcPfSWsaRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3B0mMXn; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3B0mMXn"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c713f37c2so158506eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 02:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782291885; x=1782896685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PTj+e/CMdSSvzWYs4zs41PqUf9nmBw56F9DD4zOMWcw=;
        b=U3B0mMXn351YtUZQA76dT5qA/Z0MQJX1gA0N5zwJ7i4T5HWlFzkFJvI/Obm7eVMl5q
         xAbsmwMMuiIwzYcomV5EEX0wxQ3vpMuAoRdvvcB37qD/IxmsX9pYAhtYbqzMGYifY+Xz
         h8l+tTPCQMDdD6RbArNE/QxVG5kT61rzIRNXQW/LbGReDJp3ooe9EcV/zJjWTgHSKbYC
         wSUBdfs47R3VFCCiZYeUJX3dcExCULV31akJACyxkwyhotAIX+KC5kAxu8ewkDyl4as+
         RdBTYZZhbEgX1RVhziWqBqfuTjHm6Y3yVgEgp7r3sd+UdppDsqYOarnIQKyfqD31S09d
         EKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782291885; x=1782896685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTj+e/CMdSSvzWYs4zs41PqUf9nmBw56F9DD4zOMWcw=;
        b=WA46zn5dfnrl7F6HZgHjyG2PScLiPE7h0hUjNl/SrPEBBHiHbVVc0sEVOXRdZLE1s6
         /oIThkUQr50o+n3ZiFtfzW3MLp4qD1Q4/eZ7MfcwPeu7oLbS0JoR5Wqbcuxy1yj22i+n
         UTBchdkn4GGtCkvFSXsTmJoDp1QID+abDKUp27iy0J63INoK+HKIKnr3cKn1lPGlQ5Ib
         kFZMrxLNKnXZRtunKHqs6CH+etoAaKnkpsFTjOn0ZMUqBzCqE0C50xT6fSfGKCe7zHbF
         VgWGBEJc+htHobkbP0zYv97VfvEfe1KQJDixi/inK69Y5AzAJ+r+CJJR+actqLKgQ8Yb
         OR8g==
X-Gm-Message-State: AOJu0Yzt23Lgc/S6u6KnVwOSVFApkm7ww6VTRdJz36ahQUWb0unHo/9h
	5NncCXUQtO1caCRslnYqnW6iLeRolTYHv3rtnHnWWE0CmvA4d+UT1oex
X-Gm-Gg: AfdE7cm1RBsmjo6/xc8EbqCitaSeuyOy+xzwzyE3EDAzNV135JYMVIgT8KS6ZGBRgVj
	dC99TAcDdejmtObmfSzjLPrU1OmeiYgyddDCuM1+y3FQprzcAHR4L4KrsogaljdIvWQ1JVR96bb
	4ydBeiB4GH216ctxSlArh9BfHN9rHMcZ4Wg12X7mwUhuxRp7D9rTRz4tUCcPHHuhNwKUKT46dAa
	Dx3YklBi9lzN8NpC59FFcausLTDyhuxmMNWrCdnDi5pYfuQv5FlukV45+QDcfjqehxM8ZE6GNhI
	AK+XEBqmadwqhi5S/igdJYDJfixqPiwDA8rYXgUHSlMFhO68cV9vKDUgWXI6sC7VLzbj/B9bVoZ
	mTQPp7kpqQOQDyjo5U7P+T6A0VKIDB05k+HyjzmQeMOFtTkK6MVzIT1oTaUTl++HKs1x5qRPKmK
	/LJ1HTM5jKD3QYSo2eIrQZN5ilHoUpcgTYlsa19240s6f3xXetX0prUq05g0kzYsFs6cde
X-Received: by 2002:a05:7300:7313:b0:304:cd0d:9ea5 with SMTP id 5a478bee46e88-30c555526ecmr6393906eec.7.1782291885030;
        Wed, 24 Jun 2026 02:04:45 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c71dbed2fsm1700715eec.10.2026.06.24.02.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 02:04:44 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 24 Jun 2026 02:04:43 -0700
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v10 16/31] cxl/extent: Validate DC extent partition
Message-ID: <ajudq0RENqSrcYmV@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <def526ee51b647e9256c7e777c6b7bd5cd647f89.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <def526ee51b647e9256c7e777c6b7bd5cd647f89.1779528761.git.anisa.su@samsung.com>

On Sat, May 23, 2026 at 02:43:10AM -0700, Anisa Su wrote:
> Extend cxl_validate_extent() — the per-extent check of the add pipeline
> to check partition membership.
> 
> Resolves an extent's DPA to its containing DC partition. Then based on
> if the partition is shareable:
> 
>   - Shareable: tag must be non-null and shared_extn_seq must be non-zero
>     — multiple hosts reading the same allocation rely on the device-
>     stamped 1..n sequence to assemble extents in agreed order.
>   - Non-sharable: shared_extn_seq must be zero — sequencing is
>     meaningless when only one host consumes the allocation; tag is
>     optional (null UUID permitted).
> 
> Any cross-mix is a device firmware bug; reject the extent.
> 
> Based on patches by John Groves.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Groves <John@Groves.net>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> 
> ---
> Changes:
> [anisa: split out as a separate validation step]
> ---
>  drivers/cxl/core/core.h   |  4 ++
>  drivers/cxl/core/extent.c | 78 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1bae80dbf991..30b6b05b155b 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -179,6 +179,10 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
>  void memdev_release_extent(struct cxl_memdev_state *mds, struct range *range);
> +const struct cxl_dpa_partition *
> +cxl_extent_dc_partition(struct cxl_memdev_state *mds,
> +			struct cxl_extent *extent,
> +			struct range *ext_range);
>  
>  static inline struct device *port_to_host(struct cxl_port *port)
>  {
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> index 94128d06f4ed..b01507022cff 100644
> --- a/drivers/cxl/core/extent.c
> +++ b/drivers/cxl/core/extent.c
> @@ -63,11 +63,55 @@ alloc_tag_group(struct cxl_dax_region *cxlr_dax, uuid_t *uuid)
>  	return no_free_ptr(group);
>  }
>  
> +/*
> + * Find the DC (Dynamic Capacity) partition that fully contains @ext_range,
> + * or NULL if the extent falls outside every DC partition on this memdev.
> + * The returned pointer is owned by mds->cxlds.part[] and lives for the
> + * lifetime of the memdev.
> + */
> +const struct cxl_dpa_partition *
> +cxl_extent_dc_partition(struct cxl_memdev_state *mds,
> +			struct cxl_extent *extent,
> +			struct range *ext_range)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct device *dev = mds->cxlds.dev;
> +
From Sashiko: https://sashiko.dev/#/patchset/cover.1779528761.git.anisa.su%40samsung.com?part=16

Sashiko complains about the possibility of end < start in multiple
places. Add a check here for that. Should be sufficient to add the check
here, since every add-able extent passes through here.

if (ext_range->end < ext_range->start) {
	dev_err_ratelimited(dev,
			    "DC extent DPA %pra (%pU) has invalid length (firmware bug)\n",
			    ext_range, extent->uuid);
	return NULL;
}

- Anisa
> +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> +		struct cxl_dpa_partition *part = &cxlds->part[i];
> +		struct range partition_range = {
> +			.start = part->res.start,
> +			.end = part->res.end,
> +		};
> +
> +		if (part->mode != CXL_PARTMODE_DYNAMIC_RAM_A)
> +			continue;
> +
> +		if (range_contains(&partition_range, ext_range)) {
> +			dev_dbg(dev, "DC extent DPA %pra (DCR:%pra)(%pU)\n",
> +				ext_range, &partition_range, extent->uuid);
> +			return part;
> +		}
> +	}
> +
> +	dev_err_ratelimited(dev,
> +			    "DC extent DPA %pra (%pU) is not in a valid DC partition\n",
> +			    ext_range, extent->uuid);
> +	return NULL;
> +}
> +
>  /*
>   * Stage 1 of the add pipeline: pure, no allocation.  Resolve the extent
> - * to its region/endpoint decoder and ext_range, and verify the range
> - * fits in the resolved endpoint decoder's DPA resource.  Further
> - * per-extent invariants layer into this function in subsequent commits.
> + * to its region/endpoint decoder and ext_range, and enforce every
> + * per-extent invariant the device must satisfy:
> + *
> + *   - DPA falls inside a Dynamic Capacity partition (cxl_extent_dc_partition).
> + *   - CDAT-sharability rules:
> + *       sharable:     tag must be non-null AND shared_extn_seq != 0
> + *       non-sharable: shared_extn_seq must be 0  (tag is optional)
> + *     Any cross-mixing is a device firmware bug.
> + *   - DPA resolves to an endpoint decoder attached to a region.
> + *   - The extent's range is fully contained in that ED's DPA resource.
>   *
>   * Caller must hold cxl_rwsem.region for read (cxl_dpa_to_region()).
>   * On success, @out_cxled / @out_cxlr_dax / @out_ext_range carry the
> @@ -81,6 +125,10 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
>  {
>  	u64 start_dpa = le64_to_cpu(extent->start_dpa);
>  	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct device *dev = mds->cxlds.dev;
> +	uuid_t *uuid = (uuid_t *)extent->uuid;
> +	u16 seq = le16_to_cpu(extent->shared_extn_seq);
> +	const struct cxl_dpa_partition *part;
>  	struct cxl_endpoint_decoder *cxled;
>  	struct cxl_region *cxlr;
>  	struct range ext_range = (struct range) {
> @@ -89,6 +137,30 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
>  	};
>  	struct range ed_range;
>  
> +	part = cxl_extent_dc_partition(mds, extent, &ext_range);
> +	if (!part)
> +		return -ENXIO;
> +
> +	if (part->perf.shareable) {
> +		if (uuid_is_null(uuid)) {
> +			dev_err_ratelimited(dev,
> +				"DC extent DPA %pra: sharable-partition extent has null tag (firmware bug)\n",
> +				&ext_range);
> +			return -ENXIO;
> +		}
> +		if (seq == 0) {
> +			dev_err_ratelimited(dev,
> +				"DC extent DPA %pra (%pU): sharable-partition extent missing shared_extn_seq (firmware bug)\n",
> +				&ext_range, uuid);
> +			return -ENXIO;
> +		}
> +	} else if (seq != 0) {
> +		dev_err_ratelimited(dev,
> +			"DC extent DPA %pra (%pU): non-sharable partition but shared_extn_seq=%u (firmware bug)\n",
> +			&ext_range, uuid, seq);
> +		return -ENXIO;
> +	}
> +
>  	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
>  	if (!cxlr)
>  		return -ENXIO;
> -- 
> 2.43.0
> 
