Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0F62EAB82;
	Thu, 15 Jan 2026 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508555; cv=none; b=OdzzjhslHGlJO+z+x49DUijMkqFkBk0ii/XHEaF8/mDnLV9Nzaxe6Z12YZIMXu3lFLAsJrQxJxC8sLznxtD3eWmfkOpHnM0T376qCATotibeVTucUUtK3Y97eyU9daHWteo9Tk7WuPJLoFu85YLHdxD2YcXAuqaLcyUe930OFhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508555; c=relaxed/simple;
	bh=1hddCG3xZm/iiLHpPmyWA0LbsiF/+3oaYQmfb6kzP2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JzDHoBWEKwqgNg2YTBC/Uk3CBKPFk4PBHmf+fH5VSoecI+UIDE89EVoKFhfIj094wmU3S671pFWc1dF710++dEaPGqWcHP3PatorEzc1lJOqc9sXxypu2HC42jvl6i9ClkTzXATb9yed0coMN2uSbviV1jHlBIkj6HzYxQyuRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9qY3ysQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9qY3ysQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC72EC19422;
	Thu, 15 Jan 2026 20:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768508554;
	bh=1hddCG3xZm/iiLHpPmyWA0LbsiF/+3oaYQmfb6kzP2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h9qY3ysQ0ie8RBLLbvg84OXV5EKQQR9D2zZjbIgXTYwqFEOarV5Pom2h6aQDS+joc
	 mtP5ye5rHB5JxqXdC40G6sxfKaV8qD0a+8wdqYWAw36i8e5is9TJGt6ag0MXCm1mt8
	 Lc/eSGDTLBeg4MuxvgYbRUiq5MkFPju6wTx6k0SjS8oqq2eT//EVO5RF/kFWNkaWTe
	 lGz+4ndG6+n+2ZINMdsmbYmEBijbZuetaxu8wB63cFto07iGcOGbr2V02O5DZPEax9
	 nYSYIilIFGx+atyNQV5Lv1TOi5wYX6roUQWGxbYqFpCuiBc3nxGK9O198eofZulYeI
	 oNcfnjQdgCvKQ==
Message-ID: <65cdc2fa-b6ba-4422-9537-feb7d3a33210@kernel.org>
Date: Thu, 15 Jan 2026 21:22:28 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
To: dan.j.williams@intel.com, Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Li Zhe <lizhe.67@bytedance.com>, akpm@linux-foundation.org,
 ankur.a.arora@oracle.com, fvdl@google.com, joao.m.martins@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 mjguzik@gmail.com, muchun.song@linux.dev, osalvador@suse.de,
 raghavendra.kt@amd.com, linux-cxl@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, Gregory Price <gourry@gourry.net>,
 zhanjie9@hisilicon.com, wangzhou1@hisilicon.com
