Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69626C83F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 13:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbjIDNqB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIDNqA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 09:46:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD11731
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 06:45:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a603159f33so213421466b.0
        for <linux-cxl@vger.kernel.org>; Mon, 04 Sep 2023 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693835141; x=1694439941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dveQUEAvemW9I8YRw3cIPQPyAvdx+sH8Cofh5E8QoS0=;
        b=D1/Z9lTS9OuvW34CJQQpEQMik2n3973+aQ01EVjd3bMZxuoDwpZNbPwf3BKTil2qTj
         U2baCdZxer2wJfxYHNYh7B63GIiRsZEtxCPRaMhGBRoc6BwhYzhyC/kCfFlWl6aRcUJU
         3guh7E3k98pfsgmTUec809CoQEzB0sn0yqtBfeRtuf4jEtNg8oPTqvjIpNhnh07qU4T5
         J5bgDPtd9ChYpGqjjn/KMjjfhB4noizTE8a5FjuhDJVl0I24PkAHzORZ4qTENAfYoGOn
         chxsQWcw/X6WHqDju3ANGtQRybZd6a2CcvK5ydlbfcINvXH1AVEgg90EmO6PCSkNPK9n
         iX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693835141; x=1694439941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dveQUEAvemW9I8YRw3cIPQPyAvdx+sH8Cofh5E8QoS0=;
        b=kVHP+U+4fOznAXRaRGeA+/kH9glRecyYL3AX0zH9Q68MUw6WnPTgHEdHJz+be3murl
         fZQmjGwTPirDKXQ6Jg3oYciLR8D7yARXiRgmvCptSoF85GQvnmjXK1dAYlUimgjSZN8J
         PyH3uyeL9GFw+5l3G+Bbh316Ba4WQ84lNR7j9L84/TQkA7sRnYjS2xQ4LjKnS+k2I8xY
         94GCmcxKYpxn7pIEV5Ii9rkt/z6DGWSiEEmOK6RL0qfQC2lvw6RJ5TKgREWcp2m+d9Ld
         uAA2R1Aaf7L/8aRr2wdVvNAs/5FTeA8iwymv5+Pg6Zr1TmFZX9xmB7Z9/rfhxIl3QGiB
         s9KQ==
X-Gm-Message-State: AOJu0YycOVj+s40VlL6bG9Nlywqz7Hm3Rs+lIfgASmuD68/cB0t/jt+a
        gM19Mly1Q14o8Likue8WKnPtfNqnCRC5ck2X4bw=
X-Google-Smtp-Source: AGHT+IHOOndRquWTygdUg8VUT1+U+bUI+9aACnqPkr1Mx9rzkCKLBvoF4da8FZ6dK0a4xGlt3ySNEQ==
X-Received: by 2002:a17:906:3091:b0:99b:ed44:1a79 with SMTP id 17-20020a170906309100b0099bed441a79mr7246789ejv.3.1693835140691;
        Mon, 04 Sep 2023 06:45:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
        by smtp.gmail.com with ESMTPSA id h23-20020a1709063c1700b0099d45ed589csm6154590ejg.125.2023.09.04.06.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 06:45:40 -0700 (PDT)
Message-ID: <9fcd5396-e6c2-b5fa-6d6c-3e950bc15155@linaro.org>
Date:   Mon, 4 Sep 2023 15:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] hw/pci-bridge/cxl_upstream: Fix bandwidth entry base
 unit for SSLBIS
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>, linuxarm@huawei.com
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
 <20230904132806.6094-3-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904132806.6094-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 4/9/23 15:28, Jonathan Cameron wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> According to ACPI spec 6.5 5.2.28.4 System Locality Latency and Bandwidth
> Information Structure, if the "Entry Base Unit" is 1024 for BW and the
> matrix entry has the value of 100, the BW is 100 GB/s. So the
> entry_base_unit should be changed from 1000 to 1024 given the comment notes
> it's 16GB/s for .latency_bandwidth.
> 
> Fixes: 882877fc359d ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/pci-bridge/cxl_upstream.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

