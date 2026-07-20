Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8B38D3E5
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784527579; cv=pass; b=Lskmg6JyAEJ/bc4OJnUIcZOrnq8PvkU89atwDEWMzQYQ3d5Wwi1PPAiKe3XbbpBSPwv6Ugyp/kpJISqoVrmxyF8g1cm+aPYCEyaxrEeh5lTutDubqw912b13z09QIRDpcoPNC/20h2KehU1HE4p0vgVOFs3zL2dQ8khxfnMBYs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784527579; c=relaxed/simple;
	bh=zfCfJuazhpNHCe0ASlzTsjwG6DuFQvMsdtvFr3Vv85A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTvhKkQ8rbIvS5gUCWolFUN+AIkkOm1GLA2yhe2TY4YDCdmmS+aJ0qnqiH0Rl/NRFvUfYMGOThQLoUPx4R0jzuHSQdzDUMOeb0q6eFq+rehVfmEExIez0qN2p2I63WdiByISVOYIYigraf5AYaDV5NPo2mZ8371H3AXtb1zbuC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=TuhlXNOo; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="TuhlXNOo"
ARC-Seal: i=1; a=rsa-sha256; t=1784527563; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l7q5QK4Pjnl4DI4R4cmBoGMuMNCKLblQrju+jnTCkCERQzIbZg7F00Uj3NhLLJotT9vGuU4z2ttjspX9JWOfVr2+7dPMMDCzmSpLk1Gyc5ALQhCjKvTNxkDIsrEO3zjK7noXaZw4w+G9F6ExLt34M5JhVRXNtgBxRtgN6X5WsYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784527563; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/ZnMXlzQpBHxKcD8OYB1VvoAQHa0aHp0dCGtj+Eakmk=; 
	b=cI4fUmQks0Qh+4TjGgNWXVCM2YlLKM7S/JJIl4WlyvQ86DagvvYk5NaHIOhoAswAz9wOaAVIG+bey3nzlpkJTvphqiYUF2LeH5eoHvydcXUt5Pl5woUHHuv376YJkvZhvbCgDXlsihUsowGBmvCmyfeiE9ZBQIx8GWN0pzoW0Ns=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784527563;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=/ZnMXlzQpBHxKcD8OYB1VvoAQHa0aHp0dCGtj+Eakmk=;
	b=TuhlXNOoYlFt0ls0RJnfSnpMXjPX80UKLVZHzwMHfG9Lb0SHLpOKTUaM+Fmah9qF
	j4iomlpUxwc1E1pumRm0PikL5DbKoTwne8DX6RJSCiXLLhzPG3iMMD5lGApzzFPrmso
	ijLcZS4cY0YsxGHCOuB1Xx16ZfMWkhpJxgnyS/Jw=
Received: by mx.zohomail.com with SMTPS id 1784527560312704.8273564297459;
	Sun, 19 Jul 2026 23:06:00 -0700 (PDT)
Message-ID: <84e5dff7-1e49-49d6-8e7d-c9bc42600e0a@zohomail.com>
Date: Mon, 20 Jul 2026 14:05:54 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] cxl/hdm: Make switch decoder target parsing
 endian-safe
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Richard Cheng <icheng@nvidia.com>, Ira Weiny <iweiny@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <djbw@kernel.org>
References: <cover.1784322343.git.alison.schofield@intel.com>
 <c09d201db3b716a6a9c664ccb8ff7fd9dc67b562.1784322343.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <c09d201db3b716a6a9c664ccb8ff7fd9dc67b562.1784322343.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227a060d09af4f7fb29b8101b990000e633ae0e2b5052ba04dcd68aa451f1104f48be0b355f031cc6:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/7/18 05:42, Alison Schofield 写道:
> Switch decoder target IDs are stored one per byte, starting with target
> 0 in the least significant byte. The current code accesses those bytes
> in memory order, which only matches register order on little-endian
> hosts.
>
> On big-endian hosts, the target IDs are reversed and the decoder is
> associated with the wrong downstream ports.
>
> Extract each target ID from the register value with an explicit shift
> and mask so the target mapping is independent of host endianness.
>
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>


> ---
>   drivers/cxl/core/hdm.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d81df45d8005..4aaadb842d90 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -976,14 +976,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   {
>   	struct cxl_endpoint_decoder *cxled = NULL;
>   	u64 size, base, skip, dpa_size, lo, hi;
> +	u64 target_list;
>   	bool committed;
>   	u32 remainder;
>   	int i, rc;
>   	u32 ctrl;
> -	union {
> -		u64 value;
> -		unsigned char target_id[8];
> -	} target_list;
>   
>   	if (should_emulate_decoders(info))
>   		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> @@ -1119,9 +1116,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   
>   		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>   		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> -		target_list.value = (hi << 32) + lo;
> +		target_list = (hi << 32) + lo;
>   		for (i = 0; i < cxld->interleave_ways; i++)
> -			cxld->target_map[i] = target_list.target_id[i];
> +			cxld->target_map[i] = (target_list >> (i * 8)) & 0xff;
>   
>   		return 0;
>   	}
