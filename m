Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793866873;
	b=ZgoSXJx923CzZKloQP7k7yVkcTHHDOeAdOm75riJCdb/Hwft/+L/NiIsH5NHaP37t9xc
	 24eaPA9mzudK0zI/siV5kgkvJG98Ge0ANAMS6VEyBdiBRnQBgruPgUgjOi060ZDZKfVw9
	 +l23tofmIPJNg91OxVhrfgyh/qkrC2qkVBACin5M1+ION5vLH0cDkondnjNN6Tn4Da/fZ
	 NzSANg40psxQsVR6d5YrDBjWAXU6ZtsJPU1C5620r1RTHOuZCUmHcwH4Str7rWb0t66Fs
	 q0XhvMMtrBNZegDfgCiquStafDSq4ZEYltObkbJDu53JbvVtj/qO/Rg7BZNJkGTiR+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866873;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=MhqTaeYg8C0cA2ARimiJcpcf7M5ITCUmL70CiSxA+7I=;
	b=xzoCPp/1yoQW2j80W+nwfz5A0C0cgObltCTL7HuGhfZhNkBelCI9fXhuH7J9ymHOsG5q
	 QYjuWzWmaBqQwponjIclzYKVCaF/SKc67RMteH+AVw2FDhx8EyNdsI/WM+sV5q7BSD9QB
	 tQ87jEx7JPcNh2jFiBn2hJ1LvbQT2HcAZpcpUNxAK3XHiZwyumm+jBG/vXIr5OIu4OFoL
	 1eMZRKB0j/8n1gjdlxMUd2+OVVUYuMpkrEjGGUrICfrOszU1jr3h4X7eyHBjctNWBrqt5
	 P9ewL/+CaVGTpl9E0nn/43hbt+S1PKZMqOZgnAhRC7wbuVpv+P2YmK4FOPXQtcvXwfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=VsEfUwTV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC945606A31B;
	Thu,  5 Nov 2026 08:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC945606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=VsEfUwTV
ARC-Seal: i=1; a=rsa-sha256; t=1793866864; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eETmFpCRCWoRk1ooHqCzu0HoTfYD4SEtwaNU3JzCqInnu6AuV7ynOSblFWiX6sewRIL2iw+FtigYb1EMJ5E7Nu2WdbRIzHlWeVNumA5C5RdcJKrXc+Oyoz44bJqaEKQouWjyEyobSdhdBwF2Jehwla0tiapA7o86hO4hAC6JRVU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793866864; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MhqTaeYg8C0cA2ARimiJcpcf7M5ITCUmL70CiSxA+7I=; 
	b=OtCT+TRFsgfon0WIyWOKMZu9cfMa9OVfk6ZmxwjHCSV5bklMJBPVKXnYktYSq2lGYi3v8dBQ/C8IE7t1hOiMeR+B2iqkjVEnv5gDoisnRnlX0F541aXFrrtZdfEw0yzPz8Et9bgAnk3UvKr+AATHPLzBUxX6nWvL5M5OOVjYMRo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=VsEfUwTVea0kiINsjl2vk0cEm3agjhR3bCuzZ3bYWQsm1EuCa2Q2mWOhkkMQo+bfCn1QdqQQ/bm84tQFSX5hx2Ukr70Zv2Z98GfbQvFtKAwBnvsaBZx5UjijRVa1SSUs4RjkJaW3jdvaY66gCuotIzEFXd+UT96+cu6lyrrVC2U=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=MhqTaeYg8C0cA2ARimiJcpcf7M5ITCUmL70CiSxA+7I=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793866863229960.8149995318363;
	Thu, 5 Nov 2026 00:21:03 -0800 (PST)
Message-ID: <f4be9108-e5ea-4e6d-bd6d-0af14f28951d@zohomail.com>
Date: Thu, 5 Nov 2026 16:20:57 +0800
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
Subject: Re: [PATCH v4 2/2] cxl/edac: Mask DPA flags in the event record cache
 key
To: Jongwon Lee <ai@linux.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261102123233.74598-1-ai@linux.com>
 <20261102123233.74598-3-ai@linux.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261102123233.74598-3-ai@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu0801122706e1e922292410484dd909d50000064883799090bb172ba4cbe04a354fc87666834b4b216388b1:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/2 20:32, Jongwon Lee 写道:
