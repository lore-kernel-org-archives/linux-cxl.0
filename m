Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F16B9463
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 05:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525166; cv=none; b=MezeVznBKaBsdGoyEm7NRLmnTOV3qikzvF8s4vV7Qm8EsacEFtwtSd4RJwJ0jxJoq7Y04C1WbD3jaZqXGsxrsBjP0KCgLht1AAEe8yOcuck7374oqHt4no0GPoCLq2vr2YrT5vliEkxA2Q2GSXb7dPmBrTLWotU5u/lR2ECfAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525166; c=relaxed/simple;
	bh=LmYbHfvdjEndiM4q8x27My/sm5mG8IUJNkD+B0dYBfQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkDRgpvYnmQt/L+ACILMQ5wTalN9ATkKc60s9InzzDTwn+WtuOfXIhRm33MAjgOeuBXJGtrnbqfnciFaeBp37UH8ZOLU8iYmLqCmk7mfrM0uhEQOydqDEvJTKW8RSTI+U0W/jSbhhUVeI9ucUjbK0Fx+R5fdueQ2Xlo9S6SVvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+IDLcpE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+IDLcpE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2156e078563so85578895ad.2
        for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 21:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737525164; x=1738129964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lIZ4JWBoERe85R1qokaI80YQhLGY5lo9dktYyry3040=;
        b=Y+IDLcpE8qxRoGmHYF9dAocj40pRqTUlQ34bVx6EN43+5wGC7Ice4N2cKq0hF/rwmz
         Mazcd7/IOCVOqSU39e12aO6qSCNiz1MwBPsj0nE5uvEA7WIoySWGvYZ77sBOs4WB3XZd
         +O5NPKk4lspE7GTzAiOM8wVo/5oT5nyn9Kk44pa1l+HRVzceOk7df2ddkhmR6eZa48fQ
         DC7pVVQujGfiBfdM50dxJtMK6gHnMCmmKlk6JCqClgjW+NPDLPci0++AxI62B/26WXFQ
         +N10w9CAvoZ6qcCH9pDJlB1CSojMQ//dqC1hPbrFKgO5D0UHTMSOnxzTcBN0gXymwLKi
         p2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737525164; x=1738129964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIZ4JWBoERe85R1qokaI80YQhLGY5lo9dktYyry3040=;
        b=KWlUWFk+nURPWz8226yi5KMp6XNQJxWvi+A5I3s5ZXnwdDbEq4YL846V0Oh71Q8CUQ
         E3uQB0qolR18e8TxKRe4zF3i3mF+sNH9Tlq8UkARvQHVFu5A54fIK6nVorNLP8f4JrrD
         lwKedk0QFYUoBXHPfcXH8N1ECO8Ba5VnzwuN5aj4Ca4xaz3ObjNL3eZFXI/qlwTPTJjR
         h3DUAG7uOL/nUe/GVt+CGO0jzJdNsvYbyxL2y1kejI+6mkXKigfExBJftzVK8t90+bu0
         amX1YLrW5Un1fobpH8EElZs38vmCA0Pk7XRCJJatccPe71s7PzuEII4sYyrznaDnDt69
         JtOg==
X-Gm-Message-State: AOJu0YwhR/DbT3ZBhr49MhCaw9bns47JnxL8wXTD9rlDuedDpWqZ4RCS
	Bcu+x507ehM3KyK5s62051mTthq0e7UM6e72x49m4SrvlmTLYkNb
X-Gm-Gg: ASbGnctQfN94ovN62Qq1ZU0Z8zp0J6TxLobUmuvFSxhRzSq/RXvhmEajRKnQBZLUrHx
	a1Am6xkm1WLG2zlrqXOpn+TjVAlU5FpZK+z59Ytr3STfkaSD3SF48ezqEymsmoLf5htEjRw8oKQ
	PII8Wk+MKA+/NQ6Gu+o2MTEzVMRcv4bAO8mvP0CbZCOhfIQcEN+qDhCcEXWENhKWINccI1a1IMu
	cDB6Sin+02g/UQsEAr2CjH1gbo61+LJ/8SmPw61dETDWr17e4OTU1Jfk9cn
