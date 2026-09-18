Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B353F12C1
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762157; cv=none; b=THh74oSULOcCrAZ5eHCLFth4p14SMbk76kgaQCxZO1FNMJ+535r4+9zI0shtmYn4xXpi9hdYnkR8LcwCxr9f323gWiXwiR0KDCoUE/hdJNKt94vX/DAfOAXqVF0poX6cQLDo/rY0TH9njqBVHt/1OgULvvC/keo9Y6y7ie+fHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762157; c=relaxed/simple;
	bh=IPGtDwLK3LT4Vg+EcpdHrhH5PAfpluV52H4S9g/pDH8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx4lCKWLfQaTXhH6WiESjZvgj0TnWyHOP+WRbvPHz1EUqFh5awdHxY3QOZWkpkMNuIzXC9da7BjJJXq34BafShR5ILo70k78CCYiu+/CeKQZz/c6JqSVQl6kI/KFARl0vIKuSerBkLKA43VFQ59pMObUaJFflja1SjLdBBdxZb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=in7YjQuH; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="in7YjQuH"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-67109935888so1167732d50.3
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 13:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789762155; x=1790366955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OqpI7zrZtoZRaa0jid1OsqPmB6DyoQpCnujU/1Wnzyc=;
        b=in7YjQuHkKAGOajQ9HYaN/WMxSTpC8TyubrUHTfmfPgqg+dlffSfkR4j0DLcliWuba
         dm1SKgpurBLSbVnDl9fQ+r1E0Ug/oa76X9/6zg1q3rMC8k8n1C8vEJWROzemWKolb9k/
         De1Z6EP0srY/QCkmsW/K5Oy+nrTvDKPJiZHGTLnak+q0uORLIlIus3HkCO6XAqjkhPyO
         XqGXYA6bmH7GGcWwIkcv6AeiPnQH9sTM7CnJlD7Zz5nhXvzv33Hjg1xjnkdVemuizyzr
         3AIbyCw75WpLEoJ847hfzkmz6wvZzAjviwY/DX6fLgTE+FbSL4zgOvXMhw9ZnQ3lW9oa
         pxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789762155; x=1790366955;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OqpI7zrZtoZRaa0jid1OsqPmB6DyoQpCnujU/1Wnzyc=;
        b=kxxrONWtn45U/OxlZ1x5kE8Dp1cUY5t+tglSNeVjoRQoyh6NqIGNX1WPyOWMpZBUFW
         AqHYMA0B+lCoZznWjgxwYvM/kzvlDTp0F1r2ey7NktfGhnZaG6lAZBUV/A3PKFxLgqYl
         uZor7TwCPus8frJMnltaQl3Mxv+FkpwlSVRZRNBSC47K7LHTY3qlfDLGR7SxnUbTop9p
         9HbbGYPfIED+hGCrmyRhAZmkm77zZq96JICWVdImCQYwtwrQM10Q/nhF5Cdti/aVO4FC
         JtN3xNvWhxsskuzX3V/T9l6CZ38r5QQLy5QhB4AMY/kIfSJCAw+vk7XpbBO4MImL5p8h
         twag==
X-Gm-Message-State: AFuF++mb6wD4vPDzOyr/h6WPXiT79Psru8hLvyNZ4zH6V5zZ+3MeekWx
	3yaScPrnxJuUawF//HH6K0NJrs0tU2Xhu++cE6SQ3Oti86A6ZevlzohR
X-Gm-Gg: AYBFou3Kj8bIya+n/ffCXBsRZ03N72R8/51fcIG5yhntWJRxhFYlOT4DTLFPuj2VXf6
	9d31r/3wXwZ4jcNeUUzfSVG2cqg+uObAV9L/HWBF6y3LVcScpLzPtTdNSAnzPtr4LVyTuGhY7M/
	5HVE+PdZwQKRWeqZo9rKyzXMk7HAURtgG0AnkPiiKoT9UGcdYtlokXV0YJJ4tSAnp4l9uSbkVMg
	l7uukNnIZBgm9CEc0/bTiQwvWQvLOEej9BjuUMl2NVGTfxMSFKpK9d9eg3cv0KBPwNppnxhv+0F
	ZMgZTQ8YfvaBBZu9MmvLHpY7TIPslfOddlhXKm2/dlW1Bn9PREjXuHLu4xkWC1l+HbHYmhn9DTa
	bUbbLU54GGDm3ETiHvk/Hd/9CgHVM5b0Kd5X6Q972tuuLpCBC1VXLlp+Y6c6QrrGXxQPy75RKCe
	cposYNSX0JuFHWFbluH/LLcYmXfXygeUMeSnYPtqMCO1JCP+wfGFrz6apLrj4VXI2YAjQsD1sV/
	FMwaGaUnPRZ5sgPtHDIuIWyhLEVodm6E9fSXyVGK4RzqwZk5a0=
