Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794315307;
	b=OXPwJKMwhudElEpL6uITLywXX+tQb4qqLNCp93vfxCRo5FpeWrXMkPq66bYEGAkH5w7X
	 Wr46cdjq3WEgJ7NBYLNNQaYEwhPk3rx4QQCt0sqHYXsXJiXpZ1wgvlA9jylhpbv5XV4AZ
	 6cZ++CyItO/IOSJ1VyVImsZTQmaE1Q11UbvPGFfVQzTnE5sz3Hiqkzxhdig0ZBf1s0OiZ
	 jwaU/q59OqecDmkmay3h8q5Rpj7SRA65twaw2neqHv1SldBQrJUpIiuKmvzfFyit6166b
	 InCIZSY/wySuKM1pRA8xF5dzpickZ0cwW2FoGpcPa+ca3DrOaeLewMwMJYRkyQPNSxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315307;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=0GQ5O2kKwmrg6kcTaKBTkUBP6M692ED8CxCicZsiYMg=;
	b=5aXF/7t8CmzGoygj2F4C3Nc3ww622njZozBN0BlQOT5JK2JrK09gPM5NZHkmdiJEUPaB
	 KuK63d1az04js9Fu1sgy56pQUGxNEgiHOIhKMaK/aV2JBO/qs+1kuggom44koZ9s5YsZk
	 ts1X6tehlvp+gfxjKCoeFQvc/etojwkFdNx+Gw4pLBdPc38SwZ7qDGSMR24iw0wN9qhWM
	 iW2MSzbRHLYBVpyrOqCNQQnygXVFUOiD1Bew/TSn40A2tV/bQeLc8+lMoNLLV3+Jw3KSW
	 rheI33EHNC2XqjMmSCuj4qf/FoJ1/gDG029bCGUopRhSfwJ7zllkF0KmWp50e4EqI5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=I815BIk8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576D60A2600;
	Tue, 10 Nov 2026 12:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A576D60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=I815BIk8
ARC-Seal: i=1; a=rsa-sha256; t=1794315283; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y94BJ/d0hu/ljQ4Yxrp6aA/BvOH34wxDNxYzHHDKhrnVdwxONwD6P/+T2AL7wT6+z+cOjh+D+jRcsCYlF4yjz0LDWPtww32bPIw5V8D16x0JhmfUglr9tC9wvAHa/yS1vXBqBiKlt3ZSHlsZTl8eMSZJ4lQ67RraBPTQXU9V+6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794315283; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0GQ5O2kKwmrg6kcTaKBTkUBP6M692ED8CxCicZsiYMg=; 
	b=hjTGevDhhbrsiZPnVW8oeHzIW9l2DC2E2Cdvwkejm/CCd1oevNWYszDsDwbpBZbrcSIgzBWtGaMiTOZt7sVP4URJ545UU79FU6KXZSxTZnxAWW+QC3a0wxcp+FyjZguzVw0lGJNoxy6KKI04pm4jNPqhW6ePGipWPmq+s4uIxfA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=I815BIk8Ck01D+vSY1GW88Nk761IpiALPCQaTeYJateDDS83tBm4s55KwO5+3Sg7rvd1L0GcA9wSsgLaGzVfWHTAkFu9K1JKmGsKCDK9tpY6DE+Q4guO89Hts5LvyQOCDAqiV3luJoyXUg/vhlo6L7//CTmdXQiYoJAwc0olrrU=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=0GQ5O2kKwmrg6kcTaKBTkUBP6M692ED8CxCicZsiYMg=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794315281413705.7572751268435;
	Tue, 10 Nov 2026 04:54:41 -0800 (PST)
Message-ID: <866cfed1-e55f-4f01-acbd-c29219f67e54@zohomail.com>
Date: Tue, 10 Nov 2026 20:54:37 +0800
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
Subject: Re: [PATCH v5 3/3] cxl/edac: Mask DPA flags in the event record cache
 key
To: Jongwon Lee <ai@linux.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261108022022.3352-1-ai@linux.com>
 <20261108022022.3352-4-ai@linux.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20261108022022.3352-4-ai@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227409f9b5e809833055c825ca500000bcf75c86c3758d1da631cda78326748a4312015d4a113cc6f:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/8 10:20, Jongwon Lee 写道:
> The low bits of the DPA field in General Media and DRAM event records
> are flags. Bit 0 is VOLATILE and bit 1 is NOT_REPAIRABLE. The trace
> events print the DPA with CXL_DPA_MASK applied, while
> cxl_store_rec_gen_media() and cxl_store_rec_dram() use the raw value as
> the xarray key.
>
> User space takes the DPA from the trace event and writes it to the
> mem_repair dpa attribute. If the record has any flag set, xa_load() does
> not find it and the repair fails with -EINVAL.
>
> Use the masked DPA as the key. Records marked NOT_REPAIRABLE are still
> rejected, because the lookup skips them.
>
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Jongwon Lee <ai@linux.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/edac.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 42683b7c54..f627c73ff6 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,6 +918,16 @@ struct cxl_mem_repair_attrbs {
>   	enum cxl_mem_repair_type repair_type;
>   };
>   
> +/*
> + * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
> + * Records are looked up by the DPA user space writes back, which comes from
> + * the trace event and has the flags masked off, so key them the same way.
> + */
> +static inline unsigned long cxl_rec_dpa(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
> +}
> +
>   static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
>   {
>   	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
> @@ -1131,8 +1141,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>   		return -ENOMEM;
>   
>   	old_rec = xa_store(&array_rec->rec_gen_media,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_dpa(&rec->media_hdr), rec, GFP_KERNEL);
>   	if (xa_is_err(old_rec)) {
>   		kfree(rec);
>   		return xa_err(old_rec);
> @@ -1161,8 +1170,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>   		return -ENOMEM;
>   
>   	old_rec = xa_store(&array_rec->rec_dram,
> -			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
> -			   GFP_KERNEL);
> +			   cxl_rec_dpa(&rec->media_hdr), rec, GFP_KERNEL);
>   	if (xa_is_err(old_rec)) {
>   		kfree(rec);
>   		return xa_err(old_rec);
