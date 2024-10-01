Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9C84A07
	for <linux-cxl@vger.kernel.org>; Tue,  1 Oct 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790333; cv=none; b=rkaRtiNZ2a2o2/1wyR67VPpHjP+1IsdFDWmFr8d+YCT0+yUr8pJuSaVAjnl67Q6KAAM0CwjlsfzTHhF/JItY4B9d1P3Roud2WQdaJ6KZnpme3rDl7yNTaf2Je+JHN4ET920o/PGUwHhFnHsrx0n+uNQOxOOe1IeE4kyvtsh3CKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790333; c=relaxed/simple;
	bh=pDbBzy+BoAaB8dRVK++eCMB4Dk8+UyQ1Oily4R1FyeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogRMZ+FKWNDK/trOrXIYosfmg8u9N52qlZNoHr40GKFvNNQ+LdEgzi+sGUTy94JwhFdtB2SNPmfeYAzcziIYgTkGtaDxJovQzpMDhIt3gbtXKnGuEhxRDJEDI2YSUFhVZBos0ZHMzllZq96oOQxPZlxNMZbt695nFYbXuHq97XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=X+C5oohv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="X+C5oohv"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-458320b30e7so38797931cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 01 Oct 2024 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1727790331; x=1728395131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSUQi2CXVstrkKehz5CiFb0Pzkeiyixbu3bRD/RkH9w=;
        b=X+C5oohvOp13zcNxMOuL5rnEaH6QZ49pcNlQhgZnTVrkc0sX/BJEp/BqH8DXUMHOqD
         8k5iaYDUxGS2n2d0+ggc0F8fYcfGdZUjW4i2ensGh8/DGTKeahbNCZIFBjD70LJPvxBR
         lzi7C2mAUULmabslBMpMwxSEKpQocKnZRfjnzkjq8khH0iYq359Cb6LedBEEMpb9XqqY
         Ty9ru9g/zonqDTnse8hIHnPywVpgRUB9fua8DNneThpyz86su74I14Ot6OCb7ZB02xjB
         NRK+QX1kKBah8v2q63Fh4K02ZOdNaah15v1JYhSUV7CUKLWbmO4+HCjxxv2/kn3UsujS
         p4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790331; x=1728395131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSUQi2CXVstrkKehz5CiFb0Pzkeiyixbu3bRD/RkH9w=;
        b=UGE1H9m8uSsY++rrk3affOfrT8TwWmuHm5Haqqd6m28VQmHCOxPfCurNp5p19FH5eL
         T2kSVjA9hcB1hgpUMG8dvvj6wqee7Yb5fe4/8J4Gjbxb6/qg6Lx/ssCQipZELGfs3PY/
         c6Xb0bCy8BY5j4Ojrb59MX2rs2x1jyANuCKeZaV8Ql3AHUSyf1jVjY1NKkDdVeuVEzpf
         MH8uprot1m6d8kKRhFj4ZaVtowM1czS808hz9RUR+C9pTfSUWY5rd8d6JftOHgCt1790
         +ToF9qYNTe3A7OQ4ro54S5dNfzwinMaLKoOqYmDaB6oLdX0OCHPCfqTsF4tkDHrYGGDK
         XtKA==
X-Forwarded-Encrypted: i=1; AJvYcCXH8stdNPje35G+FO6qPUNvpj/UixfH8/Z+LxWC447IEqzZuKvU7FhD85WtLl1KU1gorjqQ+6XtE+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/tNzLex3H2MNxB8La++tFskj+yhM68PqfcmV+pB6uvvJvoR9j
	sRFx44LBVp4sEms0/xnU6tl/OBsSfYRyL2XRWrVAWRoSRPZRW9NkdF1IG6ULUhA=
X-Google-Smtp-Source: AGHT+IHTNZNNg4AQLQSBy40Dioqas1hHQVeTzNppv4MVcc0nfKq4d2Vb9YQRTsfNuVobQNhX/I7NCg==
X-Received: by 2002:a05:622a:58e:b0:453:5ce5:9972 with SMTP id d75a77b69052e-45c9f1f0f1dmr249279591cf.16.1727790330620;
        Tue, 01 Oct 2024 06:45:30 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f28ea36sm45405951cf.20.2024.10.01.06.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:45:30 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:45:01 -0400
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [RFC 2/5] cxl: Rename CXL_DECODER_HOSTONLYMEM/DEVMEM
Message-ID: <Zvv83Xg_jDilJgqx@PC2K9PVX.TheFacebook.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-3-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925024647.46735-3-ying.huang@intel.com>

On Wed, Sep 25, 2024 at 10:46:44AM +0800, Huang Ying wrote:
> Previously, CXL type3 devices (memory expanders) use hostonly
> coherence (HDM-H), while CXL type2 devices (accelerators) use dev
> coherence (HDM-D).  So the target device type of a cxl decoder is
> named as CXL_DECODER_HOSTONLYMEM for type3 devices and
> CXL_DECODER_DEVMEM for type2 devices.  However, this isn't true
> anymore.  CXL type3 devices can use dev coherence + back
> invalidation (HDM-DB) too.
> 
> To avoid confusing between the device type and coherence, in this
> patch, CXL_DECODER_HOSTONLYMEM/DEVMEM is renamed to
> CXL_DECODER_EXPANDER/ACCEL.
> 
> No functionality change is expected in this patch.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/acpi.c           |  2 +-
>  drivers/cxl/core/hdm.c       | 16 ++++++++--------
>  drivers/cxl/core/port.c      |  6 +++---
>  drivers/cxl/core/region.c    |  2 +-
>  drivers/cxl/cxl.h            |  4 ++--
>  tools/testing/cxl/test/cxl.c |  6 +++---
>  6 files changed, 18 insertions(+), 18 deletions(-)
> 

Reviewed-by: Gregory Price <gourry@gourry.net>
