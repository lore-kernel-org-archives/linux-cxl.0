Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B19CC433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Mar 2022 18:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiCASBi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiCASBh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Mar 2022 13:01:37 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B073FBF6
        for <linux-cxl@vger.kernel.org>; Tue,  1 Mar 2022 10:00:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ay10so3943237wrb.6
        for <linux-cxl@vger.kernel.org>; Tue, 01 Mar 2022 10:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dII4/E7nT8P0EHlPIb8FQ4IezjgVFuFEwukcVtjA6gw=;
        b=x02if5M8ph4V/Ye0HcJLXFjKVsOMhVK/xsNd6L+CIjjtIUbNzggg3guSafQ3P0WKeI
         ac2z3PsTIxV47TNh7fI70EOz5HYeuEstOQYuN9Khur69xHMykOQTMrTHV6FRJwM0tCM4
         8m+cx1t4BCVNGwtgXiCEfkB/C2/rCpJ2r5bXTbt9EOHdVZSObhW/12MJACMB72DvZ2DU
         iOFlK1sFiIbmyVsTx+YL36dJbyT47QurQ3rhgxP35RsgT8SD1K5dLe83TAcfB3Hkin+h
         ts7dOncwaLDFWIrOiJqIKJYSzB3AL934u8LWveU2KEi8T0d7OFnGMjcLSUSjztAvusj/
         /5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dII4/E7nT8P0EHlPIb8FQ4IezjgVFuFEwukcVtjA6gw=;
        b=MNAPJ/IQkIVoJ9fZE884Vm0bfyPOHb3zQR8/AMZGL11/Mug3TPnB+ni/SIpvos6cYQ
         67lLbKAR5DY0sQo7jaeYYGjwYw/E767cUEdcxLJL/VGDqTmTd819z7uj2y2LzCX1NYA8
         sFw077ilQG5uYnw3zdBobuQe5oOeICFiiWQ3s2P1796Qf66OK3X3IzWnugh4GhQzLWor
         c8MUnOiuX3fskg0UcYKg/XYt75uz7xwrgfD38oXuCRE6vwLMVZmLytCQMOj8c3Ku+Uto
         OxrN7bLzoyQRrDOsL5o+k9P0h7D9NmlVy1puvm78FPGpQfbib4RF+q/QKGM7wGLMQhDs
         u41A==
X-Gm-Message-State: AOAM532r6L3kW0XpJI85V9FbawaKVnKJJ2TCnSsBu4DZAvbiRVJr3ycB
        KaIEWE2zkNRpnuBlZfEHsG+/OQWN3o9MQA==
X-Google-Smtp-Source: ABdhPJxbL1lxCgT4MIg2AZnqHNc1Mpzr5bY+iBVQB0cQCt+dziY8QNLfWnBx0vz4QL6Mtfs4smBWoA==
X-Received: by 2002:adf:c44d:0:b0:1ea:99b6:2c2a with SMTP id a13-20020adfc44d000000b001ea99b62c2amr20725054wrg.716.1646157654765;
        Tue, 01 Mar 2022 10:00:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm15147575wrg.62.2022.03.01.10.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:00:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id F21CC1FFB7;
        Tue,  1 Mar 2022 18:00:52 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-16-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 15/43] qtest/cxl: Introduce initial test for pxb-cxl
 only.
Date:   Tue, 01 Mar 2022 18:00:44 +0000
In-reply-to: <20220211120747.3074-16-Jonathan.Cameron@huawei.com>
Message-ID: <87pmn5lfhn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> Initial test with just pxb-cxl.  Other tests will be added
> alongside functionality.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
