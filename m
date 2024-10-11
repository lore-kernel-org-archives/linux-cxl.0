Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B56F31E;
	Fri, 11 Oct 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643775; cv=none; b=C/wy330/Bf+GG68BVRCfE0J0TQDK94p5walLSPD2uEQX/eVeoZcF4MsN3COfzzxADXm7TjRCC6FBBm6768n0DN4kbPyKIThKkiXVUog5jD7IRn2nlEhNZmoaeYq2n7km4E8sca/PFe67EuGhBENIQG0eneK0fR2fadHd/2PZIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643775; c=relaxed/simple;
	bh=XH9y2E5yHPSSbBGvg6K2K0apjNjCYkkwGjaiDudoz1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYqDJ0EmY4svV7BTkI9QZWhAKeLvwW1eZPWg/UHnnwLCMsu2tKsRFHnlW8J6nKT0iHQeVhwAx8of/lAiGqhD1e9H/ACUDf8hTNh+2Nyr63zddJNBNrqatYAcJv/I/XsPySagVkahuZn2dB+DpiNx0zGVJhb1HTSRv1GKDlVIqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCVLUXWl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCVLUXWl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728643774; x=1760179774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XH9y2E5yHPSSbBGvg6K2K0apjNjCYkkwGjaiDudoz1U=;
  b=GCVLUXWlIK+dgYIHPTgss7A0hdM0S7/JXi05R9iQ5V0EHK7urUbqVhfE
   uo9U5wxRP+ZOVoP3Q8Q3VjtgAophf7rUuHGkPdT+jRoZCHWV0eLhwrMhS
   /knJMr/5bk2IL+Uty/Ll2Y177QwPgojBFzZN61cHAt+kLWlVw5NN2Yvjp
   FWRob9vEJpPoM5W8SdFki/VsltegYW1vgnTV2yF0tmkHlx5rzvCvwivBA
   Tpng1CYTaTeII4pFAHxcu33FHYKj7x64jb16ZvlTNarhVaSCJa5ZTt36h
   xPHeignNXrUCdkjV1SFOCKKE6SLH3GzjV3Lc1S9aJpSBO03WvTKhFin/d
   w==;
X-CSE-ConnectionGUID: TePsHd3wTIqcjOIIGQgp5g==
X-CSE-MsgGUID: zoYcwusUSr6CP86QVo9N5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27909893"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="27909893"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:49:33 -0700
X-CSE-ConnectionGUID: 7/ZcGODLQUWBwWhh7JtSpA==
X-CSE-MsgGUID: Kg5MiDyFRtSq+ak0B7s8Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="76984507"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:49:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1szDD5-00000001reQ-1m08;
	Fri, 11 Oct 2024 13:49:27 +0300
Date: Fri, 11 Oct 2024 13:49:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
Message-ID: <ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
References: <20241010065558.1347018-1-ying.huang@intel.com>
 <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
 <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> > On 10.10.24 08:55, Huang Ying wrote:

...

> > 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
> 
> Yes.  This can improve code readability.
> 
> A possible issue is that "_root" will be evaluated twice in above macro
> definition.  IMO, this should be avoided.

Ideally, yes. But how many for_each type of macros you see that really try hard
to achieve that? I believe we shouldn't worry right now about this and rely on
the fact that root is the given variable. Or do you have an example of what you
suggested in the other reply, i.e. where it's an evaluation of the heavy call?

> Do you have some idea about
> how to do that?  Something like below?
> 
> #define for_each_resource_XXX(_root, _p)                                \
> 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
> 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))

This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
solve (see above).

> > XXX TBD
> >
> > Or do you think this should not only be "improved" for the __region_intersects() use case
> > but for all for_each_resource() users? I cannot tell easily.
> 
> I prefer to make for_each_resource() to traverse only descendant
> resource tree of "_root".  This helps code reusing and make the
> interface easier to be understood.  The difficulty lies in twice
> evaluation as above.

-- 
With Best Regards,
Andy Shevchenko


