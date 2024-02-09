Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6F5A787
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505475; cv=none; b=DsDVErH4XRnJvJlwoY+22H735hVra3E9NMLuGYXbh1bO6nlaOd4e/2ATeyRYs6X1oFhkp1tRoX5Y/uQ/u7rix8FrKuYnlNnGULCTPSZ+7gxCrFwQeFK45yXKSvvkTFuRqkbWUq45b82GhdZ9EdJ1gbMjbb/FjB4Tw6T6HjYdzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505475; c=relaxed/simple;
	bh=/VucBwaDbgqxUwjfqRzzZ0rhMwk8e59PJDsVHIuuCms=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQbPK2+lnPDp2TYVXY9IHnwM8UB9EfrmgQr/ndh9VjZ+pYJBclyluarIwa9aSD3DRtyWoxuX8KMAkOGE2tcnN1mfQ9AhWS0ncDNerfGXorU6vg10nOEMkSOuyuQYcVIzxCTxJAJtaHqPkzWN+TyAlGuze5Ds0hWxowiMEBR4RT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er4DaA+p; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er4DaA+p"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d8ef977f1eso11352725ad.0
        for <linux-cxl@vger.kernel.org>; Fri, 09 Feb 2024 11:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707505473; x=1708110273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hLI+DnLAUF0CmVB8aA9JgOPaPHjiy2v35lOZdbLXb/U=;
        b=Er4DaA+pPGZThVbOglbjCDxDkEJ0CUoTn5LxhM2YhzGJnzRQx0REBQ/85RJ85azrk8
         Q0EaF+giwEDz1ve7ioYFPrzoEDLopPcJnhizstXxqfxxv7TV+1uhpyAKNwKV5H4aJKzt
         fDHjIyAQWPkjvB6h+mkyf0G5896q1a+AMLkLaAfTq9/EBrs497eImA26WX8DWNGQP5yJ
         xfn2XaI0G+WE4JBpTGxeXggeYBKQNFvicEN37x9qeDLQPDyU3kiOa2JDBqm8SjegYWFi
         GqpaXtJmXPsxr9VhIRnYAJsChDDE/ATR/9zdXxRY9TjdeB9sRA+AzS1POk5AomEkWLfn
         nPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505473; x=1708110273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLI+DnLAUF0CmVB8aA9JgOPaPHjiy2v35lOZdbLXb/U=;
        b=qtLoUjWwkKHpOQQ57E80xfqvzCJVAiWJQUM8CpAzNs5G5wOnOyku3g7HiVpXMjBzJ4
         8zPJWo7PHa+1kb3/WlLtsyd30DkPIO+xhtxZlOuGtVhHbNyYZmM7g6wyAgOdCY1sdT+y
         mvTMCr4MZRl9KVUmr08hGFsckLgvoczemrMSLIDsbp+5nP15Hl10CCzIBmsGIGfyHsnu
         65ZAYrvIROaoLg6uJesKkC9I9Grer6WoTpS/iJkahozP1HfBIvdq9o5DzUBjP2M0QrDz
         uYShBPQ1jWDyfqEmmRTUx/dqH2hqTsK5o+vuZutvuciNKsXWMUZzampSeoWm/R6zp9pk
         G/qg==
X-Gm-Message-State: AOJu0Yw/oEVUTi1i2apmusmRCoYSUeCSAt2/MCQbjX+QpSlRytS2hu8g
	jbZeADK/E1S7QcJT62agMkzVuXLhoAHft4FSxnp+YgZMoD5nv6f6
X-Google-Smtp-Source: AGHT+IFAKeIpM5HBs8uhyYJXitvSknzU8xFlSnpeBRlIL3wrrZ19jFh6XtYQYKVPHkqkTbE0Bqr5TQ==
X-Received: by 2002:a17:903:988:b0:1d9:a5ec:30c6 with SMTP id mb8-20020a170903098800b001d9a5ec30c6mr90736plb.44.1707505472634;
        Fri, 09 Feb 2024 11:04:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4sa+AiQu2q/mj4EPZYDBqmnNLtFk7pAy9uXWraQQf39DuubXS4BpmbOlEzRLy3rzNuunlxVw7veyXZhUld7hoP55gvKfODbvhUVm4YtvyJxnpFia8SdLtZDUe1FcF4Dv2e8vKuXES9wvdxroowrFisCTkQXdUigaZTKrpsuObfCZIjCHnnlveaMoHUH/7Leo0v7NPabjyPncmQXq8t5sIKZGVSOm8W8/KucSh4BFELIN8mX/D265xeooKcTyxyRS5femorvrlP0ILxStEkO7hwZpcv840jXvv20uPWWriYtL9G2ylOAE37hE6Cz/ElqNL3b0w9uV5jnKO2d3wj/fLLElR72ZMzzo8TAX1mvDMmZ9djZkSeQ==
