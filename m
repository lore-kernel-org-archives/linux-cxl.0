Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1326B94E
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760184; cv=none; b=s063el9hw8JjCoBjcPbi8pq+EcqAf+LO5u6Z01dPRkU8UwSGSsv82bIb15KwsFU7wz3ZUvJ3vN/ejAC+4DiuROJth4uUhjpGdrnd5Fs1YuU7zNy4mJs8ea3IpzP2UQvpslB27THtRbuLr4hqhRDw49M6QVuQF9R0RI66fdxEfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760184; c=relaxed/simple;
	bh=wYk0jB9qwqTZ0U59yOrlAPgUHgrwtHFxBMNsjR5wAD4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENPYiYI7pYpjxmsQCPOO9naBDRwroi68c30WW1qJeHln8d3/PZQs78W4Aw9b9NJbIYTm+Wb5nZtFv6Cb/4tuQM6J+JxFdEocIMLYoDFuzX6NjPb5g9DgrUJRPBE2hobps4fKHsnJ3p2dRphvX6+i0CkeX7ZppwbVmJG1FcVnwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/ZyTqB3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/ZyTqB3"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30f0d8628c8so1666430a91.0
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747760182; x=1748364982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vRLMitreON+vFW++48y7TglTchdWWbvnyq6iT67lMY=;
        b=P/ZyTqB3G22W8+XpFtE7zXj3CBv/zckSYAtE2c1Pw5kCVa9CaWTEIua3PnpCthpVDL
         WOF4oz6N7piE3O15c6RmDQ3y8DQ3QQ15xRAd5Sy3e49VligQujI8f0ExLw1K/S1ahZ0u
         gj5LQBuACL6Ez83Te41ehMHlDYbleZfnR/UUEMVGHui1n8OQQfgFk7tP9v+9wIdUzCBy
         NVnckoBl/dtm2d+JCP9g1y17rK7a1RWsjuP0h7JI407nM96uRSEI4VBwS3jNFnwVAOVi
         SD7ckuyeJmQGDfE91hJrFCngUUV71H/LvsMO0BA6tzhhoPnU9yJs9XspBxDpvhoVgeCL
         nZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747760182; x=1748364982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vRLMitreON+vFW++48y7TglTchdWWbvnyq6iT67lMY=;
        b=TUTGBRE44thkeZQpOqRPgZm+JqUIE6e6mD/bZsYHWw5BRMG+KiBja3KSvSXOylRjlT
         1aTtd+ytPRZMDyQB+C+z9ubWZ0HG5HXYQVoPc+OEKu4jpURiUEvMbPBhrSZyh/OKGXz7
         9ZNQ3N4HC1QZJKSTpDTN/6kflruM7CA9vsLdD7Or5yPnKHb6Ytcojp/WVH2j8i27+YFD
         RkpMlDCERqujGlI8ydRvLrDS6NT31LNU6xmPaGN+zinBvlMP1tLKQDHrzOTeljUuEF0e
         0NuLVavsx7U7x094b5OSnKf6KOb27FIQVPTbDrP7/dSZmvV0U5YVspA5VPHVkQWh1S0i
         V8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW7ur3aV07OmTP8PjM2jOCQ7ipLxUeDLPkWfBG7r7JS93SGiKlZXl8zAinDllKW8ljkYEiFxi0qNr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx26j49Oict87qSc1lt/8If7CoTkDrqLD9LSfq1GOtB9gRlM2L
	kW1ncBMqxTOzmIYQGwqi/l2kvNrva1hgQ05LP+65Z+3mUms44wZuzd/2
X-Gm-Gg: ASbGnct+kuqdvG9ecQLaxdJgxS4vZ9bYT1oTVIAistV3fRrhUNP0YGh2RzVAVKIgPeT
	XZQyVgSdjgRxavmvVZEzk7PjoRBaROxoJ+grHDN25rTvguno7YtLjbACETaq8+9xR9WOUhcEwZC
	zc9f7/DBKIfpN3MEZOO7k/FyO8gB1GmxIJgYjMcE8/qFvKTHjesL060RDJVEdlVDMO2i5jUKm8I
	I/BLVZLzJ9yQKJW0jUmc3L13xOZvcfztZGrD8WmTOq8j4D2pagr7YNniCyKAs/4yPSsiX9VRlY/
	WAHLuTizuRmI/9TCouqItfcoqBRgaaT4JcAju45oqQ==
X-Google-Smtp-Source: AGHT+IEldrYyfqRchNLhtdk3Ea5E8njSYxDDAnkx44QFrecfD06Y3xlMc2io0rTCgfTnWFsUuD9VUg==
X-Received: by 2002:a17:90b:3e8e:b0:2fa:1e56:5d82 with SMTP id 98e67ed59e1d1-30e7e87f02amr25553357a91.17.1747760181771;
        Tue, 20 May 2025 09:56:21 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d460fsm1928556a91.23.2025.05.20.09.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:56:21 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 09:56:18 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 06/10] hw/cxl_type3: Add DC Region bitmap lock
Message-ID: <aCy0MoOUEwFj8HQ4@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-7-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-7-anisa.su887@gmail.com>

On Thu, May 08, 2025 at 12:01:02AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> Add a lock on the bitmap of each CXLDCRegion in preparation for the next
> patch which implements FMAPI Set DC Region Configuration. This command
> can modify the block size, which means the region's bitmap must be updated
> accordingly.
> 
> The lock becomes necessary when commands that add/release extents
> (meaning they update the bitmap too) are enabled on a different CCI than
> the CCI on which the FMAPI commands are enabled. 

read/write access also need to touch the blk_bitmap to ensure the range
to access is backed by DC blocks through ct3_test_region_block_backed().

Otherwise,


Reviewed-by: Fan Ni <fan.ni@samsung.com>




> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 4 ++++
>  include/hw/cxl/cxl_device.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6ad48f55ce..b5b3df5edf 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -824,6 +824,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>          };
>          ct3d->dc.total_capacity += region->len;
>          region->blk_bitmap = bitmap_new(region->len / region->block_size);
> +        qemu_mutex_init(&region->bitmap_lock);
>      }
>      QTAILQ_INIT(&ct3d->dc.extents);
>      QTAILQ_INIT(&ct3d->dc.extents_pending);
> @@ -1176,6 +1177,7 @@ void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>          return;
>      }
>  
> +    QEMU_LOCK_GUARD(&region->bitmap_lock);
>      bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
>                 len / region->block_size);
>  }
> @@ -1202,6 +1204,7 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>       * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
>       * backed with DC extents, return true; else return false.
>       */
> +    QEMU_LOCK_GUARD(&region->bitmap_lock);
>      return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
>  }
>  
> @@ -1223,6 +1226,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  
>      nr = (dpa - region->base) / region->block_size;
>      nbits = len / region->block_size;
> +    QEMU_LOCK_GUARD(&region->bitmap_lock);
>      bitmap_clear(region->blk_bitmap, nr, nbits);
>  }
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index cbcc1bc9f5..9cfd9c5a9f 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -618,6 +618,7 @@ typedef struct CXLDCRegion {
>      uint8_t flags;
>      unsigned long *blk_bitmap;
>      uint64_t supported_blk_size_bitmask;
> +    QemuMutex bitmap_lock;
>      /* Following bools make up dsmas flags, as defined in the CDAT */
>      bool nonvolatile;
>      bool sharable;
> -- 
> 2.47.2
> 

-- 
Fan Ni
