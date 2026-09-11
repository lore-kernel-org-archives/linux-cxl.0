Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9EC448D16;
	Fri, 11 Sep 2026 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114786; cv=none; b=UU0UQbmLPw3cJrcvHCxZkexGvgnSFuKxs6a7xTlZPF+6e6YvtQqFZ91BWNymOKzuXnERoYSsNy2vE9U+XDAtNydF4E3ArFKTFSLgcPHULKgZc7R4wfzM1UGZbQmEDb44x94/JY9StTySlmvyoVcuB/pbcqFbzVhTke2k5hb0kOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114786; c=relaxed/simple;
	bh=N3S6b+Az5g4o5di2mJ6MI9dgWyzxca/Ar2fC9gYpsAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnzW8HHjC4IRqlesV7+kQTbhCPf5eHi5VrCmlBSdqenIhd7o8ZcYZ5v+M2NQZI0tS8M12ZVoWas2XqvWd72IPHOChA2O+A9GIVjEpVbmA9IsUX7MavppaadYZdAithN9yrLOtloIoroQSQXee0xW/gs1GWVpE+Jr1ufkCmXAY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09209158|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0787936-0.000257506-0.920949;FP=7864596658906816633|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=yehuaisheng@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jB9h8rm_1789114770;
Received: from 172.18.22.180(mailfrom:yehuaisheng@open-hieco.net fp:SMTPD_---.jB9h8rm_1789114770 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 11 Sep 2026 16:19:31 +0800
Message-ID: <17ebffd9-1ec3-4a34-85b5-fa00eb516478@open-hieco.net>
Date: Fri, 11 Sep 2026 16:19:29 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: account for allowed nodes when gathering
 surplus pages
To: Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: osalvador@suse.de, linux-mm@kvack.org, david@kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260909074642.7308-1-yehuaisheng@open-hieco.net>
 <8A0F6014-4E2C-4F07-9732-2DF32418B986@linux.dev>
 <20260910152026.5bcf5c5d7f1ecdcb0147ceaf@linux-foundation.org>
 <35D58CFB-BC97-4245-A387-DB3077E395C3@linux.dev>
From: Huaisheng Ye <yehuaisheng@open-hieco.net>
In-Reply-To: <35D58CFB-BC97-4245-A387-DB3077E395C3@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/11/2026 10:41, Muchun Song wrote:
>
>> On Sep 11, 2026, at 06:20, Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Thu, 10 Sep 2026 16:48:56 +0800 Muchun Song <muchun.song@linux.dev> wrote:
>>
>>>> This fixes hugetlb mappings when, for example, a task runs with
>>>> MPOL_BIND on Node 1 while the existing free huge pages are on Node 0.
>>>>
>>>> Similar issue also could be found in ltp if the free pages of global pool
>>>> reside outside the nodes allowed by the application.
>>>> # cd ltp/testcases/kernel/mem/hugetlb/hugemmap/
>>>> # numactl --cpunodebind=0 --membind=1 ./hugemmap10
>>>>
>>>> Signed-off-by: Huaisheng Ye <yehuaisheng@open-hieco.net>
>>> Acked-by: Muchun Song <muchun.song@linux.dev>
>> Should we backport this?
>>
>> If so, a Fixes: target would be helpful.
> I believe the fix should be e4e574b767ba ("hugetlb: Try to grow hugetlb
> pool for MAP_SHARED mappings"). This commit was introduced back in 2007.
> Regarding the impact of this issue, I consulted an AI:
>
> Severity: Medium
> Impact: valid HugeTLB mappings can be rejected with ENOMEM
> Scope: NUMA + cpuset/MPOL_BIND + nr_overcommit_hugepages
> Risk: availability/configuration failure, no data corruption
>
>
> The fact that it has only been triggered after such a long time also
> precisely shows how uncommon its configuration is. I expect that
> backporting may encounter some conflicts. In the absence of clear user
> feedback, I personally suggest not doing a backport.
>
> Of course, as the author of this patch, you could also provide more
> information, for example, whether it was discovered as a real issue
> in a production environment, so as to decide whether to proceed with
> a backport.
We found this defect when doing the hugemmap10 test of LTP, it appears
with a certain probability (5%) in scenarios involving multiple NUMA nodes.
After debugging, I believe its occurrence is related to the location of
the regular huge page pool and the MPOL_BIND strategy used for allocating 
surplus pages.
So I moved to hugetlb-mmap with some simple setup steps to make it reproduce stably.

A more realistic scenario I have in mind is this, user uses huge pages in memory
pooling solutions like CXL memory expander or others, if there are already some 
regular
huge pages locates on the local node, but user wants to restrict application to use
surplus pages from remote nodes — and that's when the failure occurs.

CC linux-cxl.

BRs,
Huaisheng Ye

