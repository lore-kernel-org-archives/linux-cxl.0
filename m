Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B251D54DC;
	Mon,  7 Oct 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311090; cv=none; b=snn+6hdXNfKVHdrIpRykBLl/BFfD4l72IYcjByjjHeouN0vKv1/zlQsdSfIV84xf/ehMenNJhYRzal5nNH4d9k4wohdLOHwqhWtdrGelJdazvJVfbP98jzO7SlPcC6VpmSYvt/q4D5A4iAl9V/8XvYDiAxppdhUfgDdmtvXnDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311090; c=relaxed/simple;
	bh=xtD5r6R1+iAiOT5E2n5P7WbselsT4vAju7aEoR9WU7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2jYnBbBZIOvVoetxN9RBjS8PJynscFOhYtIgmNjgaVTi/iCgxt39guTC3dEKZ22FOJBkGjAmni4tjX8FAqXGSqKaQic5puinfypcVv63fPAYzaTgukcEwvb4G3Zgg9XJRYeSkTfXGxAO+qmgVYKeeAyetHt+ubSxX7sECUdrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3As6tQ6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3As6tQ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728311089; x=1759847089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xtD5r6R1+iAiOT5E2n5P7WbselsT4vAju7aEoR9WU7k=;
  b=i3As6tQ68sepqwtt+1vnF5rp+rKpQwhXsmhEfNiBX5oHPJPt4Nkpe5L8
   DFJoWbbjcpG/k310lpxQuwkiyqzUKdqXgY12Yjx5D5F+xX+LwSthYz6AL
   2LwnQV3t+TLhyF7VeRqN83jQGmVvpPfJ3DRIf0Id19hMA2qj3u8NoD03q
   5100qFwDTyYVlE+XPbY6Yes+Hl4ag6qFv/tH+vHwBYCF5Wb2+MolHiyRb
   lr4yDkviu8rEtdwd2r55ylhZdmDXYHzUjOAJM+RonHu4bYROhH+IsrZzH
   AFOXSoZCPsz2YThAnkTAxjg0wkD8DQJSteVlZVlbdsFKBO9d9vYdbrx3x
   w==;
X-CSE-ConnectionGUID: a+GtRHKtT2SPaVPK8Qr+Tw==
X-CSE-MsgGUID: OLW3yXJ4RV6MDufSlFTOiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38066724"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38066724"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:24:48 -0700
X-CSE-ConnectionGUID: GY0tNvgjRFGpfhvvU6AzHA==
X-CSE-MsgGUID: B/OfJPxKRyKdLRPqMuh9HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="106244537"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 07:24:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sxofB-00000000F60-2JO7;
	Mon, 07 Oct 2024 17:24:41 +0300
Date: Mon, 7 Oct 2024 17:24:41 +0300
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
Message-ID: <ZwPvKST69TdcaVO8@smile.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
 <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
 <874j6vc10j.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <66d8f41cb3e6_3975294f9@dwillia2-xfh.jf.intel.com.notmuch>
 <ZtmOTYF9EWPeLg5u@smile.fi.intel.com>
 <65838cc0-9a20-4994-a0ef-9cd50bb00951@redhat.com>
 <Ztmlw1q3Djn94MRQ@smile.fi.intel.com>
 <09d44b21-9739-417b-a76c-5383fcbde96b@redhat.com>
 <Ztmo_EITDSRewSka@smile.fi.intel.com>
 <922e97d9-e16a-4bb8-90b0-4bb3347174e8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <922e97d9-e16a-4bb8-90b0-4bb3347174e8@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 02:57:34PM +0200, David Hildenbrand wrote:
> On 05.09.24 14:50, Andy Shevchenko wrote:
> > On Thu, Sep 05, 2024 at 02:42:05PM +0200, David Hildenbrand wrote:
> > > On 05.09.24 14:36, Andy Shevchenko wrote:
> > > > On Thu, Sep 05, 2024 at 01:08:35PM +0200, David Hildenbrand wrote:
> > > > > On 05.09.24 12:56, Andy Shevchenko wrote:
> > > > > > On Wed, Sep 04, 2024 at 04:58:20PM -0700, Dan Williams wrote:
> > > > > > > Huang, Ying wrote:
> > > > > > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

