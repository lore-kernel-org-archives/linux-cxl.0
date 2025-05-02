Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05A433CE
	for <linux-cxl@vger.kernel.org>; Fri,  2 May 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176524; cv=none; b=GPHmUedVpTvwAsgK8wPKAakZvqsjIDiKMfbgCZR9VJp3zlPzgq5Ig/WSOAtVHXOVyD5RR+rPfDGznJSMb6ygBv8D6RE5Ys1PjJ3l7w4NsTrU1aeVbGNt83iGVD27GTyjME1K8LZQk2SnP6JxwYHTLZ5jdWXC64kOoTsLGcZrspY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176524; c=relaxed/simple;
	bh=5bxBxlFd/9+7M9oK+/sjxyMmLcpR4/q0oDR2cIxjp4o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/7d9rRWOk5hvdCh+KiCAaZwZTvKJRSegUdW0Li0LgW7iap8DuHqGrE8wn84MrAijvxh9XPFTG2NVUIs5JumJla1ue2D7OXyn2TWLw2lebEcwJo5DctVuBeytBy2g0OLBoG39qNfASGlCtnS13PE31eHPypiEMZJ+JrAXkd0KXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZplH73psZz6L51q;
	Fri,  2 May 2025 16:59:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A8792140137;
	Fri,  2 May 2025 17:01:58 +0800 (CST)
Received: from localhost (10.48.156.249) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 May
 2025 11:01:58 +0200
Date: Fri, 2 May 2025 10:01:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: <anisa.su887@gmail.com>, <qemu-devel@nongnu.org>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 3/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <20250502100155.00003bfa@huawei.com>
In-Reply-To: <aBPV80J9TULzRslk@fanair.local>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
	<20250317164204.2299371-4-anisa.su887@gmail.com>
	<20250424114259.000000a0@huawei.com>
	<aBPV80J9TULzRslk@fanair.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 1 May 2025 20:21:56 +0000
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Thu, Apr 24, 2025 at 11:42:59AM +0100, Jonathan Cameron wrote:
> > On Mon, 17 Mar 2025 16:31:30 +0000
> > anisa.su887@gmail.com wrote:
> >   
> > > From: Anisa Su <anisa.su@samsung.com>
> > > 
> > > Add dsmas_flags field to DC Region struct in preparation for next
> > > command, which returns the dsmas flags in the response.
> > > 
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > ---
> > >  hw/mem/cxl_type3.c          | 2 ++
> > >  include/hw/cxl/cxl_device.h | 1 +
> > >  2 files changed, 3 insertions(+)
> > > 
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index 731497ebda..452a0c101a 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -237,6 +237,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> > >                                            ct3d->dc.regions[i].len,
> > >                                            false, true, region_base);
> > >              ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> > > +            CDATDsmas *dsmas = (CDATDsmas *) table[cur_ent + CT3_CDAT_DSMAS];
> > > +            ct3d->dc.regions[i].dsmas_flags = dsmas->flags;  
> >   
> Hi Jonathan,
> Thanks for the feedback.
> > This is relying to much on the ordering of creating fields in
> > ct3_build_cdat_entries_for_mr().  
> I am not sure whether I understand this clearly.
> In current qemu implemtation, each mr (ram,pmem or dc region) will have the
> whole set of cdat table entries (dsmas, dslbis0-3, etc), so as long as we point
> to the right table entry, we can get the table correctly.
> What do you mean "the ordering of creating fields"?

It is an implementation detail only that the first bit of that table is
the DSMAS entry.  I think we shouldn't rely on that.

> > 
> > I'd rather you just stored the information flags is built from in CXLDCRegion
> > and then built the field that is wonderfully called 'Note' in the DC region  
I got distracted by the spec oddity :)

> This sentence is kind of broken for me, not totally clear what you are
> suggesting :-(. Can you explain more?
> Are you suggesting not directly take dsmas->flags as dsmas_flags, but
> use bit op to generate the value used in Table 7-66 in cxl spec 3.2?

No. Just store the various  bools etc that become dsmas->flags in the
CXLDCRegion structure directly rather than reading back from dsmas->flags.
Probably as explicit bools etc not a single value.

Then pass those in to  ct3_build_cdat_entries_for_mr() .  Mostly they overlap
with current true / false parameters that are hard coded.


> > configuration in 6.2 spec.   I've sent a mail to see if we can clean that  
> 6.2 spec???
> > 'what is the field called' question for future spec releases.
> > 
> > Whilst the flag definitions cross refer the CDAT spec, the actual locations
> > of those flags matches, but doesn't cross refer so maybe in the future
> > we will have other flags in here and locations might not match.  
> For the flags stored in dsmas table, do we expect there can be more than those
> defined in Table 7-66 in spec 3.2?

Not for now. Though I'm sure something will come along at some point.
The comment is about there being particular reason the flag locations should match
between CDAT and what we report via the commands being added here.  The definitions
of individual bits cross refer between specs, the register as a whole does not.

Jonathan

> 
> Fan
> 
> >   
> > >  
> > >              cur_ent += CT3_CDAT_NUM_ENTRIES;
> > >              region_base += ct3d->dc.regions[i].len;
> > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > > index bebed04085..81b826f570 100644
> > > --- a/include/hw/cxl/cxl_device.h
> > > +++ b/include/hw/cxl/cxl_device.h
> > > @@ -609,6 +609,7 @@ typedef struct CXLDCRegion {
> > >      uint8_t flags;
> > >      unsigned long *blk_bitmap;
> > >      uint64_t supported_blk_size_bitmask;
> > > +    uint8_t dsmas_flags;
> > >  } CXLDCRegion;
> > >  
> > >  typedef struct CXLSetFeatureInfo {  
> >   

