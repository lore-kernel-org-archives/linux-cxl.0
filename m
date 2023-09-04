Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B329BC83F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 13:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjIDNq6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbjIDNq5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 09:46:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28BDE1
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 06:46:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52e297c7c39so1355702a12.2
        for <linux-cxl@vger.kernel.org>; Mon, 04 Sep 2023 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693835199; x=1694439999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPvaJPFVBpM2rTDHekNU1+xDkQWhPcj+1om5P1ebX5U=;
        b=q8wlu49YxSBGSBHL40kSny+Mp8cFZ/0bEgaf8cX2prmxIxiIO1hzG31QrXY0g4cA/6
         9YCSLbKoPz0trFjguNOuerZK8egufuolq7wsOxWEKk8MqqP6+JoPs2zLUwYMw9Y/de8W
         YtdM2BDpxd/E544FrcrAL4y05fQUKCq1R87LD2fQl1bR5yc2gnsdAiBUIff0egmWg2Mf
         UXUyq2gPIsHg0jzh+mq5WSPasvtxHXHsc/OhnlppOxiUetVdm8h67OpJadScW6aGNMrx
         26hBDLd+Gd4wA7n2L+cOu5gPPLhHDqmcFXHB3P9aIEF6841z/R+ajbShFgA0HLSft81m
         /BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693835199; x=1694439999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPvaJPFVBpM2rTDHekNU1+xDkQWhPcj+1om5P1ebX5U=;
        b=Zo7gzvScW17wXY0m70AxkJj+xdOAioSdLBFa/C/3CgHCfszoPJbOkX/23OZscaQhsF
         xTdW++Tbxd7geKIqIQ7KDp5HCg8eY6gSI1YbSvZO4giapOV56MLmDZoW0dM6x5LJ04KK
         XGAlTrX9c+AdJvIigbCf+ogtUBndHH7hN4oU02VmEgvKdufC0bpCZ8FqXfq0PTCVjh+S
         iGTbgZTOiocYJKb2XwhslY+bAoQwBe2YTfn1aPZa+zAqdDnKXFnzPZV3fNkRIpBIyBlA
         Z/eaaF45k00ikiTaGUHDrcVN5eLF2/jw/tiS73IONFTGcKRpGRbOo4ip9tMigqstw7fl
         3rKQ==
X-Gm-Message-State: AOJu0YxBdR52RBkXgUX/UOenhlOTbMtzC0bDXkax6ffZ6gZXFcaCCATI
        nCjYc7Gh0cTKPhasxBg20wY6KQ==
X-Google-Smtp-Source: AGHT+IGPsJmFzFzg8M3jmQ4yBjnho2pweXGuDIIFXtx3fiLE1YUJh+QvDAfFY0GBivkkHqskkMDwgw==
X-Received: by 2002:a17:906:738c:b0:9a2:ecd:d962 with SMTP id f12-20020a170906738c00b009a20ecdd962mr7271120ejl.4.1693835199538;
        Mon, 04 Sep 2023 06:46:39 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
        by smtp.gmail.com with ESMTPSA id gj17-20020a170906e11100b0098921e1b064sm6195235ejb.181.2023.09.04.06.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 06:46:38 -0700 (PDT)
Message-ID: <6661927c-d054-5747-3ceb-c2c88fb01265@linaro.org>
Date:   Mon, 4 Sep 2023 15:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 4/4] docs/cxl: Change to lowercase as others
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>, linuxarm@huawei.com
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
 <20230904132806.6094-5-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904132806.6094-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 4/9/23 15:28, Jonathan Cameron wrote:
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
> 
> Using the same style as elsewhere for topology / topo
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Link: https://lore.kernel.org/r/20230519085802.2106900-2-lizhijian@cn.fujitsu.com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   docs/system/devices/cxl.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

