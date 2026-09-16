Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B63672BD
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789520905; cv=none; b=j7K0kt3JtIqYslw4KzsXAjKrIA3pqlZVPplKYiErwMcPVAgXYVI0QYO97qdBY/tSmDzRfK5raMhW+PCAPN+LUNauhHmonUCJjbGMDgAzA4Q3W3TGA7HeKfFMFEqyJoDoajShPkN6jEg8h0sSKKgSmYJQ9oWwWfyBYy9DbJOBQfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789520905; c=relaxed/simple;
	bh=x/JHiqkUlQyPTWNbaNNHvxEqbgGndOVDIWDAFtCxKnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHNZCaR9x3n9WHisu5jI9XsxM2GOlvIwWbXXfR6zzuQ3jkvk2vuXmR4Heyb1E8dAFDDHNlqFsRxmSxkb1c0Z8nL5ecLK/BtCzsQj0jolCmHhlwB+viYcmQK7KWssvdNRL9pApM3MU+x01srNnhmuErPp5b9z92saUHVar3uZvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lkd9jyVx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lkd9jyVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190C51F000FF;
	Wed, 16 Sep 2026 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789520903;
	bh=GeIVwuD/AQPvxVAm7b5hi6P2XbB7ZLcn2HE/5blya3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lkd9jyVx1jlZn3sNI+Y3u6ZKf22HpfdRyMNJmVRdGfQFISmNYVy/DiwGWimneGfUt
	 1mhzzSJutqNxyhidyOKhyNMueFSmHtvUq1vYmoAEnaMIGShMeynvvDZyYiJirNAuKG
	 yN3yTLIehhLRLFuiiKYVVUbrsXHraVqsJV69C7fj4GZ7NtcB0aliPMd8rK6snV5VHH
	 puKsr7hYP1+/MzvpEGhFE4ptRBbj+eSqZ0g26WMuBm/Hj201D4W/gS4sRugPNVxnoc
	 pTCaU1NuAiQ8OnklUn3YXmJ3U/EJklO/6AOJgfK4kF5OgLRSJ+HPrQpayhprk3+3f3
	 fOJeQ9XEj74Ag==
Date: Wed, 16 Sep 2026 02:08:12 +0100
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
Message-ID: <20260916020812.1146d1c1@jic23-hlaptop>
In-Reply-To: <aqhaLTIc8Z8VknnT@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
	<20260908102124.2231730-5-anisa.su@samsung.com>
	<20260908215200.6f825aa1@jic23-huawei>
	<aqNFEUWNMmTvJmh_@cxlqual>
	<20260911015625.7f06c4eb@jic23-hlaptop>
	<aqQuO-6kwau4RYk4@cxlqual>
	<aqhaLTIc8Z8VknnT@cxlqual>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 05:33:49 +0900
Anisa Su <anisa.su887@gmail.com> wrote:

