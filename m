Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C681EC8740
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Sep 2023 16:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjIGQAl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbjIGP7A (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 7 Sep 2023 11:59:00 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3A63C23
        for <linux-cxl@vger.kernel.org>; Thu,  7 Sep 2023 08:47:10 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so12447855e9.2
        for <linux-cxl@vger.kernel.org>; Thu, 07 Sep 2023 08:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101254; x=1694706054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5Zv2w57Pu5zvBv+RmRMWxTLLDD5033YVrG2FGo/z5Y=;
        b=C31ANkf44g7HcM9XJiIYsT424Q1/1fJZzTVeMM8NkrIXKlHqTm/LwlYblXclYcvU/e
         cBwv+It17PPC5iE2UKWkruKE35uBvoj5Jgb4MqQJoIfsJ9UkNoSzJLv79zJBklzxx8eh
         Jbt27oQeXNShFKVPDdi8pzrd2VlwEKtvLlBArLDJ2fCKqH+zDJP4YPTUmFgJgbYF7d6L
         oqI+rbcsiTLJc+CZ6WrIdUsmn98WI9S1rSFz6z7NAcAJGZWC/FCT5OQlfXscfO7d9EW6
         alJmK3vloUc6zIWQZvYdGKEoblRRjlb7PKt/mPYCtfG3ndEnKpfbLC0l0T57g83/4cOg
         zV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101254; x=1694706054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5Zv2w57Pu5zvBv+RmRMWxTLLDD5033YVrG2FGo/z5Y=;
        b=VXznBYVDF84LifjJ4NcDd289THo3uPrqH7C6EOFBPL5b6Boofnv2Wz/OTM5z5QauRq
         fgdQo5/A10ddbEyRXrO2n+XLAwApu91hd9Dbt3RJCW/aMNerEe0/dpWfOFUKGQq9V5lC
         qvl4wKjARZ6vTyB0VklVQcONCxutuiJqFemGUvvl/uy7v5COg6K4mKpvSbAfHsbs2vDg
         YH9Dns97Ldv5FYlFnpUTKLFhEJd1S28eAomhN0PvsuXi0JfnvYuS2TaUWy3XXDatymSq
         bwHfDH40aM4DcSILNZKV5MLJAT4pKn+/gqBOZ+LKE1AkL5COzzU7TNJbNaUzvliBOitH
         aLhA==
X-Gm-Message-State: AOJu0YxSsHPyIe6vIfvMjsKMkCt8Eg9f6NHQ1lF9tAbYVYAipX70FzOf
        /MIRyVLH4pUKk3VNwrVs8PsrsZQxym1Z7Z3BwMU=
X-Google-Smtp-Source: AGHT+IFiyeAxv+PcElS78SKV3hRLxkrNfqZ4f3aObhMItsMGt+ctJOtd8El6PUpyXS64y9sUPU6UFQ==
X-Received: by 2002:aa7:c485:0:b0:525:7f37:e87a with SMTP id m5-20020aa7c485000000b005257f37e87amr4585262edq.16.1694090006446;
        Thu, 07 Sep 2023 05:33:26 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr. [176.131.222.226])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7dccd000000b005256e0797acsm9717904edu.37.2023.09.07.05.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 05:33:26 -0700 (PDT)
Message-ID: <760a2e78-9e8e-8c98-4c58-3e2c560bdd44@linaro.org>
Date:   Thu, 7 Sep 2023 14:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/3] hw/cxl: Push cxl_decoder_count_enc() and
 cxl_decode_ig() into .c
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
 <20230907113543.19760-2-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907113543.19760-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 7/9/23 13:35, Jonathan Cameron wrote:
> There is no strong justification for keeping these in the header
> so push them down into the associated cxl-component-utils.c file.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/hw/cxl/cxl_component.h | 18 ++----------------
>   hw/cxl/cxl-component-utils.c   | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

