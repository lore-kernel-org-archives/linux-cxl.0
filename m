Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9EF26B97E
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757132; cv=none; b=i0MF6uHk0YCwUtnkuExsZuX6wlvl2onTAYfa39+jmYa6NmPGbWysOgac2YA89S8puLlruqiKQ2lICChOZLHg+i74js9Ma1vnwQQYDdR6hxfkO1Sw2Xx0ctcBLkkXDidALnH2leWkjZ2pSLfF5e3/YrjDkgq9+3RDolBUmdCXFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757132; c=relaxed/simple;
	bh=OKj5p6MoWUnTbstfV6rkNEWIC/Dn6NfWaVj4sY+JByo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/MObYzTqB29m/Gyap4XGTSR7dLdzDLrNz3oRGwe5bxZJ6efJhoj7cBLW9IMpwMzxEkzi3+rTdnEPcOg+vVrROdOAy36FqfCgsJyF5o4rNnbXxYfXgJGfOZC7URMxYfeYhLO4+/2ieEyUTFNjFWlmFrdx34yOMUVhAwl2RMkR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdF907wB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdF907wB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c336fcdaaso46093955ad.3
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747757130; x=1748361930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/6sMJeL+6+CmWHLAjXbC2hLM8VOcfQ7nl6fo+PeHtvQ=;
        b=KdF907wBznujngeyHBtv3FrDGqURybbDOVVA8iTzrQNrvVJ8DvUOhP9tzcSJ4VpEDa
         ulwrc3EytBlE7WQoONPkNUJq9ENWGYQhoWV+UIKLS0+saYt9rHRvxjItds8y7UJT+g6m
         aXErUPD3MRGl97blYqQbrc03fWfjESd6yoR1BlGkec+CagOQmuadyv8k7pU9wixSLSyF
         7b+kH+0E4lvecx0rudyPG10mC72sFbqMYR3lqwNnJhchQvwIbr6isrft102U0ylFJPy9
         ba4e7Aw78DFaNaZ47lntTNTpPAw6Lpron0qJC1i0nz0e+oUiWXUSH6g+Zpm9vePm+iun
         gXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757130; x=1748361930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6sMJeL+6+CmWHLAjXbC2hLM8VOcfQ7nl6fo+PeHtvQ=;
        b=QBKYpuS9j9sehrHp8QDr8RKTxUglQT5ONTSUfTKue1hvuZ5kuPEhvzsEhGoZHFL3cx
         rUIKbXMXBYlD+PejGV1lNgG5VykYD5Jgdhm17hY2IvziHA5si3MIiAt3hme6ugywjLMY
         h0RFlNYQseWlyYt+da02+mKwMz8q5Ep6kxmHQyvWk7+/Qb7c8YAGYGCYk/mDObVIvnB2
         GOwpcyHILqulNgyL4fN+r/o0N3DsH3eAHwf9WUEq1kHxk0qsqJjfI505g8+K+oYikl/y
         639ELHxADDpBoLjY3Fsk8WX20sm4hCpDIpR0Z7E4WmOn0JIE8kloeuAykx5gX8Pi0dWb
         qUjg==
X-Forwarded-Encrypted: i=1; AJvYcCVvfT77cVA10cvUiLsYgFzjt31fAyZ3DE93IsIwBLBOu1xKOlatwTdpDaG/isM/1Cn/H51gChO3iNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMiOUVhbxYRetHXvJE6UcwwgXhXJQkq7f1ZOC66Wk2izqc/OqQ
	f3tTe36Jb4R7WbhyfrKSJ91kw8McAuUTEe/lobTyyz63ODZehxkF3Reu