References: <9daa39e6-9653-45cc-8c00-abf5f3bae974@kernel.org>
 <20260115093641.44404-1-lizhe.67@bytedance.com>
 <83798495-915b-4a5d-9638-f5b3de913b71@kernel.org>
 <20260115115739.00007cf6@huawei.com>
 <23513e86-0769-4f3f-b90b-22273343a03c@kernel.org>
 <69694b06835e_34d2a100b3@dwillia2-mobl4.notmuch>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAa2VybmVsLm9yZz7CwY0EEwEIADcWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCaKYhwAIbAwUJJlgIpAILCQQVCgkIAhYCAh4FAheAAAoJEE3eEPcA/4Naa5EP/3a1
 9sgS9m7oiR0uenlj+C6kkIKlpWKRfGH/WvtFaHr/y06TKnWn6cMOZzJQ+8S39GOteyCCGADh
 6ceBx1KPf6/AvMktnGETDTqZ0N9roR4/aEPSMt8kHu/GKR3gtPwzfosX2NgqXNmA7ErU4puf
 zica1DAmTvx44LOYjvBV24JQG99bZ5Bm2gTDjGXV15/X159CpS6Tc2e3KvYfnfRvezD+alhF
 XIym8OvvGMeo97BCHpX88pHVIfBg2g2JogR6f0PAJtHGYz6M/9YMxyUShJfo0Df1SOMAbU1Q
 Op0Ij4PlFCC64rovjH38ly0xfRZH37DZs6kP0jOj4QdExdaXcTILKJFIB3wWXWsqLbtJVgjR
 YhOrPokd6mDA3gAque7481KkpKM4JraOEELg8pF6eRb3KcAwPRekvf/nYVIbOVyT9lXD5mJn
 IZUY0LwZsFN0YhGhQJ8xronZy0A59faGBMuVnVb3oy2S0fO1y/r53IeUDTF1wCYF+fM5zo14
 5L8mE1GsDJ7FNLj5eSDu/qdZIKqzfY0/l0SAUAAt5yYYejKuii4kfTyLDF/j4LyYZD1QzxLC
 MjQl36IEcmDTMznLf0/JvCHlxTYZsF0OjWWj1ATRMk41/Q+PX07XQlRCRcE13a8neEz3F6we
 08oWh2DnC4AXKbP+kuD9ZP6+5+x1H1zEzsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCgh
 Cj/CA/lc/LMthqQ773gauB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseB
 fDXHA6m4B3mUTWo13nid0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts
 6TZ+IrPOwT1hfB4WNC+X2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiu
 Qmt3yqrmN63V9wzaPhC+xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKB
 Tccu2AXJXWAE1Xjh6GOC8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvF
 FFyAS0Nk1q/7EChPcbRbhJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh
 2YmnmLRTro6eZ/qYwWkCu8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRk
 F3TwgucpyPtcpmQtTkWSgDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0L
 LH63+BrrHasfJzxKXzqgrW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4v
 q7oFCPsOgwARAQABwsF8BBgBCAAmAhsMFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmic2qsF
 CSZYCKEACgkQTd4Q9wD/g1oq0xAAsAnw/OmsERdtdwRfAMpC74/++2wh9RvVQ0x8xXvoGJwZ
 rk0Jmck1ABIM//5sWDo7eDHk1uEcc95pbP9XGU6ZgeiQeh06+0vRYILwDk8Q/y06TrTb1n4n
 7FRwyskKU1UWnNW86lvWUJuGPABXjrkfL41RJttSJHF3M1C0u2BnM5VnDuPFQKzhRRktBMK4
 GkWBvXlsHFhn8Ev0xvPE/G99RAg9ufNAxyq2lSzbUIwrY918KHlziBKwNyLoPn9kgHD3hRBa
 Yakz87WKUZd17ZnPMZiXriCWZxwPx7zs6cSAqcfcVucmdPiIlyG1K/HIk2LX63T6oO2Libzz
 7/0i4+oIpvpK2X6zZ2cu0k2uNcEYm2xAb+xGmqwnPnHX/ac8lJEyzH3lh+pt2slI4VcPNnz+
 vzYeBAS1S+VJc1pcJr3l7PRSQ4bv5sObZvezRdqEFB4tUIfSbDdEBCCvvEMBgoisDB8ceYxO
 cFAM8nBWrEmNU2vvIGJzjJ/NVYYIY0TgOc5bS9wh6jKHL2+chrfDW5neLJjY2x3snF8q7U9G
 EIbBfNHDlOV8SyhEjtX0DyKxQKioTYPOHcW9gdV5fhSz5tEv+ipqt4kIgWqBgzK8ePtDTqRM
 qZq457g1/SXSoSQi4jN+gsneqvlTJdzaEu1bJP0iv6ViVf15+qHuY5iojCz8fa0=
In-Reply-To: <69694b06835e_34d2a100b3@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 21:16, dan.j.williams@intel.com wrote:
> David Hildenbrand (Red Hat) wrote:
> [..]
>>> Give me a list of 1Gig pages and this stuff becomes much more efficient
>>> than anything the CPU can do.
>>
>> Right, and ideally we'd implement any such mechanisms in a way that more
>> parts of the kernel can benefit, and not just an unloved in-memory
>> file-system that most people just want to get rid of as soon as we can :)
> 
> CPUs have tended to eat the value of simple DMA offload operations like
> copy/zero over time.
> 
> In the case of this patch there is no async-offload benefit because
> userspace is already charged with spawning more threads if it wants more
> parallelism.

In this subthread we're discussing handling that in the kernel like 
init_on_free. So when user space frees a hugetlb folio (or in the 
future, other similarly gigantic folios from another allocator), we'd be 
zeroing it.

If it would be freeing multiple such folios, we could pack them and send 
them to a DMA engine to zero them for us (concurrently? asynchronously? 
I don't know :) )

-- 
Cheers

David
