Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850318A6C5
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268692; cv=none; b=i5J1pbKtVvvxcsctXusYivm/dYSaXjISaqNDO70z3BoFohZYMrI15xNHQLXdAT4xxdGEaQLKkqF8PnVc+oqn7YUIvk7WPldsYkfWP0V9RG1QmF1vOJpuHnGnnjzUfhIYSmjTb1IppUnWsUFQsmaLkqm3YeYQZYnCFJ4QDi2xXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268692; c=relaxed/simple;
	bh=D9TpQtY/D6zTzmvezWBG88w5175KxBu8gJ6iCiap530=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgTS7DkoO1qF5jMum9Gwn4JCDccVdcH/XwvL0B63oKQkMGu9Tkj53gH7+bMplH9OimxQU8gUcco8BncF+n/+hYmHuHyoEM+c9kn2kRmG3rZ7iXP8siBZaO1KzwLQfiwfVaCNZWF1LWsALYZw5VztvzmVV4VyBJcBShMkp43vXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=u2N3dO7B; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="u2N3dO7B"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b9ad0e84e6so1605133785a.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 08:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736268685; x=1736873485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZCgda5/+PgmZz+oMEy39UXN258VdBQY9TXt0VyacJg=;
        b=u2N3dO7BKY3SBHRfvXrxMqU356Bbvz9tkNbdi9WXglSY3GItz35Ej8ECf0mlzjkniD
         wxjO+lztB8qwZQ0fN5lSGXpyF7HxH2ZDF+4lVeIcxGuvxVVEnpDD9g2VXwzo9OPi2hM7
         Lj+XGvy5jbX5R51w/2VfGpLUeeJiQh8HZ9ZbrgXs2dVLUITfFzh4LAGT83/8MthsMS70
         zyOFjyRS5Sijggg2YSEw8BC4rAIr+363zbKTFA++IWmKTOveAgAyHaTFnwUsgm1vmpQK
         O7ichOp+7U8NSQ6ai2hoLe6k65TyPGhhQnKf45QOKE+MRZoTCMWVcxWRcqWl6E2XPi+/
         oEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268685; x=1736873485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZCgda5/+PgmZz+oMEy39UXN258VdBQY9TXt0VyacJg=;
        b=Akz2d0Xvr+JjeUC920oZoltNdBQeNDlo0tUCkLQQWFtvfX3l6g9alqfL5WkxEFtr2W
         ooChhYlyP1LsaoUs61CVgxEI1AXFvw49LI0k9Ksp1d9EQJhCYZYf5XLxiFfG5OuYiBmN
         0YeAXL3hji6RNq+RAzxocN7BRI0z50GSjgBIwCoCCh6SDHJRYPUOXV5gmqTheaZEkYcw
         Qxvej0CDtpuNGyEg07UuVVu3jnyGFBLvPOM2GHmrInzBUV0U/G4LC1kxMEHQFtc3bfBN
         m8FS47vNA2R1rL56pKFlgp2IjRdiWYxjfCCFqVqoJSk2YaSTigc2lVyGQQvwDNFAZnvz
         DftQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy651Ou603W2berZT0+05aRsVSHxgTBKVEJMTGM8t/mgjbeo4xBRJR4c/w84/0Obe3HhXKugsrxFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgw2IQYI1nIo9OhffXUMq8HOxFPWIj99MltffouGGUxo0JSUF
	nqcwVbwqBs3dLuJ7NFqvgsEHYXIe2A8wLzYfFMDlsnoZZvtsz1TTjC1LYJJg3xc=
X-Gm-Gg: ASbGncsJdxRUIHbaQJ8oNolxqCSs3jtRfxVWSo1NHb8PhG2neq4tgHGY+5g3V/rRK4/
	uSappo68n11vq69NIL1m34OdT5GDYy65hChckYxcPN7gndG1+eZ+MOQlxUjRXVaKcOoX1WOpTwb
	3LZ8mSw8tCnA7kwdr24i0Bf7FUai7p9bP6mU2v9ZrfoHRwW/Pahh0oVuNbpAh38hBFySG9v/H1N
	RnMD2K5rs1KNllWh7kR7qBGx/t0Tqd2MZxiW3F+xE0VPW85J/KJG8kux7yW7BxfxdNwDbRy7+2m
	41snKFVQ+Eu3Vo1YFzGhxNQUStsBcrgpAonXUvU=
X-Google-Smtp-Source: AGHT+IFoLbnJvnZUTCjrmSfS98Fm9uoyXS2ITYDQ+HhfMS8Bu5tFyZB+sD7gg0Xw+k/wMILWltmUNg==
X-Received: by 2002:a05:620a:260b:b0:7b6:d4a2:f11f with SMTP id af79cd13be357-7b9ba5edeafmr11233954085a.0.1736268685507;
        Tue, 07 Jan 2025 08:51:25 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4ef0f6sm1609817885a.123.2025.01.07.08.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:51:25 -0800 (PST)
Date: Tue, 7 Jan 2025 11:51:23 -0500
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
Subject: Re: [PATCH v1 04/29] cxl/pci: Add comments to cxl_hdm_decode_init()
Message-ID: <Z31bizrgbgjj-RXG@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-5-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-5-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:50PM +0100, Robert Richter wrote:
> There are various configuration cases of HDM decoder registers causing
> different code paths. Add comments to cxl_hdm_decode_init() to better
> explain them.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/pci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

This addresses some of my prior questions, but I still think this
function is worth some extra scrutiny.

Reviewed-by: Gregory Price <gourry@gourry.net>

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c7050c13f71a..4d2154457efb 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -416,9 +416,17 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
>  		return devm_cxl_enable_mem(&port->dev, cxlds);
>  
> +	/*
> +	 * If the HDM Decoder Capability does not exist and DVSEC was
> +	 * not setup, the DVSEC based emulation cannot be used.
> +	 */
>  	if (!hdm)
>  		return -ENODEV;
>  
> +	/*
> +	 * The HDM Decoder Capability exists but is globally disabled.
> +	 */
> +
>  	/*
>  	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
>  	 * [High,Low] when HDM operation is enabled the range register values
> @@ -426,7 +434,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
>  	 * are expected even though Linux does not require or maintain that
>  	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> -	 * Decoder Capability Enable.
> +	 * Decoder Capability Enable. Else, use the HDM Decoder Capability and
> +	 * enable it.
>  	 */
>  	if (!info->mem_enabled) {
>  		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> -- 
> 2.39.5
> 
