Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6851DF75E
	for <linux-cxl@vger.kernel.org>; Tue,  8 Oct 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399762; cv=none; b=lriAnU4mDg1Kz9sjDZk4jZ5ONrjfDp1Nom6QoAafT1JWnBqiCVegZxWl7TQAKN2Gh1zcCAJ762EvWWgT6AEqwEMV+1XOAJAAmAlspwwdnojTrc6NIuStVIKucbkG3waEw2RHkgd6+vTKZQ6NRr688YiQSlkwtcxxVGRc41gOILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399762; c=relaxed/simple;
	bh=vzqt3hrVTXflRNuVO3L19ZJ3+SZRR36ceDMjb86Zj1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYKyakGbxKMPNnSlS7WbrL4AAui8bDusZQ6lrZG21voy+jPgk7oOqiVBNFfS7Qswt/RIIjKVSv6l6q3UXj2iv76DZI8/Ac3kHjOdlAUUz8snZ/9pmId3537hJL+TGgJQjwahlz6sII08Wf/kQuunEgIKCS15oySu6MxYx6yrWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXkzSw2K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXkzSw2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728399759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0/3OUmyHj9egoKO3W+ad9PiM2e5i+z+vUsEoQ8af/vY=;
	b=PXkzSw2KJkZFYuKS6YpsUso2xYuNr++Yh+FbFp4KRV5kuk8fbzFe+bKC8kIN6yMbUZt+0J
	63bpOuOK0rWzpa6e5nsvZU5qRdOjiC5ZyJgba4CXPKrpGZyXDpoyQVUD3w13iVm0kRN3J+
	k7ej0MdXjZRRSDS5Dwx8LdtKoftnZ/Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-NY_yBi3lOa21Y5xaN8j1OQ-1; Tue, 08 Oct 2024 11:02:38 -0400
X-MC-Unique: NY_yBi3lOa21Y5xaN8j1OQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb9e14ab6so47551545e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 08 Oct 2024 08:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399757; x=1729004557;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0/3OUmyHj9egoKO3W+ad9PiM2e5i+z+vUsEoQ8af/vY=;
        b=pLBUdcmxCdcdGi3/u24sYwD1PIevt9jjABC6HBIfbf9KUv0Bz6DXT+w118ggbGVbYP
         UahMkEQBL7BmfoXWwS0xySIj8aiOkRezq+m64bZjCZZMcMc2TqtUP44FdZN+Je+6KErE
         KXQ2ARGSniFVfTNMsaGsk18BT/Xw5L8Hhrzov5Q0O3fKRztQ3dJV5zNHpSR0qRWi402+
         F3CBJFoi42nccZwC9PodDi5c7zoXDUblYD4Yg93cJYmZPjKdf9jqUVy1rRd5QbN8mIZp
         rwGSDot2i61KH0gxy4uGn//Qh9y87hZ2M2/DLzrwOZ7WqOfjKFMGtJv4RhmVqvKpo9X0
         eIUw==
X-Gm-Message-State: AOJu0YzWuUYO3xCOzf2OIW/a0QrpPU8Z4fISsD+DXW/MOKq+MnG0i3m1
	vz7XcBVM8tCpFW5YA6slt62GunDA7Y+wZv/gO9nLnTMu4dpWDOkgFHOeJ+TJtchbVHvQ+2YMM0H
	petzjpwPcQ1/N1dtvrBOEjqhfhIjrY1WJ0rq3aBkKOoBsZ2luPAiK6NGH6Q==
X-Received: by 2002:a05:600c:1d05:b0:430:4db0:3fef with SMTP id 5b1f17b1804b1-4304db041b1mr21619295e9.15.1728399756828;
        Tue, 08 Oct 2024 08:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5KfWAEfo13d7LBkIzALwm5EMMzkC+qUYwK/+sE00fwCjhiq2WEKxm9BSVRHrra9a9n2gkyQ==
X-Received: by 2002:a05:600c:1d05:b0:430:4db0:3fef with SMTP id 5b1f17b1804b1-4304db041b1mr21618565e9.15.1728399756152;
        Tue, 08 Oct 2024 08:02:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c700:a76f:473d:d5cf:25a8? (p200300cbc72fc700a76f473dd5cf25a8.dip0.t-ipconnect.de. [2003:cb:c72f:c700:a76f:473d:d5cf:25a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0a9c9sm129678865e9.3.2024.10.08.08.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 08:02:35 -0700 (PDT)
Message-ID: <d3203f2c-eff6-4e84-80cd-3c6f58dab292@redhat.com>
Date: Tue, 8 Oct 2024 17:02:33 +0200
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
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.10.24 16:51, Gregory Price wrote:
> On Tue, Oct 08, 2024 at 04:03:37PM +0200, David Hildenbrand wrote:
>> On 08.10.24 06:43, Gregory Price wrote:
>>> On CXL systems, block alignment may be as small as 256MB, which may
>>> require a resize of the block size during initialization.  This is done
>>> in the ACPI driver, so the resize function need to be made available.
>>>
>>> Presently, only x86 provides the functionality to resize memory
>>> block sizes.  Wire up a weak stub for set_memory_block_size_order,
>>> similar to memory_block_size_bytes, that simply returns -ENODEV.
>>>
>>> Since set_memory_block_size_order is now extern, we also need to
>>> drop the __init macro.
>>>
>>> Signed-off-by: Gregory Price <gourry@gourry.net>
>>> ---
>>>    arch/x86/mm/init_64.c  | 2 +-
>>>    drivers/base/memory.c  | 6 ++++++
>>>    include/linux/memory.h | 4 ++--
>>>    3 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>>> index ff253648706f..6086f99449fa 100644
>>> --- a/arch/x86/mm/init_64.c
>>> +++ b/arch/x86/mm/init_64.c
>>> @@ -1424,7 +1424,7 @@ void mark_rodata_ro(void)
>>>    /* Adjustable memory block size */
>>>    static unsigned long set_memory_block_size;
>>> -int __init set_memory_block_size_order(unsigned int order)
>>> +int set_memory_block_size_order(unsigned int order)
>>>    {
>>>    	unsigned long size = 1UL << order;
>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>> index 67858eeb92ed..f9045642f69e 100644
>>> --- a/drivers/base/memory.c
>>> +++ b/drivers/base/memory.c
>>> @@ -110,6 +110,12 @@ static void memory_block_release(struct device *dev)
>>>    	kfree(mem);
>>>    }
>>> +int __weak set_memory_block_size_order(unsigned int order)
>>> +{
>>> +	return -ENODEV;
>>> +}
>>> +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
>>
>> I can understand what you are trying to achieve, but letting arbitrary
>> modules mess with this sounds like a bad idea.
>>
> 
> I suppose the alternative is trying to scan the CEDT from inside each
> machine, rather than the ACPI driver?  Seems less maintainable.
> 
> I don't entirely disagree with your comment.  I hummed and hawwed over
> externing this - hence the warning in the x86 machine.
> 
> Open to better answers.

Maybe an interface to add more restrictions on the maximum size might be 
better (instead of setting the size/order, you would impose another 
upper limit). Just imagine having various users of such an interface ..

-- 
Cheers,

David / dhildenb

