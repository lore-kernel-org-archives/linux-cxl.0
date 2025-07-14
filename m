Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D602AE99
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511537; cv=none; b=KZN9LBxK7OS6F7v9IvxNsAxNIWsTpqv7Zag7/pQOnzf8q5txZxegtPzDRCvkExBLnkCEtxOK/J69s6WEygvzc74J9v+qaJMefj31bwWVGUWl5JtuzV8jEQ3eVc73KnwdOWfSqqcR2Lph6zrkrXD2Y06SCG096P0T2duWJF5kaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511537; c=relaxed/simple;
	bh=gian8VrscCpamB1YhbMoxezbBTOm+Uc4ruokIEJ16ik=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfgFltCpPfdSuS7YXwN+fkTmI/WH0NkVR0bHFiItXzO7A7w4gEy44xxWao1kjth+lDEjtlbR+rjRQvN2Al53s+yv36Wg7DkFR2J9q1DPKnmhisimNGiSU2xKy7mlrd6InAc0MMGR4pjC+WEkbFncWMREyUcOMOWezrM27Ql/kW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7ulavHD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7ulavHD"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso4810416b3a.2
        for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752511535; x=1753116335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ncCyV0aoZ/6qo09uLJz5eMmCg2hr2we7Tu7Iid9x4is=;
        b=T7ulavHDTW475q4BGh0xCgJ9HlgJhI7xZLJNTZfpBHKDFlxTwXed91cPCwqHIOdg0o
         1qGNm1vPa8kzNXTIW6qQNBOxB1x4H9AasXus+JppYHXxb6j8MJHJMXgGMeaqPKQlq7P9
         +7h+bATyuzTJJcsDitspeIQ3qK+wRRIna1Mhjt9R463VHcwJlK6DQskmjc33juxBRSYe
         /aXUshMz/4Qyyl3NGRf4P9bkcQJXEGEhyPA+8Ak5DfEWwUWx/oK61jjZNdUTi4VCH6se
         TvkeQFHU+IgF38NV1l5fM/QhG9VoVp/whJrCp/IPoovM+rGzr7T03AaEWNzp+0Ql59mE
         56AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511535; x=1753116335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncCyV0aoZ/6qo09uLJz5eMmCg2hr2we7Tu7Iid9x4is=;
        b=hWyr0X8fU8+d0UcvP0H/0KcYa/su0yBXJyL6EUrNfoA+Dg/4p0yMn/hEWM4BPItkYm
         u9CNnotF4RB99V1EhJq6vwxgMnadIq6t5PmlolRl3tYXw5IHehJQ0Pcj0Qcy8jmguG8i
         9HUA3+UqheWEV4M9OzPScFegv3t/N318mHHK9Xi9ZcEhH3DQwXXpX48NcOiYzO1XMplQ
         xmRK6tmAV9wnzn8E+q4VTFm+8Kca+QFidMuFXgRICEng6BXmcGV44DfnSvexvoYBaej2
         VM/31yYe7GJ/c/MOgHa6K2YoKTGdYoSU/ToQUoWhyRJCBy5bMxvqoGYeXm/OnxvDeGUX
         HV9g==
X-Forwarded-Encrypted: i=1; AJvYcCWb2zWdRZTcYKHBmf2ytoPXEWOxopSrX3sXtoA31CU4frBt5xQAI57j9Ac+hd6PlojsDVZ6xe2Uhqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfbsplWHP13Ijp0o/1kpRqdoSR2brYGsQtwMzmMewcB7zIu/N3
	phGoXV7KqMskiuONCbYYnWtyuzDAlEAL9uAh0Pe2mBYFOFlEHbtWKcF/FzBtOIOH
X-Gm-Gg: ASbGncvmbfkTIqyLDLvXMQ6ECIJn2alpguVGYJbzDZa3stmznU7g4nNnEec+LycXbvq
	N6Hxl2gcZZeNrI/EYgIGTwO10L6sQE8ZXrGXGGsrUrWNtdXYfKiFnFDDswaiULXxgvU01VVMqOl
	OSVKgLrnNTuLHqK8yxb4kRHRZ2JeqP3OZEmfuuA/IXKG4YXV9IrGh6JYJwi5nWOrDyZGp8ERl4j
	CFRs+9BPA6A6QEYP1KyxHcRvgXoU9TBzf+9zZx61vmU1Y9/4N/00ENxd+S/YURvwb3tMx/MZ97C
	Szmd+DTXZ7xIURqt8pRFTfMENv3FMDPSTnQ5qrqW2f2k6eqHjhkPshykuYjNv0WmPU0DBns3q2J
	paJwOuauITRJQzng3/HiSESU=
X-Google-Smtp-Source: AGHT+IFJVe7YMzCa6bbCexww2jlzcc1c8cj0MKXOGeuxUdKTtEKzyTlxvUPzIaawdf+MnCiLeW3RYA==
X-Received: by 2002:a05:6a00:3d47:b0:746:24c9:c92e with SMTP id d2e1a72fcca58-74ee09ae484mr22673386b3a.8.1752511535251;
        Mon, 14 Jul 2025 09:45:35 -0700 (PDT)
