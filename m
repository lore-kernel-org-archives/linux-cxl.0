Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8BC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Nov 2021 23:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171326124C
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Nov 2021 23:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhKLACk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Nov 2021 19:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhKLACj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Nov 2021 19:02:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD848C061766
        for <linux-cxl@vger.kernel.org>; Thu, 11 Nov 2021 15:59:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v23so5297754pjr.5
        for <linux-cxl@vger.kernel.org>; Thu, 11 Nov 2021 15:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t02UqgZc2QhnaS2krogft7UDzt5BTgan1OGAY6pK/vs=;
        b=Vie4JoLMrqgeF7o16WIe8gRIzXzPjqIe3wxTea4vBQBEtNfIFptF5eRCjDszp/Ythp
         yV+Gn5/ewyLPbuf2/+Mw5mMLZWej4/mLWTuY4xf2CsnK/0JC9/XluFe+Z+0Pfo6bW7nD
         10HS5itjeiKDGQ5t4PnVOZ1KDN0OdbivQStWaAzRc5YF4y8MUIcYR6iEVsgyUjbQ5yU1
         vgwQeV03meU5AhPpFDhoBY7hr46yMWQ45B5VHbNYARVcZHRSPbcUSuXlriCoSPMc43NR
         ClM0ww9RP+nJ28+AG+dqftrFpvtI5EstWE3gHmpwUKAlXe9UkMYTemEsJEp4b+TbGSMJ
         fQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t02UqgZc2QhnaS2krogft7UDzt5BTgan1OGAY6pK/vs=;
        b=12VXvv7b8AzcoSM90xlxMxcvR2YiEz+2BLFX6hXAF3DaU5/tevmyMRPN8vXltsOkor
         t1pdw2lbH+T8LE6FFQ2H2bghIVfrMWld/tWQccDgKkdySR9FB+v4y5nm9HOwPVxhOSEJ
         NEmwm/f1sBDFN1t+JdwLtzr1BSDIVzXuBhTLt1s6kS4BtvXfoWZtH2NoLouDnb9Rz1/B
         /MU0hQwBp5StqnDY5vzFId83ZsNpHhc+YnDFxD7HqE88TNZQHp0GfCdGucoLJ06tAjlr
         uffPkTDOkbM/nSQiHgdKjjQ1MbwpwO2F8e1VWlMwqlFPN8+OV2zOCyGlEx+FGLm/8gfD
         Y9aA==
X-Gm-Message-State: AOAM533DR9Fd5WsvKlr166R9l+hHSfbSUVNw+38+7ysXRvUxeYmLVGAz
        HMdjLTP440jBc2DaYR375eoz0vi5y+GESZyayG8PAw==
X-Google-Smtp-Source: ABdhPJxH7ufDXmgS0mxdiiqLRtOa0NuamwCZbHk26u8TebikwoL/r1wMBHOKYV/DV1sRWEpfHZBdrkaho9QLDaU11GA=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr3462762plb.4.1636675189483; Thu, 11 Nov
 2021 15:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20211111204436.1560365-1-vishal.l.verma@intel.com> <20211111204436.1560365-17-vishal.l.verma@intel.com>
In-Reply-To: <20211111204436.1560365-17-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Nov 2021 15:59:37 -0800
Message-ID: <CAPcyv4gLpfF_fahLJSw7BC4AkrU5pN+HeqA2E3Aj1+-iDGPZ-A@mail.gmail.com>
Subject: Re: [ndctl PATCH v5 16/16] cxl: add health information to cxl-list
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Nov 11, 2021 at 12:45 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add JSON output for fields from the 'GET_HEALTH_INFO' mailbox command
> to memory device listings.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  Documentation/cxl/cxl-list.txt |   4 +
>  util/json.h                    |   1 +
>  cxl/list.c                     |   5 +
>  util/json.c                    | 179 +++++++++++++++++++++++++++++++++
>  4 files changed, 189 insertions(+)
>
> diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
> index bd377b3..dc86651 100644
> --- a/Documentation/cxl/cxl-list.txt
> +++ b/Documentation/cxl/cxl-list.txt
> @@ -53,6 +53,10 @@ OPTIONS
>  --idle::
>         Include idle (not enabled / zero-sized) devices in the listing
>
> +-H::
> +--health::
> +       Include health information in the memdev listing

Let's include a sample listing here in the man page, like the
following, so that people can get an idea ahead of time about the key
names and value types in the payload. Other than that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

  {
    "memdev":"mem7",
    "pmem_size":268435456,
    "ram_size":268435456,
    "health":{
      "maintenance_needed":true,
      "performance_degraded":true,
      "hw_replacement_needed":true,
      "media_normal":false,
      "media_not_ready":false,
      "media_persistence_lost":false,
      "media_data_lost":true,
      "media_powerloss_persistence_loss":false,
      "media_shutdown_persistence_loss":false,
      "media_persistence_loss_imminent":false,
      "media_powerloss_data_loss":false,
      "media_shutdown_data_loss":false,
      "media_data_loss_imminent":false,
      "ext_life_used":"normal",
      "ext_temperature":"critical",
      "ext_corrected_volatile":"warning",
      "ext_corrected_persistent":"normal",
      "life_used_percent":15,
      "temperature":25,
      "dirty_shutdowns":10,
      "volatile_errors":20,
      "pmem_errors":30
    }
