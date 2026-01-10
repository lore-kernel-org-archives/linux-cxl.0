Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A32BEC5A
	for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768072425; cv=none; b=ZfxFLCRf9RVfxEmLOtbi4oWQ6qBt4rHDt2kDUQxGihEFIbeSDDXIZ1hodLN14CUgr5sj5LxQFXJZ6Dj2dPnd7PINsdJHq/iJe5RnWmGwRY90UW0ohB62lZ9Ns6YftpH6hzUu8S6UGTeuB/OhV+enSY+SuXUKafF8onVcz1C6Y2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768072425; c=relaxed/simple;
	bh=gsgoliyVDjM234wOQ6XNJCElfvV/BWp+oyiqwvbqWYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMHO22G0x3X3v1SYNsQ+nxciDs946e7vAn4KF1Orzx3uGrRkYIREi068oGg+t+MnDYTMtXY2ug/QV28S6u6dg7BhFcmt/o9esUEtR75IJ9lqdlEqoVxI7JDP7QeDT8qMsZH2PLX9NRjnMFaOix77GaJn0XpsmftqYNcrG8awvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ45zEY+; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ45zEY+"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45085a4ab72so3237595b6e.1
        for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 11:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768072423; x=1768677223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wc+4dGtNJwImkk4e3z1oLydA4nRcQFRWdxyLMHd1ydM=;
        b=PJ45zEY+fhdZzw5jzCZYk9UJ4vNzoR/JfXm+Tzd5droDrRwpnC0uD90LRRofbEH8Kp
         kpIP9xhcoXvsuFiGfOgNQOPYvu7WFs1l4oJ+lF+ociFTtb/6ZJZ28CEwawNEGme5JK60
         BtbxmBCajtMkFKoJ6HtIh4GFBW+33c5tQek6A01n8Rzp4ekVXpFcC0hSQj3g2Y5jzU80
         xEPt7lNNznjUh4XOVq4NFGV0WH9bSPzJB5MrxDuFDkeu5JNhfCEF5fKo5e3HkVXls2AH
         ho3JiQyz+KpIkNirXrzzOSiEfhGHbuGaAAGVpm9jFTEZe8e6XWbS/3zhqqDa62DcyRU8
         DM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768072423; x=1768677223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wc+4dGtNJwImkk4e3z1oLydA4nRcQFRWdxyLMHd1ydM=;
        b=FYnlMGWfLqOI/IFvbzvW9CRgWg1D/mSpNNi/+9e4J6hBWfJF7TUJrB+MFwP3Ex8WJz
         S0vw9bgtVOMAslEB+Ui1KHG6z7FZo0uDeytQc538nUy6hJOpq5WYcvP3JiQnb2B61Oz6
         0kTUrREsdHCN+yHooB0l5lO0DamhzqbpZidsUQ3CE/F4FXmpmW3Mv+wmtASup5vlV86s
         zLwVMHPDsFiBiyP4PLg309qYP3hl7e3uMhp83QcbzjU2ROu1TfyYkZCsgr0oPYRyIvHY
         3U/hGLczhKzkqh3FPCN7wl2SPmoMyAaS8eC6Jy6Eoz0Zbg4KtN+Cv1vECaTxazjVAoiT
         3jFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8/hETmn399tNUr7PZvx8+cjPtmPMAcL1t5/WoPeT1DgwC4gqZIUTnxBUO8iVRnzxY8bTxMpfLc0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfS/D5eoBHm3dTCd4kFaEad2UyK6q3qfJYWqQ0eI/FgcPifFlu
	pSga/dP+JIh9oInf7vb9tWiUgEzXmSZ2Bt9oAzs3KzL+XUIWNUowiQ6D
