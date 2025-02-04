Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEA208974
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663206; cv=none; b=vAFyEUn/Q/wOOBuuXNKORKJ/9qVeEA2JD4xkmBfbFPcQwp5bFCzBFmcOmDRoO9vxiPbZ9wXaWhwjAT6cQORQmLr/+0slra5IJO60pA8sW8ctREcwFZJWtoGfLa/v2nvHoizYJnnuQCnC+AEebnPlGJbL8OWFccEgrHpk4ZBf/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663206; c=relaxed/simple;
	bh=6czwO0fm8HFp1X0fKNO36in1vD1gSXIUzjzZYwzLOZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdcJ80XSIokEGa68WmWaBN1dyMrLsaKHu+3/FFAg++zW7gFUriej7uYyvNJ8wVYKfqBXYk+uQxB7lZT3VKwMdB4yKVF+tFiMAhz8q6+CYIpdu2RohenW4+zv6w8ZY7zYwkgojSxbOlFG4T2w+H8eWG9bQ3lQhgOA5/H4oqOV0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/58d+8M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/58d+8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738663203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m9EKHP4nynfCdNmUrSWbenO+oqa2jlQ1dNbX1aaC4cc=;
	b=J/58d+8M0NCusur5xxjEraY14/QOw0rGmZlKHLh5jXi0iHu/c+qmAlDKpmW/TBGjTakMzq
	zE9HJvS1wJAkOpFTKmuGzxfd47xLDK/RhrqBsUuEXHkpyWGxoGDYxumAxjbjhqJi9WXGex
	v3pHLm4ugenVEsHW02dL84rOgnLwg38=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-QvEGDVUpPNWGTt5mxUBxpQ-1; Tue, 04 Feb 2025 04:59:59 -0500
X-MC-Unique: QvEGDVUpPNWGTt5mxUBxpQ-1
X-Mimecast-MFC-AGG-ID: QvEGDVUpPNWGTt5mxUBxpQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so27910625e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 04 Feb 2025 01:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738663198; x=1739267998;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m9EKHP4nynfCdNmUrSWbenO+oqa2jlQ1dNbX1aaC4cc=;
        b=vpHY0NYtsPbJcMzh7CVHXq0cLXt5o3TDd9tERSk/lPrUMTN6YIsA4atWDQl8Q/HLbQ
         VE8+JNstRVMgoLhLAgOfSw0xBYANhHFhHx88enaWj/HTQNUv6J9KCG6Gh/v+uxsvQ1ox
         OHUzqnnsAlg9JuyYSjjGxblkNSvenC2gZyXxYdBQrF0CYXXRQUjyNBub1drqGl5dDhOa
         +UCYeYrrStNsvoCH8QiVL0VgtE9ZYlTT983ogovRSKUDl3KqH39e7rJWDeIDuXYAguxi
         GKhojODICm/PDSoPCvfLfVz09BnTek98KUkY0Wfp8U5u3+QSMIr2wVEn6E+XlGIFspaq
         Iv4w==
X-Gm-Message-State: AOJu0YxAmqJVoUJSN4hMS2YFBEVAvIJcHqi5+DtYtqa7tq1E4LXUUxqD
	LYccncp1hHUClQ/gEUv4suzrOlya7uI5PvVfYk14veeH0fcF2aM08wdtOohhIZuNYy8EKfTmZfx
	KMqLZnd+T0wBxDWAua1heb2oF4VOv5+9PXuTxrHGmghEdVZaopnfZFoB0cg==
X-Gm-Gg: ASbGnctykQm31OmdGN9y9FoG35Jdycy3wyNYL5X33bsFKYAonK6ngAVVIZtCj19wo13
	8l91b5i1K7xd6nqjqlBR/CVRBvg/u0X1tTR2s+qV7BFUXhQU4Eqj/HRSluLWNXA5vWtqHUIsX5A
	sGoLDVSOdLKkcz4MTPYrkEMkQfPWZbYraAq3R6ESkC2W0raytYSItBDI/0//TLN0OPUm0RKgQpk
	1AkmIt5fvWIKcfkEPzS1P8mm6etHXeqiW+CEtbvIGbfUrRiYn5yu2ojVRmBqBrGWW9QWbVD4/XD
	eg36AwyTZno2Dz7MAxBUIK8nW8osW+j9Ls05OpEcEeXNtsN3W8sgL1aR+Eraj+cvggqPqhjeH5n
	W1eid5qeYeHRd6hgBzNAM95fPM5M=
