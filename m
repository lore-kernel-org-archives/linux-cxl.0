Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE0E1EABBB
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184010; cv=none; b=aRLEb7toG7CBLwQX1Vbr3cCzQdPK+vDouLjIQ5LD4PhTiqHgHWyxWrq6vlvSMsrKnAToJsUY/dCdsKaS8wOifr/zpCkeJWQ+5b7a5aMgoDvNLyeC9j0p5cf4apDsyZBdW3J2JQs1a6xiHR2TZvcjCzn38wCHKooDtsu/flod9yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184010; c=relaxed/simple;
	bh=80Of5ArVRKyyD1s+HGBjhgypZK15MJfv5zszdTTT4NI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqflNHvDBETUhh/6u+cpeL07fOxMphnn6qkV4+axbi2Xa7H0QaalHCjp9u34MJ3lP5OBdXYXmkChBPH1bqFP6+9n7F2kHgC9gjBQcAEQSHaJZ/ecl1euca7ax7FT+H5Rssc8Nd2bz4ixaPYG2RxCJUx2sZuKwRLQgynh6KXfyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTv4T5LTSz6K6lM;
	Fri, 18 Oct 2024 00:51:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 611111400DB;
	Fri, 18 Oct 2024 00:53:22 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 18:53:21 +0200
Date: Thu, 17 Oct 2024 17:53:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Fontenot, Nathan" <nafonten@amd.com>
CC: Nathan Fontenot <nathan.fontenot@amd.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC] cxl: Update Soft Reserved resources upon region creation
Message-ID: <20241017175320.000023e5@Huawei.com>
In-Reply-To: <45f3d3e7-4145-4bc9-96bb-98d7c10c35e0@amd.com>
References: <20241004181754.8960-1-nathan.fontenot@amd.com>
	<20241016164324.000037b9@Huawei.com>
	<45f3d3e7-4145-4bc9-96bb-98d7c10c35e0@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 09:49:01 -0500
"Fontenot, Nathan" <nafonten@amd.com> wrote:

> Hi Jonathan,
Hi Nathan,
> 
> On 10/16/2024 10:43 AM, Jonathan Cameron wrote:
> > On Fri, 4 Oct 2024 13:17:54 -0500
> > Nathan Fontenot <nathan.fontenot@amd.com> wrote:
> >   
> >> Update handling of SOFT RESERVE iomem resources that intersect with
> >> CXL region resources to remove the intersections from the SOFT RESERVE
> >> resources. The current approach of leaving the SOFT RESERVE
> >> resource as is can cause failures during hotplug replace of CXL
> >> devices because the resource is not available for reuse after
> >> teardown.  
> > Good to give an example here + any debug error messages etc.  
> 
> Good point. I'll include a better explanation of the failure with examples
> in the next version.

Thanks
> 
> >   
> >>
> >> The approach sought is to trim out any pieces of SOFT RESERVE
> >> resources that intersect with CXL regions. To do this, first set
> >> aside any SOFT RESERVE resources that intersect with a CFMWS
> >> into a separate resource tree during e820__reserve_resources_late()
> >> that would have been otherwise added to the iomem resource tree.
> >>
> >> As CXL regions are created the cxl resource created for the new
> >> region is used to trim intersections from the SOFT RESERVE
> >> resources that were previously set aside.
> >>
> >> The next steps are to add any SOFT RESERVE resources remaining to the
> >> iomem resource tree after CXL device probe completes and to notify
> >> the dax driver so it may consume the added SOFT RESERVE resources.
> >>
> >> This patch includes the use of a delayed work queue to wait
> >> for CXL device probe completion and then have a worker thread add
> >> any remaining SOFT RESERVE resources to the iomem resource tree.
> >>
> >> Not in this patch is notification of the dax driver so it may consume
> >> the SOFT RESERVE resources.
> >>
> >> The goal of presenting this RFC is to drive discussion of the
> >> current approach for trimming SOFT RESERVE resources, the use of
> >> a delayed work queue to add remaining SOFT RESERVE resources to
> >> the iomem resource tree, and methods for notifying the dax driver
> >> of any newly added SOFT RESERVE resources.
> >>
> >> NOTE: As this is a RFC the temporary pr_err("CXL DEBUG...")  messages
> >> have been left in to aid in testing and validation.
> >>
> >> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
> >> Signed-off-by: Alison Schofield <alison.schofield@intel.com>  
> > 
> > Trivial, but why Alison's SoB?  She didn't send the patch which would
> > be normal reason for last SoB in a list like this (handling of the patch).
> > 
> > Maybe a Co-developed-by is missing?  
> 
> Alison helped develop the code so a Co-developed-by should be here.
> 
> > 
> > Whilst I appreciate this is an RFC, the arch specific bleed
> > into CXL code needs to go.  + we need some info here on whether this
> > is an x86 specific issue.  I'm fairly sure it's not and that should
> > be called out as future work.  
> 
> As far as I know this is an x86 issue for handling the SOFT RESERVE
> resources, if other arches are seeing this than we need to update the approach.

Hmm. I've not fully understood where it is tripping up in the x86 code.
Any EFI table using arch (arm64 etc) has soft reserved handling so
a bios doing CXL enumeration might have chosen to mark the CXL memory
with that.  

The rest of us just don't bounce through the ancient history of e820,

It's more than possible that other architectures don't care that
it was previously soft reserved on hotplug paths. I'm not sure.
I guess I could hack a test but it will be a while...

> 
> > 
> > Also, much of this is actually generic, with only a few bits
> > being e820 related.  Can we pull the soft reserve list etc out
> > of them into generic code.  
> 
> Yes, we could do that. The handling of the soft reserve list doesn't
> need to live in the e820 code.
> 
> > 
> > To me the general approach seems reasonable but I'd suggest +CC linux-mm
> > as the issue maybe more about the impacts on DAX than this working for CXL.  
> 
> ok, I'll add linux-mm. One of the pieces I wanted to get feedback on was the
> dax component and how we could invoke the dax driver to consume any soft
> reserves that remain after the cxl driver removes intersecting cxl region
> resources.

Understood.  That bit I can't help with and we all know everyone else
will back away faster than Dan Williams :)

 

> >   
> >> +	up_write(&cxl_sr_rwsem);
> >> +}
> >> +
> >> +DECLARE_DELAYED_WORK(cxl_sr_work, cxl_sr_update);
> >> +
> >> +static void schedule_soft_reserve_update(void)
> >> +{
> >> +	static bool update_scheduled;
> >> +	int timeout = 5 * HZ;
> >> +
> >> +	down_write(&cxl_sr_rwsem);  
> > For the locks use guard()  
> 
> Yes can switch to guard().
> 
> > 
> > However, what are they for?  
> 
> The concern is that we could have races on scheduling the soft reserve updates
> and I wanted to try to keep only one work item on the queue. They may not be
> needed, I was erring on the side of safety

You only have one item, so it can't be there twice.  If the aim is to protec
that one item then maybe this makes sense.

Jonathan
  

