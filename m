Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4D8C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Apr 2022 23:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiDLXVc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiDLXU7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Apr 2022 19:20:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18B2BD
        for <linux-cxl@vger.kernel.org>; Tue, 12 Apr 2022 16:00:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a42so357351pfx.7
        for <linux-cxl@vger.kernel.org>; Tue, 12 Apr 2022 16:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F49G/T+nwxm9w2sBRfv3oXc8uyN5Uncp1KypMUua6iI=;
        b=GMvCGpgVcz4/SzgfsoU9pwgdpJnX65tFlxMYmNaCF/aouGNDiA2wClO1UeuItcFKdY
         FCvTyxylRxKlWVCkk2xylvYyfrChTGJZrWjkK+0/UdF+TWPIQaYHqEP7HQUpzQG32ixQ
         KJRxSJhUrvQcxriPtEjhZuzbBS+O3tEbSOe/74ckVdh98scgeQQzAbv9T4vh+Muys41f
         dkUXxfwSeVd9N1zIPugjCbqfOE//piGMbm5bzxafeNs8IpDOdUHQgZp38EOuSm2n240Z
         HuXJm0A1o17g0jN1uOmzBagh7hu1p7ljNfr4hIYrdavjpLffJWyB9BcGPoXHA9P+6GdA
         j5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F49G/T+nwxm9w2sBRfv3oXc8uyN5Uncp1KypMUua6iI=;
        b=xwF2609WW15j7UWYVyBYwuBrcd7z7xXla9miYEJe0NC5Yu7TI4ZCofzQHny01XeILE
         W8bDg0bfypzmXZyVzGmFjN+odhpEkQlxoPrIJzFjcGzWD1i1eESIbw20VOWabmMPmHG/
         oY1kv7rJjErsiUVn2SnR37d5N5rnGQ/r2cFZvKzoaBn/IzBtkFQn0mfms2OYMpox8RqQ
         sdzJqE/cBwJb2AxYK2T6aidfhmCNk25mT1SYDsGO2ZImHLcDyu6Oqu/fQu/mksPKCsVg
         /ekexCz9tKisLdXl0Iqf1ENRfzUk2ou5ctfdDc0maGFGVAI037W3OS0sJEhilBO8fy01
         ubDg==
X-Gm-Message-State: AOAM530MmSby+hAgKov7+VjJ0l4OjdNTMlcL7PPIVGb2PxXL8VYXHxdl
        2eosAcWKORTwlbiMuxfpiElJXOujf8XaYl09xvIpng==
X-Google-Smtp-Source: ABdhPJx3CvYA3qrx73cVMPlmGIrDgidUklkZkqMDy6q/vLnkWlgBIafcS92yqcSX7u9Irn9hM8QGe/rTV2KXa1/yJlA=
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id
 g23-20020a631117000000b003992df07fb9mr33360002pgl.40.1649804440625; Tue, 12
 Apr 2022 16:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220409031312.1220512-1-alison.schofield@intel.com>
In-Reply-To: <20220409031312.1220512-1-alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Apr 2022 16:00:29 -0700
Message-ID: <CAPcyv4g+V6VUT=o7-cgqiGX0yOyaY5YwTiwkB6Qmg89tfB6+sg@mail.gmail.com>
Subject: Re: [PATCH] cxl/mbox: Handle variable size output while still signed
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 8, 2022 at 8:11 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> A mailbox command output size value of (-1) means that a device
> may return a variable sized output for that command. The device
> defines a maximum payload size, so the driver will allocate enough
> memory to receive that maximum payload for these commands.
>
> A recent code refactoring moved the check for variable sized output
> to occur after the signedness is discarded from the output size.
> Move the check to occur while still operating on the signed output
> size variable.
>
> Smatch warn: unsigned 'out_size' is never less than 0
>
> Fixes: be0d0ce77aa3 ("cxl/mbox: Move build of user mailbox cmd to a helper funct
> ions")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 8a8388599a85..987703ae1fe3 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -258,6 +258,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>         *mbox = (struct cxl_mbox_cmd) {
>                 .opcode = opcode,
>                 .size_in = in_size,
> +               .size_out = out_size,
>         };
>
>         if (in_size) {
> @@ -274,12 +275,6 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>                 }
>         }
>
> -       /* Prepare to handle a full payload for variable sized output */
> -       if (out_size < 0)
> -               mbox->size_out = cxlds->payload_size;
> -       else
> -               mbox->size_out = out_size;
> -

Why not?

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8a8388599a85..6c6f6a157485 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -253,7 +253,7 @@ static bool cxl_payload_from_user_allowed(u16
opcode, void *payload_in)

 static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
                             struct cxl_dev_state *cxlds, u16 opcode,
-                            size_t in_size, size_t out_size, u64 in_payload)
+                            ssize_t in_size, ssize_t out_size, u64 in_payload)
 {
        *mbox = (struct cxl_mbox_cmd) {
                .opcode = opcode,


...and then the rest of this patch becomes unnecessary.
