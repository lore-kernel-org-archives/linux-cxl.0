Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E232253E4
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199555; cv=none; b=ClPvpaEWa+gkjBEaZ3ifFDXzNEC9SmuLa64GLIY9g6BSf1yPJqN9266sD7IN+X/nWXQ3xEtG5+kkVcr50uAgnWlQvtdinocnzECSkS7z7sybdVYKYF9hTVL+LvnHidUJyQr2f5PvL5y1jlU1dT1IOj6RjInCFuP3VTPEnnn0wCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199555; c=relaxed/simple;
	bh=zpqcRkcdgI2BGzW7BEUff4GwNlxMQxaqdRExzDRvQS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOKRxRHNwrApXPkk+JpGAPT6ivnyZ3sdz+vpBjCJJKfGKuMVwKbWoXQcATgE6GUuT9Yp2QrjwZsNFB7GhUmuEZe+c5hHrffx/XGInlMOdduhIuJp3SOAYlh2mO2H10sAjN6CuzgHlrByrRHD5ZI+VAOTfNFeTFTEb7V9tIwb93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShdNNQa/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShdNNQa/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744199553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZlAh5BF+/VKy4R6pJBU59qZDQS0XAI1pwtnPwkboZ94=;
	b=ShdNNQa/ijGf13vCfDx6GYcw5kQ+hiEqTpWuYLKXkgH7BY3wq9eKJ5VprPtBm/Yh2E+bPZ
	25qv0n7C3dymoLLpz2hclagONixK8Q+Nwk3uU7+q7zuZ2w+CsLqPLJiVoELt7Ed9N+tQV8
	VyaOSFtTr+ricRNrX+tVgCJhRfUVsXg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-cIzbMM4vMM6UKoPhgn18Xg-1; Wed, 09 Apr 2025 07:52:31 -0400
X-MC-Unique: cIzbMM4vMM6UKoPhgn18Xg-1
X-Mimecast-MFC-AGG-ID: cIzbMM4vMM6UKoPhgn18Xg_1744199550
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so38879025e9.0
        for <linux-cxl@vger.kernel.org>; Wed, 09 Apr 2025 04:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744199550; x=1744804350;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZlAh5BF+/VKy4R6pJBU59qZDQS0XAI1pwtnPwkboZ94=;
        b=WpXhCHSeXBaGQgyUO+oGs7lU77MIpmEbIN7nUiwoXhICexrBl7vc2lBBPXRHTHpx10
         yrpd6Qzr+rHwKgD7KB6IIC/huz3+g4qOQ8SbnQVZpBtrmSOPcOHAZ+lOMBVWr2F3XSid
         KUFcuyB5vgputVJpsxG25BEpurAafauUuydAwLI+mo4S6vfL2D8lHKZiybGfAMO2OTqv
         ozVliNyoOmbYJ7eAdxTNZLlg3ssO6cvSFUFx1WDzUcnnCbZCW6rPMASobF0Wi0KLqaG9
         raDcdYuxtek98Jako5Tw1RbnU6WZTNI0wd9U806hND481e43KZqNj9R72Whvx33Kqmg3
         Q+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU7V1pEH7xv5q8Or3XmJuka1QSZhgS0c8aR9vaVyNjJezsz9k1c+TVj/GYHUphjQoLMeDS4mzct574=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9BuZFjWod9g6WzaXYOE3rUiPale2Ls1Z4Gn1X/efSdumE90z3
	Qxbgavg5XSZMcrVKlLKN73aFXsAztFna8QVaIEy90ETQk5gE6vFGU5fOtUf0uiuAhqIg/CzTE4k
	8e2uHDCBieCdJrcv3DYbHsOm1Ncpq3km6Y1xShggZRvwqTQUA1OOGb4MvKJoaF+08Xe9R
X-Gm-Gg: ASbGncuHFPv2E/aFADED7diepeQhVBDgBSNNtZ8qxYWvKnKPv4m/jaQ7jKZf4kRTCqI
	Ipux2YCaA5/XCvJBZ9gs5LmXo/n1OPdbrR+KNKTT5XVr7Iz/SruJtaOXzm7AZW1XIJVnQubQGpm
	2DocGgsdOvJPfOmU8jEqWKb/IdChJV1GrcJ6CYtmS8nOVmChNFqwyWGMKLTTuvr/KXIVwInBnSl
	EEFLC4NYClFcsXz6kJ+5emOykzfPVYRx7NtcOsw81gxpcMOfJmdz9kB9WqvYKDJK4hgOFmjwWYK
	dNwA/yVsUMlKuvmr7MhJRsMl17Kqg5LZqH3B3xhQyQ==
