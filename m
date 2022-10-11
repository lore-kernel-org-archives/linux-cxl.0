Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C899C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 09:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJKJsX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJKJsV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 05:48:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C470A8B2D3
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 02:48:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i3so3477420pfc.11
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OzApLwxIYuEtnBDrd0GiQ2Z/nulp+/dYzIs6PEq4pUE=;
        b=D3ZzYlPZ112n+0eBJn7XFXREfMH2CIa0l4WQewkRNQK3RENuIbbdivEsnG+ynOCRPs
         9FnMSIOXg3CF6Ud6sAjIylKWlnIn0L83VDLKnaxWCwsm8Uun1uWxeaZkINxoYanNyaib
         PEUYfUqZcUMoMMDbO56rOs/Ye56in3nFLQ2XJBH/f8GxQox76x0mapx9+NBnjTDtt32O
         OnswdJ4QCwWH2C1zbpFwROWr9AjDTh5gyBglHRrodL9emU9sbWmww+wAHfFztFbZFZKr
         l/SUUEuYb/0c7Si1QFXHPI3VFPxFaDaqjo1X1i3T8ZhEVSc5w+ZrHoTi4/UPWStMEB/b
         5gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzApLwxIYuEtnBDrd0GiQ2Z/nulp+/dYzIs6PEq4pUE=;
        b=h1+J3RQvTEe6ELYHZuE+czr2f5c6WZYnzo4VuNBRCHEYNzvPrujW9q5RQNbTENUAbZ
         QpLolzaI7avAWMl2IFYWQ7W8HhVRfElqL/leqjNQXh0N3cglKBWQt8sJGA3k5A2BizRn
         pigeH8UF3zEVL02j0w5lGVNrdEHSpHNwDqETFo4N8p97Jvn7Bhz0EJoWd0qZzTnVvf/x
         bS0ApX14NW+D3tVZSddtXjXkjlVqxQCDcnasiVg46ewVgqCvHP39XxGTsqpPd0tB3Eig
         xilL3h0lxJ6us9v9x7AQVDi5u+KrblzBhm0F8S6GMTL4sGEqEcVVukOynTEGKukooDz4
         kb/A==
X-Gm-Message-State: ACrzQf3BtrT7TjK79BTj9+PzBh3CqMkepHgd9vTvS9Qo/eS7xeMafAym
        IVCl3fuu98A3bLm3CobfE9a6KGTEfKTREWEDP+BlxA==
X-Google-Smtp-Source: AMsMyM7KMEI5Tabse6Iws4nW+Os0RZ03aFqkiPQZx/oXEFUibmUqNHcnjzP3PxGiaKYa7RhWC7fpuyKsCsZ6Gw7g6v0=
X-Received: by 2002:a63:9043:0:b0:458:6003:30ee with SMTP id
 a64-20020a639043000000b00458600330eemr20999795pge.231.1665481698189; Tue, 11
 Oct 2022 02:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221010222944.3923556-1-ira.weiny@intel.com> <20221010222944.3923556-2-ira.weiny@intel.com>
In-Reply-To: <20221010222944.3923556-2-ira.weiny@intel.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 11 Oct 2022 10:48:06 +0100
Message-ID: <CAFEAcA9yVKWCZ-PhCbHqpaEW7Tgtqoo=wSQLy6=U5yfq2uVfPA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] qemu/bswap: Add const_le64()
To:     ira.weiny@intel.com
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 10 Oct 2022 at 23:48, <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Gcc requires constant versions of cpu_to_le* calls.
>
> Add a 64 bit version.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/qemu/bswap.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 346d05f2aab3..08e607821102 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -192,10 +192,20 @@ CPU_CONVERT(le, 64, uint64_t)
>       (((_x) & 0x0000ff00U) <<  8) |              \
>       (((_x) & 0x00ff0000U) >>  8) |              \
>       (((_x) & 0xff000000U) >> 24))
> +# define const_le64(_x)                          \
> +    ((((_x) & 0x00000000000000ffU) << 56) |      \
> +     (((_x) & 0x000000000000ff00U) << 40) |      \
> +     (((_x) & 0x0000000000ff0000U) << 24) |      \
> +     (((_x) & 0x00000000ff000000U) <<  8) |      \
> +     (((_x) & 0x000000ff00000000U) >>  8) |      \
> +     (((_x) & 0x0000ff0000000000U) >> 24) |      \
> +     (((_x) & 0x00ff000000000000U) >> 40) |      \
> +     (((_x) & 0xff00000000000000U) >> 56))

Can you add this in the right place, ie above the const_le32()
definition, please ?

>  # define const_le16(_x)                          \
>      ((((_x) & 0x00ff) << 8) |                    \
>       (((_x) & 0xff00) >> 8))
>  #else
> +# define const_le64(_x) (_x)
>  # define const_le32(_x) (_x)
>  # define const_le16(_x) (_x)
>  #endif

This is kind of a weird API, because:
 * it only exists for little-endian, not big-endian
 * we use it in exactly two files (linux-user/elfload.c and
   hw/input/virtio-input-hid.c)

which leaves me wondering if there's a better way of doing
it that I'm missing. But maybe it's just that we never filled
out the missing bits of the API surface because we haven't
needed them yet. Richard ?

thanks
-- PMM
