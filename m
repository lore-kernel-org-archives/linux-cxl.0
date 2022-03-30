Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE850C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 03:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242269AbiC3DbX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 23:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbiC3DbV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 23:31:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87A126AFB
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 20:29:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so4951778pjm.0
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=usOdW5JYdxClHsHrxp7ZONB21AltBpqn24DKVOjoijc=;
        b=uEkYIrm+OE+fI6WMb9bMT1ifcoQboMyNtPsd4ll/PoDsUcF5BqSe/Y33CocmAoA5Sx
         DlGzfTLIQ1sXs2jZDOZeokmZsUfB2YWuz8X2Ql4ai2h2ZQDrtTsbfM5d7iSyxnt3yGLt
         nF5/R9lqVmj8QByEv/xxkwksLupDMb5DLhq179HeNkYE4KWnwdc94HdkFJOUhsiHNG+7
         3WwnmoU1HuNX49yt1o1gqgRpDBAbFcttcsK8rCHE/3s+6p6yTy9NRHtHXezZVQPZjdbZ
         puIVDP7G9EBLxd9EDvVUQ1A6qaw1l9OXLjiGb7eIvyzS4AOieb7Nbq6M23WcqVD3eTOv
         2Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=usOdW5JYdxClHsHrxp7ZONB21AltBpqn24DKVOjoijc=;
        b=30PAEgkmBi3XAbgn5HZHIR2scE6JtSYHgee166Z6hCxexoLa3OW8Q55y3bfrS1Sd6R
         Xl/Mc9M/p0/h6eFXJJAefJis6NnGmq/qxRorfxVDpoAUqUy4i3kA/R170a2B39tGnKLa
         4QCSAuR35MRsUKAjPFamKEWj/Pu7g0gc+SB4XeEkad7L1Ix0dTR0bylt6EPcTOq9aYtX
         lP8JUHXCgndPg7PlhFzuWsEFQK2kpaLXHTz4aOLzfyod8NIzZ/VnWBGjdiOUj9jNlht+
         dhpN5ZXnXD+oxz4PFi2QyNiBtF0Ps3rCz6SYLfRYxgU/85ZLKsjv0NCGhAwoOO7XpCEy
         Hp3Q==
X-Gm-Message-State: AOAM531+cCyfaHC8rWXRKJeP5snuMq9kh6fMLmN8XfeyatIWIkI3SAzM
        CTNcHjB/qhtdEDrpQkU03yPSeBDOSdRHOcPZ6R0B5A==
X-Google-Smtp-Source: ABdhPJydPybJC9Y5AObg3FgcF0AOrYbuv7oWalemL8krPTu7JnISkszwvPUXsBQ6Q7ydF7TdS5JwABlMZr7hTA5hV1g=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr33131424pll.132.1648610976111; Tue, 29
 Mar 2022 20:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648601710.git.alison.schofield@intel.com> <1ede5d9b049ef8e87c352b23c6e86441dee55bbd.1648601710.git.alison.schofield@intel.com>
In-Reply-To: <1ede5d9b049ef8e87c352b23c6e86441dee55bbd.1648601710.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 20:29:25 -0700
Message-ID: <CAPcyv4gY=x92qbuLpDrU6avAuWsNAG1HuQabK864_xi0jUpGUQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] cxl/mbox: Move build of user mailbox cmd to a
 helper function
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 29, 2022 at 6:28 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> In preparation for moving the construction of a mailbox command
> to the validation path, extract the work into a helper function.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 60 +++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ae9aeb6c20f7..a19365075cae 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -207,6 +207,38 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>         return true;
>  }
>
> +static int cxl_to_mbox_cmd(struct cxl_dev_state *cxlds,
> +                          struct cxl_mbox_cmd *mbox, u16 opcode,
> +                          size_t in_size, size_t out_size, u64 in_payload)

Here the output object ends up in the middle of the arg list, so it
should at least be consistent with the other to() functions and as
before I'd prefer it to be the first argument.

Other than that looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
