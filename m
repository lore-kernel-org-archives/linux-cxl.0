Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793864575;
	b=m9rWzB0aSsQn4wGuNwfXyUq1CwWenFRxMUVuoAFg/0r8V1BHcgredDipsGsLFh2x/SAM
	 IUhHDq2KBTdi/7kCKcGk3d+pHE5lrjImdspOX9rJqY5Clc9F6Yf+VBh6MnA9eXxTysy2G
	 2MxnXsmtua9UKUlDYdwjdRDHUGZjhU4MKRVKCNtYg2X9VI2fVuEHbDeOp/8qV5obxu4kn
	 6+ka3Ov6issbU3+CH/XMinOlkiFwKlNOywrwXImbIQHGi6jImqrqtHWrQNdpzKaM6S1xl
	 pCVyirDtMpFB7yPEvG0miQtFfwJVFI5HD+HaVtvcmjhDE5eeWBoz6A3aY3f7akbfkPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864575;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=2WrpCJ3LvQXdIzhrj2s2a863Fv+7CoJ1TbJKk90Qlss=;
	b=1Y66C5aX2pwUlzTysrHiTx00rFF8wXk1X0Zz8evgxQz8YuwLivS1v3A2SpSM6ADeFK3r
	 XyOHpromTH32/gqSkHkPmn6oJHypf2e+uBfWa3BVBszozpkIvbmfkTtK4i3gTcWX/YfCM
	 jh+MCnwkcuvUaOtQ6nwVbz8mPCNyXqTtM6ODL7Johjhv1ewHi2g6FHPlCgSx3JICtHLUx
	 cM1Fon4977epHK3uL0yOEoFHeU5HCo23DNTvQU7lDVh9/rYjQhP9E6amq9oqCVNy7tb8k
	 P/GxGQ104hT5yF39uhGOH8zmdpwTHopEG03//arilNLs4xND/VlV11+yamWMPx8rNqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Er9VxpkF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A088606A31B;
	Thu,  5 Nov 2026 07:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A088606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Er9VxpkF
ARC-Seal: i=1; a=rsa-sha256; t=1793864561; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZzYNY641QjuTJR3B0kKUEb8/znvUBZ2vwkTRw5qI9MfzDmuRVX3Y9AfN3HeCnrKH5l3RqZoB4aONRjv5zSMCSakidr59TCQyNISCdN19E1lFxMaK+1wZVv6juJXeRwehV1VS/T67vqq3m/U6VoHNYfdeT59BQaxqS+K2egGg/lE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793864561; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2WrpCJ3LvQXdIzhrj2s2a863Fv+7CoJ1TbJKk90Qlss=; 
	b=DfahHT1dryq3rCBepupPqTPUxVJuFQOLLeSNtXtrJxxH5z9AmThanN7g+Qm9BE6WSgBy3Q+++Klz4LolK2pGN/AU8JLiq8dRMM1ccuxrMS2Pxz9RUWxzNnF67P3OORU09iG43/7nQZjN23+tQErTX049Fcs6V6XOMUo/chSzx6Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=Er9VxpkFfyWxdzBTQc+pIwjkVhoGb7XL0sd3KJrK4j2nSFvBmjYiZSiP8JCpc5fWFy/Zo8zPnrLDMB9oKW+qJS4RgdIAQIsaRYhHt4NBNQWY/bH+lxlf7J8mut6JNOTwZp4LQiAt5NC5gBZlrifU7lwPgimrDZCauMjYfpNdPkI=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=2WrpCJ3LvQXdIzhrj2s2a863Fv+7CoJ1TbJKk90Qlss=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793864559898533.7135209097421;
	Wed, 4 Nov 2026 23:42:39 -0800 (PST)
Message-ID: <417b4379-4f6a-4a31-b2a4-f6f84b13d362@zohomail.com>
Date: Thu, 5 Nov 2026 15:42:34 +0800
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/edac: Read cached DRAM event records under the
 xarray lock
