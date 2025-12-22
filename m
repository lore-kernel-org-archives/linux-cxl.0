Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34B2F6168
	for <linux-cxl@vger.kernel.org>; Mon, 22 Dec 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766410585; cv=none; b=YACy0gvM0ftnKIhBOL9N1CIivy/a2vTCVPwCSIfr9vX+KDHqJVezjRc929rA7KN65zpLcBnshOlvI9/jxEmlR98Y8rXmnjnUR1VseN+n60Z1zMSvLtYsIINqQAxE7oEThIem8nLcNcljMQGI8qb1vZQqqepiTrcvrh1XIrhbTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766410585; c=relaxed/simple;
	bh=UNcawWnzv01dDL4jzcCtxfPSNlGJCEON/+jiQn5aS0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMUrdSTv7XeQOwbJ16ia3B5/THRyJCVW71m7EUKitKA1IGS5pPu2gl8l69sutgEmVc6cOS/YOm6+boz3QEo/vuYFeZSeVpwGZAM/M6PuReG/Vfd3JQQSPL6ZU6eFC0VY6cI+5saZt4l/K/HXijc+tAr1UvCKDAEnpZMcSiY0B80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epyOK1se; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epyOK1se"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4511f736011so2974593b6e.0
        for <linux-cxl@vger.kernel.org>; Mon, 22 Dec 2025 05:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766410583; x=1767015383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5H7iZ45FrF2tS4o+Y42wdgxFFcoGprkixQX9HHYUyv4=;
        b=epyOK1sel9fZtI3h2MA0MSelVY1NgMw5lvOtGNlEwU9cEjbThKCcr9rL1xBCytsSaE
         xseus7h2f6naXS1k3AxfagKgRhijLHZ4RML+XzTS1wy8RpTndv7s5px2vMK++z2vMXwR
         /rb0y2bOqdG+YbORpJRUrtHKccTbUB32VQgwT75qA2/FCAyBiVXFcBkI67BOSLP+H1Fk
         FHIp6i9vNmNO/ELStRrnn9UfwYqIcf6lgmyRaMQ0Rn2hGkEPIwpEQn/iycj/2y5EH7AM
         2asufe0lmRDFiBt1FPE+Qx4gwyoAJpywztG/bKvzgb4dFzdDKEVQiOofTNLJA9ZPtq57
         bYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766410583; x=1767015383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5H7iZ45FrF2tS4o+Y42wdgxFFcoGprkixQX9HHYUyv4=;
        b=WdAQzqmwgv4GhgFjjjzPSWY9D2dSSFjEoIUhIHsGX9hHPlOMF+/yG0k5+31OiQd4cU
         zA8ztsp97daxbmpnYH8Mn6iVOOdgT0j+n9KoQ3PybVMOnZHB+QBdufWTBVKrI9taYX9i
         988zWKbtY+88Ilg6W0ShHLVK8MYUgmiNm/IpPhORzUz+vlsMfhyuXR4lZkV2AhQ5V4qr
         ppimDY9DWRsUK/u6bxt/q3plFr8zflc0x7ZjGw1CS6jxbZU6mMQS34gFaEAXhIsaLfZ7
         l3Yqqdhe4CTZMHVw5ekg77g4theluazuLkkZquuvsg9flAgNcmVCjqRjxxyfhbgkv+/z
         wzlg==
X-Forwarded-Encrypted: i=1; AJvYcCXUqxkgNwdcrxA0mVCQemtQzqJICya9BokMSyCGFQZY8VcxbE+czcS3a8vKQXh/q+oP4CAYkNJXAwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs9eqjL7C3f+9ueuGrlapX9/pRz/7lGfr5QzvQRuPYbJUMnozs
	qjC2LfgKnF5cZkmy/8a3WWvtcxDm5k0gVbXyHC+o3aKWosOnHlWzWkO9
X-Gm-Gg: AY/fxX4CUIWTR1JivqZjSgJVjAup7+5Zkl63rcKHC5Q2ccVrT1uU7qjTSUG1mqvh+11
	oramY+OqJco8BFjok3HpJYIkPZhG3UOOnDIVJcM0QuBb0Nje7/qAWVEhArpA5nHGuFiAgXI4K7x
	87UycQWjcvEQ/Qc+hM7BeF9+pnBUb2yk6DIlhT3cA3AGOG4ddm5d//Bbrwft1kgdka0GiikNtO7
	jrZI8bPah0MbB0hWYd//lhirK3rx2oKQB+e6JxmXQxDo5wo3ymGHQZMQrdn/TpDM1iyxsFsgazL
	Qa78moXnUDUE4Zj5tETa6jMAenehiUX/W7jaX9XEakrYwC13DJ4HVaPesoQoeVGmFNYwq7elM8E
	JFqHcqEGSeG2m2K2GcGw0eCyfJlhHNksjLcpZZHBgxvdmRCM7XD6HwtBS1pkmDsFACkvVprrq0u
	hXopyjKtcJhH/Dex6uvpjd/FsS4JJ0zQ==
X-Google-Smtp-Source: AGHT+IFMAbxBTC55OcMj8bbxTyNSgdWaomaWM/ZZNGC1HLFwksIkDaaw+0SMTuleI3W7IPjVWcJ9Lg==
X-Received: by 2002:a05:6808:3a17:b0:450:bef1:f4e0 with SMTP id 5614622812f47-457a28b3decmr6717499b6e.15.1766410582575;
        Mon, 22 Dec 2025 05:36:22 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:d4a5:e713:bd35:50d2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaa4e0d18sm6318415fac.0.2025.12.22.05.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 05:36:22 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 22 Dec 2025 07:36:20 -0600
From: John Groves <John@groves.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Notify the "Device Memory" community of
 memory hotplug changes
Message-ID: <iugopjdd5u32zgzrpohhswmk3dcebkpgntkz4afuqjrjkdfpil@lyrdle4hghpc>
References: <20251220000327.3502994-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220000327.3502994-1-dan.j.williams@intel.com>

On 25/12/19 04:03PM, Dan Williams wrote:
> The recent episode of a warning regression in memremap_pages() [1]
> highlights that relevant updates are being missed by folks that care about
> core ZONE_DEVICE changes. Yes, CXL folks should pay more attention to
> linux-mm@, but it also would not hurt to copy linux-cxl@, where most Device
> Memory folks hang out, on memory hotplug changes by default.
> 
> Link: http://lore.kernel.org/20251219123717.39330-1-john@groves.net [1]
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Groves <John@Groves.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..076322fe91de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16426,6 +16426,7 @@ MEMORY HOT(UN)PLUG
>  M:	David Hildenbrand <david@kernel.org>
>  M:	Oscar Salvador <osalvador@suse.de>
>  L:	linux-mm@kvack.org
> +L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/admin-guide/mm/memory-hotplug.rst
>  F:	Documentation/core-api/memory-hotplug.rst
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> -- 
> 2.51.1
> 

Acked-by: John Groves <John@Groves.net>

