Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBE25A2C8
	for <linux-cxl@vger.kernel.org>; Fri,  2 May 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201461; cv=none; b=cKIQdrq1sE3eykxTkVCtwHUMcCNbLM/e9ESZI4Okk9wrpjayH/YgzrM9YJMuUXJnQTBYTiDSwlZw4mvZcXfT+gyPJdJy4Jw7cOZM1xrsLL84snTLOA2dkIkhCM1FEtbuOh/dP+eXMDfmNXxFY/7+4kXqrT8fgAec8kPRvHYQX5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201461; c=relaxed/simple;
	bh=z1gJn2d1Dibzw2R/XcU1IhPnSFj8MEunhb3BeMSs4xE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHEUOIzUxz05gdBbRxFWU+0IsohB3tjY2MGZY4gBPf9daJo18k8l8MCspkxH/eHpECKRrqUsT0AZ9cRkaq6A/n3IB46B8CYAntFI5aJ/FU2+YrhcSzI/26my2WBBEjtn7DWydB6Nftyu2y5fEzPazk7jCh1twIkaardn3t6YCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eX+tGHAa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX+tGHAa"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-739be717eddso1949317b3a.2
        for <linux-cxl@vger.kernel.org>; Fri, 02 May 2025 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746201459; x=1746806259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKI/MbhgySCmhrgKFtZDoE5nt+OFW0JQ0ZIGxBLEsXI=;
        b=eX+tGHAaEc2asEjtD6hrrsoV6tii4gul0e12jglGCaCjrYBM2nuKHhJKYQw06nd9kt
         woPnKSo0mpTCh/kcDCou6aKE3WaYtuuRdHvSFv16s7sQ5g142OzGGug9nhkbATlVnuSN
         i27+UERcq1ztvjQEo2MGVxS/utZzx0pEv5Zrh4cyjvFIENN0gEWMdPFdLTatNJsNGqrL
         fYll9G/n5VEkamFbYJDWtM3FBLL3VWcu8qbUl7troxbDvrNHqH3rpxHfHsiuZ6tWSbKv
         PgeYTn6QK9E4e/KQHrQf2QCt6FtgD/6024dZig9O4pSjgyvsHlVtwdG4PdGxQ7EHLhVh
         jTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746201459; x=1746806259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKI/MbhgySCmhrgKFtZDoE5nt+OFW0JQ0ZIGxBLEsXI=;
        b=MXrxama5af6k2/xBzOInsoWSf2PTqO1e8pgwipxBBf19N9GBC7SOWfQJju5XdMmO1x
         Ta3gjDAWTWjNW9ZpeJS8PHwhCF1C2aloqyfJG+8H0NO8WIJ7wrrACsPJSxqC2UGcrD+t
         FXussSbXAD+U1LbEb3KPWBUWzyG8JWBiOrRZwTN/laJX2PAk1g/JQflEXUeXORjlqWsr
         50zI5wQYrzwXSHFgb+xoGLpC8Mhwf2aqijQq17Q9wCavy2+401wsp+qmunh96BxUrW4Y
         2uJ6YlErxGd7bV2EEWR0VIdY8/g8eVvJUXxVqeDyrBtERo3EJGlollCXGY3fNn7aV5ax
         ePHA==
X-Forwarded-Encrypted: i=1; AJvYcCXhNMxcvT21KIJkAenIdnVz0xqDRgQx/ytK4s/owMfnWj+IlRAwj7gDm1Vo9NMMxd1YGOVSvH0GLrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwibMsFEfZnewP1kRQjM9TK/S6Kq4gg8fExMFOHmlB9wo6wo7OD
	z7iLeJQzDcjtUk4sMoABMU/9o4cEMPMQvUTfhxZZmZr7UJENshhx4wfiGw==
X-Gm-Gg: ASbGncu6NQMeR+3nQfH/iMnqZ08t9N/Di3XzkcUWUYs49tn5lu2YsIktbFOb5cszJ48
	v1Vba33dddDJwNpuX6WhrB9EnwT5l4GSSP2CG44g1EBIIafmuYw5DqBdTkK2WprMxjM0sk6qV9X
	0sETW6j1vfeP4JPgVhTjwqxohvVU0ur7iw4WoNBKoRQJnsevtWo60bpz7GFsC8zsldLiOuYk+sf
	nHJZ35lApcIqe2rczCVBpNpzeSqGggOQjZYWAxMl+29haXao00VoGFCo5+22bmhjFCHjOL92Jxn
	8CYWgdeE2JiPZ1fK9sPT4UFvCKjb9SDUOSw=
