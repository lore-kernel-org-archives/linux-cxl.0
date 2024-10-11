Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404620B214;
	Fri, 11 Oct 2024 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636723; cv=none; b=sP5EytVsvJjAKf5PnwR0QTK58kn/UbSAQu00xG4CZPBVfUm1lFE67bjYhzv5571OFxj9MBaGjen/QIWUfG0uww898WGZHiAZAxjsknUGnVjA/sA9+sN2+Ce9x5M/sBlyTMEDLjo51zRZJ4beRa5UUrzDx+dzM1t+fZRL/q2zDlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636723; c=relaxed/simple;
	bh=uMFBtSJwpjFyt4XPOYTWRjCnEGz3qayb9sH9HP8Kf+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q6rmttw7jrjENEi7QWebdlWlTYETC7DU5ZGIZb9iKbC2QjBYpBfvNUPkefH8Yul1CMS7ud99CRiGN/5bTmpCT0hTApCeCOLN07VsHs6tNSVX2GEcGZdrG6x+AVvxpdltUpg/l8L57N8tBwqmwc1yxYk47JdCSFw4RaI0mpmAR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mysXs1LR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mysXs1LR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728636723; x=1760172723;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uMFBtSJwpjFyt4XPOYTWRjCnEGz3qayb9sH9HP8Kf+A=;
  b=mysXs1LRGK/x/RqU1ZqNTYe5SMZETjAOszee4s3zI0N4GsTiUXIlmD6h
   u6vUj4w30v/fh+2MIwrdgTB8xpLCSFBAHmnN/X1CfGM63TYd7bJQ0b9BB
   Mr0yiSu6p67redzFEKrIp37fvjyY0C/8dSWUwas2DWT311oRx9HWZCsTD
   9+AtTVOyAVRHR+C1qkD6mwYvGYO6fdbJNUWrqkZtaoeiIWSy+NN+BWkAi
   HGctzHEUKebzGtTFpRtmqIZLnUYanq8HogNpnMMkfB9zT5U4y1B2xmH8h
   6LtQn2uaoIsDkC4bKJket6b/5IVjVkUdugoRsiL6c9lXtP0IRGKqblYlV
   w==;
X-CSE-ConnectionGUID: vFvfSShtTUGu8l3jpsxy/A==
X-CSE-MsgGUID: JFqKeiV+SUa7HUjSKW4dqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31729567"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="31729567"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 01:52:02 -0700
X-CSE-ConnectionGUID: YW2FBySGQKSYW32O6JD87g==
X-CSE-MsgGUID: PKap7fe8RumhHfbm5A0wqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="80854591"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 01:51:58 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-cxl@vger.kernel.org,  Dan Williams
 <dan.j.williams@intel.com>,  Davidlohr Bueso <dave@stgolabs.net>,
  Jonathan Cameron <jonathan.cameron@huawei.com>,  Alistair Popple
 <apopple@nvidia.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  Baoquan He <bhe@redhat.com>,  Dave Jiang <dave.jiang@intel.com>,  Alison
 Schofield <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
In-Reply-To: <38566dbf-1293-4fd5-9cbd-385e6c35344c@redhat.com> (David
	Hildenbrand's message of "Fri, 11 Oct 2024 10:02:43 +0200")
References: <20241010065558.1347018-1-ying.huang@intel.com>
	<d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
	<87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<38566dbf-1293-4fd5-9cbd-385e6c35344c@redhat.com>
Date: Fri, 11 Oct 2024 16:48:25 +0800
Message-ID: <87zfnb81pi.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 11.10.24 03:06, Huang, Ying wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> On 10.10.24 08:55, Huang Ying wrote:
>>>> Currently, if __region_intersects() finds any overlapped but unmatched
>>>> resource, it walks the descendant resource tree to check for
>>>> overlapped and matched descendant resources.  This is achieved using
>>>> for_each_resource(), which iterates not only the descent tree, but
>>>> also subsequent sibling trees in certain scenarios.  While this
>>>> doesn't introduce bugs, it makes code hard to be understood and
>>>> potentially inefficient.
>>>> So, the patch renames next_resource() to __next_resource() and
>>>> modified it to return NULL after traversing all descent resources.
>>>> Test shows that this avoids unnecessary resource tree walking in
>>>> __region_intersects().
>>>> It appears even better to revise for_each_resource() to traverse the
>>>> descendant resource tree of "_root" only.  But that will cause "_root"
>>>> to be evaluated twice, which I don't find a good way to eliminate.
>>>
>>> I'm not sure I'm enjoying below code, it makes it harder for me to
>>> understand what's happening.
>>>
>>> I'm also not 100% sure why "p" becomes "root" and "dp" becomes "p" when
>>> calling the function :) Likely this works as intended, but it's confusing
>>> (IOW, bad naming, especially for dp).
>>>
>>>
>>> I think you should just leave next_resource() alone and rather add
>>> a new function that doesn't conditionally consume NULL pointers
>>> (and also no skip_children because you're passing false either way).
>>>
>>> static struct resource *next_resource_XXX(struct resource *root,
>>> 		struct resource *p)
>>> {
>>> 	while (!p->sibling && p->parent) {
>>> 		p = p->parent;
>>> 		if (p == root)
>>> 			return NULL;
>>> 	}
>>> 	return p->sibling;
>>> }
>>>
>>> Maybe even better, add a new for_each_resource() macro that expresses the intended semantics.
>>>
>>> #define for_each_resource_XXX(_root, _p) \
>>> 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
>> Yes.  This can improve code readability.
>> A possible issue is that "_root" will be evaluated twice in above
>> macro
>> definition. 
>
> Do you mean that we would process it twice in the loop body, or what
> exactly do you mean with "evaluate" ?

In the macro definition above, _root is used twice.  For example, if
"_root" is a time consuming function call, the function will run twice.
That's not expected.

> And just I understand what we want to achieve: we want to walk the
> subtree below "root" and prevent going to root->sibling or
> root->parent if "root" is not actually the "real root", correct?
>
> X
> |--------|
> A----D   E
> |
> B--C
>
>
> So assume we start walking at A, we want to evaluate A,B,C but not D,E,X.
>
> Does that sum up what we want to achieve?

Yes.

--
Best Regards,
Huang, Ying
