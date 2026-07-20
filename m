Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4125A655
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784527419; cv=pass; b=OYh+teuX681NsRImEXNNLQ8vRUGw/bS93zjXofIaVC9ZhgmxRwQZJQhiy5FhASziM76QqUW3FHTJi9zDsY+pGghm0qSYKC2R7LqxrPh+jCVhedzdjyBmkcbpxX97/LXWz0eTqZj7SeXgdF9mxq4Ak9QL2Bf8Hnjp08+1vQTTzf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784527419; c=relaxed/simple;
	bh=PEBiXeVWXAVMxJ9PAyDrBGPWcLHMYWg2tpPPZlRyhtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsbB5Ubb6G4zpjxsiNB2rYtp/A1zNvyZbgHkJAgHf0RBFdyUd2QS6jt4LOkaJk7NuiqJwE2PzbmnvEp6QGY75RyDoG0iHO0lCqhT2t9FdY/D65I7gJq70S/zD5rKt8VBl+1qxfTliOk87asLvu591lPOl8G5AZO7AK3WUUW4es0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=eV/64VE+; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="eV/64VE+"
ARC-Seal: i=1; a=rsa-sha256; t=1784527398; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=beE/c8+9VT3/0kZpIuIEPiMQKl3oAHxrV3P/Dhw/yKg0synkzSr6KKM9phmv3vNR0bRb+ChYnI045CI4HewU622vb8B1C/0U6KJwy+TIN1bGs+Du8yuYYgXcZHxXQdgyQR7BWxCdr81+JTzXkFu85wmZB7c4LifWlT9oQwdRdy0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784527398; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cIsEj6YAupl7MYoXDjtItsKqoZcq334lYDTPd/alWus=; 
	b=ESdZiQCyvgRL/1FbcANU6HcH2hAGapE94EV4LPModvYaWHgLq6lDBft5/U52AhV486KW2rYg2T7ElnOPTtA1Zz/j5QiCNhlHCyTxoYj36Uz2U0z5NZslOAmLQNUEUfXtZh897xW0tjvraLccAmVGmogUA0ju4lJROVkjMW/yw/U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784527398;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=cIsEj6YAupl7MYoXDjtItsKqoZcq334lYDTPd/alWus=;
	b=eV/64VE+sBszGEfBefuOZkq7NIUu2PLsqsYd4YWe69uXMbiE9O6fkXIbcqrcZ7uJ
	3rJuYSuD0fgwN0JOPr+kWQKTi119qk96OILtNMbFMi4S8TC3F0qPs7zGkY6AokD8T4F
	3ekKJJnCmIO1kWka94csRbcF7RuFGmkUDvYKFH8U=
Received: by mx.zohomail.com with SMTPS id 1784527395750528.8390715284543;
	Sun, 19 Jul 2026 23:03:15 -0700 (PDT)
Message-ID: <171d58db-3555-4a79-a9f9-8a3c2e14d91d@zohomail.com>
Date: Mon, 20 Jul 2026 14:03:06 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>
References: <cover.1784322343.git.alison.schofield@intel.com>
 <de61a8143c7de391f8463003d87a3845496f4af3.1784322343.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <de61a8143c7de391f8463003d87a3845496f4af3.1784322343.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu0801122727be893a46aeeadd8dcb35c500000089a84ee7e77af35162f86bd1e38a2615cfbdec684f3baddb:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/7/18 05:42, Alison Schofield 写道:
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
> +
> +		if (!committed) {
> +			/* Ignore interleave ways until commit */
> +			cxld->interleave_ways = 1;
> +			return 0;
> +		}
Current init_hdm_decoder() reads IW and IG from CTRL register whatever a 
decoder is enabled or not, just wondering any reason for that. Because 
my understanding is when CXL driver programs a decoder, IW and IG will 
be rewritten, so is it not needed to read IW and IG from the register if 
a decoder is not enabled?
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
