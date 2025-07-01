Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060B2777FD
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386367; cv=none; b=neVfgdRXpiliHgwR8qAhLS5srhtmVLy6muIjLZDadRsMBIXMgUTXnIKNyJs6RSHDO1cZ26O6IYeydp7ZkBX1dnWIkzXm1nDFDu4Y+HMyFYwJmffNeyhnp5iSj47nJj7rbInnEUxQadGyvif+jzr52jT4rlvNl5H1tvWQqIAwjjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386367; c=relaxed/simple;
	bh=0oZF13dCmhUdoWJwhAGDi2DUHVxi2ttId4WTRfxz59g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+wd4zIgMfhOBk/sx++M21W/GB3iOeDT/0PAYqZvOqeR87l2fuD2oUB+El2/Rt0dzBWbmMqH7KiG2GPeYYyauZdNlJ4x8HV7QPKE/nhEuTaSmARLxI5y+9I41bxC9ejNSmE5j4XVGx5+oY916Rz62FYnI+xjEh3Al2ioOaRMrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVlc0oHo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVlc0oHo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751386364;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5NkSCYgm+5mmXaHIh6/iab5ImzUVQL7sPGLKwXT8E+0=;
	b=TVlc0oHoYafhTvo06PWM96+bu3uNcUeznVcw/0Q7gORdZIgKu1D+enAsVvq80ZfW4Cb3X+
	OenZ0ZDl7rNW/z7jsmWKss1C72Q4sw580YpIyYAxn80/wCwg9hZUeW8dMQ8twZxJCcH16t
	Ctqxeaq+d7hadwQI2R8hpDDZXyAo9mg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-VNw_OKGNPae8am3rc1N3vQ-1; Tue, 01 Jul 2025 12:12:43 -0400
X-MC-Unique: VNw_OKGNPae8am3rc1N3vQ-1
X-Mimecast-MFC-AGG-ID: VNw_OKGNPae8am3rc1N3vQ_1751386362
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4539b44e7b1so18330035e9.1
        for <linux-cxl@vger.kernel.org>; Tue, 01 Jul 2025 09:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386362; x=1751991162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NkSCYgm+5mmXaHIh6/iab5ImzUVQL7sPGLKwXT8E+0=;
        b=cOgvWhp1kpWFDagPnr/PlheVwIpaX5Ld2CjL7VqJEs+yneouL3Z9RmtxbozqJzPXbM
         QnFxk/HXU00MoMA7FoUMRt81tY270v2uMiAfLpJjzsxSh6GcEX2NlWClazDgDB59sBB1
         tprQm4uPg17aJybZp4oZvd3fyUvqpRS0UZJHyjd96Jtffl4RmjWSNUx2mZHB4HirMyNq
         HNHOiOLD/BbHTfcX0+qaA36ycGBJ1rrah7otj1sMVuYda51mdd7tbKOLDAgrIi/KZaup
         sOVVnQZIyYjZS9YOvhRHOqEKxsYlyKHNOwI95BTWsPn2JcLIEt8G6w895+bvRLqx40lc
         mh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7I+zinVrT6WkJ7/mE9/bq+uUWC3c9FEfU8fghMMAYTBAz5PCdxj6HrFIC9/TWBiiF0U6USPx2PqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUyTG7BeDB7l8mzebV0pDe85TZloD2Jkz2ZyfrvpPaks1/7Px
	i/TlgzA9kYHxbujaGWfmqbVWlwsn1UY5ltUwsFRJO9assVYzU/l2Tpp0cZFJqHNzB8OibVQo70D
	neE0VLUPm1MKOoEuvzhKgvQxde9pZo5GLOVW4RJGIinTliqkTU8pCSvF92iIMkw==
X-Gm-Gg: ASbGncvfCSX8A5fa8W7IPwllbVA9E1b7tG+IXBhgu4tAOZErUxttnyd+QmqWi5AmlU0
	IeplYSYmgLd1OadKg3qVC2P5nX/LtvcCPR0XLYcxYwWbXB4V3lgwOSUDbcBL3MkITB/EiTIVDDr
	hN3aThyrW6E+kTT83aKc4FHw71JIyy8yDlFMK6gPCGu4VOrmh5GL2rPAnLgIKuWkJHhtGKMdfr4
	co0C49++TqyYtAgeiPvETosjTUzPNYbKYRlV1D0JasNEO3j+8cFXQeR3jPSBBBoLLserK1eMwIA
	EIc94nzmbJg2jGjZBgSUROFoIRJAoP3id4DUju5s2s31g3wX0BUinNLEDOui35eFhvsWOw==
