Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C8B42BE95
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789504659; cv=none; b=KNWn2d+t/0wkfPmNwgTSXx9/PAICdnplNOp8O4EM+BXT5+/nsRU4Z2xq4ppnXPkd+kwkr/BBgPYE8guNv76rk5jbFSV5AmqY65f0TtsrXAlZNja/UaF5mefQrA6iXMVqgTKKfsF1499b45MXHuu1kwBT3UxYK1sWQAyLDBc1l/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789504659; c=relaxed/simple;
	bh=tqqtL86y+9dh4AP0Lj9xNUqm/k3NQQ5jDUPmrr4zeZc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2cnSJdYkcGNVZxXAQ1zEPJlEWlkdFEspc22IaI+TQAT9ihSySl9rRNDEfCEKIQ+3VGaMvPSnx8sn1zDAGcngKFr/k2dIOkpze1so0aHhYKCqdsnEbQSJ1oVUqhxGyLevLuBddIOUrsH8I/R7PiYMypf7LP2VMk/N16z/IX2mTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4T4Ty98; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4T4Ty98"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d91ede8035so2400575ad.3
        for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789504657; x=1790109457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E42eCRR5NENvlfZEin4YsbFAPO8SoGaWDYgnnEhJNu8=;
        b=g4T4Ty98jIhLNkW7b81tE9iVdXr3LFLEMdxlz1ZaStoD1sqQ02BfqDvfJQ9q39R1GD
         bnzCW1lW8Mw7hglXTTbp1GB4fuuqJ1h4DhyUa2Hr/m8ElHU20DUuoVx586dUnZxlAjbU
         xTXj5TVLXf5/Ju57vxiqyGp9X181JCagKBD2r89GY+gatUuPQXI98+T6iNLhDUVvBOR9
         ZpA8Ol/onxEXI3oVRqjiK+zNsgKRD5UX2LRFgy7kFZPxpYsmcjnTtcLpyo/0MOttBuIo
         GwDEXBSH/0YoLogYzf8dDfHQu/5AzlC/N64UNGTn7vl8hK8VOzIca/PQJCIGbkJWPCw6
         P4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789504657; x=1790109457;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E42eCRR5NENvlfZEin4YsbFAPO8SoGaWDYgnnEhJNu8=;
        b=0FbEvPuNaxfajGGuf3pIuwZNJiFS2TecvR+cZn/MBTjqELktyl0jaFIT+HPvsb0C8J
         Q6Ji82IWjZ1CMPWuKkJSUJN9cDuuVtORjTjJNKNKzpiPxPc5fVLPQcg3tS7/ALS2YL7N
         3SzH2sk5fHRKZ1zTGMNO9fvRLByCKxSfg2zPuJevtlznqfcJTxplHwJZ99yRNcXhlQqH
         z8XJdFwXsD8pBl9snf1oW+epVfClSgdZ5bWp944pmjzWHhZpJ02AmBL99siIn6eSzmW+
         P6sxmNQKHYE4tUaxGutqAhmOVG4l+cGDNuLcmQ/OL6E717+f5DJxHG9zeYBFhlAZSaJo
         pqpw==
X-Forwarded-Encrypted: i=1; AKwUvBzkwKkgmta/0GBGFMrwJYkV3quDhGfBlz3H+bNbPYIlHchFYZva3EyC7QqegH6bWNP9O38DW3GP2Gk=@vger.kernel.org
X-Gm-Message-State: AFuF++kGjvP4T1T6HoztEDTNTHYCvvgowXsQ7kGmT1urc7HLq0UzGyuT
	uYkmoLp+Fq0jcEqk1hXp9WmjHTYzBWYbgfmCB7F5hLe7/1F+IdUamFSf
