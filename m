Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8E3B8BD9
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 05:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790226749; cv=none; b=Ls8ngsUlC8dKVcFhc+jz8tCql0tKo9Z/VDsqyseWIea99L6nNOBZ/uNwUs44SR55y47rghU7FGFnOZRlmqXVcoGX3t+KSvDbm422zvHLkT2cq8nL0bHVxzHPKKM17ftFpg8DaMj3n4IkwkMtUCob8cDfXqxRP9D/NVvK7xxPm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790226749; c=relaxed/simple;
	bh=JyAkDlcBVheoraVlJaZwNQaGdLuL4muSsruX4Tr/eKc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+Qk0CVurQZAcY+Up1022OGR38viw8Wm22MHGMxAoA4iNGWuiELJkNGRUiVrytNJY7YEQlfFFFDtc0lM2Yyjc9MvX2E2u7rcvHjHQ9nrXuNX5syYC+BjeCWvIQ5ZT3bAKr8Ljwh7tHDXnmhx0h1nj2j6uYcxMa5vXdVE853GseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4sDC2CZ; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4sDC2CZ"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-14354475e6cso479182c88.0
        for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 22:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790226744; x=1790831544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=We2rSELzLufySKLY29yENB+7/Ly7tCo3IVSzU//i+Fs=;
        b=O4sDC2CZHRt+lUSBjAF4LyfDTOv7snjXOLU7JgjFKUtMTUZByRkdcrF4MO+WNrIEqa
         7zZ3Gs2CWTsyF3Cc2U1TkMvxQLcDzarG9TWNvTDC/AfMbB7Xwait75Z/3gClHqc9N/ne
         fPbTZeuCxAbQkS3bZFlnI8KA/lRbXMhf6u7B0lyGU40w2XAshpalvv2QjuGlp2A/6QzP
         gsR9f+OjUD4TUiojVGXTQitiEzyboMxGfPvqL8crYhLuqb3WRCQO292mjWXJyYZT8gG5
         JcuL+kpsiijYDtzgmHPwLcqraQjHCSkaz6R1OvE77FSRP1YKDxJiz/fqYbydbhrVniAN
         XXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790226744; x=1790831544;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=We2rSELzLufySKLY29yENB+7/Ly7tCo3IVSzU//i+Fs=;
        b=kf501W4wpvOLDJTnaDZxj+8/gXhc2J0Goa81C+Ec/wwjSUJcCRg5dM7L+7vaI6q0VB
         WDzjmklRrv5guwfW4gZCVJjSVDMx3U5b3WpNXzfVoXWukiruAzOc3x8Azh3gHdcNkOAk
         do+Cz1yF8fe4pJmat/WnUPhlfP+Up1+ztgrqJ+tvML0fUGYi30wk3ilfPQNiWfxxwIVL
         Fofi3BAVoN+yQaBATz7Ybqyfra4sZcE6EjsHPsf20ydSSoMI4CQZb3ST+ocdxmOpUuBf
         /gvvdqcFthKK6aZ+i7CyaQOVaXj4C61ahBKaqfQXJeSzue2TeJbVeO+HPdeLwDiYvzgx
         giuw==
X-Forwarded-Encrypted: i=1; AKwUvBxxh79zdZgv/h+/l/K3vCmIIOcWWGwJBR1oUDMJyVB9KM7uxd5UlLJgGwxwOn9Ns1/YhMk+WNaeciw=@vger.kernel.org
X-Gm-Message-State: AFuF++ngC5i6SMeTaEmh7pcghqwRYphy14lMMLEYzCmKwVC3p9uC3QkC
	qbMmBnVuV5fDwuNQjF3HR4bWeDr4WIXQ/+00lPhkX6TPkgd3dEO+Xfsf
X-Gm-Gg: AYBFou0X3E0Up4mz2kGE/wggJUPiKDTB8nRwRJG7lX0kf4mO/RRVpCqiNUKd4UYDwPi
	TGucbJ2wv8wlNHm01F50lEbet2fesD2/ehClYU/YmXgSo1U1m4+392bkFD4gRhKkSzWLeKXnZbB
	y0Xigds7xXiS4+3nfE8cNIri3AwEGxF6zBsG0TQfqJ6ImmrAS8J24oo2ph/TZxWvTqbSb4Jsn5v
	bL83dKVZ6eeaDfJFv3cg/jtw5fbJosod9wx+hmOC9jD2lUhJNJ2A/6IvE1FJWWV8s8J1VAEDySI
	Aekj/vjWhaU7I1zZGXp9F/mvBtd2NrTsH5VNycKaYNHrhowmFmjHijp7Ipnm6RObn5IryaDZgl8
	touNIbiHoOyvK7CCutb0mEEINgYkxDnzoaTNI31pY1al8ql++qNe2t1TighdNITD02H45iuYiIB
	eV6dYzErTm/OT+wJZ/ysT31oc+wspqZSAA5/xvaecPU6Z38R81Ts5iLU3HMmNUX/y2kue394l66
	N6c1j51D+ePCFS8zFg68VwsvXR1ffJHmo594N3F8I1nsIkivQhJbRm0b6rKAHiIOBf9lvtbgnWX
	SyJNdpaNRQOXhb89
