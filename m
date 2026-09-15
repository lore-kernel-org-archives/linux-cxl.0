Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27303876CC
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507414; cv=none; b=BkLTObhJDLKfPpASP25JOay59T2VsSfAgBZ7Hhx66bFhRIbHiOKKPO/nTfG3tqnYFBpGN9kl5sTm9QXty9XPlN7BLYW9w3QOnCy8ZsOzb0Zs8vvLzNHrPZiO4NjaOTavFWX+2J75q+PHOssTWYfGy6AwdUpvxfu2eFottTsBk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507414; c=relaxed/simple;
	bh=/cLNtCUgG2bHfNNKVXsyWFnTdP5LThFRekcm7ZHBdq8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtNzU5TUXOy/mksqByVUcpvBv9bV0mAJJh2iVMtWQefeoP/4//PMn8HWv8AiFSlGjpXCZVaJ2P89Kkr9Z40gLjaUHScgFHg6sjlf6J/y+ELabZPrmbxIQGZRktJWTR4a5sAd1brl8gph8kMwti6g6emvGVPfhdGTBajjuw3Wn8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jm68koOR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jm68koOR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so12496245ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789507412; x=1790112212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GCSzVgFAHyvoU3+NG+wI4374hDCvLmIJ1WahE34v59c=;
        b=Jm68koORdxqJG5S2Bh4V/2jVa3OPgDLPZQerRfx6rIt6Y3Vel8ac59patLeUjUPOoV
         Y4ZOamt95+JGr/ToTkUMlVHhZSB10wZ3adhOA1KQ2QtGnA1f/0rRgbsMFla8s3zFKZCE
         nSWJoKdDkoQbKJjen0ttem7qRa7huTIEo7qwZmMBrAKXCsQv5sGbwttJeS49qUNE+Yak
         YYmixNGcLE8SWR4QieqzhPvg10HARk0ehTl86as7WYpThL5RaMDVnPTpdv8+O+T2wNq2
         NwJR7JrF2oK8YcYE8jEQFp4cDc2dYb1QWZ2vyy71MIFyxFNW8IdmXURZ4bvDt5YXJu2X
         tGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789507412; x=1790112212;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCSzVgFAHyvoU3+NG+wI4374hDCvLmIJ1WahE34v59c=;
        b=iSLpfUVEsOlCD9eqwcyq9yCIlkpm89Zmj7upzqd0moEjbh3eLrs+vVY5Jgonq4u8fl
         2rYCTJsqLzCzFEAYXT2ZkuFggltlm26TEYNNl7uKZb4TDfuby/kt90OppqhPbwRPwmja
         DT3AmJf671iKJIx4tL/Vp//gv8oEKYDmYwBYHFcaNdM4+YLSXpqwiZ04YQT9imhryieY
         6IwBalQUAvq5dk45kCli/6s28j+cHCQPNzNUiQsVR00fcv0zliCfEb5kjY1KJ/djDHgs
         39liDpKqgYp1mH8VpAJaKexbb9Mb5DtafAqbSViR6ew/FlT3V5Ug2AaJl+hW43OsEc0+
         pDFg==
X-Forwarded-Encrypted: i=1; AKwUvBxVZ30SuNLc+53zIxkp/w+XdJgxjR+RdKZSffCennUnBOOpmsPeYDQfaUQfZfCBeseoFxxuz9E78e4=@vger.kernel.org
X-Gm-Message-State: AFuF++m2TrnMHqdkzIAEXjwbIJ3X8kdKGoSGoTixR9lovfp5D1x/AEjM
	Tz4Gfa1Hlt2uaInV7vFSciRvSpV9ub2zlugItRnnx5WEFxWG27spB8WQ
X-Gm-Gg: AYBFou1ns2u1E8qXxqs5T0+4MilLUxC8GZP6PLM28xacqF3uqbqY1VIv584tWJXYBWX
	VENH0xSRoV0WHPjjYgVID9a1kkWqD+GT3NvKmsiK/5k+YyVWmDPtDwO1Yr05uW6HjHJj+xgzc4t
	jJsJE5yEzfcOZVXRsYWOLLFMo0Tsd3AOR3PTamz/e2W5zABVpr71WTBJWei49D8YgA+nhswGjYq
	kWlAwKmOp0WzI9dzkhyeIOicW4tFFzNIhBlHgmznImnyF2ruINwiFdpVLlRty1aAvgpm+mVE26Y
	E2mq7cuoJ7SbR0oZMqiBUbJNkbTogTeSdPaPCkCa4TAvbu3iIV7a6r+oSlP6nX5H3ZcF5iqUs1Q
	DKdDGxLNDxmvbEYpY4i/9g3WXoIAo2HONgGj1QexCN7wEKTY4xa1gqJGwPjOUw6eUm6wRU+FE8i
	1yFdUYQMVRDD8DbvaDv3cwSSj3+Twlqa1i9w0Q639aMJ7V13a6Q7X+EXScVdcBTsmrEqAjshhoO
	7K75/6m6tR0MrX9JQ3jhKv0Dw==
