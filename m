Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDA7C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Jun 2022 16:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiFXQNG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiFXQNF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Jun 2022 12:13:05 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7392012757
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 09:13:03 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31780ad7535so29329107b3.8
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iC0gjzLo/+NeCxUooWDkYLGFZYMI378klxjabIannsQ=;
        b=K8sEoSyBYqMDhct1wWQSdQ7WMnXZvT+3aFa9K5bLJJJzPfyK1oqKmuMAF0KxAD45t2
         O3uTzQY6YSrgmvwB1scDkKuLCydIySEOGHkxd9qqL30Wnp7c4tFftfi6ZlSzGt+rt2Bi
         RToOHE7mMRz232936in3xBirb7NNkRR44HLKKq/sYcbvYwdZisSQCsERJop5tHw/Sjxp
         ziS25MryBgzJLNJ7HyFd4DMCJGUUcdPmurmvKU61wCC7ukkgRGfki/VtzXn9UCHyrquf
         N9BJpNqBl4Ngd8jenkFlIJS1pw4vWQ7dlnJh74LYH9PTR5L9usuZXmMKqCYX/Q6ZKisP
         oM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iC0gjzLo/+NeCxUooWDkYLGFZYMI378klxjabIannsQ=;
        b=JaGPt9yAIwUyzHxNLWqGxpeejeVnnOqGaYyfnJcZihOtihXJfqvQr/gGnsWElBtuTN
         wU9Irpoe0y446NHcKQp3OeQuNnVpHcorV/2jd6DvpPyzUY7+LOZuvGJPKdp0HoLOTX1+
         7Quw7ArtzENbkD09Jy9c6S2hzMo9ZuAr6Fx6zi9gn7DKmnUEGzHfQwCwfKFRlCgAnFe2
         I3/46srJIo75ZTMn2loqxLWCSqoHr23ZtrM6Z/6hgGAfK32kpc0QUcVqjA76/XQQARmu
         5EYCxoILFhIng5yqEPpUPgkK+zHR7XbgRCZPUGL2Glf7atO50MMIUwucqsx/ie35rXc7
         osKQ==
X-Gm-Message-State: AJIora97bA+GqEb5DzjeYBv39Giy9r0kcmf5KkXrzGcfd/GI14qs50tD
        VHnb79USN+txBGJDQKLt7L65oYtdY2Bdw63HuSBkew==
X-Google-Smtp-Source: AGRyM1uW1xfzgnRrf8c/H6yT0nn/HC62aGIxuPAVkf5Cn0RTTHUzwThcy5suDJhylW/v8KYTIsR93ohlCnSQmFR2Z3w=
X-Received: by 2002:a81:8486:0:b0:317:a4af:4e0a with SMTP id
 u128-20020a818486000000b00317a4af4e0amr17919466ywf.455.1656087182563; Fri, 24
 Jun 2022 09:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220616141950.23374-1-Jonathan.Cameron@huawei.com> <20220616141950.23374-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20220616141950.23374-3-Jonathan.Cameron@huawei.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 24 Jun 2022 17:12:25 +0100
Message-ID: <CAFEAcA_tck3fG67qO=4QiTHY2ST3jvy7-w156XkMKMv38-aN9g@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] qtest/cxl: Add aarch64 virt test for CXL
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, alex.bennee@linaro.org, qemu-arm@nongnu.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 16 Jun 2022 at 15:20, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Add a single complex case for aarch64 virt machine.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  tests/qtest/cxl-test.c  | 48 +++++++++++++++++++++++++++++++++--------
>  tests/qtest/meson.build |  1 +
>  2 files changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index 2133e973f4..1015d0e7c2 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -17,6 +17,11 @@
>                        "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
>                        "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
>
> +#define QEMU_VIRT_2PXB_CMD "-machine virt,cxl=on "                      \
> +                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
> +                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "  \
> +                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> +

If CXL requires booting via UEFI, what does this test case do?
It doesn't seem to be passing in a BIOS image.

thanks
-- PMM