X-Received: by 2002:a05:600c:3b22:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-4538ee3343dmr201835615e9.4.1751386361499;
        Tue, 01 Jul 2025 09:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUxtPdWyJP+Gh38lQd6OscAC/exsnY5TcmCtIrtDeSaT4JNW56f9ovA5tFf9G042kRjDh+1Q==
X-Received: by 2002:a05:600c:3b22:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-4538ee3343dmr201834985e9.4.1751386360971;
        Tue, 01 Jul 2025 09:12:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm198790095e9.3.2025.07.01.09.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 09:12:40 -0700 (PDT)
Message-ID: <954f10cf-3de4-4067-878c-f0bb07e9dbe0@redhat.com>
Date: Tue, 1 Jul 2025 18:12:39 +0200
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
 <128e59be-4038-4a19-8cca-3be3d6446e0e@redhat.com>
 <20250701165222.0000068f@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250701165222.0000068f@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GPycT9EXqTsxjGH9axjyNWaTHD-9hZkgND5TCqdwMbc_1751386362
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi Jonathan,
On 7/1/25 5:52 PM, Jonathan Cameron wrote:
> On Tue, 1 Jul 2025 17:34:36 +0200
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
>>>
>>> The CFMWs are placed above the extended memmap.  Note the confusing
>>> existing variable highest_gpa is the highest_gpa that has been allocated
>>> at a particular point in setting up the memory map.
>>>
>>> The cxl_devices_state.host_mr is provides a small space in which to place  
>> s/is//
> Fixed. Thanks.
>>> the individual host bridge register regions for whatever host bridges are
>>> allocated via -device pxb-cxl on the command line. The existing dynamic
>>> sysbus infrastructure is not reused because pxb-cxl is a PCI device not
>>> a sysbus one but these registers are directly in the main memory map,
>>> not the PCI address space.
>>>
>>> Only create the CEDT table if cxl=on set for the machine. Default to off.
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>> @@ -1895,6 +1917,9 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>>>      if (device_memory_size > 0) {
>>>          machine_memory_devices_init(ms, device_memory_base, device_memory_size);
>>>      }
>>> +    vms->highest_gpa = cxl_fmws_set_memmap(ROUND_UP(vms->highest_gpa + 1,
>>> +                                                    256 * MiB),
>>> +                                           BIT_ULL(pa_bits)) - 1;  
>> in hw/cxl/cxl-host.c, there seems to be a loop on fw windows? I guess
>> those windows only exist if cxl option is set. In the positive,
>> highest_gpa will be changed only if the option is set, which is fine.
>> Indeed we have requested_ipa_size = 64 - clz64(vms->highest_gpa). So we
>> shall not modify this if cxl is not set.
so do you confirm highest_gpa is unchanged in case cxl/fmw option is not
set ?
>>
>> What I am a bit concerned with is that it"consumes" some high memory
>> without making it explicit in extended_memmap. Shouldn't we book some
>> dedicated space there? Sorry I am jumping very late in the review, maybe
>> turning things worse & noisy :-( Eric
> No problem with late review - whilst it looks late we had a several year
> gap at one point in updating this series!
>
> How much to book?  It's effectively infinite much like device memory.
> Would be odd to book the minimum which is 256MiB given any useful system
> is going to have a lot more than that (they are usually a few TiB but
> may be much larger than that).
>
> Would a comment after 
>    [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE }, 
> such as
>    /* Any CXL Fixed memory windows come here */
> be enough?
yes at least it deserves a comment I think. Then it must be understood
that it may prevent new regions from being added in the high mem range.
I am definitively not the most knowledgeable guy to decide whether it is
critical. I have not checked CCA impact on the layout for instance.

Thanks

Eric
>
>  
>

