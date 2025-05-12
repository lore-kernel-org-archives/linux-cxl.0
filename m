Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9451C32FF;
	Mon, 12 May 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072054; cv=none; b=qJyV2/HeqIYenixlv79TUyjVKezy2s1acT3SI/4iGLCMe+lau0XW7S0QCTLaxKBvW4+7ViC6DEIapOmfo1OzsVgX2XMdFB8ivSb0gNLJyu0C616bgu0hAoH2broM5EZ3S9owIYqSG4hZTRpBuq57vk0gf2O1KGzITtWa5oV85nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072054; c=relaxed/simple;
	bh=PV1TfeTgXo3Miq8F1pKou4TGDQ70MOFKYLMFFLrmILs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOxkh3BdcrfcdR+/ibwFdUyniZ/jgzsEeVuq5vk2z3Chbr3FH+0pmrcps/D/wf7RKYzGc5i0EfhNXazebm1bMAQkra/XbalvIxAc4K++s6DzVdGJnpLzF32RK5MHfDlQdIktArZIvcSkBxoquumSiLmsoQ7Sxle57Hg5GiVmv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI/6grf4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI/6grf4"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23035b3edf1so10789455ad.3;
        Mon, 12 May 2025 10:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747072052; x=1747676852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HypgtS7YKITLhMNbXkMfJuxLzAcwmiO8rI/dW/dWnJk=;
        b=EI/6grf498wIs6KF3A/bg2GixrgL6xg5vOXgSPilh+hRb7uVDu4r+KJ79DiEsIfjOz
         DCxZuXRTWHbhpOTEMfmTLoydWBRWG/uzfA/4GVfaQjMxfhKFRnf1Dey8rXslxiRGiDU4
         g2mSCwwotU8l1sJlvtlyvS6JT5ON+x0+jyr+qRBwxY5WWwvyi1/HsEpS7kp3iqh0vf+0
         TaeJGpf082tNLBzHMgiRgYRiaSGZk2p93raIhYfq81x2OwOlTlC7co/maJ6fO9ow2tDJ
         aIFjjjtz5i2RfhoNtyY2FD85CT9pyhMgGvlmUk0BMdSaW/qYBXiH2O7xwB+LgdxzPrvJ
         VyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747072052; x=1747676852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HypgtS7YKITLhMNbXkMfJuxLzAcwmiO8rI/dW/dWnJk=;
        b=dmcFptMjmK4KxkyufTnjbAqr1qKy3jiOsuIoCUAhb1O3SwKEaG//OR5rWBn8FJGlA+
         l7f1Vv2fQcIZaPRz7tGK5dqHGNxX/+qp4w4mQX7rOBf2wZAPozAzQ3CKkeCcmfPc/xvG
         Eu+K3le4zdAwbuwFPsD+yIOpLcsby3WtxthDgs9ACq0e+4PizIToW/+w44HHXMloZo+y
         9+rWIjZ1SszZO5TwGz0eRXittNmHn28l0y7NlhaKQ5QFkVzwjQ14O88hxdv0RI9lLnMr
         G5mjqCAmCI2/KHvjgSnR020wIMwuQ6TVaT8iSrsGPWOgC+tLTpL879/wfwcN8SllOLYG
         /eGw==
X-Forwarded-Encrypted: i=1; AJvYcCU+D7PaUekxMrY5PUvKekDieq4Xgawt3EqJCqF1Qc7TxGr8oWDEK3SM7jGrypyHod5zg2I3/WrxFwA=@vger.kernel.org, AJvYcCX2UVNSx1hUxS7BDhrt6MsVX/XOw19EwJsOohAzTTLzvueyEBFBo/pt+8s9rpA0GP89rIVb/7g2A5S5IPhY@vger.kernel.org
X-Gm-Message-State: AOJu0YxgobWWNcNvig4Z/PxEzl3BhCnAmhFLkd8JNe0kY7xay6ovz99w
	fSxvI0PdBBZpNfIR9LLy0wVB+9+aIW/4A4KDmxsSuUkTUtNXk4WT5PbcRg==
X-Gm-Gg: ASbGncteFYnQJciYABXQgur2cwNrbUeHS7bu4M+ibqYofnYdiXw27eTeUjDVXaATupz
	iRoswnvxDB54Tq1BO1FHO5BzRUKMw7b+YzW5W4PXk3ztFpg+1zrSvmNfo/Nh6276616ynrC4zeA
	/ILJCloiPMK+qXK9Wp8BM3c5hpv3y69FZyHOQpYhoRkPR28dozF0ZWasFAUO+TgOpXxlso0rsPJ
	dg6XeE+vwUp9wAK+/mEWEIu7LFM+R+AyiPgN4wTk5d7PBixN2ghjjkqDrJSl7TdYzeIO1LfayYO
	k7NmONlkfY9GI33v2iT7d/srxU3E7+V5X5k74y0XanJCJc1RqdgkL14=
