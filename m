Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4558B303A12;
	Mon, 26 Jan 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418441; cv=none; b=L7iWd6/OLV6F6ygIdp4rSTdthZt+zkLq9L/q24JyJ/PbhAzprfa/toq7QcjOy8leJQlOy+7j7OexO35g2rG1/NzIB0/cSpEeK0hK3oQ38s1uSJZ3y0eYm6oLBFCdW6D9TCMhcP4M/waMku6ZdpC6pznVXnDe3XSzCzt8mwYgeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418441; c=relaxed/simple;
	bh=4eQrDZNXV5sLSJhe9LmmKIBEtk5Mr8s64c1XKPFNqKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjlkawrJIlPKJ5hBCELWrIx181C020bBa3ViCOV/zlDq9dwKO3aW5qxl4MJLr4zGxgLlu2wMIJBrx2c2CnEFlilPBpyqiCN6nFkWxzEg9dzP9H/JuT3U6PnEYti6zeliLRP8kfv85F0Tnh+YuVrl9BLZO+CHL1BTbVcTZT6RLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3A12tLndp7GBmAw--.30612S2;
	Mon, 26 Jan 2026 17:06:53 +0800 (CST)
Received: from [10.22.77.56] (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAHX+yrLndpaKIWAA--.39254S2;
	Mon, 26 Jan 2026 17:06:52 +0800 (CST)
Message-ID: <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
Date: Mon, 26 Jan 2026 17:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID of
 CFMW
To: Gregory Price <gourry@gourry.net>
Cc: dan.j.williams@intel.com, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mike Rapoport <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
 <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
 <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
 <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
 <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
 <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
From: Cui Chao <cuichao1753@phytium.com.cn>
In-Reply-To: <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAHX+yrLndpaKIWAA--.39254S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAHAGl2eO0EOAAAsw
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7WF1DKrWUXr4rXF13CF48JFb_yoW8Zw48pa
	yrKrZYyFnrKFyS9wn29w4DWr15ZFs5CayUCryUuFyxZF4q9F1ftr48tan09a9rJr1xC3W0
	qFsFqr93uF95Z3JanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU


On 1/24/2026 12:46 AM, Gregory Price wrote:
> On Thu, Jan 22, 2026 at 04:03:49PM +0800, Cui Chao wrote:
>> 2.Why a Kernel Update is Recommended Over a Firmware Update:
>>
>> In the scenario of dynamic CXL region creation, the association between the
>> memory's HPA range and its corresponding NUMA node is established when the
>> kernel driver performs the commit operation. This is a runtime, OS-managed
>> operation where the platform firmware cannot intervene to provide a fix.
>>
> This is not accurate
>
> The memory-to-node association for CXL memory is built by acpi logic:
>
>     linux/drivers/acpi/numa/srat.c
>
> Specifically:
>
>     acpi_parse_memory_affinity()  /* if SRAT entry exists */
>        -> numa_add_memblk(node, start, end)
>
>     acpi_parse_cfmws()  /* if no SRAT entry exists */
>        -> numa_add_reserved_memblk(node, start, end)
>
>
> This patch implies the latter is occurring - as it queries the reserved
> block associations - meaning your platform is not shipping SRAT tables
> for CXL memory regions.
Sorry，my previous statement was ambiguous. What I intended to convey is 
that the moment when CXL memory is actually assigned to a dedicated NUMA 
node and becomes ready for use by applications is precisely during the 
creation of the region.
> We have only seen this in QEMU - and this is correctable in firmware.
>
> But if this is shipped hardware, letting us know the platform lets us
> know whether we should backport it.
>
> ---
>
> All that said, this does look harmless, and seems reasonable - but the
> changelog should reflect what the hardware is doing above.
This issue was discovered on the QEMU platform. I need to apologize for 
my earlier imprecise statement (claiming it was hardware instead of 
QEMU). My core point at the time was to emphasize that this is a problem 
in the general code path when facing this scenario, not a QEMU-specific 
emulation issue, and therefore it could theoretically affect real 
hardware as well. I apologize for any confusion this may have caused.
>
> ~Gregory

-- 
Best regards,
Cui Chao.

