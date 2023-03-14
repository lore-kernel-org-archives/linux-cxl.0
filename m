Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048EDC6FD1C
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 10:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCNKW1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 06:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjCNKWJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 06:22:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D52D1E5CF
        for <linux-cxl@vger.kernel.org>; Tue, 14 Mar 2023 03:21:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso9744148wmo.0
        for <linux-cxl@vger.kernel.org>; Tue, 14 Mar 2023 03:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678789292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2k4n721sTHh4MVEmsnF9m20QGHqMqtblaWfyT3DVg0=;
        b=x0X06yWWHiVDc1/3ZshjoWRNjGQWT0JUe2pkW6AOGy0U1sX2OwLCgP6Mw66j3yodxf
         spUekOQumlBxU+XlShI3SDrXhpHWjHTu+cAOj3Fysv9ibHUDyBwkSjZOoFLc1dPnA1b/
         +v3iB2xJ3oJZgjddDMHvOG0r1pT/6kyiY+L0MStshPHghOAkK6KsTj+X8XomzJW/OV1d
         0vOVHcCJEOvRG6ql/AbrKVWX7H/Q0fK3l5vvmBIlF17th9g4/K7bMCNxDcn6gkmHHhe5
         be8Va+6AGd2Il/zScPG1RhnnW6Fb0nsCsOGBc/Zx7qUoxzUdf1+xmWIHb4BkqfMjZM9R
         2CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678789292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2k4n721sTHh4MVEmsnF9m20QGHqMqtblaWfyT3DVg0=;
        b=Xpin2hKMM7mG3U/IKpeVdG9dXSB9eyUjunoWKnW+xmQ4DVBOvO9V8eOBiK4Sc6J+qT
         Nt9XJo3+9dnBsE9noGekOqmx7nhfx2Du7FaWx2lOM7mueW+QoSpnmt2NX1dxazwbUsIG
         182cEi0Ko/zznxdukO6L2aHFO2awMz+1oar/aQvZlpHkVBqLvGFXadGo2YgQ+jB3vHb+
         sXjVm+NgSrCa3EQcP3rLI/f8zpyb99Gmzl7F9ZctDXVyjHx8kWtRl0XJvFrazElyeQUK
         zXEU7u94agmIxx0rpDusBe4pVIez8/xI1oyb150J4k7pBsO/icEr3iTmMYmVJLuGQRBB
         PYiw==
X-Gm-Message-State: AO0yUKXlGiQHNaglJPX2qKoydA+wwNeV+QJixmaAUBc4l/U0rmLRirqY
        n0oQA+KSfzmBqGgmSwyNCZxS7A==
X-Google-Smtp-Source: AK7set8cKGHlWctW/kYAnvIvBC8wPDZGPMsmYBHFNLJ2Od6lZHoHsmV6tlhnr8sOPrdqf+xbsxp2mw==
X-Received: by 2002:a05:600c:548a:b0:3df:e21f:d705 with SMTP id iv10-20020a05600c548a00b003dfe21fd705mr13647567wmb.28.1678789292634;
        Tue, 14 Mar 2023 03:21:32 -0700 (PDT)
Received: from [192.168.1.115] (233.red-88-29-167.dynamicip.rima-tde.net. [88.29.167.233])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c2cc600b003df5be8987esm2405223wmc.20.2023.03.14.03.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 03:21:32 -0700 (PDT)
Message-ID: <c8b5b1ad-62b2-7271-0852-6ca1ca4d93da@linaro.org>
Date:   Tue, 14 Mar 2023 11:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/2] tests/qtest/cxl-test: whitespace, line ending
 cleanup
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
References: <20230227163157.6621-1-Jonathan.Cameron@huawei.com>
 <20230227163157.6621-2-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230227163157.6621-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 27/2/23 17:31, Jonathan Cameron wrote:
> From: Gregory Price <gourry.memverge@gmail.com>
> 
> Defines are starting to exceed line length limits, align them for
> cleanliness before making modifications.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   tests/qtest/cxl-test.c | 84 +++++++++++++++++++++++-------------------
>   1 file changed, 46 insertions(+), 38 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

