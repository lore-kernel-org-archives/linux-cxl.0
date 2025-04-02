Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38AC10E9;
	Wed,  2 Apr 2025 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743571933; cv=none; b=q1tqoWIrpANVCT75EIMiHHxH64/NToyzrO+rCxUUQ2R0zWPmGlKQbPd40ON4ogw6Z2lgOhUGGdIwHVcR1o5DW3AnJu9A7sC5n+KqPBn6KIE9uMLJ/v0nzIAwt82Lwnp9LeyoA3LiSbB02fTRwFkmBheqWmGzsNFSOH5P4rq1NH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743571933; c=relaxed/simple;
	bh=MQT3+UmWpcqnB98CQgT2riHqMD8EpeHRAZeoOZrRWFo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l4AG+LORNP/DttcyYfNcQgDXcWL1nUk8DFMgpq1sK9EApGRvcdflhcb/c1smmRYZaSI7NEATadclWmWOPAB8ITaaLyDR2FKp9GogQMyxrksm9bc+5hst17M91d41S1bJsMF6gl1YpJ0/Em/5AlmXHrnKGf43nobnjWuglkgC7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-59-67eccbd394c9
Message-ID: <62664200-c087-48ed-960f-264f340cf7af@sk.com>
Date: Wed, 2 Apr 2025 14:32:03 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Rakie Kim <rakie.kim@sk.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, david@redhat.com, Jonathan.Cameron@huawei.com,
 yunjeong.mun@sk.com
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Content-Language: ko
To: Gregory Price <gourry@gourry.net>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250402014906.1086-1-rakie.kim@sk.com>
 <20250402014906.1086-4-rakie.kim@sk.com>
 <5462e706-5b29-495d-9af9-1945e8a5445e@sk.com>
 <20250401213439.4e7a124d94aa42603d31d45e@linux-foundation.org>
 <Z-zIBM4zQ0LbGPYZ@gourry-fedora-PF4VCD3F>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <Z-zIBM4zQ0LbGPYZ@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsXC9ZZnke6V02/SDW42sVjMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9Vi9ZoMBy6PnbPusnt0t11m
	92g58pbVY/Gel0wemz5NYvc4MeM3i8fOh5Ye7/ddZfP4vEkugDOKyyYlNSezLLVI3y6BK+P+
	5fUsBZ85K9ZNe87WwHiXvYuRk0NCwETi1uY2Rhi7+9tfsDivgKXEnEurmUFsFgEViZkbr7BB
	xAUlTs58wgJiiwrIS9y/NQOonouDWWAxk8SztefAmoUFIiU2TLrOBGIzC4hIzO5sAxskIhAk
	8fnpWiaQBiGBP4wSE/ovgm1mE1CTuPJyElgDp4CZRHPzf2aIZjOJrq1djBC2vMT2t3OYQZol
	BJrZJWa8vw51tqTEwRU3WCYwCs5CcuEsJMtnIZk1C8msBYwsqxiFMvPKchMzc0z0MirzMiv0
	kvNzNzECo2pZ7Z/oHYyfLgQfYhTgYFTi4W3gfZMuxJpYVlyZe4hRgoNZSYQ34uvLdCHelMTK
	qtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2MvFpvnsjt6m+wYDr/
	Kjn9zU6VW/wLN78MOf18+yIzsX2Cz46ke/+w5amekvxw4s7YP7NtUgJS/i689XLWhdNOgit3
	fbXdz3OAheGq7UGlm/ujRQK+Mrgc5BVU+qS46XLnj9shJzKWXfN7t7h0/TI93uu10YLGj7aJ
	qrrJvV3wp+b72tSu/Z+uH1NiKc5INNRiLipOBADUiO7npgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LhmqGlp3v59Jt0g4/LLCzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg89ySrxflZp1gsLu+aw2Zxb81/VotD156zWqxek2Hx
	e9sKNgdej52z7rJ7dLddZvdoOfKW1WPxnpdMHps+TWL3ODHjN4vHzoeWHu/3XWXz+Hbbw2Px
	iw9MHp83yQVwR3HZpKTmZJalFunbJXBl3L+8nqXgM2fFumnP2RoY77J3MXJySAiYSHR/+wtm
	8wpYSsy5tJoZxGYRUJGYufEKG0RcUOLkzCcsILaogLzE/VszgOq5OJgFFjNJPFt7DqxZWCBS
	YsOk60wgNrOAiMTszjawQSICQRKfn65lAmkQEvjDKDGh/yIjSIJNQE3iystJYA2cAmYSzc3/
	mSGazSS6tnYxQtjyEtvfzmGewMg3C8khs5DsmIWkZRaSlgWMLKsYRTLzynITM3NM9YqzMyrz
	Miv0kvNzNzEC42dZ7Z+JOxi/XHY/xCjAwajEwyvQ8yZdiDWxrLgy9xCjBAezkghvxNeX6UK8
	KYmVValF+fFFpTmpxYcYpTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MU7ZKeHEUntyU
	qP49+derTmVVYR/36v0XPZ9ujH/y8UjA9d+3k++4Sm4903TlxddwoT0lv/3uqZaJMX8Ka7jW
	nXRWKV9a9Poslm3OBTPP/9n57SXz80+8DffLJgQ/Ld73ZcI35s0zihpVDvwuqF8ja3HUd+9E
	12Ube+v+RJjvL1v9TMfYpeDJbCWW4oxEQy3mouJEALRH1nWbAgAA
X-CFilter-Loop: Reflected

Hi Gregory,

On 4/2/2025 2:15 PM, Gregory Price wrote:
> On Tue, Apr 01, 2025 at 09:34:39PM -0700, Andrew Morton wrote:
>>> I'm not sure if this is going to the final version but could you please add this
>>> patch to stable with Cc: <stable@vger.kernel.org>?
>>> We might need to bring the whole series to avoid conflicts to stable tree.
>>
>> This is all rather confused.
>>
>> Do we need to backport all three patches into -stable?  If so, all three
>> should have Fixes:.  Preferably they all have the same Fixes: so we
>> aren't backporting untested patch combinations.
>>
> 
> I'd just as soon leave the entire thing out of stable backports.
> 
> Only the first patch actually fixes a bug (very small memory leak
> during system tear down, so it's not even a critical bug). This could
> be added to stable.
> 
> Patches 2 and 3 aren't fixes, they're desired behavioral changes
> to the feature. An interface being confusing doesn't mean it's broken.

I think those are fixes but I also agree that this is behavioral changes as
well.  So I'm fine leaving these out of stable backports.


Hi Andrew,

I won't ask changes so please keep the current status as is.  Sorry for making
confusion.

Thanks,
Honggyu

> 
> ~Gregory

