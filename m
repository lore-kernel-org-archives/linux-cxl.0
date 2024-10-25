Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC91859;
	Fri, 25 Oct 2024 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729816500; cv=none; b=ba01ZwyqdRpFJynN2GCfkWwMAtTRAF4FUO+B0dUj3bzLqmTZFPNnKbCkejetFXkO1RFXzDpyiYy8010rgXYxGpTgEaZc/c8W6gadH8CJwm11l/AVNbeSuv9PAoaTTM+My9GS/tXH1S6cYvj7bswG5JbJywJuPCYgkwjMYYEQ8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729816500; c=relaxed/simple;
	bh=WZLcB/JIp9eAIRtXS44KhQy+6u4FTbvIx6i23GslbnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AoH8hf+0IPUgKk6AzrLFhQqwWjdJL8hMDVXj/nVCz7lzaoUtrMaw2gaYzjyjOD8NxmuysP0l0DEAbBjVeXGteSzXVjJ3NTyMo2ElNWXWwXELGWyIEEclUpF0k+gHxnWiHhwKTgdLS/S0Bvyk6FNOSoVSEbhfGPPqnLmU8QoWHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jeWXkcHm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jeWXkcHm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729816498; x=1761352498;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=WZLcB/JIp9eAIRtXS44KhQy+6u4FTbvIx6i23GslbnM=;
  b=jeWXkcHm5Y73p7VWCxlGv8xCR/mvHVe6I+44/eRYrA9I4lNTloAmfb2/
   6a9FGtJqDvs/UqMXiWEy3qMr5vF9AoL93lqD7PlV5tNeI9aDjv5g/hm7Y
   EHRl8Vm/FCSieKviimz4eRcJC51IusOnDYSr+X/ktmbWomnkxFqbPsBYe
   G1KCzBz3AmgNxF/Vy5lCPlnzUAhsLiczK+bkzrbP0bfuM14W+nIo2Dj/m
   41enf5y+SmV8/VphyOR6vD7wcC0dMgQd1x0aHQSRGs6vpeNdHTYNXd3iP
   dRSClYXpLzGWlbXxD0LWKwMZCJNNoUllp36to9usESpKPZpPoCtdYGwFO
   Q==;
