Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EA2571DA;
	Tue, 21 Jul 2026 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644443; cv=none; b=AMpoCBMtI+/Bj6b9JgInhn501QAwBBcXBAwVPsGPg5nyi9BCUzfKwmCmPKbT0H+xaUwtGT+vsgrGDueq+zR0KFtYRqRLQXTpIJ/qg075upmgal0NY9RpoSM7FWULOsw13H/zCOodsodWI02EZiJNYBX22Z35xI8I9IyQSmgPQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644443; c=relaxed/simple;
	bh=TksD02+nSDFZTkqqTuNUZSfmERYLEKSrjFd/fYy3l5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXFcLH8q3YPZkmPxbXlv9q2nAAyFL8juhwVYNEVX1Su0JATYAmTwryMrrtoQOPoLMa/uBF9/J7K3Hmv8kfEifaEzx7WpdPZGJ7VNW+sydJKVm+kLSjxj7ycHlWW6l8Mwbh+JTZ26bpMIpmjwinB2RgV/lte5we5Rq3Fm1G2fXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxp/mt8s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxp/mt8s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE2C1F00A3A;
	Tue, 21 Jul 2026 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644442;
	bh=+5YEfpnT2oozYCnmAI9PBP18Duhq3Tk/K6j/fOF23yk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Wxp/mt8stG+Rc3giQdEBOVq+M0GGJSxpatj/AoGDI11QtjXS++ZO3wst/OIYM3b+r
	 p9xtA5OgnMxY8dIyiwhcIvrkRVCBOBQ8YBmY3DksE6a0d5zJRIS/HAauMMyXw6oMkq
	 +sz2KJK77Rzf5Jt9gxktu0YKZM2amQS9iECJzzhW5wNRrGP+vdSAecoik8quLZwLqt
	 vak91HwBcii9zp7Z7lkEDw8ech5OBrEC04OC185A/7SqwhOB9iWLfQRuc2beb2oLrP
	 G4O0vSF/2WUqDAhnU9fglU6QjsrTq+g32MQsBhN7FxEY9PFtiwPp69FWML+JwW/TSS
	 GKjDoyaD/YOZA==
Message-ID: <5766bfae-8dd9-4542-bbab-324dbde0e2f5@kernel.org>
Date: Tue, 21 Jul 2026 16:33:56 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mm: fix PMD level mTHP accounting bugs
To: Nico Pache <npache@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>
Cc: Barry Song <baohua@kernel.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>
References: <20260717064502.1980173-1-npache@redhat.com>
 <20260717182947.534af296aaa1831d13f8ae6d@linux-foundation.org>
 <CAA1CXcCrA9nrraxVNTdo19TRONvqM-fndSbDaCib4tZCmQC9tw@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAA1CXcCrA9nrraxVNTdo19TRONvqM-fndSbDaCib4tZCmQC9tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/26 15:57, Nico Pache wrote:
> On Fri, Jul 17, 2026 at 7:29 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Fri, 17 Jul 2026 00:44:58 -0600 Nico Pache <npache@redhat.com> wrote:
>>
>>> While running selftests I noticed the PMD level per-mTHP stats (nr_anon)
>>> remained elevated after each run. After further investigation I noticed
>>> this accounting error occurs for both the migration.private_anon_htlb_test
>>> and the HMM tests.
>>>
>>> In the HMM case this is due to folio_add_new_anon_rmap() incrementing the
>>> mTHP stats, but never containing a corresponding decrement in
>>> free_zone_device_folio(). We solve this by making sure to decrement the
>>> counter when freeing device memory.
>>>
>>> In the migration case, we are incrementing this counter without first
>>> checking whether this folio is a hugetlb folio, which relies on a separate
>>> accounting system. We solve this by adding the proper hugetlb check before
>>> incrementing this counter.
>>>
>>> With these changes in place, the two tests no longer cause elevated PMD
>>> level accounting issues.
>>
>> Thanks, I've updated mm.git's mm-hotfixes-unstable branch to this
>> version.
> 
> Thanks!
> 
>>
>> Sashiko is worried about the existing code ("list corruption or a
>> use-after-free panic"):
>>         https://sashiko.dev/#/patchset/20260717064502.1980173-1-npache@redhat.com
> 
> https://sashiko.dev/#/patchset/20260717064502.1980173-1-npache@redhat.com
> 
> I dug into this, although I'm not very familiar with device memory.

In general: Don't let a tool waste your time on unrelated things if it wasn't
you that asked the tool for it. Someone else asked the tool to find unrelated
things.

I thought we only support anonymous THP for device-private, not device-coherent.

Maybe lib/test_hmm.c could somehow trigger it by selecting
MIGRATE_VMA_SELECT_COMPOUND?

But in migrate_device_coherent_folio() we have

	WARN_ON_ONCE(folio_test_large(folio));

So this would already be pretty broken and I wouldn't spend any more time on it.

-- 
Cheers,

David