X-Google-Smtp-Source: AGHT+IFZtNDdN2Gq2dB75z4Ec7mMFB9Q1ilvVpGe8e0DJH90CZGTb4Kh+1fOyk61XygKwdJ9TeKNng==
X-Received: by 2002:a17:902:da90:b0:22e:3b02:c094 with SMTP id d9443c01a7336-22fc8b107a0mr173859635ad.8.1747072051567;
        Mon, 12 May 2025 10:47:31 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b3a0sm66330515ad.179.2025.05.12.10.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 10:47:31 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 12 May 2025 17:47:16 +0000
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v9 12/19] cxl/extent: Process dynamic partition events
 and realize region extents
Message-ID: <aCI0JC88vIhcTGNH@smc-140338-bm01>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
 <20250413-dcd-type2-upstream-v9-12-1d4911a0b365@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413-dcd-type2-upstream-v9-12-1d4911a0b365@intel.com>

On Sun, Apr 13, 2025 at 05:52:20PM -0500, Ira Weiny wrote:
> A dynamic capacity device (DCD) sends events to signal the host for
> changes in the availability of Dynamic Capacity (DC) memory.  These
> events contain extents describing a DPA range and meta data for memory
> to be added or removed.  Events may be sent from the device at any time.
> 
...
> Tag support within the DAX layer is not yet supported.  To maintain
> compatibility with legacy DAX/region processing only tags with a value
> of 0 are allowed.  This defines existing DAX devices as having a 0 tag
> which makes the most logical sense as a default.
> 
> Process DCD events and create region devices.
> 
> Based on an original patch by Navneet Singh.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
Hi Ira,
I have some comments inline. 
There is one that will need to fix if I understand the code correctly.

