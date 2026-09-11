Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0123D7F0
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789088193; cv=none; b=IOyaC+e3E6ZlY9ZcJ75fT3OOn6UgRvWqI+ck7qFjChVnDuIsVaZGWVKY4kZtfEGYWbfXC4b6Kes5em1v7jMHaM5eAbqoDKgYN83sw9IvoXk7xv3DrFXDtI8I7Nn05NXQkf+bMtylpoEFre3tbxKQR/prt4hbTxt/zV9Ljki/IQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789088193; c=relaxed/simple;
	bh=QCjLrnRHM5SCqbcyO4MOXe1BvtbHgfW5rk6AErlavY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gih5/bgaNZAtaSsUkIxzzqweKppPfoWAOYxrJDY3Ty/9YKt4TUD7sz3uEJg9Zit6LipkAhios/S6MABBzh28DbXQuMMdmiYdnICBcw94iVHKRhwcKMDgJ8/+5Ay/SPY/3Gknep1fgRvAz5AwvZLFD0UPPaMvcC83kKl+ajfwJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEW1o4Ki; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEW1o4Ki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850861F000FF;
	Fri, 11 Sep 2026 00:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789088191;
	bh=z/AJXJHvN3UaBspWv+FltI0U7+oALO/5lzq6zoKHMgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NEW1o4KiybRMEQGMbI50QGnm0vrennUMDFmVGstcGaBe+APGcOLXE+B1cQChM6Kmx
	 FyP2z75N4bSt4xjCo3+Afh3Sg5XHJ8ad8PW88LX71OArUs0zkxlbgLN13VinEyYvZT
	 JBF6eUxKbBHNjdv7X+5nzL1++hdN2+9PTDUVK8OhOBCVijdrFoesYABdgj6m6ip+AR
	 hf/kr7OEkb5f3bKeORspxy43D6axgLclKpQtwFIxkYmLEFe9TeVT8PK57pqj2cElNW
	 HKLckDM2QMwsse30AxN3WBtcNDWrgg31Xp3b7M4hH9XGugA+30oa27m9eyBMiYPjP1
	 pZDQ+I5lq6lDg==
Date: Fri, 11 Sep 2026 01:56:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, dave@stgolabs.net,
 benjamin.cheatham@amd.com, Ira Weiny <iweiny@kernel.org>, Wonjae Lee
 <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
 <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 3/8] cxl/cdat: Gather DSMAS data for DCD
 partitions
Message-ID: <20260911015625.7f06c4eb@jic23-hlaptop>
In-Reply-To: <aqNFEUWNMmTvJmh_@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
	<20260908102124.2231730-5-anisa.su@samsung.com>
	<20260908215200.6f825aa1@jic23-huawei>
	<aqNFEUWNMmTvJmh_@cxlqual>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 09:02:25 +0900
Anisa Su <anisa.su887@gmail.com> wrote:

> On Tue, Sep 08, 2026 at 09:52:00PM +0100, Jonathan Cameron wrote:
> > On Tue,  8 Sep 2026 03:15:07 -0700
> > Anisa Su <anisa.su887@gmail.com> wrote:
> >   
> > > From: Ira Weiny <iweiny@kernel.org>
> > > 
> > > Additional DCD partition (AKA region) information is contained in the
> > > DSMAS CDAT tables, including performance and shareable attributes.
> > > 
> > > Match DCD partitions with DSMAS tables and store the meta data.
> > > 
> > > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > >   
> > Minor thing inline. I think we can take a bit of refactoring
> > you did a little further and end up with simpler code.
> >   
> > > ---
> > >  drivers/cxl/core/cdat.c   | 32 +++++++++++++++++++++++++-------
> > >  drivers/cxl/core/hdm.c    |  1 +
> > >  drivers/cxl/core/mbox.c   |  9 +++++++++
> > >  drivers/cxl/core/memdev.c | 17 ++++++++++-------
> > >  drivers/cxl/cxlmem.h      |  2 ++
> > >  include/cxl/cxl.h         |  4 ++++
> > >  6 files changed, 51 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > > index 5c9f07262513..05058d4520f2 100644
> > > --- a/drivers/cxl/core/cdat.c
> > > +++ b/drivers/cxl/core/cdat.c
> > > @@ -17,6 +17,7 @@ struct dsmas_entry {
> > >  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> > >  	int entries;
> > >  	int qos_class;
> > > +	bool shareable;
> > >  };
> > >  
> > >  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> > > @@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
> > >  		return -ENOMEM;
> > >  
> > >  	dent->handle = dsmas->dsmad_handle;
> > > +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
> > > +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
> > >  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
> > >  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
> > >  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> > > @@ -266,18 +269,33 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> > >  		bool found = false;
> > >  
> > >  		for (int i = 0; i < cxlds->nr_partitions; i++) {
> > > -			struct resource *res = &cxlds->part[i].res;
> > > +			struct cxl_dpa_partition *part = &cxlds->part[i];
> > >  			struct range range = {
> > > -				.start = res->start,
> > > -				.end = res->end,
> > > +				.start = part->res.start,
> > > +				.end = part->res.end,
> > >  			};
> > >  
> > > -			if (range_contains(&range, &dent->dpa_range)) {
> > > -				update_perf_entry(dev, dent,
> > > -						  &cxlds->part[i].perf);
> > > -				found = true;
> > > +			if (!range_contains(&range, &dent->dpa_range))
> > > +				continue;
> > > +
> > > +			found = true;
> > > +			/*
> > > +			 * part->handle is from Get DC Config, dent->handle
> > > +			 * from the CDAT DSMAS entry.
> > > +			 */
> > > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
> > > +			    dent->handle != part->handle) {
> > > +				dev_warn(dev,
> > > +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
> > > +					 &range, part->handle,
> > > +					 &dent->dpa_range, dent->handle);
> > >  				break;  
> > 
> > For the error path I'd just return here. Maybe there is more after this loop
> > in future patches that make it useful to break instead?
> >   
> > >  			}
> > > +
> > > +			update_perf_entry(dev, dent, &part->perf);
> > > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> > > +				part->shareable = dent->shareable;
> > > +			break;  
> > 
> > Come to think of it, can return in this path too.  Then you don't need the
> > local variable found.
> >   
> Ah the break in both spots is so we print a debug message if no
> partition is found matching the dsmas entry:
> 
> if (!found)
> 	dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> 		&dent->dpa_range);
> 
> It got cut off in the diff.

For both break paths, found == true

Jonathan

> 
> > >  		}  
> >   
> > >  
> > >  		if (!found)  