X-Gm-Gg: AYBFou1e5HRQN4KEdOtZZfNr7bP2cS/AfUZaMJHr/Dv4XLkri+6NWogJxhHHzjqgFd1
	mZIJqqgnSKCHHsWFdS4gQIOuDlL1V0eG5+QhReM7Bc5YmFEl+sxrkU0+C13pPhMCocHMi/AvQ8C
	cg7MN+gLJoOozp5v7rR8up+izZRyX5MgGPoBjr2/lsk4au1CX1yBF/v1OjYSuUuR7rNocsyJEC/
	419soYSfJmZe0LnBzNN+lxtnWxmoRLKHI4dWV+8kyEA6YWbaaaGPiGOpLxGHdDGMHvgaQe00c/B
	g5BftY/CT0eSkP09u1NmPfKw0J7bHVIXDS25beTWK7rppCCmKZlYQzI7R4JOcwUQ9qpL1om6Y5h
	oU3ATDG3sDSIqMWLhG5tVdm4JhVPgMy6kyJ4t5rrwFmzDL+9yVF/044bDYeyE5Iq8PgQW52WK0h
	2rGQlSjEWxnApmtnfuvqhy11Oqo7El40+pTC3Or0i2BP4L1Iazf002B/wMFr55+ak9I/uR5ZIJF
	OFrcT2P/5SrluIG8q4Kt90RyA==
X-Received: by 2002:a17:90b:50c7:b0:39e:b15:7950 with SMTP id 98e67ed59e1d1-39e1e4eaeacmr82923a91.23.1789504656738;
        Tue, 15 Sep 2026 13:37:36 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b7a7a1csm481809a91.15.2026.09.15.13.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 13:37:36 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 16 Sep 2026 05:38:46 +0900
To: Richard Cheng <icheng@nvidia.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, jic23@kernel.org, dave.jiang@intel.com,
	gourry@gourry.net, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 2/8] cxl/mem: Read dynamic capacity
 configuration from the device
Message-ID: <aqms1t5DamJzxd5Y@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-4-anisa.su@samsung.com>
 <aqjxpUZSylwTN01S@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqjxpUZSylwTN01S@MWDK4CY14F>

