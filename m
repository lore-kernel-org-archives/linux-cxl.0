Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B81198842;
	Tue, 22 Oct 2024 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587315; cv=none; b=MqJb/JcVigp+us667RsD06fDfnBYj7Bm9dYf+2M3C3w/I9QZLnYk1wC54TPLK74nfDOI9G8EcE9WX2+tOGpNrr2R3pfnZoJZSBYFXaCXfWkxeqIoTJsmnk3oMaiqp4SKxLl5ekkVtqwAul0zA7l1ZYSmAXVIZKBTIvCg00W1wcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587315; c=relaxed/simple;
	bh=GtdwHkMu5Vu+ITk+uiwWQIn/+rp0fZ195H106kR+b9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RpwuQ6EDZ7EhmVXYkGIAnn+FIXkjXdeTNuvyC7qPv84nwKmnjgIBtCGDYNqCDA25QiDsRNK6N1aPkjpF1tJiYzKMQ5aQgMEKI8LvN0w2TSJiEWUska84dbgp+nFMT1nfBRG/h36uDB8a4ZpwLecBIDC84k/GahmxBsK4Xu04iDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1pnK98g; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1pnK98g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729587314; x=1761123314;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=GtdwHkMu5Vu+ITk+uiwWQIn/+rp0fZ195H106kR+b9E=;
  b=j1pnK98g88CLG2wSH033bl/B473ZcEmABBgrNymRVBdPxwwuJawiOOoE
   fSqVq3HdpMCZtpCAp4/xfo8q7UA8e0bHlCSlh7bQZ45NdzN7UqRBDVN2a
   RvUseBn9+cS26NTN2iCNoGg1UMkXugQGJSMUXEhcwrKdPqnvSS4vb3kUl
   YxjLLUHnOKFJ1SceAV65m6XaGJ2njGkkcpDySaO2UqYODYtGQpB/6GkGd
   JeeYIVp/Fl6xN0LF/8grDwZ3pSvAZg2UQy06Cq+WGPSxOZs10I9oLso/v
   eYCkMM1zbeexcy8ff6f8Xzg2+ku2gWWjzgVokTQK52GuV1lv8OkedMsVk
   Q==;
X-CSE-ConnectionGUID: u/Uen02rRFKLqFVav3/qFg==
X-CSE-MsgGUID: OLQBuGggQY2xPvPx5kEo3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="40493963"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="40493963"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:55:09 -0700
X-CSE-ConnectionGUID: PP3K5ywuSq2E1stjpXA46w==
X-CSE-MsgGUID: jQKWzKU/ScOdfm5tdnWGFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80154060"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:55:06 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-cxl@vger.kernel.org,  David
 Hildenbrand <david@redhat.com>,  Davidlohr Bueso <dave@stgolabs.net>,
  Jonathan Cameron <jonathan.cameron@huawei.com>,  Alistair Popple
 <apopple@nvidia.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  Baoquan He <bhe@redhat.com>,  Dave Jiang <dave.jiang@intel.com>,  Alison
 Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
In-Reply-To: <6717600289c1e_2312294ab@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Tue, 22 Oct 2024 01:19:14 -0700")
References: <20241022053835.217703-1-ying.huang@intel.com>
	<6717600289c1e_2312294ab@dwillia2-xfh.jf.intel.com.notmuch>
Date: Tue, 22 Oct 2024 16:51:33 +0800
Message-ID: <87msiw4j1m.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Huang Ying wrote:
> [..]
>> For the example resource tree as follows,
>> 
>>   X
>>   |
>>   A----D----E
>>   |
>>   B--C
>> 
>> if 'A' is the overlapped but unmatched resource, original kernel
>> iterates 'B', 'C', 'D', 'E' when it walks the descendant tree.  While
>> the patched kernel iterates only 'B', 'C'.
>> 
>> It appears even better to revise for_each_resource() to traverse the
>> resource subtree under "_root" only.  But that will cause "_root" to
>> be evaluated twice, which I don't find a good way to eliminate.
>> 
>> Thanks David Hildenbrand for providing a good resource tree example.
>
> Should this have a Reported-by: and a Closes: tags for that report?
> Seems useful to capture that in the history.

IIUC, David didn't reported an issue.  He just provided an example to
explain the different traversal behavior.

>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> ---
>> 
>> Changes:
>> 
>> RFC->v1:
>> 
>> - Revised patch description and comments, Thanks David and Andy!
>> 
>> - Link to RFC: https://lore.kernel.org/linux-mm/20241010065558.1347018-1-ying.huang@intel.com/
>> 
>> ---
>>  kernel/resource.c | 26 +++++++++++++++++++++++---
>>  1 file changed, 23 insertions(+), 3 deletions(-)
>> 
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index b730bd28b422..bd217d57fb09 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -50,15 +50,34 @@ EXPORT_SYMBOL(iomem_resource);
>>  
>>  static DEFINE_RWLOCK(resource_lock);
>>  
>> -static struct resource *next_resource(struct resource *p, bool skip_children)
>> +/*
>> + * Return the next node of @p in pre-order tree traversal.  If
>> + * @skip_children is true, skip the descendant nodes of @p in
>> + * traversal.  If @p is a descendant of @subtree_root, only traverse
>> + * the subtree under @subtree_root.
>> + */
>> +static struct resource *__next_resource(struct resource *p, bool skip_children,
>> +					struct resource *subtree_root)
>>  {
>>  	if (!skip_children && p->child)
>>  		return p->child;
>> -	while (!p->sibling && p->parent)
>> +	while (!p->sibling && p->parent) {
>>  		p = p->parent;
>> +		if (p == subtree_root)
>> +			return NULL;
>> +	}
>>  	return p->sibling;
>>  }
>>  
>> +static struct resource *next_resource(struct resource *p, bool skip_children)
>> +{
>> +	return __next_resource(p, skip_children, NULL);
>> +}
>> +
>> +/*
>> + * Traverse the whole resource tree with @_root as root in pre-order.
>> + * NOTE: @_root should be the topmost node, that is, @_root->parent == NULL.
>> + */
>>  #define for_each_resource(_root, _p, _skip_children) \
>>  	for ((_p) = (_root)->child; (_p); (_p) = next_resource(_p, _skip_children))
>>  
>> @@ -572,7 +591,8 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
>>  		covered = false;
>>  		ostart = max(res.start, p->start);
>>  		oend = min(res.end, p->end);
>> -		for_each_resource(p, dp, false) {
>> +		/* Traverse the subtree under 'p'. */
>> +		for (dp = p->child; dp; dp = __next_resource(dp, false, p)) {
>
> Perhaps a new for_each_resource_descendant() to clarify this new
> iterator from for_each_resource()?

Yes.  That's a good idea.  The problem is that it's hard to avoid double
evaluation in an elegant way.  We have discussed this in

https://lore.kernel.org/linux-mm/ZwkCt_ip5VOGWp4u@smile.fi.intel.com/

I have proposed something like,

#define for_each_resource_descendant(_root, _p)                            \
	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
	     __p && (_p); (_p) = __next_resource(_p, false, __root))

But this doesn't look elegant.

> Otherwise looks good to me:
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Thanks!

--
Best Regards,
Huang, Ying
