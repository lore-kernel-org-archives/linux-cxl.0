Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D95E3128CD
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472910; cv=none; b=lwFTP+mq+lwWSR/7cjMI5MkMJyk1Ky11DW2BEC1ynf8elkeTYwcgYNXMl2oLWHsHDgAxo0s5JGdTSdBZVNTc05spihAfNpm5XOryJNnsx/oY5khRIEtll5SfvyZvRZDlYqW2vpK+hIV8B1CpEHtBL7mDqRgR2312rdqRcOBpi6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472910; c=relaxed/simple;
	bh=JInTYXtV5AUCCz6g+gaWJcphWCPdNKv9iVI2oZBYVF0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+ywWvqgCYkU8oxBlfhm2QF6MyBYY9Q3zDznqv41V+RhHIVxjST09slY90NuA/KWKB9hVaQFmcjS5iQx6IE08AsV6yKvFRDIJLlS3t6t08DPMzECFqu5/giNzPbWKXT2geO4k8g2lqtLB0Benj0EC9F5WOBJd3kovdqkvEfoMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsK1v1TgRzHnH5b;
	Thu, 15 Jan 2026 18:28:03 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id E570140584;
	Thu, 15 Jan 2026 18:28:24 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Jan
 2026 10:28:24 +0000
Date: Thu, 15 Jan 2026 10:28:19 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>,
	<dongjoo.seo1@samsung.com>
Subject: Re: [RFC PATCH 0/3] Add Support for Multiple DC Regions
Message-ID: <20260115102819.00006d55.alireza.sanaee@huawei.com>
In-Reply-To: <aWV0e03pP4hfqkLo@4470NRD-ASU.ssi.samsung.com>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
	<6931c4c85a526_43de3100bb@iweiny-mobl.notmuch>
	<aTsyJXKnL0SA1hl-@deb-101020-bm01.eng.stellus.in>
	<693c922448bbc_c04a9100eb@iweiny-mobl.notmuch>
	<aWV0e03pP4hfqkLo@4470NRD-ASU.ssi.samsung.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 12 Jan 2026 14:23:55 -0800
Anisa Su <anisa.su887@gmail.com> wrote:

Hi Anisa,

> On Fri, Dec 12, 2025 at 04:07:32PM -0600, Ira Weiny wrote:
> > Anisa Su wrote:  
> > > On Thu, Dec 04, 2025 at 11:28:40AM -0600, Ira Weiny wrote:  
> > > > anisa.su887@ wrote:  
> > > > > From: Anisa Su <anisa.su@samsung.com>
> > > > >   
> [snip] 
> > > > Unfortunately none of the details presented in this cover letter really
> > > > show why the kernel needs this additional complexity.
> > > > 
> > > > Can you go into more details on the use cases of multiple partitions?
> > > >   
> > > From what I understand, the motivation for DCD as a whole has always been a
> > > blocker for the entire series. However, this year we've seen multiple vendors
> > > demo memory pooling/sharing at SC,25[1], as well as the development of a 
> > > controller that supports "memory pooling and sharing across 
> > > multiple hosts" from Montage[2].  
> > 
> > That is great!  Do we know if they used the patches which have been
> > submitted?  Do we know if the user interfaces were sufficient?  
> 
> Sorry for the delay! While I don't know the details of the software
> stack used in those demos, I think the root of the question "Do we know
> if the user interfaces were sufficient" goes back to the missing use
> case for DCD.
> 
> So then, can I ask: how can I demonstrate a reasonable use case?
> Ex: bringing up Kubernetes pods using this patchset on real hw?
> Or something else?
> ^ This is also a question for the community, so everyone please chime in :)
> >  
> > How will this memory be presented with the new DAX changes being proposed?
> >  
> From the call today, there seemed to be general agreement that the changes
> proposed by Gregory's patches are a promising direction for DCD, bc it
> allows hotplug/unplug capabilities without needing to route it through
> the DAX subsystem.
> I haven't looked at those patches yet, but from what was
> discussed today, plan to move forward based on that. Are those the changes
> you were referring to? Or the special famfs dax type you mentioned
> below?
> > > 
> > > The flexibility and control provided by multiple partitions is
> > > an important capability of DCD for enabling composable memory 
> > > infrastructures. IMO, adding multi-partition support back in from v8 or
> > > picking up this patchset would strengthen the series.
> > > 
> > > Let me know if this proposal sounds fair? Otherwise I can
> > > separate out the 2 patches that are bug fixes.  
> > 
> > After RC1 could you rebase the series and fold the bug fixes in?
> >   
> Yep, working on rebasing the series now and will send RC2 with the bug
> fixes.
> > Before we get to multiple DCD partitions the interface for DAX devices
> > needs to be settled.  In the last community call we were discussing a
> > special famfs dax type I believe.  Has any work been done on that?
> >  
> That makes sense to me; I missed that call, so I'm not familiar with the
> famfs dax type, but as I mentioned above, it sounds like Gregory's
> patch set is a good solution to this, so I'll explore how to integrate
> with that first.
> 
> > For multi-partitions we need some review on the partition (region) names
> > because you made a change which would be incompatible with the base
> > series.  But it would be good to get single partitions landed and then
> > multiple partitions as you have added.
> >   
> Sounds good. For RC2, I'll keep it simple and just rebase + bug fixes.
Thanks Anisa. I was also about to look into the rebasing as well.
> > > Also, apologies if these points have already been discussed. I've not been
> > > following this series for very long, so forgive the ignorance as I try to
> > > catch up. If you can think of any materials/documentation outside of the
> > > mailing list or open collab sync notes that would help fill in the gaps,
> > > please let me know :)  
> > 
> > NP this has been a while.  I've been looking for someone to take the
> > series who is more familiar with the use cases.
> > 
> > I look forward to you posting a new series with the support you feel you
> > need.
> > 
> > Ira
> >   
> Thanks Ira, I will definitely have to keep bothering you, though I'll
> try to keep it to a minimum.
> 
> Thanks,
> Anisa
> 
> [snip]

