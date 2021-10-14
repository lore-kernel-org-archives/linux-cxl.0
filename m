Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136CDC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 16:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD5D61151
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 16:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhJNQuf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhJNQuf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Oct 2021 12:50:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA47C061570
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 09:48:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f11so2078472pfc.12
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1RwGIFYqIcTa4h7PEF9eSckj/8EEJrGq1do1E24wPDg=;
        b=fXs02Ecy0zNBoaQ/S/ON33Glt1oyRADv0YHdmLLBrNF4BM/O5Kz1y5GJTvkXcFyQOe
         5d8dh8XPCbz12wQFIRx9vHoEJD7nnEkOt9ZuW6hbhxFjL0XuYm0xRUiRus5w1DvPCaVZ
         452Q0SSgsZmEJhgLVj8BUcfnbuOC5ubumYtXxRtcfFlflVHUT7zJujMTH068yVRBAr8Q
         SehXk5trabX0x0D43nON8rkTGhFYCz/qUv5mCzMII8RoCrvcStTv/p6ZTnsv4oQpJc3W
         D/ycj8RlNzcFYZk0vuhMZ+np/r3kYZrKENyqgVy+AjTvRzzeKzcetetmZTKv+1/sMVgj
         /RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1RwGIFYqIcTa4h7PEF9eSckj/8EEJrGq1do1E24wPDg=;
        b=dfqIr0FOxHG+GwcjqHU8jWFMCexSJp7yrUClirNHD40wkOs2NBeK8AvSFZNzNLL8eI
         P2N5OoBDVxb/UZ/rRU4QLQ/F3KZWK1uTHmvqF+kBiApI+1S7G6XSg61t31myn6XOrEPP
         E17XN6tEx/HhzMg7Ca3vaZuReqSZOdfIT1Zv9A73Sw168LVAwq+7ylUV9Uaw0siN2fw8
         C5wxWbPWBvqPBJwo9vrIV9NcP9wwrw/ehPCLSAShbtqNEs+4kKobMTka+XXaLVRZwa6r
         0pMCUPB9c01rBg0HizXzC0hVWpX443My8bOOUWDvSD+j+rRnZExRCR7SvSyRuk7CeDkE
         3dhg==
X-Gm-Message-State: AOAM533AAIcDVbrEiNXW434aQP/TKZN7hdmh/9mpQlZttZDGBDP/vtyO
        JPJh1jAJkLIlvaSdhBAjnN0CtZOzZlgAa7xT3YDpLuO3mS39iw==
X-Google-Smtp-Source: ABdhPJzhwOQcDTklJnUiXHmt0mYtwIR5itIrTG7nLK/3IfH20FNjtS9cnabwkC5qSseYoVL15mFmSQquHO03SlT8cb4=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr6158723pfb.3.1634230109724; Thu, 14
 Oct 2021 09:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com> <20211007082139.3088615-10-vishal.l.verma@intel.com>
In-Reply-To: <20211007082139.3088615-10-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Oct 2021 09:48:19 -0700
Message-ID: <CAPcyv4gRM_3UxQkKxLg_up-zNecyTjrvG1CAuJyF1Wd+9bwfUA@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 09/17] util/hexdump: Add a util helper to print a
 buffer in hex
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> In preparation for tests that may need to set, retrieve, and display
> opaque data, add a hexdump function in util/
>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  util/hexdump.h |  8 ++++++++
>  util/hexdump.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++

If this is just for tests shouldn't it go in tests/ with the other
common test helpers? If it stays in util/ I would kind of expect it to
use the log infrastructure, no?

Other than that looks ok to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>  2 files changed, 61 insertions(+)
>  create mode 100644 util/hexdump.h
>  create mode 100644 util/hexdump.c
>
> diff --git a/util/hexdump.h b/util/hexdump.h
> new file mode 100644
> index 0000000..d322b6a
> --- /dev/null
> +++ b/util/hexdump.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2021 Intel Corporation. All rights reserved. */
> +#ifndef _UTIL_HEXDUMP_H_
> +#define _UTIL_HEXDUMP_H_
> +
> +void hex_dump_buf(unsigned char *buf, int size);
> +
> +#endif /* _UTIL_HEXDUMP_H_*/
> diff --git a/util/hexdump.c b/util/hexdump.c
> new file mode 100644
> index 0000000..1ab0118
> --- /dev/null
> +++ b/util/hexdump.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2015-2021 Intel Corporation. All rights reserved. */
> +#include <stdio.h>
> +#include <util/hexdump.h>
> +
> +static void print_separator(int len)
> +{
> +       int i;
> +
> +       for (i = 0; i < len; i++)
> +               fprintf(stderr, "-");
> +       fprintf(stderr, "\n");
> +}
> +
> +void hex_dump_buf(unsigned char *buf, int size)
> +{
> +       int i;
> +       const int grp = 4;  /* Number of bytes in a group */
> +       const int wid = 16; /* Bytes per line. Should be a multiple of grp */
> +       char ascii[wid + 1];
> +
> +       /* Generate header */
> +       print_separator((wid * 4) + (wid / grp) + 12);
> +
> +       fprintf(stderr, "Offset    ");
> +       for (i = 0; i < wid; i++) {
> +               if (i % grp == 0) fprintf(stderr, " ");
> +               fprintf(stderr, "%02x ", i);
> +       }
> +       fprintf(stderr, "  Ascii\n");
> +
> +       print_separator((wid * 4) + (wid / grp) + 12);
> +
> +       /* Generate hex dump */
> +       for (i = 0; i < size; i++) {
> +               if (i % wid == 0) fprintf(stderr, "%08x  ", i);
> +               ascii[i % wid] =
> +                   ((buf[i] >= ' ') && (buf[i] <= '~')) ? buf[i] : '.';
> +               if (i % grp == 0) fprintf(stderr, " ");
> +               fprintf(stderr, "%02x ", buf[i]);
> +               if ((i == size - 1) && (size % wid != 0)) {
> +                       int j;
> +                       int done = size % wid;
> +                       int grps_done = (done / grp) + ((done % grp) ? 1 : 0);
> +                       int spaces = wid / grp - grps_done + ((wid - done) * 3);
> +
> +                       for (j = 0; j < spaces; j++) fprintf(stderr, " ");
> +               }
> +               if ((i % wid == wid - 1) || (i == size - 1))
> +                       fprintf(stderr, "  %.*s\n", (i % wid) + 1, ascii);
> +       }
> +       print_separator((wid * 4) + (wid / grp) + 12);
> +}
> --
> 2.31.1
>
