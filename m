Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60816C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Jun 2022 10:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiFXKmg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Jun 2022 06:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiFXKme (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Jun 2022 06:42:34 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBF67C862
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 03:42:32 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-317a66d62dfso20556747b3.7
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 03:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+Byo1b4X9Vbz/m7CyDm8kInKMKO0y+GBykwADZ8WmE=;
        b=TQ0l6TXsTnX4C3Z8K73saa/OV9zdzb7o1WStXBQDX6AadaryI4yw7JjhkrRJzqPNn6
         mtTSkllyAcQej8hsdq+9lvQUDDX/0W3HzZv9haS+SqlE+J9aDUVx7r3EB5VxtfvdGmxo
         ff9suaD1bYTOTTolUJg8suBUxodExgv0+BHwRuz6r+hJjIX0CZI/hHAN6PVN4EZYr3fr
         W8nkqODphPaiYsarIRIxS5w0asNpt0T2JzMws4Zzb56ayJzDrR8ASK2fKfNclbi9Nddy
         xuCKyve1c3NVQZs8mSDXx8HfzosVTzDzDWAiJlKqQWoRgN/EqGITmgPLijtXZeDNDW/F
         8A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+Byo1b4X9Vbz/m7CyDm8kInKMKO0y+GBykwADZ8WmE=;
        b=2ypDRGnfRdl2PkSOZL9w6cQn1vKmeW9xBhUAydL93qL3UPd4aMJSpey0P/jKQq5SSE
         m11OtuUZnk9fA8rNPb/K3HvxjovFPHxmOQiTL3+q5OwobQnSE0wQeLJyM5S5xocT30ay
         XHTiZzdC0+a9QdA4wlmM15Ux+2Bir6mRDXrDTdlrUTG2XoutE4zGL/CoYr6H6szBFUCc
         nNBoaiYTJVWDPiyYjXPLykS1MXhP1/RHeK2hwMCi7xIolXGbCPL9sNmJVYC9oGqyheC+
         LqGDdiPXddXehqeMSF83pgU78wFHG+RXSpSgYHFjEbQ0iQN1aABxTyNm4p1M5PyuZf9s
         jQCg==
X-Gm-Message-State: AJIora9K3P1kopQSUSeLpEIpnX9Ck6RQ1pXUm018A9IgCA9saAhjV4uz
        FwNiMfj1NAqIKMbkBBEAF6NDNvP4hoVwwm74L+ZwwQ==
X-Google-Smtp-Source: AGRyM1sq+/2VjBMF5dFg09mCn+s1Qdjq3iIBMrleMMhwNzQyYBgetjTSfEuoJKDinF7P8RioYadghPn+2sUqZUWqvaE=
X-Received: by 2002:a0d:ca0f:0:b0:317:a2cc:aa2 with SMTP id
 m15-20020a0dca0f000000b00317a2cc0aa2mr16667139ywd.347.1656067352203; Fri, 24
 Jun 2022 03:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220616141950.23374-1-Jonathan.Cameron@huawei.com> <20220616141950.23374-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20220616141950.23374-3-Jonathan.Cameron@huawei.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 24 Jun 2022 11:41:54 +0100
Message-ID: <CAFEAcA-rmDrMcq-s4X68dSSWwhwHcY=5m=20wFZSJ1qKm7gfjA@mail.gmail.com>
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