X-Received: by 2002:a05:600c:1d8a:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-43f1eca819cmr27432975e9.11.1744199550429;
        Wed, 09 Apr 2025 04:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXhzHj+xMdvlRohVTa4JmpL3IBWUzjbyb6iOg/HTDb5KSd2qF22C/o+XaXrMaZB8WmHtER/Q==
X-Received: by 2002:a05:600c:1d8a:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-43f1eca819cmr27432735e9.11.1744199550088;
        Wed, 09 Apr 2025 04:52:30 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23667.dip0.t-ipconnect.de. [79.242.54.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2c46sm13881765e9.13.2025.04.09.04.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 04:52:29 -0700 (PDT)
Message-ID: <203ed4e9-4691-483c-bf42-3035b3ad3539@redhat.com>
Date: Wed, 9 Apr 2025 13:52:28 +0200
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b58f2dd6-d978-487a-b420-badfb4847c00@sk.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u5YgFdiW3aqtxo60BhalTmacU8qtAc3UxcSWB5NyF9M_1744199550
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.04.25 13:39, Honggyu Kim wrote:
> Hi David,
> 
> On 4/9/2025 6:05 PM, David Hildenbrand wrote:
>> On 08.04.25 09:32, Rakie Kim wrote:
>>> The weighted interleave policy distributes page allocations across multiple
>>> NUMA nodes based on their performance weight, thereby improving memory
>>> bandwidth utilization. The weight values for each node are configured
>>> through sysfs.
>>>
>>> Previously, sysfs entries for configuring weighted interleave were created
>>> for all possible nodes (N_POSSIBLE) at initialization, including nodes that
>>> might not have memory. However, not all nodes in N_POSSIBLE are usable at
>>> runtime, as some may remain memoryless or offline.
>>> This led to sysfs entries being created for unusable nodes, causing
>>> potential misconfiguration issues.
>>>
>>> To address this issue, this patch modifies the sysfs creation logic to:
>>> 1) Limit sysfs entries to nodes that are online and have memory, avoiding
>>>      the creation of sysfs entries for nodes that cannot be used.
>>> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>>>      based on whether a node transitions into or out of the N_MEMORY state.
>>>
>>> Additionally, the patch ensures that sysfs attributes are properly managed
>>> when nodes go offline, preventing stale or redundant entries from persisting
>>> in the system.
>>>
>>> By making these changes, the weighted interleave policy now manages its
>>> sysfs entries more efficiently, ensuring that only relevant nodes are
>>> considered for interleaving, and dynamically adapting to memory hotplug
>>> events.
>>>
>>> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
>>> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
>>> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
>>
>>
>> Why are the other SOF in there? Are there Co-developed-by missing?
> 
> I initially found the problem and fixed it with my internal implementation but
> Rakie also had his idea so he started working on it.  His initial implementation
> has almost been similar to mine.
> 
> I thought Signed-off-by is a way to express the patch series contains our
> contribution, but if you think it's unusual, then I can add this.

Please see Documentation/process/submitting-patches.rst, and note that these
are not "patch delivery" SOB.

"
The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path.
"

and

"
Co-developed-by: states that the patch was co-created by multiple developers;
it is used to give attribution to co-authors (in addition to the author
attributed by the From: tag) when several people work on a single patch.  Since
Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
followed by a Signed-off-by: of the associated co-author.  Standard sign-off
procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
chronological history of the patch insofar as possible, regardless of whether
the author is attributed via From: or Co-developed-by:.  Notably, the last
Signed-off-by: must always be that of the developer submitting the patch.
"

The SOB order here is also not correct.

> 
>     Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
>     Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> 
> For Yunjeong, the following can be added.
> 
>     Tested-by: Yunjeong Mun <yunjeong.mun@sk.com>

That is probably the right thing to do if contribution was focused on testing.

> 
> However, this patch series is already in Andrew's mm-new so I don't want to
> bother him again unless we need to update this patches for other reasons.

mm-new is exactly for these kind of things. We can ask Andrew to fix it up.

-- 
Cheers,

David / dhildenb

