Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FF13AA2F;
	Thu, 24 Oct 2024 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729774922; cv=none; b=Fa0C/dXQAcwW1ivepoKVk0y2/bV6QwMK8j4FW0bmPSRJ6fzXzpnQEhy3FtuA5jE1M+kV/OFf13Ran/ptBvrMLC02ounR0RYUxuh7hEtfjidwhWyITsz6RcuAZK6VNEPH2f3xAW7DZLCSsVIgDN6zKGGdBO68URluZD3R3hxlX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729774922; c=relaxed/simple;
	bh=2a+9bKMv7hVzknlW8OazkLUPwrbxo5rblBY4AWBW2pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K85ZJaSxdDR/IKkWELAHAUfv243vE4M/GGc5M/ErSX6XqrZW0lEUkre0CM0Rm1AudFrw4MxtLHZueG56fG6Q02gWvDsnjeTe3wVdadpIj0ESilf86b5szTfdAJcnTWcXdiNm3+WD8ylT8fK3fxs14n3+Qv6HWv68TWAMZi0RmD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CY16NWev; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CY16NWev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729774920; x=1761310920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2a+9bKMv7hVzknlW8OazkLUPwrbxo5rblBY4AWBW2pI=;
  b=CY16NWevZLqXhEQXvK2bSE8cctLfnDvkuCnioOYL1v5/fD3YDiqwtqav
   aau4N+yyKYP3cin+80GOghhIUEsC5f2jp5wAwWkg7jfzQkqPLb6d58gXV
   ZJLA+FKaeTBWWE/m/XcPV2zmW1GN+xVsh9+FQuwgMcaUV6Fkk6G1RIwY5
   9g9uqsl/WzWJsoMSo+2urQpUwRSksW3XNcfPFFXrbOYoGhoJ2LU5yFLhc
   Ec/StMBCCyhDidJJNTfvSzsduWDf1URsGgpJ44D5AQV11RN4toTRBh0z/
   MC+mcoSZZ7fyQM0uHiTiuoRXRhvHp50K2LcILnj+aoMrQMx8xZ8G6kosC
   Q==;
X-CSE-ConnectionGUID: o0GGTXs5S4qLRfRStS2F0g==
X-CSE-MsgGUID: GSNgBoBPSRSjhG+Oz0Udcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29303306"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29303306"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:01:59 -0700
X-CSE-ConnectionGUID: Cd4N0AKgRuanQXpDlER8KQ==
X-CSE-MsgGUID: BgcMOECEQKqvDTOvgmvjfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85191643"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 06:01:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t3xTM-00000006Zui-3IcU;
	Thu, 24 Oct 2024 16:01:52 +0300
Date: Thu, 24 Oct 2024 16:01:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
Message-ID: <ZxpFQBRqWMDjhtSY@smile.fi.intel.com>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
 <671965a8b37a2_1bbc629489@dwillia2-xfh.jf.intel.com.notmuch>
 <ZxnvyIme98Q8ey1c@smile.fi.intel.com>
 <87wmhx3cpc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmhx3cpc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 24, 2024 at 08:30:39PM +0800, Huang, Ying wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Wed, Oct 23, 2024 at 02:07:52PM -0700, Dan Williams wrote:
> >> Andy Shevchenko wrote:
> >> > On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
> >> > > David Hildenbrand <david@redhat.com> writes:
> >> > > > On 10.10.24 08:55, Huang Ying wrote:

...

> >> > > > 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
> >> > > 
> >> > > Yes.  This can improve code readability.
> >> > > 
> >> > > A possible issue is that "_root" will be evaluated twice in above macro
> >> > > definition.  IMO, this should be avoided.
> >> > 
> >> > Ideally, yes. But how many for_each type of macros you see that really try hard
> >> > to achieve that? I believe we shouldn't worry right now about this and rely on
> >> > the fact that root is the given variable. Or do you have an example of what you
> >> > suggested in the other reply, i.e. where it's an evaluation of the heavy call?
> >> > 
> >> > > Do you have some idea about
> >> > > how to do that?  Something like below?
> >> > > 
> >> > > #define for_each_resource_XXX(_root, _p)                                \
> >> > > 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
> >> > > 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))
> >> > 
> >> > This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
> >> > solve (see above).
> >> 
> >> Using a local defined variable to avoid double evaluation is standard
> >> practice. I do not understand "avoid ugliness as long as we have no problem to
> >> solve", the problem to solve will be if someone accidentally does
> >> something like "for_each_resource_descendant(root++, res)". *That* will
> >> be a problem when someone finally realizes that the macro is hiding a
> >> double evaluation.
> >
> > Can you explain, why do we need __p and how can we get rid of that?
> > I understand the part of the local variable for root.
> 
> If don't use '__p', the macro becomes
> 
> #define for_each_resource_XXX(_root, _p)                                \
> 	for (typeof(_root) __root = (_root), (_p) = (__root)->child; \
> 	     (_p); (_p) = next_resource_XXX(__root, _p))
> 
> Where, '_p' must be a variable name, and it will be a new variable
> inside for loop and mask the variable with same name outside of macro.
> IIUC, this breaks the macro convention in kernel and has subtle variable
> masking semantics.

Yep.

In property.h nobody cares about evaluation which makes the macro as simple as

#define for_each_resource_XXX(_root, _p)		\
	for (_p = next_resource_XXX(__root, NULL); _p;	\
	     _p = next_resource_XXX(__root, _p))

(Dan,
 that's what I called to avoid solving issues we don't have and most likely
 will never have.)

but if you want to stick with your variant some improvements can be done:

#define for_each_resource_XXX(_root, _p)				\
	for (typeof(_root) __root = (_root), __p = _p = __root->child;	\
	     __p && _p; _p = next_resource_XXX(__root, _p))


1) no need to have local variable in parentheses;
2) no need to have iterator in parentheses, otherwise it would be crazy code
that has put something really wrong there and still expect the thing to work.

> >> So no, this proposal is not "ugly", it is a best practice. See the
> >> definition of min_not_zero() for example.
> >
> > I know that there are a lot of macros that look uglier that this one.

-- 
With Best Regards,
Andy Shevchenko


