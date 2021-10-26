Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AA5C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Oct 2021 01:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7256061057
	for <linux-cxl@archiver.kernel.org>; Tue, 26 Oct 2021 01:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhJZBMD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Oct 2021 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbhJZBMC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Oct 2021 21:12:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58019C061745
        for <linux-cxl@vger.kernel.org>; Mon, 25 Oct 2021 18:09:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r28so8083583pga.0
        for <linux-cxl@vger.kernel.org>; Mon, 25 Oct 2021 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCITFXxjqJeB6n9UK+yDG2f7cPRezhP5HHhiolMiCjM=;
        b=JBXGkcPdrfcD4ZLvACue6+5w79HWmZ5QfYlCap/SBqJF7MxgoRWbZiHXC3rMjgFOdm
         xcyPi/Xv2fX1ZOkShXNBB/JUsQb6jQKtJjBR3DOSiEwSiHiCm7nPlATmlkHmuFxRrbyP
         HsEtRw/S4+olKzmaMeMxOZGdSQLzBilB947JAnjba1ahavrOcmSSENqbCVjUZl4QnDFP
         p5sHQQBv6X50k9hkOa5A6dX4K6vSlJYcnOZ+t6JT8o5Zw83k+M+xhNSjrzCTy8EAGI2P
         t7yCVx67FuTLtAWpU7THQfwWPRudxaywAT6j1qShjxbeCd8pMz8hiowqsbkPYabOZQqv
         s3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCITFXxjqJeB6n9UK+yDG2f7cPRezhP5HHhiolMiCjM=;
        b=2O+Y4ybvF8AghSBbZJdljfPJacrmLxKMnNbmoE7WIMh9ksb1F2BGWIADzzpM43HmrC
         mK52X5ou0WDUVA+vh8mtd3zLuWj1G/pWvRfNUaDWi5W+ypGWCZlyeM48ZyGS0AUJS36X
         Q40rVhG8Oj62F97CH8Swq8OPm1O9iA7Z+oFeSmjpyTU7lhPSJqV6RUi2ErQATQ6gNsRL
         akYmiLxWPbw3jrvhIdJB9qK0f//1+mexkIK2682eAJYV4E1sGUIbui4cUaAeq/Vufp5F
         0BW3FXZvxrG3HSeqscRzWekfYYjEMeXdvYf1Uhdb4OW1gj92uRT1+k5z3dbSMeCP9MkY
         O/NA==
X-Gm-Message-State: AOAM530XSgMYvkSPhTvkkLxJNzcLE7XdTGX/GxZK5tjL6DtEZu6w4UgI
        BOKzsQOUeO2uEEnTpUCpfKNA1bPD51pGUl5MnPA+Kw==
X-Google-Smtp-Source: ABdhPJzvw8ppRYYrix8vcKQPtLZcUG4WuboObsoLWJSvOV9abVZFP6b3AzXVf1ZbdG5asXureWAlsVrxm5slsUtmYWA=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr21917427pfu.61.1635210578889; Mon, 25
 Oct 2021 18:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211019050908.449231-1-alison.schofield@intel.com> <CAJZ5v0h3vwrNQrs8F5KQcFoNy+KyAfg6k99cwTO19g-ra7kzFQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h3vwrNQrs8F5KQcFoNy+KyAfg6k99cwTO19g-ra7kzFQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Oct 2021 18:09:28 -0700
Message-ID: <CAPcyv4jymqC5GG36YAZmoB-xm-cPdTsHkpnzGvM=mzJDYi7oHg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: NUMA: Add a node and memblk for each CFMWS not
 in SRAT
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Oct 20, 2021 at 8:27 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 19, 2021 at 7:01 AM <alison.schofield@intel.com> wrote:
> >
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > subtable may be assigned to a NUMA node. Since there is no
> > requirement that the SRAT be comprehensive for CXL memory another
> > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > in the SRAT.
> >
> > Use the CXL Fixed Memory Window Structure (CFMWS) of the ACPI CXL
> > Early Discovery Table (CEDT) to find all CXL memory ranges.
> > Create a NUMA node for each CFMWS that is not already assigned to
> > a NUMA node. Add a memblk attaching its host physical address
> > range to the node.
> >
> > Note that these ranges may not actually map any memory at boot time.
> > They may describe persistent capacity or may be present to enable
> > hot-plug.
> >
> > Consumers can use phys_to_target_node() to discover the NUMA node.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>
> Dan, this seems to fall into your territory.

Rafael,

Sure, I'm happy to take this through the CXL tree with your ack.
