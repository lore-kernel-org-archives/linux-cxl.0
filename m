Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98411F0E3C
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268371; cv=none; b=Nfc+oLK/gcdvyscKDYHYC9J3UqLdhtOX7ulyTOMHEcv0rLu6gKauMKY1PXahJPpDiJ88OmfVJYN1ZZpv6NoZ7Y/8/vY2c8ScWeNfOmGU8PCdUwkSkSskoBA3lUEd96CFZOFOGm/8TzH8ocT4XVjcKdklDTCQ6HxoQ1d16AaYbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268371; c=relaxed/simple;
	bh=vvmQ/vWqZ6Jd0XLaEN4syQMA3VuajonFxiQX5J+6Z/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7+q4kpVmjPiVZT0HJN9ERJZMtHh7mtG0AZkH3p/4wg25Ojkh1a4lukVSM4SWfYzHA4kWOmDIYTH5X5WPzZkGSdrySBjhagvxctq0qI7OVAa3g9rTCoajdEn0zatVT83vm/4F+4U9B2b6DY6i9X8EWeAzLRA44R6ij9K2dOkp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XnQ17tkl; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XnQ17tkl"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6c3629816so810170085a.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 08:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736268367; x=1736873167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R741ys1OA6AYsI4G25gfgCXJcX9w1I4h9g9q/LwMKU0=;
        b=XnQ17tkluHETWu1YmiwbZ47jntlbGjyaqLli/XiuPJ1KqzbQfK4anfy+/6txEwPMvy
         gfVblACCDAr0YwOWSFlzk/bF7s2lscgvERNjf2NoIciNs3Ij3vnsZjP+kZawNr9K21EP
         JDWANQbgR/tTFDzLZDg3/gsQVevYX4ADXrl4/IkhhhYDF2dADf63QdwDHrduNnsqEBIT
         M0qOiGjLHNK3zZh87RuDuq2q78GPyJvQzfYyAgGUmWTTNgTqwZrn3r/GAhOJ8eDctFf/
         3tAo8PQIvIBM8a5Y5XVnPeTrS2BO5d7dY3cOVOXMLbS9DDDD5EIFJwlKIuvlme9/KnGZ
         B3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268367; x=1736873167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R741ys1OA6AYsI4G25gfgCXJcX9w1I4h9g9q/LwMKU0=;
        b=E+AvBBHfuNHcZMxP8cBwgtQuPKMEwqUrnsz8qRTDsyKgmR/Vx5VcG3CxZGGCFW2feQ
         g32C+wkZOtwx9PeTWzHXtWqodmRHOWs3AGZGiV4+/GePfIAqqovv41gkqBVeTFLz26Mq
         k47zKMMaKCq5C9UV0yt2SekfdmigPmUu2wVBtFMDg0PcHF4PgUW0e0dr81qh2JHpVtpH
         NHomici9drNM5u30d526SxCvBw2LpA4mGyy+pxmeo4QBG7BKXWN84vJPThCheL9Mx3w7
         ONodwyQGItf3eSSoySm00fDiCUoaMq6kLPMaLuX1PPz4wHLwuDB1BeDhb888wKrAhLTr
         ok9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwvmg/U3rKvjKQ1zyb4xqlI+EhFib5XWyTgXMN7KYGdlzXBsCsU0OnenddYnNVyRJt3aq0bQSfJE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUaYVEhY0lw+IInAjxDTtViAqYpc67cvDOe4CJhk6dllOF7eVi
	94H+tBEv4M2XfaZp7v9oXRPBqoBI/VMi8MGs+3twI0kflcfNsrX3iZQ0mbNvTDg=
X-Gm-Gg: ASbGncu/bwaw8pjb+TTWQ+Q2thuuxiFXaUor18Q92XHRO3F2PNlX+PnLmgfWRGC2mM5
	r8S1YqFmBKtyi+Izp6Nu0ldst1Dhdkl6BxAEWz1Wnv9OaKrg7CWorjFRX2I4FWOO0tJLAJDlpmU
	u63mNy/ACVeaJ1d0Py/tySWzQnzTQO6NecW6rrdi6hKkl9xCo7koWWQcbyHl1+UVJ4C5J8lpIQj
	XqfiobCMdbR/lhvYl2oj0eYGxPQQX5+TGm8WnHZLNTA7vNu+wCJQOkRpPOamVeNtpfgDh1OBKj1
	mIPS125hFVXiYmQFkjdWxJuBJbxBrJfQYZA61CI=
X-Google-Smtp-Source: AGHT+IH7W4gk72ZttfBtrUIDiflC6Kt4NtB6dnRnwszva/4PT4hTs2c2rMiYGUauwpwz9dk6eaoOlQ==
X-Received: by 2002:a05:620a:1992:b0:7b6:7618:d7ce with SMTP id af79cd13be357-7b9ba6efa98mr11715876585a.10.1736268367608;
        Tue, 07 Jan 2025 08:46:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac30e8a0sm1608974385a.63.2025.01.07.08.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:46:07 -0800 (PST)
Date: Tue, 7 Jan 2025 11:46:04 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 03/29] cxl/pci: cxl_hdm_decode_init: Move comment
Message-ID: <Z31aTEA5Cxr829qf@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-4-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-4-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:49PM +0100, Robert Richter wrote:
> The comment applies to the check, move it there.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d206378c4cbc..c7050c13f71a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -419,6 +419,15 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	if (!hdm)
>  		return -ENODEV;
>  
> +	/*
> +	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> +	 * [High,Low] when HDM operation is enabled the range register values
> +	 * are ignored by the device, but the spec also recommends matching the
> +	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> +	 * are expected even though Linux does not require or maintain that
> +	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> +	 * Decoder Capability Enable.
> +	 */

I agree this comment applies to the earlier check, but wow this function
is confusing when compared to what this comment says.

For example this line

/*
 * If the HDM Decoder Capability is already enabled then assume
 * that some other agent like platform firmware set it up.
 */
if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
	return devm_cxl_enable_mem(&port->dev, cxlds);


It seems like range register validation logic is unreachable if HDM
decoders are enabled?  It's unclear.

>  	if (!info->mem_enabled) {
>  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  		if (rc)
> @@ -454,15 +463,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  		return -ENXIO;
>  	}
>  
> -	/*
> -	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> -	 * [High,Low] when HDM operation is enabled the range register values
> -	 * are ignored by the device, but the spec also recommends matching the
> -	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> -	 * are expected even though Linux does not require or maintain that
> -	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> -	 * Decoder Capability Enable.
> -	 */
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
> -- 
> 2.39.5
> 