> The low bits of the DPA in a General Media or DRAM event record are
> flags: bit 0 is VOLATILE and bit 1 is NOT_REPAIRABLE. The trace events
> report the DPA with CXL_DPA_MASK applied, but cxl_store_rec_gen_media()
> and cxl_store_rec_dram() use the raw value as the xarray key.
>
> User space reads the DPA from the trace event and writes it to the
> mem_repair dpa attribute. If the record had any flag set, xa_load()
> misses it and the repair fails with -EINVAL. The raw key also lets a
> repair go through for a record the device marked NOT_REPAIRABLE, if the
> DPA is written with bit 1 set.
>
> Key the records by the masked DPA and skip records marked
> NOT_REPAIRABLE. cxl_find_rec_gen_media() now reads the record, so do
> the lookup under the xarray lock as cxl_find_rec_dram() does, and
> return a bool since its only caller tests the result.
>
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Jongwon Lee <ai@linux.com>
> ---
>   drivers/cxl/core/edac.c | 43 ++++++++++++++++++++++++++---------------
>   1 file changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index c5c8dda20e..a5f198b561 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,24 +918,37 @@ struct cxl_mem_repair_attrbs {
>   	enum cxl_mem_repair_type repair_type;
>   };
>   
> -static struct cxl_event_gen_media *
> -cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> -		       struct cxl_mem_repair_attrbs *attrbs)
> +/*
> + * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
> + * Records are looked up by the DPA user space writes back, which comes from
> + * the trace event and has the flags masked off, so key them the same way.
> + */
> +static inline unsigned long cxl_rec_key(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
> +}

This function actually returns the real DPA of the event record, I think 
the name should be cxl_rec_dpa()? xa_load() uses attrbs->dpa as the 
index, but xa_store() uses cxl_rec_key() as the index, that could make 
readers confused.


> +
> +static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
> +}
> +
> +static bool cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> +				   struct cxl_mem_repair_attrbs *attrbs)
>   {
>   	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
>   	struct cxl_event_gen_media *rec;
> +	bool found;
>   
> -	if (!array_rec)
> -		return NULL;
> +	if (!array_rec || attrbs->repair_type != CXL_PPR)
> +		return false;
>   
> +	xa_lock(&array_rec->rec_gen_media);
>   	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
> -	if (!rec)
> -		return NULL;
> +	found = rec && !cxl_rec_not_repairable(&rec->media_hdr);
> +	xa_unlock(&array_rec->rec_gen_media);
>   
> -	if (attrbs->repair_type == CXL_PPR)
> -		return rec;
> -
> -	return NULL;
> +	return found;
>   }

I think the implementation of skipping unrepairable records should be 
moved into a separate patch, and this patch focuses on using real DPA as 
the index parameter of the xarray.

My first feeling is that we should not simply ignore unrepairable 
records without any logs. But I am not very familiar with this area, not 
sure if we should report this repairable bit in trace log or output a 
kernel log while finding an unrepairable record.

Let us see if maintainers have more comments on that.


Ming

>   
>   /* Caller holds the xarray lock. The record may be freed once it is dropped. */
> @@ -949,7 +962,7 @@ __cxl_find_rec_dram(struct xarray *rec_xarray,
>   	lockdep_assert_held(&rec_xarray->xa_lock);
>   
>   	rec = xa_load(rec_xarray, attrbs->dpa);
> -	if (!rec)
> +	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
>   		return NULL;
>   
>   	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
> @@ -1130,8 +1143,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>   		return -ENOMEM;
>   
>   	old_rec = xa_store(&array_rec->rec_gen_media,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
>   	if (xa_is_err(old_rec)) {
>   		kfree(rec);
>   		return xa_err(old_rec);
> @@ -1160,8 +1172,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>   		return -ENOMEM;
>   
>   	old_rec = xa_store(&array_rec->rec_dram,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_key(&rec->media_hdr), rec, GFP_KERNEL);
>   	if (xa_is_err(old_rec)) {
>   		kfree(rec);
>   		return xa_err(old_rec);
