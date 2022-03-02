Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D04C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Mar 2022 12:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbiCBMTL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239514AbiCBMTI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Mar 2022 07:19:08 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0815C26ADE
        for <linux-cxl@vger.kernel.org>; Wed,  2 Mar 2022 04:18:24 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk11so3374775ejb.2
        for <linux-cxl@vger.kernel.org>; Wed, 02 Mar 2022 04:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jgIaKdgCmX9XzFPul0xeQhCe+1+YoHtNENK9hgsvxN0=;
        b=ZF0xBuWPuetP7AW3J4ql19Tgg8XyE29giS8CtrvnkCRDwvrKA/XRxOWxx117QsjL3h
         zqINYUxOu30NOFHoeshGCHoaZfmmRO1+DbgmVQw9jym8Dv+HShOebZRZIw8xjj6Wlmd2
         lzpvpDHDPVOcnT41rp+/13gdfQMf27DEQFOGqJ7/Qz8j5Baato3IeWSDY9qM7kcUHdd1
         xrziaro7PYObqVwTvGOw0HrdH1vshzVMDo9Z03AQBXAz5xqHF7d/9mOvdS9guYlHh+s5
         I5cfd17oMSXlrUI0ttJnLIHbNar8TEFheHfl9Rah7GxgWuBcaEGg0EVAS6MD5lB4E/lD
         hZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jgIaKdgCmX9XzFPul0xeQhCe+1+YoHtNENK9hgsvxN0=;
        b=fgQ7OrHTxIQ9VOQaYWhaD21KHxtOFZpQs5UTEbS1NR9+yRP2JSbifL/9FOpdDKeq2j
         0hDou77IH8rbCtN+Dd24tanxcZUtRclrdd6Au3jFLECI+NnmLehdjuzS+oM6aXR3sFwx
         cCyMdzhDKs2rCbNK5aetAaTOQHLbBg4k5ilARk/u1m7FZGUbkGdMQ0DqJP733vSVudQZ
         qWmwKhMRvPE47HGfvIz7Stzr2BjugqGsuKSWe+rht9qrVmQjqqNzjLXeg8Kr32bj611p
         ymL3ZaRFcVEgwEm5qw2Ordj8UK2iHcY/BJGTJpQL2rUPlSbbHNuVr8ampEFifb1uAb3v
         eNCg==
X-Gm-Message-State: AOAM530J/SI/xzISWgpfcjjiPdJ8fcKXqnMW6Fa/YsDTOT+H0/HL89qr
        /0vdd2sSuYvqycqdKVYSmCYHtQ==
X-Google-Smtp-Source: ABdhPJyv9GHDfgeLqQuBcbRZZaoG7y1EDmH3HRMSg6KyY5wtgpeuCGh7yV2un9IYkC6B/nrkUqaA4A==
X-Received: by 2002:a17:907:9712:b0:6b7:98d6:6139 with SMTP id jg18-20020a170907971200b006b798d66139mr3095518ejc.498.1646223503432;
        Wed, 02 Mar 2022 04:18:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id i26-20020a17090671da00b006d9b2150a22sm669505ejk.146.2022.03.02.04.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:18:22 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id A6F591FFB7;
        Wed,  2 Mar 2022 12:18:21 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-29-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.9; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 28/43] acpi/cxl: Introduce CFMWS structures in CEDT
Date:   Wed, 02 Mar 2022 12:18:15 +0000
In-reply-to: <20220211120747.3074-29-Jonathan.Cameron@huawei.com>
Message-ID: <87bkyok0oi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> The CEDT CXL Fixed Window Memory Window Structures (CFMWs)
> define regions of the host phyiscal address map which
> (via an impdef means) are configured such that they have
> a particular interleave setup across one or more CXL Host Bridges.
>
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
