Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A316378F4E
	for <linux-cxl@vger.kernel.org>; Thu, 10 Apr 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292478; cv=none; b=VDDi650myfy6IltFbEytDC9olv85aJK8bcAp7O+OlDbhtS4FWRVxe8hvoNueBeawgooYBii9uNAUSda6CfsvYAYqnlSecNARdGk2JN+1sUGFr2qFT7AxXWLj1FwGNJTernqDBO2WfMMY0fQfSP/y4ZKlJvPviNBKzb3NeF1vhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292478; c=relaxed/simple;
	bh=k7HZ3J6Sdznt73jGRL/V1rXRjiNjVKh9Rezm6vCsJlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0uPGokciWwS1Bb0cSVFJl24+5wMV71msz39jnZonqEm/EpqlPfd1ONWGOMPKlcF16Znrg9ZpPMz275785SvLLOOQ6N74xzNIc/4qED3DXeUY3nl9MhtaVfcUtMDtno6aUSljwcT95lQsxkb4sNv9nND3mWAgWjikfWZMBdstlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mwzxzi8q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mwzxzi8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744292474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VtKjRccRoZwfHOkp6JnSpQLVWKCEwxlpsURyTo3+C1M=;
	b=Mwzxzi8qOwFF9VNzk23BZYYx1DJc1lwQAWGcyWfVrKfumnI3i01IQVXGd8EArU3PQY7pPv
	1eZSSNviLy978QGc3Mg85BXk1/Oe11zpQB6aO5akcfccr8sPIOGr2tPWGsXknP8Imx2Nsi
	2wDZvxjFHCVpg7XqZ7+NDeNHElUYvN0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-OWtdwnuUN-CS2pT6qQASkA-1; Thu, 10 Apr 2025 09:41:13 -0400
X-MC-Unique: OWtdwnuUN-CS2pT6qQASkA-1
X-Mimecast-MFC-AGG-ID: OWtdwnuUN-CS2pT6qQASkA_1744292472
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39c184b20a2so426244f8f.1
        for <linux-cxl@vger.kernel.org>; Thu, 10 Apr 2025 06:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744292472; x=1744897272;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VtKjRccRoZwfHOkp6JnSpQLVWKCEwxlpsURyTo3+C1M=;
        b=a+55rPp+mFwFe7DaNldonJt+RqiFLFT4hgYRQVZASDqIWAowWoBNu049+aQewW5QU+
         /F2g1nzww9f9N644x/WJwq/Y6kKDFPeKkDx+QSUmm9bw8eU0sCLeAZNYkZQNqGzPKAV7
         3ukEuqle1YkYEz3c5yTQyCYETX/VFj126qjvje0APOAli7oPnWR13S6WB/Pntskq4Jl3
         wFFuFF4XG0ic+F8WWbitUBikhxj3EYeqUSy+fGso6nVnfRLVC3WMWFXJdBBdNZa/vRCF
         dNohPJdfcqTye0k4odJyPlqK4ytlYaQ0+Prqbzh109+fKpK3StEPS5cu3agr+EEMwVV/
         4wgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBQIbq1D3fbdC3PyQCVKNaRIwB8ioklAXOYqJFGFySkoqBgq2xzYGpn3715kFfQTvRBraKp40tt0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJNkGaInC19or4pLhwtwkuS/TMO3kaw4Sd0h1DPmXDYsEBtOC
	Vyqys58seDMJNTwsacTTrexZ7MDWY3CjVT4ObuxBMi9uwXy7Yr5H/QnDPR6QZIGFwvj02QcO9V9
	HynlBRWIvpmKr7TPLSppoIqFSU1D2bw3R3QypGenEvipa3hr25+uMwr5NSQ==
X-Gm-Gg: ASbGncsfMSEy0IllMszFvaXDkLTfKT62JKZn42u1H49SHmYuxhScdvq6VWmD+AjNRyY
	+ANSWddyPtounrwjOlbjzQ0aQliWb/kbAHmA+9yN07Jh2iR55WALmPBWZ72/IuHbpVZZs88SJ0P
	nrTBRaFmgQr9s+WWNaEitR6Up/vFn97V/ZHbtCJcaPRBe21mD2/0EMEI/7U6IwnMJB1EY1iYd1o
	EGF0NBJ6yoMIV+0oDShmWR9aSLAzPyj642+/AOm1eF9Q6B9m2Rr0ubDW4h5Fm6AvCweGb89iJZh
	QulON/n4bF740U9C28uLuJHVQSo39jGrBSLVpN+V+G4mkxmmjxtqxT7V9zCWvTN08AJ10n05S4H
	duuFSxJUwJd2u27fj6t7bxzEhuSwDVvbYBYuYFAY=
