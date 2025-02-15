Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4F1514EE
	for <linux-cxl@vger.kernel.org>; Sat, 15 Feb 2025 05:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739597507; cv=none; b=VD/JG0gTMOqDNCkVQ8QG+GMflFCiK/K/HS9nJSs87TkTVvC1QV2B+h5ZRg96rLNVXtbAWjEHbvYgKYcqit6VG+vb0dKY/dt2uepR2kp1b9F5G2OPoCgCy8jWQhY2jGeCP0bNHT2QwshjMSOvZQ8UsHCFdjNSmNU7act0o4SRbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739597507; c=relaxed/simple;
	bh=3dRHaR5rll499YKe2Mv2k5msIJ+yNKNKnReR+Jn5dJw=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uecOVfzoh1F5oJCvCBtHOGc/Jucoi86H3BWeei2VN19UK1iC9ckrRvl8Ks1jhnZyBlLUvCtIw5d/VI1KbbvEBOsduGkCW9oPQU8uAvc5e+AdVHIjPfY3IZ9w5o4xz+4EVJ569rMuINMn/vDn1tFVCax/M7DhM5q+YGRXfUZV/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Biscwdhe; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Biscwdhe"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fbf5c2f72dso4403087a91.1
        for <linux-cxl@vger.kernel.org>; Fri, 14 Feb 2025 21:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739597504; x=1740202304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KTmsz7aBaMraFMRnH0ALQy2FOpyB1fYrB6XU3fJoMJE=;
        b=Biscwdhe58do+AiEI3UOHJtMwMDvKf7JFKpmVhrhNaaHGbZDBrfDGZ6smrdk/kks+d
         Kv4KDcfvqFHOk2/Lemk1RDrhiaAsnasfYYwy9RXpBX+jgba6kC81myT1dGm3FnKCZ17v
         Yd+VZ2ft/Yj6DDGw7EjgXqOKEk3yY/JIfEmx8mpTjTHCNYaY5rRvZPQ0CmqkItE517UE
         ZdSbF8ynG35wKZ+4bRfxgaIxPhgI7Lpr6vzO3tc+82JFCI4i87r47vydHNO7zWXjtBz/
         lJ0F7pZfR8SC1nE0nSI7EuKYZdSjOB5fy3mOpGMnXwTQjAd0bdYRD7VObNWSRjSzSC7K
         CteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739597504; x=1740202304;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTmsz7aBaMraFMRnH0ALQy2FOpyB1fYrB6XU3fJoMJE=;
        b=sUD/bM7A83SrClJzZvP5b7a+/loyo/wSPcFzrTsIB7Mr7tgsvvTcN9uGfkJIlrtKFf
         tsSYB2AWy743SGYm+3RGhlDNURMSTxCQMHEeUXNMwrJEUVVP3gLpEf3/29fMFn+EWCxW
         ozlQdI6Aqy4M/df8/nYXCUfCmj1/WeZ14J5Vq28DRgmmeieYqa8ZCcYC1l+ZpOvJhYU4
         5aRkKIgbGsV8U2+ZrPstB9HteDRtCC5bgtuAUTLKFkRnfCgdl/hk343Bkd+pC7YGFeJz
         tXYSz7K1UBarzUhpoSY7eXpBSRLtTL+fSKFEb0oHfPU9FcqU/bxlffpH8lLi5/O6I0uF
         IHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAlvc7TdpZIadFm5tQ/DTRZhTNBA9NMDbrcVX6QWadHAEw6/3lzXjjNeA6N0xZ+vUZMM3Xn1jcbzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwduTxL/NLagOu7dzkrtEbcI/5BSFtfJ8cghfLhq6/C3hugRSy6
	YbEQm2IK1r6m1lQJgWRQWrCBgbWEwAlip46hi1Fa4rPUd9R/nRjw
X-Gm-Gg: ASbGnctlhfV+DTwtdAzA6MLPAdrS0uSCnYW1vU9pdC/vekQjsgD9u/8rqYSOqP4IA1Y
	Jr48dROeevgYvJMddg0yWzVFoXCmHy1B9ILKm+u3DvcEtNptz3DfUh69nRqnVutNMdkLkmfhexo
	jiPzt23NEd3bwg/JGHqgeTP2Oc586K0sDje4HoTiINxMv9eTf+2+rgNI8MEPZfXJDqPB5Mh47pN
	z1H4M5js3HC/EXuzV2rZMwBe3wfjKfzIU2DYbiMeEabxO1UQn3MsPgvnklBJQ2HwdwSnvO4+UlY
	vX+ZlbHRoLPWnkOfpAAIKYNcum0BtdO9rx3+Beu5yXc=
X-Google-Smtp-Source: AGHT+IH62GPn18Tt4iWwrL0gis3tyWFj4HxEbm1DpXqKf8esU3esKQcA4hBCKTYyNmve9KSeCfo3nw==
X-Received: by 2002:a17:90a:dfc8:b0:2ee:7c65:ae8e with SMTP id 98e67ed59e1d1-2fc40f103ecmr2888461a91.11.1739597503721;
        Fri, 14 Feb 2025 21:31:43 -0800 (PST)
Received: from asus. (c-73-189-148-61.hsd1.ca.comcast.net. [73.189.148.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364503sm36852205ad.80.2025.02.14.21.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 21:31:43 -0800 (PST)
Message-ID: <67b026bf.170a0220.3a2be4.9884@mx.google.com>
X-Google-Original-Message-ID: <Z7AmvFlEaRCLNl9Z@asus.>
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 14 Feb 2025 21:31:40 -0800
To: alison.schofield@intel.com
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH] cxl/lib: remove unimplemented symbol
 cxl_mapping_get_region
References: <20250215021319.1948097-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215021319.1948097-1-alison.schofield@intel.com>

On Fri, Feb 14, 2025 at 06:13:16PM -0800, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> User reports this symbol was added but has never had an implementation
> causing their linker ld.lld to fail like so:
> 
> ld.lld: error: version script assignment of 'LIBCXL_3' to symbol 'cxl_mapping_get_region' failed: symbol not defined
> 
> This likely worked for some builds but not others because of different
> toolchains (linkers), compiler optimizations (garbage collection), or
> linker flags (ignoring or only warning on unused symbols).
> 
> Clean this up by removing the symbol.
> 
> Reposted here from github pull request:
> https://github.com/pmem/ndctl/pull/267/
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  cxl/lib/libcxl.sym | 1 -
>  cxl/libcxl.h       | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 0c155a40ad47..763151fbef59 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -208,7 +208,6 @@ global:
>  	cxl_mapping_get_first;
>  	cxl_mapping_get_next;
>  	cxl_mapping_get_decoder;
> -	cxl_mapping_get_region;
>  	cxl_mapping_get_position;
>  	cxl_decoder_get_by_name;
>  	cxl_decoder_get_memdev;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index 0a5fd0e13cc2..43c082acd836 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -354,7 +354,6 @@ struct cxl_memdev_mapping *cxl_mapping_get_first(struct cxl_region *region);
>  struct cxl_memdev_mapping *
>  cxl_mapping_get_next(struct cxl_memdev_mapping *mapping);
>  struct cxl_decoder *cxl_mapping_get_decoder(struct cxl_memdev_mapping *mapping);
> -struct cxl_region *cxl_mapping_get_region(struct cxl_memdev_mapping *mapping);
>  unsigned int cxl_mapping_get_position(struct cxl_memdev_mapping *mapping);
>  
>  #define cxl_mapping_foreach(region, mapping) \
> -- 
> 2.37.3
> 