> ---
> Changes:
> [iweiny: rebase]
> [djbw: s/region/partition/]
> [iweiny: Adapt to new partition arch]
> [iweiny: s/tag/uuid/ throughout the code]
> ---
>  drivers/cxl/core/Makefile |   2 +-
>  drivers/cxl/core/core.h   |  13 ++
>  drivers/cxl/core/extent.c | 366 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/mbox.c   | 292 +++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/region.c |   3 +
>  drivers/cxl/cxl.h         |  53 ++++++-
>  drivers/cxl/cxlmem.h      |  27 ++++
>  include/cxl/event.h       |  31 ++++
>  tools/testing/cxl/Kbuild  |   3 +-
>  9 files changed, 786 insertions(+), 4 deletions(-)
...  
> +static int send_one_response(struct cxl_mailbox *cxl_mbox,
I feel like the name is not that informative, maybe 
send_one_dc_response?
> +			     struct cxl_mbox_dc_response *response,
> +			     int opcode, u32 extent_list_size, u8 flags)
> +{
> +	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = opcode,
> +		.size_in = struct_size(response, extent_list, extent_list_size),
> +		.payload_in = response,
> +	};
> +
> +	response->extent_list_size = cpu_to_le32(extent_list_size);
> +	response->flags = flags;
> +	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +}
> +
> +static int cxl_send_dc_response(struct cxl_memdev_state *mds, int opcode,
> +				struct xarray *extent_array, int cnt)
> +{
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +	struct cxl_mbox_dc_response *p;
> +	struct cxl_extent *extent;
> +	unsigned long index;
> +	u32 pl_index;
> +
> +	size_t pl_size = struct_size(p, extent_list, cnt);
> +	u32 max_extents = cnt;
> +
> +	/* May have to use more bit on response. */
> +	if (pl_size > cxl_mbox->payload_size) {
> +		max_extents = (cxl_mbox->payload_size - sizeof(*p)) /
> +			      sizeof(struct updated_extent_list);
> +		pl_size = struct_size(p, extent_list, max_extents);
> +	}
> +
> +	struct cxl_mbox_dc_response *response __free(kfree) =
> +						kzalloc(pl_size, GFP_KERNEL);
> +	if (!response)
> +		return -ENOMEM;
> +
> +	if (cnt == 0)
> +		return send_one_response(cxl_mbox, response, opcode, 0, 0);
> +
> +	pl_index = 0;
> +	xa_for_each(extent_array, index, extent) {
> +		response->extent_list[pl_index].dpa_start = extent->start_dpa;
> +		response->extent_list[pl_index].length = extent->length;
> +		pl_index++;
> +
> +		if (pl_index == max_extents) {
> +			u8 flags = 0;
> +			int rc;
> +
> +			if (pl_index < cnt)
> +				flags |= CXL_DCD_EVENT_MORE;
> +			rc = send_one_response(cxl_mbox, response, opcode,
> +					       pl_index, flags);
> +			if (rc)
> +				return rc;
> +			cnt -= pl_index;
> +			pl_index = 0;

The logic here seems incorrect. 
Let's say cnt = 8, and max_extents = 5.
For the first 5 extents, it works fine. But after the first 5 extents
are processed (response sent), the cnt will become 8-5=3, however,
max_extents is still 5, so there is no chance we can send response for
the last 3 extents.
I think we need to update max_extents based on "cnt" after each
iteration.

> +		}
> +	}
> +
> +	if (!pl_index) /* nothing more to do */
> +		return 0;
...
> +/*
> + * Add Dynamic Capacity Response
> + * CXL rev 3.1 section 8.2.9.9.9.3; Table 8-168 & Table 8-169
> + */
> +struct cxl_mbox_dc_response {
> +	__le32 extent_list_size;

As jonathan mentioned, "size" may be not a good name.
Maybe "nr_extents"?

Fan
> +	u8 flags;
> +	u8 reserved[3];
> +	struct updated_extent_list {
> +		__le64 dpa_start;
> +		__le64 length;
> +		u8 reserved[8];
> +	} __packed extent_list[];
> +} __packed;
> +
>  struct cxl_mbox_get_supported_logs {
>  	__le16 entries;
>  	u8 rsvd[6];
> @@ -644,6 +662,14 @@ struct cxl_mbox_identify {
>  	UUID_INIT(0xfe927475, 0xdd59, 0x4339, 0xa5, 0x86, 0x79, 0xba, 0xb1, \
>  		  0x13, 0xb7, 0x74)
>  
> +/*
> + * Dynamic Capacity Event Record
> + * CXL rev 3.1 section 8.2.9.2.1; Table 8-43
> + */
> +#define CXL_EVENT_DC_EVENT_UUID                                             \
> +	UUID_INIT(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f, 0x95, 0x26, 0x8e, \
> +		  0x10, 0x1a, 0x2a)
> +
>  /*
>   * Get Event Records output payload
>   * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> @@ -669,6 +695,7 @@ enum cxl_event_log_type {
>  	CXL_EVENT_TYPE_WARN,
>  	CXL_EVENT_TYPE_FAIL,
>  	CXL_EVENT_TYPE_FATAL,
> +	CXL_EVENT_TYPE_DCD,
>  	CXL_EVENT_TYPE_MAX
>  };
>  
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index f9ae1796da85..0c159eac4337 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -108,11 +108,42 @@ struct cxl_event_mem_module {
>  	u8 reserved[0x2a];
>  } __packed;
>  
> +/*
> + * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-51
> + */
> +struct cxl_extent {
> +	__le64 start_dpa;
> +	__le64 length;
> +	u8 uuid[UUID_SIZE];
> +	__le16 shared_extn_seq;
> +	u8 reserved[0x6];
> +} __packed;
> +
> +/*
> + * Dynamic Capacity Event Record
> + * CXL rev 3.1 section 8.2.9.2.1.6; Table 8-50
> + */
> +#define CXL_DCD_EVENT_MORE			BIT(0)
> +struct cxl_event_dcd {
> +	struct cxl_event_record_hdr hdr;
> +	u8 event_type;
> +	u8 validity_flags;
> +	__le16 host_id;
> +	u8 partition_index;
> +	u8 flags;
> +	u8 reserved1[0x2];
> +	struct cxl_extent extent;
> +	u8 reserved2[0x18];
> +	__le32 num_avail_extents;
> +	__le32 num_avail_tags;
> +} __packed;
> +
>  union cxl_event {
>  	struct cxl_event_generic generic;
>  	struct cxl_event_gen_media gen_media;
>  	struct cxl_event_dram dram;
>  	struct cxl_event_mem_module mem_module;
> +	struct cxl_event_dcd dcd;
>  	/* dram & gen_media event header */
>  	struct cxl_event_media_hdr media_hdr;
>  } __packed;
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 387f3df8b988..916f2b30e2f3 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -64,7 +64,8 @@ cxl_core-y += $(CXL_CORE_SRC)/cdat.o
>  cxl_core-y += $(CXL_CORE_SRC)/ras.o
>  cxl_core-y += $(CXL_CORE_SRC)/acpi.o
>  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
> -cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
> +cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o \
> +				 $(CXL_CORE_SRC)/extent.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>  cxl_core-y += config_check.o
> 
> -- 
> 2.49.0
> 

-- 
Fan Ni (From gmail)
