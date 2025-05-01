Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5891DD0EF
	for <linux-cxl@vger.kernel.org>; Thu,  1 May 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746136193; cv=none; b=ogzSXOANomkEGfu9aW68CkNyM7BB/yV3nTT6AK4sOrdW74Bk2D9Pdi5ak3loxNEa77mrA0n7ug5/3M4hh4hURFyNiySx9DKnJgbetc3I/auToQgkeOmgBKMWbRs7JqsKqyUyBKX9RaHBIFf/xoRSIMYmCaK7jGckn7BjG3FJ9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746136193; c=relaxed/simple;
	bh=s9DzIHm+ijqQAUEYYWNAW/UKs9ZkDQfTRI5itG8dt1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D13B0ooNzvD2n8bgBwQOy0K27KC7nVdBYN7Jw2kykSl6D4P0KGaqJ5LavSJ+ckvzoJZIOvQ75OBuxV+4JUf2rUdwsv5m/tKKe3hANsxNFDXI/jzQ3YAWzBCJMgZDnEwaxshC3ZAaPjamQQR3mNrdjy4KX9/IcdY7yqx1eVo9H/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U2Uwv+gH; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2Uwv+gH"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d8fc9dbce4so9527655ab.0
        for <linux-cxl@vger.kernel.org>; Thu, 01 May 2025 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746136190; x=1746740990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rr6BFBQrpoBkaUZeh7DoqYwcB8XwJFEp9+Dw7V6RYH4=;
        b=U2Uwv+gH9CFnnH5wmeIHcW9dw4RL9TaQXd1rDpccPsiEpL/UIlAAe/wgmUJcuL8I+I
         1TZe2udZvuwJDwRWhxMokSzQqhmbWAL4ew2NQef4YmF5yfiHKAJXCYHHIhwj7O2BNg25
         P9pmfWNIG4XAREslArzp1J2khBS31OIAZ8JQQ9YAeaj0c9EhiCUCGh5ZuQr4DQ3G35sw
         SR6LTrIUL/gVU8XDjpLquYHxb/pVtzjjw08ftL3OhRSQ676OMtO9PPhRhLa5nkpOQdAN
         +EFbd5iMZIfqxLrI2K78g7TdIJFKH0wf1IR16zYYgapdqPh8tQ9Jjy0BbfsrgMQTSLvN
         yzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746136190; x=1746740990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rr6BFBQrpoBkaUZeh7DoqYwcB8XwJFEp9+Dw7V6RYH4=;
        b=qghDHtRDXZWmnJkcXPL71wjM8VD05bRLaRhmayRHiD9moGKoaR9Poc3XICJT0jQEO5
         XckZ9MnUtScr9cylYKEvdq5XhKfSmd4ZHKt3azfHFqbTqlfNfsS3Q26AQjoC0bdwLZ/T
         sjw5ZKUAnTeyT9wYrFmOu8kVb+RM3tIZOK/LsPFSUYlLIm5eneLY7WP6FY6PhoDnlGZL
         mFVrSQ8xBAjOCUNFc4tEzPNly7ZmxSeLpsLiqPTuWukONQ09lBuqS0fbkAKHqVsRs3ZN
         scG8po3wL3718G2w5FR7Y98g0YiuT+I9KOoe1hEDWES56Ed1FwnjTYJL6Ck3dvaHfowF
         SuCA==
X-Forwarded-Encrypted: i=1; AJvYcCW/fyZt7tQYMxz2itEAI5tJjLd6rVyAgSXB+D9SpHJLHAJjBLiATtntiMZCNRQgcMe30Si/X0B0vnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9ShM5UUXjutFGDZZDq1BnLhA8VeTLPxHlIZjqNJRiXjRxYQL
	6rujC8wXpbYz+PMJBeXAy40qowNRMvyAvLBuFIue07l+t8pU9yaqkx/SNW/WJRE=
