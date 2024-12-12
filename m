Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA819995A
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734043341; cv=none; b=trnEVZQNMtsruu1oXvdkH//EPimzrFQSduKXnCFBay4O+wZGg9H0WUgn9ldIX6nP9gT1ELZhrt+cS790W2RtHp/g41YUxgc8fRvxQ7GZBRZRj9yrjGh1456gpuRjR302OsWRjazzi6Ww63qGHqJIuKBhnDsnkOL9wvLMZ1H+HAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734043341; c=relaxed/simple;
	bh=UcJNwzMbilRR/v7mOn+Zbi9cia2KhfJnotQB/B+3gmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTWVnzzGMra6taDXIacZgd8x9v9nzW/XQafg6KLyJOrSvB0oQy7wHPmkzeMSVef1FWrh8AiSXVenb8BMjVjscV/suOAQjTeV+7AV7dzkSKpBG2JR28AKBp6zgTgYdpd8pvgRpVXSqBhD4ngpOMJce+ygYXqIoR/Z71KFjCgxu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WluUwFW1; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WluUwFW1"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d888fc8300so5971266d6.3
        for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 14:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1734043338; x=1734648138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDR/LFuljYmdIkvdxk0XRHGqL3q2O+pQlUnwlg06J80=;
        b=WluUwFW1UgaJHR6gwlq9/0xnTJJ6f1vnm2oWnwxpKwbcYvS2+14VA99u1xFF4cMtDu
         FBOxx5VaQ7sEXnvdz4YbbuEp3cjP9Ln5y6PEdjenu59al9ZpTZIkOtkImpPbqCM7gFnF
         XyxVSknf5vBblnXHKB6K9aS/syxWHHiRqyk6FzBg4srQSrzEf6n9UuSDLsUTlfzgwWQz
         6uMg/zMPRjFTNWjUuRL9zVyKQ6mM6BkWmmtnWwDB8tsM6jufLBEUFsuyJ5t4tOTlXEMc
         y6/rhIyCEk8e5wPzbtuJlXf+A63Hdx8K402q5Cm0Z1jYpurTggz22YBPrL8Dm+Lzrc8X
         +nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734043338; x=1734648138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDR/LFuljYmdIkvdxk0XRHGqL3q2O+pQlUnwlg06J80=;
        b=EZW+zCe5R8DJzIexeFwM35TjcTYfdOHzt3wxyn2g/P1HlOoDt2StNKtoE6wIXRriLh
         1RuXWOCKYQifeUk0hk/ajM1hOgihSOYCvyjXBt3KQnb7aG0hM/gy6xVnnX3XPo3PZjqH
         ja5AQcLRtmkziaejsWgF/nQmsK/pLioITST/zuXQ0ZULKDGHHK5UrwchXQr+7NBLLMSx
         fJAeyxF/8NWpKJPC6oaJMF2nk9/0ERDyiILkLWjBaS0RKgAXqS/fujC/tyCAdcy+W4oN
         898UHul0k5lgC/6cB6bfH7fEdRLFGFX5U2ocLsF3a2u+1aLdrzSTQoSsCXqi3EZqBQOM
         KfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh2tTWkfkvux7U+oPUyFGw9hIG8RnZl/koUcMA2pzaZWTYU4nQVx4x6ieQN2hb1kcI/2pSRpPTtCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFikRk/hfBAUPbDxD4KMYJJQydLPXQjckiok7hGDjDN7FnEpSA
	yfDAU9zWiUbxxJnmIDanF4c1fMec2+ciHKR/VUOXhFsrRWrw+aMW88l6rh95I80C5VKJ51MhR1a
	8
X-Gm-Gg: ASbGnctNFhCa79N5FL5/hTO4CDqIc3bVUz+oAmxQaGdJLCJ888F0P/seCs+0hdSeNB8
	KjImPb1mNhe8cURlm+KKdC83xhcOWWA7IzSwN90iA41jA6Y4Nu7stg2dwRKRzsd20QM/XxtTTlc
	h+llT0Lp9CtESfxrEXm7Jy17yeOkYcICcHqeGwj/jjnilD4M+MD6Iz+Vnfg3ew2VWD7stmPI7be
	50QQDkCax9/cLcsST3rWX0TWkRDPzvWb4cYczDB+BMLgy1fdkpFKAcJBIYWj6w4m68Ib+4390lx
	+Khuc+UOG2tjyle1aEIxxnjQhmLKWYTxpHeor9GdBA==
