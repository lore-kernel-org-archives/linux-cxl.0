Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3604757F3;
	Thu, 10 Apr 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291533; cv=none; b=JeGQ3BPVLw0UHcQ1fzqjVQ668qAUCNuuBngmjwIKaOs1C3dVQAEBQrB0CWvzorC/eVkHnKUXR8sRx5Td/TFV7SC5wmJyfyeeOvC/fO8IF1NC9fIfKltV4dT5EfBKhSwxUyryHWgQnC2C0330D3XUpLbJXdoVKC27nYUqLeNnia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291533; c=relaxed/simple;
	bh=x5bDpHp365CfjBfwmEPEq3ZmJcMhy/CTh70fae+6WcI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r/GYKke8rOO0AuJyCSPQOYYnGVkemRJB1fXo6U9sr161bgqWehww4EF9mMEH5GN0doUl641UPYNy26dyyC+KT1i4JS9A287bBZrGppoa/5MeurlbD6JTRQf+TshwHbqmuGYuUgLFffvRfe7B5WcWuKF9td4GKZsmD0xlpixP9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-c8-67f7c6c2b057
Message-ID: <755ad3ff-17d5-4610-94ce-2f2d775b518d@sk.com>
Date: Thu, 10 Apr 2025 22:25:22 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, gourry@gourry.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, Jonathan.Cameron@huawei.com,
 osalvador@suse.de, yunjeong.mun@sk.com
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
To: David Hildenbrand <david@redhat.com>, Rakie Kim <rakie.kim@sk.com>,
 akpm@linux-foundation.org
References: <20250408073243.488-1-rakie.kim@sk.com>
 <20250408073243.488-4-rakie.kim@sk.com>
 <19562f7e-38ce-41fc-8dfc-bfd6b1259291@redhat.com>
 <b58f2dd6-d978-487a-b420-badfb4847c00@sk.com>
 <203ed4e9-4691-483c-bf42-3035b3ad3539@redhat.com>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <203ed4e9-4691-483c-bf42-3035b3ad3539@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsXC9ZZnke7hY9/TDdYeZbKYs34Nm8X0qRcY
	Lb6u/8Vs8fPucXaLVQuvsVkc3zqP3eL8rFMsFpd3zWGzuLfmP6vFmWlFFqvXZDhwe+ycdZfd
	o7vtMrtHy5G3rB6L97xk8tj0aRK7x4kZv1k8dj609Hi/7yqbx+bT1R6fN8kFcEVx2aSk5mSW
	pRbp2yVwZaz+dpOxYIdExZrTixkbGD8JdzFyckgImEjs//SQHcbe862LFcTmFbCUmL3oOlCc
	g4NFQFVixi9NiLCgxMmZT1hAbFEBeYn7t2YAlXBxMAvMZJJ4cXQtK0i9sECkxM9+Z5AaEYFk
	icNnzjCD1AgJfGWUWL1oMdguZgERidmdbcwgNpuAmsSVl5OYQHo5Bewkun5YQZSYSXRt7WKE
	sOUlmrfOBpsjITCZXWLim+lQN0tKHFxxg2UCo+AsJPfNQrJiFpJZs5DMWsDIsopRKDOvLDcx
	M8dEL6MyL7NCLzk/dxMjML6W1f6J3sH46ULwIUYBDkYlHt4dq7+nC7EmlhVX5h5ilOBgVhLh
	9TQECvGmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl4uCUamBcPLkn
	RmWdBnPkE6bEvC1MQWYH3S5tuVOz3kqy5dNm/6tt8zO/memvqg5hFJLW+3diqzJ3tGHktGub
	H27ctP3P39BYr3IGwSO8b4y1DPinuC2cISi+oXG73NPAifHX3pWcs19WFOo3I9k9nO+K0O3i
	lqDfQnLOD/+nLdDekSHZznqp7/P1DxxKLMUZiYZazEXFiQA9tucpqwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LhmqGlp3vo2Pd0gx1/DCzmrF/DZjF96gVG
	i6/rfzFb/Lx7nN1i1cJrbBbHt85jtzg89ySrxflZp1gsLu+aw2Zxb81/Vosz04osDl17zmqx
	ek2Gxe9tK9gc+Dx2zrrL7tHddpndo+XIW1aPxXteMnls+jSJ3ePEjN8sHjsfWnq833eVzePb
	bQ+PxS8+MHlsPl3t8XmTXABPFJdNSmpOZllqkb5dAlfG6m83GQt2SFSsOb2YsYHxk3AXIyeH
	hICJxJ5vXawgNq+ApcTsRdfZuxg5OFgEVCVm/NKECAtKnJz5hAXEFhWQl7h/awZQCRcHs8BM
	JokXR9eygtQLC0RK/Ox3BqkREUiWOHzmDDNIjZDAV0aJ1YsWs4MkmAVEJGZ3tjGD2GwCahJX
	Xk5iAunlFLCT6PphBVFiJtG1tYsRwpaXaN46m3kCI98sJGfMQjJpFpKWWUhaFjCyrGIUycwr
	y03MzDHVK87OqMzLrNBLzs/dxAiMpGW1fybuYPxy2f0QowAHoxIP747V39OFWBPLiitzDzFK
	cDArifB6GgKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4OKUa
	GAsWqrxXqJmR9+Djt/XnC1UiJFXknyuEL9N8dddXk00xV1xb/Xpo8cabtrP8HtzfeLVwwsW/
	YeqM29+aL1zVcnAdwxJlTst0049XskU6Lbfea1lSNPnw+pWp3Zm9PxZNLv967/PvE3HuKlc3
	SKhfi7ab6sDCxZ59i6dke+XJmbynXL3VeHtnT1FiKc5INNRiLipOBADJCk+zoAIAAA==