X-Received: by 2002:a05:701b:428d:10b0:143:2974:bb05 with SMTP id a92af1059eb24-14503fb6d62mr1108193c88.31.1790226744062;
        Wed, 23 Sep 2026 22:12:24 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14501794269sm3895685c88.8.2026.09.23.22.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:12:23 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 23 Sep 2026 22:12:21 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 3/8] cxl/cdat: Gather DSMAS data for DCD partitions
Message-ID: <arSxNYEmxUadSX7i@4470NRD-ASU.ssi.samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-4-anisa.su@samsung.com>
 <0adc5c19-b045-4b45-bb65-deb2d255a787@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0adc5c19-b045-4b45-bb65-deb2d255a787@intel.com>

On Mon, Sep 21, 2026 at 02:55:00PM -0700, Dave Jiang wrote:
> 
> 
> On 9/18/26 1:30 PM, Anisa Su wrote:
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
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> Just a nit below. Otherwise
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > 
> > ---
> > Changes:
> > 1. cdat.c: record the DSMAS shareable flag independently of QTG
> >    discovery. cxl_port_perf_data_calculate() returns -ENOENT when FW
> >    recommends no QTG for any entry, which skipped the assignment even
> >    though the CDAT parsed successfully and the DSMAS flag was valid.
> >    Richard
> > ---
> >  drivers/cxl/core/cdat.c   | 49 +++++++++++++++++++++++++++++----------
> >  drivers/cxl/core/hdm.c    |  1 +
> >  drivers/cxl/core/mbox.c   |  9 +++++++
> >  drivers/cxl/core/memdev.c | 17 ++++++++------
> >  drivers/cxl/cxlmem.h      |  2 ++
> >  include/cxl/cxl.h         |  4 ++++
> >  6 files changed, 63 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index 5c9f07262513..6e7950f12134 100644
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
> > @@ -255,8 +258,13 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
> >  		dent->coord[ACCESS_COORDINATE_CPU].write_latency);
> >  }
> >  
> > -static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> > -				     struct xarray *dsmas_xa)
> > +/*
> > + * The DSMAS shareable flag is a property of the CDAT entry and is recorded
> > + * even if FW returns no QTG recommendations for any entry; only update perf
> > + * if those recommendations exist, indicated by @set_perf
> > + */
> > +static void cxl_memdev_apply_dsmas(struct cxl_dev_state *cxlds,
> > +				   struct xarray *dsmas_xa, bool set_perf)
> 
> Perfer an enum rather than a bool
> 
> DJ
> 
Ok, I'll add this enum:

enum cxl_dsmas_apply {
	CXL_DSMAS_APPLY_FLAGS,		/* shareable etc.; no QTG data */
	CXL_DSMAS_APPLY_FLAGS_PERF,	/* perf coordinates and qos_class */
};

Thanks,
Anisa

> >  {
> >  	struct device *dev = cxlds->dev;
> >  	struct dsmas_entry *dent;
> > @@ -266,18 +274,34 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
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
> > +			if (set_perf)
> > +				update_perf_entry(dev, dent, &part->perf);
> > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> > +				part->shareable = dent->shareable;
> > +			break;
> >  		}
> >  
> >  		if (!found)
> > @@ -419,12 +443,13 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
> >  	}
> >  
> >  	rc = cxl_port_perf_data_calculate(port, dsmas_xa);
> > -	if (rc) {
> > +	if (rc)
> >  		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
> > +
> > +	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, rc == 0);
> > +	if (rc)
> >  		return;
> > -	}
> >  
> > -	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
> >  	cxl_qos_class_verify(cxlmd);
> >  	cxl_memdev_update_perf(cxlmd);
> >  }
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
> > index c96c16cc08e1..d84a90320081 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1366,6 +1366,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> >  	u64 decode_len = le64_to_cpu(dev_part->decode_length);
> >  	u64 blk_size = le64_to_cpu(dev_part->block_size);
> >  	u64 len = le64_to_cpu(dev_part->length);
> > +	u32 handle = le32_to_cpu(dev_part->dsmad_handle);
> >  	u64 size;
> >  
> >  	/*
> > @@ -1378,6 +1379,13 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
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
> >  	/*
> >  	 * Decode length is a count of 256M units, so a device reporting 2^36
> >  	 * or more wraps.
> > @@ -1391,6 +1399,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> >  	*part = (struct cxl_dc_partition_info) {
> >  		.start = le64_to_cpu(dev_part->base),
> >  		.size = size,
> > +		.handle = handle,
> >  	};
> >  
> >  	/*
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 15df8db314d9..8883c8850759 100644
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
> > @@ -685,7 +687,8 @@ int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> >  	info->size = total;
> >  	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> >  		dc_info.start, dc_info.size);
> > -	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> > +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1,
> > +		 dc_info.handle);
> >  
> >  	return 0;
> >  }
> > @@ -704,7 +707,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
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
> 
