Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D43822A810
	for <linux-cxl@vger.kernel.org>; Thu,  1 May 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746130921; cv=none; b=ZGjZty2lX369+byRUE+TIhMPvzuR1RlbxfSRVpZaQR0PbZ4vKntasbG4uvKAFMrl1St70LuXQcuYSXi7dH/IwrpEwXlSYQXOsZ/L4X945327Wi9e8gLarWK36h9HDdzZn84dqW6O4aNfcbFTjmlE07Go2TVwvb+Czvgi9oAQpXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746130921; c=relaxed/simple;
	bh=hp9/+l3s8F3423eboOLb5F/0ihkrqwCaHwWTbP0xV/k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUjoa+QgRhHM59pmY++RAuo7rnenb0AvWCedUrsfLJYSOqCC19sCEW2wE1O4+mrLmUTegXkbiWCw0qQ6WhHO0pPKbpG5RkIi/Gw2pvNR7rGthbrA2naemBFMNkl5wgSbYxcJUmxjl4rjd/F1wj/hj4FlS5DFrgCr0Jwb5Mvs/9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOMmhBC5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOMmhBC5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224171d6826so20813275ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 01 May 2025 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746130919; x=1746735719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7bWiW4bRsnks3rl9OHy6axsrNrN4JteSqAxTGYEvLA=;
        b=SOMmhBC5THpftPxAutLqRyakQfZBTxL55WYb+miT3+zlyKJ1Z2FVPzKiuZ9XE3YapJ
         J/uF2Y8EwihC3rvKNcnlbDZB7sd3aQEB9lve4xhC3nJzXHZJv/amrVpxFl9qhTvNvO6g
         5yMZ5mpJNtY/Vs8ZovpEUZi/nm/tl1AvMtLGLs703wRLEDVyB647Lmg1ecozB3s63p7n
         uNWrZxC2ox11rYtfWNqtoEUF6nr4fbUJXUzTL+4ULwntBSsSuxeN6LNBRF1JzRWouVE7
         mTjaavFy9pUitYjg2v0FacqPfIYEqEm0WGQcxYzSr04YnxuxjE0+vpDMJDijcUZ32GSW
         5Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746130919; x=1746735719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7bWiW4bRsnks3rl9OHy6axsrNrN4JteSqAxTGYEvLA=;
        b=WTQqCb9kGAm1mBdX9RhYaOWZXzzf3zI3Y5B8hPNGFh7+f754Uo77eDjN9coAZ2vhQ4
         +qgs3d6G7IwaJbGAIjqZaDnEtzJHDxs5CDyd/PRUGb2vjEyL+AaNwfnqPkJ49thzqcCc
         HX67RF4/JCdED26uYTFUBzSdk1AS8sG8fHFqqKq7SOsFyWOIYVyPV13P0xwUcU8pFqWY
         qe5nQC5OKk07QPSUd41reipH5L6a4ir/n9fMQnT4+BJiSPpuzoUQ+TcpgR20bEBMx2Y8
         WltIgivcX8MzrPH3GGB4TRwPlVV6LQdKVUXKitiTipLCNTL8JCBh/C2fNRT6nAIvwSN+
         0lSA==
X-Forwarded-Encrypted: i=1; AJvYcCXqNGAjSx5gRjAlTLHzpFExwIU6o/AJcGtZ8CXXyYV7hGE9OXsLeoAATR8EMSaZ3mUFb/fZUW6NJcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZl2txRY50ou12zQTB8eoPiPHf56K0KuQ7t4jKYAmirq4ojIb4
	gFRRgdAsYZeriiP2HEUlyzMtTHrZZOynowaJ15XSq/Ee5sGeNB1Y
