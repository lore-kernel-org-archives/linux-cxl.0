Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7234A15;
	Thu, 16 May 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877206; cv=none; b=Kd4dJNHxnkwAoYPzqsUEZVdqb1ggHTAV+CS/WvdTh7yLLRh2bdTjJAbz3/Fa9kZnW7msho/Rl1xAsbZqA+g0K6ROd3Ne+ipeJ4aH3MKjj8PbATj80may5A4V9Gdy3E6wBSoZBcrFK1L/HWMfYgEq9P71+rqdNJPmlyf8ZPHabL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877206; c=relaxed/simple;
	bh=HyxKbm7lvP7BZCmAfJtpChzelCXKU4ecBlBVnNw5c5Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boDv3wX235W+ASRkLqiQ2Fy+cc/mEy6bivQL4ZvsMG4HGicSPObKMgbTZp6wZwOLnjYAZOwPp5jur6o2KYzXKkivWaNBlNtC9yEsnSIN/lC1CvVzq/gy8prUHINmbkhMNLVFxhS8MHMko9yNqCspvYccpihuMZhLaWqdpH6hT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VgFxh1rKGz6J7yy;
	Fri, 17 May 2024 00:32:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 84B04140594;
	Fri, 17 May 2024 00:33:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 16 May
 2024 17:33:21 +0100
Date: Thu, 16 May 2024 17:33:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <20240516173319.00007429@Huawei.com>
In-Reply-To: <20240516102116.3512377-1-fabio.m.de.francesco@linux.intel.com>
References: <20240516102116.3512377-1-fabio.m.de.francesco@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 16 May 2024 12:19:53 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> cxl_event_common was a poor naming choice and caused confusion with the
> existing Common Event Record.
> 
> Use cxl_event_media as a common structure to record information about DRAM
> and General Media events because it simplifies handling the two events.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: 6aec00139d3a ("cxl/core: Add region info to cxl_general_media and cxl_dram events")
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---

Packing question inline.

> 
> Changes for v2:
> 	- Extend the commit message (Alison);
> 	- Add a "Fixes" tag (Alison, thanks).
> 
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

Does the struct that is created end up __packed?
Also, why is tagged useful here?  

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