X-Received: by 2002:a05:6000:4287:b0:39b:ede7:8906 with SMTP id ffacd0b85a97d-39d8f46d4a8mr2098073f8f.19.1744292472121;
        Thu, 10 Apr 2025 06:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0jqojO5GuXCmEsovcLJk3mS+EZg4SREWFZQBmCngBxQV0Ac/y+yZfGPR3I7oxkT/akTCJmQ==
X-Received: by 2002:a05:6000:4287:b0:39b:ede7:8906 with SMTP id ffacd0b85a97d-39d8f46d4a8mr2098046f8f.19.1744292471789;
        Thu, 10 Apr 2025 06:41:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:5900:d106:4706:528a:7cd5? (p200300cbc71a5900d1064706528a7cd5.dip0.t-ipconnect.de. [2003:cb:c71a:5900:d106:4706:528a:7cd5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f235a5e9dsm53785615e9.36.2025.04.10.06.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 06:41:11 -0700 (PDT)
Message-ID: <3270dbbb-0bd3-4217-90f5-441210fef87b@redhat.com>
Date: Thu, 10 Apr 2025 15:41:04 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
To: Honggyu Kim <honggyu.kim@sk.com>, Rakie Kim <rakie.kim@sk.com>,
 akpm@linux-foundation.org
Cc: kernel_team@skhynix.com, gourry@gourry.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, Jonathan.Cameron@huawei.com,
 osalvador@suse.de, yunjeong.mun@sk.com
References: <20250408073243.488-1-rakie.kim@sk.com>
 <20250408073243.488-4-rakie.kim@sk.com>
 <19562f7e-38ce-41fc-8dfc-bfd6b1259291@redhat.com>
 <b58f2dd6-d978-487a-b420-badfb4847c00@sk.com>
 <203ed4e9-4691-483c-bf42-3035b3ad3539@redhat.com>
 <755ad3ff-17d5-4610-94ce-2f2d775b518d@sk.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <755ad3ff-17d5-4610-94ce-2f2d775b518d@sk.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BDEiOSPafj9tbgpfpXkRJQYKdF5Wu3GUz7xanr1i48U_1744292472
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.04.25 15:25, Honggyu Kim wrote:
> Hi David,
> 
> On 4/9/2025 8:52 PM, David Hildenbrand wrote:
>> On 09.04.25 13:39, Honggyu Kim wrote:
>>> Hi David,
>>>
>>> On 4/9/2025 6:05 PM, David Hildenbrand wrote:
>>>> On 08.04.25 09:32, Rakie Kim wrote:
> [...snip...]
>>>>> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
>>>>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>>>>> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
>>>>
>>>> Why are the other SOF in there? Are there Co-developed-by missing?
>>>
>>> I initially found the problem and fixed it with my internal implementation but
>>> Rakie also had his idea so he started working on it.  His initial implementation
>>> has almost been similar to mine.
>>>
>>> I thought Signed-off-by is a way to express the patch series contains our
>>> contribution, but if you think it's unusual, then I can add this.
>>
>> Please see Documentation/process/submitting-patches.rst,
> 
> Thanks for the info.
> 
>> and note that these are not "patch delivery" SOB.
>>
>> "
>> The Signed-off-by: tag indicates that the signer was involved in the
>> development of the patch, or that he/she was in the patch's delivery path.
> 
> Yunjeong and I have been involved in finding the problem and also concluded this
> issue is related to hotplug together with our initial implementations before
> this patch.  So I guess it is the former case.

IIRC, usually we use Co-developed-by + SOB only if there are actual code 
contributions: when you would consider someone a "co-author".

"Co-developed-by: denotes authorship"

For suggestions we use Suggested-by, and for things that popped up 
during a review, it's usually a good idea that reviewers supply a 
Reviewed-by at the end.


So I guess Co-developed-by + SOB is appropriate if people consider 
themselves co-authors, in addition  to the main author.

> 
>> "
>>
>> and
>>
>> "
>> Co-developed-by: states that the patch was co-created by multiple developers;
>> it is used to give attribution to co-authors (in addition to the author
>> attributed by the From: tag) when several people work on a single patch.  Since
>> Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
>> followed by a Signed-off-by: of the associated co-author.  Standard sign-off
> 
> So the Co-developed-by comes before Signed-off-by.

Yes.

-- 
Cheers,

David / dhildenb

