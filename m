Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A4264A95
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513675; cv=none; b=Rr4RZRzbvWZpD1HnSMJ4Ox5IiuamBuKYPwBgM1pvw5YqsIGzIYWXAgXc7dB7WSe2Gihcj0CRLSdUB+39BC4kK4o6aAnUh7YOkFjrc9EhIxdNmyrGIFON1FjeuO1n1IUXjkA8McxwzDzqmHf255IgA4+L3sIuTMDPfDBwAGsK57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513675; c=relaxed/simple;
	bh=BbjE9baDWQuofWBC/EitnpnoQwTe9ysrSW5oNgKISyI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETdfWlEF21lQHvdBpgNGuO6NaPORpENMm/TR6PweI1vp0r8BkEGDKftVBJMR+3jmKBRHcFy94NC9gNagWAtTAFhl15B3Mt+HsfQHD3ZVI5d6uK84EziRh1NUzXATjL/XVsuyl1YJPoRxqNlBzQ+jxm9wj004H+a1DUTZYLgOZo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k16+uTFN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k16+uTFN"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so3621317a12.1
        for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752513673; x=1753118473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1xCcyA4imSktTZNuYs6d0ixwsnZXyJ0ZGdf4DChw5wg=;
        b=k16+uTFNl3fIdJr612gMKR8EfiECOGalOnxDILX7IR8sIxtEEaqOy1ykhvTtSHjY3j
         9UU6mC8sw/QQfAVyNMUJ3gLbfacNyMPZSXsULDTKUw4A19vyCozZBfniLxH/hP2EOm6r
         KpIHltSw8olACNCmtR67FG2osQZPOaECFNTYrWKBcWdkeRIbEImO6FH5YUhf6N9HoVa/
         YQ9M/whxzDBjSaJoLZlCZJS/yrwFnycmTyFmWbJ3/SzJI61X9eHgYUYMehtFttOAd/Zr
         pBHGnGh2a0njyolpT4zwk5o2a6EyPH5eb8lf02JvChsVI6KzKVTRbbVXj7eCg4gkknIs
         8zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752513673; x=1753118473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xCcyA4imSktTZNuYs6d0ixwsnZXyJ0ZGdf4DChw5wg=;
        b=HCZ2Be1XATMwkJnHkHAfh/SveJ85by/hWfQmTMw7b62zHLJAlthh3Dlrc3TMgwvmXT
         wMxzW9R3SF0aIX8aFqQ3aDLcLAstcAALDiEiBssZRm9ZQmzefjNT3qAdbRmsFmWTdykj
         tj1Yz5LYpBPS/RcjIl2xYzngHsrOkpNh/WhX6B8c8fXGQSRq06CjjezECRgMeXXaiMNv
         f6wRAIS4ZFnmuMBn4Wh9b1sn84K/3qnpWX0CXog+lrgTL5us64CIE9FQfmhiKkleQrQq
         oxgBewdlleH/JoPtZdkSarukZ4e7QlT6QL8OG9g6lAayHXpRb/QnfZCltzqnX41TFC7Y
         sk9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxldGdHZvfRIurAVCxsjNwsnbwCAIWmubBoSjenGSgz3WLjgvXEvybtWgi1IQI43m/q+S8Js8RLmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpZMXLW9gqGiwn6WOOxrdEjWw/4dDjhA1dLjGVIZIwaz0tl31
	7r2iEIKR8sXqPsUlNTN9NNF6ewXFqgB3LPZXZGqaJx71hbB9y4v8LbEc
