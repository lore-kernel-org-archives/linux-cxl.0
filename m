Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C54C71153
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 13:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjIDNq0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjIDNqY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 09:46:24 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A7CD7
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 06:46:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5007616b756so2501149e87.3
        for <linux-cxl@vger.kernel.org>; Mon, 04 Sep 2023 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693835178; x=1694439978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1/9yHxhR/RjzLVaCkZST93HX1zcDr7VO983zyArYbY=;
        b=D7WDbXo9etkqEOKkBIRWOnm7NRu2eu/a1DqmbtoSWYN1G/4q3N2/5NbuYedSuaL8w7
         dB6EqTeuiSiSNbJcAIzgn4utLWq0x0U9y5TRkhgELmKK/yKwSia1NYldzzPfEA8eHtOz
         8I7aSi7fBC1g6GXaOAGYyQksD/phtxqO950mxlfyWZFuprhWj/BK8zI2rL3V1svsGD7r
         ScbusWuCjuh0i+La4MnHEkscUXtpUZ4WIibx3rXvUnes3d0aAzCv1QBR7p+g8T1fL52N
         OhhUq7Lx8OloxKPh7D6LwkR9sLvA1lRENAFykYTv5y2g4BLBgpGI5Y0hXI6yLx3tUOkW
         YMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693835178; x=1694439978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1/9yHxhR/RjzLVaCkZST93HX1zcDr7VO983zyArYbY=;
        b=OOOM3fFQ0e7ncIEQtNYWqj1z6BwfgE2GlbBXXmQ0AxIuVWduaLfAJl3KkbjQ7ejSf0
         BC4tpLhOLER76zdsOfVAlfnLUeXAhRdO/C4etxNGBCB/dD1dhc73VZIYDdzaYGOcXyih
         lPUGb8r82d6NrmsOjJZMbo+EJNc4C1aSAq8gLaFfFFVapbIUZe6Xhqer1k8Cf/uJcqLJ
         RU0LHKxttdPrNZulmZl+uQwOPEq4JgEgU1gedOo+Li9rL3RC57IQnVBHsZ/zNVbGal8v
         PZOqyVEqERwPTZVbUJcLOVxP2jWO8PJazlR35HieeqqTIlDEau7aOSuXBPMT99fsYw2q
         FV5Q==
X-Gm-Message-State: AOJu0Yz566sgGA4WtrldlX2MSr4Is7rZjcFtrcaWXR909KzJUiR3ee69
        wWZBKLbTV5EKzfbP8VBtuxBytg==
X-Google-Smtp-Source: AGHT+IEx/ADFu+ggbqe0qHOBB/D30C3Xm43xVFRvIBtxSoRHK5wBGxhHaJnG0FU2g6UE0V30v++HMw==
X-Received: by 2002:a05:6512:b8e:b0:4fe:3e89:fcb2 with SMTP id b14-20020a0565120b8e00b004fe3e89fcb2mr8266245lfv.34.1693835177794;
        Mon, 04 Sep 2023 06:46:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
        by smtp.gmail.com with ESMTPSA id t3-20020aa7d4c3000000b0051bed21a635sm5818208edr.74.2023.09.04.06.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 06:46:17 -0700 (PDT)
Message-ID: <b4c9daf6-e262-18b7-b100-5e904fd0758b@linaro.org>
Date:   Mon, 4 Sep 2023 15:46:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 3/4] hw/cxl/cxl_device: Replace magic number in CXLError
 definition
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>, linuxarm@huawei.com
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
 <20230904132806.6094-4-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904132806.6094-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 4/9/23 15:28, Jonathan Cameron wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Replace the magic number 32 with CXL_RAS_ERR_HEADER_NUM for better code
> readability and maintainability.

Thanks :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/hw/cxl/cxl_device.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