Received: from debian ([2601:641:300:14de:9652:d83b:aa3c:1e1f])
        by smtp.gmail.com with ESMTPSA id kk7-20020a170903070700b001d8f99dbe4asm1829773plb.4.2024.02.09.11.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 11:04:32 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 9 Feb 2024 11:04:13 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, nifan@outlook.com,
	jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v3 9/9] hw/mem/cxl_type3: Add dpa range validation for
 accesses to dc regions
Message-ID: <ZcZ3LU9bM20Lomce@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-10-nifan.cxl@gmail.com>
 <20240124165815.00007e46@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124165815.00007e46@Huawei.com>

On Wed, Jan 24, 2024 at 04:58:15PM +0000, Jonathan Cameron wrote:
> On Tue,  7 Nov 2023 10:07:13 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Not all dpa range in the dc regions is valid to access until an extent
> DPA ... DC etc
> 
> > covering the range has been added. Add a bitmap for each region to
> > record whether a dc block in the region has been backed by dc extent.
> > For the bitmap, a bit in the bitmap represents a dc block. When a dc
> > extent is added, all the bits of the blocks in the extent will be set,
> > which will be cleared when the extent is released.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> Hi Fan, one query inline and a few comments.
> 
> Jonathan
> 
> > 
> > --
> > JC changes:
> > - Rebase on what will be next gitlab.com/jic23/qemu CXL staging tree.
> > - Drop unnecessary handling of failed bitmap allocations. In common with
> >   most QEMU allocations they fail hard anyway.
> > - Use previously factored out cxl_find_region() helper
> > - Minor editorial stuff in comments such as spec version references
> >   according to the standard form I'm trying to push through the code.
> > Picked up Jørgen's fix:
> > https://lore.kernel.org/qemu-devel/d0d7ca1d-81bc-19b3-4904-d60046ded844@wdc.com/T/#u
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 31 +++++++++------
> >  hw/mem/cxl_type3.c          | 78 +++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h | 15 +++++--
> >  3 files changed, 109 insertions(+), 15 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 8e6a98753a..6be92fb5ba 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1401,10 +1401,9 @@ CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
> >  }
> >  
> >  void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
> > -                                             uint64_t dpa,
> > -                                             uint64_t len,
> > -                                             uint8_t *tag,
> > -                                             uint16_t shared_seq)
> > +                                      uint64_t dpa, uint64_t len,
> > +                                      uint8_t *tag,
> > +                                      uint16_t shared_seq)
> 
> avoid noisy whitespace changes like this.
> 
> 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 43cea3d818..4ec65a751a 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> 
> > +/*
> > + * Check whether a DPA range [dpa, dpa + len) has been backed with DC extents.
> > + * Used when validating read/write to dc regions
> > + */
> > +bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > +                                  uint64_t len)
> > +{
> > +    CXLDCDRegion *region;
> > +    uint64_t nbits;
> > +    long nr;
> > +
> > +    region = cxl_find_dc_region(ct3d, dpa, len);
> > +    if (!region) {
> > +        return false;
> > +    }
> > +
> > +    nr = (dpa - region->base) / region->block_size;
> > +    nbits = DIV_ROUND_UP(len, region->block_size);
> > +    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
> I'm not sure how this works... Is it taking a size or an end point?
> 
> Linux equivalent takes size, so I'd expect
> 
>     return find_next_zero_bit(region->blk_bitmap, nbits, nr);
> Perhaps a comment would avoid any future confusion on this.
> 

My understanding is that the size is the size of the bitmap, which is
also end of the range to check, not the length of the range to check.

The function find_next_zero_bit(bitmap, size, offset) checks the bitmap range
[offset, size) to find the next unset bit, for the above test, we want to
check range [nr, nr + nbits), so the arguments passed to the function
should be right.

In the definition of the function, whenever offset >= size, it returns size
because size is the end of the range, So if we pass nbits and nr
to the function and nr >= nbits, which can be common, meaning (dpa-region_base)
\> len, the function will always return true; that is not what we want.

To sum up, the second parameter of the function should always be the end
of the range to check, for our case, it is nr + nbits.

Fan



> > +}
> > +
> > +/*
> > + * Mark the DPA range [dpa, dap + len) to be unbacked and inaccessible. This
> > + * happens when a dc extent is return by the host.
> > + */
> > +void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > +                                   uint64_t len)
> > +{
> > +    CXLDCDRegion *region;
> > +    uint64_t nbits;
> > +    long nr;
> > +
> > +    region = cxl_find_dc_region(ct3d, dpa, len);
> > +    if (!region) {
> > +        return;
> > +    }
> > +
> > +    nr = (dpa - region->base) / region->block_size;
> > +    nbits = len / region->block_size;
> > +    bitmap_clear(region->blk_bitmap, nr, nbits);
> > +}
> > +
> 
