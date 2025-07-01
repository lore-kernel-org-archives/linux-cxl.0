Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD902459D1
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382241; cv=none; b=UYSX8kTLJ2/zlpplNNAUyROl3hDzQjcY+yLOc3VToTETSm9tlQlZd3fSmsXRKFstonbA219DFEZMgDX7Yq3xcrTZGwEEjWnWBXbMZuCR5LteDVnB9tC7/hvsUSTICWjRYAgP0LTUNWU0NLGzf6FgZRRo1hDxW2uCcW2ezgpvgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382241; c=relaxed/simple;
	bh=cHV1HtIGmdmjNejzteIrVd8Rz5a6DRvFc+1W8hGxIjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaTj8P3QEEQxMKzAGH90jI+pPO7Uc3q0y46iwMBKY37gNLaWYM63HHdYT30hO/FYujvv9EMB/A1GzmZkJh5AmUOpwTalVhZkgGbv0OGC9p5KLD3I3oo22iXjsMqzSW8EpsZIquK0nyIQB3wULtXqRFfEdzTlVafKWp8omUe4jPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9VKwFMR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9VKwFMR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751382239;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+V26RQ9dDGQgTbpoIwnPJwm4j3M31eZGmT8jXNJ3HNY=;
	b=Y9VKwFMRj5HEWdBEsCVzmDSXU6OpCReQD+KOMFwifbg8KbFWZi7gefZGWbe3IdipvmzlP8
	523cVoRMGUbCD5P729jNjDGPOEexGYH1zRIKt193xeIBwNAY4iiVlznoH5Pm7B+0nrOGoQ
	Hs+gqwYXUVEb+0GEtuWBnorUkQ3Rfds=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-uaeYbVJkNwyLRyjVa0CUwQ-1; Tue, 01 Jul 2025 11:03:58 -0400
X-MC-Unique: uaeYbVJkNwyLRyjVa0CUwQ-1
X-Mimecast-MFC-AGG-ID: uaeYbVJkNwyLRyjVa0CUwQ_1751382236
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a52bfda108so2745175f8f.3
        for <linux-cxl@vger.kernel.org>; Tue, 01 Jul 2025 08:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382235; x=1751987035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+V26RQ9dDGQgTbpoIwnPJwm4j3M31eZGmT8jXNJ3HNY=;
        b=oEI/L35kngKw5CjQN0zC/fkEQw4imYEiqhZdpO88Qk2PjqxhJP7K3QSMSf1YW7Om/Q
         O5i1SGq2aKGsp2TKjgkowx81wjavfojh2B4L2mQLwT/89ZPco9STLxROFq1Ucxd1tYSW
         6xK1bNtvvSdn6wtjtqVCz99uzo011zNQr7L2r+vXjy7JrLFYkac9o/WnsvolzCOaKEY+
         yYsIM+/LH67XR/FhGSwCpMEx1xeM+qW4BoBCuSEnsTIJVh/GZQdWFEvJb65vE5Hj2G8k
         E0a3faOFG2SU/JJqZRO0HSDdkad8ajDWiVsUZcCWNFzA8gE7DPyJGgB3R5K583lWELyy
         EvLg==
X-Forwarded-Encrypted: i=1; AJvYcCXqM01JKBLuRcn5YwavuJsXiG75ygQfQFmEL+se8apdwta5jd988QAXJaIkYaocitczHnxRIdLzL0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1oJKFhWF7vX3J4ET4JtDaWC+/XAvvA3CN72bBgdWj7p+zSs7N
	xgl+1eXjelb2eh8xSVWftULqIY9kzudZpinSWeTcCY8h2zGt+SnxGADGwVs08O5pfPdn4plWgCe
	ABiFCjY3rDUJotTupkY+TV10Y6gKgXFxx3LfpCErVQn6pspnyYNOmeKId4kios3rkxod4oQ==
