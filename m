Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE82C83F2C
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbjIEQYC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353970AbjIEI7X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 04:59:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E32BF
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 01:59:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so22775625e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 05 Sep 2023 01:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693904358; x=1694509158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFSdJDombvd+rd5pQzJJ2wZFkYPkFfldpsIghShkl+w=;
        b=CjLFfcUxx/ElxE8DKQCOTjy57bSPX+tKHuNmS4pdOSKiLy9RfGVytAEuo3sLg1IsKg
         mT7Ra1uu/37lzc7XhZ3daYB/X861maVmFwxjZfCnAd+ZDhs9dLTSYkTMy7SggTwss/Tl
         dv5021sBZzVpzrFgGurWEtbpSnvk6FPROUzEMOnFpm6QnDjQid3WLxUp6ocZESbEG2Zk
         M5jTcPA2ibA2QkQsv2PR2fXzvWU/KXYE42MSGbrCYnQlzw8yjUP1xpZrc5FWrAupalRb
         ucXBiNRQYWoXJcXUVecscpp1Ky08QLHLzd9xub4+e8oESV+BEtt4JBZ8NdYOkZ6Ew8yC
         s2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693904358; x=1694509158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFSdJDombvd+rd5pQzJJ2wZFkYPkFfldpsIghShkl+w=;
        b=dbM/ZNxoNV25xn0BF8je3vycf+3QRK85m+uUfcX6e867eXY70PQ2MFoOZxpGID8jZJ
         d1GZHanHtKEomSRB3YwLiXntDNrRFtQnlaw0b+hFTfQ7e2zmp7wUvEsQbi85avqB+Y2Q
         7lToqOtIp2pUf1VnKhXHsKnCtCuEFyLdJuOTl1cl41Y4FMv5jOLq1am09v6r2l0s58EX
         WMRh5uhHBo4KgEkoOl1FPcgXENIhiTSJT1kYQ7fsU5OtG7aSFRT1k5efxOCrzzQZ2kmN
         9LnBtHBdoyn6MjZVQOoDVkfv+GzU9LLG78cFHwWjCLHOuxFCgciqBiI5AMDvDadvLUuP
         93ZQ==
X-Gm-Message-State: AOJu0Yw3jc5FdmtiA8djCvCJAuHu9FY8jBPrwn93+F+zATi9+r85PvcZ
        5RsU3Ha0DEwxkOvT2eiYOoCkoA==
X-Google-Smtp-Source: AGHT+IGbh5g0fSLsIgi9AROhgesfTcuGvZBYhFTLHDeM+eRrinTmimdhA/+j0sfMjOMfzZYKqFMuzw==
X-Received: by 2002:a05:600c:2181:b0:401:d803:6242 with SMTP id e1-20020a05600c218100b00401d8036242mr9250334wme.27.1693904357927;
        Tue, 05 Sep 2023 01:59:17 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr. [176.184.47.79])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c00d300b003fe17901fcdsm19409968wmm.32.2023.09.05.01.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 01:59:17 -0700 (PDT)
Message-ID: <13f5859d-9da7-4862-ba1e-487e60098fe7@linaro.org>
Date:   Tue, 5 Sep 2023 10:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 3/5] cxl/type3: Expose ct3 functions so that inheriters
 can call them
Content-Language: en-US
To:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-4-gregory.price@memverge.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901012914.226527-4-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Gregory,

On 1/9/23 03:29, Gregory Price wrote:
> For devices built on top of ct3, we need the init, realize, and
> exit functions exposed to correctly start up and tear down.

You shouldn't need this. Your device class can inherit from
the CT3 base class by setting its .parent to TYPE_CXL_TYPE3:

static const TypeInfo my_cxl_types[] = {
     {
         .name           = TYPE_MY_CXL_DEVICE_X,
         .parent         = TYPE_CXL_TYPE3,
         .class_init     = dev_x_class_init,
     },
     {
         .name           = TYPE_MY_CXL_DEVICE_Y,
         .parent         = TYPE_CXL_TYPE3,
         .class_init     = dev_y_class_init,
     }
};

You can see some documentation about QOM here:
https://qemu-project.gitlab.io/qemu/devel/qom.html
But still you'll have to look at examples in the tree.

> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>   hw/mem/cxl_type3.c          | 8 ++++----
>   include/hw/cxl/cxl_device.h | 5 +++++
>   2 files changed, 9 insertions(+), 4 deletions(-)

