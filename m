Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E787386568
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791671238; cv=none; b=XDZ50+Pg9w6Ksnv1GMEURaIryKMrmEvKZIiERS5PH53udZrA12aSFRMVMPr5mNbHVsWAheOSqz9zVCxoAFn8r9l+SIWWL45R9Cj/bSlXbzN7YgNyW+sVIUcqHM1mso+tVZsV3Uh6Kvc+LBqW4QiMurYgAOeRsiG2q7SZCCQIbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791671238; c=relaxed/simple;
	bh=geSFjZIFbEgwMvKQjTIPe81xEJomJ2s7aTBDqJKH10I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6vJl4AALaBOnIs/hL08PaNv4sAsNGBB0TJij0fSsBWRBrxIlcXNoSjaQvjdvq9Ihg9WnSgHkqjUmBUFI0cdJsHiHYnyMd1y8iQjJ3li7QgI1zw7aU9gcHujuzx13ZaLTqfxrZ5auHruywucxFhV7X7MWSvuabPP6SxJXr8s8nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na1lvV8C; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na1lvV8C"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e812e2b31bso3655545ad.3
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791671236; x=1792276036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ef2rOQreX7ParG6i+WbVLJHCfV55gX5hfeh8vRXSUgo=;
        b=na1lvV8CnbrzO9c/vcF2RA4RuXGvSq+67NIT6zk530MpK/JonmfNOnLjEKIORHce82
         fpWIRimYinkpqPtpfX53W99Gk856V/luoBufPWgd2J0x5seZQQMoXfyHf2NL+b7yh15P
         Ml39mTmxBZwSEZLGX2yBNt4Q4bkas9R4hPLtR4v/GfvVDCH0nh0heEmmDEquq2zZbRmU
         xyW47S2tGh8xC7KHqjbTwv8T2ncmkilvVSnQDf0rqoeh7LziR2TmwbJZIfMFEfyGc+b0
         /aHs/P6qHWE7ocL9gC3UNmJokDxJgY/hVOPyUsJ6C0+Oz8rNiEJwR20W4bHpfnZ2wDC4
         jzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791671236; x=1792276036;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ef2rOQreX7ParG6i+WbVLJHCfV55gX5hfeh8vRXSUgo=;
        b=n+jBXpCEwLySTYGOGerrr21GzhKwiOw5x2+O6y6REMlkVJXf+shiqcHwoBPnuTsLM9
         yj5gs/ymlQNVU3BSTtOSbAc6jGiLUg56Bx/i2DOc2ccC+NCys4DieQW0IwQLrutIdcBc
         t5bqn7XtfFbgcO9X9+NEMYHeQbuXB4JPsv3KjC3QOS8RwoZ/zBD67TmH7aRtocg3Iqo0
         B5pzrwsOVoqcNEvBb6a28QbWMxVeHXy73B6ICkSXU6FhP3gU8B4yo4aTEJa7tbrsqmUL
         bxG0378HKFZtew6JjsLF4VBEXuZJGdFuUiIN7STVMp8xnS46K8CNHC/DFon3X06TB5yE
         3b4g==
X-Forwarded-Encrypted: i=1; AKwUvBxdW+jP+z7Irm6V7ET4lAcdamr/NRB2xHkvRdExWTpYHj4bhMYIdDdx6yWiWaSFaB9f7VPumuFNsHM=@vger.kernel.org
X-Gm-Message-State: AFq9FYILOmbWa7WziD1Tj9UXjkiWfYeQsYUI1+cL+xplM1/2NMOyzsBP
	vqMv0I8drT6aTWDra3Q3mx0AVMfR2881lu88URAX9GmV1TLBBBc5j61b
