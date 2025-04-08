Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F346235BF7
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127159; cv=none; b=DcYELMA62lcHigarmX1+d5np/02kzSkdTD804MK8IXjzwC8gC5+ceOnxPDvgtsyCQAsv1qXpUc3fgoZ9yPHk0LlofK0Y283Xu0XEqy0xjPwR2GiLgIiZTWIpT1ptg889FE1WdZFFGixWv7rPVW7CvFRhkl4ZJyWYHkBZMMX0Pzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127159; c=relaxed/simple;
	bh=mjBuZ4+ZgrBFpY/9zvDNPYwTF8Lw4OT1AFFQ3ui0A8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8U4mLIiTmYi9kmOmgfaMypqGUno+CPt8Gt4hk4uBlVCJg1M1BLDsenHBPdFLoegHvIDimroZPMeaqEytenFZGz7WfdWPYhp8vd/cUEI+AjFOldUBl+x8myOXpd94DsEJqpAapvAV0aWemoBA6+dXsaS3dlKCeaVyYLhVbtnYiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=niCnm59S; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="niCnm59S"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4767e969b94so97125941cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 08 Apr 2025 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744127156; x=1744731956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VoXkx7vCK0V8Vdi8YRN6LJcm0AotHEaK6mdkVU4exog=;
        b=niCnm59So3Ij29BsoGLZF141Hw63RbHoWrnJwoFwjvtN6RxgBFEwEGGugA64wHRSN7
         JB/xyfsBkI0Ob9ZWXE3+4XZVpfBmTvKFKHQthGLKNNZdSeoFfm6O9ct2KFt827KJ+VWC
         rC2rSec/pMaKZFesovKj5DJ2twY5LW7MMhHLaiDyqdfK9hAo0/ZqHDUwxCd8cejhbw8G
         3BIpGJzzO3XzmDoEK2i0+ywcCzEX/HqwLsfTD5I6scBY4Q5y6IY48y+I/YBKfp9+x0eB
         BZnJeFBmd9PkHRlEpGoEFgPQUgKnsMD9215zFo6yuqX8qT5DqEpgm5IDI0lBKBXcD5RW
         aq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127156; x=1744731956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoXkx7vCK0V8Vdi8YRN6LJcm0AotHEaK6mdkVU4exog=;
        b=AbNEfqKtAHsZbLrrxuv2YY6md+ayOzWH/pn1zsyOzJ6t5hhlUP9YiExwaFozxo1XjY
         NfHsoq0F3FO8rYbu+KhA/1KZSUXHtggvLZXC5zfJQCwtUZ2Chnj+SKL9G//ZeIwuDQAz
         TYJABbk9yMFRhyVEZePvE4iRKHc+1YFZmbn8YEEzj5ZFzo6orcnGL6mpbH55LklRYLFq
         KN/KSVrGXRGSBDnCq+mu11HRyMtAScope/ZKvKPu0JIFoE3/CF9/PdLKmqVRS5b9bOXJ
         yFoD2Vd6ZaXLvv7gUj64kSdD+rMrqPHnu7r8JckKY6z0dXk8C8Eb2/rFPMXZonapl0R4
         f9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU49X5ABebkyVJjqAzeTb9ted7jSNw2MrPhL0Zpekul3/rRgRVTjcMO8tc4GvHM2TD5V4bCg1teuLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXodvRUvCRYhWhtsDvrnn2lG9rF56um2sFFNXZE4lYbV394ctb
	HoGZxjOiBY5H5+O2+1EA/SYxyhJvqM9DLeYqRvb7LJSBoMksPxpE/G3q7H9i6B0=
X-Gm-Gg: ASbGncu1ghNEJ1V4fq+HQwEwW2opLI76n9xZE9Av6c1wl0eCT/0An6DVI/0gnmAkJch
	U6vJvliyB067gcWcvVkVlANQ5DOUWLaV5/cSdnXLHHdnOV/kKQyXMTwGZwjxaLY4PyJXa9cbOk2
	AYF962ePtpBU5GRMJb53dBc8DXmo/fK4bv/Ko9mrBFp5oHmQP3QJ1ILdlLMkXsqsrA7XuDb0HJ0
	S8SztbqFudX0kGRvM48PraoTnXwiqmjoM8XH00A+wqpVeNbbCv1YCpg+u6+0YbSlA8goMsbrjmF
	5DeAbjpCsMoPSeimFNlVpDuaSepS0TBarxy63Kzp8vdDhscjDV1hRMHk+wMJVvQq3amLEzc92ML
	PlHXyv1N81nvP6zsfGptQka8Jfcc=
X-Google-Smtp-Source: AGHT+IE0t0oHePrcFXYkuYevl7iuOHqLSKUup+qyVgXocIBtQicJgUL+StRyzSINlW/hNULuQT1bVw==
X-Received: by 2002:ac8:7f01:0:b0:476:b06a:716e with SMTP id d75a77b69052e-479249a7ef6mr322034311cf.34.1744127155544;
        Tue, 08 Apr 2025 08:45:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b07456csm77885091cf.32.2025.04.08.08.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:45:55 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:45:53 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 08/15] cxl/region: Use the endpoint's SPA range to
 find a region
Message-ID: <Z_VEsYYevJ-BPJnx@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-9-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-9-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:49PM +0100, Robert Richter wrote:
> To find the correct region and root port of an endpoint of a system
> needing address translation, the endpoint's HPA range must be
> translated to each of the parent port address ranges up to the root
> decoder.
> 
> Use the calculated SPA range of an endpoint to find the endpoint's
> region.
> 

After debugging some other patches, I think this patch needs to just be
rolled in with the introduction of cxled->spa_range (Patch 5).

(spa_range == hpa_range) up to this point, so this is effectively a NOP.

> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d5ede5b4c43..ffe6038249ed 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3535,7 +3535,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_root_decoder *cxlrd = cxled->cxlrd;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> @@ -3547,7 +3546,7 @@ static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
>  	 * one does the construction and the others add to that.
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
> -	cxlr = cxl_find_region_by_range(cxlrd, hpa);
> +	cxlr = cxl_find_region_by_range(cxlrd, &cxled->spa_range);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
>  	mutex_unlock(&cxlrd->range_lock);
> -- 
> 2.39.5
> 
