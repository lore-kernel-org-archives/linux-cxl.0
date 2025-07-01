Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4AEA926
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384531; cv=none; b=ClBKVUpN5YEBpwfukuR/SnxF6b/04Smtg5L0vQERwEOA3VLWaVRDvGsTyWiNMaHja6yNWoQE8S7X9XgT5WdCUD7CqhNgDOp1Nf+3XQ5F+raDLcqppa4gE+EQZViU23tveqQfBLrsA8DBV6QBd5Ec5E9qIM0G1ZD/AAWzmp3kIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384531; c=relaxed/simple;
	bh=3cLvZqk7Rf2uiDyoldy3vnUG9sBlR2/O4wymH7zjmJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5NFynFJa1j1ZMXRsojVNMSXmbpBLXFDDFsiWCidgBTOrSB/xAkuC9NKUD+6dR7GgAEDiIB744DDZS5jt5CeUSUWCoy5aTFpL/26MFNvyW59CgwwWw7p1g+3Y0IrqXvo4HhdhniJ5ciN0diXXmw/pLN6Fzi+/Wu25rYFsiwD5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eKiaorNw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eKiaorNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751384528;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knpxdZnqXLQC9XtqfBwzd0/gTVLSukHtyaVrMMe7/AE=;
	b=eKiaorNwMzfpUKP+h9RHEkwF/1IZPZ0qVF0gTsSHSsceHEyRKHwK0UfNGVlxXNzBWmcxwu
	dc4MpT08aJvRis9nzSvrsHSEVhzV/yjvY3hgRPWX+xDzDo/42GYBtN9QmJD3y6YF3RlHkA
	jb8UmKWWyqE6w9jikrypLJPRg3JMVI8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230--Z-RfoubN_2XDoqMODmEdQ-1; Tue, 01 Jul 2025 11:42:07 -0400
X-MC-Unique: -Z-RfoubN_2XDoqMODmEdQ-1
X-Mimecast-MFC-AGG-ID: -Z-RfoubN_2XDoqMODmEdQ_1751384526
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so28226645e9.2
        for <linux-cxl@vger.kernel.org>; Tue, 01 Jul 2025 08:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751384526; x=1751989326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knpxdZnqXLQC9XtqfBwzd0/gTVLSukHtyaVrMMe7/AE=;
        b=u0ka3FNwasXUOjTTevEUtc/YbhVGPEvC3vdWPnsow5op7CF9n1AMpeO94blSGqDEJd
         6J1gdDnZ4819CJnzFtGS3YuW8jiFRonBvYW9tgKBSPbR1RchSv9rB4EQuJdK2QvHzCHX
         Be+ti3dVbM46kCUbW8z5/ZWRQGcwTvQGP0hsAuitewr+o6U9s/nWRI4hBb55iASmX3ij
         5boWbBoEofVsDcZ6b35P9/TBfi9uty+MP+AVQvUeprY59TWpMBBNk36u7IoNamIRpo4+
         uxwdvFMKxo6x0pdetsCWnnUFhxLH+OsX6xsEpMH53Nd2QIJN+bgYweLuz1TnePUk/DRG
         HVTw==
X-Forwarded-Encrypted: i=1; AJvYcCVZCT1/5xtiFCuMs19vr9UVJDBoOs1E6Up7fBV967LvgEaH+Z4Fj7aB2iDiP2YTa3AsgOF3o2l3tLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/A8EJCmueChrw1MH1K8gyfbalIKid0fNWLte63ZM0ig5N1QTP
	69oUpZM9xIqJOlg2SmzYZHAkCrw3n9Eq1zetndCtSSTNHHDj0D7EOzvS6FNAjP0BSvTxk97DRq5
	DPcvysXZlO6yjFICWts4JxSY7GJhqQuesxyHmTx/80m65rYlE5YIUXJnU6l2clA==
X-Gm-Gg: ASbGncvgWgW2yRQVuqQJ60QLYiOjaqQiqftYBTFYsBIn6isgLfkdVMbsr5+aUud9cSK
	L1zHzLKHxWTP5OSL8qWKC3ll2McdIL6k1bgv0IJGdOtRzwd/UjHAE31bon436BKDJ41d4HjyGy4
	iPtVhCvQDywQfciCFkcKyd2sUEKPMyUz83opKqqlQ9amVp3/At4nGt7twnYr46v7vgo8d3Hk//p
	kQGbbXvzBUMLk8LgBx8+Noz4ueaMhuOb37NskrVdtErbw4KdkDCUlQqvN8qm1pGolgSfi1F1LAL
	CMcWGU9cdDICu+9EZErNQt3O7U2oC9O0locpPv93+cjYPMLaqwBb9w8YZ6KZc2LzwK6yBw==
X-Received: by 2002:a05:600c:828f:b0:450:d00d:588b with SMTP id 5b1f17b1804b1-45392bc88damr174331175e9.9.1751384525599;
        Tue, 01 Jul 2025 08:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJve1TAHCBKdYAwJ4yJVAsUhL5lVig43gaMFe/oIWm5C97bZeWTADeUSVHhlbUroDFDgSg3Q==
X-Received: by 2002:a05:600c:828f:b0:450:d00d:588b with SMTP id 5b1f17b1804b1-45392bc88damr174330815e9.9.1751384525163;
        Tue, 01 Jul 2025 08:42:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3a5599sm173282975e9.13.2025.07.01.08.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 08:42:04 -0700 (PDT)
Message-ID: <29373347-2b7d-4cb8-9b0f-7b53d5633890@redhat.com>
Date: Tue, 1 Jul 2025 17:42:03 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH qemu v16 4/5] docs/cxl: Add an arm/virt example.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 mst@redhat.com, Zhijian Li <lizhijian@fujitsu.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-5-Jonathan.Cameron@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250625161926.549812-5-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sS6ou74ru7Y0sumFdfPXb8NEgszSityFqxmtWv1V06c_1751384526
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
> Only add one very simple example as all the i386/pc examples will work
> for arm/virt with a change to appropriate executable and appropriate
> standard launch line for arm/virt. Note that max cpu is used to
> ensure we have plenty of physical address space.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  docs/system/devices/cxl.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index e307caf3f8..73e80e672f 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -384,6 +384,16 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>    -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>  
> +A simple arm/virt example::
> +
> +  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8g,slots=4 -cpu max -smp 4 \
> +  ...
> +  -object memory-backend-ram,id=vmem0,share=on,size=256M \
> +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> +  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> +  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
Matches the x86 identifical example entitled "A very simple setup with
just one directly attached CXL Type 3 Volatile Memory device"
nit: in case you need to respin you can add something like "featuring a
CXL Type 3 Volatile Memory device"

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> +
>  Deprecations
>  ------------
>  

