Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17178233735
	for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949386; cv=none; b=s1SGZkwbj3TymgFF3DNNYcu6tMyFLNZPCun8k5UB4wUROtCE0E2f4ofI1WBHl31xiz6t77gUq9WLqMTWWQ9POAAbq6/lRUM8ezMnOMP7HrxaP0MUwwWAnOtHlHfG1+hMJpy4p69KRrMPPjeOFZB4dbN+5Ap5Y25CAXdSq/+aCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949386; c=relaxed/simple;
	bh=nZX7mKl64clXIVLF2nwjidyt78Yy6zZgWhqAzg/FK5M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/iQ2fiUsdhNIw/26DI4P2yG0RHXmhR8M3k8pmTIBsYtk2iFOD8flS8ms1gO2FwjiX3IA3upKXf3HjTvPr/deSHcf4+MtHMRRC96zKxCjGQO9GI1ixH3mRxOfwMmzGPNxpCUJL6+gMEWNdifOGyOIJoPuGWnVN8N9cRMiorjgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVPwnBtW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVPwnBtW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2243803b776so106450375ad.0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745949384; x=1746554184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJuFu2T2uACt7lYPR7DK5aCYKnlqtxYEUsDvqs5aJGA=;
        b=MVPwnBtWKGJXsvlqhkRjM/41wrCkow9RvQolVDFcfw6q7JXua8ZITxwbzIMXXV7oxx
         XokbvJHY2phPkAU1uWmUo26Ul2RNLZgZeNhn9oiAT29iJYWaKPNlzfCPMR6GxW7G4/u6
         D5bz1NBY6lHVXejfryjsWCz4GZ9sC5sYv8ZY0i6UASZmM3rAwTssZUV04SENsYTbOKxj
         Y7AG7oprecaOmAPe+OSN/oJqNoxDdV9nnYp1/DdDoLwv4ssl5VWv5xxZTQIJctq2DupN
         SyGSCl9txTMQMBcTPvoOhrMxJrx1o5bPyk+mXb8D0HlkymDTbWiywzVvROvknObUWiAo
         WGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949384; x=1746554184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJuFu2T2uACt7lYPR7DK5aCYKnlqtxYEUsDvqs5aJGA=;
        b=ez6FwijVAoVOBAg/Kov2IeZUtU9VdHArX/jF5gbVwHAmbVEqU5e9EkV9zv0D4jmAtA
         zbNYgjjn0iQhoRNU7hnTAw64b6Iye+5fdhGuq/f09oNeZ/6GZpOYrZf6RG6obCnWbN2B
         K7VvBoGEnuDH8tiL2XkHtEESXZ0tqe2nNX4gqz9TcMQxUF3X4FI4uibVxBRb2aiAoFmM
         F0nbDU37Q4pubbpn6D832kbLGWQE1mvMxqJGyf3UBjC9r+kY/RH/cdtPpDSsX2TQdjhi
         qWGqf0CC5JPhkMIH+S8bNAmZQ/WydgjvBA8uYNgntQTCYYwktnJjqRWWnZ/uQxpaExNt
         9MMg==
X-Forwarded-Encrypted: i=1; AJvYcCVx7sHfdh55jgRxYLmNQYGPwp5cZcw7UK62hUnVpGdEIKxjI/iwOiwHvWLilvjOERvsmnij+9TL2p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCMiCwWS0LBdiGG9JtpYGYM4MKv1U220UIZgQb3F1XPH+NISNS
	jTIlpsFnXhwT2+ApA8NjXHAVOGdNkfMh4y5RKzvpLd4IRlXbd/OM
X-Gm-Gg: ASbGncvIufvr9lnl75cOpSvUSPshGWJzhmCry0wYtwahA8hiTsxrKbtGegpi7IJjQaz
	szKnL3dE5sjMIsLoAPEDFp4Jxjgo5bDqxlvUmsxluBN33XsMzvNdJEzJ/sItdXSRvugivMovoUh
	D1uBO4FL9VwYpyngi2xQPDxtmWx/44PcxFHkKNJ6jVMrB3dIMW+GO9xFMagY7lBbC0Y2MckJoLR
	wSvI7KKLQ/Y0qlZ+ekK4j8nNL8OLOh8UiEsyi9ebrZtlIwnra2mV527QJyQEs3qYInS/jyj66eI
	pOIArODp8GYTSxcnm4yWz8oDo6wPN1ziH9JxsiUg7dWL+bgzfioSf3kUEh2eAPMbHq4=
X-Google-Smtp-Source: AGHT+IHh05EfYulLqBSbJTNmqSNuuxyR3fQUErngIO1EFAitJiPAP6+8QHeuDFL7PSyVG7VRZRbZ/A==
X-Received: by 2002:a17:903:1aa5:b0:223:635d:3e38 with SMTP id d9443c01a7336-22df34e7f64mr4824645ad.15.1745949384214;
        Tue, 29 Apr 2025 10:56:24 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100aa7sm105284405ad.161.2025.04.29.10.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:56:23 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 29 Apr 2025 17:56:21 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/9] cxl/type3: Add supported block sizes bitmask to
 CXLDCRegion struct
Message-ID: <aBESxXNTecIbPJPP@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-2-anisa.su887@gmail.com>
 <20250424111131.00005ff2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424111131.00005ff2@huawei.com>

On Thu, Apr 24, 2025 at 11:11:31AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:28 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > Add supported_blk_size field to CXLDCRegion struct in preparation for
> > next patch. It is needed by command 0x5600 Get DC Region Config.
...
> > @@ -8,6 +8,7 @@
> >   *
> >   * SPDX-License-Identifier: GPL-v2-only
> >   */
> > +#include <math.h>
> >  
> >  #include "qemu/osdep.h"
> >  #include "qemu/units.h"
> > @@ -766,6 +767,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >      uint64_t region_len;
> >      uint64_t decode_len;
> >      uint64_t blk_size = 2 * MiB;
> > +    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
> 
> Isn't this going in circles?  I guess it sort of acts as documentation that it
> is a bitmap but then the name is already doing that. 
> Maybe set it to blk_size and add a comment that for now only a fixed block size
> is supported?
> 
> I'm a little confused on what this is for given you don't check it in patch 6
> which is changing the block size?
Good catch! It doesn't seem to specify this check in Section 7.6.7.6.3
Set DC Region Configuration (Opcode 5602h) in the 3.2 spec, but it would
make sense to me to fail with the same rc as when the region has not
been cleared, which is CXL_MBOX_UNSUPPORTED.

Will have the fix in v2.

> >      CXLDCRegion *region;
> >      MemoryRegion *mr;
> >      uint64_t dc_size;
> > @@ -811,6 +813,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >              .block_size = blk_size,
> >              /* dsmad_handle set when creating CDAT table entries */
> >              .flags = 0,
> > +            .supported_blk_size_bitmask = supported_blk_size_bitmask,
> >          };
> >          ct3d->dc.total_capacity += region->len;
> >          region->blk_bitmap = bitmap_new(region->len / region->block_size);
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index ca515cab13..bebed04085 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -608,6 +608,7 @@ typedef struct CXLDCRegion {
> >      uint32_t dsmadhandle;
> >      uint8_t flags;
> >      unsigned long *blk_bitmap;
> > +    uint64_t supported_blk_size_bitmask;
> >  } CXLDCRegion;
> >  
> >  typedef struct CXLSetFeatureInfo {
> 
