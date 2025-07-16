Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBC17A31B
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671106; cv=none; b=qEFofpD8bRbuUBRZ+37rj78VlufBDQZT2sWV0Vjmnx6rV6saRiRYIilFeFjg1qgb5rFfUT+PMLeI8EtTYRlVkG+DZrs6V70i3F16kN+pnPbhRvERHKGFGMrGR8zUJO7/txh/3pzh2tyk1th4Sv/qTut2TlYZFgIpmabCfPzgh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671106; c=relaxed/simple;
	bh=uk6Q5UI+csabL31WPrrzYHVnT/rwOJqWHcg6A+0TWaI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tK4BrkBJrhd4jKSByo3lI6c5F8/eV29ipyFSBvpm5tND2i5zX6f5/uT2ORl9mNa7Nbts1MD5P0hdMXGV1L5heNZNfpXEJIquzrGgu1wXm0vliaYkbQdXKR1wyZ+Qdu4AGq21SRDb+urH4c3B9HqFNk02KVh8+oF9Ft5QeaYq8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhx861y9fz6L5Gm;
	Wed, 16 Jul 2025 21:03:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3056314033C;
	Wed, 16 Jul 2025 21:05:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 15:05:00 +0200
Date: Wed, 16 Jul 2025 14:04:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 2/4] cxl/events: Add extra validity checks for corrected
 memory error count in General Media Event Record
Message-ID: <20250716140459.000049bc@huawei.com>
In-Reply-To: <20250716104945.2002-3-shiju.jose@huawei.com>
References: <20250716104945.2002-1-shiju.jose@huawei.com>
	<20250716104945.2002-3-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Jul 2025 11:49:43 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> According to the CXL Specification Revision 3.2, Section 8.2.10.2.1.1,
> Table 8-57 (General Media Event Record), the Corrected Memory Error Count
> field is valid under the following conditions:
> 1. The Threshold Event bit is set in the Memory Event Descriptor field, and
> 2. The Corrected Memory Error Count must be greater than 0 for events where
>    the Advanced Programmable Threshold Counter has expired.
> 
> Additionally, if the Advanced Programmable Corrected Memory Error Counter
> Expire bit in the Memory Event Type field is set, then the Threshold Event
> bit in the Memory Event Descriptor field shall also be set.
> 
> Add validity checks for the above conditions while reporting the event to
> the userspace.
> 
> Note: CXL spec rev3.2 Table 8-57. General Media Event Record
> Field: Corrected Memory Error Count at Event) "For events in which the
> advanced programmable threshold counter has expired, this field value
> shall be a value greater than 0. Counter expiration events in which
> the corrected memory error count is 0 shall not generate a media event
> record".
> Q: Should kernel drop the event record in this case or user space
> to handle?

Personally I think this is a problem for user space. I don't mind the
additional warnings though. I'd have put the question under ---
though as then, if everyone is happy no need to resend to drop the
question (or for Dave to remove it)

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/mbox.c  | 9 +++++++++
>  drivers/cxl/core/trace.h | 5 ++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2689e6453c5a..5a30d3891b17 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -926,6 +926,15 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  			if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
>  				dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
>  
> +			if (evt->gen_media.media_hdr.descriptor &
> +			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
> +				WARN_ON_ONCE((evt->gen_media.media_hdr.type &
> +					      CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
> +					     !evt->gen_media.cme_count);
> +			else
> +				WARN_ON_ONCE(evt->gen_media.media_hdr.type &
> +					     CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
> +
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>  						hpa_alias, &evt->gen_media);
>  		} else if (event_type == CXL_CPER_EVENT_DRAM) {
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a77487a257b3..c38f94ca0ca1 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -506,7 +506,10 @@ TRACE_EVENT(cxl_general_media,
>  			uuid_copy(&__entry->region_uuid, &uuid_null);
>  		}
>  		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
> -		__entry->cme_count = get_unaligned_le24(rec->cme_count);
> +		if (rec->media_hdr.descriptor & CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
> +			__entry->cme_count = get_unaligned_le24(rec->cme_count);
> +		else
> +			__entry->cme_count = 0;
>  	),
>  
>  	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \

