Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863CE12E1D2
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546086; cv=none; b=KwnYejKjZJiu5lRpcYa+WJhL3oziw9XxhK67fryKGfncpzkjcZ+W0OD6y1Y2JNrJw9ebSlbXrTmQju4F3DQnjuyzBrKhN1dqRPVd8G2vy6fjy08/13ByD6sLvQQXd08m1GYzkXMst+S7NFyFUy1gtGRe21HpyWMqGI3FsR4051o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546086; c=relaxed/simple;
	bh=UvdEaJ8tz57StM6Av8Ejk/5sKaRNxJ3kQFqATS6TGOQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I12mHYm/O1EPOFq9mKC6emq71BgtEHuC7jnHpM2t7pwIEkxOFIjGuRLwK7Ob+bjZMq4DKYCgqJapbYf9txh3Y6Ir3tX/9irEiV3rNgCEqnf3RHXWGDPEq2+fh1KWWY0oxYqcRj1UXrZUldFvDMZ7zApXG89rdzRbrz7j1TuEKYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hID3FUxR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hID3FUxR"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1764960a12.1
        for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713546085; x=1714150885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCqDR5ofpB9P2cVzzgQRqSAIe23nC6UzgumCvkwMrZ8=;
        b=hID3FUxRFQ/Ufn48/skbjIyxpVb4DSxJX46KYAd18qGcQ10GXcuNvxNO/SjDhWrmoj
         1cDBfZ3rPGYZkcG336MX+XlWMQzpay+4yotJ96pl7xETcpl/cgXAkbRVX6q0RW3F2gB8
         1A+KgQvy3kbzn+MlCJett72YIBH1qczof4kwPG194PNeIm5svDdersp9ghNZJrVbAG9o
         jcI+1fbYdBhexhAqsFjzRlp+9buMGZwxbUmoXzAqIiL2V9zJ8KZTlbzMocFowEbTLDbX
         MowuomKy9q6uZMkLCeS2585YsnsEJKEptKOyLR8dfK8vlaA3Ax7wFkMafbky2aIZFKG4
         nToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713546085; x=1714150885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCqDR5ofpB9P2cVzzgQRqSAIe23nC6UzgumCvkwMrZ8=;
        b=dIhutPGoL2LhWaLNCAwiJz9A1/jmTYtPYEmXL2EofLdiz39kpy9qxz9jmkFxh5SfJk
         w4bvMzIP3fmYD0TGXJJ1KZ3yamwYiF5RZEsBc1/MacOUdlYrCo2YQKPWzxGyUaxaf63i
         rrqpxnol7OnFDIcaqrIg/VRHPqEB+DuXyWfUZCqG9gMFKeGIGcil+BAfWxVhYJJ34B4K
         M1m/u77YgEdOLSgWuLgVjPwIreEa6cRYp425saZzNWNncZPUG0T4JNVsvP51WLVcFNWy
         OXqYVXvo7aiut+O9HZBTSY/xkIyj4p7uJ624gBR3AlLzSdRkb1YFrm+eRvEK2dZ7q4ui
         gMlA==
X-Forwarded-Encrypted: i=1; AJvYcCWP01027Ut1aEHEaEhvo69QbK+mUfZu/B/yxsa+sLbOF866RRd+1vWmZqbF6/iORkq99JLdpmMMmyLLLjTGsCp9LKFElfMJC0qN
X-Gm-Message-State: AOJu0YxJhn41Kowgh/Y7u1qLkQSdDW2GHiGsqfl0Go1toO7d5BN7mGTR
	oJnMWndO1TvJFcV3leUINLgM2SLoJBtnv0fd/I+6hiWXGcp377h8
X-Google-Smtp-Source: AGHT+IHhin3JHzd47H4Vr7ZTT20YXo1vo9aIuptLAocyrHYAJ3oUOblonl4ugkPGeh8hAMXu+o4YHw==
X-Received: by 2002:a17:90a:2dce:b0:2a2:cf1d:895c with SMTP id q14-20020a17090a2dce00b002a2cf1d895cmr2888570pjm.41.1713546084627;
        Fri, 19 Apr 2024 10:01:24 -0700 (PDT)
Received: from debian ([2601:641:300:14de:df9a:a0db:2922:7fe6])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090a6b4600b002a0544b81d6sm3336191pjl.35.2024.04.19.10.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 10:01:24 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 19 Apr 2024 10:01:08 -0700
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	jim.harris@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3] cxl/core/region: check interleave capability
Message-ID: <ZiKjVEJGFM6czFSj@debian>
References: <20240409022621.29115-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409022621.29115-1-yaoxt.fnst@fujitsu.com>

On Mon, Apr 08, 2024 at 10:26:21PM -0400, Yao Xingtao wrote:
> Since interleave capability is not checked, a target can be attached to
> region successfully even it does not support the interleave way or
> interleave granularity.
> 
> When accessing the memory, unexpected behavior occurs due to converting
> HPA to an error DPA:
> $ numactl -m 2 ls
> Segmentation fault (core dumped)

The commit comments only explain what the issue is before the change,
maybe add some sentence to describe the change?

Fan

> 
> Link: https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fujitsu.com
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/hdm.c    |  5 ++++
>  drivers/cxl/core/region.c | 51 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  drivers/cxl/cxlmem.h      |  1 +
>  4 files changed, 59 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..5ac79d843a16 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -79,6 +79,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(11, 8);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..abc14fe1717e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1210,6 +1210,41 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	unsigned int interleave_mask;
> +	u8 eiw;
> +	u16 eig;
> +	int rc, start_pos, stop_pos;
> +
> +	rc = ways_to_eiw(iw, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cxlhdm->iw_cap_mask & BIT(iw)))
> +		return -EOPNOTSUPP;
> +
> +	rc = granularity_to_eig(ig, &eig);
> +	if (rc)
> +		return rc;
> +
> +	if (eiw >= 8)
> +		start_pos = eiw + eig - 1;
> +	else
> +		start_pos = eiw + eig + 7;
> +	stop_pos = eig + 8;
> +	if (stop_pos > start_pos)
> +		return 0;
> +
> +	interleave_mask = GENMASK(start_pos, stop_pos);
> +	if ((interleave_mask & cxlhdm->interleave_mask) != interleave_mask)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1360,6 +1395,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  			return -ENXIO;
>  		}
>  	} else {
> +		rc = check_interleave_cap(cxld, iw, ig);
> +		if (rc) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s iw: %d ig: %d is not supported\n",
> +				dev_name(port->uport_dev),
> +				dev_name(&port->dev), iw, ig);
> +			return rc;
> +		}
>  		cxld->interleave_ways = iw;
>  		cxld->interleave_granularity = ig;
>  		cxld->hpa_range = (struct range) {
> @@ -1796,6 +1839,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_dport *dport;
>  	int rc = -ENXIO;
>  
> +	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> +				  p->interleave_granularity);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
> +			dev_name(&cxled->cxld.dev), p->interleave_ways,
> +			p->interleave_granularity);
> +		return rc;
> +	}
>  	if (cxled->mode != cxlr->mode) {
>  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
>  			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 534e25e2f0a4..da8a487ededa 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -45,6 +45,8 @@
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 20fb3b35e89e..1ec3e6285d41 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -853,6 +853,7 @@ struct cxl_hdm {
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
> +	unsigned int iw_cap_mask;
>  	struct cxl_port *port;
>  };
>  
> -- 
> 2.37.3
> 