X-Received: by 2002:a05:690e:e8e:b0:671:70d2:5286 with SMTP id 956f58d0204a3-6717fd9c65bmr1055483d50.73.1789762154737;
        Fri, 18 Sep 2026 13:09:14 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672990ff9aasm392941d50.14.2026.09.18.13.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:09:13 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 18 Sep 2026 13:09:11 -0700
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, jic23@kernel.org,
	dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
	ming.li@zohomail.com, vishal.l.verma@intel.com, dave@stgolabs.net,
	benjamin.cheatham@amd.com, Ira Weiny <iweiny@kernel.org>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 2/8] cxl/mem: Read dynamic capacity
 configuration from the device
Message-ID: <aq2aZ2FxeLkv_NdJ@4470NRD-ASU.ssi.samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-4-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908102124.2231730-4-anisa.su@samsung.com>

On Tue, Sep 08, 2026 at 03:15:06AM -0700, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Devices which support Dynamic Capacity (DC) are configured
> via mailbox commands. CXL r4.0 section 9.13.3 requires the host to issue
> the Get DC Configuration command in order to properly configure DCDs.
> 
> Implement the DC mailbox commands as specified in CXL 4.0 section
> 8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
> information. Disable DCD if an invalid configuration is found.
> 
> Linux has no support for more than one dynamic capacity partition. Read
> all the partitions the device reports but validate only the first, and
> configure it as 'dynamic ram 1'.
> 
> The specification requires that volatile capacity starts at DPA 0 and pmem
> starts at the DPA immediately following it, but DC partitions only need
> to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
> So a device could leave a gap between ram/pmem (static) capacity and its first
> DC partition, or between one DC partition and the next.
> 
> However, Linux follows the precedent set by PMEM/RAM partitions and requires the
> first DC partition to begin at the DPA immediately following static
> capacity.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> 
> ---
> Changes:
> 1. mbox.c: validate only the first DC partition. Other partitions are read
>    to make it easier to add support for additional partitions but not
>    checked. Richard/Alison
> 
> 2. mbox.c: rework the cxl_dc_check() validation. Run the checks in
>    dependency order -- block size, decode length, length, base -- so the
>    block size is validated before IS_ALIGNED() uses it as an alignment,
>    and give each failure its own message naming the field that is wrong.
>    Drop the block size alignment requirement on the region base; CXL
>    r4.0 Table 8-347 requires the base to be 256M aligned and states the
>    block size alignment for extent start DPAs, not for the base.
>    Reported by Alison.
> 
> 3. mbox.c: range check the number of available DC partitions reported by
>    the device. CXL r4.0 Table 8-346 requires a DCD to report between 1
>    and 8 regions, but the count was used unchecked as the read loop
>    bound, so an out of range value failed later as "Invalid num of
>    dynamic capacity partitions". Reported by Alison.
> 
> 4. mbox.c/pci.c: cxl_configure_dcd() returns an error instead of void,
>    and cxl_pci_probe() decides what to do with it. Failure to read the
>    DC configuration is now reported rather than silently swallowed;
>    -EINVAL for a partition overlapping static capacity, -EOPNOTSUPP for
>    the gap Linux does not support, and the mailbox error propagated
>    otherwise. cxl_disable_dcd() moves to the caller so the function
>    reports and the caller sets policy. Probe still continues without
>    DCD rather than failing the memdev, which would cost the device its
>    static capacity too. Reported by Jonathan Cameron.
> 
> 5. mbox.c: check the block size is a power of 2 in 64 bits.
>    is_power_of_2() takes an unsigned long, so on a 32 bit build blk_size
>    was truncated to its low 32 bits and a value such as 0x100000040 --
>    non-zero and a multiple of 40h -- passed validation. CXL_BUS only
>    depends on PCI, so this builds on 32 bit. Reported by Sashiko.
> ---
>  drivers/cxl/core/hdm.c    |   2 +
>  drivers/cxl/core/mbox.c   | 235 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c |  37 ++++++
>  drivers/cxl/cxlmem.h      |  55 +++++++++
>  drivers/cxl/pci.c         |   6 +
>  include/cxl/cxl.h         |   3 +-
>  6 files changed, 337 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9..fdd6b395dcdf 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -643,6 +643,43 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
>  
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
> +{
> +	struct cxl_dc_partition_info dc_info = { };
> +	struct device *dev = mds->cxlds.dev;
> +	int rc;
> +
Check media_ready here, similar to cxl_mem_dpa_fetch, which doesn't configure
ram/pmem partitions if !media_ready.

	if (!mds->cxlds.media_ready)
		return 0;

Reported-by Claude with /kreview skill
(https://github.com/masoncl/review-prompts)

> +	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
> +	if (rc) {
> +		dev_warn(dev,
> +			 "Failed to read Dynamic Capacity config: %d\n", rc);
> +		return rc;
> +	}
> +
> +	if (dc_info.start < info->size) {
> +		dev_err(dev,
> +			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n",
> +			dc_info.start, info->size);
> +		return -EINVAL;
> +	}
> +
> +	/* A gap between static capacity and the DC partition is not supported */
> +	if (dc_info.start > info->size) {
> +		dev_warn(dev,
> +			 "DC partition 0 base %#llx leaves a gap from static capacity ending at %#llx\n",
> +			 dc_info.start, info->size);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	info->size += dc_info.size;
> +	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
> +		dc_info.start, dc_info.size);
> +	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_configure_dcd, "CXL");
> +
>  
>  /**
>   * cxl_set_capacity: initialize dpa by a driver without a mailbox.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0c8e23276dc6..4fac65dbb808 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -407,6 +407,8 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };
>  
> +#define CXL_MAX_DC_PARTITIONS 8
> +
>  static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  {
>  	/*
> @@ -689,6 +691,39 @@ struct cxl_mbox_set_shutdown_state_in {
>  	u8 state;
>  } __packed;
>  
> +/* See CXL r4.0 Table 8-345 get dynamic capacity config Input Payload */
> +struct cxl_mbox_get_dc_config_in {
> +	u8 partition_count;
> +	u8 start_partition_index;
> +} __packed;
> +
> +/* See CXL r4.0 Table 8-346 get dynamic capacity config Output Payload */
> +struct cxl_mbox_get_dc_config_out {
> +	u8 avail_partition_count;
> +	u8 partitions_returned;
> +	u8 rsvd[6];
> +	/* See CXL r4.0 Table 8-347 */
> +	struct cxl_dc_partition {
> +		__le64 base;
> +		__le64 decode_length;
> +		__le64 length;
> +		__le64 block_size;
> +		__le32 dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed partition[] __counted_by(partitions_returned);
> +	/* Trailing extent/tag count fields unused */
> +} __packed;
> +
> +/* Trailing counts; cannot be a member after the flex array above */
> +struct cxl_mbox_get_dc_config_tail {
> +	__le32 num_extents_supported;
> +	__le32 num_extents_available;
> +	__le32 num_tags_supported;
> +	__le32 num_tags_available;
> +} __packed;
> +#define CXL_DCD_BLOCK_LINE_SIZE 0x40
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -812,9 +847,18 @@ enum {
>  int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +
> +struct cxl_dc_partition_info {
> +	u64 start;
> +	u64 size;
> +};
> +
> +int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> +			struct cxl_dc_partition_info *dc_info);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> +int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
>  						 u16 dvsec);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> @@ -828,6 +872,17 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
>  			    const uuid_t *uuid, union cxl_event *evt);
>  int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
>  int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
> +
> +static inline bool cxl_dcd_supported(struct cxl_memdev_state *mds)
> +{
> +	return mds->dcd_supported;
> +}
> +
> +static inline void cxl_disable_dcd(struct cxl_memdev_state *mds)
> +{
> +	mds->dcd_supported = false;
> +}
> +
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..2fe9db4b3d86 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -868,6 +868,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	if (cxl_dcd_supported(mds)) {
> +		rc = cxl_configure_dcd(mds, &range_info);
> +		if (rc)
> +			cxl_disable_dcd(mds);
> +	}
> +
>  	rc = cxl_dpa_setup(cxlds, &range_info);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..4ef9511fbbdd 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -133,6 +133,7 @@ struct cxl_dpa_perf {
>  enum cxl_partition_mode {
>  	CXL_PARTMODE_RAM,
>  	CXL_PARTMODE_PMEM,
> +	CXL_PARTMODE_DYNAMIC_RAM_1,
>  };
>  
>  /**
> @@ -147,7 +148,7 @@ struct cxl_dpa_partition {
>  	enum cxl_partition_mode mode;
>  };
>  
> -#define CXL_NR_PARTITIONS_MAX 2
> +#define CXL_NR_PARTITIONS_MAX 3
>  
>  /**
>   * struct cxl_dev_state - The driver device state
> -- 
> 2.43.0
> 
