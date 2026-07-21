Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840036EA8B
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 06:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615236; cv=pass; b=qe0PsMdv6EZg1y7trNkjS/xf/Gaa4L3oj+W9KaL/9pmbwG3SCyHE1/EO4X6iAUherYhUM/5EPJz55ErMv1Z4S6aEQEiJI8TgU7cUlDiPAF6VcI1pKJnCsH44i4X5Nb02QfsGs5sae470OoEPicKtHjc+MLhbLrHjIQZVH5sjw2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615236; c=relaxed/simple;
	bh=+7lWRBe1cVC7UVt8SyfaRtnSqQQQV3Vj5gWOumpJgkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXDnZUk73rruGYMom27+z5wdaVpFGh8bSIaxA51bhPT6YenZttlmG5xKywunzH51MMagXKJvjnucEgwv23KECRvTfWx7NQFUPWMpDMPPu5Cwyf6XKRw8/IH2/XAI5NgzkirO045w/SQCKx45IZaA/JLP+LS78N6MQ1XkZkoZr2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=KWC/Yzxl; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="KWC/Yzxl"
ARC-Seal: i=1; a=rsa-sha256; t=1784615226; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jLjahxaexiiNf8Szys42MzG8DqCHUx+uOMmuY6hLdktRklOh5Jk8M5fkku2PUPt8wSrrUffTqxmkqpdx60sE/RWCsLdsKUKZY8O5+7BKaEVt1JbsWJCye22g0+VaZzYc6lxIhUQ1UgmcRSZdWPldBbXbvb158lrwiF7IiZVaVHY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784615226; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BHdE28qaXzOGNXCqZOjlVzJAx48+8G7qGAlH0R8hqVo=; 
	b=KHyzPBQfdiMYq0AsTxCHNuZsgzKwkWh9CRts8slFCAUOQdIXeNu66eNq6f+gs8MVMBaXEwJuh58QHtASGNgi5NF0KLXGGxnV7YocCZ6BithjSOPIjx8388+/yGwN4fA6zFnxXt8smoabqh64PcmrgSdicRtPafAPgtYLZaRolh0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784615226;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=BHdE28qaXzOGNXCqZOjlVzJAx48+8G7qGAlH0R8hqVo=;
	b=KWC/Yzxlk+7xfxPXaHPSHOkvj672Y5L4wREMWcIQcvVv+6pHSx+4F1aOgwx0WI+V
	eSEyLZLnNPuVFqHvTV00xdx4Y3neiWbzjBiiQvgeAQIDBjY5Vx2XzoLDX1M5BX2py4C
	XDDQDW0fFOHpmw3NZVU6ujiRY9ksKNRPlhFwMJTw=
Received: by mx.zohomail.com with SMTPS id 1784615223142182.3216451643084;
	Mon, 20 Jul 2026 23:27:03 -0700 (PDT)
Message-ID: <d7a9b8e0-8b70-4440-88c7-6ee5f33eec2a@zohomail.com>
Date: Tue, 21 Jul 2026 14:26:57 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] cxl/hdm: Only interpret interleave settings on
 committed decoders
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>,
 Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <48e04e2688a636d90b6e49f3e0c2dca78f773c4f.1784595445.git.alison.schofield@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <48e04e2688a636d90b6e49f3e0c2dca78f773c4f.1784595445.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227c50d01e450ac5d062952106f0000edecd4e59eb1ae683a6d5442261eb084e1ad665c7be8bd188b:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/7/21 09:59, Alison Schofield 写道:
> Decoder enumeration reads the interleave ways and granularity fields
> from the CTRL register unconditionally, then decodes and validates
> them for every decoder. On an uncommitted decoder these fields are
> stale. They hold whatever was last latched and are reprogrammed when
> the decoder is committed. Interpreting them serves no purpose, and
> rejecting enumeration on a reserved encoding in those stale bits can
> fail an otherwise usable decoder.
>
> Decode and validate interleave ways and granularity only when the
> decoder is committed. On an uncommitted decoder the stale register
> values are not interpreted. The interleave fields are set when the
> decoder is programmed at commit time.
>
>
> Reported-by: Li Ming <ming.li@zohomail.com>
> Closes: https://lore.kernel.org/all/171d58db-3555-4a79-a9f9-8a3c2e14d91d@zohomail.com/
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   drivers/cxl/core/hdm.c | 33 ++++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d81df45d8005..1f995191baf5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -1064,21 +1064,24 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>   		}
>   	}
> -	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> -			  &cxld->interleave_ways);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> -			 port->id, cxld->id, ctrl);
> -		return rc;
> -	}
> -	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> -				 &cxld->interleave_granularity);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
> -			 port->id, cxld->id, ctrl);
> -		return rc;
> +	/* Interleave settings are only valid on a committed decoder */
> +	if (committed) {
> +		rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> +				 &cxld->interleave_ways);
> +		if (rc) {
> +			dev_warn(&port->dev,
> +				 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> +				 port->id, cxld->id, ctrl);
> +			return rc;
> +		}
> +		rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> +					&cxld->interleave_granularity);
> +		if (rc) {
> +			dev_warn(&port->dev,
> +				 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
> +				 port->id, cxld->id, ctrl);
> +			return rc;
> +		}

There is a "if (committed) {}" block before these changes, maybe we can 
combine them into one.

Besides, there is a piece of codes related to a committed decoder 
handling in the end of init_hdm_decoder(), maybe we should put all 
committed decoder handling codes into one "if {}" block?

>   	}
>   
>   	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