X-Gm-Gg: ASbGncsR1dGORBK0ZdctnnR0UP1xnpB0adUYhY/oUz1jO8E8t9ZYEEON3DieW6HGVMU
	dNo58uY8S6FRQpnVAzeSxfQ7m51IDMytXBDYSp1E77DvBJrE2tk68bxDPDgefx+VAHaz0fQyjyr
	eKexn7rLU+QTi4iGZBR7cwGLMtLke60sNEqkV/mMSDbD3dbGkKml8AZwJfsY3EusXVmhwy2Hesl
	Qu+99VYhDasMilkIXZy2xPk1axzjQ1NqTDHo46XwvdeK7rau8kuZqXzwTQURWZfclkYS/+4UhYS
	jRn+RbD2TDR5GbuyX0N7a5cpjGG3ROtvox7GLQJO1EnP
X-Google-Smtp-Source: AGHT+IHlnqOZGR10lQx5RUe7HeSnm/NAMouxKfBunI57Mx1V7PBcF+jSOHJZiAV3AzeNMLkfJf//hw==
X-Received: by 2002:a17:903:2303:b0:223:6180:1bf7 with SMTP id d9443c01a7336-22e1033eecamr5319415ad.42.1746130919440;
        Thu, 01 May 2025 13:21:59 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1094180esm356985ad.235.2025.05.01.13.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:21:58 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 1 May 2025 20:21:56 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 3/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <aBPV80J9TULzRslk@fanair.local>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-4-anisa.su887@gmail.com>
 <20250424114259.000000a0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424114259.000000a0@huawei.com>

On Thu, Apr 24, 2025 at 11:42:59AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:30 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > Add dsmas_flags field to DC Region struct in preparation for next
> > command, which returns the dsmas flags in the response.
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
> >  hw/mem/cxl_type3.c          | 2 ++
> >  include/hw/cxl/cxl_device.h | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 731497ebda..452a0c101a 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -237,6 +237,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> >                                            ct3d->dc.regions[i].len,
> >                                            false, true, region_base);
> >              ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> > +            CDATDsmas *dsmas = (CDATDsmas *) table[cur_ent + CT3_CDAT_DSMAS];
> > +            ct3d->dc.regions[i].dsmas_flags = dsmas->flags;
> 
Hi Jonathan,
Thanks for the feedback.
> This is relying to much on the ordering of creating fields in
> ct3_build_cdat_entries_for_mr().
I am not sure whether I understand this clearly.
In current qemu implemtation, each mr (ram,pmem or dc region) will have the
whole set of cdat table entries (dsmas, dslbis0-3, etc), so as long as we point
to the right table entry, we can get the table correctly.
What do you mean "the ordering of creating fields"?
> 
> I'd rather you just stored the information flags is built from in CXLDCRegion
> and then built the field that is wonderfully called 'Note' in the DC region
This sentence is kind of broken for me, not totally clear what you are
suggesting :-(. Can you explain more?
Are you suggesting not directly take dsmas->flags as dsmas_flags, but
use bit op to generate the value used in Table 7-66 in cxl spec 3.2?
> configuration in 6.2 spec.   I've sent a mail to see if we can clean that
6.2 spec???
> 'what is the field called' question for future spec releases.
> 
> Whilst the flag definitions cross refer the CDAT spec, the actual locations
> of those flags matches, but doesn't cross refer so maybe in the future
> we will have other flags in here and locations might not match.
For the flags stored in dsmas table, do we expect there can be more than those
defined in Table 7-66 in spec 3.2?

Fan

> 
> >  
> >              cur_ent += CT3_CDAT_NUM_ENTRIES;
> >              region_base += ct3d->dc.regions[i].len;
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index bebed04085..81b826f570 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -609,6 +609,7 @@ typedef struct CXLDCRegion {
> >      uint8_t flags;
> >      unsigned long *blk_bitmap;
> >      uint64_t supported_blk_size_bitmask;
> > +    uint8_t dsmas_flags;
> >  } CXLDCRegion;
> >  
> >  typedef struct CXLSetFeatureInfo {
> 