[..]

> > > > > > > > > You may move Cc list after '---', so it won't unnecessarily pollute the commit
> > > > > > > > > message.
> > > > > > > > 
> > > > > > > > Emm... It appears that it's a common practice to include "Cc" in the
> > > > > > > > commit log.
> > > > > > > 
> > > > > > > Yes, just ignore this feedback, it goes against common practice. Cc list
> > > > > > > as is looks sane to me.
> > > > > > 
> > > > > > It seems nobody can give technical arguments why it's better than just keeping
> > > > > > them outside of the commit message. Mantra "common practice" nowadays is
> > > > > > questionable.
> > > > > 
> > > > > Just look at how patches look like in the git tree that Andrew picks up.
> > > > > (IIRC, he adds a bunch of CCs himself that are not even part of the original
> > > > > patch).
> > > > 
> > > > I know that and it's historical, he has a lot of the scripts that work and when
> > > > he moved to the Git it was another long story. Now you even can see how he uses
> > > > Git in his quilt approach. So, it's an exceptional and not usual workflow, hence
> > > > bad example. Try again :-)
> > > 
> > > Point is, it doesn't matter what we do in this patch here if Andrew will
> > > unify it at all.
> > 
> > Point is, that this is exceptional. And better to teach people based on better
> > practices, no?
> 
> "Better" in your opinion.

> I don't care

Exactly, that's what I pointed out as well to the previous reply to Dan:
it's matter of our care about number of things.

> about a couple of Cc lines in a git
> commit. They've been useful for me, apparently not for you.

I hardly can imagine how _nowadays_ this may be still useful in this form.
What I admit is the lore archive and Link tag is really useful. Much more
than bare Cc list.

> If you succeed in convincing Andrew to change it, then Andrew can fixup his
> scripts to remove all of these from the patches he sends out.

Maybe at some point in time. As you know he is the most conservative maintainer
(from tooling or workflow perspective), so it might take time, but I'm going to
do my best to convince people to look at this problem from different angles.

> > > > > Having in the git tree who was actually involved/CCed can be quite valuable.
> > > > > More helpful than get_maintainers.pl sometimes.
> > > > 
> > > > First of all, there is no guarantee they _were_ involved. From this perspective
> > > > having Link: tag instead has much more value and supports my side of arguments.
> > > 
> > > Link is certainly preferable. Usually when I fix a commit, I make sure to CC
> > > the people that are listed for the patch, because it at least should have
> > > ended up in their mailbox.
> > > 
> > > Often, it also helped to see if a buggy commit was at least CCed to the
> > > right persons without digging through mailing list archives.
> > 
> > How is it better than having it in lore.kernel.org in archives where you even
> > see who _actually_ participated in discussion, if any?
> 
> You might have to dig through multiple code revisions to find that out.

The Link tag will refer to the one that has been applied. It keeps not less
information as bare Cc list, but on top one may:

1) either put a few Link tags with versioning;
2) or refer to the previous version of the patches in the respective cover
letter.

> Again, I used this in the past quite successfully.
> 
> > Again, Cc neither in the Git commit, nor in the email guarantees the people
> > were involved. Having Cc in the commit just a big noise that pollutes it.
> > Especially I do not understand at all Cc: mailing-list@bla.bla.bla cases.
> > They are not people, they have a lot of archives besides lore.kernel.org,
> > only waste of resources in all means of that. I tried to summarize that in
> > the submitted patches to the documentation, that I referred earlier in this
> > thread to.
> 
> I, for my part, never add "Cc:" to patches or cover letters that refer to
> mailing lists. I add these manually to my git-send-email "--cc" list. I
> though Andrews script also fix that up, but I might be wrong.

I see some people / scripts? still put mailing lists to the Cc list which
comes as part of the commit messages. This is most odd part to me why.

> Anyhow, this is a discussion to be had with Andrew, not with me, so feel
> free to engage with Andrew to change is scripts to throw away all CC.

I will try, definitely.

-- 
With Best Regards,
Andy Shevchenko


