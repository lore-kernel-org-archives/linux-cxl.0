Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF13A8F6C;
	Mon,  2 Sep 2024 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725243092; cv=none; b=u34thxfcI1iRawMexZrAsUECa75jLT2trwCHKM/3L467cqkXAJi1GNLl/+KqEJm8JZ4U4CF8XSaHI2xAwHRzkZjdoYM62AbnN0Aux+3OEq56LuJE+/B3Jtr0gqtDpFiMUqaY8DsHs4n5E2/6UdQk/4+WDk59wjxB/l/bk/Z7QW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725243092; c=relaxed/simple;
	bh=lIa1/ves7CFhzV4mIUGD2uJCIk7VgGhY+d4DZ+ukbCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CKn7h3KAga6jHka7+PywiCNe1cHyl0XHz+WuIgzzLCc7VQ55SEZLS/6e0mSN2Ivjz5y8jGpJrxQgyXRrFNOkzytAoq+R0Cm2dTNHwW/MC9vxpkcs/gYl5kukUN8w6nq5QWOh0Pfe0VA5d5gqFgDhuCRepf6nZylT052GfdhBE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrhwMf1/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrhwMf1/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725243090; x=1756779090;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lIa1/ves7CFhzV4mIUGD2uJCIk7VgGhY+d4DZ+ukbCE=;
  b=XrhwMf1/VYlsfI+un+WhtG4VBI6NJbrDLT52woE7iP6KRvVz+LLS3eKp
   9TKrlPTZ0ivOph8zFDNQl1anMxcN5N25S2CH9XiW0RYcqmYF05UNp2GHe
   Gd7YMw6Zg3lnQbWL9w88vyZoxxvmIHv457TRBgF0h4C8Fyf5w5UaeppSe
   9Dzlzw5jmJ7wig3iYk5Ipieb/vytbT8Q2wBHtvMArUp3AJKOeN6RxYEee
   FldymXALOIjBpkJFa2hQ9RU6HzWyhXzcV/vOZ4376G8EatHOsSC6ydXi1
   xEYhCkv0SJdmdxgJyi14zHqC8WHtvA74d5LV0wFSgANokVlBvhouwpBIb
   Q==;
X-CSE-ConnectionGUID: 6XVf55LHTWGxegAXiNJynw==
X-CSE-MsgGUID: H0BSmI/OSLCBSiBxJ7uBYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="49206481"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="49206481"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:11:29 -0700
X-CSE-ConnectionGUID: u3HEMCwyQbWZqI0ZiAcqLw==
X-CSE-MsgGUID: 8aJnlJ+tSlSFM3Y1Mybzlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="101931078"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:11:26 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-cxl@vger.kernel.org,  Davidlohr
 Bueso <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Dave Jiang <dave.jiang@intel.com>,  Alison
 Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Alistair
 Popple <apopple@nvidia.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Resource: fix region_intersects() for CXL memory
In-Reply-To: <66c69470ae357_7605294ab@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	(Dan Williams's message of "Wed, 21 Aug 2024 18:29:20 -0700")
References: <20240816020723.771196-1-ying.huang@intel.com>
	<66bedd0f746ab_1c18294b5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<87y14wj4ju.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<66c69470ae357_7605294ab@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Date: Mon, 02 Sep 2024 10:07:52 +0800
Message-ID: <87r0a2g64n.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Huang, Ying wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>> > Huang Ying wrote:
> [..]
>> >>  kernel/resource.c | 44 +++++++++++++++++++++++++++++++++++++-------
>> >>  1 file changed, 37 insertions(+), 7 deletions(-)
>> >> 
>> >> diff --git a/kernel/resource.c b/kernel/resource.c
>> >> index 14777afb0a99..c97a5add9394 100644
>> >> --- a/kernel/resource.c
>> >> +++ b/kernel/resource.c
> [..]

[snip]

>
>> However, I admit that the original code is hard to be understood,
>> whether is something like below better?
>
> I like that this proposal defers incrementing @other rather than
> decrement after the fact.
>
>> 
>> 	for (p = parent->child; p ; p = p->sibling) {
>> 		if (!resource_overlaps(p, &res))
>> 			continue;
>> 		is_type = (((p->flags & flags) == flags) &&
>> 			   ((desc == IORES_DESC_NONE) || (desc == p->desc)));
>> 		if (is_type) {
>> 			type++;
>> 			continue;
>> 		}
>> 		/*
>> 		 * Continue to search in descendant resources.  Unless
>> 		 * the matched descendant resources cover the whole
>> 		 * overlapped range, increase 'other', because it
>> 		 * overlaps with 'p' at least.
>> 		 */
>> 		covered = false;
>
> I would call @covered, @single_descendant. Since @covered is ambiguous.

Sorry, I don't understand why this is called @single_descendant.  It's
possible that the checked region is overlapped with 2 descendants, and
the result is REGION_INTERSECTS.  For example,

490000000-52fffffff : CXL Window 0
  490000000-50fffffff : region0
    490000000-50fffffff : dax0.0
      490000000-50fffffff : System RAM (kmem)
  510000000-52fffffff : region1
    510000000-52fffffff : dax0.1
      510000000-52fffffff : System RAM (kmem)

region_intersects(, 0x50ffff000, 2 * PAGE_SIZE, IORESOURCE_SYSTEM_RAM,
IORES_DESC_NONE) => REGION_INTERSECTS

>> 		ostart = max(res.start, p->start);
>> 		oend = min(res.end, p->end);
>> 		for_each_resource(p, dp, false) {
>> 			if (!resource_overlaps(dp, &res))
>> 				continue;
>> 			is_type = (((dp->flags & flags) == flags) &&
>> 				   ((desc == IORES_DESC_NONE) ||
>> 				    (desc == dp->desc)));
>> 			if (is_type) {
>> 				type++;
>> 				if (dp->start > ostart)
>
> ...this should have a comment:
>
> /* partial descendant overlap indicates overlap with a descendant hole */

Yes.  Some comments should help.

>> 					break;
>> 				if (dp->end >= oend) {
>> 					covered = true;
>> 					break;
>
> ...then per above this because easier to read as:
>
> 	single_descendant = true;
>
>> 				}
>> 				ostart = dp->end + 1;
>> 			}
>> 		}
>> 		if (!covered)
>> 			other++;
>> 	}
>> 

[snip]

--
Best Regards,
Huang, Ying
