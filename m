Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD42348EC8B
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144566; cv=none; b=K6z31CIJKyoQ17Plg30C1i4XTWMPk3vZYGrWspLTntGeTNVUXr6OSO+ED0M5irMoUBGfLHnO5JGS0jMNcxhduF4ErNJoQsz+1AAH5AnGSYRq3080vQmlhr72sk7d47dbkgTg1mwHRWkRw5jCd1oxjbty/z4R9afWTV00qBbQzLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144566; c=relaxed/simple;
	bh=KX+jyv32AFaLAwDFSnZdoi8lHOtReKg/NNWDOP7DF/A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEuR+ulIHC6tHh+PRzU9j3xtdPBksiPaMplf6CJyR80mMVHvzJHeT2nbgtIRJn4Dd5EE2bGMcRPvtvCKcBGooPM+WsWUM8m0ylFLtm1BrYhx1ZFD1Mpy+EydP48JfgaKGChmXjUOkuDass7EjQY6yDXgLokdyHe+RU/pDyzprPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrwO9SMH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrwO9SMH"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381b831d535so1961751a91.0
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789144560; x=1789749360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Si8ROppyHxCpSP6F39uSGaU3fGeGGeRGZJykcbOB2jU=;
        b=PrwO9SMHxoAc+JGQ75+HRdYgjNC9H93wkkBCjJZu8p+UCug/S5h5OJ9GYfPLFmwbN9
         eYBX1OcsbHDhCHsTxdcp5C9fO+JpQZSBOWj10o4i8vdZpFdLqVpN7CZrmBQ/fC8GwBgB
         4aoeujsqj+3KuczC/8Z1Nj56Bhffk3uzMruRSsjgoGDzNaaTrH+TBhjn19Rw4FUZrfW9
         ijTjMP2Sd6D4I4kL3op2uMXzXImR65Pc88nowR473B6RHIYLiRs06wR3b4Mdm910ckkf
         A16CHYiQCsMaPIrQ2d4N6nIEJhe4JG6p9gmTwjP5tvI1mQgY5Yr9pA5Dcxi7x/nIyQQt
         uoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144560; x=1789749360;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Si8ROppyHxCpSP6F39uSGaU3fGeGGeRGZJykcbOB2jU=;
        b=ZgGDEJLD/9bqUZ/A1FH9MDWYNOCRJNbbRWmSyRjpVVWdu6puQt+gkWP3Hcg3SyOOA6
         NQRXNIKCtw2bbA13NOaGoMeFsdEJEvIUc79s4lJcCpK/8X+s6HX+6111MfrjJ5pMhfv6
         GvFJvCM3tGxOzOzFIiFRxuNvgL7Q9wQ4G2/Lqqf/97pVfOZKlVav7ZkvEQWIeE1ni8Cu
         SR1lwxnsOgP19lAMUVPQnN+XiwN4Io3aHqVf5Nr07DYcZTgje8AeN6HqXsh23cT4QYm+
         jVHocrIz0eyrlNwbb9MeLeYamL6/jRraQ4TDD49DuB/Rs1cUJXWTmqrp4svq2FmuU/kK
         2tYw==
X-Forwarded-Encrypted: i=1; AKwUvBwibNaixFOITfXhUTZr03UQ1LUg/hJp4zY6ecFROqai3AI2oKMFWAsmT1kukg906jFEFU5j8CGAD1A=@vger.kernel.org
X-Gm-Message-State: AFuF++meM9i0yCGkMZx2Db/3CiDCE6qcpORf3PZzRqtKp9pTsgXgPetq
	hr9woUeBasz/KVf1MEOV16mRs5iyDby9riEvQUczqGUt9kuLmvAS34wY
X-Gm-Gg: AYBFou2QMmX3ACT1vvtWtayNTpC5J4s2EdvFs9+e71gw6OsKEZnu3m85JsfrWwWbycB
	BVETOL6NV6ezRwKTpNwrji9c8zPJdUgmDB4kRih7v+6PNwwBo3B87LqQ0/+r2NZZc6t7CV/ggZB
	fLdj/9yZrt9GruVUcOXtiojeU9v6oePnOzf+fgXb9lzu6vJqzEU7u8OBjQH9mKd38jmPd8g3Nrq
	tKrRSxBB4FTIi0mvGVup+a6LEG4xioMub6B+OljxN1hifg8vXpgm3P3ZlYK/JHPtbJG4eZ+W3Xh
	I8W3jEvsNBhKqVn7S+I/r156aIaxGqNOb96H1E/uXTZ7djlISKk1qE1nJrhj896sgLTT0FL0VPj
	dnQQv4F3pUxniejGsa/9r/TTxEvW3OAkjKf0UQ6rWy3zKuoPO4zukMNhV4kywQe5UadzAoKVhgp
	oCXlpTtvEaMw++A7mON4Nqzjd25rDoOTwgfJ9p/eIXDPqJ7nltlhua1SIwus6vlCVXRC/YVuXLa
	1s41hwUvTXcRkIbZIo7Vcyt
