Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37049CE7AFE
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Sep 2023 04:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjI1Esv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Sep 2023 00:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1Esu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Sep 2023 00:48:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A0D121
        for <linux-cxl@vger.kernel.org>; Wed, 27 Sep 2023 21:48:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533cbbd0153so11711286a12.0
        for <linux-cxl@vger.kernel.org>; Wed, 27 Sep 2023 21:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695876525; x=1696481325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heHPGL1VWDNNf6XFxEEfiRz4HN3qiwrjyD3dIT3TT3Y=;
        b=iFtUSMQ2WG+o3eku0DMh8DgE/Lz1f2VH6+eYClR1+G8JlIHRsTFy84+FWsSdyZxq21
         8fL4JATtWSDiuj9CnY1bYHTy++1A6GWWFmsoGOheEGiQst3VVIPGcD1C40Wljbcu6qSE
         XaXvL55UpA3b/JOh7C305laFdjoJnz3TpRU0lJ+jAUBzbDf0bLapd9z4Bhyokn21YZRU
         9B6wfV55CiHS8oxLsRv6FjDi+PeD83EqF/7yvZrGQNvcv1nllpA2UnD8Vt71Ffls44wI
         ogqyU2GIDRKtW3WNPPy8z8NIOZgYVx1R0CjLfkDIzEESSCCd6ii9LZZeomD5gbjwUk30
         Wz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695876525; x=1696481325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heHPGL1VWDNNf6XFxEEfiRz4HN3qiwrjyD3dIT3TT3Y=;
        b=HUyeEnvzAmHvk3hWeCIMDB6wVRWaQA4Mtt7S04vHM9V9DsDhfUxrhWw83uNRCLxc+X
         mrG6Jb4mXD8tknN8gQTLJhrPty5dmT0UyUFNzU1iZjz4wWXZlo8qBKqpVz/33OnF01Nw
         u19s1ty6F0UdxBfDIdS3ARgibP15sTwcbKlCfWNMxZfBEuNzGdaQXk4X3fVTrXz/jy5N
         jJQa270PLndyKHFyYAtOHMHhftMPsANYnxra0Vn+6Z038rDAVjUQCOED4I62zkwag9CS
         PRbqS2T89KeIL0zg9CKq/d2ne5brFX042pudTy9tiRxZoEiem0voaM48Vh7knWmXuB9p
         kwaA==
X-Gm-Message-State: AOJu0Yyq1+BQZDQ2a0YZBOWMv/bC9ZycbeRsTgJ+lV7rEVuGm3h4WPbP
        O4d8IfGGmcG3lgqJkWl8z8kRq/dh+TZmapQN6NccpRx9CrK3ZFAtEqOcgA==
X-Google-Smtp-Source: AGHT+IGiiFxnaM49SGb+63NiClG0YLueyxu9CNO9+fTK7ufBWNBl6F+BFa5pFCOChXf1fAyEMh5KUhanvrUUAun0FOY=
X-Received: by 2002:a17:906:8a77:b0:9ae:5848:3f8e with SMTP id
 hy23-20020a1709068a7700b009ae58483f8emr150816ejc.49.1695876525470; Wed, 27
 Sep 2023 21:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175319.work.096-kees@kernel.org>
In-Reply-To: <20230922175319.work.096-kees@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 28 Sep 2023 13:48:34 +0900
Message-ID: <CAFhGd8qdBmqwxAWsxDmmRYweOTRK33nFXWdM_QpqHtv6=bOcOQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/acpi: Annotate struct cxl_cxims_data with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, Sep 23, 2023 at 2:53=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct cxl_cxims_data.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-cxl@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good.

The reordering of the count assignment is crucial here otherwise
the runtime checks will trip when `cximsd->xormaps` is used as
memcpy destination.

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/cxl/acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d1c559879dcc..40d055560e52 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -14,7 +14,7 @@
>
>  struct cxl_cxims_data {
>         int nr_maps;
> -       u64 xormaps[];
> +       u64 xormaps[] __counted_by(nr_maps);
>  };
>
>  /*
> @@ -112,9 +112,9 @@ static int cxl_parse_cxims(union acpi_subtable_header=
s *header, void *arg,
>                               GFP_KERNEL);
>         if (!cximsd)
>                 return -ENOMEM;
> +       cximsd->nr_maps =3D nr_maps;
>         memcpy(cximsd->xormaps, cxims->xormap_list,
>                nr_maps * sizeof(*cximsd->xormaps));
> -       cximsd->nr_maps =3D nr_maps;
>         cxlrd->platform_data =3D cximsd;
>
>         return 0;
> --
> 2.34.1
>
>
