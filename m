Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A415E5B8;
	Mon, 28 Oct 2024 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730083978; cv=none; b=HZ6t2zysz8OPmuZdkslyRTfh4mWN+KfUf1ZWN8+gMSnUOuqlSzWtcMpIaeKWFwyy4LIUQkzCnKurSAhhd5SlIldQ2F0yp3qoVW/yYdh55DeWfEc/pkpNNiT96mR9/+le2ep0oWa7Ceyq1l+A3NLc4XZAFWT/zhjbBynxFTF0kxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730083978; c=relaxed/simple;
	bh=gbA2PCwdnxgqssCr7s6U4TSBzXN4+/DsTBMqtrHDBhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ileo/0rTzP1q5t/FCNnCTTNsRSFeX5LTy7IuDZpP+8KQIuQYOXBr5cV+TvfcjrtZ85QOCopbnYakhfjxxhtZAdj3wWO+KHnzXi54GgUhF+pOaPnmn3lMuzROktEG4+/iTBAdUy+XhKua0t8Fqfity+MdVJ9MJbDpLmmmwo07miY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AmjVkMTT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AmjVkMTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730083977; x=1761619977;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gbA2PCwdnxgqssCr7s6U4TSBzXN4+/DsTBMqtrHDBhA=;
  b=AmjVkMTTQa8K19m95aI10N+rblIfrkb6iSFy8NDk+QBxZFgXKCggWWeI
   yvWn30n2cvOqVf4XqApGFbKc49MBr1J6nTzQnZnsfLl+pi0XZNUnCP/RV
   Aq9iPNJJ82mcXQoCQ1czZQH1RG33ZzvtD9jkr246UYVqmnPpeF4IwNFvk
   GeWjmLRml2CT2kckoavgMnpVLHCmvCCIVFrFNydPtCMbh4r1aey2rbt3K
   /5D6J5AB8sfD5aXaBOoARuTZzxLc/wbfiz6H5DE3xwOi2zxu2NbSBfk9i
   RW6wZsnAGBpf3UUzHUbCPSEGmFk9c/00uZSGzDnISqZNOOxjvjqur62cN
   A==;
X-CSE-ConnectionGUID: OCpFXOkkRaSumjHv+oH0uQ==
X-CSE-MsgGUID: rhRAgnN4Ro2tDNE3DcC1Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40249551"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="40249551"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:52:57 -0700
X-CSE-ConnectionGUID: QfcbvVwjR+ix2rgzDazo2g==
X-CSE-MsgGUID: Xq4F7E1QRX2iXcCKUazCxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81421254"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 19:52:53 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,  David Hildenbrand
 <david@redhat.com>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  linux-cxl@vger.kernel.org,  Davidlohr Bueso <dave@stgolabs.net>,
  Jonathan Cameron <jonathan.cameron@huawei.com>,  Alistair Popple
 <apopple@nvidia.com>,  Bjorn Helgaas <bhelgaas@google.com>,  Baoquan He
 <bhe@redhat.com>,  Dave Jiang <dave.jiang@intel.com>,  Alison Schofield
 <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
In-Reply-To: <671bb5d165_10e592941e@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Fri, 25 Oct 2024 08:14:25 -0700")
References: <20241010065558.1347018-1-ying.huang@intel.com>
	<d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
	<87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
	<671965a8b37a2_1bbc629489@dwillia2-xfh.jf.intel.com.notmuch>
	<ZxnvyIme98Q8ey1c@smile.fi.intel.com>
	<87wmhx3cpc.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZxpFQBRqWMDjhtSY@smile.fi.intel.com>
	<671ac2d2b7bea_10e59294f2@dwillia2-xfh.jf.intel.com.notmuch>
	<ZxubhuEwL5GrhBdu@smile.fi.intel.com>
	<671bb5d165_10e592941e@dwillia2-xfh.jf.intel.com.notmuch>
Date: Mon, 28 Oct 2024 10:49:19 +0800
Message-ID: <87plnl0wnk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Andy Shevchenko wrote:
> [..]
>> > > but if you want to stick with your variant some improvements can be done:
>> > > 
>> > > #define for_each_resource_XXX(_root, _p)				\
>> > > 	for (typeof(_root) __root = (_root), __p = _p = __root->child;	\
>> > > 	     __p && _p; _p = next_resource_XXX(__root, _p))
>> > > 
>> > > 
>> > > 1) no need to have local variable in parentheses;
>> > > 2) no need to have iterator in parentheses, otherwise it would be crazy code
>> > > that has put something really wrong there and still expect the thing to work.
>> > 
>> > Why not:
>> > 
>> > #define for_each_resource_XXX(_root, _p)				\
>> > 	for (typeof(_root) __root = (_root), __p = _p = __root->child;	\
>> > 	     _p; _p = next_resource_XXX(__root, _p))
>> > 
>> > The __p is only to allow for _p to be initialized in the first statement
>> > without causing a new "_p" shadow to be declared.
>> 
>> If people think this would be better than the existing patterns, okay. fine.
>
> I think this case is different than the existing patterns in that the
> iterator variable needs to be initiatlized from a declared variable, and
> as Ying said, my proposal is busted.
>
> To your point though, lets add a comment on why this macro is a bit
> different to avoid people like me making bad cleanup suggestions.

Sure.  Will do that.

--
Best Regards,
Huang, Ying