X-Received: by 2002:a05:600c:1d07:b0:434:f219:6b28 with SMTP id 5b1f17b1804b1-438dc40ff6fmr196190345e9.24.1738663198618;
        Tue, 04 Feb 2025 01:59:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtopFGL7jNdvaOuoIy/KfAsAxC9FULS53CWXbdFKmMqrHJokZHeTPUiO/3DKnbEDH+GDtscw==
X-Received: by 2002:a05:600c:1d07:b0:434:f219:6b28 with SMTP id 5b1f17b1804b1-438dc40ff6fmr196190205e9.24.1738663198246;
        Tue, 04 Feb 2025 01:59:58 -0800 (PST)
Received: from ?IPV6:2003:cb:c70a:300:3ae1:c3c0:cef:8413? (p200300cbc70a03003ae1c3c00cef8413.dip0.t-ipconnect.de. [2003:cb:c70a:300:3ae1:c3c0:cef:8413])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2ef08sm221424315e9.22.2025.02.04.01.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 01:59:57 -0800 (PST)
Message-ID: <3e5cfe8b-9ca8-4625-b6ff-7f170f1579ff@redhat.com>
Date: Tue, 4 Feb 2025 10:59:55 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, lsf-pc@lists.linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org, Byungchul Park <byungchul@sk.com>,
 Honggyu Kim <honggyu.kim@sk.com>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2LqZYUCB30wn4Fzhj3zAwBkJbAFI2kGjrJycqpVlHcM_1738663199
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.02.25 14:29, Hyeonggon Yoo wrote:
> Hi,
> 
> Byungchul and I would like to suggest a topic about the performance impact of
> kernel allocations on CXL memory.
> 
> As CXL-enabled servers and memory devices are being developed, CXL-supported
> hardware is expected to continue emerging in the coming years.
> 
> The Linux kernel supports hot-plugging CXL memory via dax/kmem functionality.
> The hot-plugged memory allows either unmovable kernel allocations
> (ZONE_NORMAL), or restricts them to movable allocations (ZONE_MOVABLE)
> depending on the hot-plug policy.
> 
> Recently, Byungchul and I observed a measurable performance degradation with
> memhp_default_state=online compared to memhp_default_state=online_movable
> on a server where the ratio of memory capacity between DRAM and CXL is 1:2
> when running the llama.cpp workload with the default mempolicy.
> The workload performs LLM inference and pressures the memory subsystem
> due to its large working set size.
> 
> Obviously, allowing kernel allocations from CXL memory degrades performance
> because kernel memory like page tables, kernel stacks, and slab allocations,
> is accessed frequently and may reside in physical memory with significantly
> higher access latency.
> 
> However, as far as I can tell there are at least two reasons why we need to
> support ZONE_NORMAL for CXL memory (please add if there are more):
>    1. When hot-plugging a huge amount of CXL memory, the size of
>       the struct page array might not fit into DRAM
>       -> This could be relaxed with memmap_on_memory

There are some others, although most are less significant, and I tried 
documenting them here:

https://www.kernel.org/doc/html/latest/admin-guide/mm/memory-hotplug.html#zone-movable-sizing-considerations


E.g., a 4 KiB page requires a single PTE (8 bytes) to be mapped into 
user space, corresponding to 0.2 %. At least for anonymous memory, 
PMD-sized THPs don't help, because we still have to allocate the page 
table to be prepared for a PMD->PTE remapping. In the worst case, the 
directmap requires another 0.2 % (but usually, we rely on PMD mappings). 
So that usage depends on how you are intending to use the CXL memory 
(e.g., pagecache vs. anonymous memory).


 >    2. To hot-unplug CXL memory, pages in CXL memory should be 
migrated to DRAM,
 >       which means sometimes some portion of CXL memory should be 
ZONE_NORMAL.

I don't quite understand that argument for ZONE_NORMAL.

-- 
Cheers,

David / dhildenb

