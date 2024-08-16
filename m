Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8613B286
	for <linux-cxl@vger.kernel.org>; Fri, 16 Aug 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798682; cv=none; b=ggJjbFi2WbHmOnzTW5ba0Xq1hnkAkkEEJcvDNX5r6PqAApR46m3n31Yh6/7j62L47y84PUJbyUy6f0E3kAqEFr+x5ye0j1syrcD/5H68k8/3pGdJ59X3L6iQBh8ZtMiOI3OEFeNtUIJKWXajx3c+CLPgioFrxhReDSdI5pWJHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798682; c=relaxed/simple;
	bh=5yfoNoxi/3g/q618ra3ypVMWHfWiO/F6l10xyvzy1kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kN1xvgvjhetpxz+LwXTr3u2i7obEOP8P5pO+Ea+jMWr5yWb9CfI4CL41/Ou3MAKLHLI+F1rK9DLUsr9I0pe+dDplOhOqgk6pBNmFf/mQXcaZFy289MJPN1Fjf/C0mfES/V6T5Pont1GR7e4tcvS995jEdTaKk8p0mWsVdHx6r5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDtNI3g9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDtNI3g9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723798678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3kPI6r1w4qQs31tMsarBNqKUKUjQAoblMFtYfPMJ9a8=;
	b=KDtNI3g9KSpCA1dgxJChtGzqgwSkXu54o7HOKQDNhTDKEZD5gqWGlf3yWImInfbLe8iUwn
	UbQD8veT/vGufrjd4AYkB9phSAscuTH2OIxF7iK4rQNa4qOYWnlnydf/afCzZFwCbRbPg+
	wAOj1Welp2b47o7dZLuK/7DdMs1lIzg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-PPoPnWSxOmyuse_SIZI5cg-1; Fri, 16 Aug 2024 04:57:40 -0400
X-MC-Unique: PPoPnWSxOmyuse_SIZI5cg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3718d9d9267so620351f8f.0
        for <linux-cxl@vger.kernel.org>; Fri, 16 Aug 2024 01:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798659; x=1724403459;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3kPI6r1w4qQs31tMsarBNqKUKUjQAoblMFtYfPMJ9a8=;
        b=bGfTFFszH2w4+rnBbDGSLOQgsuPmgIDbWUAql4X8BWunHUSMKQwYCrrUh4waqNOHeH
         oXUrsylhjV070HBXlDLRqhbt9i658BGwAG0lRtdCbYy4BVdsVgqtecOBQB097CPR3MH8
         55MzRulc1RkpukxAqDG1jctrkdeFDsq9kAnFE+LRzn1UpGvkGP1/s0zk+isMMPhOKiEI
         Z6f3BjGFAoW2ZRAyxlGCI4mLxpX+dn7/pj4f90XjrxGZ9EzlY+7JhyTuyYcA94/w4/sF
         bNvUGs79bmKbrXgUT8qn0QkqetCYlYNNGy/FfbIU2ANEpYTrDMclnJBKmOlsQl6Gpgsi
         vWFg==
X-Forwarded-Encrypted: i=1; AJvYcCWwrgwLtQcxXE3No8aFpGhovgffq/3k+ZRcQ0XEvalveMN3rp9E/2QQaPhiMomMDQXJq00BXibqcX9UMCjwNBey+3ttNzLLEoUd
X-Gm-Message-State: AOJu0YwBptODglR0nC+PC4b1c1WebpE9l75oJuVunNRltOIXdd9bpl9S
	2QZX3dIaqxjXzLk0t+bHryMazFv8as/Ks+8AM5sPlGMJGilWvMq/Hs5CuDM2GEELijYhm1Jk2Rg
	jBGC6YpN/Gg7SY/xn5AGHMqnxZvw/T1yfLDxX6DP58tiyai3rxw8ocbaDpQ==
