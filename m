Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B81442FBE
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417960; cv=none; b=k54Gv10vqiPr1hAkKiR2DNI4q4/LTb8+e6vMpHH2N2yAZiwti2UC620PCsBpT4j7n79+P4+3LtwGBY7Zoi8kxS0wq9ADeJNNZYjZvNU5MshweY/jJa9BVwNq9s6DeUR1RsMuRQBjlc5ZJKfJzS8BpqRtUTBOU3tVz5Fe588kIi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417960; c=relaxed/simple;
	bh=lZOzNiOiDXh2OCpR9ZvnygTuLDPQ2LVPRWmDDrgObAE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf1irp/rVxyLVMox/JacsEpdcKp0EmKFAoeJoyltvhlH5N/VJzoiL9AoVG9JVT4IHG/UMc/MhgNSmkfI3pth64ruggb2viSyhyEo3gvMw5jCim8eBF4n0HgIQgGQxCYK5z+RfMAna8nho37Ul1kx7L0fdhnXFfElhqw2sw0hCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rzn9TKDo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rzn9TKDo"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8701fcf40d4so771305b3a.3
        for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789417958; x=1790022758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hnQDsSks2ulbXA9S2xVxN9uyEq1YkizwYfbj2+pbKUA=;
        b=Rzn9TKDolTE7rVBKc1QBiapBBsmcjkjLH8MOlebZ0didYh9UG1TFKC1VzugPVYLvAw
         WUbOB6KyKwomMk0XcmtrK+WjY5NyEQj9j4pX65ODGwhVyLdRvoQ5ei+K/pozQWrD1Tu9
         oKEtJne57LdXU4MbLkdkXgR3OVeoR+A/srTITPfBRBFWhNo+9U7Yofz3O7dKoejgQLN1
         gnM3uKstXPLerBN8rIQIZiwmcHCKWtvW4jfITY29Tjr73aDAMSCE83DNnWv5bRUq8EDC
         jZ3z7FXE/r6UkD/jWHuSzMpNYVdbl3fOk+PKDHGFCsQ+ahY5Ke7j8IPUMYj4SkwDphiA
         AeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789417958; x=1790022758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnQDsSks2ulbXA9S2xVxN9uyEq1YkizwYfbj2+pbKUA=;
        b=f+DlW4LPK8vAi/NREAF3LiExHeOLDCSKu0pejHmvjQ1nqgBDA8OxiYUp/HK0lBkmz6
         R+H0HgKGUBpUSDWWgT6eR+5lkmzHKqRE4j4r8hseUB+c2Ua8x6lzuK3juUGYWzD7gdUL
         g/w7Ajeb/wNgoop18qX2pCP1UaGEIgZT/YkW4GPM1I91NV+zazaeibOXvK9YfJ9if56g
         RvvjKDG1rTGvD3T8EDi48DaDddxGP6souXrYoK/jSdIZVxLdzZ8qnlvrkQCFYMUSeEY8
         scajF3SyOHaxhV8ioPK6bcPfx4xKovs8YGAxwrCW1m1G07DdjPZNRagzIgydqTfxoFzZ
         WWKw==
X-Forwarded-Encrypted: i=1; AKwUvBxXTh91YkhuHEFzhwic9mVwXRy6zoG9D8oTyJGchJI1RKtsUGE5gOwaVtIVk1XdC27hX1J89wu44m8=@vger.kernel.org
X-Gm-Message-State: AFuF++kwp65BqpBqoMmBUxJ1kJyGi6kGF05P0tckn/1r9VfGC+z3RHb3
	bXveWURSAD8TTTLqdawWN1iPkXYGXaATGurvcWBwIQCFQOoEjos2/uNhd3ST9qI2
X-Gm-Gg: AYBFou0qmJiPXDrb7KPThc2lBtbBbUWgKEFeOM5/RdMTp3mfWnRWrYGrxeMzG2WfFHb
	Wotbk65iSwAh/c9TERMLhdCmWLkN8WAhyqJc5x5OJao7RNKP05BLQA5X0zMoyfLTnBB8xS9Skpl
	oRqMbB60jQLgTDCyIeCRi/E1xZJJoh+IWJdfWrhTUDVBW1SHEOomRHD4ml/UawNb1HWn9kDRIv7
	yVPxovrNDA6fSB1yl/P9ObDvUOOvJsEZLokLI4BIn4eaRkdd+uY/Xw7/c5RS7O8kBqNeYe8wUc1
	XGo+s/JD1G9xJbQGN2YoyPVY8I7EFSiuG0gJkFryVHJYk4o9p9gCdzDtgQJ9NhVGxCM46JR+few
	HzSq8MuMLmZtqnxJwBvsOYrvdVpj95EMS43+VuN5/pigZAjvpuXaJW2zJctrNyzmyXY74SNVn69
	3Mg8yHiVA1KUCM1TCH5pPz1Li1t3uEQ/ynOb25ZD5Iipm6ne3ciNEuAQU+FHWssC5Y99H/K+kBA
	MGLjAnFhr76DzJ3Ayu3uDFy
X-Received: by 2002:a05:6a20:2454:b0:3da:5eda:d167 with SMTP id adf61e73a8af0-3db4039d3b3mr8560559637.5.1789417957939;
        Mon, 14 Sep 2026 13:32:37 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c652aa9asm5513192a12.9.2026.09.14.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 13:32:37 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 15 Sep 2026 05:33:49 +0900
To: Anisa Su <anisa.su887@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, dave.jiang@intel.com, gourry@gourry.net,
	icheng@nvidia.com, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 3/8] cxl/cdat: Gather DSMAS data for DCD
 partitions