X-Google-Smtp-Source: AGHT+IGsxcm3PfM5EAymYDCEpO8WpGhXaFdTJXIlPkZ/khgvSIYnAHVOH8iTHDVckjG1aaG2MTOf1Q==
X-Received: by 2002:a05:6214:f07:b0:6d4:2131:563c with SMTP id 6a1803df08f44-6dc8ca8999emr4699046d6.27.1734043338364;
        Thu, 12 Dec 2024 14:42:18 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6e6faf428sm268774085a.119.2024.12.12.14.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 14:42:17 -0800 (PST)
Date: Thu, 12 Dec 2024 17:42:08 -0500
From: Gregory Price <gourry@gourry.net>
To: Nathan Fontenot <nathan.fontenot@amd.com>
Cc: alison.schofield@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <Z1tmwOsAtL-wBR3Y@PC2K9PVX.TheFacebook.com>
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202155542.22111-1-nathan.fontenot@amd.com>

On Mon, Dec 02, 2024 at 09:55:42AM -0600, Nathan Fontenot wrote:
... snip ...
> diff --git a/kernel/resource.c b/kernel/resource.c
> index a83040fde236..8fc4121a1887 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
... snip ...
> +static int srmem_parse_cfmws(union acpi_subtable_headers *hdr,
> +			     void *arg, const unsigned long unused)
> +{

Chiming in a little late to the party here

I don't think encoding CXL-specific terminology and functionality
directly into kernel/resource.c is wise by any measure.

The abstraction here is completely inverted, and this is probably
in line with Dan's comments.

The comments in e820.c allude to a similar issue

    * Prior to inserting SOFT_RESERVED resources we want to check
    * for an intersection with potential CXL resources.

This is similarly inverted - e820 doesn't know anthing about CXL
and it shouldn't have to be made aware of CXL. Mucking with
e820 is *begging* to be bitten elsewhere in parts of the system
that depend on it to be a relatively stable source of truth.


This tells me that this patch is trying to solve the wrong problem.


Your changelog alludes to supporting hotplug replace

"""
  The current approach of leaving the SOFT RESERVE resource as is can
  cause failure during hotplug replace of CXL devices because the 
  resource is not available for reuse after teardown of the CXL device.
"""

It sounds like we should be making the SR resource available for
re-use through proper teardown and cleanup of the resource tree,
rather than trying to change fundamental components like e820.

If the driver was capable of using the SOFT_RESERVED region on
initial setup, it should be capable of re-using that region.


Is the issue here that the hotplug-replaced component has a
different capacity? It it being assigned a new region entirely?
Is it exactly the same, but the resource isn't being cleaned up?

Can you provide more specifics about the exact hotplug interaction
that is happening? That might help understand the issue a bit better.


Much of this sounds like we need additional better tear-down
management and possibly additional cxl/acpi features to handle 
hotplug of these devices - rather than changing resource.c.


~Gregory

> +	struct acpi_cedt_cfmws *cfmws;
> +	struct srmem_arg *args = arg;
> +	struct resource cfmws_res;
> +	struct resource *res;
> +
> +	res = args->res;
> +
> +	cfmws = (struct acpi_cedt_cfmws *)hdr;
> +	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
> +				   cfmws->base_hpa + cfmws->window_size);
> +
> +	if (resource_overlaps(&cfmws_res, res)) {
> +		args->overlaps += 1;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool resource_overlaps_cfmws(struct resource *res)
> +{
> +	struct srmem_arg arg = {
> +		.res = res,
> +		.overlaps = 0
> +	};
> +
> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
> +
> +	if (arg.overlaps)
> +		return true;
> +
> +	return false;
> +}
> +
> +int insert_soft_reserve_resource(struct resource *res)
> +{
> +	if (resource_overlaps_cfmws(res)) {
> +		pr_info("Reserving Soft Reserve %pr\n", res);
> +		return insert_resource(&srmem_resource, res);
> +	}
> +
> +	return insert_resource(&iomem_resource, res);
> +}
> +EXPORT_SYMBOL(insert_soft_reserve_resource);
> +
>  static void __init
>  __reserve_region_with_split(struct resource *root, resource_size_t start,
>  			    resource_size_t end, const char *name)
> -- 
> 2.43.0
> 
