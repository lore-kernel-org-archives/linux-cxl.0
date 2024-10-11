Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E6A2185B1;
	Fri, 11 Oct 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653088; cv=none; b=dBKas9y6g38BRbf2Rqp3/jqeuJjp4qzWuzSbrPy6Q7GZbyAta3LOBRy62rGBOC13sSg8e/1D4T6gPnDl4GRtza1YQuZKvtQxgLlcOpslXPubJKG4FQHWg4bzlIl5L7aPvH8SENKhT+o5BJC+FOCAOb/T7TzUmvzW+HIGOs5LWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653088; c=relaxed/simple;
	bh=iIufuyOteBXsvMYuxWsNVz1UkSne8TnyU6hpEqh44yI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tX2oUa0++kCMLTSLL0bPs15tM8++++AgLkXsxsNzQgxdVjmOU/XQeTWBm4oj0QIF+TpJBseBOZqnUoOQ7yCeWXBOHTgGACewNTaZZSVR98PC+q3pZ7UNir2d0CknLfVNUOiEktSZ+QmFqi9p+DfJw1fElCN8untHUf1CdYAYIyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBFvuGBC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBFvuGBC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728653086; x=1760189086;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=iIufuyOteBXsvMYuxWsNVz1UkSne8TnyU6hpEqh44yI=;
  b=YBFvuGBCB1zmX1UEEcMwEsnMSOqqV28qPzwYCMAyb0Nv6q25FU/ObfD8
   N4SvU7NR0x3vVkyFwUtIi6NpPeZn3l/CDuA83KFISYvQU4bMIboTOepjK
   NpNxly+G9ufPc9X9vkMjApweBzqOBto3xaDj0yROKeN0wW5f/hEmefZpE
   0j//lUZOuD1KmtE0Ygb/ocJ3XnYh3a9+wVrVOFO2gnYlBED/wPnlRNgbi
   5tgLtiiBfIge/bEAngvRL7oXeovftal9hg/C4W6kizDiN/MR6ABb/XqEN
   68N6XZxQN1TJmPHjHZDRuFiT8/ISSc0SOcJ6f70/UkYsysCv8FLJjQYhn
   Q==;
X-CSE-ConnectionGUID: UU6h8R+/Qk6y4UtnNiKrvA==
X-CSE-MsgGUID: /9AnyVUgT+iCCaZN+AXCPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27523126"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="27523126"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:24:43 -0700
X-CSE-ConnectionGUID: 9HFN1MVJREGnXwoFJGKiNg==
X-CSE-MsgGUID: lLrqMJBrQo+K8cdGK7CVbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="107640626"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 06:24:38 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-cxl@vger.kernel.org,  Dan Williams
 <dan.j.williams@intel.com>,  Davidlohr Bueso <dave@stgolabs.net>,
  Jonathan Cameron <jonathan.cameron@huawei.com>,  Alistair Popple
 <apopple@nvidia.com>,  Bjorn Helgaas <bhelgaas@google.com>,  Baoquan He
 <bhe@redhat.com>,  Dave Jiang <dave.jiang@intel.com>,  Alison Schofield
 <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
In-Reply-To: <12c0a19e-784d-4ac0-8d3c-d5242bcd3723@redhat.com> (David
	Hildenbrand's message of "Fri, 11 Oct 2024 13:30:15 +0200")
References: <20241010065558.1347018-1-ying.huang@intel.com>
	<d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
	<87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
	<b8262026-533b-497b-9713-fa3e32f76d9f@redhat.com>
	<ZwkI62qBAbc02O8C@smile.fi.intel.com>
	<ZwkJyMaBnN84Kbg7@smile.fi.intel.com>
	<12c0a19e-784d-4ac0-8d3c-d5242bcd3723@redhat.com>
Date: Fri, 11 Oct 2024 21:21:05 +0800
Message-ID: <87msja93ni.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 11.10.24 13:19, Andy Shevchenko wrote:
>> On Fri, Oct 11, 2024 at 02:15:55PM +0300, Andy Shevchenko wrote:
>>> On Fri, Oct 11, 2024 at 12:51:09PM +0200, David Hildenbrand wrote:
>>>> On 11.10.24 12:49, Andy Shevchenko wrote:
>>>>> On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
>>>>>> David Hildenbrand <david@redhat.com> writes:
>>>>>>> On 10.10.24 08:55, Huang Ying wrote:
>> ...
>> 
>>>>>>> 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
>>>>>>
>>>>>> Yes.  This can improve code readability.
>>>>>>
>>>>>> A possible issue is that "_root" will be evaluated twice in above macro
>>>>>> definition.  IMO, this should be avoided.
>>>>>
>>>>> Ideally, yes. But how many for_each type of macros you see that really try hard
>>>>> to achieve that? I believe we shouldn't worry right now about this and rely on
>>>>> the fact that root is the given variable. Or do you have an example of what you
>>>>> suggested in the other reply, i.e. where it's an evaluation of the heavy call?
>>>>>
>>>>>> Do you have some idea about
>>>>>> how to do that?  Something like below?
>>>>>>
>>>>>> #define for_each_resource_XXX(_root, _p)                                \
>>>>>> 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
>>>>>> 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))
>>>>>
>>>>> This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
>>>>> solve (see above).
>>>>
>>>> Fully agreed, I didn't quite understand the concern about "evaluation" at
>>>> first.
>>>
>>> It's a basic concept for macros and a good mine field even for the simple
>>> cases.
>>>
>>>> If it's just reading a variable twice, it doesn't matter at all right
>>>> now.
>>>
>>> The problem (even if it's a variable) is that the content of variable can be
>>> changed when run in non-atomic context, i.e. two evaluations will give two
>>> different results. Most "simple" for_each macros leave this exercise to the
>>> caller. That's what I also suggest for now.
>> For any context as Ying provided an example with calls, they have to
>> be
>> idempotent, or you definitely get two different pointers for these, which is
>> bigger issue that what I described above.
>
> Ah, now I understood what Ying meant: if the root pointer is modified
> within the loop body we'd be in trouble.

Given we cannot provide a good macro implementation to traverse only the
descendant tree of _root, I suggest to just keep current
for_each_resource() implementation.  There is only one user of the
proposed new macro to traverse the descendant tree.  So, I suggest to
open coded the for loop instead.  More comments can be added to make it
clear.

--
Best Regards,
Huang, Ying
