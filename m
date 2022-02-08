Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C37DC3526E
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiBHWZq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386511AbiBHUrD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Feb 2022 15:47:03 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A68C0613CB
        for <linux-cxl@vger.kernel.org>; Tue,  8 Feb 2022 12:47:02 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z13so572002pfa.3
        for <linux-cxl@vger.kernel.org>; Tue, 08 Feb 2022 12:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtnqUgSIa3X/cpdmfWa9zlW2f1lwuqSEBAfSPO0aEM8=;
        b=qFbqJVX6C4eNHu4MYEFs0PGNyXPEx1waVEVM8nBKinW0gK8K961vSFpJV0XNEjDxRZ
         Sjmv1Vt1D+QSoPnLs1dUXxGs9hLLTIxbd9jvDxJSnFpIAyhSNrRsYBbCTWozZWNkIhAX
         +P0brg01k5EZSm4PvmZWhzH1JrnqOPMHbJxxTCS313mCWyhnAzu5vJSDV0Q+9R2uCdEE
         Uem16fG+jCk4JjeZUcLuuTIKw0kG65N4uEsGhOwvWme28ogXQo8Zwvjsd95X/0LpsHD2
         HgTk8Itp9fTHKqOrIk9R0yD7VwgkBAW/56faO4HwRRamEhBLvwuGw/XPlp67RusaVgMs
         SJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtnqUgSIa3X/cpdmfWa9zlW2f1lwuqSEBAfSPO0aEM8=;
        b=vN4hIjywMA1wR41Z09+9vYZvSJnq1byUD/01VUjajbz5U2gRVPEGbDfAk9noJDbsbF
         6paD56my6kEjkq7qkRsy6GQ5m5I9DAXpTFoXlFU/PZ2PnBSCmxbPsLjwbXf3A+bNFMXJ
         N0uGYFBBo3tTcZKSGuFq+kvOKg1FjJwTJqcGQ7weBWsxndiIRrIRkGPJdW5bTVKd0zol
         Ud7mnChivbNpaRIFbEpogIsXQKpNyV1MOmgwe9pLl0iZvghycftrR2z/F23x/nnr2wTM
         RvBkrOK5I00Pgp4BNsMTzUaAWXK1w3o0ddljyy/Yt6e9DZd5p+ZczUZdkMzmfuPZtMaE
         Kjlg==
X-Gm-Message-State: AOAM531zI5yA89VT5bv/Su8cS7lRemjIGyx+6knQd0BmO2QyaO0GnyXn
        aJ3SRxMbfTjwkizyc/y+8I6iGmExaVHWuFpOvKim0g==
X-Google-Smtp-Source: ABdhPJxtlz9vwgaxefg+HZgHOLCqaC/jJaP2FkkSmJTG56MULfKP//dedb0UIiIO9183wWHyKPvWk5rx7It/XimTRek=
X-Received: by 2002:a63:4717:: with SMTP id u23mr5020649pga.74.1644353221741;
 Tue, 08 Feb 2022 12:47:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644271559.git.alison.schofield@intel.com> <7d1ebd8316584d065133ab7343e14eba2810f98e.1644271559.git.alison.schofield@intel.com>
In-Reply-To: <7d1ebd8316584d065133ab7343e14eba2810f98e.1644271559.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Feb 2022 12:46:50 -0800
Message-ID: <CAPcyv4hcTto3Aza_BTrczu_y6G7Ffh4F2Mx=ZR1NyOfCwhaHyQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 5/6] libcxl: add interfaces for
 SET_PARTITION_INFO mailbox command
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 7, 2022 at 3:06 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> Users may want the ability to change the partition layout of a CXL
> memory device.
>
> Add interfaces to libcxl to allocate and send a SET_PARTITION_INFO
> mailbox command as defined in the CXL 2.0 specification.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/cxl/lib/libcxl.txt |  4 ++++
>  cxl/lib/libcxl.c                 | 28 ++++++++++++++++++++++++++++
>  cxl/lib/libcxl.sym               |  2 ++
>  cxl/lib/private.h                |  8 ++++++++
>  cxl/libcxl.h                     | 10 ++++++++++
>  5 files changed, 52 insertions(+)
>
> diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
> index a6986ab..301b4d7 100644
> --- a/Documentation/cxl/lib/libcxl.txt
> +++ b/Documentation/cxl/lib/libcxl.txt
> @@ -132,6 +132,8 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
>  int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
>                            size_t offset);
>  struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev);
> +struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
> +                                         unsigned long long volatile_size);

Perhaps a note here about the role of cxl_cmd_partition_set_mode(),
that the default sets the partition for NEXTBOOT, and that IMMEDIATE
support depends on the device being inactive in all regions before the
kernel will allow the change?

Otherwise, looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
