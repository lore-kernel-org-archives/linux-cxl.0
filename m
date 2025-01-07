Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BC1F2C22
	for <linux-cxl@vger.kernel.org>; Tue,  7 Jan 2025 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275501; cv=none; b=f43puCEwYcwXOQuUKB4CoarbEQ2aQYKTORMvbiRboY96V/8s2xA/FP+cTyokGtos3JNvamnvGlM8FTR3NBQMOsWpu8V/+VfEKorMzMuunyX1JDhLGNSPxYNiBs+7PHJB8KcuQXleyFDfJFvFceepU/Pa4juOfAPGPIYy5vUgP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275501; c=relaxed/simple;
	bh=OseuZAjSKoHRHFmSV5YXoYm9Axuvzg8EqRYzM5Ic8oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueulF7lOAU2OnjCaJE5f2itxl9SVj7qYj6c1Sjg8eYWP+2V5RYccwmNvfml9hASGBnH4sGCvsveqs+64/7L3tKjXnQs0SvSAX5CI/iGIx07+q29EKFbTpyWOYF4xGcB9RMp7QtK+v2YvRjnRAsqP4Je2WW5AjrLEo40JopByi2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oo71dsmD; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oo71dsmD"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dd01781b56so90946656d6.0
        for <linux-cxl@vger.kernel.org>; Tue, 07 Jan 2025 10:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736275499; x=1736880299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sz8+RHY/rv2VkVwYEL7YWz+C8Z9qf02KGrZ5BViTHk4=;
        b=oo71dsmD3CevBmayauwc1znSehcawkwIu6P12LwiE6S3FrrnXXB/byAwqqGSJg5o2H
         mzWG+VUvRYA7slni1Y99dG8TXXhwNJshrsjGlURC736mrkm/maiRdbdzZkGSbe/QbJeF
         i7Qo5TXmEZzjmKPa242wt69LtUEbWEQPcD0U7vCC1xUIemRUzEwiEgW3h6GcE1XOr5u7
         Pe9UFCpmiV6jG3YaxJnKLVYVnz2/OV4ASuTfP+djNeae3wlcwGwJG+Ce/Hv9MYQQs+yG
         E4U6Hvu8Q/H2foC7fpOPq9gFRIoa0a/0wCCq7tH8pGKgCHzY2ADsFvoXVMFlWRqGNvHG
         V+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736275499; x=1736880299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz8+RHY/rv2VkVwYEL7YWz+C8Z9qf02KGrZ5BViTHk4=;
        b=cbU7eBjcT3AFvC05m5kpKhaVm80VI++y7DWUVUzjsBPNl9G8may6598eTwl0P9GWBd
         LhX2ZNhNy8nIGsUahYIQlCIxCKx2iS6aRVaOjla5ioBguHT/BvcuViejpZ4bLQcuTZxi
         x/L3tvqRy44oMjsmfUKRlwxc8mZtrN0aaiDVVXtvaYfS+4WiEVyXpxUZd3vxIqoCh1YH
         IFjgHRVriWSstE2Jt52eeqLaYF/qv/bItBtG+mAU7/mQbyMu05lp10lY/9xxODswEiex
         wD+t6rMLH2eEQkUPsqJmn/jcJr6RB9JKj6WdN075WS/HMbMBQKRAg2A+Zl1kcPcJ+0ke
         cheQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcF/ZghCLfZCZEBNKe7dcwkLVhwnEHx6pPzKE4R4kRx7Phs+yTvHQgEucmVbrsuqYLoH5Yb5AG9fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5laeshptuFWa9v72dY03SstwFhFFbjIJR4Ps2KRLW8uuKAKMw
	H0qcujc3Yl1TBt8l3+1IetDror2kaoRklpi5gtW4ah6w2hCiWpl4etYkK7qu/24=
X-Gm-Gg: ASbGncsFyaW3buE2lyp9KEQDk6IRaPzoG0x3riNdUsS4PF8XmbStESIHEcDmWLlneOE
	Ly9O/1kg4kBFbD9tURlNwzLvVnnaMZ+GALpWebeA/DL5DkUKcjMLvk3Pxd99Roumt6xNOAJ3fYO
	rSpm8rftMfKimyvvSczPV5tBOjqK+iQTacGK4wqn1BVvlJJ3t6MfEYSZv1vKI5McmAeCPIcYp0i
	SF7ruc1cK9i8392Lb34eGZQCh1iMPxOCC057MtK+KYUdLYB+ZNdq6RuEB98JjsnNrZVrBXLQQSO
	V95zTiF3hDANJr4kzjpYMw0I17082835zfDG/Ps=
X-Google-Smtp-Source: AGHT+IE1HzXui79IVUrq9vqxXHysJOEvg9ndx8cb11Kg5ybSLwjgkPO13YiS2b6T5y17VQ+yoKZKSg==
X-Received: by 2002:a05:6214:f6b:b0:6d8:9994:ac30 with SMTP id 6a1803df08f44-6df9b2aa3c5mr1776926d6.26.1736275498923;
        Tue, 07 Jan 2025 10:44:58 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d5adbsm183152316d6.115.2025.01.07.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 10:44:58 -0800 (PST)
Date: Tue, 7 Jan 2025 13:44:56 -0500
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
Subject: Re: [PATCH v1 12/29] cxl: Modify address translation callback for
 generic use
Message-ID: <Z312KLDlB7Hs1RB5@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-13-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-13-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:09:58PM +0100, Robert Richter wrote:
> The root decoder address translation callback could be reused for
> other decoders too. For generic use of the callback, change the
> function interface to use a decoder argument instead of the root
> decoder.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/acpi.c        | 4 ++--
>  drivers/cxl/core/region.c | 2 +-
>  drivers/cxl/cxl.h         | 5 ++---
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
... snip ...
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b3989dc58ed1..be7685fe8a23 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -443,8 +443,7 @@ struct cxl_switch_decoder {
>  	struct cxl_dport *target[];
>  };
>  
> -struct cxl_root_decoder;
> -typedef u64 (*cxl_hpa_to_spa_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
> +typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
>  

changed from _to_spa to _to_hpa? Was the name wrong previously? Maybe at
least comment on this in the changelog.
