Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F3C77B7A
	for <linux-cxl@archiver.kernel.org>; Sat, 20 May 2023 12:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjETMiJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 20 May 2023 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjETMiJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 20 May 2023 08:38:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EF0115
        for <linux-cxl@vger.kernel.org>; Sat, 20 May 2023 05:38:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso7087916a12.0
        for <linux-cxl@vger.kernel.org>; Sat, 20 May 2023 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684586286; x=1687178286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sodBaUbIIBP3YQBI3zr8YQ5KKd3axlGTGAqXJU42UXs=;
        b=i2kSbI5svxKH5TrfW02P9EOmvm4A3uwKMigjvv8Ttv66HS/U91y3ezdlP3DaS8j3rW
         3XS0keCqbErWVVtL0rz/o5vDVO6RSLbPF2WCV8A63XL0QtTATy20RdUOlSqYZ3YqL6CQ
         b2bzdNk7PSTxLPEHwUt1eqasZPlRNAugHFZ1X+PYYO4NarujjLXlhOjEVSegv16/zI/4
         QTvQH+YrLhwWFMlcLelHHNQ9V37C/BwLi0kmC/EQGB67ogYEz+ffb8+FlZqfwxnk1yUQ
         Bff7QunQ2gdTNieitclAyGsWPR2a9OtMi9CQUi1JoV5YwIN/N6nUCTMDFFWMwEzCUPgh
         ekTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684586286; x=1687178286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sodBaUbIIBP3YQBI3zr8YQ5KKd3axlGTGAqXJU42UXs=;
        b=hqBIeEJZJzO9qpPwovT87UO26RBG1s9fV3wGHgEwc0QzIW9sMVi0WxcvGPQimcETCK
         PgGDfOG1Pq/NVkvIwwMXwhNURfmDJxUxCNyf4TJvRQ4PhqYZKvbcCBgogaelq3u9n8Ua
         07fg8Cj0j60+9Vx7aArb+ZhhgD4jTAvt/v+r2vTpVsD0LjbHh6meyvpd/ufySvNKRVF+
         ko6bdJNvHCZKMO8BRkz/hHRYVfLr70zvp2FOndd1RPFavFWUkfxddNt8hDXhJ4u2TKsN
         aC5ha5SKkrQKsZkZkRgvbaG6+pd+E0iectu5/sICLWEq515gGVw52f1FOgmgixeWkBjQ
         E4UA==
X-Gm-Message-State: AC+VfDyz6/M4nhnbf6HO+T8MhXwpy00iATX0cQFk5PIyYOPnp3BY+20K
        QHkKDwInGx2MZKdoVrIYZR5e6MDrz423QDP0ioUaFw==
X-Google-Smtp-Source: ACHHUZ6ccSfmLlx5bLjn6mhYNAoy4X85foHkwJ+euJ/rK2DSipa6zQTeAQyRPpvyg02IcMFEYUhvXpa1YggIFNPj2Jc=
X-Received: by 2002:aa7:d905:0:b0:50b:febd:3cde with SMTP id
 a5-20020aa7d905000000b0050bfebd3cdemr4289123edr.42.1684586286093; Sat, 20 May
 2023 05:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com> <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Sat, 20 May 2023 13:37:42 +0100
Message-ID: <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned 24
 bit field
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> specified as little endian.
>
> Define st24_le_p() and the supporting functions to store such a field
> from a 32 bit host native value.
>
> The use of b, w, l, q as the size specifier is limiting.  So "24" was
> used for the size part of the function name.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  docs/devel/loads-stores.rst |  1 +
>  include/qemu/bswap.h        | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index d2cefc77a2..82a79e91d9 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
>  ``size``
>   - ``b`` : 8 bits
>   - ``w`` : 16 bits
> + - ``24`` : 24 bits
>   - ``l`` : 32 bits
>   - ``q`` : 64 bits

Can you also update the "Regexes for git grep" section
below to account for the new size value, please?

thanks
-- PMM