X-CSE-ConnectionGUID: PSNYYFqERM6ctNhHT+EHdQ==
X-CSE-MsgGUID: HGpj0FzqQ/SgFEFs6qsrrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40065036"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="40065036"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 17:34:57 -0700
X-CSE-ConnectionGUID: ZUpTV2XERfSb8sYEZNtsng==
X-CSE-MsgGUID: lMDrP+CLSxGFFav1q8Ue3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="81580938"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 17:34:54 -0700
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
In-Reply-To: <671ac2d2b7bea_10e59294f2@dwillia2-xfh.jf.intel.com.notmuch> (Dan
	Williams's message of "Thu, 24 Oct 2024 14:57:38 -0700")
References: <20241010065558.1347018-1-ying.huang@intel.com>
	<d129bbe4-8ae8-4915-bd9c-b38b684e8103@redhat.com>
	<87set3a1nm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZwkCt_ip5VOGWp4u@smile.fi.intel.com>
	<671965a8b37a2_1bbc629489@dwillia2-xfh.jf.intel.com.notmuch>
	<ZxnvyIme98Q8ey1c@smile.fi.intel.com>
	<87wmhx3cpc.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZxpFQBRqWMDjhtSY@smile.fi.intel.com>
	<671ac2d2b7bea_10e59294f2@dwillia2-xfh.jf.intel.com.notmuch>
Date: Fri, 25 Oct 2024 08:31:21 +0800
Message-ID: <87sesl2fc6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dan Williams <dan.j.williams@intel.com> writes:

> Andy Shevchenko wrote:
>> On Thu, Oct 24, 2024 at 08:30:39PM +0800, Huang, Ying wrote:
>> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > > On Wed, Oct 23, 2024 at 02:07:52PM -0700, Dan Williams wrote:
>> > >> Andy Shevchenko wrote:
>> > >> > On Fri, Oct 11, 2024 at 09:06:37AM +0800, Huang, Ying wrote:
>> > >> > > David Hildenbrand <david@redhat.com> writes:
>> > >> > > > On 10.10.24 08:55, Huang Ying wrote:
>>=20
>> ...
>>=20
>> > >> > > > 	for ((_p) =3D (_root)->child; (_p); (_p) =3D next_resource_X=
XX(_root, _p))
>> > >> > >=20
>> > >> > > Yes.  This can improve code readability.
>> > >> > >=20
>> > >> > > A possible issue is that "_root" will be evaluated twice in abo=
ve macro
>> > >> > > definition.  IMO, this should be avoided.
>> > >> >=20
>> > >> > Ideally, yes. But how many for_each type of macros you see that r=
eally try hard
>> > >> > to achieve that? I believe we shouldn't worry right now about thi=
s and rely on
>> > >> > the fact that root is the given variable. Or do you have an examp=
le of what you
>> > >> > suggested in the other reply, i.e. where it's an evaluation of th=
e heavy call?
>> > >> >=20
>> > >> > > Do you have some idea about
>> > >> > > how to do that?  Something like below?
>> > >> > >=20
>> > >> > > #define for_each_resource_XXX(_root, _p)                       =
         \
>> > >> > > 	for (typeof(_root) __root =3D (_root), __p =3D (_p) =3D (__roo=
t)->child; \
>> > >> > > 	     __p && (_p); (_p) =3D next_resource_XXX(__root, _p))
>> > >> >=20
>> > >> > This is a bit ugly :-( I would avoid ugliness as long as we have =
no problem to
>> > >> > solve (see above).
>> > >>=20
>> > >> Using a local defined variable to avoid double evaluation is standa=
rd
>> > >> practice. I do not understand "avoid ugliness as long as we have no=
 problem to
>> > >> solve", the problem to solve will be if someone accidentally does
>> > >> something like "for_each_resource_descendant(root++, res)". *That* =
will
>> > >> be a problem when someone finally realizes that the macro is hiding=
 a
>> > >> double evaluation.
>> > >
>> > > Can you explain, why do we need __p and how can we get rid of that?
>> > > I understand the part of the local variable for root.
>> >=20
>> > If don't use '__p', the macro becomes
>> >=20
>> > #define for_each_resource_XXX(_root, _p)                              =
  \
>> > 	for (typeof(_root) __root =3D (_root), (_p) =3D (__root)->child; \
>> > 	     (_p); (_p) =3D next_resource_XXX(__root, _p))
>> >=20
>> > Where, '_p' must be a variable name, and it will be a new variable
>> > inside for loop and mask the variable with same name outside of macro.
>> > IIUC, this breaks the macro convention in kernel and has subtle variab=
le
>> > masking semantics.
>>=20
>> Yep.
>
> Oh, due to the comment expression, good catch.
>
>>=20
>> In property.h nobody cares about evaluation which makes the macro as sim=
ple as
>>=20
>> #define for_each_resource_XXX(_root, _p)		\
>> 	for (_p =3D next_resource_XXX(__root, NULL); _p;	\
>> 	     _p =3D next_resource_XXX(__root, _p))
>>=20
>> (Dan,
>>  that's what I called to avoid solving issues we don't have and most lik=
ely
>>  will never have.)
>
> Ah, my apologies, I thought the objection was to the macro altogether.=20
>
>> but if you want to stick with your variant some improvements can be done:
>>=20
>> #define for_each_resource_XXX(_root, _p)				\
>> 	for (typeof(_root) __root =3D (_root), __p =3D _p =3D __root->child;	\
>> 	     __p && _p; _p =3D next_resource_XXX(__root, _p))
>>=20
>>=20
>> 1) no need to have local variable in parentheses;
>> 2) no need to have iterator in parentheses, otherwise it would be crazy =
code
>> that has put something really wrong there and still expect the thing to =
work.
>
> Why not:
>
> #define for_each_resource_XXX(_root, _p)				\
> 	for (typeof(_root) __root =3D (_root), __p =3D _p =3D __root->child;	\
> 	     _p; _p =3D next_resource_XXX(__root, _p))
>
> The __p is only to allow for _p to be initialized in the first statement
> without causing a new "_p" shadow to be declared.

I have tries this before.  Compiler will complain with

warning: unused variable =E2=80=98__p=E2=80=99 [-Wunused-variable]

--
Best Regards,
Huang, Ying
