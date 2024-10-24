Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD106F305;
	Thu, 24 Oct 2024 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753042; cv=none; b=HiocZ1XqOxqWt+Ekn8a9uQN64xWu8YEYA9XUNB+5VaCnn+UAPW4J2njTccvxc8BQ7eeEI216LezoSIm/Pd6aGah4exBHj7psRdK5D+Sx/n/hAC35ZmejVaOBxReEx0HxXC+rwV800WvxuEgYWM64cCKV77ssW6qCW7rYt2zgrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753042; c=relaxed/simple;
	bh=HEG5AppcH8Omlqn6dqBEOOVtSw/qmfp62vOEhiOJa7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTNB+O01MUT8MpNxedPvYkagmX3/4JMMdZnzuv5cO1H9i6vSGfSWLJ5HHFWiuJu7nhBUaQBsBzz1QpsLo6I0BciRlNVBv6VZhBxByfQMO0CXop8G6Q2lqjWQW6Ozh7uYuv/BEnu38hmNPVl2pCD+9TIjckmaTtJ3SXEYfIi8we8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hbm0gELR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hbm0gELR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729753040; x=1761289040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HEG5AppcH8Omlqn6dqBEOOVtSw/qmfp62vOEhiOJa7A=;
  b=Hbm0gELRY9GpkaKmeCP0QyJk7eorP/O3ys77suJrrdhhZ4YtXhN9AWsy
   LwNT8vfUGUC8GDhlavEMLfRd1iXQrmLeWpE+CE6cxeJWgfxd0bYgCd7nH
   4duZ27uDopCXPVhu/3I+3uaZC7/1fsLrsx1YVtYJM6GCv7QRgphykizyU
   kXFyMyplwGEymG3ay8biAs7ouUN/RrUyqTrs+NtpibWq+krc4//00BW3h
   Xi8vBvOSegpIP+wOOMrReE3XhHutf2s3TI80DWdhGYKrvl4TbemYhD68k
   YhMomAp75HbH4HY9SAILMKFsWTxddn9cZL8MZ8/gmkmC/LvOQKIAQc2wK
   A==;
X-CSE-ConnectionGUID: d5y5aeOGROiaYB9Wpg939w==
X-CSE-MsgGUID: W8vsASeZRJqWL7X9OUxgmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="39979952"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="39979952"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 23:57:19 -0700
X-CSE-ConnectionGUID: Sd9fHMOjSUOoo2kjypeU7g==
X-CSE-MsgGUID: yNoH64OFRuW/PaET0dNstg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80160070"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 23:57:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t3rmS-00000006Tym-1cq6;
	Thu, 24 Oct 2024 09:57:12 +0300
Date: Thu, 24 Oct 2024 09:57:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
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
Message-ID: <ZxnvyIme98Q8ey1c@smile.fi.intel.com>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
 <671965a8b37a2_1bbc629489@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <671965a8b37a2_1bbc629489@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 23, 2024 at 02:07:52PM -0700, Dan Williams wrote:
> Andy Shevchenko wrote:
> > On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
> > > David Hildenbrand <david@redhat.com> writes:
> > > > On 10.10.24 08:55, Huang Ying wrote:

...

> > > > 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
> > > 
> > > Yes.  This can improve code readability.
> > > 
> > > A possible issue is that "_root" will be evaluated twice in above macro
> > > definition.  IMO, this should be avoided.
> > 
> > Ideally, yes. But how many for_each type of macros you see that really try hard
> > to achieve that? I believe we shouldn't worry right now about this and rely on
> > the fact that root is the given variable. Or do you have an example of what you
> > suggested in the other reply, i.e. where it's an evaluation of the heavy call?
> > 
> > > Do you have some idea about
> > > how to do that?  Something like below?
> > > 
> > > #define for_each_resource_XXX(_root, _p)                                \
> > > 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
> > > 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))
> > 
> > This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
> > solve (see above).
> 
> Using a local defined variable to avoid double evaluation is standard
> practice. I do not understand "avoid ugliness as long as we have no problem to
> solve", the problem to solve will be if someone accidentally does
> something like "for_each_resource_descendant(root++, res)". *That* will
> be a problem when someone finally realizes that the macro is hiding a
> double evaluation.

Can you explain, why do we need __p and how can we get rid of that?
I understand the part of the local variable for root.

> So no, this proposal is not "ugly", it is a best practice. See the
> definition of min_not_zero() for example.

I know that there are a lot of macros that look uglier that this one.

-- 
With Best Regards,
Andy Shevchenko


