Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE002E1EE7;
	Mon, 15 Jun 2026 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497187; cv=none; b=eux+EX0q2pCdBeauT3K3AHe4MSZ1Eh+/5DQW5/dvkNgGUdtsjROoqf0Tjfr/vbMqLtxiVGAeq/xg8vjVwngGsI2BmIm12pgydZ9yK4jqqlBvmn701O48qMRgMAumAo8gDg2vCrt0rW4ygFyYSVBVU14gieddxWq4DypjN8N9s0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497187; c=relaxed/simple;
	bh=awkC/x5sxPMUOQuuKL9cfTO+IenDNzK9QiTgEcVEQcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDILroh1cRtNRE0WpPrLUfaXdL7EYw45tg0h9tLVzaqGHb7O1OjXfp7MUGR/RcXWw5eeo2TsCIPDx/1Yy5/kEtK2rSP7Udf4/U9DfwXklKKoUesmHcHRwMyXy7lBMJScPbJuDFn4EopLAt2h8Zg66L7tsDO0pH8LNM6nJiXKOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with SMTP id HwEQrAD3zTQvfS9qfd8mAA--.42428S2;
	Mon, 15 Jun 2026 12:18:55 +0800 (CST)
Received: from [10.12.169.118] (unknown [10.12.169.118])
	by gateway (Coremail) with SMTP id _____wAnHcwsfS9q4stRAA--.35173S2;
	Mon, 15 Jun 2026 12:18:54 +0800 (CST)
Message-ID: <6ff7bedc-76df-49bf-9184-a5e4af9b13c3@hust.edu.cn>
Date: Mon, 15 Jun 2026 12:18:52 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: docs/linux/dax-driver - fix typos
To: Zenghui Yu <zenghui.yu@linux.dev>, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 djbw@kernel.org, gourry@gourry.net, corbet@lwn.net, skhan@linuxfoundation.org
References: <20260614161458.88942-1-zenghui.yu@linux.dev>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20260614161458.88942-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HwEQrAD3zTQvfS9qfd8mAA--.42428S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyfXr1DJFW7Wr1fCw48Zwb_yoW8GFWrpF
	4xJ3y3tFyDAay7Cw48GasF9FyUZa97Ga1UCa4293s5ZFnIyFnakF9xta1YvFyrGry09FW2
	q3WjyFyj93WYy37anT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ2b7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04
	k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUs_OzDUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 6/15/26 12:14 AM, Zenghui Yu wrote:
> Fix two obvious typos in the "kmem conversion" section.
>
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>   Documentation/driver-api/cxl/linux/dax-driver.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/driver-api/cxl/linux/dax-driver.rst b/Documentation/driver-api/cxl/linux/dax-driver.rst
> index 10d953a2167b..72c85a0f8606 100644
> --- a/Documentation/driver-api/cxl/linux/dax-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/dax-driver.rst
> @@ -35,9 +35,9 @@ will be exposed to the kernel page allocator in the user-selected memory
>   zone.
>   
>   The :code:`memmap_on_memory` setting (both global and DAX device local)
> -dictates where the kernell will allocate the :code:`struct folio` descriptors
> +dictates where the kernel will allocate the :code:`struct folio` descriptors
>   for this memory will come from.  If :code:`memmap_on_memory` is set, memory
>   hotplug will set aside a portion of the memory block capacity to allocate
>   folios. If unset, the memory is allocated via a normal :code:`GFP_KERNEL`
> -allocation - and as a result will most likely land on the local NUM node of the
> +allocation - and as a result will most likely land on the local NUMA node of the
>   CPU executing the hotplug operation.

