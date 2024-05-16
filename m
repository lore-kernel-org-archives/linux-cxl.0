Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF631362;
	Thu, 16 May 2024 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715824883; cv=none; b=dcW/TpVJtmHT/9YX1N/Me0XIX1e7aIWnuJ2nUagy9itFQKjfwExffeg3Mb0eS+KjKZnES1sT/foa+CK9BPyFS45ObMD8ITpaRXXKHoVCk9I+K0K4T75ObGFrnpk/MuOMy+tEZLCTrHcZ+chjua6qGjsVOstDP1cggjGjzpQufkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715824883; c=relaxed/simple;
	bh=D5hIBH/xrIU5xGjpWSXQPtBqiEprNo+HFshmxHFLBS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8l4+hk43o855CxCBv/LftIawLMXxUfsD4dnu9eSaKB4/kkenAZZHoUJGP6K/uyvPwVBgx9D74vOEPuMbBmNkmRpjRnIrQngcSLOG8sLtoO0KmhSApHpA0faGDR+PkuffqO+Dm98RpXwZemdKkO0c8mFUmJcReA7Wr22/OJzjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Itcu+hVQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Itcu+hVQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715824882; x=1747360882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D5hIBH/xrIU5xGjpWSXQPtBqiEprNo+HFshmxHFLBS8=;
  b=Itcu+hVQU4UclbNmVX/cA2NLdbTjJZYn9kvuMX783+JgWWooGjEavQ30
   y8kj6V/dsMBwkaDtbri44nmMfXcr7Uzr3WpBjltfybKdHUFS8WrDHnty0
   UcG9rEzhmF9Eho7TMHZRbPVUeG71YZditpXmS9RnBrm3sgYEY8uGTe1mQ
   voLe4Xf92bg1UPzeWdsPWBG+sBiQX0PVEhyGqLpq+evjlUt3CcyMKVvDz
   s4L+qdS290uELby7ZRhb6hDC3Pxy7lrHD3qrlttRti6Cn+eJOPnE5xdYv
   A/nanlhh+GmET9iYachqfu5/GIHIndPNqGs83FOzhxoe9OgNfd09JloVq
   w==;
X-CSE-ConnectionGUID: OJLs31dDRhWeNXdKvc1GGg==
X-CSE-MsgGUID: ydL7q1TBR62Ye9fwGLgNNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23313204"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="23313204"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 19:01:20 -0700
X-CSE-ConnectionGUID: wjIc16IFS7ubpe64n08wAg==
X-CSE-MsgGUID: C5LrK5snSJO7G05zNkNs1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="68711558"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.19.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 19:01:20 -0700
Date: Wed, 15 May 2024 19:01:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <ZkVo7molzy8diF2p@aschofie-mobl2>
References: <20240515190512.3480817-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515190512.3480817-1-fabio.m.de.francesco@linux.intel.com>

On Wed, May 15, 2024 at 09:04:53PM +0200, Fabio M. De Francesco wrote:
> Use cxl_event_media as a common structure to record information about DRAM
> and General Media events because it simplifies handling the two events.
> 

Fabio,

Thanks! I think this header file cleanup warrants a fixes tag.
Try prefacing the above log message with something like:
"struct cxl_event_common was a poor naming choice and causes confusion
with the existing Common Event Record."

Fixes: 6aec00139d3a ("cxl/core: Add region info to cxl_general_media and cxl_dram events")

-- Alison

> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/mbox.c      |  6 ++--
>  drivers/cxl/core/trace.h     |  4 +--
>  include/linux/cxl-event.h    | 70 +++++++++++++++---------------------
>  tools/testing/cxl/test/mem.c |  4 +--
>  4 files changed, 36 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..ad4d7b0f7f4d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -875,16 +875,16 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		guard(rwsem_read)(&cxl_region_rwsem);
>  		guard(rwsem_read)(&cxl_dpa_rwsem);
>  
> -		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
> +		dpa = le64_to_cpu(evt->media_common.phys_addr) & CXL_DPA_MASK;
>  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
>  		if (cxlr)
>  			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>  
>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> -						&evt->gen_media);
> +						&evt->media_general);
>  		else if (event_type == CXL_CPER_EVENT_DRAM)
> -			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
> +			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->media_dram);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 07a0394b1d99..2c7293761bb2 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -316,7 +316,7 @@ TRACE_EVENT(cxl_generic_event,
>  TRACE_EVENT(cxl_general_media,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_gen_media *rec),
> +		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_media *rec),
>  
>  	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
>  
> @@ -413,7 +413,7 @@ TRACE_EVENT(cxl_general_media,
>  TRACE_EVENT(cxl_dram,
>  
>  	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> -		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_dram *rec),
> +		 struct cxl_region *cxlr, u64 hpa, struct cxl_event_media *rec),
>  
>  	TP_ARGS(cxlmd, log, cxlr, hpa, rec),
>  
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 60b25020281f..e417556cc120 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -32,41 +32,38 @@ struct cxl_event_generic {
>   * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
> -struct cxl_event_gen_media {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> -	u8 device[3];
> -	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> -	u8 reserved[46];
> -} __packed;
> -
>  /*
>   * DRAM Event Record - DER
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
>   */
>  #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
> -struct cxl_event_dram {
> +struct cxl_event_media {
>  	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> -	u8 nibble_mask[3];
> -	u8 bank_group;
> -	u8 bank;
> -	u8 row[3];
> -	u8 column[2];
> -	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> -	u8 reserved[0x17];
> +	struct_group_tagged(cxl_event_media_hdr, media_hdr,
> +		__le64 phys_addr;
> +		u8 descriptor;
> +		u8 type;
> +		u8 transaction_type;
> +		u8 validity_flags[2];
> +		u8 channel;
> +		u8 rank;
> +	);
> +	union {
> +		struct_group(general,
> +			u8 device[3];
> +			u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
> +			u8 gen_reserved[46];
> +		);
> +		struct_group(dram,
> +			u8 nibble_mask[3];
> +			u8 bank_group;
> +			u8 bank;
> +			u8 row[3];
> +			u8 column[2];
> +			u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
> +			u8 dram_reserved[0x17];
> +		);
> +	};
>  } __packed;
>  
>  /*
> @@ -95,21 +92,12 @@ struct cxl_event_mem_module {
>  	u8 reserved[0x3d];
>  } __packed;
>  
> -/*
> - * General Media or DRAM Event Common Fields
> - * - provides common access to phys_addr
> - */
> -struct cxl_event_common {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -} __packed;
> -
>  union cxl_event {
>  	struct cxl_event_generic generic;
> -	struct cxl_event_gen_media gen_media;
> -	struct cxl_event_dram dram;
> +	struct cxl_event_media media_general;
> +	struct cxl_event_media media_dram;
>  	struct cxl_event_mem_module mem_module;
> -	struct cxl_event_common common;
> +	struct cxl_event_media media_common;
>  } __packed;
>  
>  /*
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 6584443144de..0a8fd145c391 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -378,7 +378,7 @@ struct cxl_event_record_raw hardware_replace = {
>  
>  struct cxl_test_gen_media {
>  	uuid_t id;
> -	struct cxl_event_gen_media rec;
> +	struct cxl_event_media rec;
>  } __packed;
>  
>  struct cxl_test_gen_media gen_media = {
> @@ -402,7 +402,7 @@ struct cxl_test_gen_media gen_media = {
>  
>  struct cxl_test_dram {
>  	uuid_t id;
> -	struct cxl_event_dram rec;
> +	struct cxl_event_media rec;
>  } __packed;
>  
>  struct cxl_test_dram dram = {
> -- 
> 2.45.0
> 
