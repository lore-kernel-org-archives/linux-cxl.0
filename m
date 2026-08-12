Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27F2773E4
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534328; cv=pass; b=fG2ttZj+Vi5hcXDWtVVy3eSd2AGB3Y9kOhieLhQ9A0lgHSodOakMhzAcXqEMKWnXkIcYLKiE4FMFku7ir8bziOFUlnmj083HhwwGbYoJnfUGP37cn+rQ8QJZBkIQ1Sy0ujVUge+E1lcLZvTYYX8l9/CYAByRy7Oja03pmZm+JUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534328; c=relaxed/simple;
	bh=qqtLVWpobLwH+0Cr2EDvGO09jzUPFQNkB13tTTYsIFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jobrx6P23nMPv7Q/cRXtFNpJAvdmeKASzOvDhM3i39QweeAMv+Um24b4d0JlxXI6QGxaSd2P9MGoAmojzBPdqav+CNF/MtP47xwWgOjNtHac/qXuw/Roe8bZ04bMc6fTa5FZQzNM7w5X5UrSVKNCvDJM27rwyA/vKnMBkBIfdTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Nwvb/GTE; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Nwvb/GTE"
ARC-Seal: i=1; a=rsa-sha256; t=1786534308; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aymujSDtMdym/M9VCWmIZkWs1i5oT89JEILoLK0X/tSSr7lJ/hJMm0EDVtg+I47L2XOObTviYnCxExuUGsRB15WeT1XN8+SRHRnaeZHIa7vOb+D0WvfNBQO7INEjYEU6ML8R3AUTmiRMUmpQuzwQdJnBHb4G7y97U4MDVDcmQMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786534308; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9x0J7qe8QhgUlsM2KKGkceKTuWKYXaYzknl5HgjCCKU=; 
	b=U/mn1S9cLYzx66hTVo5qAbzOBC/lC1aDTnXivDSVAHxoIi/TpyL1twzdH4bIPqiiF5wzOA0zeZz4x55a+G49gxWxOtpr8UfscG4sUnDo+g03FgT+gzzrbTXKJHo+OJCcenUlHaOeTfD92+k5zD/5eFcu4eJnu+3GsoLSfuPrr1k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786534308;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=9x0J7qe8QhgUlsM2KKGkceKTuWKYXaYzknl5HgjCCKU=;
	b=Nwvb/GTEyYjjZO+TYIZi8FxUGFovl+J9WiwJi/BBeOrryQkIJlqTC8uTvBIhYKSl
	FCHUpxik/2G/WKiSj6lbPgvYgebzDJQDtadGFSZ6EdqTv/K1PdAN6bGWHKPee1YRMf5
	XTOWykUon9TnuPNPw7dcA4qi279VVZwkl+x66/I0=
Received: by mx.zohomail.com with SMTPS id 1786534305126289.2351809341485;
	Wed, 12 Aug 2026 04:31:45 -0700 (PDT)
Message-ID: <1507430d-a117-4512-8568-9a995f559fdf@zohomail.com>
Date: Wed, 12 Aug 2026 19:31:35 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: Fix out of bounds read of the decoder target
 list
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <20260812061017.56916-1-kanie@linux.alibaba.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260812061017.56916-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227095680809fad806e8daadb9d000097f5c79444fdf46d376c402492533de75cc877a92890ce25cd:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/8/12 14:10, Guixin Liu 写道:
> init_hdm_decoder() reads the HDM Decoder Target List register of a switch
> or host bridge decoder into an 8 byte on-stack image and copies
> cxld->interleave_ways bytes of it into cxld->target_map, with nothing
> bounding the count against the 8 target port IDs the register can hold.
> cxl_port_setup_targets(), which programs the same field from the region
> side, refuses the configuration up front with 'iw > 8 || iw > nr_targets';
> the enumeration path has no equivalent gate.
>
> Values above 8 are legal hardware encodings, not corruption.
> interleave_ways comes from the 4-bit Interleave Ways field of the decoder
> control register through eiw_to_ways(), which returns 16 for eiw 4 and 12
> for eiw 10, and the driver accepts whatever firmware left programmed there
> before it enumerated the decoder.
>
> The copy loop therefore reads up to 8 bytes past the union, and the stack
> residue is stored into target_map as target port IDs. Those IDs are matched
> against the port's dports by find_dport() when the decoder's targets are
> populated, so a byte that happens to match an unrelated dport's port_id
> installs that dport into cxlsd->target[].
>
> Reject the decoder, which is how the eiw_to_ways() and eig_to_granularity()
> failures in the same function are already handled. A decoder whose target
> list register cannot describe its own interleave is not a configuration a
> region can be attached to.
>
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

I believe the patch Alison posted is fixing the same issue.

https://lore.kernel.org/linux-cxl/cover.1786143520.git.alison.schofield@intel.com/T/#md705ff429d485f036e448cb48ed2574f9fd85331

> ---
> This was patch 5/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead. Patches 1, 2 and 7 of the series are dropped, as those
> issues are already fixed in cxl/next.
>
> v1->v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>    the code change (Alison Schofield)
>
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
>
>   drivers/cxl/core/hdm.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..9d49b48a4456 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1084,6 +1084,18 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		cxld->interleave_ways, cxld->interleave_granularity);
>   
>   	if (!cxled) {
> +		/*
> +		 * The Target List register only holds
> +		 * ARRAY_SIZE(target_list.target_id) entries, so a switch
> +		 * decoder cannot interleave across more ports than that.
> +		 */
> +		if (cxld->interleave_ways > ARRAY_SIZE(target_list.target_id)) {
> +			dev_warn(&port->dev,
> +				 "decoder%d.%d: Interleave ways: %d exceeds target list size\n",
> +				 port->id, cxld->id, cxld->interleave_ways);
> +			return -ENXIO;
> +		}
> +
>   		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>   		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>   		target_list.value = (hi << 32) + lo;
>
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
