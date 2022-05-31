Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398D4C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 31 May 2022 07:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiEaH0j (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 May 2022 03:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiEaH0h (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 May 2022 03:26:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2808592D09
        for <linux-cxl@vger.kernel.org>; Tue, 31 May 2022 00:26:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id rq11so24860002ejc.4
        for <linux-cxl@vger.kernel.org>; Tue, 31 May 2022 00:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IKS5gbVC5TKkwCxvfzNBNsteWO3XdewF6O03i9WkL2k=;
        b=VKgN+Vu5HV9ZfjKsG6MXuV0uc1Y7i++jFVjttD15/vblyI/xZR4oCks9oNuU7SHFM7
         wIaRr/OZvTn9XZo4kmXOYTyzqeDzIhtLQcjDV1ySO08+WV/moo5it0j/DuGg+UdDOAUx
         bp8DgfGuIBTw/L2YqwzzEMgulmhlK7SE/duZRCRha+oCgRAVQlOaW6IMZ5DSablH8WEy
         8sPXPoq6nkR8c+SqfPGcpl8l7dSa3wtqO6e2CbN/N5L/Wf55slwhHUPG7xlzm6XtluKa
         QZW8tt4qxI5jt46Wk8laXvbbGBxiq/sPd/goaHI2uaBfPjdjGI/+AK2CRMK0UNuIc5r3
         Hs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IKS5gbVC5TKkwCxvfzNBNsteWO3XdewF6O03i9WkL2k=;
        b=V++aHH7IizApdl6ESAsNWM/lQ+gc+38JMBVQCLhcbSz8l77/xCveo8iY0DV92nz+T8
         jMTSadDu1425ufsm+v1XeuTW1Il2TyR7+Suvgr0ztsx72Q9yh9OooriHUeNoNqcltBtf
         UMPsydoDXIGjhC7JZk5evNrQGbgnu+B+ol5jGdvXAUw2S6FeUhqFTp2DH2vtZsx453w0
         j3DzMCUygCboaohDw8hJNT8QG5AIAdye1aCUlubmM8s15xHrO7IptNzIBxgvgwCAk7t8
         F/M9p0yeQw7eHRG7A0Pmcd5J54zAyK3OQVwFOvjS/SxwQpTL22fYWkJyDyPmq9eTfWBk
         /ELA==
X-Gm-Message-State: AOAM532QhAcSc3kRzFQhi1kgt2pSxUIgyFbzI38R4r9QHNCUbNWdLe1J
        DnIenh6izovQg6ch6TVtONs=
X-Google-Smtp-Source: ABdhPJyI82V82+l/ssP/+iIgPP/zZ/m2yvYHRt5DKM+YO1MLiDdz1hIGSEuVlz+HftMFW6T0eRteDg==
X-Received: by 2002:a17:906:4784:b0:6ff:34ea:d824 with SMTP id cw4-20020a170906478400b006ff34ead824mr17564455ejc.526.1653981992512;
        Tue, 31 May 2022 00:26:32 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id m8-20020a056402430800b0042de29d8fc0sm701315edc.94.2022.05.31.00.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 00:26:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <cdb07cb9-4705-5b63-4f40-a44a6f735f38@redhat.com>
Date:   Tue, 31 May 2022 09:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/8] hw/cxl: Make the CXL fixed memory window setup a
 machine parameter.
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
 <20220530134514.31664-2-Jonathan.Cameron@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220530134514.31664-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 5/30/22 15:45, Jonathan Cameron via wrote:
> +    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow",
> +                        machine_get_cfmw, machine_set_cfmw,
> +                        NULL, state);
> +    object_property_set_description(obj, "cxl-fmw",
> +                                    "CXL Fixed Memory Window");

Perhaps "CML fixed memory windows (array)" or something like that?

Paolo