X-Gm-Gg: AYBFou12NAC8bKMvLeUoT5EIIXRKKTe3pPNiDMOXaE5z65FY+qgk2tvWbxQzf594La8
	JcyaHOJ+7ZQ1/jsPnAF+r0RGq2Vsj9SEPNp8DYfoTzOo32dxZZpR0H9cA1Qj/tTSHVSZHqFmPbi
	FQ7OCmjlk6bGlPUXY9nh2SX5gF1QdznaEiA+eonb+Wpfu5OcrlA9lJ3gk+wj1X60h5JSK36DNPq
	Rkp1qMZmsRLMmH1G3FtBPKi6dWl6M0HL1n7y8t4VCr3DKoMSGBqdRelDhN+PFazbRwxTSD720cg
	Uf1kQUcHuk3Wl+PYdQdhlnUoC++hN1d6DhRFj0iPuX1kmnkljIISjzXkonydVvUXgkuRMSYO2xv
	wF50vqBM0YGf9tBSRlZz1fKreWyfvtvEtAvSymrfySF0aomYJgUO1whlNxSnoiBTL/BedSM0EyU
	bM6yZO0DT79Ind4BwMrRRLqroK7j+9LhqOtccJuiO1isdoqAR0UnbgeIgYAS0WS0bWXIJKe6ib7
	DaWL2WUY9tTfzeJR0VmvQJIzw==
X-Received: by 2002:a17:90b:224e:b0:3a8:9db2:a4f with SMTP id 98e67ed59e1d1-3ab3af75ac1mr4415504a91.51.1791671236214;
        Sat, 10 Oct 2026 15:27:16 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab37163e21sm10802592a91.14.2026.10.10.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:27:15 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Sun, 11 Oct 2026 07:29:06 +0900
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>, Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>
Subject: Re: [PATCH v15 3/8] cxl/cdat: Gather DSMAS data for DCD partitions
Message-ID: <asq8MhNhamoM3JwG@cxlqual>
References: <20261007201828.952-1-anisa.su@samsung.com>
 <20261007201828.952-4-anisa.su@samsung.com>
 <dc0fc04c-cc75-4e8d-bbb4-459825c58f20@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0fc04c-cc75-4e8d-bbb4-459825c58f20@intel.com>

