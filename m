Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CF5C433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 15:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEA86112D
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 15:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhINPng (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhINPnd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Sep 2021 11:43:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0175DC061574
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 08:42:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id f3-20020a17090a638300b00199097ddf1aso2513648pjj.0
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqrZf2RpvTXlUmbRyI2QxPTRCT62GWMUqprCb4O9iv0=;
        b=R68nkCIBgi4tzTf2MsQxydUGK5qmIiOepWBVPDzhpnm4nX8LXu58vXbtjzmF+E8byt
         8XTqcGe917Vrbpjr71mFbX1tJFns3YkzB9/rGD3J7a5+FdTugj8ONEIiiO6qXJqoBHX9
         lMoFuKn75vZN3Txje64yeqHoFnlU9Ukbjn3YJ0nvUIaMymTN1Hntmmw4vXFkudk/3fkl
         lOSrmvIwupDazVsHuXC7BSP/kradpQEU3rS2If8rC/6nrKUQTBunjN3/mwe1kRBUhr+4
         U9p7my/NY7OVuJXjqhH1E0g+jrvxwSqrNUUTAUKeqD29Tq0n8/de8TeKkBYA+i3hzDwD
         16yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqrZf2RpvTXlUmbRyI2QxPTRCT62GWMUqprCb4O9iv0=;
        b=4kEyM03bkwaYO8gTRJeVgnUbJd7Oy890Bz9KwQG+OplpQ6XvRG/7ODWYE40PXxiUeH
         Z0kJ0GuplO2aF+aQJdU1a1GJ1lbUSoctgziX9Ge1C6y+fWd9DhM8qWVQi41/G5BOoYZY
         SNopxg6qR1IlDPmzg5aMEYl4NSO6zvV9rMrpIWJEGc3pxRP2zKk4SeZWcUlTQITD+l8w
         hcjhG14Bdq0n3Phyl+szg44hiSCC/+5PWiWHPI/zc9rgxMyEIltz1DfFmDHR+LrO/cpX
         IGfQIjxJrA7EL/8ANlGAzWRm6jf1tCIfAfAR1KqTPyAHrdt6kqH/yyKGg8RA47MyBkVV
         0x3g==
X-Gm-Message-State: AOAM530WWoGom3J4GUVrNqyIOdxn/bjZnTAnYTVToQa0OC0JdO9/xhJj
        QdTfUTqN0+pMQ6PBelaboNKjvUlLGW63T+SvEO7cHA==
X-Google-Smtp-Source: ABdhPJwdSVBKoaQKVJDayqeNTdAmPJTaWf0sE3199v0xfH37WlYDE5QvLJk18AFTt9/gOMFZnUXlAkZMmBQ27SCKhmI=
X-Received: by 2002:a17:902:e80f:b0:13b:721d:f750 with SMTP id
 u15-20020a170902e80f00b0013b721df750mr15580149plg.18.1631634135572; Tue, 14
 Sep 2021 08:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210913223339.435347-1-sashal@kernel.org> <20210913223339.435347-4-sashal@kernel.org>
In-Reply-To: <20210913223339.435347-4-sashal@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Sep 2021 08:42:04 -0700
Message-ID: <CAPcyv4i5OHv2wHTO1Pdjz+qzAAWEha-7HdDdt42VyO_FasLSEA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.14 04/25] cxl/pci: Introduce cdevm_file_operations
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 13, 2021 at 3:33 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Dan Williams <dan.j.williams@intel.com>
>
> [ Upstream commit 9cc238c7a526dba9ee8c210fa2828886fc65db66 ]
>
> In preparation for moving cxl_memdev allocation to the core, introduce
> cdevm_file_operations to coordinate file operations shutdown relative to
> driver data release.
>
> The motivation for moving cxl_memdev allocation to the core (beyond
> better file organization of sysfs attributes in core/ and drivers in
> cxl/), is that device lifetime is longer than module lifetime. The cxl_pci
> module should be free to come and go without needing to coordinate with
> devices that need the text associated with cxl_memdev_release() to stay
> resident. The move will fix a use after free bug when looping driver
> load / unload with CONFIG_DEBUG_KOBJECT_RELEASE=y.
>
> Another motivation for passing in file_operations to the core cxl_memdev
> creation flow is to allow for alternate drivers, like unit test code, to
> define their own ioctl backends.

Hi Sasha,

Please drop this. It's not a fix, it's just a reorganization for
easing the addition of new features and capabilities.
