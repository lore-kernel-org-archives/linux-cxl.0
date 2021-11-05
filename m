Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0A6C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Nov 2021 18:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4317461216
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Nov 2021 18:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhKETBG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Nov 2021 15:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhKETBE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Nov 2021 15:01:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE36BC061714
        for <linux-cxl@vger.kernel.org>; Fri,  5 Nov 2021 11:58:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u141so1713547pfc.4
        for <linux-cxl@vger.kernel.org>; Fri, 05 Nov 2021 11:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mW90X9+gr0PIhSZqkuZE/L6VltlPrLZXEb+Nmd3FqjE=;
        b=Vk9ywDDuUBQjBxz5Bhs82UqvyiI5el74xlzmmTq6IyrpBX075HpWlqo6vczeS+i3Ts
         rmKXQSfHpwhq51JRUnjkAkvRswQDUhclfzc0tzP72GeCl5dylN0cdCuIzv8u1zmQ6D0V
         wTNEspIhh/ABEBZLOXT4HN1mcw5/NxSewyfRL3ZBnczRX77Jz1w2Rg4sDvZLWtZrbMUv
         YS8rMPVlEZ084Dns6saHvYhTeTQTkhP/fuEecw5ghFS5OqG4s64GdNE/jyFccQLWuQhw
         wPpeHAtTyJPj+hx8joyht7rGaZ1UChCLeXDKrfuYtmOBLDzJvpcVXuqcGFmD0+ttntzb
         Gt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mW90X9+gr0PIhSZqkuZE/L6VltlPrLZXEb+Nmd3FqjE=;
        b=eUFkB1DPW83F0Rp/tQIQGcYtK9fxNE5Mz7YfhsfuGzynkwjg3octcZu9X1tQFdbsXK
         9Bt7D+4BA+Tv+S2UKoSY7M740LnvtvCxpmM0b0Kg8KkbRtSqhH5Ka72r9kT0TbYlNO8A
         g/JdtFAq4XUKT2/5nTU2H8B/1AXcojR1KfiOg5ZYhVOAXivsGHMh9Fw50/GvGc5urkp9
         zOwedBSfhrPE16+40rlJRgJVgC0DT+IottP491V25EQBwytTHW8600j/cB+WDE0mMjo6
         5xizm/0a9Yuq1pXH7w1Ee3hSYBdm+mECsENS7jt/kFhfPp2lwCWRloGYm3w9jS7VB8p3
         WEEA==
X-Gm-Message-State: AOAM533L2wIi13fpohh4aak+VHRBxUxM/Jng8gCwi4e+J62C9r+Z8SxO
        jkHQAP4PbKmwIdia2CriEttLG0LH9gpzokl1byKFQA==
X-Google-Smtp-Source: ABdhPJzqoEa6aN6B4mzzs9jiitxAuljmgujGqpHKF7RPAxB503ycvVs+0OUKX60ZCN+BWDbBSATY0DZXgxiYgekQugQ=
X-Received: by 2002:aa7:8019:0:b0:44d:d761:6f79 with SMTP id
 j25-20020aa78019000000b0044dd7616f79mr61901423pfi.3.1636138704466; Fri, 05
 Nov 2021 11:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com> <20211007082139.3088615-15-vishal.l.verma@intel.com>
In-Reply-To: <20211007082139.3088615-15-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Nov 2021 11:58:15 -0700
Message-ID: <CAPcyv4grwvoGwzhF_bkg_O+uF8bkaODrnwiVhKL=8T8+_ytCdA@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 14/17] Documentation/cxl: add library API documentation
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add library API documentation for libcxl(3) using the existing
> asciidoc(tor) build system. Add a section 3 man page for 'libcxl' that
> provides an overview of the library and its usage, and a man page for
> the 'cxl_new()' API.
>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  Documentation/cxl/lib/cxl_new.txt | 43 +++++++++++++++++++++++
>  Documentation/cxl/lib/libcxl.txt  | 56 +++++++++++++++++++++++++++++
>  configure.ac                      |  1 +
>  Makefile.am                       |  1 +
>  .gitignore                        |  3 ++
>  Documentation/cxl/lib/Makefile.am | 58 +++++++++++++++++++++++++++++++
>  6 files changed, 162 insertions(+)
>  create mode 100644 Documentation/cxl/lib/cxl_new.txt
>  create mode 100644 Documentation/cxl/lib/libcxl.txt
>  create mode 100644 Documentation/cxl/lib/Makefile.am
>
> diff --git a/Documentation/cxl/lib/cxl_new.txt b/Documentation/cxl/lib/cxl_new.txt
> new file mode 100644
> index 0000000..d4d5bcb
> --- /dev/null
> +++ b/Documentation/cxl/lib/cxl_new.txt
[..]
> +include::../../copyright.txt[]
[..]
> diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
> new file mode 100644
> index 0000000..47f4cc3
> --- /dev/null
> +++ b/Documentation/cxl/lib/libcxl.txt
[..]
> +include::../../copyright.txt[]

I just noticed that these two man pages list the GPL license even
though the library is LGPL. Even though I think the license is with
respect to the man page I think go ahead and create a LGPL notice for
the library man pages functions just to reduce potential confusion.

The copyright can also be bumped to 2021 now.