X-Received: by 2002:a17:902:db0c:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2dd763da77fmr68613415ad.0.1789507411702;
        Tue, 15 Sep 2026 14:23:31 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f21b39sm1399945ad.75.2026.09.15.14.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:23:30 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 16 Sep 2026 06:24:41 +0900
To: Richard Cheng <icheng@nvidia.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, jic23@kernel.org, dave.jiang@intel.com,
	gourry@gourry.net, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 3/8] cxl/cdat: Gather DSMAS data for DCD
 partitions
Message-ID: <aqm3mazftZrNEHA5@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-5-anisa.su@samsung.com>
 <aqkMVCJRlgyJMJAT@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqkMVCJRlgyJMJAT@MWDK4CY14F>

On Tue, Sep 15, 2026 at 05:16:52PM +0800, Richard Cheng wrote:
> On Tue, Sep 08, 2026 at 03:15:07AM +0800, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Additional DCD partition (AKA region) information is contained in the
> > DSMAS CDAT tables, including performance and shareable attributes.
> > 
> > Match DCD partitions with DSMAS tables and store the meta data.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > 
> > ---
> > Changes:
> > 1. cdat.c: set found=true as soon as a partition contains the range, and
> >    break out of the search on a DSMAD handle mismatch. Partitions are
> >    disjoint, so the continue could never match another one; the search
> >    always ran out and the entry was reported twice, once as a mismatch
> >    and again as "no partition for dsmas dpa" even though a partition did
> >    cover it.
> > 
> > 2. cdat.c: only assign shareable for the dynamic ram 1 partition. It
> >    was set for every partition the DSMAS range fell into, while the
> >    handle check above it is DC only. The field describes a DC partition,
> >    so ram and pmem have no use for it.
> > 
> > 3. Commit message: drop the claim that the read only attribute is
> >    gathered. Only the shareable flag is. Nothing in this series or the
> >    follow-on DCD work consumes a read only flag, so storing it would be
> >    dead state. Implementing read-only (reject writes to RO partitions)
> >    applies to any DSMAS described range, non-specific to dynamic capacity and
> >    belongs to separate patch.
> > ---
> >  drivers/cxl/core/cdat.c   | 32 +++++++++++++++++++++++++-------
> >  drivers/cxl/core/hdm.c    |  1 +
> >  drivers/cxl/core/mbox.c   |  9 +++++++++
> >  drivers/cxl/core/memdev.c | 17 ++++++++++-------
> >  drivers/cxl/cxlmem.h      |  2 ++
> >  include/cxl/cxl.h         |  4 ++++
> >  6 files changed, 51 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index 5c9f07262513..05058d4520f2 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -17,6 +17,7 @@ struct dsmas_entry {
> >  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> >  	int entries;
> >  	int qos_class;
> > +	bool shareable;
> >  };
> >  
> >  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> > @@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
> >  		return -ENOMEM;
> >  
> >  	dent->handle = dsmas->dsmad_handle;
> > +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
> > +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
> >  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
> >  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
> >  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> > @@ -266,18 +269,33 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> >  		bool found = false;
> >  
> >  		for (int i = 0; i < cxlds->nr_partitions; i++) {
> > -			struct resource *res = &cxlds->part[i].res;
> > +			struct cxl_dpa_partition *part = &cxlds->part[i];
> >  			struct range range = {
> > -				.start = res->start,
> > -				.end = res->end,
> > +				.start = part->res.start,
> > +				.end = part->res.end,
> >  			};
> >  
> > -			if (range_contains(&range, &dent->dpa_range)) {
> > -				update_perf_entry(dev, dent,
> > -						  &cxlds->part[i].perf);
> > -				found = true;
> > +			if (!range_contains(&range, &dent->dpa_range))
> > +				continue;
> > +
> > +			found = true;
> > +			/*
> > +			 * part->handle is from Get DC Config, dent->handle
> > +			 * from the CDAT DSMAS entry.
> > +			 */
> > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
> > +			    dent->handle != part->handle) {
> > +				dev_warn(dev,
> > +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
> > +					 &range, part->handle,
> > +					 &dent->dpa_range, dent->handle);
> >  				break;
> >  			}
> > +
> > +			update_perf_entry(dev, dent, &part->perf);
> > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> > +				part->shareable = dent->shareable;
> > +			break;
> 
> I think this should be independent of QoS discovery ?
> 
> If FW returns no QTG recommnedations for any entry, that calculation returns
> -ENOENT even though CDAT was parsed successfully.
> And the result is that a matching DSMAS entry having its shareable bit set, but
> part->shareable remains false because this assignment is never reached.
> 
Hmmm yeah... I added an input param set_perf and renamed the function:
/*
 * The DSMAS shareable flag is a property of the CDAT entry and is recorded
 * even if FW returns no QTG recommendations for any entry; only update perf
 * if those recommendations exist, indicated by @set_perf
 */
static void cxl_memdev_apply_dsmas(struct cxl_dev_state *cxlds,
				   struct xarray *dsmas_xa, bool set_perf)
{ ...
			if (set_perf)
				update_perf_entry(dev, dent, &part->perf);
...}
The rest of the function stays the same.

From the caller:
	rc = cxl_port_perf_data_calculate(port, dsmas_xa);
	if (rc)
		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");

	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, rc == 0);
	if (rc)
		return;

