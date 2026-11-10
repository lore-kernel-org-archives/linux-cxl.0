Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794315264;
	b=UF4WCY41HAnwsJbrWXTfvGOlyt9jNQIpNmURK9FdWNy/vMBeqNpHJQz/6f9bG2HWCVxv
	 nx7W4D62xgjncUQEis4UFOWvm/jQ2BHtgX2hYPpOUbzz8IAJtqhLnH7p2MIeCnP1H2Blt
	 n1mcPIaUAvBXMryKsLVUVunlADK0YvIl/K+VhxIUzcvXVgbP/y6q6ukPnomSopioNRPVa
	 DmDHCKNDxz4mOcOaQK1gPWR+/VTZART/ZL8Fpg+8U+YMuYH2TR86RZ9JiiX7kpkYUIbyz
	 6BQ2F2C7SAnna+rpIxEYuJRuGIoFMtWWaZ/XqhQiZQ8gNjv7VUJNKEmIvEiSqbSTXLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315264;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=esbC5ATjtJfqtnYU3IOp26sxPPOT8ocXoJeczCT8Gt8=;
	b=HIIuT5C2nzfa7ra4NCj5UpZx4wSZqgv0B/gxR6PKpMFrTNUH3P2FwkRnqjgekKEfFwNn
	 cYiQwyUdSARoQs8Dbm6k3L8CrOhAlwDV5dfJKTdaK6gwtf94Z3pLkYXRjtEeOSet1bc4/
	 NKW/yoh8yHVL0FQ4mpskaGW/iUNLEcqkguuTV7tjSWk6N4yVZvcE7zIu9yUETLeckFAZw
	 hDB0gBw+PipWnJsLtSlVbqQwgNjo9sUsZGtnlzl4tnYcTGkbzJirnmhcrCko/e8NEMw5+
	 uhH/rlOvxKZCB3pM8pEBWIP+kXzMEMUUADEB/Y96x/S/wr4HLM/KwxAF8fWij6PKvjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=YbiMBpJM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF49606A337;
	Tue, 10 Nov 2026 12:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FF49606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=YbiMBpJM
ARC-Seal: i=1; a=rsa-sha256; t=1794315247; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L2of3fjnq3qQavquma1tO69BfxKQS5MZGP05JaJiM9lniyCdxD7tg/k5RIqlSo9Vd8HpumM9xWZP0tRfJs85wdwRQCTxwsO+wpC76RlvRnLRKN4eKkadnOasR8t39nWHZqbHpy1w17XaX3q1Ys5Vppj9KGTX6eXSQ0qPXZgrcuE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794315247; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=esbC5ATjtJfqtnYU3IOp26sxPPOT8ocXoJeczCT8Gt8=; 
	b=jm3yICeTeAxF267qKupaVcBKxysaL020dl1Yn0HFyHwZCwOvE7ZL30yRcV6Om3lgXMFslQJlfNJKqKtdy9gw2nll5186RY2QrOaQOkUWOuw8OnNxAK75d3nqmGquFPUGG9oYMTp1ZgLotz+GvkeY1NzA3i2Pq8zPAE4+gzLGuW4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=YbiMBpJMXQXCFOUBEL96diq98ZGrg+lA9DsK2zRDJzFxXgQruxkj++qzHH4ps4JXmb1yBnjbR6GiAgx9bx+KmUiLZ/1laj+6akRuoifoOkQ32XtLo5Lz4sSJrKyTRkw+ogQmj/dfExKbJ+PbcpG3z/2ZkcgWMBYovDutM6FCG9s=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=esbC5ATjtJfqtnYU3IOp26sxPPOT8ocXoJeczCT8Gt8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794315245080595.5681826489314;
	Tue, 10 Nov 2026 04:54:05 -0800 (PST)
Message-ID: <9d83fe6d-025d-4c18-8741-24f685c1b0a7@zohomail.com>
Date: Tue, 10 Nov 2026 20:53:58 +0800
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
Subject: Re: [PATCH v5 2/3] cxl/edac: Skip event records marked NOT_REPAIRABLE
To: Jongwon Lee <ai@linux.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261108022022.3352-1-ai@linux.com>
 <20261108022022.3352-3-ai@linux.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261108022022.3352-3-ai@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112275f163ad227a945618359f5e5000039a5f8aec6dabf01a0e0bc743aeb9c84f0fea1b6b8cef5fe5b:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/8 10:20, Jongwon Lee 写道:
> Bit 1 of the DPA field in General Media and DRAM event records is the
> NOT_REPAIRABLE flag. The device sets it when the memory at that DPA
> cannot be repaired.
>
> cxl_find_rec_gen_media() and cxl_find_rec_dram() do not check this flag.
> A repair request that matches such a record passes the lookup and is
> sent to the device. Since the records are keyed by the raw DPA, this
> happens today when user space writes the DPA with bit 1 set.
>
> Skip these records in both lookups, so the repair request fails with
> -EINVAL. The trace events already show dpa_flags='NOT_REPAIRABLE' for
> them, so user space can tell before it asks for a repair.
>
> cxl_find_rec_gen_media() now reads the record, so take the xarray lock
> there too, as cxl_find_rec_dram() does. Also make it return bool, since
> its only caller just checks the result.
>
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Jongwon Lee <ai@linux.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/edac.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 4624ab4644..42683b7c54 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,24 +918,27 @@ struct cxl_mem_repair_attrbs {
>   	enum cxl_mem_repair_type repair_type;
>   };
>   
> -static struct cxl_event_gen_media *
> -cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
> -		       struct cxl_mem_repair_attrbs *attrbs)
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
> -
> -	if (attrbs->repair_type == CXL_PPR)
> -		return rec;
> +	found = rec && !cxl_rec_not_repairable(&rec->media_hdr);
> +	xa_unlock(&array_rec->rec_gen_media);
>   
> -	return NULL;
> +	return found;
>   }
>   
>   /* Caller holds the xarray lock. The record may be freed once it is dropped. */
> @@ -949,7 +952,7 @@ __cxl_find_rec_dram(struct xarray *rec_xarray,
>   	lockdep_assert_held(&rec_xarray->xa_lock);
>   
>   	rec = xa_load(rec_xarray, attrbs->dpa);
> -	if (!rec)
> +	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
>   		return NULL;
>   
>   	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
