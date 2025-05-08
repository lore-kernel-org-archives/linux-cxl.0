Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3119D080;
	Thu,  8 May 2025 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680027; cv=none; b=tSJKbDvZm6MNWV3wM7zD0EcKHDqDYtp24OB1regZPd+ziM/k0L+JzP6oWH5kZ4FbqSOL23btzL00S++CVsSF4kZjKa2Mgr6MfUvpYzdTHDqWKN72+s2aK82uhi+RcOYmzjG3xwIenBoLKKt/XmHPf0qJ3JT0OaW89+uDUQuOePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680027; c=relaxed/simple;
	bh=Rqlhl8scJWK1KFRqpMadZ1k19G5+0GHAMj4w2ohm/zY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+QyUD7rDJKj35W5pYfg1+EK1AQbwQAMgE9ZXnD0ob9ytBDm0BP5Aemtxay2ri9P9mkZyRWKPRFQ2YBgR1lWWYhyOsgKEXPms6clZB2HF+fL2OnBIc8b3fyirGqXM2Uru5zJgkhLDtbW9qD1C3Dp3q46YYDMhu/DYVusOhzgGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JK1qOFm9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK1qOFm9"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e70a9c6bdso10574875ad.3;
        Wed, 07 May 2025 21:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746680025; x=1747284825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CX+buwoA+SqSG7r/CEcjs5/GgQYEZL4oqoCzZ/o1bnQ=;
        b=JK1qOFm9MrnBpyNHreQ+LXzI7/Go+N3vDZpbBXNeD3uhnD6+kpnoyfKUfiaSZ9phFB
         sca+oAtzj5yrhEUYUAMZio8y16azdFy1nXGY9LC6XC0pQ2WN2WgrEW8+Usv1SxEiiIN7
         z2AdtY2Fy/psFG8m+QSmWdymcyL8VnmkGcNzngixitcY4Xzn5w3f1cr4uclf7XfV9Ki+
         XsfxRaEXWqKxigvwTEyc7cRZKRYunM3eKdCwM7F5PbpviAIJQgk//d2jbkMfiYcHdcFw
         Eh15vmXiqiizPXZl271cd/BNvw2XePoOk6X/wpBbXw8KsMccC0i/CtyWOJanboC+Qt/I
         kdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746680025; x=1747284825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CX+buwoA+SqSG7r/CEcjs5/GgQYEZL4oqoCzZ/o1bnQ=;
        b=GflK8yUrwhp+iWnWmenH0pa3HG/Sp35y15EhV/OPtF59/vxdtqunwkU4BtE2f83IJS
         qiF7ktP67rqTDc+pgujSmzMSNw+qY0BDpz8StcpdbEMT4C3zT7XSbGN1pzHdNpDQTLyF
         ygBpD1iV/hhb7NXqk+WP7IAAZ7/kUCfTekytNFr1zePp3v8vl8myvB5NOmULRdpaxGvW
         jYhczAdV3lmeWNyT5sNOgkU93gK1fd/COd2MbD3R9F952Op6pr/m2AvMxnJDCFy2x0tU
         vLOQe7QHJxMxETdgmpSBDsvGACJUt4NK6LFg7iXmXeHI+De5bY3pjktqgsRALJjWC3WS
         kp7A==
X-Forwarded-Encrypted: i=1; AJvYcCUXGiLqz3ZDY8bzv5BK1u3JB+lSYUkB6rlhnCcSHw8IfNlTec0CiAWHHeWhz6V4YtvIpIpBqolWvBiBLE+h@vger.kernel.org, AJvYcCUwL0VIM/VrzWpRwXFNWMgMpqf3hqr+MGHh9TL1lbRSNxnkze/3UEg6mnC/glbU2m4TU+i5jfEQU99tVbSvecU=@vger.kernel.org, AJvYcCXofX0dylYCkvnC7qcef0Bp6Uj3iQ0QmTHwmqx2o8CAMy9iuJCRJ+Fv6H6iBgxqddaN09nPKtLSHlqm@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7BI4QfEmHW/qbmrLVLD5uhnwjRTJ2kvzMfOt8ThIK1DYFLDh
	geh9GVlAvIpj1f14GIewXTgdIXbi2oEWH3etYhbvglSCw91veGxP
X-Gm-Gg: ASbGncty4CRvGNmDFdMMGWiAGB/boRyarWb/z8T8zUVWCsWovZ+F5ohsr6nLLtkK2O0
	x8KYfXfTUCelORpP3GyOuNyMEDw2JoCcoa4fH8kzfFzzOnKH9ch4dKCkkLqAQYyL8+AykR/ffy1
	IWfwjTYmvmFjCvPrjVAzQlirtPc+mH3Hmjwzd604kDI+r5e4buKlBFLbq71//2ogam+GlpSwl8l
	2lMhUyoIEqklAOai/xErHT9rENvXXoLb+iTayVpryOk7qaOvwA/xuwYgGs+ct36Xs/gp1IpS70k
	pnWUwUDoFb2duw6c0if3
X-Google-Smtp-Source: AGHT+IF3yfQ3vEhkvHrsH76UO8Q6p2XlUioNaCrv8r5owADj/fqe0m8eUgPdCq40yC+V8F8mtSG/gw==
X-Received: by 2002:a17:902:ecc4:b0:224:24d3:6103 with SMTP id d9443c01a7336-22e5ecd1211mr101208945ad.35.1746680025350;
        Wed, 07 May 2025 21:53:45 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:9548:d4f6:7b28:38bb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e459e1677sm41921675ad.257.2025.05.07.21.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 21:53:44 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 7 May 2025 21:53:40 -0700
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Robert Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxl/hdm: Clean up a debug printk
Message-ID: <aBw41HRNXEj3tgYG@lg>
References: <3d3d969d-651d-4e9d-a892-900876a60ab5@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d3d969d-651d-4e9d-a892-900876a60ab5@moroto.mountain>

On Thu, Feb 22, 2024 at 09:14:02AM +0300, Dan Carpenter wrote:
> Smatch complains that %pa is for phys_addr_t types and "size" is a u64.
> 
>     drivers/cxl/core/hdm.c:521 cxl_dpa_alloc() error: '%pa' expects
>     argument of type 'phys_addr_t*', argument 4 has type 'ullong*
> 
> Looking at this, to me it seems more useful to print the sizes as
> decimal instead of hex.  Let's do that.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/hdm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..0b1843631b26 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -518,9 +518,9 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	}
>  
>  	if (size > avail) {
> -		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> +		dev_dbg(dev, "%llu exceeds available %s capacity: %llu\n", size,
>  			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> -			&avail);
> +			(u64)avail);
>  		rc = -ENOSPC;
>  		goto out;
>  	}
> -- 
> 2.43.0
> 
