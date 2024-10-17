Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCB21CF5E7;
	Thu, 17 Oct 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151504; cv=none; b=s52zbfr1K+VCmPbcPuD+MFiN/TJ+Ghr2uKAwsmqwhrAh4dHGMC1Q6rAFvTuCVx4q6ZHEHXRoebwWwyoF9NyWZafE5/vZogGlTC41i5bab7IZz4N3KcQpB81RJ3X4oTQemSVj+KsxHvRmy8X9TMlRNMKFHotjHfHdQyL9dyPZJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151504; c=relaxed/simple;
	bh=REIKD1HxvzYNIbz9uCq0Hz8fovFtDXa2dgj1UHMlgiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BakNu/12VR8DzTjA0s23NZFYgeS7S5XHuYAxTDGyY5UQJiqB7TWSvoXWw+/CA5Ru3i44N6YtlSsAlr/BtofyzdNH1asajkYY4GytTAR1P+xceuyIc4dKib6C9ksZIB5JrzDn6j1oaAnVaOk+kAcPokrYog+F/rX+DGmh9kSUpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipgqoqjj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipgqoqjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729151500; x=1760687500;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=REIKD1HxvzYNIbz9uCq0Hz8fovFtDXa2dgj1UHMlgiA=;
  b=ipgqoqjji8IkZRlxP1qM99bFBckoJJ4sBpMDYaghEwtdWG3u4/CGTprO
   Qgldm7O7ZRnuIuhvGxnNCjO4Ns9UYGVNpa0XKVHAuBm5RtZ5RCj0avs/O
   N00YSw7npJMfMgFD7ew67Uyfgzj+3zovrfGk9U30F3yr9hPseaU5EMlRu
   v9zd5CdBliB+JcBAJyU/uJ8H562Bp8Pdd6QpVQUsGlZ0yJwCfAsQtuCSq
   dMMu0T3yryCgL0n1LRrQvLc+t1wJpEfQWiOpGiIoRv4ihpuHm60YHXFcR
   uduXKoneEiNmvCru7t66NO4QboGkeh4MzmMYY2SO+v8H64K0Hgq64pd9h
   A==;
X-CSE-ConnectionGUID: mvzVCO0CRyqdKC9McaosFQ==
X-CSE-MsgGUID: 4M38skxLSzGmr3rrmjHDnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39746770"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39746770"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 00:51:39 -0700
X-CSE-ConnectionGUID: gQEdFuC1SRi9xZ8fxPzgeQ==
X-CSE-MsgGUID: 8lAFyR3gRKixJAuKNvk8Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="83247961"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 00:51:37 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Gregory Price <gourry@gourry.net>,
  "Davidlohr Bueso" <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Alison Schofield
 <alison.schofield@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  Ben Cheatham
 <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 5/5] cxl: Avoid to create dax regions for type2
 accelerators
In-Reply-To: <ea8afddb-9e97-98f6-b1ee-b5394d35e8c0@amd.com> (Alejandro Lucero
	Palau's message of "Thu, 17 Oct 2024 08:27:01 +0100")
References: <20241015065713.308671-1-ying.huang@intel.com>
	<20241015065713.308671-6-ying.huang@intel.com>
	<d5233135-9d70-9080-c7eb-0906f07e5104@amd.com>
	<87jze76y4r.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ea8afddb-9e97-98f6-b1ee-b5394d35e8c0@amd.com>
Date: Thu, 17 Oct 2024 15:48:04 +0800
Message-ID: <87frov6uh7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Alejandro Lucero Palau <alucerop@amd.com> writes:

> On 10/17/24 07:29, Huang, Ying wrote:
>> Hi, Alejandro,
>>
>> Alejandro Lucero Palau <alucerop@amd.com> writes:
>>
>>> I did comment on this some time ago and I'm doing it again.
>>>
>>>
>>> This is originally part of the type2 patchset, and I'm keeping it in
>>> V4. I do not understand why you pick code changes (you explicitly said
>>> that in the first RFC) from there and use it here, and without
>>> previous discussion about this necessity in the list. I do not think
>>> this is usual, at least in other kernel subsystems I'm more familiar
>>> with, so I will raise this in today's cxl open source collaboration
>>> sync.
>> No.  I picked this change from Dan's series as follows,
>>
>> https://eclists.intel.com/sympa//arc/linux-bkc/2024-10/msg00018.html
>>
>> So, I added co-developed-by and signed-off-by of Dan.
>>
>> IIUC, your picked this change from Dan's series too?
>
>
> Look, this is not going well.
>
>
> You specifically said in your first patchset you considered the type2
> support patchset complete but too large or complex, so you were taking
> parts of it as a prelude for making it easier to review/accept. Just
> face that and not twist the argument.

Although I listed your patchset in my cover letter.  All changes I
picked was from Dan's patchset instead of yours.  And, I kept Dan's
co-developed-by and signed-off-by.  If you will pick changes from Dan,
please do that too.

> FWIW, I'm against you doing so because:
>
>
> 1) You should have commented in the type2 patchset about your concern,
> and gave advice about doing such a prelude (by me) or offer yourself
> for doing it.
>
> 2) Just following your approach, anyone could do the same for any
> patchset sent to the list. This is not a good precedent.
>
> 3) If this is going to be allowed/approved, I'm not going to be
> comfortable within this community. If it is just me, I guess it will
> not be a big loss.
>
>
> None has commented yet except you and me, what I do not know if it is
> because this is a nasty discussion they do not want to get entangle
> with, or because they just think your approach is OK. If not further
> comment and your patchset is accepted, nothing else will be needed to
> say.
>
>
>> Feel free to include this change in your series.  If your patchset is
>> merged firstly, I will rebase on yours and drop this change.
>>
>> [snip]

--
Best Regards,
Huang, Ying
