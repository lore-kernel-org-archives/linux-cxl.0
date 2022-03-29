Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA440C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Mar 2022 22:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiC2Wmn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbiC2Wmm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 18:42:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6475232133
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 15:40:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so284273pjb.3
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 15:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSuRaxXOO/FOHlC2DV+esnWJ5qeNkp2Usu6MeGIAewM=;
        b=taEs8FeG8hA0EirKTmaPRwABH9+l+9qq2WuofwItnyyr8BgQn6elCVtVUFl94mHPMA
         2RIzsKxrN1aL5v6CAac8ZIKZh/ThBY4fwoLL18htYdjI6dix8J7xpN1lGQ93stDtyYO3
         VksMWcTGY35M0PfmQM6E49kLTtYLBDwgH7nF7CIC1oE/0QRqO9mo44t+r6xuOlAJUXkU
         MgE2swEDOcbAAJ2sRgI29QckNe+YjMoQO/m0JKyKt/1zy8nh2cVnSOehlVF2RTjgjZn8
         r8KOjKcIu6/J8sN78FkAUtidluZ3L7nW9DBgX+LPy4v149G7S1qJPXvp94SmbJwyzUeO
         ZCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSuRaxXOO/FOHlC2DV+esnWJ5qeNkp2Usu6MeGIAewM=;
        b=KUd98PsiWM5dJESignYzMXCLJbRMbuTVToSccsDBxNYgwOmxcT7g0TFSUZF6ywtbP1
         c0VfjVT7JXf5Iw111bweso1nAkrwKuF5sN//Vv4JXVl5BDAJ2wiDRi2Il00zs8nUHNcx
         WkxuHvWbVZaUzWPnCVJROYNsIjPa+iaD1fKM0OacuTNqP7lSpfRmgxJn7jsUG10iQh0k
         8BdYLgEAl1z65wX9GmrwwMH1LjswSuG0h18UUPP5FomHpAqyKZU/Iu4C1NS7XyktfVhI
         9EVJyrTC3FLs3+EYqc1wTpkgnqIcL4ei3WBpf44QmNoIk33KOcKKnbiihS1FK08OmGiW
         d1TQ==
X-Gm-Message-State: AOAM533Ih+iTxby9oSoHbHE9up+tSWwAT84o/L0ZI9jx07lZhhPTQtSE
        cQqyTY738Nty/PejdVJxBZe1I96LzoVjFCMKpqagEg==
X-Google-Smtp-Source: ABdhPJw0bapHsY6547mgCq9iEhrMmpVsoSSzXzUyE/D1E9bDf3642gChuz28GTkUeWPk+qEgTM60ldwc2XxJ+pIiFRQ=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr1421798pjg.93.1648593657413; Tue, 29
 Mar 2022 15:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234049.69323-1-dave@stgolabs.net> <20220317234049.69323-2-dave@stgolabs.net>
In-Reply-To: <20220317234049.69323-2-dave@stgolabs.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 15:40:46 -0700
Message-ID: <CAPcyv4iZsvdJvMX9gAkuXLPxVLJUHYz3fN9QWTRP6Fsi3Y5b_Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] cxl/mbox: Move mbox_mutex usage comment
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
> ... this is better served in the callback that actually
> grabs the lock.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index be61a0d8016b..778b04a0fb0a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -136,7 +136,7 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
>   * @out: Caller allocated buffer for the output.
>   * @out_size: Expected size of output.
>   *
> - * Context: Any context. Will acquire and release mbox_mutex.
> + * Context: Any context.
>   * Return:
>   *  * %>=0     - Number of bytes returned in @out.
>   *  * %-E2BIG  - Payload is too large for hardware.
> @@ -165,6 +165,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>         if (out_size > cxlds->payload_size)
>                 return -E2BIG;
>
> +       /* acquire and releases the mbox_mutex */

I'm not even sure this comment is necessary, because that's what
lockdep is for, and it's also not true for cxl_mock_mbox_send().
Nothing outside of the ->mbox_send() implementation should be assuming
that ->mbox_send() is enforcing serialization. So let's just drop this
second hunk.