On Tue, Sep 15, 2026 at 03:30:35PM +0800, Richard Cheng wrote:
> On Tue, Sep 08, 2026 at 03:15:06AM +0800, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Devices which support Dynamic Capacity (DC) are configured
> > via mailbox commands. CXL r4.0 section 9.13.3 requires the host to issue
> > the Get DC Configuration command in order to properly configure DCDs.
> > 
> > Implement the DC mailbox commands as specified in CXL 4.0 section
> > 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> > information. Disable DCD if an invalid configuration is found.
> > 
> > Linux has no support for more than one dynamic capacity partition. Read
> > all the partitions the device reports but validate only the first, and
> > configure it as 'dynamic ram 1'.
> > 
> > The specification requires that volatile capacity starts at DPA 0 and pmem
> > starts at the DPA immediately following it, but DC partitions only need
> > to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> > So a device could leave a gap between ram/pmem (static) capacity and its first
> > DC partition, or between one DC partition and the next.
> > 
> > However, Linux follows the precedent set by PMEM/RAM partitions and requires the
> > first DC partition to begin at the DPA immediately following static
> > capacity.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > 
> > ---
> > Changes:
> > 1. mbox.c: validate only the first DC partition. Other partitions are read
> >    to make it easier to add support for additional partitions but not
> >    checked. Richard/Alison
> > 
> > 2. mbox.c: rework the cxl_dc_check() validation. Run the checks in
> >    dependency order -- block size, decode length, length, base -- so the
> >    block size is validated before IS_ALIGNED() uses it as an alignment,
> >    and give each failure its own message naming the field that is wrong.
> >    Drop the block size alignment requirement on the region base; CXL
> >    r4.0 Table 8-347 requires the base to be 256M aligned and states the
> >    block size alignment for extent start DPAs, not for the base.
> >    Reported by Alison.
> > 
> > 3. mbox.c: range check the number of available DC partitions reported by
> >    the device. CXL r4.0 Table 8-346 requires a DCD to report between 1
> >    and 8 regions, but the count was used unchecked as the read loop
> >    bound, so an out of range value failed later as "Invalid num of
> >    dynamic capacity partitions". Reported by Alison.
> > 
> > 4. mbox.c/pci.c: cxl_configure_dcd() returns an error instead of void,
> >    and cxl_pci_probe() decides what to do with it. Failure to read the
> >    DC configuration is now reported rather than silently swallowed;
> >    -EINVAL for a partition overlapping static capacity, -EOPNOTSUPP for
> >    the gap Linux does not support, and the mailbox error propagated
> >    otherwise. cxl_disable_dcd() moves to the caller so the function
> >    reports and the caller sets policy. Probe still continues without
> >    DCD rather than failing the memdev, which would cost the device its
> >    static capacity too. Reported by Jonathan Cameron.
> > 
> > 5. mbox.c: check the block size is a power of 2 in 64 bits.
> >    is_power_of_2() takes an unsigned long, so on a 32 bit build blk_size
> >    was truncated to its low 32 bits and a value such as 0x100000040 --
> >    non-zero and a multiple of 40h -- passed validation. CXL_BUS only
> >    depends on PCI, so this builds on 32 bit. Reported by Sashiko.
> > ---
> >  drivers/cxl/core/hdm.c    |   2 +
> >  drivers/cxl/core/mbox.c   | 235 ++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/memdev.c |  37 ++++++
> >  drivers/cxl/cxlmem.h      |  55 +++++++++
> >  drivers/cxl/pci.c         |   6 +
> >  include/cxl/cxl.h         |   3 +-
> >  6 files changed, 337 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b..0ef076c08ed2 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -446,6 +446,8 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
> >  		return "ram";
> >  	case CXL_PARTMODE_PMEM:
> >  		return "pmem";
> > +	case CXL_PARTMODE_DYNAMIC_RAM_1:
> > +		return "dynamic_ram_1";
> >  	default:
> >  		return "";
> >  	};
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 199bb986d674..a484e23b2b3a 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -1349,6 +1349,241 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
> >  	return -EBUSY;
> >  }
> >  
> > +/*
> > + * A partition unavailable for Dynamic Capacity reports zeros for decode_length,
> > + * length, and block_size.
> > + */
> > +static bool cxl_dc_partition_unavailable(struct cxl_dc_partition *dev_part)
> > +{
> > +	return !le64_to_cpu(dev_part->decode_length) &&
> > +	       !le64_to_cpu(dev_part->length) &&
> > +	       !le64_to_cpu(dev_part->block_size);
> > +}
> > +
> > +static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
> > +			struct cxl_dc_partition *dev_part)
> > +{
> > +	u64 blk_size = le64_to_cpu(dev_part->block_size);
> > +	u64 len = le64_to_cpu(dev_part->length);
> > +
> > +	/*
> > +	 * Not an error; leave the entry empty. A partially zeroed partition
> > +	 * is rejected by the checks below. CXL r4.0 Table 8-347.
> > +	 */
> > +	if (cxl_dc_partition_unavailable(dev_part)) {
> > +		*part = (struct cxl_dc_partition_info) { };
> > +		dev_dbg(dev, "Partition 0 unavailable for DC\n");
> > +		return 0;
> > +	}
> > +
> > +	*part = (struct cxl_dc_partition_info) {
> > +		.start = le64_to_cpu(dev_part->base),
> > +		.size = le64_to_cpu(dev_part->decode_length) * CXL_CAPACITY_MULTIPLIER,
> > +	};
> > +
> 
> Hi Anisa,
> 
> 
> I think this might have overflowing issue, if decode_length = 0x1000000002 , it produces
> 2^64 + 512 MB, which wraps to 512MB in u64. The following check wouldn't reject such case.
> 
> Maybe a check_mul_overflow() here ?
> 
Thank you for catching that. Changed to check for overflow before
assigning to partition size.

	/*
	 * Decode length is a count of 256M units, so a device reporting 2^36
	 * or more wraps.
	 */
	if (check_mul_overflow(decode_len, (u64)CXL_CAPACITY_MULTIPLIER, &size)) {
		dev_err(dev, "DC partition 0 decode length %#llx overflows\n",
			decode_len);
		return -EINVAL;
	}

	*part = (struct cxl_dc_partition_info) {
		.start = le64_to_cpu(dev_part->base),
		.size = size,
		.handle = handle,
	};

> 
> > +	/*
> > +	 * Block size is a power of 2 and a multiple of 40h. is_power_of_2()
> > +	 * takes an unsigned long, which truncates blk_size on 32 bit.
> > +	 */
> > +	if (blk_size == 0 || (blk_size & (blk_size - 1)) ||
> > +	    blk_size % CXL_DCD_BLOCK_LINE_SIZE) {
> > +		dev_err(dev, "DC partition 0 invalid block size %#llx\n", blk_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (part->size == 0) {
> > +		dev_err(dev, "DC partition 0 zero decode length\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (len == 0) {
> > +		dev_err(dev, "DC partition 0 zero length\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (len > part->size) {
> > +		dev_err(dev, "DC partition 0 length %#llx exceeds decode length %#llx\n",
> > +			len, part->size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!IS_ALIGNED(len, blk_size)) {
> > +		dev_err(dev, "DC partition 0 length %#llx not a multiple of block size %#llx\n",
> > +			len, blk_size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!IS_ALIGNED(part->start, SZ_256M)) {
> > +		dev_err(dev, "DC partition 0 base %#llx not aligned to 256M\n",
> > +			part->start);
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_dbg(dev, "DC partition 0 start %#llx size %#llx blk_size: %#llx\n",
> > +		part->start, part->size, blk_size);
> > +
> > +	return 0;
> > +}
> > +
snip
> >  
> > +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> > +{
> > +	struct cxl_dc_partition_info dc_info = { };
> > +	struct device *dev = mds->cxlds.dev;
> > +	int rc;
> > +
> > +	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
> > +	if (rc) {
> > +		dev_warn(dev,
> > +			 "Failed to read Dynamic Capacity config: %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	if (dc_info.start < info->size) {
> > +		dev_err(dev,
> > +			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n",
> > +			dc_info.start, info->size);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* A gap between static capacity and the DC partition is not supported */
> > +	if (dc_info.start > info->size) {
> > +		dev_warn(dev,
> > +			 "DC partition 0 base %#llx leaves a gap from static capacity ending at %#llx\n",
> > +			 dc_info.start, info->size);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	info->size += dc_info.size;
> 
> Overflowing issue issue as well.
> 
> With 2 GB static capacity, DC base = 0x80000000, DC size = 0xffffffff80000000.
> The placement checks pass but the total wrpas to 0.
> 
> Maybe check_add_overflow() and return an error before changing info->size .
> 
Replaced info->size += dc_info.size with:

	if (check_add_overflow(info->size, dc_info.size, &total)) {
		dev_err(dev,
			"DC partition 0 size %#llx overflows DPA space ending at %#llx\n",
			dc_info.size, info->size);
		return -EINVAL;
	}

	info->size = total;

> Best regards,
> Richard Cheng.
> 
Thanks,
Anisa
> > +	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> > +		dc_info.start, dc_info.size);
> > +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_configure_dcd, "CXL");
> > +
> >  
> >  /**
> >   * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 0c8e23276dc6..4fac65dbb808 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -407,6 +407,8 @@ struct cxl_security_state {
> >  	struct kernfs_node *sanitize_node;
> >  };
> >  
> > +#define CXL_MAX_DC_PARTITIONS 8
> > +
> >  static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
> >  {
> >  	/*
> > @@ -689,6 +691,39 @@ struct cxl_mbox_set_shutdown_state_in {
> >  	u8 state;
> >  } __packed;
> >  
> > +/* See CXL r4.0 Table 8-345 get dynamic capacity config Input Payload */
> > +struct cxl_mbox_get_dc_config_in {
> > +	u8 partition_count;
> > +	u8 start_partition_index;
> > +} __packed;
> > +
> > +/* See CXL r4.0 Table 8-346 get dynamic capacity config Output Payload */
> > +struct cxl_mbox_get_dc_config_out {
> > +	u8 avail_partition_count;
> > +	u8 partitions_returned;
> > +	u8 rsvd[6];
> > +	/* See CXL r4.0 Table 8-347 */
> > +	struct cxl_dc_partition {
> > +		__le64 base;
> > +		__le64 decode_length;
> > +		__le64 length;
> > +		__le64 block_size;
> > +		__le32 dsmad_handle;
> > +		u8 flags;
> > +		u8 rsvd[3];
> > +	} __packed partition[] __counted_by(partitions_returned);
> > +	/* Trailing extent/tag count fields unused */
> > +} __packed;
> > +
> > +/* Trailing counts; cannot be a member after the flex array above */
> > +struct cxl_mbox_get_dc_config_tail {
> > +	__le32 num_extents_supported;
> > +	__le32 num_extents_available;
> > +	__le32 num_tags_supported;
> > +	__le32 num_tags_available;
> > +} __packed;
> > +#define CXL_DCD_BLOCK_LINE_SIZE 0x40
> > +
> >  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
> >  struct cxl_mbox_set_timestamp_in {
> >  	__le64 timestamp;
> > @@ -812,9 +847,18 @@ enum {
> >  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
> >  			  struct cxl_mbox_cmd *cmd);
> >  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> > +
> > +struct cxl_dc_partition_info {
> > +	u64 start;
> > +	u64 size;
> > +};
> > +
> > +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> > +			struct cxl_dc_partition_info *dc_info);
> >  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
> >  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
> >  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> > +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> >  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> >  						 u16 dvsec);
> >  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> > @@ -828,6 +872,17 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
> >  			    const uuid_t *uuid, union cxl_event *evt);
> >  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
> >  int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
> > +
> > +static inline bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> > +{
> > +	return mds->dcd_supported;
> > +}
> > +
> > +static inline void cxl_disable_dcd(struct cxl_memdev_state *mds)
> > +{
> > +	mds->dcd_supported = false;
> > +}
> > +
> >  int cxl_set_timestamp(struct cxl_memdev_state *mds);
> >  int cxl_poison_state_init(struct cxl_memdev_state *mds);
> >  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index c7c91e8dc51d..2fe9db4b3d86 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -868,6 +868,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	if (cxl_dcd_supported(mds)) {
> > +		rc = cxl_configure_dcd(mds, &range_info);
> > +		if (rc)
> > +			cxl_disable_dcd(mds);
> > +	}
> > +
> >  	rc = cxl_dpa_setup(cxlds, &range_info);
> >  	if (rc)
> >  		return rc;
> > diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> > index 802b143de83d..4ef9511fbbdd 100644
> > --- a/include/cxl/cxl.h
> > +++ b/include/cxl/cxl.h
> > @@ -133,6 +133,7 @@ struct cxl_dpa_perf {
> >  enum cxl_partition_mode {
> >  	CXL_PARTMODE_RAM,
> >  	CXL_PARTMODE_PMEM,
> > +	CXL_PARTMODE_DYNAMIC_RAM_1,
> >  };
> >  
> >  /**
> > @@ -147,7 +148,7 @@ struct cxl_dpa_partition {
> >  	enum cxl_partition_mode mode;
> >  };
> >  
> > -#define CXL_NR_PARTITIONS_MAX 2
> > +#define CXL_NR_PARTITIONS_MAX 3
> >  
> >  /**
> >   * struct cxl_dev_state - The driver device state
> > -- 
> > 2.43.0
> > 
