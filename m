Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059217BD3
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732204181; cv=none; b=MDPv3kVqNUp03pUYlzvR8eWR0Id5hiQsfPC0d+FUH2BksoDtGYSsztnd8JZq8gPhtwDXwuhOKdPaw2aDa31buvAvrjX1KNj9S/f0tVXqJbLTdaLio/Ko7G8jdKGmoWVaX+3SEV+2hM08Z4Vw163RBvEAc7tItea09pyrO+Ln0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732204181; c=relaxed/simple;
	bh=Oh2BfdcHy7OE0x9WaESMJI4AmM1rSdTVvNsNt0TS0t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFz5QwntF+DyHihBNw7Qv4Qlf6WGpCmbFueMLLbk3YurvOb0BqrwgUIdRsWoZ5uuco1vnkDQjkuI2x6cV+U2mOlKdyMBPeQwhIslMOL16ClGnR2t9pZ39wG4elmOlo9ltWQ3kUXxfqCv5DGbtAtGzldoi3scDW1qloyUZabvHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CrIN55H9; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CrIN55H9"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46375ac25fbso7079281cf.0
        for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1732204178; x=1732808978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=imGyslVzf4MtAURe8zmBJ1AT4ZR15AATmZm1LrrG9KI=;
        b=CrIN55H94xdEe9kJWFTcz441z2u0l5Wh4dT4fecty+AV2No8cMQMfZ6D4CUvO8gYcR
         +OyojOtqcasfP6TsYpSfMruF1KQFi0ppqRkeQgCc6NIRnzTO5H0w9a53esovD3fJ6VRH
         48WCU4T85NlU2636kTnsTtfOm6tAWDTXIkynAQeDGs3+JYdAD6CfC6MbPaDlYIBdiXtv
         73XOIugaLbV/O34A/SXJjhoUyL3kErbJkXbo/2FDL/kl57GEPMLd/ejJEeA9ZGyoDQBr
         15mZWMXA6mU6vXlF2ySLziRZpHYqk8fT+3jVkdTyNduQlYTR+p1+VUiUVCG42LTPTFpG
         0oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732204178; x=1732808978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imGyslVzf4MtAURe8zmBJ1AT4ZR15AATmZm1LrrG9KI=;
        b=ld9iTRLvtgTbixSEex9sR6d6mqN1RJGW3+XRY8TUcv9HiRSpDGwgkSB0zRc3zmJUgF
         eCdQjz1bWYv2CCTkAne8KsQhFwW/ufQcOHYSkMboGCD3SX8QK04t1nhUAa2WdORexp48
         HfFT6x+u025Ii7BeM6PtBJR7y0KHw0HvqsWaePnxQ53ticLzaw8CgwofFsQTJVvn38q2
         srOh52STNe7riqT2kc+9/xKmOZr1GPKS01JT5JrWyknxiPeQcACvXoandOT+Et+zVnG6
         6a3gNK8d3tITqbmxUmPFBlo6o66OC0uwTUR1pr5rS8p9K+Wti1x+Q5eMphh7mUumZpmL
         OGww==
X-Gm-Message-State: AOJu0YxtA9xOXdlHq8rXb8CkavmNAyY/X9UYetekhh00LmzrKNKnsH5/
	gvlOlMb3Ar8j2ZNS/8eApA+UPSRy4M1GrUzEmqDblln/YUUmodOs8Bbtgn4XHmhEiYBP014qYFH
	m
X-Gm-Gg: ASbGncvhsUmDDAv0b0FCpQwIu6dC8jxbC4jKMVOmnvSOQMDV34xho5xlI32JfuCy2N6
	ZeXCJQaDTaXon6mIfSGR0JBL4gB1u+GwkYt97YBKKTeQLAYrlMSDSrNWGIeuOh7N3t0XKHdkTlz
	kJUD6mdw4b1uZ7P6/r/zymm5IH+W4RRxdVu2FT/6mbbqUj31gniZDUKyK/DYi1Cl6HWnqkcEP7j
	MqkzoCU4pLY1qgltZhhXwVpnEhrHmu5gFiyM4nwEmNLcIN50HW3Xhp8L0RitwqVsffzQAgKma77
	4/OUQRMbppBHpZHnBX2G26L3/Iw7yT2blD4=
X-Google-Smtp-Source: AGHT+IHfa6uG1/ElJG3c1ctd03gnOTTo/GnY7T0aRJbPucnRyYeXTT/g4/UhflcfSiPSDaYXjPo35A==
X-Received: by 2002:ac8:5e4d:0:b0:460:a730:3176 with SMTP id d75a77b69052e-464777e23f3mr93728941cf.11.1732204178485;
        Thu, 21 Nov 2024 07:49:38 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646a63da08sm23720671cf.63.2024.11.21.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 07:49:37 -0800 (PST)
Date: Thu, 21 Nov 2024 10:49:29 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com, tongtiangen@huawei.com,
	Yicong Yang <yangyicong@huawei.com>,
	Niyas Sait <niyas.sait@huawei.com>, ajayjoshi@micron.com,
	Vandana Salve <vsalve@micron.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [RFC PATCH 0/4] CXL Hotness Monitoring Unit perf driver