X-Google-Smtp-Source: AGHT+IEcEsQw6DDjDO1IrU3xSR2eU71FKhRhOXQq20kZDhL5FaIBZhp0SpvhObynBb6E3jhHc0QyGA==
X-Received: by 2002:a05:6a00:1d9d:b0:73c:3060:d53 with SMTP id d2e1a72fcca58-74058afcf0fmr4676786b3a.18.1746201458921;
        Fri, 02 May 2025 08:57:38 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590616ffsm1791307b3a.140.2025.05.02.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:57:38 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 2 May 2025 08:57:36 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, anisa.su887@gmail.com,
	qemu-devel@nongnu.org, dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 3/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <aBTrcAa9yt8lGHJO@debian>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-4-anisa.su887@gmail.com>
 <20250424114259.000000a0@huawei.com>
 <aBPV80J9TULzRslk@fanair.local>
 <20250502100155.00003bfa@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502100155.00003bfa@huawei.com>

On Fri, May 02, 2025 at 10:01:55AM +0100, Jonathan Cameron wrote:
> On Thu, 1 May 2025 20:21:56 +0000
> Fan Ni <nifan.cxl@gmail.com> wrote:
> 
> > On Thu, Apr 24, 2025 at 11:42:59AM +0100, Jonathan Cameron wrote:
> > > On Mon, 17 Mar 2025 16:31:30 +0000
> > > anisa.su887@gmail.com wrote:
> > >   
> > > > From: Anisa Su <anisa.su@samsung.com>
> > > > 
> > > > Add dsmas_flags field to DC Region struct in preparation for next
> > > > command, which returns the dsmas flags in the response.
> > > > 
> > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > ---
> > > >  hw/mem/cxl_type3.c          | 2 ++
> > > >  include/hw/cxl/cxl_device.h | 1 +
> > > >  2 files changed, 3 insertions(+)
> > > > 
> > > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > > index 731497ebda..452a0c101a 100644
> > > > --- a/hw/mem/cxl_type3.c
> > > > +++ b/hw/mem/cxl_type3.c
> > > > @@ -237,6 +237,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> > > >                                            ct3d->dc.regions[i].len,
> > > >                                            false, true, region_base);
> > > >              ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> > > > +            CDATDsmas *dsmas = (CDATDsmas *) table[cur_ent + CT3_CDAT_DSMAS];
> > > > +            ct3d->dc.regions[i].dsmas_flags = dsmas->flags;  
> > >   
> > Hi Jonathan,
> > Thanks for the feedback.
> > > This is relying to much on the ordering of creating fields in
> > > ct3_build_cdat_entries_for_mr().  
> > I am not sure whether I understand this clearly.
> > In current qemu implemtation, each mr (ram,pmem or dc region) will have the
> > whole set of cdat table entries (dsmas, dslbis0-3, etc), so as long as we point
> > to the right table entry, we can get the table correctly.
> > What do you mean "the ordering of creating fields"?
> 
> It is an implementation detail only that the first bit of that table is
> the DSMAS entry.  I think we shouldn't rely on that.
> 
> > > 
> > > I'd rather you just stored the information flags is built from in CXLDCRegion
> > > and then built the field that is wonderfully called 'Note' in the DC region  
> I got distracted by the spec oddity :)
> 
> > This sentence is kind of broken for me, not totally clear what you are
> > suggesting :-(. Can you explain more?
> > Are you suggesting not directly take dsmas->flags as dsmas_flags, but
> > use bit op to generate the value used in Table 7-66 in cxl spec 3.2?
> 
> No. Just store the various  bools etc that become dsmas->flags in the
> CXLDCRegion structure directly rather than reading back from dsmas->flags.
> Probably as explicit bools etc not a single value.
> 
> Then pass those in to  ct3_build_cdat_entries_for_mr() .  Mostly they overlap
> with current true / false parameters that are hard coded.

OK. Since some flags are not support yet, can we hard coded them for now?

Fan
> 
> 
> > > configuration in 6.2 spec.   I've sent a mail to see if we can clean that  
> > 6.2 spec???
> > > 'what is the field called' question for future spec releases.
> > > 
> > > Whilst the flag definitions cross refer the CDAT spec, the actual locations
> > > of those flags matches, but doesn't cross refer so maybe in the future
> > > we will have other flags in here and locations might not match.  
> > For the flags stored in dsmas table, do we expect there can be more than those
> > defined in Table 7-66 in spec 3.2?
> 
> Not for now. Though I'm sure something will come along at some point.
> The comment is about there being particular reason the flag locations should match
> between CDAT and what we report via the commands being added here.  The definitions
> of individual bits cross refer between specs, the register as a whole does not.
> 
> Jonathan
> 
> > 
> > Fan
> > 
> > >   
> > > >  
> > > >              cur_ent += CT3_CDAT_NUM_ENTRIES;
> > > >              region_base += ct3d->dc.regions[i].len;
> > > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > > > index bebed04085..81b826f570 100644
> > > > --- a/include/hw/cxl/cxl_device.h
> > > > +++ b/include/hw/cxl/cxl_device.h
> > > > @@ -609,6 +609,7 @@ typedef struct CXLDCRegion {
> > > >      uint8_t flags;
> > > >      unsigned long *blk_bitmap;
> > > >      uint64_t supported_blk_size_bitmask;
> > > > +    uint8_t dsmas_flags;
> > > >  } CXLDCRegion;
> > > >  
> > > >  typedef struct CXLSetFeatureInfo {  
> > >   
> 
