Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC18C4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 16:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAEB60E97
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 16:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhHBQKo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHBQKo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Aug 2021 12:10:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA48C06175F
        for <linux-cxl@vger.kernel.org>; Mon,  2 Aug 2021 09:10:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nh14so14102397pjb.2
        for <linux-cxl@vger.kernel.org>; Mon, 02 Aug 2021 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jspHBudRfzdrlHrBvbR4p9Ux59bIBnk02oaIIv6lh4k=;
        b=ytkwLKXVBfLyehi3GnxAkGfnNrEFobu1KUc5krYhkeEueFYXHzjhIuxuOjuk19Jobq
         QW73+O3iR3ZGA6NXjWYAGwFZgBoKCSfplWZIqMepRpavl3z9bSPw3R7iT973ZzVwtt4D
         WUpvQ92VnsPvj36r/t/VhWT+B4qZGYEtXYdqkcHjph/x8feWIlUMsRg8GUna7zy+cRl4
         JnGTEhVrl53hr37djd3G/KH/Zr4fEUjZ6WOgY4mAZeiG/6u002AaEMoliEYq/q807yTD
         kXMc98Rapp+MgwdGDcy796lGswkFK9TsEHePm/U7kA0IJB7DCKfmCl3V1n+BQHrbh+dK
         +43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jspHBudRfzdrlHrBvbR4p9Ux59bIBnk02oaIIv6lh4k=;
        b=Diug5YYrssHcrU4wwGeTjv8ZIhfCeSdJ5lRyfQisehTUZ56nVFwN6ZNxP+5XXozRFO
         F86KYpkhgDU+zduIVH8L+Sqvr5AbKsEVDUiP9yW7QqF3WVSejU18d0py7WtC+5+J7oMD
         zUJKHtXJCasDmvHS1EFk5oiGFbg5Yx4qO1/EZOU9mh3s4o/vl6/7mwq9dYMQwUWJst27
         Uobwr3B3KvI9fiwkgv/Tje4J9thqsdyCuLMW3e1J8UlrNnVp6xBU+Au1GMA/N05kfSVX
         PEwYm85+dZf+1rHZki5l3uCrcUkBbxmmNXOVjUP01NQcK4iJ1K8yhp3hoLxdN5zeEG/I
         8QkQ==
X-Gm-Message-State: AOAM532AwpEL6WDAT54kw5S8wgWxB7t/CXqFBOKN4eBGuSIQUYN+iogn
        x2u7QvmEKtAgdtUZQ2ub+c/xhYy9o7tgjbIWk/hCVg==
X-Google-Smtp-Source: ABdhPJwXNtP925YdT+1n8XZEhKW+CV3DqCnI6x6S9jNP/5RJQUjxkUr1FJhQIis78D0lGcRg1bCUf7vPEcPjBBDH440=
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr18432474pjk.13.1627920634114;
 Mon, 02 Aug 2021 09:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210716231548.174778-1-ben.widawsky@intel.com>
 <20210716231548.174778-4-ben.widawsky@intel.com> <20210802165656.000036f0@Huawei.com>
In-Reply-To: <20210802165656.000036f0@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Aug 2021 09:10:23 -0700
Message-ID: <CAPcyv4jQ=jSOzcyt=0JCn_sSBQEo+23taG4O-QPU9xwTjUKw5w@mail.gmail.com>
Subject: Re: [PATCH 3/3] cxl/pci: Retain map information in cxl_mem_probe
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 2, 2021 at 8:57 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 16 Jul 2021 16:15:48 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > In order for a memdev to participate in cxl_core's port APIs, the
> > physical address of the memdev's component registers is needed. This is
> > accomplished by allocating the array of maps in probe so they can be
> > used after the memdev is created.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> Hmm. I don't entirely like the the passing of an array of
> unknown size into cxl_mem_setup_regs.  It is perhaps paranoid
> but I'd separately pass in the size and error out should we
> overflow with a suitable message to highlight the bug.

Agree.

>
> So far this code is also not justified by anything using the
> array now it's been moved up a layer. Looks that doesn't happen
> until patch 22 of your large WIP series. I think this patch needs
> to be in the same series as that one as it doesn't stand on
> it's own.

Agree, I'll reorder this change to closer to where it is used.
