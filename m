Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E9C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Jun 2022 15:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiFXPCX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiFXPCW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Jun 2022 11:02:22 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C6A6547
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 08:02:21 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id o79so4969124ybc.4
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnYWT6+eru3uHPWApb4vpG/T5apsG8TSW4cZmehz1lw=;
        b=zq7QZtDLmFXHZztoUKje/w4bFHHUIrWSc+EfGMYwAsFnl94+nuNoEQtNLEwY9Utw2w
         XXlgeWTqV4VMtIEmbW2CQR22pTCLVggk1Cv4M2swje8tO3XyslNXhF9lkSfls1aH91vE
         lUldpVSJyfvzAPqlakH7K6aa3dkNP4Y3Z5OfRaloT4Rf2Z/fAT4EuXhgzD8drzW8jIui
         dS+whmMIYPOloBJV86hpTHDS0Vj/ImCxuJGnN+5JSw7HIJ6QxhIwj6ZM2FozegAZVkoj
         1Ej1zI2qRvyaz/uh/2rMK9RGC3pgcofibN/k/HtkE8jg+mQR5hwjTDPgGLiSK1yVRAY2
         Narg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnYWT6+eru3uHPWApb4vpG/T5apsG8TSW4cZmehz1lw=;
        b=Km/fJ+VX2QldWtQUr9/n70DV4yeaJ7LVHe4LCM41FOHzcGFlDhCS5ztwOf1dv0ZCct
         RaFl/M/gIkxkYruUJFMTAilpVg4cgZcF+EQS0V2wfWPXXXm0vRui52/tUZecWMCpuzoK
         byad/1g+98Ie0J27/6OFLTdFrq5+Y0I3rw2Af/xGYF7YTWYCaDvTRlOLUN9Y4hEXc0H7
         xCm+xWDcLxyjrdq6DdHAgsEFZDdugfQQ8j1FY0FyAKMlYU6QOcRXZVXyC5QLnunxUc/e
         Pbkzrb7A2Vm3XWsLP0qrbew/ar0rZkI2yAa02Ef7J7UryeS3itdnyTT9/Ky8f3gTS6cY
         D6gA==
X-Gm-Message-State: AJIora/Lx2chpSmrFoWv0xevpDOPOuz5GxNra+/wQQfcg5K/SGxC3cgk
        3oYO92RdevRa5KnxrBF8LxHxpnRXvD7W13LDPvgbVw==
X-Google-Smtp-Source: AGRyM1uMXPWDr04izJp2BwkDssX+25tzbf0qMTakadA3kQlppmVhNAe/FMBviiZzY01JVp7a7VLvfBEFR7iSRsB3KFE=
X-Received: by 2002:a25:d655:0:b0:66c:84b7:df40 with SMTP id
 n82-20020a25d655000000b0066c84b7df40mr19510ybg.193.1656082940786; Fri, 24 Jun
 2022 08:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220616141950.23374-1-Jonathan.Cameron@huawei.com>
 <20220616141950.23374-2-Jonathan.Cameron@huawei.com> <CAFEAcA8U9oNDStfLpxOwodGm9MCTdLrt-WV+x_-rTGw9UpBGvA@mail.gmail.com>
 <20220624133909.00005f6e@Huawei.com> <CAFEAcA8GA+ZXr2eS9bVxnhZRtda17Wx0Ud8CfcA90T6yiaecew@mail.gmail.com>
 <20220624150844.000005ec@Huawei.com> <20220624155436.000047cb@Huawei.com>
In-Reply-To: <20220624155436.000047cb@Huawei.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 24 Jun 2022 16:01:42 +0100
Message-ID: <CAFEAcA8MLTm9XwAV_JU_EPiT9wfaZed8B19-pL=HobKepJsnkg@mail.gmail.com>
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
        <shameerali.kolothum.thodi@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 24 Jun 2022 at 15:54, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> Just occurred to me there is another barrier to an approach that adds
> DT bindings.
> I fairly sure hw/pci-bridge/pci_expander_bridge.c (PXB)
> only works on ACPI platforms and is the only host bridge supported
> for CXL emulation in QEMU.

Isn't it probeable like any other PCI device/bridge ?

-- PMM
