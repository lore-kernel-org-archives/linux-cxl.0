Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EEA238C12
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846777; cv=none; b=pG0fGyfOxJi/yuxI1FTF9s9PT3NSJYYZDEEEooRIrkDiHEuW+DcAQs7g6xZ1E0WwDAwpmuuvjZeRRu3qorG8XoyTQ4yWmi+pHS2nUCS5G/QVSSEuE8omdlEATTLfrCFNyz5hw7cBMqfkm17Bl3woeaAA2tXqf0i7qd1EfcRNZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846777; c=relaxed/simple;
	bh=QcNdH+Sz49XjZBR0uJqipxNzHS0KM+DQwKX0scg981A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMHi0Hj8rrlYjj3koJWEF3HPPBSm6risK2fdnFnT7HhcTB8yCqU4WSTqyqMCYaDoxgWHbF4rNjApPKhR2isCF3E2k+3b42/MK5sAfokeN/x923kAb5ISphtmaxeuVDExgFvIgZtXz/CB0Pv4r0Vn0e/ay6GQKcnzmDg9SLrY/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTfp/r2X; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTfp/r2X"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c9563fd9so3473813b3a.3
        for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747846774; x=1748451574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd6ZIFTZZmBbT7NmrB6VUv3CJ3IJftMLK1vLzp+yZ8Q=;
        b=nTfp/r2XY0l+GIrwO4a0QtVUJ0XR0KJW0n0HMxTCQ44m0F8g0KsJp3OHqzEjNxARWD
         /xB+BPloB7d0hmnp/Tk5wv1WxHbxLP3VxoAV5+D7/RbiVaVzn6TZXHBXCAltg3aSe5rz
         71VnpYz7quyOt12st/DsEyofiLhd+NKzhF61w+35UJoILFA3oPFnp2w9+hxFgjft5+j+
         UCK4O+m1jvquIijjipJgF2ikRcitVZDHYrAVKA+MJGclGhDSYoKivrJF/+SHWtd4Cn41
         m/0QOhjLDMWajcLrKuMC7t4WFg/6BOrcBDrSNzvU7etqSVNkALoNd12R94mVSCmcgTpM
         2cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846774; x=1748451574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bd6ZIFTZZmBbT7NmrB6VUv3CJ3IJftMLK1vLzp+yZ8Q=;
        b=Og6xSmcDteI+8iORjVvGmyi6i+mEvyeK+YaL1vrgsiCAylk5ysxTv1jPibFuLqranY
         TjT5qD2QTiaMooi7AMrtZLewxcSa1EEN03qtOz3HmtTCMc1VeGgRsMMV77+3fQdYzOMe
         QFQJg6ymNH6Cw98hsPtjJZ0zpgUj9AiXS66E8HOq2rrbp//mJ05JSPL2tHaT01VgoxAj
         DQP85D5J2UcXBXOTdOZO8kcs5p1IQA3uSfVFPvGMsPKJTSueXleYJ5eR3aLPPlaBL2u7
         +aHujD4vrbcQfkL9AcfjjLuwA0PdXMZObqIDAreQU3BzGNr7UKIYSFjt5YT5AcE6EI5K
         lCyg==
X-Forwarded-Encrypted: i=1; AJvYcCVjcPCHE0reJlglCF/HY6+SDL3bPawdQgqH84gJdlIgLjJAzWQQJja2NJ7GxImgmYcvjc/bffB+rys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBH9KQM2leMVZ7TS0SOCe2zaCyF5OgtbrHVlbSxonwivocoYfo
	FILLZFXzo616gk2YQvHUNyjDIaY4s1jOpFnRUYDn21+0s7eOQO/64AnY
X-Gm-Gg: ASbGnct+QRDLwQIHmDJwd0vw6oB18Fpk22SiNL8ZTGYke+IGfOxFHg9lfF5K6jN8OVA
	9jHxnDQEuxAzTBkBjjEFCKlWrHJ3Mm91VpVB1E6rKEk0pNp6Z6Ic02SQq4F2J960bSkt1CcWsYk
	DT8vxrQ7pBKjIpIyFqvA8zj0jhbQHCoxHM5rxzFnf4o9d7EysCSk9XPmneQSxw+ycVoxy7P0vy7
	REsBHB5z0g6omCOBMmrJeREaZ0GZOHSD2OU2qqEn4oqM37yxS0NZt3d+/sy+0KOl3qr0nmkUxuF
	/ZgW4dbkBo+hk1iFoQHoogqFPUFjkhA4ALMx1N5jIAPjNY1EMvdaNIE=
X-Google-Smtp-Source: AGHT+IEFXEYkEG/bbYXgCGKkIh+JxF1NvuNlk0oZ8z6sRx8WzVQWgtRD58yDof9ZQfHnQN7Xkh2kEA==
X-Received: by 2002:a05:6a20:1591:b0:204:695f:47e1 with SMTP id adf61e73a8af0-2170ccc0efdmr31537492637.23.1747846774329;
        Wed, 21 May 2025 09:59:34 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829bbesm9837482b3a.89.2025.05.21.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:59:33 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 21 May 2025 16:59:31 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
	mst@redhat.com, linux-cxl@vger.kernel.org, linuxarm@huawei.com,
	qemu-arm@nongnu.org, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Itaru Kitayama <itaru.kitayama@linux.dev>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v13 1/5] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
Message-ID: <aC4Gc7TMHHwuNGwl@smc-140338-bm01>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
 <20250513111455.128266-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513111455.128266-2-Jonathan.Cameron@huawei.com>

On Tue, May 13, 2025 at 12:14:51PM +0100, Jonathan Cameron wrote:
> To enable these to be found in a fixed order, that order needs
> to be known.  This will later be used to sort a list of these
> structures that address map and ACPI table entries are predictable.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl.h | 1 +
>  hw/cxl/cxl-host.c    | 9 ++++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 75e47b6864..b2bcce7ed6 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -27,6 +27,7 @@
>  typedef struct PXBCXLDev PXBCXLDev;
>  
>  typedef struct CXLFixedWindow {
> +    int index;
>      uint64_t size;
>      char **targets;
>      PXBCXLDev *target_hbs[16];
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e010163174..b7aa429ddf 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -24,13 +24,15 @@
>  
>  static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>                                             CXLFixedMemoryWindowOptions *object,
> -                                           Error **errp)
> +                                           int index, Error **errp)
>  {
>      ERRP_GUARD();
>      g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
>      strList *target;
>      int i;
>  
> +    fw->index = index;
> +
>      for (target = object->targets; target; target = target->next) {
>          fw->num_targets++;
>      }
> @@ -325,14 +327,15 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
>      CXLState *state = opaque;
>      CXLFixedMemoryWindowOptionsList *cfmw_list = NULL;
>      CXLFixedMemoryWindowOptionsList *it;
> +    int index;
>  
>      visit_type_CXLFixedMemoryWindowOptionsList(v, name, &cfmw_list, errp);
>      if (!cfmw_list) {
>          return;
>      }
>  
> -    for (it = cfmw_list; it; it = it->next) {
> -        cxl_fixed_memory_window_config(state, it->value, errp);
> +    for (it = cfmw_list, index = 0; it; it = it->next, index++) {
> +        cxl_fixed_memory_window_config(state, it->value, index, errp);
>      }
>      state->cfmw_list = cfmw_list;
>  }
> -- 
> 2.43.0
> 

-- 
Fan Ni (From gmail)
