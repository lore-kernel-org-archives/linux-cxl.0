Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F51684B4
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906875; cv=none; b=Y7A4bCB95sr4TDeDPg3ZiXUTtZkpukrhS6mIr1libvcz2N0ARk+1oRcpM75NhUQlZM+KKrCvDLt7pwKr9VCgephmCfFcEhbaEAI7t4eIg4nG1xuBS/0eYuszzmoGrnbDOwUGrQE/T4VmuzwHwHTrUjdtiCkEIf6lUZnEG61AlW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906875; c=relaxed/simple;
	bh=PXrpMgAf1em09n35snAXFKH9s/dIccNzU92Hs01D30I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXI41i0QUmCR5gjUs2MsULRY+0cLPPnDudFzB7Krk5q0ItSSE2WgXjzw2Ple7ddhbOj2kh+3ULcrS/Y1j8zwRpSUNbqQxUHTEFGLJBDYNjrQ58YFjLQbnX8CqgpS+2D3BSH5fMyqg9gm6i1MdHdc+GZ47v5NZfEtcTzeI6G5how=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnaM7Qlj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnaM7Qlj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728906873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sw8SdMoxvkqT+oJ6QjaS4Mdlocpgg8B3j/K0BV38W8E=;
	b=RnaM7QljAr+dyCUPEJa5yIQtwvxWPoU15CcyiYn8J9qszpzDw4u+Z/sTKY+D+rvdJW4aIz
	g108XoEIUHDespx7hVeXsusa+NRZErWszKxqY2u/Tk1A7Wz389huU1bRZco9Hag6JnCTm0
	sSzhjlfQoEQa4QJ+cd9y7x9Lys5v+fQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-_Ubo1E8fNJ6Q3zTwaDu5Yg-1; Mon, 14 Oct 2024 07:54:32 -0400
X-MC-Unique: _Ubo1E8fNJ6Q3zTwaDu5Yg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so800679f8f.3
        for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 04:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906871; x=1729511671;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw8SdMoxvkqT+oJ6QjaS4Mdlocpgg8B3j/K0BV38W8E=;
        b=w6faS8XLi4bBjx0nKE5UzqkXCyf3vwbtJbxgq3oUT7YOvjD1k5FZt4mI1w22Wm8vgN
         J/fgdKFpTjrQnwAxwa56kS+d6dSalEA7McHaLtCWz9HSFMjvKKTKJ9vlcLxDyvN578Gn
         ZuNDu9vj5koEGAUtbHnCLW97OzKnpwr2UXCDfuw5Ge+fVLH3Qesp+Aq4NIQVhNh7M6BP
         b0JRtBqOjdBoI4eHK5EzFaSLuCvkZtGZFUvaisINFukOMkFD6e6ZBkNaJgbGCsuRcmcK
         +0cjPgfjQBoPsc23IFuDe5zdq3wSZLyaBUKsKIikQRAUeT+bbbGNqW3mwU/ivwtGcTu8
         J7Vg==
X-Gm-Message-State: AOJu0YwF5JJ6ToagDW9+nN3vEWu/+HR7gvu54MRL7oNrszDP2zX5ldmH
	NX/wG1JejJ4on92x1tqicQaFamcm18qwW0VbUyWx3hI6y2cgMcVPlMNTHK2jND3kavHzcvQp/ZS
	PgulqO0sJhKgz0XTxiDxk4zHaq8tthtK1MR6cFlleGK4VCHm8Slok84QSQg==
X-Received: by 2002:a05:6000:1092:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-37d552cb121mr7706956f8f.49.1728906870993;
        Mon, 14 Oct 2024 04:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEACD/nWJW6zvguB1SSmBU+FZvicY4wNaBqIk+Gz5VEXsWYT2ZpRvnBnDHGA7inU6EB3h6eQw==
X-Received: by 2002:a05:6000:1092:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-37d552cb121mr7706932f8f.49.1728906870578;
        Mon, 14 Oct 2024 04:54:30 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd584sm11152917f8f.31.2024.10.14.04.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 04:54:30 -0700 (PDT)
Message-ID: <2c854e5e-c200-4ed9-bf21-778779af7e5b@redhat.com>
Date: Mon, 14 Oct 2024 13:54:27 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 akpm@linux-foundation.org, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, alison.schofield@intel.com, rrichter@amd.com,
 terry.bowman@amd.com, lenb@kernel.org, dave.jiang@intel.com,
 ira.weiny@intel.com
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
 <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
 <d3203f2c-eff6-4e84-80cd-3c6f58dab292@redhat.com>
 <ZwVOE6JRS8Fd9_a8@PC2K9PVX.TheFacebook.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZwVOE6JRS8Fd9_a8@PC2K9PVX.TheFacebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.24 17:21, Gregory Price wrote:
> On Tue, Oct 08, 2024 at 05:02:33PM +0200, David Hildenbrand wrote:
>> On 08.10.24 16:51, Gregory Price wrote:
>>>>> +int __weak set_memory_block_size_order(unsigned int order)
>>>>> +{
>>>>> +	return -ENODEV;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
>>>>
>>>> I can understand what you are trying to achieve, but letting arbitrary
>>>> modules mess with this sounds like a bad idea.
>>>>
>>>
>>> I suppose the alternative is trying to scan the CEDT from inside each
>>> machine, rather than the ACPI driver?  Seems less maintainable.
>>>
>>> I don't entirely disagree with your comment.  I hummed and hawwed over
>>> externing this - hence the warning in the x86 machine.
>>>
>>> Open to better answers.
>>
>> Maybe an interface to add more restrictions on the maximum size might be
>> better (instead of setting the size/order, you would impose another upper
>> limit).
> 
> That is effectively what set_memory_block_size_order is, though.  Once
> blocks are exposed to the allocators, its no longer safe to change the
> size (in part because it was built assuming it wouldn't change, but I
> imagine there are other dragons waiting in the shadows to bite me).

Yes, we must run very early.

How is this supposed to interact with code like

set_block_size()

that also calls set_memory_block_size_order() on UV systems (assuming 
there will be CXL support sooner or later?)?


> 
> So this would basically amount to a lock-bit being set in the architecture,
> beyond which block size can no longer be changed and a big ol' splat
> can be generated that says "NO TOUCH".
> 
>> Just imagine having various users of such an interface ..
> 
> I don't wanna D:

Right, and it also doesn't make sense as explained in my other comment: 
this should never apply to loaded modules. :)

-- 
Cheers,

David / dhildenb

