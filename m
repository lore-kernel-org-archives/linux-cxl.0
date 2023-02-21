Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255EFC61DA3
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 22:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBUWdX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjBUWdV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 17:33:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6C931E0B
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 14:33:18 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v3so5918849wrp.2
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 14:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzhs0wgAM9Jc5NqHZvSxpJb9rIGrF2/O5kKwwX9lr1U=;
        b=WezV8Q6MmLeaia+2khhexvSjqeccd34imelZaGlYrEGVA2LDOYR5pSncsVadiLLaG2
         jR4Y2/yU0Cmb9+PkSAAyfcq0Opr6ZijGc6UZXToQkutC51ZYh2vvNYhyiiLZlyDRdAbU
         hMDhnBS45eWcsV+k0mrfKKQ39DGnb+fmBniciWwyGmz2+0W9GmeOrIi4N023mladC6/t
         oXjElCUJeDiMH9OFpnFjpAunZey5aGMKtnh8lHTweXi8jKo5nkt0aZfsxgAjjrI3lBPZ
         C3+ToVSMF29B8QqJTPed4euWy3amkh9tnMaxKFvjnm1Y+XkCIsAgBHqjJEhULAUeWd5i
         l5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzhs0wgAM9Jc5NqHZvSxpJb9rIGrF2/O5kKwwX9lr1U=;
        b=VwERUatp/0g1UT2MmHKb7WsLiuadi507MuFbQ8KwNz83yOt7wxhsdkYRR2UOUd+4xH
         z+Katjr4pS1fNSp9LWu5l25Pf88EyPYGUfAuNHI/QPEQydP7oT2QbbLP7rjMl/cLkfgy
         Uuy6ii59ti1x8ZIRhS/rvCeL8vqaHpxUurhtmE1QaoZ18AbOg1bVbtbzCz5CrtcZ+mWb
         Jyk8DTKV8NE/OY9a3CjWIstlwLwQfEcr5JUS7sNWh6fgEy8tx5JEK0qG6LquGKnesnaL
         hg/BLGii1jPeSXX0i68ys/9gvi/rsk3qweuS/Vx2WV+Y2So2TvbSoHXfcNUH3OXGBG5p
         uVaw==
X-Gm-Message-State: AO0yUKWG01SVLELWd1N1Au/Dx+6TCOMMDcOtiTFVvp0oMWpljzW94yvP
        i6xBB3neVaNtBUmwL+sMSbJDyg==
X-Google-Smtp-Source: AK7set8//mroLBdJNgQoPmv6dRQWiGcH7Ib+K+B1vVE3/OAtqVCPROXVuP0DB5BEisXoMNAfvXdO8w==
X-Received: by 2002:a5d:4206:0:b0:2c3:ea8b:2724 with SMTP id n6-20020a5d4206000000b002c3ea8b2724mr5847066wrq.21.1677018796636;
        Tue, 21 Feb 2023 14:33:16 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id g4-20020a056000118400b002c5544b3a69sm2567368wrx.89.2023.02.21.14.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 14:33:16 -0800 (PST)
Message-ID: <d02c267e-ccfb-05c2-6eda-8de21a2793d8@linaro.org>
Date:   Tue, 21 Feb 2023 23:33:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "reviewer:Incompatible changes" <libvir-list@redhat.com>
References: <20230221140023.9315-1-Jonathan.Cameron@huawei.com>
 <20230221140023.9315-3-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230221140023.9315-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21/2/23 15:00, Jonathan Cameron wrote:
> From: Gregory Price <gourry.memverge@gmail.com>
> 
> This commit enables each CXL Type-3 device to contain one volatile
> memory region and one persistent region.
> 
> Two new properties have been added to cxl-type3 device initialization:
>      [volatile-memdev] and [persistent-memdev]
> 
> The existing [memdev] property has been deprecated and will default the
> memory region to a persistent memory region (although a user may assign
> the region to a ram or file backed region). It cannot be used in
> combination with the new [persistent-memdev] property.
> 
> Partitioning volatile memory from persistent memory is not yet supported.
> 
> Volatile memory is mapped at DPA(0x0), while Persistent memory is mapped
> at DPA(vmem->size), per CXL Spec 8.2.9.8.2.0 - Get Partition Info.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v3:
> - Don't set the DVSEC range register base address
> v2:
> - Fixed an off by one in address space selection.
> - Gather tags.
> ---
>   docs/system/devices/cxl.rst    |  49 ++++--
>   hw/cxl/cxl-mailbox-utils.c     |  26 +--
>   hw/mem/cxl_type3.c             | 294 +++++++++++++++++++++++++--------
>   include/hw/cxl/cxl_device.h    |  11 +-
>   tests/qtest/bios-tables-test.c |   8 +-
>   tests/qtest/cxl-test.c         |  76 +++++++--
>   6 files changed, 353 insertions(+), 111 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index f25783a4ec..89a41cff73 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -300,7 +300,7 @@ Example topology involving a switch::
>   
>   Example command lines
>   ---------------------
> -A very simple setup with just one directly attached CXL Type 3 device::
> +A very simple setup with just one directly attached CXL Type 3 Persistent Memory device::
>   
>     qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
>     ...
> @@ -308,7 +308,28 @@ A very simple setup with just one directly attached CXL Type 3 device::
>     -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>     -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> +  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> +
> +A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
> +
> +  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
> +  ...
> +  -object memory-backend-ram,id=vmem0,share=on,size=256M \
> +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> +  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> +  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> +
> +The same volatile setup may optionally include an LSA region::
> +
> +  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
> +  ...
> +  -object memory-backend-ram,id=vmem0,share=on,size=256M \
> +  -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa.raw,size=256M \
> +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> +  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> +  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,lsa=cxl-lsa0,id=cxl-vmem0 \
>     -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
>   
>   A setup suitable for 4 way interleave. Only one fixed window provided, to enable 2 way
> @@ -328,13 +349,13 @@ the CXL Type3 device directly attached (no switches).::
>     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>     -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
>     -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> +  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
>     -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
> -  -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
> +  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
>     -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
> -  -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
> +  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
>     -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
> -  -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
> +  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
>     -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
>   
>   An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
> @@ -354,15 +375,23 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>     -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
>     -device cxl-upstream,bus=root_port0,id=us0 \
>     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
> -  -device cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
> +  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
>     -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> -  -device cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
> +  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
>     -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
> -  -device cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
> +  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
>     -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
> -  -device cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
> +  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
>     -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>   
> +Deprecations
> +------------
> +
> +The Type 3 device [memdev] attribute has been deprecated in favor of the
> +[persistent-memdev] attributes. [memdev] will default to a persistent memory
> +device for backward compatibility and is incapable of being used in combination
> +with [persistent-memdev].
> +

Probably worth mentioning & referring this in docs/about/deprecated.rst.