X-Gm-Gg: ASbGncu+jr0t9aHCVMYifbpZXavqgMBNqwwXS933UGGDj7pyP3R6dnqVorBulq+f1N8
	Rr4/PiZMNZrj+fcKll6IWl8yq0rhSDI4sX5lgHlB4emeV/DOli91ug9MpMbelTiSGz/8MsBXOl5
	e8NGE7V/BL6a5PKYpNSEzVcXdbCf4wRM8uZQnjGaXZ7BDxDV0JbSg1lxlntITxOeEgdVmIyf/B6
	P6ZZIdQ8goMvY3ag1U1tWcVuK+wxphNadZTLWJlelfRG8F8ovfq2addUy4w0ceuWp7mZqRj62ML
	VAQZsxYFKlkMxsPC+TkCrtUypmrJuyMorDm3UGZszQ==
X-Google-Smtp-Source: AGHT+IHHmn5fYi+4RFwBN/1ksj4IBFBleWBF5S9SwFaREwh2uZNh4psYALQqkfpFPqcA3yxmklAAcQ==
X-Received: by 2002:a17:903:11c3:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-231d45eeeb0mr217773035ad.52.1747757125779;
        Tue, 20 May 2025 09:05:25 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e98018sm78925215ad.155.2025.05.20.09.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:05:25 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 09:05:15 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 03/10] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <aCyoO3FuMb-Hqe8i@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-4-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-4-anisa.su887@gmail.com>

On Thu, May 08, 2025 at 12:00:59AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> Add booleans to DC Region struct to represent dsmas flags (defined in CDAT)
> in preparation for the next command, which returns the flags in the

s/next command/mailbox command 0x5601h/, otherwise
Reviewed-by: Fan Ni <fan.ni@samsung.com>

> response.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>


> ---
>  hw/mem/cxl_type3.c          |  8 +++++++-
>  include/hw/cxl/cxl_device.h | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 7129da0940..05d4c861f1 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -232,10 +232,16 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>           * future.
>           */
>          for (i = 0; i < ct3d->dc.num_regions; i++) {
> +            ct3d->dc.regions[i].nonvolatile = false;
> +            ct3d->dc.regions[i].sharable = false;
> +            ct3d->dc.regions[i].hw_managed_coherency = false;
> +            ct3d->dc.regions[i].ic_specific_dc_management = false;
> +            ct3d->dc.regions[i].rdonly = false;
>              ct3_build_cdat_entries_for_mr(&(table[cur_ent]),
>                                            dsmad_handle++,
>                                            ct3d->dc.regions[i].len,
> -                                          false, true, region_base);
> +                                          ct3d->dc.regions[i].nonvolatile,
> +                                          true, region_base);
>              ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
>  
>              cur_ent += CT3_CDAT_NUM_ENTRIES;
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index bebed04085..cbcc1bc9f5 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -177,6 +177,15 @@ typedef enum {
>      MAX_LOG_TYPE
>  } CXLLogType;
>  
> +/* DSMAS Flags Bits */
> +typedef enum {
> +    CXL_DSMAS_FLAGS_NONVOLATILE = 2,
> +    CXL_DSMAS_FLAGS_SHARABLE = 3,
> +    CXL_DSMAS_FLAGS_HW_MANAGED_COHERENCY = 4,
> +    CXL_DSMAS_FLAGS_IC_SPECIFIC_DC_MANAGEMENT = 5,
> +    CXL_DSMAS_FLAGS_RDONLY = 6,
> +} CXLDSMASFlags;
> +
>  typedef struct CXLCCI CXLCCI;
>  typedef struct cxl_device_state CXLDeviceState;
>  struct cxl_cmd;
> @@ -609,6 +618,12 @@ typedef struct CXLDCRegion {
>      uint8_t flags;
>      unsigned long *blk_bitmap;
>      uint64_t supported_blk_size_bitmask;
> +    /* Following bools make up dsmas flags, as defined in the CDAT */
> +    bool nonvolatile;
> +    bool sharable;
> +    bool hw_managed_coherency;
> +    bool ic_specific_dc_management;
> +    bool rdonly;
>  } CXLDCRegion;
>  
>  typedef struct CXLSetFeatureInfo {
> -- 
> 2.47.2
> 

-- 
Fan Ni
