Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DFB1CACE9;
	Thu, 24 Oct 2024 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773259; cv=none; b=rZlZeu4mAS7DUBs/BAjp+iR1oiahaPVmRSW9qQekh/pk6M/TGYEMjQMakq+WHLvksw2HHAUKbFAH5hD5WKkh5uduQWlulL2dFPXtlK8gtA0LPQq6DXmr1fqi52ZJTvnDE7T8eKW2Endl5VKSCW+gZmGOUKFpMm1xPj3COZxG2+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773259; c=relaxed/simple;
	bh=CmAdV9afLS0JTDf0VeXFhYzLWX7ZMh8xBb4mg2UTXtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UseypYka+GnBghteiEnSJKMUbJ1si7SDYCFzrflg7OhNdfrHT5qJI+gtPescXfhZL1H7/1mWARI/21Zw7jClDWx89wpKrCkj6j5w5640tvCiyeWsX8N9H5GJ4UMzGUXEXylRY3L/BGN5tTSuaVVjUuzAVWhby4PZGpNaS298rTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDiyjbF3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDiyjbF3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729773257; x=1761309257;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CmAdV9afLS0JTDf0VeXFhYzLWX7ZMh8xBb4mg2UTXtU=;
  b=cDiyjbF3FdRgo+08z/Lz0zwclNV1Ojk/RGFoMkeGoDMbbUmiPWLOtZXf
   +w6JgwwL1INFFON3iyg/WCpgsSJr7wTI79QwGCRsocga0s7Xrqu0lAEeC
   U9CxCeN+F/iTflSyztUJLDmZYLBgFk5YOhtwFk1wpF5VWN9rIHM8i0tM4
   VUcqoWWnhjqriBbfWFjZ9018137kSUkYYSHChHkYU+lDTVle3sjeLzTw6
   91+jOaMN/CZcjWclek4rmyC7zZ+ufw83rsxD3rtc1bR4uBijYUT6ocDMB
   6EPUoXgCTkueq6/lsT5fAk+mEurLXgcRhrovQ9Q1PbrBjyWIJIl/rEpBl
   w==;
X-CSE-ConnectionGUID: HaxTR9wGTsOpUI0yQAmo7A==
X-CSE-MsgGUID: DMvN2uXJTMG2UnQedMT2dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29619406"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29619406"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 05:34:16 -0700
X-CSE-ConnectionGUID: dCkiNN/zRvihLsXoCaBq7Q==
X-CSE-MsgGUID: FCI6bu98S2uJetZqSIW1oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="81395591"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 05:34:13 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  David Hildenbrand
 <david@redhat.com>,  Andrew Morton <akpm@linux-foundation.org>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <linux-cxl@vger.kernel.org>,  Davidlohr Bueso <dave@stgolabs.net>,
  "Jonathan Cameron" <jonathan.cameron@huawei.com>,  Alistair Popple
 <apopple@nvidia.com>,  Bjorn Helgaas <bhelgaas@google.com>,  Baoquan He
 <bhe@redhat.com>,  Dave Jiang <dave.jiang@intel.com>,  Alison Schofield
 <alison.schofield@intel.com>
Subject: Re: [RFC] resource: Avoid unnecessary resource tree walking in
 __region_intersects()
In-Reply-To: <ZxnvyIme98Q8ey1c@smile.fi.intel.com> (Andy Shevchenko's message
	of "Thu, 24 Oct 2024 09:57:12 +0300")
References: <20241010065558.1347018-1-ying.huang@intel.com>
	<d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
	<87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
	<671965a8b37a2_1bbc629489@dwillia2-xfh.jf.intel.com.notmuch>
	<ZxnvyIme98Q8ey1c@smile.fi.intel.com>
Date: Thu, 24 Oct 2024 20:30:39 +0800
Message-ID: <87wmhx3cpc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Wed, Oct 23, 2024 at 02:07:52PM -0700, Dan Williams wrote:
>> Andy Shevchenko wrote:
>> > On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
>> > > David Hildenbrand <david@redhat.com> writes:
>> > > > On 10.10.24 08:55, Huang Ying wrote:
>
> ...
>
>> > > > 	for ((_p) = (_root)->child; (_p); (_p) = next_resource_XXX(_root, _p))
>> > > 
>> > > Yes.  This can improve code readability.
>> > > 
>> > > A possible issue is that "_root" will be evaluated twice in above macro
>> > > definition.  IMO, this should be avoided.
>> > 
>> > Ideally, yes. But how many for_each type of macros you see that really try hard
>> > to achieve that? I believe we shouldn't worry right now about this and rely on
>> > the fact that root is the given variable. Or do you have an example of what you
>> > suggested in the other reply, i.e. where it's an evaluation of the heavy call?
>> > 
>> > > Do you have some idea about
>> > > how to do that?  Something like below?
>> > > 
>> > > #define for_each_resource_XXX(_root, _p)                                \
>> > > 	for (typeof(_root) __root = (_root), __p = (_p) = (__root)->child; \
>> > > 	     __p && (_p); (_p) = next_resource_XXX(__root, _p))
>> > 
>> > This is a bit ugly :-( I would avoid ugliness as long as we have no problem to
>> > solve (see above).
>> 
>> Using a local defined variable to avoid double evaluation is standard
>> practice. I do not understand "avoid ugliness as long as we have no problem to
>> solve", the problem to solve will be if someone accidentally does
>> something like "for_each_resource_descendant(root++, res)". *That* will
>> be a problem when someone finally realizes that the macro is hiding a
>> double evaluation.
>
> Can you explain, why do we need __p and how can we get rid of that?
> I understand the part of the local variable for root.

If don't use '__p', the macro becomes

#define for_each_resource_XXX(_root, _p)                                \
	for (typeof(_root) __root = (_root), (_p) = (__root)->child; \
	     (_p); (_p) = next_resource_XXX(__root, _p))

Where, '_p' must be a variable name, and it will be a new variable
inside for loop and mask the variable with same name outside of macro.
IIUC, this breaks the macro convention in kernel and has subtle variable
masking semantics.

>> So no, this proposal is not "ugly", it is a best practice. See the
>> definition of min_not_zero() for example.
>
> I know that there are a lot of macros that look uglier that this one.

--
Best Regards,
Huang, Ying
