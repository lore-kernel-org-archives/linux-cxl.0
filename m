Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BED0298CC4;
	Fri, 23 Jan 2026 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158785; cv=none; b=DBgu1lGgBFuiiDWpksGRsOkE5kMl/6TVopA30hh5gOXFkKkQF9c9YhZKfMACSKQAwkH5x/6Fh+Qr8dzVDJXOtMHZdVNtTvV/tcLyFn6bkVHtZYEbTYqTihe+xOYLeLS7ONlRauCFYSZhMnaT3bT3cTswoHYO9PkG1bsC/fcVpf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158785; c=relaxed/simple;
	bh=zchr6X0y2CZwRw9NmuLVIsYX92oNSGIkS84wr0zMJRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JN1RFwm3mvcoS9UJsSkrqJW5Y9JxRERdpqo+nzksUIlt5E1vCYmshiMBJMrwB1nW9YQqnDJbV9TuFQ1Qk6+YBuUa1xm5TMLXA4oXBjMrJeOMmHB9JJRjqXPiN3+VVuEv3pp11euxBXHNAZMzObuAoYFlg0TBRC1N29Hi0zx8Ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDX3pppOHNpwsQ7Bg--.567S2;
	Fri, 23 Jan 2026 16:59:21 +0800 (CST)
Received: from [10.22.77.56] (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwCH3eplOHNpQ_cVAA--.23981S2;
	Fri, 23 Jan 2026 16:59:17 +0800 (CST)
Message-ID: <7b3e1f2d-7a6b-43c4-bab8-cb34d2d57991@phytium.com.cn>
Date: Fri, 23 Jan 2026 16:59:17 +0800
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
Cc: dan.j.williams@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mike Rapoport <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
 <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
 <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
 <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
 <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
 <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <20260122132807.7204b83e97e33290f6eb7d82@linux-foundation.org>
From: Cui Chao <cuichao1753@phytium.com.cn>
In-Reply-To: <20260122132807.7204b83e97e33290f6eb7d82@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAfwCH3eplOHNpQ_cVAA--.23981S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAEAGlyhIsEfwAAsq
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zw1kWr45Xw47CFy5uw1UGFg_yoW8Aw13pa
	y8Ka9YkFW5Gr1Syws2vw40qrWj9rs7GFyrXw15GryfA3s8Zr1ftr4xKFZ093WDWw4fJ342
	q3WUXrW5tFW5ZaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU


On 1/23/2026 5:28 AM, Andrew Morton wrote:
> On Thu, 22 Jan 2026 16:03:49 +0800 Cui Chao <cuichao1753@phytium.com.cn> wrote:
>
>>>> So please, tell us how much our users are hurting from this and please
>>>> make a recommendation on the backporting decision.
>>>>
>>> To add on here, Cui, please describe which shipping hardware platforms
>>> in the wild create physical address maps like this. For example, if this
>>> is something that only occurs in QEMU configurations or similar, then
>>> the urgency is low and it is debatable if Linux should even worry about
>>> fixing it.
>>>
>>> I know that x86 platforms typically do not do this. It is also
>>> within the realm of possibility for platform firmware to fix. So in
>>> addition to platform impact please also clarify why folks can not just
>>> ask for a firmware update to get this fixed without updating their
>>> kernel.
>> Andrew, Dan, thank you for your review.
>>
>> 1.Issue Impact and Backport Recommendation:
>>
>> ...
>>
>> Thus, I believe a kernel fix is necessary.
> Thanks, I posted all that into the changelog.
>
>> Therefore, I recommend backporting this patch to all stable kernel
>> series that support dynamic CXL region creation.
> It's helpful if we can tell -stable maintainers which kernel versions
> "support dynamic CXL region creation".  We communicate that by
> providing a Fixes: tag in the changelog.  Are you able to help identify
> a suitable commit for this?
Although the modified code is not in this commit, it is possible that 
since the beginning of support for dynamically creating CXL memory 
regions, this physical address layout and the issue of incorrect NUMA ID 
assignment needed to be considered and resolved.

Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")

-- 
Best regards,
Cui Chao.