Message-ID: <aqhaLTIc8Z8VknnT@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-5-anisa.su@samsung.com>
 <20260908215200.6f825aa1@jic23-huawei>
 <aqNFEUWNMmTvJmh_@cxlqual>
 <20260911015625.7f06c4eb@jic23-hlaptop>
 <aqQuO-6kwau4RYk4@cxlqual>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqQuO-6kwau4RYk4@cxlqual>

On Sat, Sep 12, 2026 at 01:37:15AM +0900, Anisa Su wrote:
> On Fri, Sep 11, 2026 at 01:56:25AM +0100, Jonathan Cameron wrote:
> > On Fri, 11 Sep 2026 09:02:25 +0900
> > Anisa Su <anisa.su887@gmail.com> wrote:
> > 
> > > On Tue, Sep 08, 2026 at 09:52:00PM +0100, Jonathan Cameron wrote:
> > > > On Tue,  8 Sep 2026 03:15:07 -0700
> > > > Anisa Su <anisa.su887@gmail.com> wrote:
> > > >   
> > > > > From: Ira Weiny <iweiny@kernel.org>
> > > > > 
> > > > > Additional DCD partition (AKA region) information is contained in the
> > > > > DSMAS CDAT tables, including performance and shareable attributes.
> > > > > 
> > > > > Match DCD partitions with DSMAS tables and store the meta data.
> > > > > 
> > > > > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > > > > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > > > > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > > > > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > > > >   
> > > > Minor thing inline. I think we can take a bit of refactoring
> > > > you did a little further and end up with simpler code.
> > > >   
> > > > > ---
> > > > >  drivers/cxl/core/cdat.c   | 32 +++++++++++++++++++++++++-------
> > > > >  drivers/cxl/core/hdm.c    |  1 +
> > > > >  drivers/cxl/core/mbox.c   |  9 +++++++++
> > > > >  drivers/cxl/core/memdev.c | 17 ++++++++++-------
> > > > >  drivers/cxl/cxlmem.h      |  2 ++
> > > > >  include/cxl/cxl.h         |  4 ++++
> > > > >  6 files changed, 51 insertions(+), 14 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > > > > index 5c9f07262513..05058d4520f2 100644
> > > > > --- a/drivers/cxl/core/cdat.c
> > > > > +++ b/drivers/cxl/core/cdat.c
> > > > > @@ -17,6 +17,7 @@ struct dsmas_entry {
> > > > >  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> > > > >  	int entries;
> > > > >  	int qos_class;
> > > > > +	bool shareable;
> > > > >  };
> > > > >  
> > > > >  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> > > > > @@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
> > > > >  		return -ENOMEM;
> > > > >  
> > > > >  	dent->handle = dsmas->dsmad_handle;
> > > > > +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
> > > > > +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
> > > > >  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
> > > > >  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
> > > > >  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> > > > > @@ -266,18 +269,33 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> > > > >  		bool found = false;
> > > > >  
> > > > >  		for (int i = 0; i < cxlds->nr_partitions; i++) {
> > > > > -			struct resource *res = &cxlds->part[i].res;
> > > > > +			struct cxl_dpa_partition *part = &cxlds->part[i];
> > > > >  			struct range range = {
> > > > > -				.start = res->start,
> > > > > -				.end = res->end,
> > > > > +				.start = part->res.start,
> > > > > +				.end = part->res.end,
> > > > >  			};
> > > > >  
> > > > > -			if (range_contains(&range, &dent->dpa_range)) {
> > > > > -				update_perf_entry(dev, dent,
> > > > > -						  &cxlds->part[i].perf);
> > > > > -				found = true;
> > > > > +			if (!range_contains(&range, &dent->dpa_range))
> > > > > +				continue;
> > > > > +
> > > > > +			found = true;
> > > > > +			/*
> > > > > +			 * part->handle is from Get DC Config, dent->handle
> > > > > +			 * from the CDAT DSMAS entry.
> > > > > +			 */
> > > > > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
> > > > > +			    dent->handle != part->handle) {
> > > > > +				dev_warn(dev,
> > > > > +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
> > > > > +					 &range, part->handle,
> > > > > +					 &dent->dpa_range, dent->handle);
> > > > >  				break;  
> > > > 
> > > > For the error path I'd just return here. Maybe there is more after this loop
> > > > in future patches that make it useful to break instead?
> > > >   
> > > > >  			}
> > > > > +
> > > > > +			update_perf_entry(dev, dent, &part->perf);
> > > > > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> > > > > +				part->shareable = dent->shareable;
> > > > > +			break;  
> > > > 
> > > > Come to think of it, can return in this path too.  Then you don't need the
> > > > local variable found.
> > > >   
> > > Ah the break in both spots is so we print a debug message if no
> > > partition is found matching the dsmas entry:
> > > 
> > > if (!found)
> > > 	dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> > > 		&dent->dpa_range);
> > > 
> > > It got cut off in the diff.
> > 
> > For both break paths, found == true
> > 
> > Jonathan
> > 
> Woah that was really dumb of me. Pretend I agreed with you the first
> time.
> 
> Anisa

Wait sorry I think the break is still correct...? The break exists to leave
the inner for each partition loop, but continue onto the next dsmas entry from
the outer xa_for_each.

Returning would skip all following dsmas entries, which leaves those
partitions with CXL_QOS_CLASS_INVALID.

Thanks,
Anisa
> > > 
> > > > >  		}  
> > > >   
> > > > >  
> > > > >  		if (!found)  
> > 