X-Google-Smtp-Source: AGHT+IEMERNf0CAbcXPzg/rzGFntCuPDmQzLA9ME8SZaMWHZjXR1p4ty85shv2aBuJWkttmh70Sf/A==
X-Received: by 2002:a05:6a20:2591:b0:1e1:e2d9:3f31 with SMTP id adf61e73a8af0-1eb2148df72mr29099403637.16.1737525163660;
        Tue, 21 Jan 2025 21:52:43 -0800 (PST)
Received: from gpd ([2601:646:8f03:9fee:1eca:6066:421d:7396])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8ed3sm10013391b3a.113.2025.01.21.21.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 21:52:43 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 21 Jan 2025 21:52:48 -0800
To: Nathan Fontenot <nathan.fontenot@amd.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	alison.schofield@intel.com, linux-mm@kvack.org, gourry@gourry.net
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
Message-ID: <Z5CHsFgDnrUT789g@gpd>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>

On Thu, Jan 16, 2025 at 11:42:05AM -0600, Nathan Fontenot wrote:
> Introduce the ability to manage SOFT RESERVED kernel resources prior to
> these resources being  placed in the iomem resource tree. This provides
> the ability for drivers to update SOFT RESERVED resources that intersect
> with their memory resources.
> 
> During boot, any resources marked as IORES_DESC_SOFT_RESERVED are placed
> on the soft reserve resource tree. Once boot completes all resources
> are placed on the iomem resource tree. This behavior is gated by a new
> kernel option CONFIG_SOFT_RESERVED_MANAGED.
> 
> As part of this update two new interfaces are added for management of
> the SOFT RESERVED resources. The release_srmem_region_adjustable()
> routine allows for removing pieces of SOFT RESERVED resources. The
> the merge_srmem_resources() allows drivers to merge any remaining SOFT
> RESERVED resources into the iomem resource tree once updatea are complete.
> 
> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> ---
>  include/linux/ioport.h |  9 +++++
>  kernel/resource.c      | 79 +++++++++++++++++++++++++++++++++++++++---
>  lib/Kconfig            |  4 +++
>  3 files changed, 87 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 6e9fb667a1c5..2c95cf0be45e 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -249,6 +249,15 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start);
>  int adjust_resource(struct resource *res, resource_size_t start,
>  		    resource_size_t size);
>  resource_size_t resource_alignment(struct resource *res);
> +
> +#ifdef CONFIG_SOFT_RESERVED_MANAGED
> +void merge_srmem_resources(void);
> +extern void release_srmem_region_adjustable(resource_size_t start,
> +					    resource_size_t size);
> +#else
> +static inline void merge_srmem_resources(void) { }
> +#endif
> +
>  static inline resource_size_t resource_size(const struct resource *res)
>  {
>  	return res->end - res->start + 1;
> diff --git a/kernel/resource.c b/kernel/resource.c
> index a83040fde236..9db420078a3f 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -48,6 +48,14 @@ struct resource iomem_resource = {
>  };
>  EXPORT_SYMBOL(iomem_resource);
>  
> +static struct resource srmem_resource = {
> +	.name	= "Soft Reserved mem",
> +	.start	= 0,
> +	.end	= -1,
> +	.flags	= IORESOURCE_MEM,
> +	.desc	= IORES_DESC_SOFT_RESERVED,
> +};
> +
>  static DEFINE_RWLOCK(resource_lock);
>  
>  static struct resource *next_resource(struct resource *p, bool skip_children)
> @@ -818,6 +826,19 @@ static struct resource * __insert_resource(struct resource *parent, struct resou
>  {
>  	struct resource *first, *next;
>  
> +	if (IS_ENABLED(CONFIG_SOFT_RESERVED_MANAGED)) {
> +		/*
> +		 * During boot SOFT RESERVED resources are placed on the srmem
> +		 * resource tree. These resources may be updated later in boot,
> +		 * for example see the CXL driver, prior to being merged into
> +		 * the iomem resource tree.
> +		 */
> +		if (system_state < SYSTEM_RUNNING &&
> +		    parent == &iomem_resource &&
> +		    new->desc == IORES_DESC_SOFT_RESERVED)
> +			parent = &srmem_resource;
> +	}
> +
>  	for (;; parent = first) {
>  		first = __request_resource(parent, new);
>  		if (!first)
> @@ -1336,11 +1357,12 @@ void __release_region(struct resource *parent, resource_size_t start,
>  }
>  EXPORT_SYMBOL(__release_region);
>  
> -#ifdef CONFIG_MEMORY_HOTREMOVE

If CONFIG_MEMORY_HOTREMOVE not defined, it seems we do not have a
user for release_region_adjustable as
release_mem_region_adjustable() will not exist.

Fan
>  /**
> - * release_mem_region_adjustable - release a previously reserved memory region
> + * release_region_adjustable - release a previously reserved memory region
> + * @parent: resource tree to release resource from
>   * @start: resource start address
>   * @size: resource region size
> + * @busy_check: check for IORESOURCE_BUSY
>   *
>   * This interface is intended for memory hot-delete.  The requested region
>   * is released from a currently busy memory resource.  The requested region
> @@ -1356,9 +1378,11 @@ EXPORT_SYMBOL(__release_region);
>   *   assumes that all children remain in the lower address entry for
>   *   simplicity.  Enhance this logic when necessary.
>   */
> -void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
> +static void release_region_adjustable(struct resource *parent,
> +				      resource_size_t start,
> +				      resource_size_t size,
> +				      bool busy_check)
>  {
> -	struct resource *parent = &iomem_resource;
>  	struct resource *new_res = NULL;
>  	bool alloc_nofail = false;
>  	struct resource **p;
> @@ -1395,7 +1419,7 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>  		if (!(res->flags & IORESOURCE_MEM))
>  			break;
>  
> -		if (!(res->flags & IORESOURCE_BUSY)) {
> +		if (busy_check && !(res->flags & IORESOURCE_BUSY)) {
>  			p = &res->child;
>  			continue;
>  		}
> @@ -1445,6 +1469,51 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
>  	write_unlock(&resource_lock);
>  	free_resource(new_res);
>  }
> +
> +#ifdef CONFIG_SOFT_RESERVED_MANAGED
> +/**
> + * merge_srmem_resources - merge srmem resources into the iomem resource tree
> + *
> + * This is intended to allow kernel drivers that manage the SOFT RESERVED
> + * resources to merge any remaining resources into the iomem resource tree
> + * once any updates have been made.
> + */
> +void merge_srmem_resources(void)
> +{
> +	struct resource *res, *next;
> +	int rc;
> +
> +	for (res = srmem_resource.child; res; res = next) {
> +		next = next_resource(res, true);
> +
> +		write_lock(&resource_lock);
> +
> +		if (WARN_ON(__release_resource(res, true))) {
> +			write_unlock(&resource_lock);
> +			continue;
> +		}
> +
> +		if (WARN_ON(__insert_resource(&iomem_resource, res)))
> +			__insert_resource(&srmem_resource, res);
> +
> +		write_unlock(&resource_lock);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(merge_srmem_resources);
> +
> +void release_srmem_region_adjustable(resource_size_t start,
> +				     resource_size_t size)
> +{
> +	release_region_adjustable(&srmem_resource, start, size, false);
> +}
> +EXPORT_SYMBOL(release_srmem_region_adjustable);
> +#endif
> +
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
> +{
> +	release_region_adjustable(&iomem_resource, start, size, true);
> +}
>  #endif	/* CONFIG_MEMORY_HOTREMOVE */
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> diff --git a/lib/Kconfig b/lib/Kconfig
> index b38849af6f13..4f4011334051 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -777,3 +777,7 @@ config POLYNOMIAL
>  
>  config FIRMWARE_TABLE
>  	bool
> +
> +config SOFT_RESERVED_MANAGED
> +	bool
> +	default n
> -- 
> 2.43.0
> 