X-Gm-Gg: AY/fxX7JjqSDMdslPYXmF5FbFjSMCl+wHs4ItDEXi8mdw0Z2Lj0snQfR/Y7AKJjJEqR
	L1D9timZbXNGkQnvukWFcN17wnfyig0Ut82q3TZEskUl44FB0JEmKWbEg83ua5cY13aD3SxJT04
	CDlI9noKe9QcJDNX3bYKyk8J3JkK0vXkHxctXIY9ZL/U+GZBVfSWRqfiJMTf49XOMalSNAtGzpd
	p4YtBcrBL5A0UzYztsBU+n0V9P1OdPQ7Fo86cArdnrujzXKqv2RUCGmVrVEYfsiCGi4M+xCD8Cr
	7DZIAsNnUzhKahj9jUmKEaix7GUBg5wV/CpIGiiNjaHrc8J1kjoxR9UisD5hJ82jzkSCw3Cbhgh
	qSPXnL22gB5BhxM2Z8xIfZj8NZMtzJP1agu83uHoUK0vot9TGDUPYOvouobs7dWry5XBmR8wIZ6
	ByLgKw8aTqS9yPDFoKRskG8C+39rL9mrPtvB7bAkS9
X-Google-Smtp-Source: AGHT+IFQIHIwmdD3f0srffHy+uB/kjZS5o3+PdDs29M5EQ2Amx3bbRZ+yCxL3+7h4N3jY9ouVmS52A==
X-Received: by 2002:a05:6808:4f66:b0:45a:683b:7442 with SMTP id 5614622812f47-45a6bf0d211mr7204726b6e.65.1768072422851;
        Sat, 10 Jan 2026 11:13:42 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:7d36:1b0c:6e77:5735])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4a9099csm9257173fac.0.2026.01.10.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 11:13:42 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sat, 10 Jan 2026 13:13:41 -0600
From: John Groves <John@groves.net>
To: Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: John Groves <jgroves@micron.com>, 
	Joao Martins <joao.m.martins@oracle.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	David Hildenbrand <david@kernel.org>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add some missing kerneldoc comment fields for struct
 dev_dax
Message-ID: <dpsovlsss4mwzao55t4clx4skxy7dtyka3igx55godmdq6rliw@kngcblth5yw3>
References: <20260110190723.5562-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110190723.5562-1-john@groves.net>

On 26/01/10 01:07PM, John Groves wrote:
> Add the missing @align and @memmap_on_memory fields to kerneldoc comment
> header for struct dev_dax.
> 
> Also, some other fields were followed by '-' and others by ':'. Fix all
> to be ':' for actual kerneldoc compliance.
> 
> Fixes: 33cf94d71766 ("device-dax: make align a per-device property")
> Fixes: 4eca0ef49af9 ("dax/kmem: allow kmem to add memory with memmap_on_memory")
> Signed-off-by: John Groves <john@groves.net>
> ---
>  drivers/dax/dax-private.h | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 0867115aeef2..a7c4ff258737 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -65,16 +65,17 @@ struct dev_dax_range {
>  };
>  
>  /**
> - * struct dev_dax - instance data for a subdivision of a dax region, and
> - * data while the device is activated in the driver.
> - * @region - parent region
> - * @dax_dev - core dax functionality
> + * struct dev_dax - instance data for a subdivision of a dax region
> + * @region: parent region
> + * @dax_dev: core dax functionality
> + * @align: alignment of this instance
>   * @target_node: effective numa node if dev_dax memory range is onlined
>   * @dyn_id: is this a dynamic or statically created instance
>   * @id: ida allocated id when the dax_region is not static
>   * @ida: mapping id allocator
> - * @dev - device core
> - * @pgmap - pgmap for memmap setup / lifetime (driver owned)
> + * @dev: device core
> + * @pgmap: pgmap for memmap setup / lifetime (driver owned)
> + * @memmap_on_memory: allow kmem to put the memmap in the memory
>   * @nr_range: size of @ranges
>   * @ranges: range tuples of memory used
>   */
> 
> base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
> -- 
> 2.52.0
> 

Oops, I somehow truncated the first line. V2 coming shortly.

Nothing to see here...

John

