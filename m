Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E9BE7D0A9
	for <linux-cxl@archiver.kernel.org>; Thu, 21 Sep 2023 20:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjIUUPs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjIUUPh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 21 Sep 2023 16:15:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C13D207C
        for <linux-cxl@vger.kernel.org>; Thu, 21 Sep 2023 11:22:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3200bc30666so1215233f8f.2
        for <linux-cxl@vger.kernel.org>; Thu, 21 Sep 2023 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695320543; x=1695925343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RUltoTfDjrQftN2//7LR1fl2JSswr2zk7qtR0CySFE=;
        b=CQ/NfEq9XCO0l9jIR1rwpAYqVL7CzL6UwZfdsNYHrlpJsjzMyhL58GOJf7a9kN7tUd
         mRK0TKsi6FPQnh9eQBXpsUH8Hx3RmEN3pw8Wgk0KIqjvH64tyUwAzQ16zU6E1iiKBhZh
         nP/PfL1L7AWNLv0Ldyi90L37MPcdVEDuozmwroNuljajniB3qXfQQ5SbfI0GAvka1HhV
         pSUY9CQojFrx0a7JecL8TCImmueMtjmNBHO8BtppWZ2xvmpoOBYti7x8py3Uzt20aZyG
         lsVFI/YZZxZkT3ou/HSvlUW9PDg2Q6c15Yk8DhG0q5qfKjHqotnVvA/XYsHsKOmypZ7x
         cn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320543; x=1695925343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RUltoTfDjrQftN2//7LR1fl2JSswr2zk7qtR0CySFE=;
        b=FDogZnmGICr3gCfoTt42nvDO2/3m6hSJJl13zkf9AuWDNjlamnUZkMs7S4tDB3ONT8
         oKllsm39XF1H1B9CmcodI/bdGCdYIrZJJOVwq1Hm5AsO8rOu8bEvoyHDT7WR5bRQ9G3Q
         ACCY/F46NYvHbsdhd5yOA5onaPLY9pLRmAsQnFViAKJgrruSDkLaH/YDGVfnTsEk/Aha
         AvTpvPBh+GyXC+AZD62QKrRXJEr57hDMVaZkQCortqbkCxan1jBreerwoiSJrRvU2Xkg
         88RxBpxELxAa9QBfNo2ABVjltMoqo0VIVGN5KCMSm1Oin8pri10/s0GNutHSmIA9eLUh
         1cBQ==
X-Gm-Message-State: AOJu0YwmBoajL/m5acvOPYr1j40/bpHcBmS9MAH9Glb0Deeyp0uV9vdo
        AZGR8JitdIbhxFHaxTEGzppcBXLYCtTGnTi3J1Q=
X-Google-Smtp-Source: AGHT+IH59wn5uEzST6n5V9ZIofZNYKYQg1mEUsPdRcxlEeLrC/mYKHD8sj4Kr5yZng4CBFyG8qFeWQ==
X-Received: by 2002:aa7:c786:0:b0:52f:a162:f4c4 with SMTP id n6-20020aa7c786000000b0052fa162f4c4mr4041155eds.18.1695281922944;
        Thu, 21 Sep 2023 00:38:42 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7db4c000000b005312b68cb37sm443798edt.28.2023.09.21.00.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:38:42 -0700 (PDT)
Message-ID: <3f9ebfe7-47f8-4aaf-d241-0d6576993bd4@linaro.org>
Date:   Thu, 21 Sep 2023 09:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] cxl/vendor: update niagara to only build on linux, add
 KConfig options
Content-Language: en-US
To:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
References: <20230920155020.550112-1-gregory.price@memverge.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230920155020.550112-1-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Gregory,

On 20/9/23 17:50, Gregory Price wrote:
> Niagara uses <sys/shm.h> which presently limits its compatibility to
> linux hosts.  Change build to only build it on linux.
> 
> Add Kconfig file for skhynix directory, and make niagara depend on
> CXL_MEM_DEVICE.  Add an explicit flag for niagara.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>   hw/cxl/Kconfig                    | 2 ++
>   hw/cxl/vendor/Kconfig             | 1 +
>   hw/cxl/vendor/skhynix/Kconfig     | 4 ++++
>   hw/cxl/vendor/skhynix/meson.build | 4 +++-
>   4 files changed, 10 insertions(+), 1 deletion(-)
>   create mode 100644 hw/cxl/vendor/Kconfig
>   create mode 100644 hw/cxl/vendor/skhynix/Kconfig


> diff --git a/hw/cxl/vendor/skhynix/Kconfig b/hw/cxl/vendor/skhynix/Kconfig
> new file mode 100644
> index 0000000000..382fa0cd6c
> --- /dev/null
> +++ b/hw/cxl/vendor/skhynix/Kconfig
> @@ -0,0 +1,4 @@
> +config CXL_SKHYNIX_NIAGARA
> +    bool
> +    depends on CXL_MEM_DEVICE

You want:

        depends on CXL_MEM_DEVICE && LINUX

> +    default y if CXL_VENDOR
> diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
> index 4e57db65f1..6f194aa517 100644
> --- a/hw/cxl/vendor/skhynix/meson.build
> +++ b/hw/cxl/vendor/skhynix/meson.build
> @@ -1 +1,3 @@
> -system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
> +if targetos == 'linux'

(Then this check is not necessary).

> +    system_ss.add(when: 'CONFIG_CXL_SKHYNIX_NIAGARA', if_true: files('skhynix_niagara.c',))
> +endif

