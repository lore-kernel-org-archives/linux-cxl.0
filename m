Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A421480E
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080685; cv=none; b=Tg4uvAylGbZcGrUlxMDPZaH5cROCJ8+a1NUUkIt10bRjfEVhkSlyBRABxaCNpcAUcVRnU1hzr7W4T0t1WDsKJsNX/UW1OVuN75Ett5TOi1zr6BCFCMUe739nCqbqQhl2X8QYM7nYq0Cmzw9XOfwZnWdMg+bVLbSj5/Qa2QsI53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080685; c=relaxed/simple;
	bh=epM/mbQGx5bYcIYYnKhe8inHgl0+75yjKwuSm3koulk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVd8k1LA/40ukNp864a99ICPqC0n0+dpOwwHVHkrwxXccvI3O+Z1aOyoojmJjUOeSarrBR4nLfdTTqK6yC8D7tNl6nUHUMqrKwYCewriz9FUejVA48UM02sq8MERoN0d3a1/STo2N44kCV9A6loy0vEqBkwhRYh+Zo7JUc2cIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilQ8PT1N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilQ8PT1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740080682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=13tc3PZGlJhjHRFttOUYRjhUqm6ZIOA8cqgOLipjY0s=;
	b=ilQ8PT1Np+/Ebx8Pt6wtba03h+Mta53wtOleppdf8qW4Xky0KITjGApj+ueRa5ELfI13qK
	2zRZZ0C5wOhG4hESbHHDO0K0leNOJCvZSm0uIcdyKWDy2DZL9CoAmBG+2Ws22Mzp/fhNNU
	YB+SMM5m++54fvscJfbpyBXytwNBxRc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-ATw_CzPwOL6kv2WyUnvYWA-1; Thu, 20 Feb 2025 14:44:41 -0500
X-MC-Unique: ATw_CzPwOL6kv2WyUnvYWA-1
X-Mimecast-MFC-AGG-ID: ATw_CzPwOL6kv2WyUnvYWA_1740080680
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393ed818ccso8781335e9.3
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 11:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080680; x=1740685480;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=13tc3PZGlJhjHRFttOUYRjhUqm6ZIOA8cqgOLipjY0s=;
        b=hlz+sGIFCjYnK/GAgB2j17iSM0P+F4PPs8Sm7764S/TJLR9J48gZuOC2/D4JSinXU0
         vzMtgFK5SjQAKPSKT4jHA1nqex+FnHB7cJBHiZ3EysNNM1Olic/uMdQwLQbNbFmyelAR
         3LT2FkH6K9I4jZFDU4r447onHO+x+YN9IXdrcerg3+GCarFBfDNqsTEk4PCS8/SGhQAZ
         Hj/OYIkMYjf8gJu3sYIhM1oOP5kS3chEbhnBx28pNE0HWIe54i5j6UU+J12H6q10kFSV
         eg2/PKtUAP5kktVyu1CbT1xt+YOcB3eWg72uSuCkTpyTJz7N4vB3bnDxvGVJnxRHEwkg
         TP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQEPkSd4mGXuVIHxaWmgSmhLUGcJ/JzSp1ZNJ5KmFW5W8eagsTtyi6/q6AuGVYcGQWC4p4lgHlE7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnp/uZJEmTNHBjd7T20DTRqmWXQ/8DwbZhguVwVZQt1NQU4MV
	h8aUgm1+t2fnen0s7l1DihyDFW7HblxZhZzdRMyXjrrepg7f4q5AQ33n9qzuhypLrgxJLe7Cxu+
	69vNKtL5DEGMtdTCRUsUGru2HPhWfSJZcJFkO5GHOOfOi9b2O8q2Gj2wseQ==
X-Gm-Gg: ASbGncvjA1yc7WH1RDue1boIFdhU1hfPLpzN6P7Fr8oyggz8z5/LzT2Tp53drav5NiS
	zwenEdXmLOXK+HeGo6I6qbeVu01+/uTGgZB3DnERn7MOTXMLypH4VHrIYBjTBA1vbr+kiphYpj7
	+FmCiwzxMsBPzpLnYy4PMVvv2hwPY8iYFj1CtE3TiD8llQ5ASQV9JW3z7wG9VHv0OibFled79jI
	37Xbn1i5RIHzCfUlQGAPlKl+Epeu66XdYjSQ4g6RRCRkGMjqSOTK7Ox9tJoSYSdOJ8GS42gKnhh
	QHc8M/l6R0H7BD4sbwzv7wDhwm9QWsWWEDLaRggEI6AAd4Q1P46mwgsGgirxeJFK9VZvEZExrUd
	t4W0kJg8o5au/XvtJoo7CB6eUOKCCqQ==
X-Received: by 2002:a05:600c:1d82:b0:438:a240:c63 with SMTP id 5b1f17b1804b1-439ae3bd798mr2636555e9.2.1740080679777;
        Thu, 20 Feb 2025 11:44:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFQ/oyfYBUK3fUiKh0XjQS+69Txr3N9lLGYrS/0bgP4TwCTcZvVA7yprzpMPBstpyFgr/mqg==
X-Received: by 2002:a05:600c:1d82:b0:438:a240:c63 with SMTP id 5b1f17b1804b1-439ae3bd798mr2636355e9.2.1740080679293;
        Thu, 20 Feb 2025 11:44:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccef7sm21822570f8f.31.2025.02.20.11.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 11:44:37 -0800 (PST)
Message-ID: <b4b312c8-1117-45cd-a3c3-c8747aca51bd@redhat.com>
Date: Thu, 20 Feb 2025 20:44:36 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
To: Gregory Price <gourry@gourry.net>
Cc: Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
 <Z7eEGwFltjWaoX-r@gourry-fedora-PF4VCD3F>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z7eEGwFltjWaoX-r@gourry-fedora-PF4VCD3F>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ugJ1h-hGk0qHPioOj_EssqsgSfbraRyBaPOHNvQULkA_1740080680
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.02.25 20:35, Gregory Price wrote:
> On Thu, Feb 20, 2025 at 08:26:21PM +0100, David Hildenbrand wrote:
>> On 20.02.25 19:43, Gregory Price wrote:
>>
>> There were ideas in how to optimize that (e.g., requiring  a new sysfs
>> interface to expose variable-sized blocks), if anybody is interested, please
>> reach out.
>>
> 
> Multiple block sizes would allow managing the misaligned issues I
> discussed earlier as well (where a memory region is not aligned to the
> arch-preferred block size).  At least in that scenario, the misaligned
> regions could be brought online as minimal block size (256MB) while the
> aligned portions could be brought online in larger (2GB) chunks.
> 
> Do you think this would this require a lot of churn to enable? Last I dug
> through hotplug, it seemed to assume block sizes would be uniform. I was
> hesitant to start ripping through it.

There were some discussions around variable-sized memory blocks. But we 
cannot rip out the old stuff, because it breaks API and thereby Linux 
user space. There would have to be a world switch (e.g., kernel cmdline, 
config option)

... and some corner cases are rather nasty (e.g., hotunplugging boot 
memory, where we only learn from ACPI which regions actually belong to a 
single DIMM; dlpar hotunplugging individual memory blocks of boot memory 
IIRC).

-- 
Cheers,

David / dhildenb

