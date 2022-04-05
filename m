Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48D5C4167D
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Apr 2022 22:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiDEWNa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345304AbiDEUsu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Apr 2022 16:48:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1498CF1AFA
        for <linux-cxl@vger.kernel.org>; Tue,  5 Apr 2022 13:22:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d185so331557pgc.13
        for <linux-cxl@vger.kernel.org>; Tue, 05 Apr 2022 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIHQKyxUpgpxOWFNPXjTrKl0ddNnEy6g9QXsjbdAZCM=;
        b=d/Y6KZO9645gdnl4o3upqi/iG9kjHXCMROn5f+LebItqV4LN4zekkBGAIgaf4F8Yvi
         dZudafPooWwy8sgynVt4vyd56kL99iIvSunXkn+J15FpyNKUVZSaTCSTjOmONCsAU2Vx
         3MRqypy/kGoqtalGE7YwzrikMN9L1iUDe+bVxELbBw1yU1ussZxmNop3XCZFpbQcaMh+
         X2NjgLkMNsS8p3lgHQQ4MYafNqIk7bCo6pg/BYTeT12ogE0ipCprm09MR8lVQwH+vK71
         RQrmXn9GBx+pDmhBG5dTlkm/9I9HrfDR5U2nwHNQCPHCHP6wmxjaY8LP9L8GveM1CigB
         nm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIHQKyxUpgpxOWFNPXjTrKl0ddNnEy6g9QXsjbdAZCM=;
        b=0mWVtg1/l+30+aUs+aQoRZJXrnv+OXWCJn7Wudt5RupoD8U9AT60I7o5zMnpmfxAh9
         TfqdqAfKOIlmZDg/yAcusonYlgfWrICF4ikEoPai2j95MagVLh7jtkk37u/vgQpJBbd8
         2onrWi1SSlB8Jy9jmsGln/SC0+RvSJepeQthesDl8P6GtCqenCDefl1nxLixyNjRUPnP
         Vlyneey2SVr7HKVRTwNRyo49ogXAbiiMJLNvElsXApe01vtIx+NKGkuBjbXvL7LwwsJa
         NsXx8HdU8kEkH7BMldnlJkgJWuT77AWCj+WODqAN4W3oRkx7wc4f1x/sT7FXbXqRHDlh
         7gNg==
X-Gm-Message-State: AOAM533G//BWPceHZcbxgPUxSS8d4W4jn7hNO/lJbEEvg+t+du3AM6yk
        LMuvJJjkp6tpIjDlbEJSee0Pru0R46uQUWr8La7ZYw==
X-Google-Smtp-Source: ABdhPJygHRFzz79Dv7ynI/sD1a/ihGODe4mcJ8u3f/SfJGfUVLl6h8mn409eGbTIBdC8IEGgY5FI40jzYwbmSswzPlI=
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id
 g23-20020a631117000000b003992df07fb9mr4420099pgl.40.1649190173580; Tue, 05
 Apr 2022 13:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <164894751774.951952.9428402449668442020.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164918880566.2022733.9710638662231385597.stgit@dwillia2-desk3.amr.corp.intel.com>
 <SJ0PR11MB48956875FB15F900B5CF130BE0E49@SJ0PR11MB4895.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB48956875FB15F900B5CF130BE0E49@SJ0PR11MB4895.namprd11.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 5 Apr 2022 13:22:42 -0700
Message-ID: <CAPcyv4h=A4UKzjzQ5DAQFD66KnAU4F9MZRu6kGAgi6U3nX1hfQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: CXL: Disable suspend
To:     "Brown, Len" <len.brown@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 5, 2022 at 1:05 PM Brown, Len <len.brown@intel.com> wrote:
>
> Is it possible for ACPI to be aware that CXL on that system doesn't support S3, and for ACPI to thus simply not export S3?

The ACPI domain has a chance to be aware of CXL devices attached at
boot and were configured into the System Memory Map.

However, there may be caveats that limit device visibility like
platform firmware only scans CXL devices directly attached to root
ports, not behind switches.

It would be welcome if there was an ACPI data structure to indicate
"device-X is in scope for S3" which would mean that it has aux power
and all HDM decoders (the registers that enable access to CXL memory)
are restored by the BIOS before OS resume begins.

Absent that the OS can only assume that the BIOS has no knowledge of
any HDM configurations that were defined at run time by the OS, like
after hotplug, or configurations that the OS rewrote by triggering a
secondary bus reset to unlock what the BIOS had locked and put into
the EFI memory map.
