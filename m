Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E8194C62;
	Mon, 21 Oct 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510847; cv=none; b=rHN1Xt+rlRiBsY9H2w/PhAf0xvo7zxaHWMgHP0HkSKL82Z4MZtWUujY0MGCRaZhmsWRQJkGSw8612VqfOqdXVhaFoHMjAchWpQ+JHwvC1PUHDdMKzMleENGW9/HHzbOVqeQh1EiVw23OLOShR5fHweLWaDFvA5Pnq/AeiNsw1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510847; c=relaxed/simple;
	bh=8Iadp4bWHhj0Kd6k/j8Sc3MrKmXOesrWaJNzvrhJuIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JVY0z8hr0rOhm08bKjdK6WmcfIt5omfJukrKGiwMb4UplnbC4ncdad7nvCkwZKbT78u72P8FeurcFx1UUi3vo+EY1QtmaXqT1bQx05z6nT7ZHYj0xWJWUxyhK2reCsn8KTIda39fA1U/F8cY9tQbMb4GksPk5W69LywrRoX1/wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HbJ8oGmk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HbJ8oGmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729510844; x=1761046844;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8Iadp4bWHhj0Kd6k/j8Sc3MrKmXOesrWaJNzvrhJuIQ=;
  b=HbJ8oGmkzmwS6mUz1PkT+Ah659AvBWQMxyn3qGS0JCn/M/xM9kh7xCNH
   ITOquOU/a8jcPPk6CeqdGXpHJU576bR1W1+CmpCrycbadrcYechbN7EC+
   lDTcpId1tRrlZmXo6951D3s2a8sTkqJdFNLJNcCgwZmEGY+64Cng6jdUx
   eb2M+lEoTrrBXR7GLHYCZtLQOrAgehedoTcusFKdfh0eW2PfLAkb6YE1D
   W7zKx6QoCYWUgssfai0F8Svz5bF4rs/SQNEU87MYIrjbVzijjmChsMweW
   WOdI2JWoCDU8GdwrKO/PLXBuWicSdKtLgQWRADJogucBh1j8dh1/WxNJG
   A==;
X-CSE-ConnectionGUID: VW4eyL7JRhK3WB9kMbs9xw==
X-CSE-MsgGUID: VojI9GNyQmSDymWdVySC8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="46481167"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="46481167"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 04:40:43 -0700
X-CSE-ConnectionGUID: pkZPGOB1R8afZ+qN8ekyFg==
X-CSE-MsgGUID: D2VOcCFtQbqj1D62QCemHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79654695"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 04:40:40 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Alejandro Lucero Palau <alucerop@amd.com>,  Dan Williams
 <dan.j.williams@intel.com>,  Dave Jiang <dave.jiang@intel.com>,
  <linux-cxl@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  Gregory
 Price <gourry@gourry.net>,  Davidlohr Bueso <dave@stgolabs.net>,  Alison
 Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  "Ira Weiny" <ira.weiny@intel.com>,  Ben
 Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 5/5] cxl: Avoid to create dax regions for type2
 accelerators
In-Reply-To: <20241018105757.00003928@Huawei.com> (Jonathan Cameron's message
	of "Fri, 18 Oct 2024 10:57:57 +0100")
References: <20241015065713.308671-1-ying.huang@intel.com>
	<20241015065713.308671-6-ying.huang@intel.com>
	<d5233135-9d70-9080-c7eb-0906f07e5104@amd.com>
	<87jze76y4r.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ea8afddb-9e97-98f6-b1ee-b5394d35e8c0@amd.com>
	<87frov6uh7.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20241018105757.00003928@Huawei.com>
