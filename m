Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58F2C433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 15:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJKPvO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJKPuk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 11:50:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EAE26B
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 08:46:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso1813006pjv.0
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rlTXHFhe0HKoNEa5fPIFMDAeUvr6Q820R5cRXfzpG6Q=;
        b=VwILFHeo+EMz1mW/rR9QnsvWyuHMcqHwUFuwU4lB2GhsPHbAmXOfUxjiqGU4Vo8d+p
         WlLwbDC97dMCHzs7PB6/zFVaFaTO7hKpa+XEzLeCGnPfjuxokSejcu+G7rpO3NpRZNtu
         Gf/kJWLvxS0Hmv6po8NotJM2l/XyarIj6upNtlKetSVht7NRrcymyEgLVSNyEH3Iut+D
         IREi03xDEzbSzoNwpU76bBRIK51/rHZfGn1GCc/CKG2uRsLfxpwnRd0lPdSP/V028ROX
         tAIPBpaGZknVig1+FpNTkAD36SOIU6T14KrCcdUhVveZ6A8zJDIz77JmmjsIM4nraYwB
         6Tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlTXHFhe0HKoNEa5fPIFMDAeUvr6Q820R5cRXfzpG6Q=;
        b=A9uZhmsw5hMgY5kI0qAEAyoKIMd/mNbGYNe9ufz8sWuTxFX5Kr83tQIxD2BIvLxUeo
         toPrIUq8689Bdycp3UoU5+u2pPMn+E+yU/+V5wQpi/9raBT2uPSWiwv9pTG6EP8UEZcb
         sufqrIi4p9cQ+/RgchQRifZbC2nSL0aTZbOJPi9HprBbzCwuUQrWh7fEGPcvVR306B/Q
         +crq2Zc9XqWyVd9z85kd5lpHNHc7ZSOw12LnDv05XZ+8RQ1NrwI9y6iOE4jBXYDcIUic
         uoMKBTs5ypr6w2fV5TSexiOs+Kubr5dNhz0tDhlEW0VBdu2/tVYbz0pY/80BD8WxLHs1
         CNdg==
X-Gm-Message-State: ACrzQf1fPaAl4TqMdVgE612OwtNBF0jtUZgKSlhuXXXSkSK9VyRfHtAO
        k5fjV/C3YDmPNpHQgim7I/6KDhmlgVPINRIGGyhRxA==
X-Google-Smtp-Source: AMsMyM61cCjneqZQAFxHWbkMdOKyOoi/2Q648R5lt6yN0cWMNdtDceoNhBPBiBvclaklCXMGy4/u7j5R93Ob8AenNME=
X-Received: by 2002:a17:902:aa8b:b0:178:8f1d:6936 with SMTP id
 d11-20020a170902aa8b00b001788f1d6936mr25088243plr.168.1665503169346; Tue, 11
 Oct 2022 08:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221010222944.3923556-1-ira.weiny@intel.com> <20221010222944.3923556-2-ira.weiny@intel.com>
 <CAFEAcA9yVKWCZ-PhCbHqpaEW7Tgtqoo=wSQLy6=U5yfq2uVfPA@mail.gmail.com> <05ed1f6a-0771-798c-408b-272fb57b4582@linaro.org>
In-Reply-To: <05ed1f6a-0771-798c-408b-272fb57b4582@linaro.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 11 Oct 2022 16:45:57 +0100
Message-ID: <CAFEAcA-M_4Srp2=9OwG81DGCxo08fJRnxBY6+NEUn6j1idiB7Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] qemu/bswap: Add const_le64()
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     ira.weiny@intel.com, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 11 Oct 2022 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 10/11/22 02:48, Peter Maydell wrote:
> > This is kind of a weird API, because:
> >   * it only exists for little-endian, not big-endian
> >   * we use it in exactly two files (linux-user/elfload.c and
> >     hw/input/virtio-input-hid.c)
> >
> > which leaves me wondering if there's a better way of doing
> > it that I'm missing. But maybe it's just that we never filled
> > out the missing bits of the API surface because we haven't
> > needed them yet. Richard ?
>
> It's piecemeal because, as you note, very few places require a version of byte swapping
> that must be applicable to static data.  I certainly don't want to completely fill this
> out and have most of it remain unused.

Makes sense. In that case, other than ordering the definitions
64-32-16,

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