Received: from lg ([2600:1010:b0b9:68c0:c4fb:1c2c:4273:7950])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ccesm10752144b3a.27.2025.07.14.09.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:45:34 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 14 Jul 2025 09:45:31 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, linuxarm@huawei.com,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH qemu 07/11] hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <aHU0K4bXbPLsed5t@lg>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-8-Jonathan.Cameron@huawei.com>
 <20250714052757-mutt-send-email-mst@kernel.org>
 <20250714150218.00006c95@huawei.com>
 <20250714151512.00000a2a@huawei.com>
 <20250714151638.000038ac@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714151638.000038ac@huawei.com>

On Mon, Jul 14, 2025 at 03:16:38PM +0100, Jonathan Cameron wrote:
> On Mon, 14 Jul 2025 15:15:12 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Mon, 14 Jul 2025 15:02:18 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > > On Mon, 14 Jul 2025 05:32:19 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Wed, Jul 02, 2025 at 05:02:13PM +0100, Jonathan Cameron wrote:    
> > > > > From: Anisa Su <anisa.su@samsung.com>
> > > > > 
> > > > > FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> > > > > 
> > > > > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>    
> > > 
> > >   
> > > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > > index bf1710b251..1fc453f70d 100644
> > > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > > +++ b/hw/cxl/cxl-mailbox-utils.c    
> > >   
> > > > > +/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
> > > > > +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
> > > > > +                                              uint8_t *payload_in,
> > > > > +                                              size_t len_in,
> > > > > +                                              uint8_t *payload_out,
> > > > > +                                              size_t *len_out,
> > > > > +                                              CXLCCI *cci)
> > > > > +{
> > > > > +    struct {
> > > > > +        uint8_t reg_id;
> > > > > +        uint8_t rsvd[3];
> > > > > +        uint64_t block_sz;
> > > > > +        uint8_t flags;
> > > > > +        uint8_t rsvd2[3];
> > > > > +    } QEMU_PACKED *in = (void *)payload_in;
> > > > > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > > > > +    CXLEventDynamicCapacity dcEvent = {};
> > > > > +    CXLDCRegion *region = &ct3d->dc.regions[in->reg_id];
> > > > > +
> > > > > +    /*
> > > > > +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> > > > > +     * This command shall fail with Unsupported when the Sanitize on Release
> > > > > +     * field does not match the region’s configuration... and the device
> > > > > +     * does not support reconfiguration of the Sanitize on Release setting.
> > > > > +     *
> > > > > +     * Currently not reconfigurable, so always fail if sanitize bit (bit 0)
> > > > > +     * doesn't match.
> > > > > +     */
> > > > > +    if ((in->flags & 0x1) != (region->flags & 0x1)) {
> > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > +    }
> > > > > +
> > > > > +    if (in->reg_id >= DCD_MAX_NUM_REGION) {
> > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > +    }
> > > > > +
> > > > > +    /* Check that no extents are in the region being reconfigured */
> > > > > +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
> > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > +    }
> > > > > +
> > > > > +    /* Check that new block size is supported */
> > > > > +    if (!test_bit(BIT((int) log2(in->block_sz)),
> > > > > +                  &region->supported_blk_size_bitmask)) {
> > > > > +        return CXL_MBOX_INVALID_INPUT;
> > > > > +    }      
> > > > 
> > > > This does not work: test_bit works on unsigned long, while
> > > > supported_blk_size_bitmask is uint64_t.
> > > > 
> > > > Why so funky? what is wrong with:
> > > > 
> > > > if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bitmask))
> > > > 
> > > > And BTW why cast to int here?    
> > This became obvious when your suggestion didn't build :(
> > 
> > ./../hw/cxl/cxl-mailbox-utils.c: In function ‘cmd_fm_set_dc_region_config’:
> > /home/jic23/src/qemu/include/qemu/bitops.h:25:39: error: invalid operands to binary << (have ‘long long unsigned int’ and ‘double’)
> >    25 | #define BIT_ULL(nr)             (1ULL << (nr))
> >       |                                       ^~ ~~~~
> > ../../hw/cxl/cxl-mailbox-utils.c:3436:11: note: in expansion of macro ‘BIT_ULL’
> >  3436 |     if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bitmask)) {
> >       |           ^~~~~~~
> > 
> > Now I look again, this is effectively 2**(log_2(x)) or x. So
> > if (in->block_sz & region->supporte_blk_size_bitmask)
> 
> it (!(in->block_sz & region->supports_blk_size_bitmask))
> 
> I mean.

Make sense to me. 

The only thing is how to detect the violation if the passed in block_sz
is not power of 2.
Or who will do the check if not in qemu?

Fan

> 
> 
> > Should work as long as we know block_size is a power of 2 (which the specification
> > says it must be).
> > 
> > Anisa?
> > 
> > > 
> > > Change looks fine to me, so I'll prepare an updated set with this
> > > and the missing semi colon.  Anisa if you can have a look at this
> > > that would be great. 
> > > 
> > > Sorry I seem to have missed Anisa off the cc for this!
> > > 
> > > Jonathan
> > >   
> > 
> 

-- 
Fan Ni
