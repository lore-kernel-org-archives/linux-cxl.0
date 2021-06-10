Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BD7C48BD1
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 22:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9894613F1
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 22:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFJWCe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Jun 2021 18:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhFJWCb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Jun 2021 18:02:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ECAC061574
        for <linux-cxl@vger.kernel.org>; Thu, 10 Jun 2021 15:00:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so4590311pjp.4
        for <linux-cxl@vger.kernel.org>; Thu, 10 Jun 2021 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i5w+LRv6C8SHjmj16D4ue7TAWg9exUnPtZjWQ04w/cA=;
        b=XXNdlZtbAsV7LCrXkc4W3Ko58O7p92xlAH9a9WQ4Adb1wYUZREH7bJwqfaW3Z66bbx
         SfeuRR0X54V3plmBBPsFkvPgspDE57iEfWfo2K0la7Oy/tA/EnzRiqBovK+IXbQalUnJ
         QuW/BAA//TfOJ63dor+lJgISWamia4aVpOPZC3F7CfBCFK5f2Zu3ncESGorhgStFYhvJ
         N02kJshrpPt1xAkG1h4eS/C8zhCiKvLqHkARVqNhw3cJR6zuijbRuezmq4/+LNEuxGfY
         sLngvSqMEGcJlbEulz1zWzCimN6UsA0Px5PTMW6moQShjlClEcbK44BSY/bN1bk+jm20
         Dfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i5w+LRv6C8SHjmj16D4ue7TAWg9exUnPtZjWQ04w/cA=;
        b=FFyNx7xxgSGcp/1XUK12sTpwd9tS5+/BGWsYeXg9dENnuqizzK9qsKdNH5dVvfs3cW
         nlP7C/CZL2GvXm6/LWyQk/rPtRdaOlYTOKSN93HHDNc8AvzRU2C/KAroDaVFQHKF6XRe
         6b8ImJq+oG2MC/E7ljPhcWJnG1iaJBlygh9vC+5SD7HwemeZTvfgabA9oIxOQZUwQ+31
         c6s+XgffPEdYSnLat/MbipvATm8rAabncJ7kscTjORzHi9mCyxCuEwZ6YIiD361obR4j
         rWk67/cu9zI4xH/GO+4IgCmWJJEdjgButb/0LueXoPRN3A4Qs5RzqZ4AD8BzgkqZkHN5
         0lTQ==
X-Gm-Message-State: AOAM531cp1dY2DUciHLMOQ1I5OZbLJpyFtxBXMd3I3rS11SefwxmHMeE
        M2myYfm/ErqB/NSPuR1zRL+K3wDJjpLSbVTSmhRQ1Q==
X-Google-Smtp-Source: ABdhPJwoYWvfjBstUPn0izkY0VT4nggS7379pES3iqk9k9Koj5zAIuKefmFFSscy3pXMt/XGbnYr8ogKvYGIVaThB8M=
X-Received: by 2002:a17:90a:ea8c:: with SMTP id h12mr5355987pjz.149.1623362432259;
 Thu, 10 Jun 2021 15:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210610215332.991905-1-ben.widawsky@intel.com>
In-Reply-To: <20210610215332.991905-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 10 Jun 2021 15:00:21 -0700
Message-ID: <CAPcyv4je4BZqpvRw92PNOKpxhp59ZLbydNBbkKLD-UQBj725sg@mail.gmail.com>
Subject: Re: [PATCH] cxl/hdm: Fix decoder count calculation
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 10, 2021 at 2:53 PM Ben Widawsky <ben.widawsky@intel.com> wrote=
:
>
> The decoder count in the HDM decoder capability structure is an encoded
> field. As defined in the spec:
>
> Decoder Count: Reports the number of memory address decoders implemented
> by the component.
> 0 =E2=80=93 1 Decoder
> 1 =E2=80=93 2 Decoders
> 2 =E2=80=93 4 Decoders
> 3 =E2=80=93 6 Decoders
> 4 =E2=80=93 8 Decoders
> 5 =E2=80=93 10 DecodersAll other values are reserved
>
> Nothing is actually fixed by this as nothing actually used this mapping
> yet.
>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core.c | 3 ++-
>  drivers/cxl/cxl.h  | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index cda09a9cd98e..92db02fe7aa8 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -666,7 +666,8 @@ void cxl_probe_component_regs(struct device *dev, voi=
d __iomem *base,
>
>                         hdr =3D readl(register_block);
>
> -                       decoder_cnt =3D FIELD_GET(CXL_HDM_DECODER_COUNT_M=
ASK, hdr);
> +                       decoder_cnt =3D
> +                               cxl_hdm_decoder_count(FIELD_GET(CXL_HDM_D=
ECODER_COUNT_MASK, hdr));

How about make it a static inline helper that takes @hdr and move the
FIELD_GET inside there to save some indentation?

I still think it warrants a Fixes: tag, the commit ids in cxl.git/next
are stable.
