Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78B4C7D;
	Fri, 11 Oct 2024 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609016; cv=none; b=dl3gcfW1cLjSZkY5LIYKNW11MiPTyWzhavxKX1WaWpJuN2OFSmcorzoRCwBEa+zf0JJCEk0+uOlz2c9L7b5HbWmBPC3aankSMjuka43eOXDtpAJNe4VovOUYRMWn8vN5yW5pnEsdHv3+PqQCZH2Dd929DAZ9XpmIagXZWxB6X/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609016; c=relaxed/simple;
	bh=CxcNe39wol/3RMMdthb7jSSJhVKt++1yY7sFwySt0Ug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qH3CvKfZcsjaAn2CxtKuEgGrwDzbY8WDFEJ0ZXrrzLMyFahLEiHTVjoihs3V/fy9JvF6W8fXvd0tx73zAY2VL4vOuLLOiLG56yE7xTUYLotokHWF6MElxf5F2WwqVYVe9kAOrO85pHvwul0MZwQqBkOGaLuHzo+5enr9UXa5Qg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYtbvKND; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYtbvKND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728609015; x=1760145015;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CxcNe39wol/3RMMdthb7jSSJhVKt++1yY7sFwySt0Ug=;
  b=GYtbvKNDO1MVSnybToA8ELBB0/eSb6lMziauiwIY94Au1cOxow/ocbT9
   m/OagYXQzpquj/woIJtAvSfFsfaHr5suDlhW1VuFQA5lVn8pcHdO7s0h1
   Jbk1aeWY9P7YlomapZ12tNVldMeEujNriEvVOuJUaS1X71S6XOGiB2DRY
   jn+a6ROpE0hekVRzNM3I+/QjpaG4Bw2tiFRdQTVhmEZznqL+PzfQs87uU
   /FYftKCkSOsjN+OHN7L83l/vRqRKxg5/vHwzV3TTjNj7Kdm5KOXSwbeW/
   5768xNZZyZejwNKPvCinXQL/uHsdwI/XRSHD6P6svQr+L4WdEAMtKasl7
   A==;
X-CSE-ConnectionGUID: ubpQHaTfTkK0v5r9BN/Y5Q==
X-CSE-MsgGUID: r16xOe25S1CbinNtVm0r5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="30869209"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="30869209"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 18:10:14 -0700
X-CSE-ConnectionGUID: cLQw4wNyTAeywHSh/b7aKQ==
X-CSE-MsgGUID: FkIIDcY1SSeg17kKRAtytA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="107629082"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 18:10:11 -0700
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
In-Reply-To: <d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com> (David
	Hildenbrand's message of "Thu, 10 Oct 2024 14:54:33 +0200")
References: <20241010065558.1347018-1-ying.huang@intel.com>
	<d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
Date: Fri, 11 Oct 2024 09:06:37 +0800
Message-ID: <87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 10.10.24 08:55, Huang Ying wrote:
>> Currently, if __region_intersects() finds any overlapped but unmatched
>> resource, it walks the descendant resource tree to check for
>> overlapped and matched descendant resources.  This is achieved using
>> for_each_resource(), which iterates not only the descent tree, but
>> also subsequent sibling trees in certain scenarios.  While this
>> doesn't introduce bugs, it makes code hard to be understood and
>> potentially inefficient.
>> So, the patch renames next_resource() to __next_resource() and
>> modified it to return NULL after traversing all descent resources.
>> Test shows that this avoids unnecessary resource tree walking in
>> __region_intersects().
>> It appears even better to revise for_each_resource() to traverse the
>> descendant resource tree of "_root" only.  But that will cause "_root"
>> to be evaluated twice, which I don't find a good way to eliminate.
>
> I'm not sure I'm enjoying below code, it makes it harder for me to
> understand what's happening.
>
> I'm also not 100% sure why "p" becomes "root" and "dp" becomes "p" when
> calling the function :) Likely this works as intended, but it's confusing
> (IOW, bad naming, especially for dp).
>
>
> I think you should just leave next_resource() alone and rather add
> a new function that doesn't conditionally consume NULL pointers
> (and also no skip_children because you're passing false either way).
>
> static struct resource *next_resource_XXX(struct resource *root,
> 		struct resource *p)
> {
> 	while (!p->sibling && p->parent) {
> 		p = p->parent;
> 		if (p == root)
> 			return NULL;
> 	}
> 	return p->sibling;
> }
>
> Maybe even better, add a new for_each_resource() macro that expresses the intended semantics.
>
> #define for_each_resource_XXX(_root, _p) \
> 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))

Yes.  This can improve code readability.

A possible issue is that "_root" will be evaluated twice in above macro
definition.  IMO, this should be avoided.  Do you have some idea about
how to do that?  Something like below?

#define for_each_resource_XXX(_root, _p)                                \
	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
	     __p && (_p); (_p) = next_resource_XXX(__root, _p))

> XXX TBD
>
> Or do you think this should not only be "improved" for the __region_intersects() use case
> but for all for_each_resource() users? I cannot tell easily.

I prefer to make for_each_resource() to traverse only descendant
resource tree of "_root".  This helps code reusing and make the
interface easier to be understood.  The difficulty lies in twice
evaluation as above.

--
Best Regards,
Huang, Ying