X-Gm-Gg: ASbGncsYQRzVxIvgOMAGIbD1sld5T9hhoVQQM+6LY70hP4OpJRG7COvRmKrH0dLp7Xr
	B5+/6X6MrhbohStV/8o9ac/TQAgl8UjgsBhsn3CjHjGwE50Yl7bFPNbsKJtJ+b29cS/mm+V26Iv
	KoehSVQWZdTQhC9fPOClFz1wfNnT+VLwKgoBgKr7cF/UoR1eQuP5/17vKceIgmo8HONRlawxDn6
	N25tyCx2YakyOM6Bcfqb5qf1Ek3kySGNbJPVNdV258+4QuMpNa3PSY+LrgS6iPTq0UzV7Z7TPpa
	jH7MCCcfME+oIK30kjD1Ka3T62I2p12fYDz0mDlVuOVt0ubbfic3fBDvekDoLjRMtHhSjw==
X-Received: by 2002:a05:6000:4009:b0:3a8:2f65:373f with SMTP id ffacd0b85a97d-3aa9fc2002dmr14430359f8f.16.1751382234599;
        Tue, 01 Jul 2025 08:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5ip4Lsfs511rWGCphqHTr2OYeW2YS07ZtdCFVV6qDRDtOPxnE/M6i+tt8fVSUZRoLJeUOug==
X-Received: by 2002:a05:6000:4009:b0:3a8:2f65:373f with SMTP id ffacd0b85a97d-3aa9fc2002dmr14430281f8f.16.1751382233984;
        Tue, 01 Jul 2025 08:03:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c4acsm195314915e9.1.2025.07.01.08.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 08:03:53 -0700 (PDT)
Message-ID: <d36b7df3-50b0-4dda-ba27-b948d8de3a20@redhat.com>
Date: Tue, 1 Jul 2025 17:03:51 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH qemu v16 3/5] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com,
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
 <itaru.kitayama@linux.dev>, linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 qemu-arm@nongnu.org, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-4-Jonathan.Cameron@huawei.com>
 <4ceea721-b633-499e-9fcd-735990ee0704@redhat.com>
 <20250701154110.00007675@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250701154110.00007675@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KIOpQd9SUI2URySDUy1zmh6p72fau-2TjyGWXRQkxlU_1751382236
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 7/1/25 4:41 PM, Jonathan Cameron wrote:
> On Tue, 1 Jul 2025 15:26:26 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Jonathan,
>>
>> On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
>>> Code based on i386/pc enablement.
>>> The memory layout places space for 16 host bridge register regions after
>>> the GIC_REDIST2 in the extended memmap. This is a hole in the current
>>> map so adding them here has no impact on placement of other memory regions
>>> (tested with enough CPUs for GIC_REDIST2 to be in use.)  
>> Doesn't it depend on the init RAM size setting.
>> if the init RAM top + REDIST2 aligns to a 256MB boundary (size of the
>> PCI ECAM) aren't you likely to have no hole?
> Hi Eric,
>
> Is that possible?  I think the device_memory_base being force to align
> to a 1 GiB means that never happens.  That seems to occur even
> if there is no device_memory.  
>
>     device_memory_base =
>         ROUND_UP(vms->memmap[VIRT_MEM].base + ms->ram_size, GiB);
>     device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;
>
>     /* Base address of the high IO region */
>     memtop = base = device_memory_base + ROUND_UP(device_memory_size, GiB);
> //So here we are GiB aligned.
Yes you are totally right, even without device memory, base is 1GiB
aligned when entering virt_set_high_memmap. I forgot this alignment
enforcement.

So we are good. Sorry for the noise

> ...
>
>     if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
>         base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
>     }
>
> //That's 256 GiB in or leave it alone as more than that but GiB aligned.
>
>    /* We know for sure that at least the memory fits in the PA space */
>     vms->highest_gpa = memtop - 1;
>
>     virt_set_high_memmap(vms, base, pa_bits);
>
>
> So I think I'm fine. I should call out that REDIST2 is GiB
> aligned though in this patch description.
>>
>>> The CFMWs are placed above the extended memmap.  Note the confusing
>>> existing variable highest_gpa is the highest_gpa that has been allocated
>>> at a particular point in setting up the memory map.  
>> what kind of improvement would you foresee wrt highest_gpa?
> This was mostly a response to Peter expressed that he was expecting
> highest_gpa to reflect the limit, not the highest yet seen.
>
> I'm not sure how to resolve that without having awkward naming
> like highest_gpa_sofar. There are existing comments where it is updated
> so I'm not thinking we need to change anything for this.

OK I understand now.

Eric
>
>
> Thanks for taking a look,
>
> Jonathan
>

