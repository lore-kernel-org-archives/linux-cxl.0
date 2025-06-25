Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E91CAA7B;
	Wed, 25 Jun 2025 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877818; cv=none; b=rIjsS3gYSrs8fQbizw3SphVp+gUg6p8vc6k8Kdnj5LCifq5iVxeQ247nsAQGkobe3TGTSm/7ghhfkXV9hPJDqCVihkZ79ArfrfZVqcVFtyeCrLZSTVEsU7XK7XMzE4H1rsRnnYpwjnyhjPC2Ds+QKfVFXPchF89rBZQyZn9jzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877818; c=relaxed/simple;
	bh=pAJn+E8Fw6rpPtJHLwOdSAsmjfHdVW9rBS7PDzny0P0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai3/mJ1esK01B//KBhYl1YUjOUT1cSVS46qXn7V4UNyLBLET3YtTDBlEduwOXCzLIddC3Sbu+XN8/pAFwFpytG2+C3to3CD7CxEv5uCkL7e9AcSqrWqFRNNgzEq50Gxjng0BIOnmK/YqxJyreCclGm89tKebHlSfMh/da1coIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2upaEwt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2upaEwt"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7494999de5cso216655b3a.3;
        Wed, 25 Jun 2025 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750877817; x=1751482617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDnCmso9gBvKQ5z3Nhbls9AMHlpp/w95LXYj9Nsfg4A=;
        b=L2upaEwtYSEYpyp5mTarR1lqxBMJg31McQst14LZtZB90R8fHrvTpQ0fuFefB0ZFIZ
         Iy/nGZTShKgJApMB+dhAaZU89XUqn9T2kX6e300K7MTIZq8tZBQ6b2KGIKElst7vniiI
         BGmLh55aONnIhBK/U982O0rjtvuOzapXOTS0x/PerqdY5IJIMEo4wQGXee+SQiofichi
         /e3gWmfwmuY/XIiPx/1HfzZP4be8dmcDDmkOq+rWJcfBaVU1tJhGIBC+UrfjN1DlGuYk
         KEtA2idP1tq76IUKegWAQphA0UnSYEgUYNtR13uqidBNUOHL3jF3GHaoQoh3ePdQ8DEO
         ElUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750877817; x=1751482617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDnCmso9gBvKQ5z3Nhbls9AMHlpp/w95LXYj9Nsfg4A=;
        b=rplJWXNDqTLOEaKybtM6ZxL75ci6IP3OdVqctQuaZDYNc1+yFKoiCQS3bvqA2QDtKU
         kTaFEFwa7BEFTcXG1Zpq9FIkzt4fxv8WL0W7jNXRpuKQrxG2NOsuGFbMyp+s5PUl7QcV
         oOG+TZVMRWoN+WrztG3KtO+Qot5oeHk/LBVR0VZJu3pkUZXuqOawzzguAFUACM6vEE0S
         4G8pNGVd9scqe9qXO3WlKHolgYksgbjJFHe/fvoeyd7M2CUEcNT0BaxE89BBXxbks2zS
         a80xG6crIvc9BJzH1ro0yWx6OuZb5h7NlqaJ2hYL48/1cwT+p7Fd5IWtYV5+FHtaf2+N
         Qegw==
X-Forwarded-Encrypted: i=1; AJvYcCUyIeTwjFj7yixjbH/luwC6WhdbL0dNpOL3CsUwWmEGnLpTs1xWYW4cbp6zXuW7G6v2f8zPBGWxPFdfOjKK@vger.kernel.org, AJvYcCXIgruuDf5VnpOKrGsdG3xPbOL27aExW0ZW1+1hfM3K55NeAMjK1KaK6H/LaGRGEGNFe5/2mwp21Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxvi7CjFnL0itqHDoqEKom37t26m+uPmkmNI/b1+g38ut5AQH
	C8bUpXoy31FcLaTTbh4w1qLFusFIrGJ4W6t4CivH8PJck7kY9x9TY3Mi
X-Gm-Gg: ASbGncuhWT1KY6WgEIGUD3sYoP87wvAs13hlHFLkf+KPK5JppCEpyDPf73axbFaIwti
	bJ3fMs3aoRr8KKcfhJOMSVOln+5604IPOu6S7BJMFQarvlALUzbfRLtTbpJ6xG2Y5+8NUGBKnGY
	9DibY/QZ9+KLKdqzeDVJGLDcmP35ME2ba11y8c9oNRPsAvQfto90N0BeBrcNtUvci7uze+I1Aid
	UPKH1fqBCWYIAI+ZjwqJhFbuzMRHZ7uXJwCOUenwT7sqoNLq9cXaxjtfQYlsRjf3AwwK/AWTMGO
	b9yhDDmJM75UTap8krl20qJq5jvHrjtmUlND1GRCClOe8Sh0N5tt
X-Google-Smtp-Source: AGHT+IHAmiu6mVphq9BC1ZY3m5KyI9JcC0kxXAC4zKALvQ9VxCyB18aOPPH+wNJPHim21oO/qofqNA==
X-Received: by 2002:a05:6a20:2449:b0:21f:ef96:49ab with SMTP id adf61e73a8af0-2207f26a286mr6640946637.27.1750877816565;
        Wed, 25 Jun 2025 11:56:56 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:4510:8d70:ea8c:c110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c88714a3sm5108046b3a.146.2025.06.25.11.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:56:56 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 25 Jun 2025 11:56:52 -0700
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/edac: Fix using wrong repair type to check dram
 event record
Message-ID: <aFxGdIceR2DeG07K@lg>
References: <20250620052924.138892-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620052924.138892-1-ming.li@zohomail.com>

On Fri, Jun 20, 2025 at 01:29:24PM +0800, Li Ming wrote:
> cxl_find_rec_dram() is used to find a DRAM event record based on the
> inputted attributes. Different repair_type of the inputted attributes
> will check the DRAM event record in different ways.
> When EDAC driver is performing a memory rank sparing, it should use
> CXL_RANK_SPARING rather than CXL_BANK_SPARING as repair_type for DRAM
> event record checking.
> 
> Fixes: 588ca944c277 ("cxl/edac: Add CXL memory device memory sparing control feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> base-commit: 3c70ec71abdaf4e4fa48cd8fdfbbd864d78235a8 cxl/fixes
> ---
>  drivers/cxl/core/edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index d725ee954199..623aaa4439c4 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1323,7 +1323,7 @@ cxl_mem_get_rec_dram(struct cxl_memdev *cxlmd,
>  		attrbs.bank = ctx->bank;
>  	break;
>  	case EDAC_REPAIR_RANK_SPARING:
> -		attrbs.repair_type = CXL_BANK_SPARING;
> +		attrbs.repair_type = CXL_RANK_SPARING;
>  		break;
>  	default:
>  		return NULL;
> -- 
> 2.34.1
> 

-- 
Fan Ni
