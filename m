Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF08356A29;
	Thu, 15 Jan 2026 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470205; cv=none; b=aS32CfIxou3n9JsVlokvWysZhYsH9OQDwsgPv9L78lCxAOGA7Y9wdwcDw2TTzCzRtP/QpS5wW/aFlNV3s06wgiOUgKhFtnxRKIIxlE9wImfoSuBpgV7EJSzuKP45XkyZoEOAv9xesPXLA02CJcVehZrPLIKUNDqlwYIpA8Fc7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470205; c=relaxed/simple;
	bh=nlE16eKxYb4COhihT92H911dWTK02thlUlvWENCa9CE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMvX99Z7s7k10c27mPH1yhqQsfMzUlPmk9v2TfkMFrIyLEm8BCatU+R5RNJLeVIVCegZmrCBCTqcBk8QpCqlsOPxeh0WnxmNibJNjHuATO7KC3jlWcyaFI4fWPeRqAPw7Di4mYjBJF7t2WJ561v8OytNgUEyi1hh6sT8xeTCq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn7ZmutmhpJtXUBQ--.777S2;
	Thu, 15 Jan 2026 17:43:10 +0800 (CST)
Received: from [10.22.77.56] (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBXruuntmhpi9oTAA--.20716S2;
	Thu, 15 Jan 2026 17:43:03 +0800 (CST)
Message-ID: <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
Date: Thu, 15 Jan 2026 17:43:02 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID of
 CFMW
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mike Rapoport <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
 <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
 <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
From: Cui Chao <cuichao1753@phytium.com.cn>
In-Reply-To: <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAfwBXruuntmhpi9oTAA--.20716S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAQAGln+JMEtAAAsE
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7CF1Duw1DCr4DKw45GF1DAwb_yoW8AF47pF
	4SqFWvgF4kJF1xGFs2vw1kX3WIqF409a17JrW7CFnrur4F9w18Jr4ayr1F9Fs7t34kGF1r
	XF4Dta4jqw1DXaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

When a CXL RAM region is created in userspace, the memory capacity of 
the newly created region is not added to the CFMW-dedicated NUMA node. 
Instead, it is accumulated into an existing NUMA node (e.g., NUMA0 
containing RAM). This makes it impossible to clearly distinguish between 
the two types of memory, which may affect memory-tiering applications.

On 1/9/2026 1:48 AM, Andrew Morton wrote:
> On Tue,  6 Jan 2026 11:10:42 +0800 Cui Chao <cuichao1753@phytium.com.cn> wrote:
>
>> In some physical memory layout designs, the address space of CFMW
>> resides between multiple segments of system memory belonging to
>> the same NUMA node. In numa_cleanup_meminfo, these multiple segments
>> of system memory are merged into a larger numa_memblk. When
>> identifying which NUMA node the CFMW belongs to, it may be incorrectly
>> assigned to the NUMA node of the merged system memory.
>>
>> Example memory layout:
>>
>> Physical address space:
>>      0x00000000 - 0x1FFFFFFF  System RAM (node0)
>>      0x20000000 - 0x2FFFFFFF  CXL CFMW (node2)
>>      0x40000000 - 0x5FFFFFFF  System RAM (node0)
>>      0x60000000 - 0x7FFFFFFF  System RAM (node1)
>>
>> After numa_cleanup_meminfo, the two node0 segments are merged into one:
>>      0x00000000 - 0x5FFFFFFF  System RAM (node0) // CFMW is inside the range
>>      0x60000000 - 0x7FFFFFFF  System RAM (node1)
>>
>> So the CFMW (0x20000000-0x2FFFFFFF) will be incorrectly assigned to node0.
>>
>> To address this scenario, accurately identifying the correct NUMA node
>> can be achieved by checking whether the region belongs to both
>> numa_meminfo and numa_reserved_meminfo.
> Thanks.
>
> Can you please help us understand the userspace-visible runtime effects
> of this incorrect assignment?

-- 
Best regards,
Cui Chao.

