Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B248166D;
	Wed, 21 Jan 2026 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998756; cv=none; b=qXLNkT38hQgJqhsDuW9xoyUM01RSCURaxVIzYg5Fq/tYsy8fPRI2t0owKuS53H01FpMx0MrytjWN6YHgrwMqfjAi9XRouIdOBBLr7DiuE3sCW7KAbFg/m2ErczzwJL9nveMfd07AYmfd0uYB12Ffdp0QMDlAGw+uC6UNgjJdVI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998756; c=relaxed/simple;
	bh=Urvd/N57mhTCzV1hIjinqqtH/SRw4kq7Kx76LANoLZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2GRbrfaeJQ54viyny4KpfNwZG0mCm/pDeE8E4LGpXF/U39bA79oTCifuUpvwCigX263UpXRy5tCOpgNF/I0zHzHNE3QE/a43HIPFaMwW3AkvZJyfJZw4DDA9e/VDYixOpyQ5g0uG1H8IJ5aHGj78Q3FiXyM/B+k5ubnyj2tdLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3kvy/nr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3kvy/nr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF1BC116D0;
	Wed, 21 Jan 2026 12:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768998756;
	bh=Urvd/N57mhTCzV1hIjinqqtH/SRw4kq7Kx76LANoLZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z3kvy/nrtc1ODOdK9vKo/8F+DqtLW8vS+My2lkW4TBV/LV9AqWY20lPS+4Kwd7sKu
	 peVDMJsmgI/nDfqRZw+JKl4cxiyWX+uR1cUh2TtbbKI+C//BubJ30civbuNnWaIQx3
	 IKjUDwqf7ZA+26d2GK/zjj0DVhoZeeLpEs+eIQTDN7q6VqaauCWLIXiJILerttyumA
	 UhT/nB7R7pLcxh6RuIxudUFVc79gyTia1AysbtMswNY6me1dELYKK8M2hiR+mgCBz1
	 +rMrHS5id45rCl1uNxMoG4KaNuNc38uGNf4szzh9FP1u9wbc8o9qMPWmQYjQdvg/s8
	 l8X3BFRa2qWIQ==
Message-ID: <54a7e6ff-b3bc-4de4-af26-03fa1400d5f9@kernel.org>
Date: Wed, 21 Jan 2026 13:32:29 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
To: David Laight <david.laight.linux@gmail.com>,
 Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, dave@stgolabs.net,
 ankur.a.arora@oracle.com, fvdl@google.com, gourry@gourry.net,
 joao.m.martins@oracle.com, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mhocko@suse.com, mjguzik@gmail.com, muchun.song@linux.dev,
 osalvador@suse.de, raghavendra.kt@amd.com, wangzhou1@hisilicon.com,
 zhanjie9@hisilicon.com
References: <87wm1ih5kb.fsf@oracle.com>
 <20260120062706.91078-1-lizhe.67@bytedance.com>
 <20260120094744.5d92e34a@pumpkin>
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
In-Reply-To: <20260120094744.5d92e34a@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/26 10:47, David Laight wrote:
> On Tue, 20 Jan 2026 14:27:06 +0800
> "Li Zhe" <lizhe.67@bytedance.com> wrote:
> 
>> In light of the preceding discussion, we appear to have reached the
>> following understanding:
>>
>> (1) At present we prefer to mitigate slow application startup (e.g.,
>> VM creation) by zeroing huge pages at the moment they are freed
>> (init_on_free). The principal benefit is that user space gains the
>> performance improvement without deploying any additional user space
>> daemon.
> 
> Am I missing something?
> If userspace does:
> $ program_a; program_b
> and pages used by program_a are zeroed when it exits you get the delay
> for zeroing all the pages it used before program_b starts.
> OTOH if the zeroing is deferred program_b only needs to zero the pages
> it needs to start (and there may be some lurking).

Can you point me to where was that spelled out as a requirement?

> 
> The only real gain has to come from zeroing pages when the system is idle.
> That will give plenty of zeroed pages needed for starting a web browser
> from the desktop and also speed up single-threaded things like 'make -j1'.

I am strictly against over-engineering any features that hugetlb 
benefits from only.

-- 
Cheers

David
