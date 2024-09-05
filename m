Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90A19B589;
	Thu,  5 Sep 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540623; cv=none; b=lBNQVBvRAxy3Bi1wWA+K5L73taBZKRCwNDbWPVZvaAiMQdXaY0w+W9S5CBv0Vx/d1UNhJRtXORUivPYQNVnork5XoUgRp3JcHyQeX0bArhubxPPOLQ6sGAwD5F0xAybiigKkQrJwCJWUnMH91H1ABVpnzBQjjFqvRGp84407o8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540623; c=relaxed/simple;
	bh=KGYsF/SRHemHh4EJhmdtbUuBR3GMDFjHUBP96dHDS1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4q+TEpThBxWH2/7erjWuBklKMSCsHfaC6tgVsEATacLjX/lHZp4RigzWxLLxQvGi6KzWvo/gKUjD5hsWQm0wSxgV732lDaomdxK6Thwj/RMgNZ98/8Mn/kotlJdMkpYnWhpM8/9+7eX4mROk8GF8gopfdXrLN/WCsGkKyFYcVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMPUdyvQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMPUdyvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725540622; x=1757076622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KGYsF/SRHemHh4EJhmdtbUuBR3GMDFjHUBP96dHDS1E=;
  b=KMPUdyvQWpVgrV3bq1GM/4F8No2rGc/3FQxYWKQ0NsjVwF+qDDigPOJy
   zO7BolCUs47j9JAlwFKqMEZ6zfH00200RwWM+FeOQuwpw9YNLOmTzcLOu
   B/Wbds+XxUURX5a4bdJ0x3sEDv/bQr435yqAfYi4VsXRehMBknZ1eCAUj
   Vj1ZcayHayb1Duezlr3wO2ucDcwDOgeZrLrP+pJ5No+YxNkFO4NW7zs73
   yh6Tdt1OeDmQuuXeMDikYLEEgzPTmYCikHU7US/kLXoquJQsIGOZq/R4g
   00AJ9bsB5HAYR1htylxxQg4HpYerG0ngSy/cvK2B1bMNg5r0p0Q/O7t/E
   w==;
X-CSE-ConnectionGUID: 2eomuSZ9SDieUuxquge34Q==
X-CSE-MsgGUID: 8QBbN0iTTG2ZEJI/t+dF8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="28142003"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="28142003"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:50:14 -0700
X-CSE-ConnectionGUID: jO07qKfISP+G9wXxcLjZNg==
X-CSE-MsgGUID: SJZXvzrVS0SvG8f4yIitww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="88856711"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 05:50:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smBw4-00000005Ogg-3jxN;
	Thu, 05 Sep 2024 15:50:04 +0300
Date: Thu, 5 Sep 2024 15:50:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <Ztmo_EITDSRewSka@smile.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
 <65838cc0-9a20-4994-a0ef-9cd50bb00951@redhat.com>
 <Ztmlw1q3Djn94MRQ@smile.fi.intel.com>
 <09d44b21-9739-417b-a76c-5383fcbde96b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d44b21-9739-417b-a76c-5383fcbde96b@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 02:42:05PM +0200, David Hildenbrand wrote:
> On 05.09.24 14:36, Andy Shevchenko wrote:
> > On Thu, Sep 05, 2024 at 01:08:35PM +0200, David Hildenbrand wrote:
> > > On 05.09.24 12:56, Andy Shevchenko wrote:
> > > > On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
> > > > > Huang, Ying wrote:
> > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

[..]

> > > > > > > You may move Cc list after '---', so it won't unnecessarily pollute the commit
> > > > > > > message.
> > > > > > 
> > > > > > Emm... It appears that it's a common practice to include "Cc" in the
> > > > > > commit log.
> > > > > 
> > > > > Yes, just ignore this feedback, it goes against common practice. Cc list
> > > > > as is looks sane to me.
> > > > 
> > > > It seems nobody can give technical arguments why it's better than just keeping
> > > > them outside of the commit message. Mantra "common practice" nowadays is
> > > > questionable.
> > > 
> > > Just look at how patches look like in the git tree that Andrew picks up.
> > > (IIRC, he adds a bunch of CCs himself that are not even part of the original
> > > patch).
> > 
> > I know that and it's historical, he has a lot of the scripts that work and when
> > he moved to the Git it was another long story. Now you even can see how he uses
> > Git in his quilt approach. So, it's an exceptional and not usual workflow, hence
> > bad example. Try again :-)
> 
> Point is, it doesn't matter what we do in this patch here if Andrew will
> unify it at all.

Point is, that this is exceptional. And better to teach people based on better
practices, no?

> > > Having in the git tree who was actually involved/CCed can be quite valuable.
> > > More helpful than get_maintainers.pl sometimes.
> > 
> > First of all, there is no guarantee they _were_ involved. From this perspective
> > having Link: tag instead has much more value and supports my side of arguments.
> 
> Link is certainly preferable. Usually when I fix a commit, I make sure to CC
> the people that are listed for the patch, because it at least should have
> ended up in their mailbox.
> 
> Often, it also helped to see if a buggy commit was at least CCed to the
> right persons without digging through mailing list archives.

How is it better than having it in lore.kernel.org in archives where you even
see who _actually_ participated in discussion, if any?

Again, Cc neither in the Git commit, nor in the email guarantees the people
were involved. Having Cc in the commit just a big noise that pollutes it.
Especially I do not understand at all Cc: mailing-list@bla.bla.bla cases.
They are not people, they have a lot of archives besides lore.kernel.org,
only waste of resources in all means of that. I tried to summarize that in
the submitted patches to the documentation, that I referred earlier in this
thread to.

-- 
With Best Regards,
Andy Shevchenko


