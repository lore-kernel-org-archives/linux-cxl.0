Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A89EC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Mar 2022 23:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiC2Xo3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 19:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiC2Xo2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 19:44:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164FC1BBF63
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 16:42:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so405217pjb.4
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7SY06tnRzrz6P/mz+rTH1u3uFmFsWNbzb3/tSpSUul8=;
        b=CuB+hQFuh7Ylf36/EBtXMlZYC8z5BHF4ttx0lN1zlx0Z9UY/zBvPyPvit+tjRSNcBY
         rs2Dn3jn6+Ukyh6Dr2fUnYlcbsw80eIU5SjDjfhccHPdxQZ6/z7eg/2FEtDzKkt/l13p
         d4F8jlTf2UyVJRq50PlGMzHN5aHC1tFWH7BIJJLatfY2dSw0EqWSelQ5X/AivJQQQ0Ie
         DACzLxW5psZgLFC0h3uRpZoypiKt7vr4VVrS444lHbPNJoybNP6dbhwZmzP1XzdY6X9Z
         VKX3/vvIcMf9p79f1M4Dh9Ha+Dx/BQ8hviI3/bNPlw8u1gzUZm4qcPNzTY0aXz52JA2X
         T1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7SY06tnRzrz6P/mz+rTH1u3uFmFsWNbzb3/tSpSUul8=;
        b=QHo55EFQX9BHwg/GDG6HLB95WUbDxMoGo38FQLwcd48MdVh/p4wJQA+ISMW0W4f2vR
         93J+DwbOloaq+JFPA1ZNrmaAOigwoJGAUXGvvdGcHnVkIyyxi1jJjAbbHIiGhddJyvEq
         QGQ4vReCbIENU/F9Vd8SvQaXreSmcYpxV26Oqukcwy2ZzYuDgseZ89yB0Vcp6mkqYHhN
         znRDU4Ee3/odyG37ro0/EeK12DrylBblMndfn/ECCHCck+0aYCcDqQAJJaL0H0qui3EX
         ObmNFOzpz69QlDuGvEGyTKYvKGdpMddXLVzmMr52DS563Lk2zhXrk1DmXrgy0lZCx75X
         UKIg==
X-Gm-Message-State: AOAM532PeZ6XqmJctP4+cPciHU4UUlKIrZPr9EgQ1JuM2ThUWzgJDRZT
        0R698WaALFBx37isVPkseQFEDAREyernirt/DXaye6BQDR0=
X-Google-Smtp-Source: ABdhPJxD51CxUJ7G/PNcTyUXIc8Tz84BGnsNNNWKatUSo46pSNflvhRk435P8EUgNaXhgcdPtV0xI2afT5z36nQhOO4=
X-Received: by 2002:a17:90a:c083:b0:1c6:a164:fd5d with SMTP id
 o3-20020a17090ac08300b001c6a164fd5dmr1726847pjs.8.1648597364545; Tue, 29 Mar
 2022 16:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234049.69323-1-dave@stgolabs.net> <20220317234049.69323-3-dave@stgolabs.net>
In-Reply-To: <20220317234049.69323-3-dave@stgolabs.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 16:42:33 -0700
Message-ID: <CAPcyv4jr8-pPBDq7+APZB1a2WjuGUQvFWmGqMoT9rT0UceCkKw@mail.gmail.com>
Subject: Re: [PATCH 2/5] cxl/pci: Use CXL_MBOX_SUCCESS to check against
 mbox_cmd return code
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 4:41 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Also mention the need for the caller to check against any
> errors from the hardware in return_code.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8a7267d116b7..c77e06aff8dc 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -177,9 +177,9 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>         mbox_cmd->return_code =
>                 FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>
> -       if (mbox_cmd->return_code != 0) {
> +       if (mbox_cmd->return_code != CXL_MBOX_SUCCESS) {
>                 dev_dbg(dev, "Mailbox operation had an error\n");
> -               return 0;
> +               return 0;  /* completed but caller must check return_code */

Looks like a good clarification to me.

Applied.

...but note it won't appear anywhere until after v5.18-rc1 is out.
