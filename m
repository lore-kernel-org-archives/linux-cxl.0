Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C40FC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 20:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649DF61166
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 20:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhINUWN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhINUWM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Sep 2021 16:22:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7348AC061574
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 13:20:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x7so443451pfa.8
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNZ9Eucd9G+Wpg6mKI84OVcJiAxN609jDplW1E3/3zE=;
        b=1hFjuNeE4PxXtkMK9tfIhZrKVxHj3tlm3YOmtpF7pIY3EYuJ4fuQMuM+xcCs5/DThN
         7eljkmSZU0YK4tvxVQmiLYRWc2go1+cbv0aCjgb11YVfpOn0HhWcSEzvwCUyV6KBVii7
         dpZadXqEB0q9r+pUAW7H9iegcHV7nmlLpKB+//JhrucLz/a7UcU55zK/Ef1VaAG9MIgv
         T1CsPLambiZz1ItFhLRDZ3nUS95d1fmwsfneSy5wPOTnxIVEKqUkfB7rxROktVvAyFWT
         wDMSHSpu6HV4higmK52ZQqKfYMLyDQxB+PlFTSmoczRpaghnjIzz/tZuBENh1+uCd520
         I/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNZ9Eucd9G+Wpg6mKI84OVcJiAxN609jDplW1E3/3zE=;
        b=idnsnuahqLO9QmN7GODmnUVbBKuKiv92h0SdPKpWrCbs5z5yuGUgmJnea7aDv2dxf7
         FYfX+sRfQFqhnnO7l2PZGZUMhfM8ry570EyewzTZ0SYqWV2XriyrmLA06zHosUtFGt3N
         u1M8+e8/4fMk5lfN4brqtUEw+kPCACI6qwOpFSvdsWlfoZL8Sdy5eobYpJqOg6gmmQZr
         HXpbwk1HnhyG0LkgxQrHar4Wz3BRUPEfQ1NY55PhQ9cRxwCa6zNnE5YWqSeOsWQAmCZl
         r7Ie1/c+x/FuEqvXa4Ve9TsOtAN05XD2NSrQBvDoKfj3JQ858krbtBqNB+6FUMw+Ge/M
         RGMg==
X-Gm-Message-State: AOAM5328alMyocFzF20vdLM8hVvkDw1aNxZ3LipVJVqYmza10FjUXI31
        IV3dfSpjDPZgjtnFiPEtRmyToAn8C6SB+HOG/k1NWA==
X-Google-Smtp-Source: ABdhPJyqaEygTAG1IwQVgM0rjoQHvjJ+o9kUsgW+nlvcNezGwVLIwhwKlOrt4rn6qkCqrftpvIsj8jRXgFkekPZvo9o=
X-Received: by 2002:a63:1262:: with SMTP id 34mr16934593pgs.356.1631650853943;
 Tue, 14 Sep 2021 13:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <YT9kSHU+P5wrnm2S@BigDog.local> <CAPcyv4gY7UvT7fkCcvxGwe7-s6r40rFExwLN2oc7xBtMGdRyAw@mail.gmail.com>
 <0100017bdf9fcce1-400920ad-2274-4d39-b45e-45410426db50-000000@email.amazonses.com>
 <dd56f465-560e-9408-d7e6-9f8de59bc792@jagalactic.com> <CAPcyv4hjD=1EEAkjx+r3DRxASCGpF45kOyOZVULsMDekyG6TYQ@mail.gmail.com>
 <0100017be5e140c0-cedfdc46-26b6-4009-899f-8dfb2268af2e-000000@email.amazonses.com>
In-Reply-To: <0100017be5e140c0-cedfdc46-26b6-4009-899f-8dfb2268af2e-000000@email.amazonses.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Sep 2021 13:20:43 -0700
Message-ID: <CAPcyv4g-t_kY84TSq6WbWP96hjOupXx1KYtB9XznQ4y2NooXWw@mail.gmail.com>
Subject: Re: CXL 1.1 Support Plan
To:     John Groves <john@jagalactic.com>
Cc:     johnny <johnny.li@montage-tech.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        John Groves <jgroves@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 14, 2021 at 12:56 PM John Groves <john@jagalactic.com> wrote:
>
> On 9/13/21 2:08 PM, Dan Williams wrote:
> > On Mon, Sep 13, 2021 at 7:46 AM John Groves <john@jagalactic.com> wrote:
> >> On Tue, Aug 10, 2021 at 8:21 AM Dan Williams <Dan.J.Willaims@intel.com> wrote:
> >>> On Tue, Aug 10, 2021 at 5:24 AM johnny <johnny.li@montage-tech.com> wrote:
> >>> Hello,
> >>>> Current CXL patches [1] focus on CXL 2.0 support. While in the real world,
> >>>> CXL 1.1 capable host and EP are the first CXL components end user can use. May I
> >>>> ask community plan on CXL 1.1 support
> >>> The expectation is that CXL 1.1 is BIOS / platform-firmware supported.
> >>> Just like the OS does not have a driver for DDR and relies on the BIOS
> >>> to describe DDR resources via generic ACPI tables, the same
> >>> expectation holds for CXL 1.1. CXL 2.0 explicitly adds features that
> >>> exceed what platform-firmware can support with static ACPI tables.
> >>>
> >>> Something is broken if the OS requires a driver for CXL 1.1 device
> >>> operation, at least for the generic memory expander use case.
> >>>
> >>> Ben did have some improvements to lspci to dump the range registers of
> >>> a CXL 1.1 device:
> >>>
> >>> https://github.com/pciutils/pciutils/pull/59
> >>>
> >>> ...but it does not seem the pciutils project has accepted that work.
> >> To probe a bit further here... On a system with a cxl 1.1 memory device,
> >> we see that bios maps it, but even though there is an SRAT entry
> >> describing a new NUMA node containing the cxl 1.1 memory, the memory
> >> shows up as "soft reserved" in the e820 memory map. And we observe
> >> that Linux (5.13 ATM) does not use it.
> >>
> > Looks like I need to improve the documentation here, please review the
> > attached patch and let me know if it answers your concerns.
> >
> > In short, Linux *does* use it. Soft-reserve memory is accessed through
> > a dedicated device-file interface called device-dax by default. You
> > should be able to run:
> >
> > cat /proc/iomem | grep dax
> >
> > ...and see your address range. I.e. something like:
> >
> > # cat /proc/iomem | grep dax
> >     340000000-43fffffff : dax0.0
> >
> > ...and then /dev/dax0.0 can be directly accessed via mmap() (subject
> > to device-dax's strict mapping alignment restriction (default 2MB)).
>
> Thanks Dan! This plus the doc patch clears up a lot. I'm able to map
> via /dev/dax0.0 now.

Great!

>
> I built the cxl-2.0v3 branch of the ndctl repo (had to find source for
> kmod, which isn't packaged for rhel8?!).
>

That doesn't sound right...

# mock -r centos-stream-8-x86_64 -n --dnf-cmd whatprovides kmod-devel
[..]
CentOS Stream 8 - Extras
  19 kB/s |  15 kB     00:00

kmod-devel-25-17.el8.x86_64 : Header files for kmod development
Repo        : powertools
Matched from:
Provide    : kmod-devel = 25-17.el8

kmod-devel-25-18.el8.x86_64 : Header files for kmod development
Repo        : powertools
Matched from:
Provide    : kmod-devel = 25-18.el8