Date: Mon, 21 Oct 2024 19:37:07 +0800
Message-ID: <87iktl661o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Jonathan,

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Thu, 17 Oct 2024 15:48:04 +0800
> "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> Alejandro Lucero Palau <alucerop@amd.com> writes:
>> 
>> > On 10/17/24 07:29, Huang, Ying wrote:  
>> >> Hi, Alejandro,
>> >>
>> >> Alejandro Lucero Palau <alucerop@amd.com> writes:
>> >>  
>> >>> I did comment on this some time ago and I'm doing it again.
>> >>>
>> >>>
>> >>> This is originally part of the type2 patchset, and I'm keeping it in
>> >>> V4. I do not understand why you pick code changes (you explicitly said
>> >>> that in the first RFC) from there and use it here, and without
>> >>> previous discussion about this necessity in the list. I do not think
>> >>> this is usual, at least in other kernel subsystems I'm more familiar
>> >>> with, so I will raise this in today's cxl open source collaboration
>> >>> sync.  
>> >> No.  I picked this change from Dan's series as follows,
>> >>
>> >> https://eclists.intel.com/sympa//arc/linux-bkc/2024-10/msg00018.html
>> >>
>> >> So, I added co-developed-by and signed-off-by of Dan.
>> >>
>> >> IIUC, your picked this change from Dan's series too?  
>> >
>> >
>> > Look, this is not going well.
>
> Hi Alejandro + Huang, Ying
>
> This seems to be an unfortunate case of disconnected work on the same
> large problem and shows the need for more coordination.
> Note these are my personal responses to this, other maintainers and
> community members may well disagree!
>
> Alejandro had already clearly adopted the patches from Dan and taken a
> number of them forwards as part of his patch set.  That had
> happened before Huang, Ying posted the RFC (which referenced
> Alejandro's work along side Dan's original series).
>
> The idea of trying to accelerate the process of upstreaming type 2
> support by merging a few low hanging fruit is certainly one I think
> we can all get behind.  However, it needs some coordination to avoid
> actually slowing down overall progress by both causing spread out
> reviews and divergence in direction + churn in the base on which
> the fuller sets are built. So Huang, Ying please work with Alejandro
> rather than continuing to evolve this set independently.

IMHO, it may be better to continue to review this small series and make
it ready to be merged (or dropped) ASAP?  I can put it as a high
priority task.  After all, this series begins with code or ideas from
Dan.

However, this is only my personal opinion, if community thinks that it
isn't a good idea, I can drop this series, at least the part that
duplicates with Alejandro's series.

> Perhaps an initial step would be to figure out how to reorder Alejandro's
> series so that any work duplicated by this set is pulled to the front.
> That should make it easy to identify and discuss differences that
> have resulted from review of this series. At that point we can focus
> the review on those patches as the rest of the set continues to evolve.
> However, I would  strongly suggest coordinating that work in order to
> avoid churning the code when Alejandro may be near to posting a new
> version of his fuller series.
> 
> Whilst the precise way we have ended up with two sets changing the same
> code is unusual it is extremely common for multiple people to be working
> on the same code and coordination to be needed.  Many of the regular
> sync calls / discord channels / irc etc are used to figure out how
> this can be done efficiently.  Please use those channels here.

Yes.  More coordination is good.

> If it would be useful to have an additional call or similar to ensure
> a fruitful collaboration then we can set one up.
>
> Finally I'll note that I'd have expected to see explicit discussion of
> how this series relates to Alejandro's set and a suggestion of how to
> move forwards in the cover letter and that would perhaps have either
> resolved Alejandro's concerns or at least publicly shown awareness of the
> issues this would cause for his work.
>
> Irrespective of the other reasons for such an intro text, whilst the
> CXL maintainers were at least somewhat aware, we always appreciate
> a reminder in a cover letter!
>
> Jonathan
>
>
>> >
>> >
>> > You specifically said in your first patchset you considered the type2
>> > support patchset complete but too large or complex, so you were taking
>> > parts of it as a prelude for making it easier to review/accept. Just
>> > face that and not twist the argument.  
>> 
>> Although I listed your patchset in my cover letter.  All changes I
>> picked was from Dan's patchset instead of yours.  And, I kept Dan's
>> co-developed-by and signed-off-by.  If you will pick changes from Dan,
>> please do that too.
>> 
>> > FWIW, I'm against you doing so because:
>> >
>> >
>> > 1) You should have commented in the type2 patchset about your concern,
>> > and gave advice about doing such a prelude (by me) or offer yourself
>> > for doing it.
>> >
>> > 2) Just following your approach, anyone could do the same for any
>> > patchset sent to the list. This is not a good precedent.
>> >
>> > 3) If this is going to be allowed/approved, I'm not going to be
>> > comfortable within this community. If it is just me, I guess it will
>> > not be a big loss.
>> >
>> >
>> > None has commented yet except you and me, what I do not know if it is
>> > because this is a nasty discussion they do not want to get entangle
>> > with, or because they just think your approach is OK. If not further
>> > comment and your patchset is accepted, nothing else will be needed to
>> > say.
>> >
>> >  
>> >> Feel free to include this change in your series.  If your patchset is
>> >> merged firstly, I will rebase on yours and drop this change.
>> >>
>> >> [snip]  
>> 

--
Best Regards,
Huang, Ying