> On Sat, Sep 12, 2026 at 01:37:15AM +0900, Anisa Su wrote:
> > On Fri, Sep 11, 2026 at 01:56:25AM +0100, Jonathan Cameron wrote:  
> > > On Fri, 11 Sep 2026 09:02:25 +0900
> > > Anisa Su <anisa.su887@gmail.com> wrote:
> > >   
> > > > On Tue, Sep 08, 2026 at 09:52:00PM +0100, Jonathan Cameron wrote:  
> > > > > On Tue,  8 Sep 2026 03:15:07 -0700
> > > > > Anisa Su <anisa.su887@gmail.com> wrote:
> > > > >     
> > > > > > From: Ira Weiny <iweiny@kernel.org>
> > > > > > 
> > > > > > Additional DCD partition (AKA region) information is contained in the
> > > > > > DSMAS CDAT tables, including performance and shareable attributes.
> > > > > > 
> > > > > > Match DCD partitions with DSMAS tables and store the meta data.
> > > > > > 
> > > > > > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > > > > > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > > > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > > > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > > > > > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > > > > > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > > > > >     
> > > > > Minor thing inline. I think we can take a bit of refactoring
> > > > > you did a little further and end up with simpler code.
> > > > >     
> > > > > > ---
> > > > > >  drivers/cxl/core/cdat.c   | 32 +++++++++++++++++++++++++-------
> > > > > >  drivers/cxl/core/hdm.c    |  1 +
> > > > > >  drivers/cxl/core/mbox.c   |  9 +++++++++
> > > > > >  drivers/cxl/core/memdev.c | 17 ++++++++++-------
> > > > > >  drivers/cxl/cxlmem.h      |  2 ++
> > > > > >  include/cxl/cxl.h         |  4 ++++
> > > > > >  6 files changed, 51 insertions(+), 14 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > > > > > index 5c9f07262513..05058d4520f2 100644
> > > > > > --- a/drivers/cxl/core/cdat.c
> > > > > > +++ b/drivers/cxl/core/cdat.c
> > > > > > @@ -17,6 +17,7 @@ struct dsmas_entry {
> > > > > >  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> > > > > >  	int entries;
> > > > > >  	int qos_class;
> > > > > > +	bool shareable;
> > > > > >  };
> > > > > >  
> > > > > >  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> > > > > > @@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
> > > > > >  		return -ENOMEM;
> > > > > >  
> > > > > >  	dent->handle = dsmas->dsmad_handle;
> > > > > > +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
> > > > > > +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
> > > > > >  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
> > > > > >  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
> > > > > >  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> > > > > > @@ -266,18 +269,33 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> > > > > >  		bool found = false;
> > > > > >  
> > > > > >  		for (int i = 0; i < cxlds->nr_partitions; i++) {
> > > > > > -			struct resource *res = &cxlds->part[i].res;
> > > > > > +			struct cxl_dpa_partition *part = &cxlds->part[i];
> > > > > >  			struct range range = {
> > > > > > -				.start = res->start,
> > > > > > -				.end = res->end,
> > > > > > +				.start = part->res.start,
> > > > > > +				.end = part->res.end,
> > > > > >  			};
> > > > > >  
> > > > > > -			if (range_contains(&range, &dent->dpa_range)) {
> > > > > > -				update_perf_entry(dev, dent,
> > > > > > -						  &cxlds->part[i].perf);
> > > > > > -				found = true;
> > > > > > +			if (!range_contains(&range, &dent->dpa_range))
> > > > > > +				continue;
> > > > > > +
> > > > > > +			found = true;
> > > > > > +			/*
> > > > > > +			 * part->handle is from Get DC Config, dent->handle
> > > > > > +			 * from the CDAT DSMAS entry.
> > > > > > +			 */
> > > > > > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
> > > > > > +			    dent->handle != part->handle) {
> > > > > > +				dev_warn(dev,
> > > > > > +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
> > > > > > +					 &range, part->handle,
> > > > > > +					 &dent->dpa_range, dent->handle);
> > > > > >  				break;    
> > > > > 
> > > > > For the error path I'd just return here. Maybe there is more after this loop
> > > > > in future patches that make it useful to break instead?
> > > > >     
> > > > > >  			}
> > > > > > +
> > > > > > +			update_perf_entry(dev, dent, &part->perf);
> > > > > > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> > > > > > +				part->shareable = dent->shareable;
> > > > > > +			break;    
> > > > > 
> > > > > Come to think of it, can return in this path too.  Then you don't need the
> > > > > local variable found.
> > > > >     
> > > > Ah the break in both spots is so we print a debug message if no
> > > > partition is found matching the dsmas entry:
> > > > 
> > > > if (!found)
> > > > 	dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> > > > 		&dent->dpa_range);
> > > > 
> > > > It got cut off in the diff.  
> > > 
> > > For both break paths, found == true
> > > 
> > > Jonathan
> > >   
> > Woah that was really dumb of me. Pretend I agreed with you the first
> > time.
> > 
> > Anisa  
> 
> Wait sorry I think the break is still correct...? The break exists to leave
> the inner for each partition loop, but continue onto the next dsmas entry from
> the outer xa_for_each.
> 
> Returning would skip all following dsmas entries, which leaves those
> partitions with CXL_QOS_CLASS_INVALID.
Ah.. Oops. Good point. I guess we paper over any errors and carry on.

Jonathan

> 
> Thanks,
> Anisa
> > > >   
> > > > > >  		}    
> > > > >     
> > > > > >  
> > > > > >  		if (!found)    
> > >   
> 