Message-ID: <Zz9WiVaT8vMaHeTW@PC2K9PVX.TheFacebook.com>
References: <20241121101845.1815660-1-Jonathan.Cameron@huawei.com>
 <Zz9Cq4CPStYGZyt7@PC2K9PVX.TheFacebook.com>
 <20241121145852.00000460@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121145852.00000460@huawei.com>

On Thu, Nov 21, 2024 at 02:58:52PM +0000, Jonathan Cameron wrote:
> On Thu, 21 Nov 2024 09:24:43 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Nov 21, 2024 at 10:18:41AM +0000, Jonathan Cameron wrote:
> > > The CXL specification release 3.2 is now available under a click through at
> > > https://computeexpresslink.org/cxl-specification/ and it brings new
> > > shiny toys.
> > > 
> > > RFC reason
> > > - Whilst trace capture with a particular configuration is potentially useful
> > >   the intent is that CXL HMU units will be used to drive various forms of
> > >   hotpage migration for memory tiering setups. This driver doesn't do this
> > >   (yet), but rather provides data capture etc for experimentation and
> > >   for working out how to mostly put the allocations in the right place to
> > >   start with by tuning applications.
> > > 
> > > CXL r3.2 introduces a CXL Hotness Monitoring Unit definition. The intent
> > > of this is to provide a way to establish which units of memory (typically
> > > pages or larger) in CXL attached memory are hot. The implementation details
> > > and algorithm are all implementation defined. The specification simply
> > > describes the 'interface' which takes the form of ring buffer of hotness
> > > records in a PCI BAR and defined capability, configuration and status
> > > registers.
> > > 
> > > The hardware may have constraints on what it can track, granularity etc
> > > and on how accurately it tracks (e.g. counter exhaustion, inaccurate
> > > trackers). Some of these constraints are discoverable from the hardware
> > > registers, others such as loss of accuracy have no universally accepted
> > > measures as they are typically access pattern dependent. Sadly it is
> > > very unlikely any hardware will implement a truly precise tracker given
> > > the large resource requirements for tracking at a useful granularity.
> > > 
> > > There are two fundamental operation modes:
> > > 
> > > * Epoch based. Counters are checked after a period of time (Epoch) and
> > >   if over a threshold added to the hotlist.
> > > * Always on. Counters run until a threshold is reached, after that the
> > >   hot unit is added to the hotlist and the counter released.
> > > 
> > > Counting can be filtered on:
> > > 
> > > * Region of CXL DPA space (256MiB per bit in a bitmap).
> > > * Type of access - Trusted and non trusted or non trusted only, R/W/RW
> > > 
> > > Sampling can be modified by:
> > > 
> > > * Downsampling including potentially randomized downsampling.
> > > 
> > > The driver presented here is intended to be useful in its own right but
> > > also to act as the first step of a possible path towards hotness monitoring
> > > based hot page migration. Those steps might look like.
> > > 
> > > 1. Gather data - drivers provide telemetry like solutions to get that
> > >    data. May be enhanced, for example in this driver by providing the
> > >    HPA address rather than DPA Unit Address. Userspace can access enough
> > >    information to do this so maybe not.
> > > 2. Userspace algorithm development, possibly combined with userspace
> > >    triggered migration by PA. Working out how to use different levels
> > >    of constrained hardware resources will be challenging.  
> > 
> > FWIW this is what i was thinking about for this extension:
> > 
> > https://lore.kernel.org/all/20240319172609.332900-1-gregory.price@memverge.com/
> 
> Yup. I had that in mind. Forgot to actually add a link.
> 
> > 
> > At least for testing CHMU stuff. So if anyone is poking at testing such
> > things, they can feel free to use that for prototyping. However, I think
> > there is general discomfort around userspace handling HPA/DPA.
> > 
> > So it might look more like
> > 
> > echo nr_pages > /sys/.../tiering/nodeN/promote_pages
> > 
> > rather than handling the raw data from the CHMU to make decisions.
> 
> Agreed, but I think we are far away from a point where we can implement that.
> 
> Just working out how to tune the hardware to grab useful data is going
> to take a while to figure out, let alone doing anything much with it.
> 
> Without care you won't get a meaningful signal for what is actually
> hot out of the box. Lots of reasons why including:
> a) Exhaustion of tracking resources, due to looking at too large a window
>    or for too long.  Will probably need some form of auto updating of
>    what is being scanning (coarse to fine might work though I'm doubtful,
>    scanning across small regions maybe).
> b) Threshold too high, no detections.
> c) Threshold too low, everything hot.
> d) Wrong timescales. Hot is not a well defined thing.
> e) Hardware that won't do tracking at fine enough granularity.
> 

f) How does this even work with interleaving on larger pools :B
   It's pretend-addressing all the way down :D

Lots of conceptually complex and fun questions here.

~Gregory