X-Gm-Gg: ASbGncseWlwU3CZwmFH03Udku+hW/j4pa6qLOo2O4aOyB0hZOhNzwBdAzWFmIZaqM/H
	605acKsdmKAfKFlZeqD3++V3xVjtqYKX9jXVSlX/tQtH4N0TBb+snLcl1UJyHfrpO4nnAsPLKy9
	DP+ti+x1P/tbiMf+VyTpu8FdQ/49b92x89Ie/erUfCnJ5EDohVDSPP1tok4B3xhTlyodG5Eb6rM
	EOxBuRWntNQlQW9jahF2j4lIOm6qRdf1od+ddkqEsMu9aXaVZPW6xBpOgZdipZwi1Mjhpj07qVI
	VctHri/CAyTgmKVDK/rdTAcgi8cz/JQf+r8ilc0XLJI3YreRUZH8MVF07rmYeYWVUaVhHnjUiiO
	3Kgaud/90S8s9/pZhv319SJH04uZTRZjFk2U9zjFhylFhYZe5bHUgWpkhP30=
X-Google-Smtp-Source: AGHT+IGuhyRqHc5viAmr7xsq1hveDst/ENhxsyPig6SbkAqDcGHad0xcjDvWpUnfE0UUA5RN4jLJpg==
X-Received: by 2002:a17:90b:4ecb:b0:2fa:2133:bc87 with SMTP id 98e67ed59e1d1-31c8f7d9573mr554006a91.6.1752513672930;
        Mon, 14 Jul 2025 10:21:12 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb4654esm11192278a91.29.2025.07.14.10.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 10:21:12 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 14 Jul 2025 17:21:10 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	linuxarm@huawei.com
Subject: Re: [PATCH qemu 07/11] hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <aHU8huAwCLTh2sLx@deb-101020-bm01.eng.stellus.in>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-8-Jonathan.Cameron@huawei.com>
 <20250714052757-mutt-send-email-mst@kernel.org>
 <20250714150218.00006c95@huawei.com>
 <20250714151512.00000a2a@huawei.com>
 <20250714151638.000038ac@huawei.com>
 <aHU0K4bXbPLsed5t@lg>
 <20250714180226.0000562d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714180226.0000562d@huawei.com>

