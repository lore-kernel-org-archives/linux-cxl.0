Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC461C433F5
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Dec 2021 01:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbhLDBkr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Dec 2021 20:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354316AbhLDBkr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Dec 2021 20:40:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ABFC061751
        for <linux-cxl@vger.kernel.org>; Fri,  3 Dec 2021 17:37:22 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id r130so4555988pfc.1
        for <linux-cxl@vger.kernel.org>; Fri, 03 Dec 2021 17:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnFIiCAfjwH2tneD5e5OfQmaIQaNufqomoIGjDz8BsM=;
        b=ZwVABYxR+5hI6BNzHYdTO8uruWJBeK4TqpTRVgY2204Ky3sPA3iRTczg7W5EvfoOSu
         upYS/mfWN7O8cGQQeaqh31f+KDTCEbf5KWxQALQJ2s68XoO1af+CI0vMcDJlx+TuDzmF
         3UmRWiPdF5ZQdx/47//ZTvvnoysaBwQD4SopuRCVVG4pC3t6tNPO6ady/4RbZfJ0h6fM
         vBrjztd2OLcYkOtvB2+rGl/72sF4cf9F2soKV56ytGhkO4pYQYPXhD0IDgr5jWrEfDJf
         Gcvz8kIws2ejIP64BZU+NqJJM3Mp7+lNXkoHYCQFmDOFFSdp+P4HiLHfgKGisA1iLOVq
         YQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnFIiCAfjwH2tneD5e5OfQmaIQaNufqomoIGjDz8BsM=;
        b=z9nSmQpFhU9lcFEq+bmr2WK4GY2zALUFjvUA7ShOZg7bfu0anpsTvq0AD5Ej5s7GrR
         V4q5KAtaMfaedW5+WX7C4shg36Jlrzav97ERTeQF8D6NOf7pM5GqzTsQglFA7W5Eq+RW
         aVBsCB2g+LN+PEP4i6JVdREhwSogGc1KtWRWapXQsALIVJGtHCOshivD2vDsLh3dI2zN
         J8FggYrNS7tpL71WZOFsSxiNN2oX33rAEtnclvbJmH/IvWRTGZmalQNCjZtybwbTHZhu
         3BTFN86xMDEkAf9cjCQsREXPkgB7mQ+JVUOY0UlNawGGzayPio9IcMQNlpvmkiASjA6u
         MoIg==
X-Gm-Message-State: AOAM533BA6FMJgddubW/Gx51M99VfEhAhHae3ZK8najPr/3aua3Mf4H7
        z/S7FrmAsDBor3PhloygAQPnPFm0vQc7XD8DQRhTwA==
X-Google-Smtp-Source: ABdhPJxHUpVP3mnk20mIvNnhPfZj9KJVvEbIg+aEEhO5NivEHPCwibczc/JDQquTsy/yl2w40JUo4/I5YpAC49GBz50=
X-Received: by 2002:a63:5357:: with SMTP id t23mr7278783pgl.40.1638581842407;
 Fri, 03 Dec 2021 17:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
 <20211129214721.1668325-4-ben.widawsky@intel.com> <CAPcyv4iWNPA98x6GsOpeqF+11YeWgZternCJ0wgQtWOOknViSw@mail.gmail.com>
 <20211202172435.2f5hlz22cea4l3a3@intel.com> <CAPcyv4h-_bLrZKdSDEozK=2mPRnFsKPtg-iirx8qCEk6Kdk6-w@mail.gmail.com>
 <20211204011749.4pzpo5wfomarcpw2@intel.com>
In-Reply-To: <20211204011749.4pzpo5wfomarcpw2@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Dec 2021 17:37:13 -0800
Message-ID: <CAPcyv4iHodWFq5=k_n8dJYYKrNsUY5GYojoOzBhGf9TaAiiwBA@mail.gmail.com>
Subject: Re: [PATCH 3/9] cxl/pci: Extract device status check
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Dec 3, 2021 at 5:18 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> >
>
> It doesn't bother me much to do so, but it's not my preference. If you'd like to
> change it, go ahead and I will review it. When I wrote the original
> implementation, my idea was that command timeout and error conditions driven by
> interrupts (media issues, firmware issues, whatever) would be disparate paths.
> My belief is the spec allows so much latitude, extra paranoia makes sense.

I think device drivers are where the "only the paranoid survive"
mantra falls apart. Paranoid drivers fall over earlier than necessary.
I just picture Dave trying to disable HAL 9000, but can't even attempt
to send the mailbox command because the CXL device's media disabled
status is set.
