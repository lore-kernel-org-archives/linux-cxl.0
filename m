Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F0168C3F;
	Fri, 18 Oct 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245486; cv=none; b=RNhrKpnPGEIKHBySy1659nvWXFwXiVVAjPzz4kpntMImTtyePkaCINZRYSk0Jf3opryB1oWlpYn0FlaMohyA0bXCWnrq+0Fufbalgr85RE3EFIVBDTvkbw9HI0qgFG4w1mwvzIn5/qFdFfyq3wAhvflK6ty/nHGSVyjmCHtSicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245486; c=relaxed/simple;
	bh=ka8Nvo6/kqXGj8zrrQhIAhfQxs5t1P3LjstYLejwvHY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRj0kgIK/OmvoXwZSrBdaEGDz1Cl9zNIB74q0fcTgNnmdisSnln3afv6WwmoPHKsZeuEZS+YiU5u7i1hoa10XCnTMMyBm/tN1REfJsoia45c/0bBYSh/TI0pmawiu7RQbzL4fSTYmmzCRmXB2j4/gNd7DgMOvCL15Mk2g9joehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XVKqy0p7xz6JB57;
	Fri, 18 Oct 2024 17:57:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BD022140B3C;
	Fri, 18 Oct 2024 17:58:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 18 Oct
 2024 11:58:00 +0200
Date: Fri, 18 Oct 2024 10:57:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, Davidlohr Bueso <dave@stgolabs.net>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 5/5] cxl: Avoid to create dax regions for type2
 accelerators
Message-ID: <20241018105757.00003928@Huawei.com>
In-Reply-To: <87frov6uh7.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20241015065713.308671-1-ying.huang@intel.com>
	<20241015065713.308671-6-ying.huang@intel.com>
	<d5233135-9d70-9080-c7eb-0906f07e5104@amd.com>
	<87jze76y4r.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ea8afddb-9e97-98f6-b1ee-b5394d35e8c0@amd.com>
	<87frov6uh7.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

On Thu, 17 Oct 2024 15:48:04 +0800
"Huang, Ying" <ying.huang@intel.com> wrote:

> Alejandro Lucero Palau <alucerop@amd.com> writes:
> 
> > On 10/17/24 07:29, Huang, Ying wrote:  
> >> Hi, Alejandro,
> >>
> >> Alejandro Lucero Palau <alucerop@amd.com> writes:
> >>  
> >>> I did comment on this some time ago and I'm doing it again.
> >>>
> >>>
> >>> This is originally part of the type2 patchset, and I'm keeping it in
> >>> V4. I do not understand why you pick code changes (you explicitly said
> >>> that in the first RFC) from there and use it here, and without
> >>> previous discussion about this necessity in the list. I do not think
> >>> this is usual, at least in other kernel subsystems I'm more familiar
> >>> with, so I will raise this in today's cxl open source collaboration
> >>> sync.  
> >> No.  I picked this change from Dan's series as follows,
> >>
> >> https://eclists.intel.com/sympa//arc/linux-bkc/2024-10/msg00018.html
> >>
> >> So, I added co-developed-by and signed-off-by of Dan.
> >>
> >> IIUC, your picked this change from Dan's series too?  
> >
> >
> > Look, this is not going well.

Hi Alejandro + Huang, Ying

This seems to be an unfortunate case of disconnected work on the same
large problem and shows the need for more coordination.
Note these are my personal responses to this, other maintainers and
community members may well disagree!

Alejandro had already clearly adopted the patches from Dan and taken a
number of them forwards as part of his patch set.  That had
happened before Huang, Ying posted the RFC (which referenced
Alejandro's work along side Dan's original series).

The idea of trying to accelerate the process of upstreaming type 2
support by merging a few low hanging fruit is certainly one I think
we can all get behind.  However, it needs some coordination to avoid
actually slowing down overall progress by both causing spread out
reviews and divergence in direction + churn in the base on which
the fuller sets are built. So Huang, Ying please work with Alejandro
rather than continuing to evolve this set independently.

Perhaps an initial step would be to figure out how to reorder Alejandro's
series so that any work duplicated by this set is pulled to the front.
That should make it easy to identify and discuss differences that
have resulted from review of this series. At that point we can focus
the review on those patches as the rest of the set continues to evolve.
However, I would  strongly suggest coordinating that work in order to
avoid churning the code when Alejandro may be near to posting a new
version of his fuller series.

Whilst the precise way we have ended up with two sets changing the same
code is unusual it is extremely common for multiple people to be working
on the same code and coordination to be needed.  Many of the regular
sync calls / discord channels / irc etc are used to figure out how
this can be done efficiently.  Please use those channels here.

If it would be useful to have an additional call or similar to ensure
a fruitful collaboration then we can set one up.

Finally I'll note that I'd have expected to see explicit discussion of
how this series relates to Alejandro's set and a suggestion of how to
move forwards in the cover letter and that would perhaps have either
resolved Alejandro's concerns or at least publicly shown awareness of the
issues this would cause for his work.

Irrespective of the other reasons for such an intro text, whilst the
CXL maintainers were at least somewhat aware, we always appreciate
a reminder in a cover letter!

Jonathan


> >
> >
> > You specifically said in your first patchset you considered the type2
> > support patchset complete but too large or complex, so you were taking
> > parts of it as a prelude for making it easier to review/accept. Just
> > face that and not twist the argument.  
> 
> Although I listed your patchset in my cover letter.  All changes I
> picked was from Dan's patchset instead of yours.  And, I kept Dan's
> co-developed-by and signed-off-by.  If you will pick changes from Dan,
> please do that too.
> 
> > FWIW, I'm against you doing so because:
> >
> >
> > 1) You should have commented in the type2 patchset about your concern,
> > and gave advice about doing such a prelude (by me) or offer yourself
> > for doing it.
> >
> > 2) Just following your approach, anyone could do the same for any
> > patchset sent to the list. This is not a good precedent.
> >
> > 3) If this is going to be allowed/approved, I'm not going to be
> > comfortable within this community. If it is just me, I guess it will
> > not be a big loss.
> >
> >
> > None has commented yet except you and me, what I do not know if it is
> > because this is a nasty discussion they do not want to get entangle
> > with, or because they just think your approach is OK. If not further
> > comment and your patchset is accepted, nothing else will be needed to
> > say.
> >
> >  
> >> Feel free to include this change in your series.  If your patchset is
> >> merged firstly, I will rebase on yours and drop this change.
> >>
> >> [snip]  
> 
> --
> Best Regards,
> Huang, Ying
> 

