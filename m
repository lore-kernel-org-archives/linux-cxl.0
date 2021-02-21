Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D83C433E0
	for <linux-cxl@archiver.kernel.org>; Sun, 21 Feb 2021 02:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A65F64EF3
	for <linux-cxl@archiver.kernel.org>; Sun, 21 Feb 2021 02:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhBUCj2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 20 Feb 2021 21:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhBUCj0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 20 Feb 2021 21:39:26 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1241C061574
        for <linux-cxl@vger.kernel.org>; Sat, 20 Feb 2021 18:38:45 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id d8so23281556ejc.4
        for <linux-cxl@vger.kernel.org>; Sat, 20 Feb 2021 18:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yBZELyjdiaRxkUIOCMRr5zC42a7wDyovP4ztiyPYwJA=;
        b=SZhcpUnPIY16mbxDPZs7FJLai9+V02OlWx7dcuLRhV/uMdkbmgNhYIX77Sghi6tUez
         WI6ecCKOgvxAzf4xw9Rb+gqrZFAGnGQOztbkgILg5Lc6GmjfJd/7exnHj3QxsE1pt3NE
         b3DJlpju4WzvQCBpUjVu63TP911pjZoPymcXauPfIe8NjdrXsz5XApmF20Au7vnCBhjr
         YP/s+cDC++60+7QCFC3zkWUjAtXBXddKbQm6FC5H5lSxnungESfYrjpQp+lek1bOd6sB
         ture0wZZqY/fdtbGC+j6G5vTRdC5JZyFtjh+TSp0yDZ98amDPRIoH7JrG2vBvlXxzjet
         XZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yBZELyjdiaRxkUIOCMRr5zC42a7wDyovP4ztiyPYwJA=;
        b=ZC78jIG2D/Bbs5rzN66ouFXTZgIxOJNaFuNtEt2kc9sVKxfoHTX15nQ3b4U+oDr7yG
         c+XjReCg3Hf7rAydz9FJoYPlTvUhBoG7pW9pF+TS1t/igLvL27zoMRnQ/N/CJBCyJ9OD
         Q9/ZSN3ghRH9GYU+5a3xqHV5Z8YDBapRUKktcuUETKHoTPoAa/csZ59SpWicgnHBuVjK
         jybiRNaakCNV+jrTvpQ1cOEktRx5439/itMdcGEFs/P54p4MxlcGY1fCIrMa9CHqMGWu
         0z+Ey7+/OkZtUHEDE1nGRBRab7IabOD18Lb79kte4GfTxShg9aG8wgrQYtAR/A/ns8z+
         oI3w==
X-Gm-Message-State: AOAM532kBn1X45e1PZBhmuyliuAZGDGP7Uu/xYC6X08ORDfp61xM/C2Z
        DeYPGtXlMGY+IRNGLIezknMFhoTqsc+eiJRKvztMSg==
X-Google-Smtp-Source: ABdhPJzj4EpS0DF6GeGIIzG6wrEYyiNCZPNgYURacgTLXK/M9PlUj+M9NiJF5oiaFyf3vVLmvLijuWlRoISHuow3Tr4=
X-Received: by 2002:a17:907:373:: with SMTP id rs19mr2489774ejb.341.1613875123282;
 Sat, 20 Feb 2021 18:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20210220215641.604535-1-ben.widawsky@intel.com>
In-Reply-To: <20210220215641.604535-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 20 Feb 2021 18:38:36 -0800
Message-ID: <CAPcyv4gfoe=QGuKV19ay51D-cqzRqTMLpD-p5whnJbYkKoGtBA@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: Fixes to IOCTL interface
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, Feb 20, 2021 at 1:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> When submitting a command for userspace, input and output payload bounce
> buffers are allocated. For a given command, both input and output
> buffers may exist and so when allocation of the input buffer fails, the
> output buffer must be freed. As far as I can tell, userspace can't
> easily exploit the leak to OOM a machine unless the machine was already
> near OOM state.
>
> This bug was introduced in v5 of the patch and did not exist in prior
> revisions.
>

Thanks for the quick turnaround, but I think that speed introduced
some issues...

> While here, adjust the variable 'j' found in patch review by Konrad.

Please split this pure cleanup to its own patch. The subject says
"Fixes", but it's only the one fix.

>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Since the commit is upstream add a "Fixes" line:

Fixes: 583fa5e71cae ('cxl/mem: Add basic IOCTL interface")

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com> (v2)
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan and I didn't pre-review this.
