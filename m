Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C81C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 02:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFF2610D0
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 02:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhJNCzt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Oct 2021 22:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhJNCzs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Oct 2021 22:55:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6157C061570
        for <linux-cxl@vger.kernel.org>; Wed, 13 Oct 2021 19:53:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so5886630pjb.2
        for <linux-cxl@vger.kernel.org>; Wed, 13 Oct 2021 19:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVpsGH9QL+KHRg/uYizyXVbiWTS3IE6Hk8UnQH9kZSc=;
        b=CBo3Y8VMIuP9F/1zWBhQpin90T5rhk3BznP+I5XT27ni7u6rLMKnOOeX3TFGtSsM3u
         LJLFipL8pvxMjg/Men7B4yRWaTxBQYv9e0L5OF9OEKGUwqi9Vta39Bw6Q2ZtGFPO0SNu
         8pzgWgBJ5Olppxw62ugK+iX1GFo3j1ojCgiTxZmKakw7Urkkn05g+d0u3aXVJj/g0Fsa
         5j0vEUWS7XXNOW0tS5wYTCcDLaIUIk3UEAs5vAjpc9La6DKNj9QKBmNzpYB5tP4wRMyo
         z60T0zc/at9qo/M4LBW35/7FqdJlKI1xREYximbYZ8ktRXVBmXYCk8ucUYc/md++a5Vu
         v8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVpsGH9QL+KHRg/uYizyXVbiWTS3IE6Hk8UnQH9kZSc=;
        b=KbgDxl2BAc9ulYsMSfcx50O36pesUGHhSUT52JhINXvMu+R6nHiXF49dYUUymjMv/s
         pWl5RZ2T13EfO1e742kN19OmRU0LAVH61sprxJ1/Ow7bPuuIY1fDmLM+sGgbVsaBU2En
         EULlf6NARlGepcN9bnJE01isj6oNz72flybLGRWspEjEsBc5RBYJ2qNOWuCEye4XmoI/
         /ZJAxN6lTCQyid7Dt+Bet+2tFJKK5DoJWtHBg6TUWLhatHrVNTJSlurmzQWENZg/uvtv
         dMwTuzDnVp8NdYt2FdEWflkqj9Yjk5xKo1wGf+23GCMyg0eYXwF1JjKstkUqKGvF1KtN
         gyCQ==
X-Gm-Message-State: AOAM530PcbuqVHzgkiTMNmvHbObvwRuIZGLBu1PAn3YELIrWPo3MrjPP
        86E0TSecc+xElmZVmvNv3fc7QeKZvHw0EUyVm8xpNw==
X-Google-Smtp-Source: ABdhPJwM2El7xf3YN1ghBPWV4OXD1TwLVjjmUssbvQ/tiDJLj4d5xzC+fmzoJwg0XlyxbzbEQTU7NHV0hyAB+0xHl6w=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr17634635pjp.8.1634180024229;
 Wed, 13 Oct 2021 19:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com> <20211007082139.3088615-6-vishal.l.verma@intel.com>
In-Reply-To: <20211007082139.3088615-6-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Oct 2021 19:53:33 -0700
Message-ID: <CAPcyv4j2=K15QDN2S6G+R37rSQQOQjO3NQP8RHWca0OnwvSh6g@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 05/17] libcxl: add support for command query and submission
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add a set of APIs around 'cxl_cmd' for querying the kernel for supported
> commands, allocating and validating command structures against the
> supported set, and submitting the commands.
>
> 'Query Commands' and 'Send Command' are implemented as IOCTLs in the
> kernel. 'Query Commands' returns information about each supported
> command, such as flags governing its use, or input and output payload
> sizes. This information is used to validate command support, as well as
> set up input and output buffers for command submission.
>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
[..]
> +CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
> +{
> +       struct cxl_memdev *memdev = cmd->memdev;
> +       const char *devname = cxl_memdev_get_devname(memdev);
> +       struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +       int rc;
> +
> +       switch (cmd->query_status) {

Ah, now I see why you proposed having another flag in the
cxl_query_cmd() payload to indicate hardware support for the command.
to save having to validate before each command.

I wouldn't mind a TODO here to remind about that... but not critical:

You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