On Thu, Oct 08, 2026 at 02:29:12PM -0700, Dave Jiang wrote:
> 
> 
> On 10/7/26 1:16 PM, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Additional DCD partition (AKA region) information is contained in the
> > DSMAS CDAT tables, including performance, shareable and read-only
> > attributes.
> > 
> > Match DCD partitions with DSMAS tables and store the meta data. A DCD
> > shall describe its DC partition in a DSMAS entry (CXL r4.0 9.13.3), so
> > if the CDAT is absent, fails to parse, or has no entry matching the DC
> > partition, disable DCD rather than run with unknown attributes.
> > 
> > DSLBIS is optional, but cxl_cdat_endpoint_process() treated zero DSLBIS
> > entries as a parse failure, which would now disable DCD on a device with
> > a valid DSMAS. Accept an empty DSLBIS, and skip DSMAS entries with no
> > DSLBIS coordinates.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > 
> > ---
> > Changes:
> > 1. cdat.c: disable DCD when the DC partition has no valid DSMAS entry:
> >    no CDAT, CDAT parse failure, or no entry matching the partition.
> >    [Richard, Dave]
> > 2. cdat.c: DSLBIS is optional. An empty DSLBIS no longer fails the
> >    CDAT parse, and cxl_port_perf_data_calculate() skips entries that
> >    have no DSLBIS coordinates.
> >    [Richard, Dave]
> > 3. cdat.c: cxl_memdev_apply_dsmas() takes an enum cxl_dsmas_apply
> >    instead of a bool so the call sites say what is applied.
> >    [Dave]
> > 4. Also record the DSMAS read-only flag (CDAT 1.04, Flags bit 6) on
> >    the partition, alongside shareable.
> >    [Jonathan]
> > ---
> >  drivers/cxl/core/cdat.c   | 97 ++++++++++++++++++++++++++++++++++-----
> >  drivers/cxl/core/hdm.c    |  1 +
> >  drivers/cxl/core/mbox.c   |  9 ++++
> >  drivers/cxl/core/memdev.c | 17 ++++---
> >  drivers/cxl/cxlmem.h      |  2 +
> >  include/cxl/cxl.h         |  6 +++
> >  6 files changed, 113 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index 5c9f07262513..07aedff657d9 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -17,6 +17,8 @@ struct dsmas_entry {
> >  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> >  	int entries;
> >  	int qos_class;
> > +	bool shareable;
> > +	bool read_only;
> >  };
> >  
> >  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> > @@ -74,6 +76,10 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
> >  		return -ENOMEM;
> >  
> >  	dent->handle = dsmas->dsmad_handle;
> > +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
> > +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
> > +	/* Read Only is CDAT 1.04 and later, DSMAS Flags bit 6 */
> > +	dent->read_only = dsmas->flags & ACPI_CDAT_DSMAS_READ_ONLY;
> >  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
> >  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
> >  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> > @@ -188,9 +194,10 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
> >  	if (rc)
> >  		return rc;
> >  
> > +	/* DSLBIS is optional; zero entries is not an error */
> >  	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
> >  			      dsmas_xa, port->cdat.table, port->cdat.length);
> > -	return cdat_table_parse_output(rc);
> > +	return rc < 0 ? rc : 0;
> >  }
> >  
> >  static int cxl_port_perf_data_calculate(struct cxl_port *port,
> > @@ -219,6 +226,13 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
> >  	xa_for_each(dsmas_xa, index, dent) {
> >  		int qos_class;
> >  
> > +		/* No DSLBIS for this DSMAS; nothing to hand the QTG _DSM */
> > +		if (!dent->cdat_coord[ACCESS_COORDINATE_CPU].read_bandwidth &&
> > +		    !dent->cdat_coord[ACCESS_COORDINATE_CPU].write_bandwidth &&
> > +		    !dent->cdat_coord[ACCESS_COORDINATE_CPU].read_latency &&
> > +		    !dent->cdat_coord[ACCESS_COORDINATE_CPU].write_latency)
> > +			continue;
> > +
> >  		cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
> >  		dent->entries = 1;
> >  		rc = cxl_root->ops.qos_class(cxl_root,
> > @@ -255,35 +269,90 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
> >  		dent->coord[ACCESS_COORDINATE_CPU].write_latency);
> >  }
> >  
> > -static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> > -				     struct xarray *dsmas_xa)
> > +/*
> > + * A DCD shall describe its DC partition in a DSMAS entry (CXL r4.0 9.13.3).
> > + * Without one the partition's attributes are unknown, so disable DCD.
> > + */
> > +static void cxl_dcd_dsmas_missing(struct cxl_dev_state *cxlds, const char *why)
> > +{
> > +	struct cxl_memdev_state *mds;
> > +
> > +	if (cxlds->type != CXL_DEVTYPE_CLASSMEM)
> > +		return;
> > +
> > +	mds = to_cxl_memdev_state(cxlds);
> > +	if (!cxl_dcd_supported(mds) ||
> > +	    !cxl_part_size(cxlds, CXL_PARTMODE_DYNAMIC_RAM))
> > +		return;
> > +
> > +	dev_warn(cxlds->dev, "DC partition has no valid DSMAS entry (%s), disabling DCD\n",
> > +		 why);
> > +	cxl_disable_dcd(mds);
> > +}
> > +
> > +enum cxl_dsmas_apply {
> > +	CXL_DSMAS_APPLY_FLAGS,		/* shareable etc.; no QTG data */
> > +	CXL_DSMAS_APPLY_FLAGS_PERF,	/* perf coordinates and qos_class */
> > +};
> > +
> > +/*
> > + * DSMAS flags such as shareable are properties of the CDAT entry and are
> > + * applied regardless; perf data is applied only if the QTG lookup produced
> > + * recommendations.
> > + */
> > +static void cxl_memdev_apply_dsmas(struct cxl_dev_state *cxlds,
> > +				   struct xarray *dsmas_xa,
> > +				   enum cxl_dsmas_apply attrs)
> >  {
> >  	struct device *dev = cxlds->dev;
> >  	struct dsmas_entry *dent;
> > +	bool dc_matched = false;
> >  	unsigned long index;
> >  
> >  	xa_for_each(dsmas_xa, index, dent) {
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
> > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM &&
> > +			    dent->handle != part->handle) {
> > +				dev_warn(dev,
> > +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
> > +					 &range, part->handle,
> > +					 &dent->dpa_range, dent->handle);
> >  				break;
> >  			}
> > +
> > +			if (attrs == CXL_DSMAS_APPLY_FLAGS_PERF)
> > +				update_perf_entry(dev, dent, &part->perf);
> > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM) {
> > +				part->shareable = dent->shareable;
> > +				part->read_only = dent->read_only;
> > +				dc_matched = true;
> 
> Should be able to just return here and avoid the dc_matched flag right?
> 
No, that would break out of the xa_for_each and skip any remaining DSMAS
entries.

> 
> > +			}
> > +			break;
> >  		}
> >  
> >  		if (!found)
> >  			dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> >  				&dent->dpa_range);
> >  	}
> > +
> > +	if (!dc_matched)
> > +		cxl_dcd_dsmas_missing(cxlds, "no matching entry");
> >  }
> >  
> >  static int match_cxlrd_qos_class(struct device *dev, void *data)
> > @@ -409,22 +478,26 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
> >  	int rc;
> >  
> >  	xa_init(&__dsmas_xa);
> > -	if (!port->cdat.table)
> > +	if (!port->cdat.table) {
> > +		cxl_dcd_dsmas_missing(cxlds, "no CDAT");
> >  		return;
> > +	}
> >  
> >  	rc = cxl_cdat_endpoint_process(port, dsmas_xa);
> >  	if (rc < 0) {
> >  		dev_dbg(&port->dev, "Failed to parse CDAT: %d\n", rc);
> > +		cxl_dcd_dsmas_missing(cxlds, "CDAT parse failed");
> >  		return;
> >  	}
> >  
> >  	rc = cxl_port_perf_data_calculate(port, dsmas_xa);
> >  	if (rc) {
> >  		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
> > +		cxl_memdev_apply_dsmas(cxlds, dsmas_xa, CXL_DSMAS_APPLY_FLAGS);
> >  		return;
> >  	}
> >  
> > -	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
> > +	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, CXL_DSMAS_APPLY_FLAGS_PERF);
> >  	cxl_qos_class_verify(cxlmd);
> >  	cxl_memdev_update_perf(cxlmd);
> >  }
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 5fa2177cefcc..379540246333 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -486,6 +486,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> >  
> >  		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
> >  		cxlds->part[i].mode = part->mode;
> > +		cxlds->part[i].handle = part->handle;
> >  
> >  		/* Require ordered + contiguous partitions */
> >  		if (i) {
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 72af23ba288e..12598d329e95 100644
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
> 
> Define a mask?
> 
Changed it to if (handle > U8_MAX)

> DJ
> 
Thanks,
Anisa

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
> > index def26c490dfe..7aa79a1a53e4 100644
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
> >  	dev_dbg(dev, "Adding dynamic ram partition; %#llx size %#llx\n",
> >  		dc_info.start, dc_info.size);
> > -	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM);
> > +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM,
> > +		 dc_info.handle);
> >  
> >  	return 0;
> >  }
> > @@ -703,7 +706,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
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
> > index e07360849344..728decda57fd 100644
> > --- a/include/cxl/cxl.h
> > +++ b/include/cxl/cxl.h
> > @@ -141,11 +141,17 @@ enum cxl_partition_mode {
> >   * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> >   * @perf: performance attributes of the partition from CDAT
> >   * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> > + * @handle: DSMAS handle that represents this partition
> > + * @shareable: Is the partition shareable (from its CDAT DSMAS entry)
> > + * @read_only: Is the partition read-only (from its CDAT DSMAS entry)
> >   */
> >  struct cxl_dpa_partition {
> >  	struct resource res;
> >  	struct cxl_dpa_perf perf;
> >  	enum cxl_partition_mode mode;
> > +	u8 handle;
> > +	bool shareable;
> > +	bool read_only;
> >  };
> >  
> >  #define CXL_NR_PARTITIONS_MAX 3
> 
