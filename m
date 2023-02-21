Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BD1C636D7
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 22:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjBUWGr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBUWGq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 17:06:46 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD732CEB
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 14:06:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o4so5949264wrs.4
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 14:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QswolMF7JwIsaKgLxTsm84bIyCbB4xAcx+Fy7sgre/U=;
        b=kFrQRYagxLqIVhlzqppxkUSOe1RcH6sNBTHoAnykrg/QrenYPIW+Xbi634K1G5Offl
         H/KN7QjHbcAwX/zodlYzAdCPFq9+g93/wMyNFOPPqPB+8z/9gpmSBcQjlgdoI63j6FKu
         we7hMmeeCyTXkorkn1gO+3Hqs/0sr29TO/YkuM1zYcMSoKcSI6gWOrBzLW/BFcA0ArpX
         k0x4Z1TallWOtsdX812yZUncrla0zphfJ+WsgoJGOrl6rTXWaXU3HTrOVTuupGBc+jbP
         XDjemydf+jO6+RAW5ESFaB269YQBsLx9SQo6Uid26MWQFukxKxh6eXYzz/rM7y1m3x0n
         ZQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QswolMF7JwIsaKgLxTsm84bIyCbB4xAcx+Fy7sgre/U=;
        b=ZGON6nmrsy2ioYVU2DilBibTjN/14m8iBHjNK15FfM1NugTn9tudd2nUavpwnK4bkK
         uw+k7hrIHAwKQSk9Jz4gmJbmvrdLh27pkkiE6a4LzqG48yrLAlZvWFpuo2cQKor6tcnL
         VW0dgGzzw9GMa2hb8BtYKrKAm01U+lZC19lkyokTPZYYyo/Ivr+asTyR764QpjfW15Mh
         t7sHmSS5av2mDotyB0irV6bLyK1bpF41+mwKaRbeuGEuN2g1yK/Shb8QfU4wUTigV+A5
         jIzz+M4OvI5VhxugJLHPjMaAjWIpnz/haRVv6/uYdsVKAwCyzWnYhAsJ3kYyABgrjNAW
         mBDA==
X-Gm-Message-State: AO0yUKX+fSQs0JHBy0trAzIrVFY1Ku217G9FtRBS5teGnGMZHzb9VU//
        DKscH8s1OPwrT0h6/Krg075p1S8n+d73Lvm4
X-Google-Smtp-Source: AK7set817qXFh60NlBP/3akgNNtrjagi01bbBSMi2AzCOukBnE3OfBRPHmbIaWCVcSldsMETUYYBIA==
X-Received: by 2002:adf:fdce:0:b0:2c5:5ff8:6b01 with SMTP id i14-20020adffdce000000b002c55ff86b01mr6495017wrs.1.1677017195790;
        Tue, 21 Feb 2023 14:06:35 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600001cd00b002c6d0462163sm4357405wrx.100.2023.02.21.14.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 14:06:35 -0800 (PST)
Message-ID: <2074f332-8f6e-95f1-6860-ba5ac2df40d0@linaro.org>
Date:   Tue, 21 Feb 2023 23:06:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v5 6/8] hw/cxl: Fix endian issues in CXL RAS capability
 defaults / masks
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
 <20230221152145.9736-7-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230221152145.9736-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21/2/23 16:21, Jonathan Cameron wrote:
> As these are about to be modified, fix the endian handle for
> this set of registers rather than making it worse.
> 
> Note that CXL is currently only supported in QEMU on
> x86 (arm64 patches out of tree) so we aren't going to yet hit
> an problems with big endian. However it is good to avoid making
> things worse for that support in the future.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   hw/cxl/cxl-component-utils.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

