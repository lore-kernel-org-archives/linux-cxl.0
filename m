Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37785C4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386422AbiBHWZb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386473AbiBHUjK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Feb 2022 15:39:10 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAB5C0613CB
        for <linux-cxl@vger.kernel.org>; Tue,  8 Feb 2022 12:39:10 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b3so488936pfg.7
        for <linux-cxl@vger.kernel.org>; Tue, 08 Feb 2022 12:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8z1UZ+NMGTJbrhhy8yl4Lu6kb8svRF/BgAyYUwsEQck=;
        b=JCplgkUiO0PqXEIAJctgsTHYuyQcLQD9TAxvLBFbCOx/ffKySRHbjX3hMHycW9DbzW
         c3tnEXiCa93KHVdCd4LaxXUberXsBLk0De/HQxNR94sxJR+LYpG1H+4h5wEQFjF9dV2m
         Ve94cbvDFFFLJaV65Y5EWshPOG4Cxb/yAGlZ+TZDbkux52MS4LFtR0RPRZMj6N+tp+qP
         7ZIB4vYAsoGSKj4Z/8CFeuEwI28Uo1X1yG5mr2rw2Cm4+OBsVarMUtrEJkDmJ7vcbbYy
         C4BlUIhEu6jYWmwvGa0rtkI9VFM74pLkwjmff5pD8vU7QIwdOtfilLEDL5YQk8QE223G
         rUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8z1UZ+NMGTJbrhhy8yl4Lu6kb8svRF/BgAyYUwsEQck=;
        b=kiepbsVo9Jxo2HjxcZrN6z5JHxNmvn59BuQLcDrxe7D4UYFALD/dmkMTaW78PeqBN2
         cxQojOaHADBKdanigNIqiDPuu2cLIrh9DK/TXCeLKltOH47R0Vsre3zZ8Z/q/DbJ5alY
         CIjfpu9sA6GmpvGxBJlLuBaIdzzBqxfL+yoCeHUcIq9Z3HmUDcytaO+pnl4JbUMb/LAf
         k+qN10ItxTDPPMPNUOXH9uWtI2pAZDtS6KCX6jhn85YX/biNYLg6j6kEtv9I8s+CHbxU
         yHocJfRTozRApxCVsOSauwicoETDv4LIoqVUYyIQ8lmg/wR5VaqiOVyn/LsPdJ4lh6q9
         Xj6g==
X-Gm-Message-State: AOAM532r2bjdVzpDP1dhFT2IQkGHTuIbcyg2XbxQ8adg1rFZsfJSuTbx
        a16RNU1P58Qa2+Fxxe1qvzB4NqraZ84llu7KQiKV9Q==
X-Google-Smtp-Source: ABdhPJy9d+7BY3Bsjz2Hj3HgFNIB1RuqdywF3tAVcSEa8HJnwuAdoazt07ZbmQJoFKi544/yr+Z+PUXG0INlvVDBKZ8=
X-Received: by 2002:a63:4717:: with SMTP id u23mr5001209pga.74.1644352749567;
 Tue, 08 Feb 2022 12:39:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644271559.git.alison.schofield@intel.com> <fad634a7912265e87a8e7f3c3c9db21c1494d9ad.1644271559.git.alison.schofield@intel.com>
In-Reply-To: <fad634a7912265e87a8e7f3c3c9db21c1494d9ad.1644271559.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Feb 2022 12:38:58 -0800
Message-ID: <CAPcyv4iA-491r-c+j_-vuxRvkOB0vhW=Sm74Fa+M4WsVLUobGw@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 3/6] libcxl: return the partition alignment field
 in bytes
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
> Per the CXL specification, the partition alignment field reports
> the alignment value in multiples of 256MB. In the libcxl API, values
> for all capacity fields are defined to return bytes.
>
> Update the partition alignment accessor to return bytes so that it
> is in sync with other capacity related fields.

Perhaps a note that the expectation is that this early in the
development cycle the expectation is that no third party consumers of
this library have come to depend on the encoded capacity field.


>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  cxl/lib/libcxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index e9d7762..307e5c4 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -2306,7 +2306,7 @@ CXL_EXPORT unsigned long long cxl_cmd_identify_get_partition_align(
>         if (cmd->status < 0)
>                 return cmd->status;

Hmm, I like that this function does "if ()" instead of "? :", however,
it seems it also needs to be fixed to return ULLONG_MAX in the error
case. The status will otherwise be misinterpreted as the alignment.

>
> -       return le64_to_cpu(id->partition_align);
> +       return capacity_to_bytes(id->partition_align);
>  }
>
>  CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
> --
> 2.31.1
>
