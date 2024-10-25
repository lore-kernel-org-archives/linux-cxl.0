Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723FDDBB;
	Fri, 25 Oct 2024 00:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729816680; cv=none; b=Qx5rgR870VX70sxCyj/hfMGXDE0JHh6AFBF9Vatb8Gi8Y8Y/crxnTHuNdUAOO55v4m+JOM6gHGOOWCGPSwv2z6r6wb0PQAndoB8d6whMAfmI0Q3zEsvHz5/hvpyMFmww/Zg/b4QW8Chl8aXObzafQG6E58IjOIjJYgedrHqcufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729816680; c=relaxed/simple;
	bh=eHPZAfwG8NkGljBkafKoc9M7hBYTkNOCs1lnbwpvDSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qg518fzsEeDqH6msWYVE2KaHGBJnwUvJu/dO6mhQTRyoP78XUVUVRCidiyE7TSvQiOLuDdl5uOMyT1VNayqqccB8nIbfAUDUemdwWDfMuH9Dz27BGGy/BT3MwHd9uvPsiiz3LeN0mB7zynQqrtY6OhcOzErn6qFFqiKZrpj55Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjZBdGR4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjZBdGR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729816678; x=1761352678;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=eHPZAfwG8NkGljBkafKoc9M7hBYTkNOCs1lnbwpvDSo=;
  b=PjZBdGR4AVvFYE+VFU/Ie8AueLrEXhBcC94AWXQBZDx3FKPDrp8C9+U1
   myQ12AzqiIE5hqJLUHCLHZXCvACyCR1l6txN1pjMc44su9yaUd4qhRv1N
   duODVv7fP4Em0V6jDxJxmel5NiPS++6DTZDbZejJC1sBJcwDlHqillipP
   HpVWx0BVUMD34T+QM3yh1qOAz/y40KcC+GyrCQ4ScZK6uiG1lLMdVxTQY
   P1V9BEU8vB/DasN+y+2bS3u2r9FSdOsx2rH40HZzlVC8TkEmiHCFSZQ3L
   Bw/mfBekhfO/j/+M1Y0erqR+3bhvh6jIp5sIWcWv0tBfCrS0OuZgUh9Yt
   Q==;
X-CSE-ConnectionGUID: X4mHj54cQyCcIhw+ZiX7+g==
X-CSE-MsgGUID: +oHGtaxSQgWjEHnL1GuMgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29694222"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="29694222"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 17:37:57 -0700
X-CSE-ConnectionGUID: JbPqYJVuTpOpdktP1jboRw==
X-CSE-MsgGUID: jnqhm2zkRJW9JS5rYDxAtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="81066461"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 17:37:54 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  David Hildenbrand
 <david@redhat.com>,  Andrew Morton <akpm@linux-foundation.org>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <linux-cxl@vger.kernel.org>,  Davidlohr Bueso <dave@stgolabs.net>,
  "Jonathan Cameron" <jonathan.cameron@huawei.com>,  Alistair Popple
 <apopple@nvidia.com>,  Bjorn Helgaas <bhelgaas@google.com>,  Baoquan He
 <bhe@redhat.com>,  Dave Jiang <dave.jiang@intel.com>,  Alison Schofield
 <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
In-Reply-To: <ZxpFQBRqWMDjhtSY@smile.fi.intel.com> (Andy Shevchenko's message
	of "Thu, 24 Oct 2024 16:01:52 +0300")
References: <20241010065558.1347018-1-ying.huang@intel.com>
	<d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
	<87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
	<671965a8b37a2_1bbc629489@dwillia2-xfh.jf.intel.com.notmuch>
	<ZxnvyIme98Q8ey1c@smile.fi.intel.com>
	<87wmhx3cpc.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZxpFQBRqWMDjhtSY@smile.fi.intel.com>
Date: Fri, 25 Oct 2024 08:34:21 +0800
Message-ID: <87o7392f76.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Thu, Oct 24, 2024 at 08:30:39PM +0800, Huang, Ying wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Wed, Oct 23, 2024 at 02:07:52PM -0700, Dan Williams wrote:
>> >> Andy Shevchenko wrote:
>> >> > On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
>> >> > > David Hildenbrand <david@redhat.com> writes:
>> >> > > > On 10.10.24 08:55, Huang Ying wrote:
>
> ...
>
>> >> > > > 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
>> >> > > 
>> >> > > Yes.  This can improve code readability.
>> >> > > 
>> >> > > A possible issue is that "_root" will be evaluated twice in above macro
>> >> > > definition.  IMO, this should be avoided.
>> >> > 
>> >> > Ideally, yes. But how many for_each type of macros you see that really try hard
>> >> > to achieve that? I believe we shouldn't worry right now about this and rely on
>> >> > the fact that root is the given variable. Or do you have an example of what you
>> >> > suggested in the other reply, i.e. where it's an evaluation of the heavy call?
>> >> > 
>> >> > > Do you have some idea about
>> >> > > how to do that?  Something like below?
>> >> > > 
>> >> > > #define for_each_resource_XXX(_root, _p)                                \
>> >> > > 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
>> >> > > 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))
>> >> > 
>> >> > This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
>> >> > solve (see above).
>> >> 
>> >> Using a local defined variable to avoid double evaluation is standard
>> >> practice. I do not understand "avoid ugliness as long as we have no problem to
>> >> solve", the problem to solve will be if someone accidentally does
>> >> something like "for_each_resource_descendant(root++, res)". *That* will
>> >> be a problem when someone finally realizes that the macro is hiding a
>> >> double evaluation.
>> >
>> > Can you explain, why do we need __p and how can we get rid of that?
>> > I understand the part of the local variable for root.
>> 
>> If don't use '__p', the macro becomes
>> 
>> #define for_each_resource_XXX(_root, _p)                                \
>> 	for (typeof(_root) __root = (_root), (_p) = (__root)->child; \
>> 	     (_p); (_p) = next_resource_XXX(__root, _p))
>> 
>> Where, '_p' must be a variable name, and it will be a new variable
>> inside for loop and mask the variable with same name outside of macro.
>> IIUC, this breaks the macro convention in kernel and has subtle variable
>> masking semantics.
>
> Yep.
>
> In property.h nobody cares about evaluation which makes the macro as simple as
>
> #define for_each_resource_XXX(_root, _p)		\
> 	for (_p = next_resource_XXX(__root, NULL); _p;	\
> 	     _p = next_resource_XXX(__root, _p))
>
> (Dan,
>  that's what I called to avoid solving issues we don't have and most likely
>  will never have.)
>
> but if you want to stick with your variant some improvements can be done:

I still prefer to solve possible issues if the solution isn't too
complex.

> #define for_each_resource_XXX(_root, _p)				\
> 	for (typeof(_root) __root = (_root), __p = _p = __root->child;	\
> 	     __p && _p; _p = next_resource_XXX(__root, _p))
>
>
> 1) no need to have local variable in parentheses;
> 2) no need to have iterator in parentheses, otherwise it would be crazy code
> that has put something really wrong there and still expect the thing to work.

Thanks!  You are right.  Will use this in the future versions.

>> >> So no, this proposal is not "ugly", it is a best practice. See the
>> >> definition of min_not_zero() for example.
>> >
>> > I know that there are a lot of macros that look uglier that this one.

--
Best Regards,
Huang, Ying