X-Received: by 2002:a17:90b:4b0e:b0:398:9be5:b41d with SMTP id 98e67ed59e1d1-39d9c368348mr8266018a91.24.1789144559649;
        Fri, 11 Sep 2026 09:35:59 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9587c157sm5894141a91.16.2026.09.11.09.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:35:59 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Sat, 12 Sep 2026 01:37:15 +0900
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, dave.jiang@intel.com, gourry@gourry.net,
	icheng@nvidia.com, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 3/8] cxl/cdat: Gather DSMAS data for DCD
 partitions
Message-ID: <aqQuO-6kwau4RYk4@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-5-anisa.su@samsung.com>
 <20260908215200.6f825aa1@jic23-huawei>
 <aqNFEUWNMmTvJmh_@cxlqual>
 <20260911015625.7f06c4eb@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911015625.7f06c4eb@jic23-hlaptop>

On Fri, Sep 11, 2026 at 01:56:25AM +0100, Jonathan Cameron wrote:
> On Fri, 11 Sep 2026 09:02:25 +0900
> Anisa Su <anisa.su887@gmail.com> wrote:
> 
> > On Tue, Sep 08, 2026 at 09:52:00PM +0100, Jonathan Cameron wrote:
> > > On Tue,  8 Sep 2026 03:15:07 -0700
> > > Anisa Su <anisa.su887@gmail.com> wrote:
> > >   
> > > > From: Ira Weiny <iweiny@kernel.org>
> > > > 
> > > > Additional DCD partition (AKA region) information is contained in the
> > > > DSMAS CDAT tables, including performance and shareable attributes.
> > > > 
> > > > Match DCD partitions with DSMAS tables and store the meta data.
> > > > 
> > > > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > > > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > > > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > > > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > > >   
> > > Minor thing inline. I think we can take a bit of refactoring
> > > you did a little further and end up with simpler code.
> > >   
> > > > ---
> > > >  drivers/cxl/core/cdat.c   | 32 +++++++++++++++++++++++++-------
> > > >  drivers/cxl/core/hdm.c    |  1 +
> > > >  drivers/cxl/core/mbox.c   |  9 +++++++++
> > > >  drivers/cxl/core/memdev.c | 17 ++++++++++-------
> > > >  drivers/cxl/cxlmem.h      |  2 ++
> > > >  include/cxl/cxl.h         |  4 ++++
> > > >  6 files changed, 51 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > > > index 5c9f07262513..05058d4520f2 100644
> > > > --- a/drivers/cxl/core/cdat.c
> > > > +++ b/drivers/cxl/core/cdat.c
> > > > @@ -17,6 +17,7 @@ struct dsmas_entry {
> > > >  	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> > > >  	int entries;
> > > >  	int qos_class;
> > > > +	bool shareable;
> > > >  };
> > > >  
> > > >  static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> > > > @@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
> > > >  		return -ENOMEM;
> > > >  
> > > >  	dent->handle = dsmas->dsmad_handle;
> > > > +	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
> > > > +	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
> > > >  	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
> > > >  	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
> > > >  			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
> > > > @@ -266,18 +269,33 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> > > >  		bool found = false;
> > > >  
> > > >  		for (int i = 0; i < cxlds->nr_partitions; i++) {
> > > > -			struct resource *res = &cxlds->part[i].res;
> > > > +			struct cxl_dpa_partition *part = &cxlds->part[i];
> > > >  			struct range range = {
> > > > -				.start = res->start,
> > > > -				.end = res->end,
> > > > +				.start = part->res.start,
> > > > +				.end = part->res.end,
> > > >  			};
> > > >  
> > > > -			if (range_contains(&range, &dent->dpa_range)) {
> > > > -				update_perf_entry(dev, dent,
> > > > -						  &cxlds->part[i].perf);
> > > > -				found = true;
> > > > +			if (!range_contains(&range, &dent->dpa_range))
> > > > +				continue;
> > > > +
> > > > +			found = true;
> > > > +			/*
> > > > +			 * part->handle is from Get DC Config, dent->handle
> > > > +			 * from the CDAT DSMAS entry.
> > > > +			 */
> > > > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
> > > > +			    dent->handle != part->handle) {
> > > > +				dev_warn(dev,
> > > > +					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
> > > > +					 &range, part->handle,
> > > > +					 &dent->dpa_range, dent->handle);
> > > >  				break;  
> > > 
> > > For the error path I'd just return here. Maybe there is more after this loop
> > > in future patches that make it useful to break instead?
> > >   
> > > >  			}
> > > > +
> > > > +			update_perf_entry(dev, dent, &part->perf);
> > > > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
> > > > +				part->shareable = dent->shareable;
> > > > +			break;  
> > > 
> > > Come to think of it, can return in this path too.  Then you don't need the
> > > local variable found.
> > >   
> > Ah the break in both spots is so we print a debug message if no
> > partition is found matching the dsmas entry:
> > 
> > if (!found)
> > 	dev_dbg(dev, "no partition for dsmas dpa: %pra\n",
> > 		&dent->dpa_range);
> > 
> > It got cut off in the diff.
> 
> For both break paths, found == true
> 
> Jonathan
> 
Woah that was really dumb of me. Pretend I agreed with you the first
time.

Anisa
> > 
> > > >  		}  
> > >   
> > > >  
> > > >  		if (!found)  
> 
