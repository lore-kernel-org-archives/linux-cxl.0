Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A63FC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Jun 2022 12:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiFXM5M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Jun 2022 08:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiFXM5L (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Jun 2022 08:57:11 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03F04FC6A
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 05:57:10 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id p7so2952095ybm.7
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiA0YGlHhMKy/ne0Mh3r8zXDFLkjCNSQ537FSF96/24=;
        b=LndkKm2MAWPB3fwQ4CrnfzqRxS5hZUiKSw6JB316osM2WjtfhNcO0ZXODAXlPjFbbC
         O3EswrgZMTZBSLV7VYeLgj6r3yzeSPg9Akk6r5WaK21VhfXgfkmGSxmL4Y1Qo8kD59et
         JYvckztr7r5Fa70QOXq003etN8q3ZjQ3nZ8zwymcfg8SBroqtUiPVPA9DYC24sQeMPVA
         bvMoLrP2hj8clExquFlniSO5VqvOkkQylsjqZ83FHiZB/K8TLV2GdvYApnF9XKv4Bob+
         zzQnLOt90NlCeBqNQVGsXS6GyZQyf/Pc6EnMdIYzXPWXa3CIFB8YBuxoez9sGMIDDWM5
         9mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiA0YGlHhMKy/ne0Mh3r8zXDFLkjCNSQ537FSF96/24=;
        b=0JMKpXxRXMnc1A7BQzKMnhJk6/2I2OKpbZ0XZ+6QucU4W2r/I1sZWUvQKzKaLcyPJL
         S7RY1EYzrofZ7CpEkTBusT/y6QP4qyqYXBD8ARlG2qSkh/tDNhavB18WUdYsHdMcCBC9
         1vgkDNGDhXVvvPIAs6bzoeY2RpHoRMKPZ5sn/6Tg9VgaVjD/SfprRk8Mq666scVp2MR5
         T1xDSTdys5069X+m8xBywSbJLRH29Lvv/jj/UhVtJE9vClBQgDYePZFCvhHRdTmTz/Jv
         fVEvf/dtORdN2ZkjbMqxLwaezG27fpinehiAwnNV/0voO5CwpgTssqN2Ls6e6MLC8SAE
         ckYQ==
X-Gm-Message-State: AJIora/trXiO+rAe1yNLbsNVVL+AHbDS6AQqKOMqpuA3rCdZISfAuwpl
        7T1sdYTnXq3+yha3XyiMTLycmLpJXkcv2y4lJX13BA==
X-Google-Smtp-Source: AGRyM1vnqCcyIkxaLhGzDujI38DtPZPyGcfvq+svZqcT4XL627aiXs+NBcZn7a4uOp9e+xW0HhccZsu3w16e46Zi9Gg=
X-Received: by 2002:a25:7ec2:0:b0:669:b7ad:8806 with SMTP id
 z185-20020a257ec2000000b00669b7ad8806mr4913319ybc.85.1656075429910; Fri, 24
 Jun 2022 05:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220616141950.23374-1-Jonathan.Cameron@huawei.com>
 <20220616141950.23374-2-Jonathan.Cameron@huawei.com> <CAFEAcA8U9oNDStfLpxOwodGm9MCTdLrt-WV+x_-rTGw9UpBGvA@mail.gmail.com>
 <20220624133909.00005f6e@Huawei.com>
In-Reply-To: <20220624133909.00005f6e@Huawei.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 24 Jun 2022 13:56:32 +0100
Message-ID: <CAFEAcA8GA+ZXr2eS9bVxnhZRtda17Wx0Ud8CfcA90T6yiaecew@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
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

On Fri, 24 Jun 2022 at 13:39, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 24 Jun 2022 11:48:47 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > This seems to be missing code to advertise the new devices in the
> > device tree.
>
> Intentionally. I am not aware of any current interest
> in defining DT support CXL or supporting it in operating systems.
> Easy enough to add if anyone does the leg work to figure out the
> bindings, but that needs to come from someone who cares and
> would need to be driven by OS support and a usecase. The ACPI
> stuff here is defined as part of the main CXL spec because the
> target class of machines simply doesn't generally use DT.

I don't really want new devices in the virt board that aren't
usable in the common use case of "just pass a kernel with -kernel"...

-- PMM