X-Gm-Gg: ASbGnctChZstDoZlluRNxIeXV/NJ5V1frPBbWVTq8m86ShtVUwposvP9ofhcQxi+2yT
	h3kIWGTF6guMyCA2ssVl9bcwAz4q7o+PHgfJjfPTcIltTXt5McHvlBJrO0UgmuuyAeDDqF0P9op
	wT4NzdVVzbGHiaasb2m+6L+qZeHdM6Y84ziH+Wl0hrV/MNVua4Pe4pYDuc4c1Qu8tzsipomRWA4
	MPDH1kW2g1y+3sP+OjyLyc2fqBlkL7C+UBH93hDQ/XDPE9q1sqe7bm+DEiJLB5DCb1+TQFyyCDy
	n6ar6UmV4hndj9UxDRROgmvkHrQhw5YjkCaLEFulCjCSOb3senXBKT35zN8xMBu+4Ke34nAqxG+
	X2csz6c1a0IWVaQ==
X-Google-Smtp-Source: AGHT+IF+PiU0/Kg2yfNoRftmPiOM41YJkxyELYES2SKx5WZSsMyO+vdbOTfpnPmc4Qdx55zGcq4S/Q==
X-Received: by 2002:a92:c512:0:b0:3d8:17b4:1792 with SMTP id e9e14a558f8ab-3d970aa462dmr53305105ab.3.1746136190245;
        Thu, 01 May 2025 14:49:50 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa58d6fsm60724173.89.2025.05.01.14.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 14:49:49 -0700 (PDT)
Message-ID: <1528a021-d3ec-495e-a42b-6614d60b0666@linaro.org>
Date: Thu, 1 May 2025 23:49:45 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC qemu 1/6] hw/pci-bridge/cxl_root_port: Provide x-speed and
 x-width properties.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, mst@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 marcel.apfelbaum@gmail.com, Dave Jiang <dave.jiang@intel.com>,
 Huang Ying <ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
 fan.ni@samsung.com, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
 <20240712122414.1448284-2-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240712122414.1448284-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan and Alex.

(This patch is now merged as commit 1478b560902).

On 12/7/24 14:24, Jonathan Cameron via wrote:
> Approach copied from gen_pcie_root_port.c
> Previously the link defaulted to a maximum of 2.5GT/s and 1x.  Enable setting
> it's maximum values.  The actual value after 'training' will depend on the
> downstream device configuration.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/pci-bridge/cxl_root_port.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index 2dd10239bd..5e2156d7ba 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -24,6 +24,7 @@
>   #include "hw/pci/pcie_port.h"
>   #include "hw/pci/msi.h"
>   #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>   #include "hw/sysbus.h"
>   #include "qapi/error.h"
>   #include "hw/cxl/cxl.h"
> @@ -206,6 +207,10 @@ static Property gen_rp_props[] = {
>                        -1),
>       DEFINE_PROP_SIZE("pref64-reserve", CXLRootPort, res_reserve.mem_pref_64,
>                        -1),
> +    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> +                                speed, PCIE_LINK_SPEED_64),
> +    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> +                                width, PCIE_LINK_WIDTH_32),

Per the documentation:

   We commonly use a ``x-`` command name prefix to make lack of
   stability obvious to human users.

Are these properties meant to be stable? You mentioned "Approach
copied from gen_pcie_root_port.c". There they were added because
of:

commit c2a490e344b4e231cf9488c67df7ee46977b1ebe
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Wed Dec 12 12:39:43 2018 -0700

     pcie: Allow generic PCIe root port to specify link speed and width

     Allow users to experimentally specify speed and width values for the
     generic PCIe root port.  Defaults remain at 2.5GT/s & x1 for
     compatiblity with the intent to only support changing defaults via
     machine types for now.

This was 6 years ago, are we still experimenting?

>       DEFINE_PROP_END_OF_LIST()
>   };
>   