X-Received: by 2002:adf:ce8e:0:b0:367:95e6:158a with SMTP id ffacd0b85a97d-371946db8bbmr1185496f8f.63.1723798659095;
        Fri, 16 Aug 2024 01:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtCXvPWHFOf3OHKw0wVaLF55Z+fjaN7H4hllFfLrVeIdxyqJKhSbCID4om543+9USnXxnkcw==
X-Received: by 2002:adf:ce8e:0:b0:367:95e6:158a with SMTP id ffacd0b85a97d-371946db8bbmr1185470f8f.63.1723798658567;
        Fri, 16 Aug 2024 01:57:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c721:b900:4f34:b2b7:739d:a650? (p200300cbc721b9004f34b2b7739da650.dip0.t-ipconnect.de. [2003:cb:c721:b900:4f34:b2b7:739d:a650])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7ead3sm72048675e9.47.2024.08.16.01.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 01:57:38 -0700 (PDT)
Message-ID: <192dcb60-e274-4b2c-a626-608bee4dbe65@redhat.com>
Date: Fri, 16 Aug 2024 10:57:36 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Resource: fix region_intersects() for CXL memory
To: Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
References: <20240816020723.771196-1-ying.huang@intel.com>
 <20240815215302.5ed29b99e94a48aea49269ce@linux-foundation.org>
 <66bede74cb96f_1c18294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <66bede74cb96f_1c18294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.24 07:07, Dan Williams wrote:
> [ add David ]
> 
> Andrew Morton wrote:
>> On Fri, 16 Aug 2024 10:07:23 +0800 Huang Ying <ying.huang@intel.com> wrote:
>>
>>> On a system with CXL memory installed, the resource tree (/proc/iomem)
>>> related to CXL memory looks like something as follows.
>>>
>>> 490000000-50fffffff : CXL Window 0
>>>    490000000-50fffffff : region0
>>>      490000000-50fffffff : dax0.0
>>>        490000000-50fffffff : System RAM (kmem)
>>>
>>> When the following command line is run to try writing some memory in
>>> CXL memory range,
>>>
>>>   $ dd if=data of=/dev/mem bs=1k seek=19136512 count=1
>>>   dd: error writing '/dev/mem': Bad address
>>>   1+0 records in
>>>   0+0 records out
>>>   0 bytes copied, 0.0283507 s, 0.0 kB/s
>>>
>>> the command fails as expected.  However, the error code is wrong.  It
>>> should be "Operation not permitted" instead of "Bad address".  And,
>>> the following warning is reported in kernel log.
>>>
>>>   ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
>>>   WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d

But we should definitely fix the warning.

>>> ...
>>>
>>
>> Presumably we want to fix earlier kernels?  If so, are you able to
>> identify a suitable Fixes: target?  Possibly 974854ab0728 ("cxl/acpi:
>> Track CXL resources in iomem_resource")?
> 
> At least that commit, but I think this problem potentially goes back
> farther to:
> 
> c221c0b0308f device-dax: "Hotplug" persistent memory for use like normal RAM
> 
> ...because that started the era of "System RAM" as a non-top-level
> resource.
> 
> David did a bunch of work to fix this back in:
> 
> 97f61c8f44ec kernel/resource: make walk_system_ram_res() find all busy IORESOURCE_SYSTEM_RAM resources
> 
> ..but the fallout in region_intersects() was missed.

Sounds reasonable.

For virtio-mem we set IORESOURCE_SYSTEM_RAM|IORESOURCE_EXCLUSIVE on our 
(highest) parent resource (to make any /dev/mem access attempts of that 
memory fail). So the problem is likely specific to other
add_memory_driver_managed() users.

I have a faint recollection that at some point we had code that would 
set IORESOURCE_SYSTEM_RAM on parent resources up the tree, but either my 
memory is wrong or that code was ripped out long ago.

Fix idea is reasonable: check if anything in that range is 
IORESOURCE_SYSTEM_RAM.

-- 
Cheers,

David / dhildenb

