Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83E5449B03
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615269; cv=pass; b=c4R1LcOrxr33GA3fj1uLZoc5utEBJ7F80DZpGCVXdAtvl+J290/utSsOviGtofSnN+Hp/cenG07YyPrj4o0vQZ/l35lZoF2QPQgbXRNbMSLktNb3RE690dsEubc6WDfmbUseGnHBZPZzztLhagwKc0bqBhmzRpridfiAdSN3jDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615269; c=relaxed/simple;
	bh=R37aXx12ciAQ18vwYc/b2UE5aIrwg8DljdXGh3Uutag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GChB4MJndCmrQLqFYM7WXrbtGwHIBCw/lITfV2cp/NsQQsZJSGDpGQLZOhwk5Bl1SA5CayqznH9VS2qDDvr5DTU8bp58ErD9rLAHV9ZKGr4dav3KKKLTG7q/H19eGeoTabqvbc2eIRNjvcxpP2GHNVXq4Smb8I2b/NtWnF9d61w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=D+mz7Z10; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="D+mz7Z10"
ARC-Seal: i=1; a=rsa-sha256; t=1784615260; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lIWzjFivwPvbuchP8Idwho7hmHTZlnDpr8STTahaf5dZY4QbpjnwotYhZoFqr9vyrTtx/WHp+/QQVrUpsQ1Fn4E7sdTxBf1zo9Dc8LaF+lJ0W1IxOslhpZUiJhqIR1tGDvbwR23aIX6UUR2jFFP2xD8gQrtruf9udymVSAZ43GI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784615260; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tIBkoPg7mpeF4OfzgPSeT+ssf+BSSy/WcfZLF7r/sr8=; 
	b=iczpt8aNtMiXNcMl01yLgiV8mh4nYQGr+8kFvRxWCDQxpuXWIaDGJ5rBW3Krnk+HuhzDzFrqm6Ocu00oW0KDuya54k+KikAFUu1hwOnrgAKRbyXFMq/LPppTyvmXUOVUOxhIw3HBJ+x+oSHWvv/maBcdHP3kC2FW8TIWZbJ1XgY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784615260;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=tIBkoPg7mpeF4OfzgPSeT+ssf+BSSy/WcfZLF7r/sr8=;
	b=D+mz7Z10jX9JKTe2nf0BReWSUHoXfQFMKStFxc63vk5KlfkL7v7Hrty9rubJTB9O
	f5E/bQsO2kISrGkZetNs20tqKNp8pe6WJfvsBi1V6chJIVjg1VCy7RiRicsspcNkwoW
	joe1iweh3KaHgTqwDahvFbxLDyDycs4uA3ewxGx0=
Received: by mx.zohomail.com with SMTPS id 1784615258337640.0852318060649;
	Mon, 20 Jul 2026 23:27:38 -0700 (PDT)
Message-ID: <b40874f6-4f53-4fdb-98f7-193c8dd639b8@zohomail.com>
Date: Tue, 21 Jul 2026 14:27:27 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112277135158140dbaa084faaeae20000a29d7f9158c56fe8797fe49cf503ea8e1d35beec654b289e1d:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/7/21 09:59, Alison Schofield 写道:
> Switch decoder enumeration validates that the interleave ways encoding
> is legal, but not that the resulting number of ways fits the available
> targets. This can overrun the target arrays during enumeration.
>
> Reject committed decoders whose interleave ways exceed either the
> hardware target list capacity or the reported target count. Reject
> switch decoders that report zero targets.
>
> For uncommitted decoders, ignore the stale interleave ways value and
> reset it to one until the decoder is committed.
>
> Add a clarifying comment that target_count is a direct count, not
> 0-based like decoder_count.
>
> Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   drivers/cxl/core/hdm.c | 33 +++++++++++++++++++++++++++++++++
>   drivers/cxl/cxl.h      |  2 ++
>   2 files changed, 35 insertions(+)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..d81df45d8005 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>   
>   	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
>   	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +
> +	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
>   	cxlhdm->target_count =
>   		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
>   	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> @@ -1084,6 +1086,37 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		cxld->interleave_ways, cxld->interleave_granularity);
>   
>   	if (!cxled) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +
> +		if (cxlsd->nr_targets < 1) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: reports zero targets\n",
> +				port->id, cxld->id);
> +			return -ENXIO;
> +		}
I noticed cxl_switch_decoder_init() has a check for the value of given 
nr_targets before setting cxlsd->nr_targets, maybe we can move this 
check into cxl_switch_decoder_init()?
> +
> +		if (!committed) {
> +			/* Ignore interleave ways until commit */
> +			cxld->interleave_ways = 1;
> +			return 0;
> +		}
The following part is related to a committed decoder( including 
target_map array updating), like my comment in patch #2, maybe it is 
worth a cleanup.
> +
> +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				CXL_HDM_DECODER0_TL_TARGETS);
> +			return -ENXIO;
> +		}
> +		if (cxld->interleave_ways > cxlsd->nr_targets) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				cxlsd->nr_targets);
> +			return -ENXIO;
> +		}
> +
>   		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>   		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>   		target_list.value = (hi << 32) + lo;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c0e5308e4d1b..291ada46b646 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -67,6 +67,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>   #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
>   #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>   #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> +/* Two registers with one target ID per byte */
> +#define CXL_HDM_DECODER0_TL_TARGETS 8
>   #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>   #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>   