To: Jongwon Lee <ai@linux.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261102123233.74598-1-ai@linux.com>
 <20261102123233.74598-2-ai@linux.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261102123233.74598-2-ai@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112271db85b29d7fb52001838560100009c6e52c0669c117f2864637cd13fec94f192753aeff4dbd434:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/2 20:32, Jongwon Lee 写道:
> The event path caches DRAM event records in an xarray and frees a record
> when xa_store() replaces it, when it expires and when the cache
> overflows. It runs with device_lock() and cxl_rwsem held for read.
>
> The repair path looks records up with cxl_find_rec_dram() while holding
> only cxl_rwsem for read, so the two paths can run at the same time.
> cxl_find_rec_dram() reads the record after xa_load() returns, and
> cxl_mem_perform_sparing() reads validity_flags from the returned record
> again later. Both reads can hit a record the event path has just freed.
>
> Move the lookup into __cxl_find_rec_dram(), called with the xarray lock
> held, and make cxl_find_rec_dram() return whether a record matched and
> copy the matching record into a buffer the caller passes in. The PPR
> path only needs the match and passes NULL. No caller keeps a pointer to
> the record after the lock is dropped. The event path frees a record
> only after xa_store() or xa_erase() has removed it from the xarray, and
> both take the same lock.
>
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org
> Signed-off-by: Jongwon Lee <ai@linux.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>


Just one minor comment below.

