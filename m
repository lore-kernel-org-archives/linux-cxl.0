Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF67FC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 22:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB49860EB2
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 22:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhJ2WZB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 18:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhJ2WZA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 18:25:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB33BC061570
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 15:22:31 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 75so11156076pga.3
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2/oc+pwbfitG9GrYtF9f+oobz21VyLR8dcpa/GWX+c=;
        b=6MH+vpPa3F288v0BOWfJ9gRYHoVucwuhvCPyEUC28sgNZUAbt1PkAhF52MeollUM30
         krdjSScaf0V/DBALzRqZgdIdFTrL7t6I+uyGWMey1RCLZ0CzV9KmD+NJeZxZ+ulF/ez8
         SKqsRy1QvdHhqs+uGzFtBLcVp+1wWVtqu1WKXI81owMxSktkaV7E03OHo1vx9htuazP3
         6TVmDo3ctMPvp5X/n1rlfunEvcSXhJGIFwefvhY5dsq26Jo65vD7JQWnnsuhATg3lbtR
         yPSZiBCdyhj4vtzvGhxpG0ZWY36Mhui4xDqn2nIx+itSrrkHi5nIYg9ooR1TdwpUZVwj
         eIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2/oc+pwbfitG9GrYtF9f+oobz21VyLR8dcpa/GWX+c=;
        b=iklqNDRLTfB85j0szEsMIxVL3a1QCT2pPLhmmesywIAor2EOdaOcR9iy6cfLe2MW5a
         6FNpadgGbZH+1yOe11TctLI6Mp/qa/XmoCJv4lEdT4bmrqMEfUxlobsil4rKuh2Twu5R
         eEwiEPhUxHXr0QzD8f3uQ45mz2bly6080Mgqogze8n1thZ435YNSmxv9+u96vW7nP30Z
         8ltKTZTvnwaLcqSBa3BO4xZ7CkCwrp3dEl9Y0/AZIsuC8dPI3h82MTZGG/pV0rAIUiQU
         YJn023GhjbJ9bS89i6SNoCTnDyVyqu+LV2spDXdTzN3iTnbVW4fDJ3D0vipoKXfWypo6
         iIXA==
X-Gm-Message-State: AOAM5311ejIOO2tnR3BjIGOq+ZqWq5MdhBsy1S/CczC2izRbvdjR17Iw
        WvR1OuCFMHspnNWRHrMJor7rem6rBfNzn32ylYgs4w==
X-Google-Smtp-Source: ABdhPJwWGo25N2CqaNcJlDrH72sBQ9OoqPArJ5Xm4iEzHrBYbsjsXZWOhTZ9Zfz7V8c17dnuJv6io8/Q9PsDtUby/Qk=
X-Received: by 2002:a05:6a00:1348:b0:47c:e8f1:69a3 with SMTP id
 k8-20020a056a00134800b0047ce8f169a3mr13815748pfu.86.1635546151355; Fri, 29
 Oct 2021 15:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-6-ben.widawsky@intel.com> <CAPcyv4iiR_HT_9ExRvgLixWnQg8y-id1zpmRYurFSfw3OiVaYQ@mail.gmail.com>
 <20211029212654.cnge45a3tj3abj4s@intel.com>
In-Reply-To: <20211029212654.cnge45a3tj3abj4s@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 15:22:19 -0700
Message-ID: <CAPcyv4idbq0+VjHRLPVDjhDF6pH1GtqBJeNNTo-7USPLq+aUBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/28] cxl/core: Convert decoder range to resource
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 29, 2021 at 2:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > Note, this is just how I had it roughly mapped out in my head, I defer
> > making it a hard recommendation until I get deeper into this set to
> > see if we diverge.
> >
>
> You're correct.
>
> I had changed this already for my v3. I ended up with this:
> +       union {
> +               struct resource cfmws_res;

"cfmws" is something that will only appear on ACPI based CXL systems,
so if it needs a prefix it should be something that does not preclude
CXL on other platform firmware architectures. So, "platform_" or
"root_"?

> +               struct resource *decoder_res;

So the region device is going to be doing the __request_region() from
@cfmws_res, not decoders, so why is this a resource and not a range?
