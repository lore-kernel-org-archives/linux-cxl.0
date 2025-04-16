Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2322CBF4;
	Wed, 16 Apr 2025 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789082; cv=none; b=rQoBMA7ydBEpX40qjw7Jf+oCF0IIlaubSlPUdx385PiNdvP7rxuU2z6XI6BMmVua4OOCzyOSIV+bS2ZhA+uvTBho5TEpo4loAKmXIuFymDrTiS1Hg0oP8AbDBwW7Pqe/Ww59hznRNUD5TqXkC2SIo6XwxeN4ccotige0AGqy0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789082; c=relaxed/simple;
	bh=Fybx3Iz/wMarHtOZGnakusCk5Rq7cupipk5q2F325aE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=AE8kJl4iCjAXP47T8+xCNHytuY33PdIgmIzQoPexUyqDmYZkmooDJ6Z4edfQXQHYDq+lmEQb/M3mGHzjMjDhB+FyMmtXdh3GfNGYSLnqEjQIRV2RX0DV5TiC8BkRckAjeaAz4EPeLOqk3d5D/oFcRt124lr+BpgDE1FrDjI/410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-42-67ff5e51dff5
Message-ID: <00619904-9111-4e75-9ff7-1494ed299f9b@sk.com>
Date: Wed, 16 Apr 2025 16:37:52 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, akpm@linux-foundation.org, gourry@gourry.net,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, david@redhat.com, osalvador@suse.de,
 yunjeong.mun@sk.com
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Rakie Kim <rakie.kim@sk.com>
References: <20250408073243.488-1-rakie.kim@sk.com>
 <20250408073243.488-4-rakie.kim@sk.com> <20250415170031.0000372b@huawei.com>
 <6a651c16-7ffc-42a5-8c98-95949073c804@sk.com>
In-Reply-To: <6a651c16-7ffc-42a5-8c98-95949073c804@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsXC9ZZnoW5g3P90g5UtUhZz1q9hs5g+9QKj
	xdf1v5gtft49zm6xauE1NovjW+exW5yfdYrF4vKuOWwW99b8Z7U4M63IYvWaDAduj52z7rJ7
	dLddZvdoOfKW1WPxnpdMHps+TWL3ODHjN4vHzoeWHu/3XWXz2Hy62uPzJrkArigum5TUnMyy
	1CJ9uwSujK87trAVvOeoWHDgGXMD4z+2LkZODgkBE4m/r5exw9jbZi1hAbF5BSwl/iy4CxZn
	EVCV2He7FyouKHFy5hMwW1RAXuL+rRlANVwczAIrmSQ+3P8H5HBwCAtESvzsdwapYRYQkZjd
	2cYMYrMJqElceTmJCcQWEQiSeDrjKTNIr5DAJkaJn5MOgx3EKWAlMfXpJTaIZjOJrq1djBC2
	vETz1tlgDRIC/ewSnf23GSGulpQ4uOIGywRGwVlIDpyFZPksJLNmIZm1gJFlFaNQZl5ZbmJm
	joleRmVeZoVecn7uJkZgjC2r/RO9g/HTheBDjAIcjEo8vBHx/9KFWBPLiitzDzFKcDArifCe
	MwcK8aYkVlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYBR9l/hl
	jufqmU8mm3fWfVjvIxZ9f1Jck983L3FFv0nL2Of63Ih7e+T7tdj67GbPsiWWLBJXor92Nqvp
	2Tu77SzivfR/UWGOw4el2qHfzQQTaudpsc2udJrDvuwFw0wbF0EThhde7FvWx3BO2eX/luPY
	ebODXyW4RWM02Jfc2nflYtufeaeY2ZVYijMSDbWYi4oTAfM9NQqtAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LhmqGlpxsY9z/dYNNvbos569ewWUyfeoHR
	4uv6X8wWP+8eZ7dYtfAam8XxrfPYLQ7PPclqcX7WKRaLy7vmsFncW/Of1eLMtCKLQ9ees1qs
	XpNh8XvbCjYHPo+ds+6ye3S3XWb3aDnyltVj8Z6XTB6bPk1i9zgx4zeLx86Hlh7v911l8/h2
	28Nj8YsPTB6bT1d7fN4kF8ATxWWTkpqTWZZapG+XwJXxdccWtoL3HBULDjxjbmD8x9bFyMkh
	IWAisW3WEhYQm1fAUuLPgrvsIDaLgKrEvtu9UHFBiZMzn4DZogLyEvdvzQCq4eJgFljJJPHh
	/j8gh4NDWCBS4me/M0gNs4CIxOzONmYQm01ATeLKy0lMILaIQJDE0xlPmUF6hQQ2MUr8nHQY
	7AhOASuJqU8vsUE0m0l0be1ihLDlJZq3zmaewMg3C8kds5DsmIWkZRaSlgWMLKsYRTLzynIT
	M3NM9YqzMyrzMiv0kvNzNzECo2lZ7Z+JOxi/XHY/xCjAwajEwxsR/y9diDWxrLgy9xCjBAez
	kgjvOXOgEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA2NE
	s82F/w1Nv2fYSJzK/iGeYvA/Wez3vHw7gx+iuzmWL5pbIvr8q2jwgsJ9paFvHGUs5KYaBSVc
	0np4+rqiuuuOKTK1zWZPP79L0f/JGL/2regTiXl5u+xMP5qmpOU3FgjLr595O3bx5JmqL8oM
	M5a1Pjteuat49kPrX9NidG0s9K6yijM4VCuxFGckGmoxFxUnAgAA0KX2ogIAAA==
X-CFilter-Loop: Reflected



On 4/16/2025 1:04 PM, Honggyu Kim wrote:
> Hi Jonathan,
> 
> Thanks for reviewing our patches.
> 
> I have a few comments and the rest will be addressed by Rakie.
> 
> On 4/16/2025 1:00 AM, Jonathan Cameron wrote:
>> On Tue, 8 Apr 2025 16:32:42 +0900
>> Rakie Kim <rakie.kim@sk.com> wrote:
[...snip...]
>>> @@ -3495,35 +3508,77 @@ static const struct kobj_type wi_ktype = {
>>>   static int sysfs_wi_node_add(int nid)
>>>   {
>>> -    struct iw_node_attr *node_attr;
>>> +    int ret = 0;
>>
>> Trivial but isn't ret always set when it is used? So no need to initialize
>> here.
> 
> If we don't initialize it, then this kind of trivial fixup might be needed later
> so I think there is no reason not to initialize it.
> https://lore.kernel.org/mm-commits/20240705010631.46743C4AF07@smtp.kernel.org

Ah.  This is a different case.  Please ignore this.

> 
>>
>>>       char *name;
>>> +    struct iw_node_attr *new_attr = NULL;
>>
>> This is also always set before use so I'm not seeing a
>> reason to initialize it to NULL.
> 
> Ditto.

Please ignore this too.

Thanks,
Honggyu
