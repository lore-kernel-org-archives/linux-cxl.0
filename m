Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AE38756B;
	Thu, 22 Jan 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069052; cv=none; b=tgRrB1Tdyax/UeGe1NPLu+q+aiY/impWPpb8iMS02bajY/Rt0poj1UquUvDdFxYVWSBA20ZqBKHL1zJ4W0USo0BhwXIP7RzWC/1Klsu1ikC6Af3JSgd2C6jpoHFn5JS4QzXIwj5WsoyCUbafzcJHukIYxZ15jqQ1r2XIxscrzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069052; c=relaxed/simple;
	bh=sUEizkO6EuH1LoEr1FTbUUx+i/+3SwlDnGfcAZMhWAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDVXtbFBcNhZxeaBDzNT+B+/jgih+ZzG3BcvTqyhIZJlgooPGJwYq+aSJ4g150fQVF+MrrssgLiqtFMxpEP0H7g+Sl35KeRS9G0C6aTktavjlwAxOgm7XbNPOznCVTQFGXy1ZxzMxmxYafyWT6iayq6qmRxbQD8vWK0wkzmRx+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnVVzo2XFpC0dMAw--.53929S2;
	Thu, 22 Jan 2026 16:03:52 +0800 (CST)
Received: from [10.22.77.56] (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDnQO7m2XFpT6cVAA--.38292S2;
	Thu, 22 Jan 2026 16:03:51 +0800 (CST)
Message-ID: <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
Date: Thu, 22 Jan 2026 16:03:49 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID of
 CFMW
To: dan.j.williams@intel.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mike Rapoport <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
 <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
 <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
 <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
 <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
From: Cui Chao <cuichao1753@phytium.com.cn>
In-Reply-To: <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAfwDnQO7m2XFpT6cVAA--.38292S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQADAGlxMvwDCgAAsd
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCr4kWr1fAFyDtw4kWrWUCFg_yoWrCF13pa
	y8JFWvyr4DGryIkr1kXw4kXr1F9ws7Gay3Gry5Cr95CrnxZF1F9r4SqayYvFZ3Gr1fWw1j
	qF4jqrWjv3Z8ZaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU


On 1/16/2026 3:50 AM, dan.j.williams@intel.com wrote:
> Andrew Morton wrote:
>> On Thu, 15 Jan 2026 17:43:02 +0800 Cui Chao <cuichao1753@phytium.com.cn> wrote:
>>
>>> When a CXL RAM region is created in userspace, the memory capacity of
>>> the newly created region is not added to the CFMW-dedicated NUMA node.
>>> Instead, it is accumulated into an existing NUMA node (e.g., NUMA0
>>> containing RAM). This makes it impossible to clearly distinguish between
>>> the two types of memory, which may affect memory-tiering applications.
>>>
>> OK, thanks, I added this to the changelog.  Please retain it when
>> sending v3.
>>
>> What I'm actually looking for here are answers to the questions
>>
>>    Should we backport this into -stable kernels and if so, why?
>>    And if not, why not?
>>
>> So a very complete description of the runtime effects really helps
>> myself and others to decide which kernels to patch.  And it helps
>> people to understand *why* we made that decision.
>>
>> And sorry, but "may affect memory-tiering applications" isn't very
>> complete!
>>
>> So please, tell us how much our users are hurting from this and please
>> make a recommendation on the backporting decision.
>>
> To add on here, Cui, please describe which shipping hardware platforms
> in the wild create physical address maps like this. For example, if this
> is something that only occurs in QEMU configurations or similar, then
> the urgency is low and it is debatable if Linux should even worry about
> fixing it.
>
> I know that x86 platforms typically do not do this. It is also
> within the realm of possibility for platform firmware to fix. So in
> addition to platform impact please also clarify why folks can not just
> ask for a firmware update to get this fixed without updating their
> kernel.

Andrew, Dan, thank you for your review.

1.Issue Impact and Backport Recommendation:

This patch fixes an issue on hardware platforms (not QEMU emulation) 
where, during the dynamic creation of a CXL RAM region, the memory 
capacity is not assigned to the correct CFMW-dedicated NUMA node. This 
issue leads to:

  *

    Failure of the memory tiering mechanism: The system is designed to
    treat System RAM as fast memory and CXL memory as slow memory. For
    performance optimization, hot pages may be migrated to fast memory
    while cold pages are migrated to slow memory. The system uses NUMA
    IDs as an index to identify different tiers of memory. If the NUMA
    ID for CXL memory is calculated incorrectly and its capacity is
    aggregated into the NUMA node containing System RAM (i.e., the node
    for fast memory), the CXL memory cannot be correctly identified. It
    may be misjudged as fast memory, thereby affecting performance
    optimization strategies.

  *

    Inability to distinguish between System RAM and CXL memory even for
    simple manual binding: Tools like |numactl|and other NUMA policy
    utilities cannot differentiate between System RAM and CXL memory,
    making it impossible to perform reasonable memory binding.

  *

    Inaccurate system reporting: Tools like |numactl -H|would display
    memory capacities that do not match the actual physical hardware
    layout, impacting operations and monitoring.

This issue affects all users utilizing the CXL RAM functionality who 
rely on memory tiering or NUMA-aware scheduling. Such configurations are 
becoming increasingly common in data centers, cloud computing, and 
high-performance computing scenarios.

Therefore, I recommend backporting this patch to all stable kernel 
series that support dynamic CXL region creation.

2.Why a Kernel Update is Recommended Over a Firmware Update:

In the scenario of dynamic CXL region creation, the association between 
the memory's HPA range and its corresponding NUMA node is established 
when the kernel driver performs the commit operation. This is a runtime, 
OS-managed operation where the platform firmware cannot intervene to 
provide a fix.

Considering factors like hardware platform architecture, memory 
resources, and others, such a physical address layout can indeed occur. 
This patch does not introduce risk; it simply correctly handles the NUMA 
node assignment for CXL RAM regions within such a physical address layout.

Thus, I believe a kernel fix is necessary.

-- 
Best regards,
Cui Chao.

