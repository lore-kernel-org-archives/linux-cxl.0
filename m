Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A93C0606
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224278; cv=none; b=O3jhVRduap0Wkt/cnydC5x/qJ6W6Zh766rqPSlfG8fYSI+YFJeIQTWmcx3Hc1mnp2qsL8iJb8F05UrAqT3Q+oDl1OYV8N0f4M3OMvuhZbqIImHniPj/3pXyb3zHZqr03ZonT4AZys7j0hjUOhXAQTv3WiRYHFCkODs39A5GcY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224278; c=relaxed/simple;
	bh=qXCXs5eTvMMrV3gX+EG0DEGCGtTLz0/FDRY13K0lWY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhgPS8EAbPYso/7joevrTdEpHsawbNfkomwgqG3OkJczgAVDcaBXKzHiMdkb8AoeSfsB1KXC0vFyQvkf2pHjWm29IMyCDXOV/tN2jS8F6qfhbnDug+ptPW3PD7tSh19ed8C97lqA2iHIcY1PfaZ/gfONjjOO85Fku54thkz6Hvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCz389n6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCz389n6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2481F000E9;
	Tue, 19 May 2026 20:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224277;
	bh=0F029817nyKUr7CFBi5Vq/YSZmB8vzA5KAIFJjfUk/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RCz389n6oWy12KGSz/J55rCFtQ2TUbSNK4pcRKpdT+0SvwDpxmaP9S7uzxckDGSq5
	 bqeW3B4bF8f/IOb0bcMN2ZJ/4UwUrEF2chFyLDUY9ZedyZb7RQgMciAaQtJ5mQUW8k
	 46X4YCg108Ii+MxwoTedQ6qdJ3mUrm+A33USa9ZDmQwGOoWqL1TJr+ffMiB+ZkmbpG
	 u2XR/0Z/22FecJ+vjj9tyd9hu6Ax0IRb1PWO7T8tjxoYhdjDgCwSISMN3/QLzXHiPc
	 kDMN8JqErH+Hpd8gTQf49jVnhEpKUWJm69SYjJhSFLNRHD7SJeLlhi3BTTnMd+wWXp
	 +C1UQFm3HeHXw==
Message-ID: <90c0af4b-f608-42e5-9f61-222d943bcebc@kernel.org>
Date: Tue, 19 May 2026 23:57:52 +0300
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/base/memory: set mem->altmap after successful
 device registration
To: Andrew Morton <akpm@linux-foundation.org>,
 Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: david@kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 Mike Rapoport <rppt@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>
References: <20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com>
 <20260519132522.421c018b39328ebc4767dd8e@linux-foundation.org>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20260519132522.421c018b39328ebc4767dd8e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/19/26 11:25 PM, Andrew Morton wrote:
> On Thu, 14 May 2026 02:26:57 -0700 Georgi Djakov <georgi.djakov@oss.qualcomm.com> wrote:
> 
>> If __add_memory_block() fails at xa_store() (under memory pressure
>> for example), device_unregister() is called, which eventually
>> triggers memory_block_release() with mem->altmap still set, causing
>> a WARN_ON(mem->altmap).
> 
> That isn't good.
> 
>> This was triggered by modifying virtio-mem
>> driver.
>>
>> Fix this by delaying the assignment of mem->altmap until after
>> __add_memory_block() has succeeded.
>>
>> Fixes: 1a8c64e11043 ("mm/memory_hotplug: embed vmem_altmap details in memory block")
> 
> Patch is nice and simple so I'll add a cc:stable to this, even though
> the issue seems rather minor.
> 
> btw, AI review had no issue with your change but might have found a bug
> in create_altmaps_and_memory_blocks():
> 
> 	https://sashiko.dev/#/patchset/20260514092657.3057141-1-georgi.djakov@oss.qualcomm.com

Yes, i have hit exactly this bug actually (shortly after this WARN_ON, we crash)
and was going to send a fix, but noticed that someone already did:
https://lore.kernel.org/lkml/20260428081855.1249045-3-songmuchun@bytedance.com/

I can respond with my RB on that one if you haven't applied it yet.

BR,
Georgi