On Mon, Jul 14, 2025 at 06:02:26PM +0100, Jonathan Cameron wrote:
> On Mon, 14 Jul 2025 09:45:31 -0700
> Fan Ni <nifan.cxl@gmail.com> wrote:
> 
> > On Mon, Jul 14, 2025 at 03:16:38PM +0100, Jonathan Cameron wrote:
> > > On Mon, 14 Jul 2025 15:15:12 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >   
> > > > On Mon, 14 Jul 2025 15:02:18 +0100
> > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > >   
> > > > > On Mon, 14 Jul 2025 05:32:19 -0400
> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > >     
> > > > > > On Wed, Jul 02, 2025 at 05:02:13PM +0100, Jonathan Cameron wrote:      
> > > > > > > From: Anisa Su <anisa.su@samsung.com>
> > > > > > > 
> > > > > > > FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> > > > > > > 
> > > > > > > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > > > > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>      
> > > > > 
> > > > >     
> > > > > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > > > > index bf1710b251..1fc453f70d 100644
> > > > > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > > > > +++ b/hw/cxl/cxl-mailbox-utils.c      
> > > > >     
> > > > > > > +/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
> > > > > > > +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
> > > > > > > +                                              uint8_t *payload_in,
> > > > > > > +                                              size_t len_in,
> > > > > > > +                                              uint8_t *payload_out,
> > > > > > > +                                              size_t *len_out,
> > > > > > > +                                              CXLCCI *cci)
> > > > > > > +{
> > > > > > > +    struct {
> > > > > > > +        uint8_t reg_id;
> > > > > > > +        uint8_t rsvd[3];
> > > > > > > +        uint64_t block_sz;
> > > > > > > +        uint8_t flags;
> > > > > > > +        uint8_t rsvd2[3];
> > > > > > > +    } QEMU_PACKED *in = (void *)payload_in;
> > > > > > > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > > > > > > +    CXLEventDynamicCapacity dcEvent = {};
> > > > > > > +    CXLDCRegion *region = &ct3d->dc.regions[in->reg_id];
> > > > > > > +
> > > > > > > +    /*
> > > > > > > +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> > > > > > > +     * This command shall fail with Unsupported when the Sanitize on Release
> > > > > > > +     * field does not match the region’s configuration... and the device
> > > > > > > +     * does not support reconfiguration of the Sanitize on Release setting.
> > > > > > > +     *
> > > > > > > +     * Currently not reconfigurable, so always fail if sanitize bit (bit 0)
> > > > > > > +     * doesn't match.
> > > > > > > +     */
> > > > > > > +    if ((in->flags & 0x1) != (region->flags & 0x1)) {
> > > > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    if (in->reg_id >= DCD_MAX_NUM_REGION) {
> > > > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    /* Check that no extents are in the region being reconfigured */
> > > > > > > +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
> > > > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    /* Check that new block size is supported */
> > > > > > > +    if (!test_bit(BIT((int) log2(in->block_sz)),
> > > > > > > +                  &region->supported_blk_size_bitmask)) {
> > > > > > > +        return CXL_MBOX_INVALID_INPUT;
> > > > > > > +    }        
> > > > > > 
> > > > > > This does not work: test_bit works on unsigned long, while
> > > > > > supported_blk_size_bitmask is uint64_t.
> > > > > > 
> > > > > > Why so funky? what is wrong with:
> > > > > > 
> > > > > > if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bitmask))
> > > > > > 
> > > > > > And BTW why cast to int here?      
> > > > This became obvious when your suggestion didn't build :(
> > > > 
> > > > ./../hw/cxl/cxl-mailbox-utils.c: In function ‘cmd_fm_set_dc_region_config’:
> > > > /home/jic23/src/qemu/include/qemu/bitops.h:25:39: error: invalid operands to binary << (have ‘long long unsigned int’ and ‘double’)
> > > >    25 | #define BIT_ULL(nr)             (1ULL << (nr))
> > > >       |                                       ^~ ~~~~
> > > > ../../hw/cxl/cxl-mailbox-utils.c:3436:11: note: in expansion of macro ‘BIT_ULL’
> > > >  3436 |     if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bitmask)) {
> > > >       |           ^~~~~~~
> > > > 
> > > > Now I look again, this is effectively 2**(log_2(x)) or x. So
> > > > if (in->block_sz & region->supporte_blk_size_bitmask)  
> > > 
> > > it (!(in->block_sz & region->supports_blk_size_bitmask))
> > > 
> > > I mean.  
> > 
> > Make sense to me. 
> > 
> > The only thing is how to detect the violation if the passed in block_sz
> > is not power of 2.
> > Or who will do the check if not in qemu?
> Hi Fan,
> 
> I checked the spec on this.  There isn't an explicit statement that the device
> should return an error on this. Looks to be impdef. I'd happily see such
> a check as a usability improvement though!
> 
> I'm just not set up to test this right now so decided to be
> risk averse and not trying adding one. 
> 
> If you want to send a patch on top I'd be happy to add it.
> 
> Jonathan
> 
> 
Would something like this work?

/* Check that new block size is supported */
if (!is_power_of_2(in->block_sz) ||
    !(in->block_sz & region->supported_blk_size_bitmask)) {
    return CXL_MBOX_INVALID_INPUT;
}

I did not have to add any extra headers to use this helper function in
include/qemu/host-utils.h and it compiles for me.

Anisa
> 
> > 
> > Fan
> > 
> > > 
> > >   
> > > > Should work as long as we know block_size is a power of 2 (which the specification
> > > > says it must be).
> > > > 
> > > > Anisa?
> > > >   
> > > > > 
> > > > > Change looks fine to me, so I'll prepare an updated set with this
> > > > > and the missing semi colon.  Anisa if you can have a look at this
> > > > > that would be great. 
> > > > > 
> > > > > Sorry I seem to have missed Anisa off the cc for this!
> > > > > 
> > > > > Jonathan
> > > > >     
> > > >   
> > >   
> > 
> 
