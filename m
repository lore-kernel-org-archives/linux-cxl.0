Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87712C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 16:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE3061181
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 16:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhJNQhx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhJNQhw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Oct 2021 12:37:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1A5C061570
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 09:35:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so5151206pjb.5
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQiBdpe7qbcqSGrUqozD2QtPj9Zro4pYZ3W/Jb6TO/g=;
        b=ZNJGoGdx+8OHFFkt/GPeDtg2CWAGRYXW+GZJgm0XiRmkOHHRHTYjwKEok5+3suoYN2
         +8cP986JoPMdYMsaS3TtKwfjxSghX9ZKiJqXCO7tPDpyS87zJaqsn0RbiGlcsLvZk5vM
         M09BfFe0EhVJ3a8WSM4N8P0Z2lnY6Ox6zQ5+ubceZSTOgqpxJGJKaSIrdlzkxwuX9JvE
         eW5h9QGaLenlUw7qOmMdkoIuSnfRf5QAAy938cEWKuLpCGyM+cmwm4kOd+UzULTyuE1b
         ZUJ0pwOMobAprNjZ01oOS4RD1y2Fli1AR5SmebNiLLVV1navHuMIah+/KO+BXjAU8x5D
         yUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQiBdpe7qbcqSGrUqozD2QtPj9Zro4pYZ3W/Jb6TO/g=;
        b=cnJNbEUz7QoSFyb9oNrbCsKSknM4CWX2ja/JyR7LeEUJPQeU+HNNoiEc/Xb33N+HD3
         cllqxU3shhxxR9SCZgl8YSypLLkXRflLolFV9oKAM528EerN0rcZbET4UgCz9Lrmjg7Z
         p5DFcLKeuvUsv2ZNW8doxFhr1grN7edjN8zeK6+LQIbj5bqkptLeVkEPUkA7d8XN+fAB
         LTh2GPkHL4NN/nqQzx7+WwjTnNCzEZlsZjQFdtdUBdeX+mjv8CoIuF5uXlTSLmNtprO9
         WHm0l45BT6AdL8jfLqqH1Z0o0bjU1jIHMrKnUfwmkjxtRbr9yMWULqVZd6UrHifaL/5v
         wzyg==
X-Gm-Message-State: AOAM533QNaeI7OpFSVsBryAt1L84tBY6TO6pbiJeGNL3x1TB6Ho6W3Ev
        Gm+/LMa3qHaZzX0/vaXt6/IZjMDWszCb3vA9hEwRfWwnAUc=
X-Google-Smtp-Source: ABdhPJycN/CudUZAYRPO2n8r4sg/sohuVKEXkwqGQ9RYUO7njtY7K8PmBYgAUFm2O12cyEt9ABb0vuw38v44r4g4YUk=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr21432231pjp.8.1634229347397;
 Thu, 14 Oct 2021 09:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com> <20211007082139.3088615-9-vishal.l.verma@intel.com>
In-Reply-To: <20211007082139.3088615-9-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Oct 2021 09:35:37 -0700
Message-ID: <CAPcyv4gMdTWPbLSo2+E6JzOzaf8soTwd+nzpBgcEZ-41BRJ63A@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 08/17] libcxl: add support for the 'GET_LSA' command
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add a command allocator and accessor APIs for the 'GET_LSA' mailbox
> command.
>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  cxl/lib/private.h  |  5 +++++
>  cxl/lib/libcxl.c   | 36 ++++++++++++++++++++++++++++++++++++
>  cxl/libcxl.h       |  7 +++----
>  cxl/lib/libcxl.sym |  4 ++--
>  4 files changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index f76b518..9c6317b 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -73,6 +73,11 @@ struct cxl_cmd_identify {
>         u8 qos_telemetry_caps;
>  } __attribute__((packed));
>
> +struct cxl_cmd_get_lsa_in {
> +       le32 offset;
> +       le32 length;
> +} __attribute__((packed));
> +
>  struct cxl_cmd_get_health_info {
>         u8 health_status;
>         u8 media_status;
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 413be9c..33cc462 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1028,6 +1028,42 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
>         return cmd;
>  }
>
> +CXL_EXPORT struct cxl_cmd *cxl_cmd_new_read_label(struct cxl_memdev *memdev,
> +               unsigned int offset, unsigned int length)
> +{
> +       struct cxl_cmd_get_lsa_in *get_lsa;
> +       struct cxl_cmd *cmd;
> +
> +       cmd = cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_GET_LSA);
> +       if (!cmd)
> +               return NULL;
> +
> +       get_lsa = (void *)cmd->send_cmd->in.payload;

Any reason that @payload is not already a 'void *' to avoid this casting?

Other than that this looks good to me.

You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