What do you think?

> Best regards,
> Richard Cheng.
> 
Thanks,
Anisa
> >  		}
> >  
> >  		if (!found)
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0ef076c08ed2..7f63b86887f4 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -477,6 +477,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> >  
> >  		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> >  		cxlds->part[i].mode = part->mode;
> > +		cxlds->part[i].handle = part->handle;
> >  
> >  		/* Require ordered + contiguous partitions */
> >  		if (i) {
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index a484e23b2b3a..efc3bf3563a5 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1365,6 +1365,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> >  {
> >  	u64 blk_size = le64_to_cpu(dev_part->block_size);
> >  	u64 len = le64_to_cpu(dev_part->length);
> > +	u32 handle = le32_to_cpu(dev_part->dsmad_handle);
> >  
> >  	/*
> >  	 * Not an error; leave the entry empty. A partially zeroed partition
> > @@ -1376,9 +1377,17 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> >  		return 0;
> >  	}
> >  
> > +	/* The CDAT DSMAD handle this refers to is 8 bits */
> > +	if (handle & ~0xFF) {
> > +		dev_warn(dev, "DSMAD handle 0x%x exceeds the 8 bit CDAT DSMAD handle\n",
> > +			 handle);
> > +		return -EINVAL;
> > +	}
> > +
> >  	*part = (struct cxl_dc_partition_info) {
> >  		.start = le64_to_cpu(dev_part->base),
> >  		.size = le64_to_cpu(dev_part->decode_length) * CXL_CAPACITY_MULTIPLIER,
> > +		.handle = handle,
> >  	};
> >  
> >  	/*
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index fdd6b395dcdf..4a5793fa3cbf 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -594,7 +594,8 @@ bool is_cxl_memdev(const struct device *dev)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
> >  
> > -static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
> > +static void add_part(struct cxl_dpa_info *info, u64 start, u64 size,
> > +		     enum cxl_partition_mode mode, u8 handle)
> >  {
> >  	int i = info->nr_partitions;
> >  
> > @@ -606,6 +607,7 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
> >  		.end = start + size - 1,
> >  	};
> >  	info->part[i].mode = mode;
> > +	info->part[i].handle = handle;
> >  	info->nr_partitions++;
> >  }
> >  
> > @@ -623,9 +625,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> >  	info->size = mds->total_bytes;
> >  
> >  	if (mds->partition_align_bytes == 0) {
> > -		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
> > +		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM, 0);
> >  		add_part(info, mds->volatile_only_bytes,
> > -			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
> > +			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM, 0);
> >  		return 0;
> >  	}
> >  
> > @@ -635,9 +637,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> >  		return rc;
> >  	}
> >  
> > -	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
> > +	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM, 0);
> >  	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
> > -		 CXL_PARTMODE_PMEM);
> > +		 CXL_PARTMODE_PMEM, 0);
> >  
> >  	return 0;
> >  }
> > @@ -674,7 +676,8 @@ int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> >  	info->size += dc_info.size;
> >  	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> >  		dc_info.start, dc_info.size);
> > -	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> > +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1,
> > +		 dc_info.handle);
> >  
> >  	return 0;
> >  }
> > @@ -693,7 +696,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
> >  		.size = capacity,
> >  	};
> >  
> > -	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
> > +	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM, 0);
> >  	return cxl_dpa_setup(cxlds, &range_info);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 4fac65dbb808..9fd5af2e41d4 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -140,6 +140,7 @@ struct cxl_dpa_info {
> >  	struct cxl_dpa_part_info {
> >  		struct range range;
> >  		enum cxl_partition_mode mode;
> > +		u8 handle;
> >  	} part[CXL_NR_PARTITIONS_MAX];
> >  	int nr_partitions;
> >  };
> > @@ -851,6 +852,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> >  struct cxl_dc_partition_info {
> >  	u64 start;
> >  	u64 size;
> > +	u8 handle;
> >  };
> >  
> >  int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> > diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> > index 4ef9511fbbdd..43edcde5bce3 100644
> > --- a/include/cxl/cxl.h
> > +++ b/include/cxl/cxl.h
> > @@ -141,11 +141,15 @@ enum cxl_partition_mode {
> >   * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> >   * @perf: performance attributes of the partition from CDAT
> >   * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> > + * @handle: DSMAS handle that represents this partition
> > + * @shareable: Is the partition shareable (from its CDAT DSMAS entry)
> >   */
> >  struct cxl_dpa_partition {
> >  	struct resource res;
> >  	struct cxl_dpa_perf perf;
> >  	enum cxl_partition_mode mode;
> > +	u8 handle;
> > +	bool shareable;
> >  };
> >  
> >  #define CXL_NR_PARTITIONS_MAX 3
> > -- 
> > 2.43.0
> > 
