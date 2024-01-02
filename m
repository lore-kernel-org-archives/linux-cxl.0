Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81BDDA7
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jan 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taRmKF6T"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so52391805e9.1
        for <linux-cxl@vger.kernel.org>; Tue, 02 Jan 2024 02:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704191350; x=1704796150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZt+jI3yrrtHW+ylSqnHBTIVmmrElsiUaVV6R1l2/6Y=;
        b=taRmKF6TsZdk8r/n5XKjr2XPS4zr/pXYdb0oeSPYaN2mGiABYFIoAaF6ejIpBkhKfx
         Xh+2Fus9hZta7ooH86u0ISC34ukbLVvIRaIjyiRiOMNX1MtqFEzqAb+02iXzA1LhDjqs
         zZ/Gty+9KSyAMQjdeyhj6sSlN+f9Jdgfvb9ETg1EiBBdvI64XXwmzNCYv7RS0zlmTT9n
         9S+IQ95shG37CkySSzGyrbgo0k9wyLYfrVojSW3+/yjwww7ksj5OG6exA9DOeUVaAHDU
         iK4+REBQ6JUYlV856rE3PsVR19zge/TEaka2hL5eZLgtG7g7rtvRgMD7KhimGATkMgfq
         UCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704191350; x=1704796150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZt+jI3yrrtHW+ylSqnHBTIVmmrElsiUaVV6R1l2/6Y=;
        b=RrIdu13dUgS8w5iYEI9WJeF9zhSnYCFGO9nD979kVMoxHVK4ObYUwHuOE5XW+xCH2y
         pJOd9p1muaSkIm5Sqlz2dPq5h9m0mDdCbDm8lkOo3Y/r7uTHgoF5xtdNLUYxFM7/QXhD
         MOf6+Z2TJojm73/PxExTHvozRyGGMb93S0U2nbnOpcFC9UxeMw5xNoB0c1PDyK20K6xt
         gnPNLFGK4fAs/3AiGFala6cu1WbuiAgBHZzMAgabZDIXN0DdJ7PAJ2zMhlbvVNZkK0xO
         Vkhvypfz4rFN6om15rcQAh5hUjZXNoI8i9DfpCFhJ2DjB3mXzCtXhK0m7EunwW7iLHLH
         N4KA==
X-Gm-Message-State: AOJu0YwlqV8QcUE3s/o8MP0E6LxzoQJkeexyzcyJ0R0g67WLrWHY2TCs
	TMsK6my9wqshquMfcC9pZf9lJA21+m8T1Q==
X-Google-Smtp-Source: AGHT+IHAb3J/DyUzJZ5XQrEKJCwXXjtwAJtsL+ESzB0vCFur9k//lqdpUL+GN3kc0YeflrCbgVv1XQ==
X-Received: by 2002:a05:600c:4f56:b0:40d:85a1:8d0a with SMTP id m22-20020a05600c4f5600b0040d85a18d0amr1787566wmq.113.1704191350241;
        Tue, 02 Jan 2024 02:29:10 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr. [176.184.16.71])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b0040b37f1079dsm51650250wmq.29.2024.01.02.02.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 02:29:09 -0800 (PST)
Message-ID: <75843b7e-1460-4ea2-8837-51299a3a232b@linaro.org>
Date: Tue, 2 Jan 2024 11:29:07 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QEMU-devel][RFC PATCH 1/1] backends/hostmem: qapi/qom: Add an
 ObjectOption for memory-backend-* called HostMemType and its arg 'cxlram'
Content-Language: en-US
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hao Xiang <hao.xiang@bytedance.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Widawsky <ben.widawsky@intel.com>,
 Gregory Price <gourry.memverge@gmail.com>, Fan Ni <fan.ni@samsung.com>,
 Ira Weiny <ira.weiny@intel.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, linux-cxl@vger.kernel.org
References: <20240101075315.43167-1-horenchuang@bytedance.com>
 <20240101075315.43167-2-horenchuang@bytedance.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240101075315.43167-2-horenchuang@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jack,

On 1/1/24 08:53, Ho-Ren (Jack) Chuang wrote:
> Introduce a new configuration option 'host-mem-type=' in the
> '-object memory-backend-ram', allowing users to specify
> from which type of memory to allocate.
> 
> Users can specify 'cxlram' as an argument, and QEMU will then
> automatically locate CXL RAM NUMA nodes and use them as the backend memory.
> For example:
> 	-object memory-backend-ram,id=vmem0,size=19G,host-mem-type=cxlram \
> 	-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> 	-device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> 	-device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> 	-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=19G,cxl-fmw.0.interleave-granularity=8k \
> 
> In v1, we plan to move most of the implementations to util and break down
> this patch into different smaller patches.
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>   backends/hostmem.c       | 184 +++++++++++++++++++++++++++++++++++++++
>   include/sysemu/hostmem.h |   1 +
>   qapi/common.json         |  19 ++++
>   qapi/qom.json            |   1 +
>   qemu-options.hx          |   2 +-
>   5 files changed, 206 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c


> +#define CXL_DEVICE_PATH "/sys/bus/cxl/devices/"
> +#define REGION_PATH_LEN 307
> +#define DAX_REGION_PATH_LEN 563
> +#define DAX_PATH_LEN 819
> +#define TARGET_FILE_PATH_LEN 831

How do you get these numbers?

> diff --git a/qapi/common.json b/qapi/common.json
> index 6fed9cde1a..591fd73291 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -167,6 +167,25 @@
>   { 'enum': 'HostMemPolicy',
>     'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
>   
> +##
> +# @HostMemType:
> +#
> +# Automatically find a backend memory type on host.

This description is not clear (to me).

> +# Can be further extened to support other types such as cxlpmem, hbm.

Typo "extended" although I'm not sure it is helpful to mention it.

> +#
> +# @none: do nothing (default).

"do nothing" is confusing here, I'd drop it.

> +#
> +# @cxlram: a CXL RAM backend on host.
> +#
> +# Note: HostMemType and HostMemPolicy/host-nodes cannot be set at the same
> +# time. HostMemType is used to automatically bind with one kind of
> +# host memory types.
> +#
> +# Since: 8.3

9.0

> +##
> +{ 'enum': 'HostMemType',
> +  'data': [ 'none', 'cxlram' ] }
> +
>   ##
>   # @NetFilterDirection:
>   #
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 95516ba325..fa3bc29708 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -626,6 +626,7 @@
>               '*host-nodes': ['uint16'],
>               '*merge': 'bool',
>               '*policy': 'HostMemPolicy',
> +            '*host-mem-type': 'HostMemType',

Missing documentation in MemoryBackendProperties.

>               '*prealloc': 'bool',
>               '*prealloc-threads': 'uint32',
>               '*prealloc-context': 'str',

