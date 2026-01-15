Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1D30E828;
	Thu, 15 Jan 2026 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768471633; cv=none; b=o13JstyIN0AM269lye41vbjmoHN5QHVIZph2aK7q3M446i8rKX9pjKLlMMU6WovdmdEZRlSkucsf/Qdbjh/cIZcdGkK9JVo6VvWbmvG+Exvw9PCEZgw4toNPPT7JZ5Z9TJepl5bQJXGnpkklipbSS8RVI4Q/wQekuOqB64Rf1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768471633; c=relaxed/simple;
	bh=UpflQX4vP7lE2J666JiCo/LobwdUEbc5WPF9bwD7e0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMrduXIRCTOE/peubBWx4z0r/3jYyPs7mjIY6uaBXrGywCj+urKTpgqIphA83WKqu8gs6/QB8KGQBHDAmT40+werXVdO1rwXDUKeoAvnYhJfuiowjxdy+y/XHvmhjrDPaLIpIDB6FpDVAfKIRRO0wybSvwh3Z82yeOkEP+FcHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwAnCSY5vGhp01wiAw--.43130S2;
	Thu, 15 Jan 2026 18:06:49 +0800 (CST)
Received: from [10.22.77.56] (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwCH3us1vGhpfdsTAA--.20387S2;
	Thu, 15 Jan 2026 18:06:46 +0800 (CST)
Message-ID: <0e1e1b5f-df0c-459d-9cba-5bde5ad56ba3@phytium.com.cn>
Date: Thu, 15 Jan 2026 18:06:45 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID of
 CFMW
To: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Cc: Wang Yinfeng <wangyinfeng@phytium.com.cn>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mike Rapoport <rppt@kernel.org>
References: <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
 <CALzOmR2z0noh74aCAd=QVUBgdn7Q+Hbevs-cr1EtV_zXCuQ=PA@mail.gmail.com>
From: Cui Chao <cuichao1753@phytium.com.cn>
In-Reply-To: <CALzOmR2z0noh74aCAd=QVUBgdn7Q+Hbevs-cr1EtV_zXCuQ=PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCH3us1vGhpfdsTAA--.20387S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAQAGln+JMEtAABsF
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxuryfJrW8tFW5try5tr4fXwb_yoW5XF47pF
	1aqa9YgF4kJr1xGFs293WUAw1IqFsa9F45XFZrCrnxZa1Ygr15Zryaqr1F9F1ktrWrCF1F
	qF4Dt3WYvw1UZaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU


On 1/9/2026 5:35 PM, Pratyush Brahma wrote:
> On Fri, Jan 9, 2026 at 12:44 PM Cui Chao <cuichao1753@phytium.com.cn> wrote:
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
>>
>> Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> ---
>>   mm/numa_memblks.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
>> index 5b009a9cd8b4..e91908ed8661 100644
>> --- a/mm/numa_memblks.c
>> +++ b/mm/numa_memblks.c
>> @@ -568,15 +568,16 @@ static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
>>   int phys_to_target_node(u64 start)
>>   {
>>          int nid = meminfo_to_nid(&numa_meminfo, start);
>> +       int reserved_nid = meminfo_to_nid(&numa_reserved_meminfo, start);
>>
>>          /*
>>           * Prefer online nodes, but if reserved memory might be
>>           * hot-added continue the search with reserved ranges.
> It would be good to change this comment as well. With the new logic
> you’re not just "continuing the search", you’re explicitly preferring
> reserved on overlap.
> Probably something like "Prefer numa_meminfo unless the address is
> also described by reserved ranges, in which case use the reserved
> nid."

Thanks.

I will revise the next version according to your suggestion.

>>           */
>> -       if (nid != NUMA_NO_NODE)
>> +       if (nid != NUMA_NO_NODE && reserved_nid == NUMA_NO_NODE)
>>                  return nid;
>>
>> -       return meminfo_to_nid(&numa_reserved_meminfo, start);
>> +       return reserved_nid;
>>   }
>>   EXPORT_SYMBOL_GPL(phys_to_target_node);
>>
>> --
>> 2.33.0
>>
-- 
Best regards,
Cui Chao.