X-CFilter-Loop: Reflected

Hi David,

On 4/9/2025 8:52 PM, David Hildenbrand wrote:
> On 09.04.25 13:39, Honggyu Kim wrote:
>> Hi David,
>>
>> On 4/9/2025 6:05 PM, David Hildenbrand wrote:
>>> On 08.04.25 09:32, Rakie Kim wrote:
[...snip...]
>>>> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
>>>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>>>> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
>>>
>>> Why are the other SOF in there? Are there Co-developed-by missing?
>>
>> I initially found the problem and fixed it with my internal implementation but
>> Rakie also had his idea so he started working on it.  His initial implementation
>> has almost been similar to mine.
>>
>> I thought Signed-off-by is a way to express the patch series contains our
>> contribution, but if you think it's unusual, then I can add this.
> 
> Please see Documentation/process/submitting-patches.rst,

Thanks for the info.

> and note that these are not "patch delivery" SOB.
> 
> "
> The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch's delivery path.

Yunjeong and I have been involved in finding the problem and also concluded this
issue is related to hotplug together with our initial implementations before
this patch.  So I guess it is the former case.

> "
> 
> and
> 
> "
> Co-developed-by: states that the patch was co-created by multiple developers;
> it is used to give attribution to co-authors (in addition to the author
> attributed by the From: tag) when several people work on a single patch.  Since
> Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
> followed by a Signed-off-by: of the associated co-author.  Standard sign-off

So the Co-developed-by comes before Signed-off-by.

> procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
> chronological history of the patch insofar as possible, regardless of whether
> the author is attributed via From: or Co-developed-by:.  Notably, the last
> Signed-off-by: must always be that of the developer submitting the patch.
> "
> 
> The SOB order here is also not correct.

It looks the below order is correct.  I saw this order in the official document
example as well.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.15-rc1#n516

>>     Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
>>     Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>>
>> For Yunjeong, the following can be added.
>>
>>     Tested-by: Yunjeong Mun <yunjeong.mun@sk.com>
> 
> That is probably the right thing to do if contribution was focused on testing.
> 
>>
>> However, this patch series is already in Andrew's mm-new so I don't want to
>> bother him again unless we need to update this patches for other reasons.
> 
> mm-new is exactly for these kind of things. We can ask Andrew to fix it up.

Rakie already asked him and he will update signinig tags at the next spin.
Thanks very much for your help!

Thanks,
Honggyu
