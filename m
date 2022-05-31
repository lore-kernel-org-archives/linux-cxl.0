Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344B0C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 31 May 2022 07:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241866AbiEaH0l (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 May 2022 03:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiEaH0k (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 May 2022 03:26:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC95CD3
        for <linux-cxl@vger.kernel.org>; Tue, 31 May 2022 00:26:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er5so16285370edb.12
        for <linux-cxl@vger.kernel.org>; Tue, 31 May 2022 00:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZXRAOzMB63EZbV3P+p/zpTU+Aduy0jpZ/23fcsJpOvw=;
        b=ZBwygGefo/NBfCQjAClkRP/6t0WpGmvzZmTeffqDj5FLd0Nb3BMk2N/xnwff4hqcd5
         h1wEJGi4dWYLQ8qEl2ST3UmjZvmMw4yWqOnnr7whcJQFZbME/9a+l9VcNPjXH//2p720
         +r55Gu1exO1R5bLeYYGbeHSh4rokIbvr9rbhrHoJPIFe55VWYY6e68GYrW3qDbApKkmi
         SLa94V6oZPnKmBAiNDmGncriPObzPaWChPy8HuqEhmuSVuzFxYwu2Er6vMuZIKvG2hks
         Vj9sF+sQl/JdbcyakQMF9T6xzCCEGW39uCOl73sgdaGQETbWaq22Jo+w54z2XTRpPdBJ
         vxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZXRAOzMB63EZbV3P+p/zpTU+Aduy0jpZ/23fcsJpOvw=;
        b=mMXBjDLrxJ5PwfNuZA3tQm6rpDKQtQ8CMeGkI/nnf4uSoay6GyzmYKrr4dllWtquDQ
         j/OX3FlDus4y9MqgRJNp+y2sLtsFIVDxNPV4uid2FPkiBLPo7u9LCXpxQpADe6bM+Ua5
         fCIGFBw2Hb7BPwpN8YABkYkevl58w6XiuWX4Qe5FdDhLn9enkahMpjSV42bDtKIgvKrg
         CHyFVZEoPwLQOagAD3qsbPTE4Z8JR0EqUstDsYtDHDjfr20LEQwLRlSKqzwIdLZ9QKb7
         pjAiet8cOOJFche6PPhuvpXx0Twj8QcQLYteNfRY8loSqbSy9TXW3bdfECPBzUVnujP2
         S2Ew==
X-Gm-Message-State: AOAM532rnBRakXUle7giuAzxQ8Ki7nk6lmALxGUuVA+Lt8Gv1hcOORgc
        1IVSJwytxxhS5JYx5jgJ7ZQ=
X-Google-Smtp-Source: ABdhPJwFNfDSt6waLF6OlQpTR0pmmbXlShTCJ8ffV43e4b3zQzi572ShONEYA9n6A9fqFD7gBFLG2Q==
X-Received: by 2002:a05:6402:27c9:b0:42a:d367:fdb9 with SMTP id c9-20020a05640227c900b0042ad367fdb9mr63313915ede.47.1653981996664;
        Tue, 31 May 2022 00:26:36 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id sb3-20020a170906edc300b006ff19354f9fsm4655389ejb.215.2022.05.31.00.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 00:26:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <8878d03f-0576-94e5-5e4d-7133baf61372@redhat.com>
Date:   Tue, 31 May 2022 09:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 5/8] pci/pci_expander_bridge: For CXL HB delay the HB
 register memory region setup.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Cc:     linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        alex.bennee@linaro.org, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
References: <20220530134514.31664-1-Jonathan.Cameron@huawei.com>
 <20220530134514.31664-6-Jonathan.Cameron@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220530134514.31664-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 5/30/22 15:45, Jonathan Cameron via wrote:
> +    /* Walk the pci busses looking for pxb busses to hook up */
> +    if (bus) {
> +        QLIST_FOREACH(bus, &bus->child, sibling) {
> +            if (!pci_bus_is_root(bus)) {
> +                continue;
> +            }
> +            if (pci_bus_is_cxl(bus)) {
> +                if (!ms->cxl_devices_state->is_enabled) {
> +                    error_report("CXL host bridges present, but cxl=off");
> +                    exit(EXIT_FAILURE);
> +                }
> +                pxb_cxl_hook_up_registers(ms->cxl_devices_state, bus, &error_fatal);
> +            }
> +        }
> +    }

Perhaps this loop can be moved to a separate function in cxl_host.h?

Otherwise looks great, thank you very much for the quick reply!

Paolo

>       if (ms->cxl_devices_state) {
>           cxl_fmws_link_targets(ms->cxl_devices_state, &error_fatal);
>       }