> ---
>   drivers/cxl/core/edac.c | 72 ++++++++++++++++++++++++++++-------------
>   1 file changed, 49 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 34b81e8dfb..c5c8dda20e 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -938,18 +938,17 @@ cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
>   	return NULL;
>   }
>   
> +/* Caller holds the xarray lock. The record may be freed once it is dropped. */
>   static struct cxl_event_dram *
> -cxl_find_rec_dram(struct cxl_memdev *cxlmd,
> -		  struct cxl_mem_repair_attrbs *attrbs)
> +__cxl_find_rec_dram(struct xarray *rec_xarray,
> +		    struct cxl_mem_repair_attrbs *attrbs)
>   {
> -	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>   	struct cxl_event_dram *rec;
>   	u16 validity_flags;
>   
> -	if (!array_rec)
> -		return NULL;
> +	lockdep_assert_held(&rec_xarray->xa_lock);
>   
> -	rec = xa_load(&array_rec->rec_dram, attrbs->dpa);
> +	rec = xa_load(rec_xarray, attrbs->dpa);
>   	if (!rec)
>   		return NULL;
>   
> @@ -1029,6 +1028,32 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
>   	return NULL;
>   }
>   
> +/*
> + * cxl_store_rec_dram() replaces and frees records while the repair path only
> + * holds cxl_rwsem for read, so look the record up and read it under the
> + * xarray lock, and hand back a copy of the record.
> + */
> +static bool cxl_find_rec_dram(struct cxl_memdev *cxlmd,
> +			      struct cxl_mem_repair_attrbs *attrbs,
> +			      struct cxl_event_dram *out)
> +{
> +	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
> +	struct cxl_event_dram *rec;
> +	bool found;
> +
> +	if (!array_rec)
> +		return false;
> +
> +	xa_lock(&array_rec->rec_dram);
> +	rec = __cxl_find_rec_dram(&array_rec->rec_dram, attrbs);
> +	found = rec;
> +	if (rec && out)
> +		*out = *rec;
> +	xa_unlock(&array_rec->rec_dram);
> +
> +	return found;
I think this "found" is not needed, "return rec;" or "return (rec != 
NULL);" is enough?
> +}
> +
>   #define CXL_MAX_STORAGE_DAYS 10
>   #define CXL_MAX_STORAGE_TIME_SECS (CXL_MAX_STORAGE_DAYS * 24 * 60 * 60)
>   
> @@ -1298,9 +1323,9 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
>   	return 0;
>   }
>   
> -static struct cxl_event_dram *
> -cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
> -		     struct cxl_mem_sparing_context *ctx)
> +static bool cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
> +				 struct cxl_mem_sparing_context *ctx,
> +				 struct cxl_event_dram *rec)
>   {
>   	struct cxl_mem_repair_attrbs attrbs = { 0 };
>   
> @@ -1332,10 +1357,10 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
>   		attrbs.repair_type = CXL_RANK_SPARING;
>   		break;
>   	default:
> -		return NULL;
> +		return false;
>   	}
>   
> -	return cxl_find_rec_dram(cxlmd, &attrbs);
> +	return cxl_find_rec_dram(cxlmd, &attrbs, rec);
>   }
>   
>   static int
> @@ -1344,7 +1369,8 @@ cxl_mem_perform_sparing(struct device *dev,
>   {
>   	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
>   	struct cxl_memdev_sparing_in_payload sparing_pi;
> -	struct cxl_event_dram *rec = NULL;
> +	struct cxl_event_dram rec;
> +	bool rec_found = false;
>   	u16 validity_flags = 0;
>   	int ret;
>   
> @@ -1362,11 +1388,14 @@ cxl_mem_perform_sparing(struct device *dev,
>   			return -EBUSY;
>   	} else {
>   		if (cxl_is_memdev_memory_online(cxlmd)) {
> -			rec = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx);
> -			if (!rec)
> +			rec_found = cxl_mem_get_rec_dram(cxlmd, cxl_sparing_ctx,
> +							 &rec);
> +			if (!rec_found)
>   				return -EINVAL;
>   
> -			if (!get_unaligned_le16(rec->media_hdr.validity_flags))
> +			validity_flags =
> +				get_unaligned_le16(rec.media_hdr.validity_flags);
> +			if (!validity_flags)
>   				return -EINVAL;
>   		}
>   	}
> @@ -1376,13 +1405,10 @@ cxl_mem_perform_sparing(struct device *dev,
>   	if (cxl_sparing_ctx->persist_mode)
>   		sparing_pi.flags |= CXL_SET_HARD_SPARING(1);
>   
> -	if (rec)
> -		validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> -
>   	switch (cxl_sparing_ctx->repair_type) {
>   	case EDAC_REPAIR_CACHELINE_SPARING:
>   		sparing_pi.column = cpu_to_le16(cxl_sparing_ctx->column);
> -		if (!rec || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
> +		if (!rec_found || (validity_flags & CXL_DER_VALID_SUB_CHANNEL)) {
>   			sparing_pi.flags |= CXL_SET_SPARING_SUB_CHNL_VALID(1);
>   			sparing_pi.sub_channel = cxl_sparing_ctx->sub_channel;
>   		}
> @@ -1399,9 +1425,9 @@ cxl_mem_perform_sparing(struct device *dev,
>   		fallthrough;
>   	default:
>   		sparing_pi.channel = cxl_sparing_ctx->channel;
> -		if ((rec && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
> -		    (!rec && (!cxl_sparing_ctx->nibble_mask ||
> -			     (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
> +		if ((rec_found && (validity_flags & CXL_DER_VALID_NIBBLE)) ||
> +		    (!rec_found && (!cxl_sparing_ctx->nibble_mask ||
> +				    (cxl_sparing_ctx->nibble_mask & 0xFFFFFF)))) {
>   			sparing_pi.flags |= CXL_SET_SPARING_NIB_MASK_VALID(1);
>   			put_unaligned_le24(cxl_sparing_ctx->nibble_mask,
>   					   sparing_pi.nibble_mask);
> @@ -1814,7 +1840,7 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
>   			attrbs.repair_type = CXL_PPR;
>   			attrbs.dpa = cxl_ppr_ctx->dpa;
>   			attrbs.nibble_mask = cxl_ppr_ctx->nibble_mask;
> -			if (!cxl_find_rec_dram(cxlmd, &attrbs) &&
> +			if (!cxl_find_rec_dram(cxlmd, &attrbs, NULL) &&
>   			    !cxl_find_rec_gen_media(cxlmd, &attrbs))
>   				return -EINVAL;
>   		}
