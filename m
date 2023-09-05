Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD40ACA0FF8
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245588AbjIEQYI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353953AbjIEIub (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 04:50:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE73B4
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 01:50:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so21134165e9.0
        for <linux-cxl@vger.kernel.org>; Tue, 05 Sep 2023 01:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693903824; x=1694508624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUEikI+8UdqOc2VGNOxBHLnl97oOfIXpCxawdnlEDMo=;
        b=l+8p2NNrFd8RJHBt6TLh0x+ek1UMVqB3vlzYzDVgaeyAYQVd0j7lah9ftTVH3G0p3g
         ZkGCGHa6UAYwRd4+l45sS0LQ1uDITkWA7PQ5lw/Ru1lQOKAKVZImWPvjN8Qw7UMcsw+S
         WjSsSYUrZGA4vF0Zf/cyvU9rMIJ/7U21AscqDn947624sfXrBrY7Bo8M92UTCV5TAv6b
         tkeqY3WK6RPlVW7qW1Xd3VxWGZuTq4ODMugS/M0knbZNb59kXV8Rbo10mD0kLR2/dA9t
         UidnN67KT5H/7r97gBi3tXAaDjm/SJzi2bObzwcMk2F0+Hnb3/UgwHL7CMwUeYeHGaLT
         QBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693903824; x=1694508624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUEikI+8UdqOc2VGNOxBHLnl97oOfIXpCxawdnlEDMo=;
        b=WL3W0oq8ihIJ/7MngeR6NMYeL/WP2AibTOLWsrvMutF0RBa9gTLqsi7qgAMHEVpTDi
         l10Ama/uDiHNgckuvYv8eG0j6g2GgSvjdwisI1AgRVQ0r67Xywoq2STue8+hO9V3wD4l
         /dpYGeUAT3KFS32aFyeUod1hyIrJ+85djoU0CE9f82t7su84//THX9YMN7uY2YW07ZDs
         MrN9gui448lCYaZkcy/9GW5S7mJE9dKdiyo9O9UBwljE/Wu0SI9xSMhBd4EmG6WkPAhd
         AXK3M8aP7CncRPEq3UUnhJr9DRx5ltMW2S/1onCGfPiMpH2WLg4boyrZwudKWKamrFsF
         lccw==
X-Gm-Message-State: AOJu0Yxh88TcKnO7gtvedBFgz9WDF9bxcCl9KRDx+x4RrMrBaJSTVpSF
        8G04pUCvWt8f39tsq8IpiONwfw==
X-Google-Smtp-Source: AGHT+IF515yTQ3QeVgzlMYcGEwnuspTWSQLI57f4UYmKfRt8JV1Og5XzZHHbXtor8Un5dILqoPHJBg==
X-Received: by 2002:a05:600c:2283:b0:401:b53e:6c57 with SMTP id 3-20020a05600c228300b00401b53e6c57mr9928368wmf.9.1693903824586;
        Tue, 05 Sep 2023 01:50:24 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr. [176.184.47.79])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c365500b003fed7fa6c00sm19490210wmq.7.2023.09.05.01.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 01:50:24 -0700 (PDT)
Message-ID: <da23f1ce-ce6d-4634-5340-11972a1ecc79@linaro.org>
Date:   Tue, 5 Sep 2023 10:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/5] cxl/mailbox: move mailbox effect definitions to a
 header
Content-Language: en-US
To:     Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        junhee.ryu@sk.com, kwangjin.ko@sk.com,
        Gregory Price <gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-2-gregory.price@memverge.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901012914.226527-2-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 1/9/23 03:29, Gregory Price wrote:
> Preparation for allowing devices to define their own CCI commands
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c   | 35 +++++++++++++++++++----------------
>   include/hw/cxl/cxl_mailbox.h | 18 ++++++++++++++++++
>   2 files changed, 37 insertions(+), 16 deletions(-)
>   create mode 100644 include/hw/cxl/cxl_mailbox.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

