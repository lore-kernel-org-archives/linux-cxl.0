Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C19EEB59A
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 06:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbjIMGif (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 02:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbjIMGie (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 02:38:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96811735
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 23:38:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so69801085e9.2
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694587109; x=1695191909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGQ97aX+bgFA0xWjQ+JfmzR9bqfL+Njc3b/0gGDUUjw=;
        b=hyUxbeao3Wx49EQ7UhsDcRYBqQEAPp8tafIF4GfsntGITGtnNHMkYtrkCbqjZtxeEQ
         RQ7/UdmK9CL2w4v3/hFM+n8KIXbrrOenDkNWtBf2Nvi6QQrYlkw5HqZt47Sq8yqNI96K
         WA8Maf27vEY+Nd9UFTaefm9hmKCi29DgDNcUXigDbyyXQiSiKGW3eCqOwHMJuqhW2FU8
         uUEUfRu5USgCo0YwZJl83rLGdm2qykLFR8cBH35Q43Nb+dfsLfA1I9fHZIMeYFHAAeKm
         bEIWXc0WjqYv8vFQsQz/IiQPm8k3mEeAQoomcfBZueq/fWM6DHHZgWz1uBROw4vYeEN1
         ic2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694587109; x=1695191909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGQ97aX+bgFA0xWjQ+JfmzR9bqfL+Njc3b/0gGDUUjw=;
        b=bvTjz+R7EQE0jy3s9q/aI4g4u0pxHAg3B9tfjE3uZzkALVdl0WZ2x6ftrN5ZLXr7S/
         s36kQggZSgQw2UqP3b5CkxYwY1bnVtkMV5FlMf4E2cOYg7jq/4rWaURYsu6sXQvA23Fi
         G2WNXEuetwvsqPd9tW7DKSy8nCnJzZUdJNeACs/s5yjWhETbk9W2tKGbo1/4+SnZDOZG
         eJZ4JzM+bXZ2SF8YeSnhHePldGpDqQSgLnlBJ1xRkf1qGZzXYW/c9ZKi2dhr8i0NVKpU
         c3NlVgzDRzUNqzE2/Mk6Zh2O3VXerkmH/J+hwddv/dB937jp+j+XZM7FZx8NrCjgyJnq
         ZWQQ==
X-Gm-Message-State: AOJu0YwGD5qDvalqiLZEej9jsjAPiKJBVePMJ2yRiWiuK0JbfdGUKO2l
        9/qYtxuL8F67zn24xgdfifG+mw==
X-Google-Smtp-Source: AGHT+IEkXmSCwcDGB7AySW/0ncrlk/A+2BaAXWod3bBj8V1V+Jya2ckFmUwR3FBxsw32aPdI4MjgPg==
X-Received: by 2002:a05:6000:8e:b0:317:1b08:b317 with SMTP id m14-20020a056000008e00b003171b08b317mr1224921wrx.6.1694587109180;
        Tue, 12 Sep 2023 23:38:29 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr. [176.131.211.241])
        by smtp.gmail.com with ESMTPSA id u24-20020adfa198000000b0031f8a59dbeasm11691443wru.62.2023.09.12.23.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 23:38:28 -0700 (PDT)
Message-ID: <30d1cae5-9a44-e9d5-2362-1a3b2ff69d10@linaro.org>
Date:   Wed, 13 Sep 2023 08:38:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] hw/cxl: Minor CXL emulation fixes and cleanup
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>, linuxarm@huawei.com,
        QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Cc'ing qemu-trivial@

On 4/9/23 15:28, Jonathan Cameron wrote:
> A small set gathering patches that have been posted and reviewed on list
> over the last few months. Looking to get these upstream before making
> any significant changes to the CXL emulation for this cycle.
> 
> More wide spread cleanup will follow later this cycle (reference
> updates to available spec and line length improvements).
> 
> Dave Jiang (1):
>    hw/pci-bridge/cxl_upstream: Fix bandwidth entry base unit for SSLBIS
> 
> Fan Ni (1):
>    hw/cxl/cxl_device: Replace magic number in CXLError definition
> 
> Li Zhijian (2):
>    hw/cxl: Fix CFMW config memory leak
>    docs/cxl: Change to lowercase as others
> 
>   docs/system/devices/cxl.rst  |  8 ++++----
>   include/hw/cxl/cxl_device.h  |  2 +-
>   hw/cxl/cxl-host.c            | 12 ++++++------
>   hw/pci-bridge/cxl_upstream.c |  2 +-
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 

