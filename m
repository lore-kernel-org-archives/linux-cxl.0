Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41673CA0FF3
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344845AbjIEQX4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353995AbjIEJFD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 05:05:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E229BF
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 02:04:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so22682525e9.0
        for <linux-cxl@vger.kernel.org>; Tue, 05 Sep 2023 02:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693904698; x=1694509498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/rtkaclifMVwreTlgFTtSlHt/oHFewkv6B4xvpVoO8=;
        b=KwUMvyU3txxQ1atwtVghQ/DMz970HP7itF1T3WdXnsInJnrI4VO0lErioTEIjoQaz2
         q3fcdldKwoJT5Qq+g41bKCkjnuNpxFC53u1oYLxn2oaG/yCfPfmMsltyZls9pBuSjqUh
         tyz9Wlmjr3V2IOAEqoTnDBoyo1IRUWWIAnbEmlvMumQ37984sBEOq7nQUyBwd2ya3Nj9
         p/gXxi09XIEA1zahwxnk1p0o22RakRL826G+ZynpNdBcHHmB6EIqBgYxt9DZ0MumvrYk
         /vR90Seuf76AC9hYmt6nigalp5Wy3BDCo0Os7k1mILzAxd5gmX/wSKomgHjK8DkX/JfR
         4kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693904698; x=1694509498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/rtkaclifMVwreTlgFTtSlHt/oHFewkv6B4xvpVoO8=;
        b=cCvfUxPS/YoFiXBv92trLagkf5dUivJaxb5Gu9/yBulen3Ha+oxP31C2SJ4U/chJxd
         kUekKmGyVbBrdyNBlpKP/bIhQhn9pnUvW/kB61tfMJx9rU947aU12aLN7qiYULcIMKen
         /uh+Q6iiOkQ2WGXo216miCPqC3aL+F8GrsQxAnuLunaYeErnFVWmdX5Y0cdpNSv5p9u4
         B08nOFt13aSrBiV7OIz7KZxvdqSEu8wtjknSMOMJULvTBim56CMUJgYfef81e//8DOjp
         Us/a2I2RxGQsPd6ML2ApKDoibwnYHCwMRThwiK8R2m/Qf1DTo1mBoCJUJXdPIgto9PkV
         atfw==
X-Gm-Message-State: AOJu0Yz3aZr9rppk/zPk/xERxyOYej3fHTH2BHnmckMDk5xaHYl6gWzH
        fxwH6fFNxthLgE4Y2wKz47Xg/A==
X-Google-Smtp-Source: AGHT+IEt4fdGCm9gpoJs/bgzm6WL9WV5xkA/o6UgWAzxHdyvBXMGuXmE5ByfHHyS+bnDZETZxDYN6g==
X-Received: by 2002:a05:600c:19d2:b0:402:cc5c:c98 with SMTP id u18-20020a05600c19d200b00402cc5c0c98mr4321807wmq.13.1693904697924;
        Tue, 05 Sep 2023 02:04:57 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr. [176.184.47.79])
        by smtp.gmail.com with ESMTPSA id fa20-20020a05600c519400b00402d7105035sm946919wmb.26.2023.09.05.02.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 02:04:57 -0700 (PDT)
Message-ID: <6c7c4237-4052-cec7-d515-8ac6dc33ec1f@linaro.org>
Date:   Tue, 5 Sep 2023 11:04:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 0/5 v2] CXL: SK hynix Niagara MHSLD Device
Content-Language: en-US
To:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901012914.226527-1-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 1/9/23 03:29, Gregory Price wrote:
> v2:
> - 5 patch series, first 4 are pull-aheads that can be merged separately
> - cci: rebased on 8-30 branch from jic23, dropped cci patches
> - mailbox: dropped MHD commands, integrated into niagara (for now)
> - mailbox: refactor CCI defines to avoid redefinition in niagara
> - type3: cleanup duplicate typecasting
> - type3: expose ct3 functions so inheriting devices may access them
> - type3: add optional mhd validation function for memory access
> - niagara: refactor to make niagara inherit type3 and override behavior
> - niagara: refactor command definitions and types into header to make
>             understanding the device a bit easier for users
> - style and formatting
> 
> This patch set includes an emulation of the SK hynix Niagara MHSLD
> platform with custom CCI commands that allow for isolation of memory
> blocks between attached hosts.
> 
> This device allows hosts to request memory blocks directly from the device,
> rather than requiring full the DCD command set.  As a matter of simplicity,
> this is beneficial to for testing and applications of dynamic memory
> pooling on top of the 1.1 and 2.0 specification.
> 
> Note that these CCI commands are not servicable without a proper driver or
> the kernel allowing raw CXL commands to be passed through the mailbox
> driver, so users should enable `CONFIG_CXL_MEM_RAW_COMMANDS=y` on the
> kernel of their QEMU instance if they wish to test it
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> 
> Gregory Price (5):
>    cxl/mailbox: move mailbox effect definitions to a header
>    cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write functions
>    cxl/type3: Expose ct3 functions so that inheriters can call them
>    cxl/type3: add an optional mhd validation function for memory accesses
>    cxl/vendor: SK hynix Niagara Multi-Headed SLD Device

Being at commit 17780edd81 I can't apply this series:

Applying: cxl/mailbox: move mailbox effect definitions to a header
error: patch failed: hw/cxl/cxl-mailbox-utils.c:12
error: hw/cxl/cxl-mailbox-utils.c: patch does not apply
Patch failed at 0001 cxl/mailbox: move mailbox effect definitions to a 
header

On what is it based?

Thanks,

Phil.
