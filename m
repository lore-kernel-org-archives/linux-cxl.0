Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDD1946D8;
	Wed,  5 Jun 2024 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587009; cv=none; b=E/qcsCmocKvMazeDcNnKirA7sUL5R8/dXcfpPJwiEaNzNN9r1Hmn5fii/6EIw28FoXJIYbYGV/a9oqHarccsDq8OXsyQFeeQ+w6VcOV9v3H63Z3Ym00H9xDdaHAxOk64WxLKEUfsPX5Ly5Vr9mLrJRX80Pz3SHN369mlgr2nt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587009; c=relaxed/simple;
	bh=zwnHaQ1ZmkNlUtS7++VTNPOg3xHBKHbpyAnauLX24ug=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddk7T8q1nWX+wNChhKXpxI7IMygnO4pC/WNdnxNpmR7sg7GhQq7KNgAnVxZae5lvJ43Tp32LNLkjfroXaZe3+v1wZkUGktFy6CyfaMv8fVHFvR2obPa9XiQCuy/cxld6/EBzz9BnLt0JraCrLaugj2ZpuyUw9pRPcNGdnRSnxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvQ9y0Rkzz6K6SB;
	Wed,  5 Jun 2024 19:25:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E68C71400C9;
	Wed,  5 Jun 2024 19:30:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 12:30:01 +0100
Date: Wed, 5 Jun 2024 12:30:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <20240605123000.00001e8f@Huawei.com>
In-Reply-To: <20240602191238.27712-1-fabio.m.de.francesco@linux.intel.com>
References: <20240602191238.27712-1-fabio.m.de.francesco@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun,  2 Jun 2024 21:12:25 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> cxl_event_common was an unfortunate naming choice and caused confusion with
> the existing Common Event Record. Furthermore, its fields didn't map all
> the common information between DRAM and General Media Events.
> 
> Remove cxl_event_common and introduce cxl_event_media_hdr to record common
> information between DRAM and General Media events.
> 
> cxl_event_media_hdr, which is embedded in both cxl_event_gen_media and
> cxl_event_dram, leverages the commonalities between the two events to
> simplify their respective handling.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> - Changes for v6 -
> 
> 	- Add "Reviewed-by" tags
Hi Fabio,

Adding tags doesn't need a new version. b4 or however Dave is picking these
up will gather them up from the v5 posting.

My one nervousness about this is the impression it perhaps gives that the contents
of validity flags has the same meaning in both records.

Maybe a comment to that effect next to it's definition makes sense?

I think the alternative of not including that or the remaining elements in
your common structure would be worse.

Jonathan




> 
> - Changes for v5 -
> 
> 	- Rebase on v6.10-rc1
> 
> - Changes for v4 -
> 
>         - Initialise cxl_test_dram and cxl_test_gen_media without 
>           unnecessary extra de-references (Dan)
>         - Add a comment for media_hdr in union cxl_event (Alison)
> 
> - Changes for v3 -
> 
>         - Rework the layout of cxl_event_dram and cxl_event_gen_media to
>           make a simpler change (Dan)
>         - Remove a "Fixes" tag (Dan)
>         - Don't use unnecessary struct_group[_tagged] (Jonathan, Ira)
>         - Rewrite end extend the commit message
> 
> - Link to v4 -
> 
> https://lore.kernel.org/linux-cxl/20240521140750.26035-1-fabio.m.de.francesco@linux.intel.com/
> 
>  drivers/cxl/core/mbox.c      |  2 +-
>  drivers/cxl/core/trace.h     | 32 ++++++++++-----------
>  include/linux/cxl-event.h    | 41 ++++++++++-----------------
>  tools/testing/cxl/test/mem.c | 54 +++++++++++++++++++-----------------
>  4 files changed, 61 insertions(+), 68 deletions(-)



> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 60b25020281f..1119d0bbb091 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -21,6 +21,17 @@ struct cxl_event_record_hdr {
>  	u8 reserved[15];
>  } __packed;
>  
> +struct cxl_event_media_hdr {
> +	struct cxl_event_record_hdr hdr;
> +	__le64 phys_addr;
> +	u8 descriptor;
> +	u8 type;
> +	u8 transaction_type;
> +	u8 validity_flags[2];

Perhaps a comment to say that validity_flags meaning after bit 2
varies across the different records?

> +	u8 channel;
> +	u8 rank;
> +} __packed;
> +
>  #define CXL_EVENT_RECORD_DATA_LENGTH 0x50
>  struct cxl_event_generic {
>  	struct cxl_event_record_hdr hdr;
> @@ -33,14 +44,7 @@ struct cxl_event_generic {
>   */
>  #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
>  struct cxl_event_gen_media {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> +	struct cxl_event_media_hdr media_hdr;
>  	u8 device[3];
>  	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
>  	u8 reserved[46];
> @@ -52,14 +56,7 @@ struct cxl_event_gen_media {
>   */
>  #define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
>  struct cxl_event_dram {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -	u8 descriptor;
> -	u8 type;
> -	u8 transaction_type;
> -	u8 validity_flags[2];
> -	u8 channel;
> -	u8 rank;
> +	struct cxl_event_media_hdr media_hdr;
>  	u8 nibble_mask[3];
>  	u8 bank_group;
>  	u8 bank;
> @@ -95,21 +92,13 @@ struct cxl_event_mem_module {
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
>  	struct cxl_event_gen_media gen_media;
>  	struct cxl_event_dram dram;
>  	struct cxl_event_mem_module mem_module;
> -	struct cxl_event_common common;
> +	/* dram & gen_media event header */
> +	struct cxl_event_media_hdr media_hdr;
>  } __packed;



