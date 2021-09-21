Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7BCC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 22:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B57060560
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 22:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhIUWaC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhIUWaC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Sep 2021 18:30:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067F6C061575
        for <linux-cxl@vger.kernel.org>; Tue, 21 Sep 2021 15:28:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q68so529826pga.9
        for <linux-cxl@vger.kernel.org>; Tue, 21 Sep 2021 15:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xYHhkXmeAvv+RY+cKqcor3N4uuoLNJlnXiEQlSjFsqU=;
        b=Da7pK6yz4uDmfwgTxVCMuOmJbOAbU8yl7DvPGaO4REDOmKxFKjiZ6fYNzWaxgCnJlj
         B8tZlVv48PdL266f7kYazi+9TxivKTKDtc/gWUxURHPqGBEPmSEsoV7/Aft6gPCxKUIK
         BnFMFw+iZZ1TMQuJ1U+T1RaI1BC/MEYoR+fF8Imtan0GYsv7IOm15ldHU+t3zcDZqwMw
         Pu3pG7VXdIIX5dOrAxr8U/0k9Bq9mj0XryxPRkEz7C/EGEjPHBBbssLemB7XKG5exm0Q
         f4u6kpv94gAhLhqfq1fyVnzc+nXo4WY4QaH8VvtDCpTnc+y0DTLm+tM2102gRHYDjjU3
         7pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xYHhkXmeAvv+RY+cKqcor3N4uuoLNJlnXiEQlSjFsqU=;
        b=jmf75wCKNSQrR6DGcZfSQVDoplN+7Iz18HfL2GPD+3TEycNlXWDpBUNZXcJP8yjNkb
         IILGIWM9wFJ4Izpk8Qym9xBcOv4btE2UpetTi8uYJ4tPkIyzyq8EnRph9BFFLuP9YH9p
         PWuxyrEOFiDBDjTaP1QAVSZ22cjRfGbHjSh4l+HERrpX7Cj4G4EmVtB6ciujiw2I7xgi
         tisOoRa8dXOACv96rtLrRiaEVYdJok/H85MCqTYXg6giWPBmD9yUPB7buYCCvcXjzVr3
         Oum/0SAt+PKrJLvnhmpXJq9rmyeLE3yaZZZyO/rni0Tj2T5svyCqWYPvbf9jDs5ue1Cn
         JywQ==
X-Gm-Message-State: AOAM532PVABp04q/S+VPaFzyU3zRp8wQbCZsvcUSvc8xMeVlsP5Z8/fn
        +nU0XK8+ySgEwjk8Rf173iW0bOZ0tMhIxE/ds+oBvg==
X-Google-Smtp-Source: ABdhPJwk34nzb0W2HUoVAKlIDBHKPa3Z5iX5LW3la4BVxDEwamNN3EVylrWns1SpDPC0evltrHTDcPEqM8F5wWORoII=
X-Received: by 2002:a62:1b92:0:b0:3eb:3f92:724 with SMTP id
 b140-20020a621b92000000b003eb3f920724mr32904283pfb.3.1632263312473; Tue, 21
 Sep 2021 15:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210921220459.2437386-1-ben.widawsky@intel.com>
In-Reply-To: <20210921220459.2437386-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 21 Sep 2021 15:28:21 -0700
Message-ID: <CAPcyv4jyTDWGAUOmkumHBAN6K9t1c9hcCt6hCTo4POSybMOMSQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] cxl_pci refactor for reusability
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 21, 2021 at 3:05 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Provide the ability to obtain CXL register blocks as discrete functionality.
> This functionality will become useful for other CXL drivers that need access to
> CXL register blocks. It is also in line with other additions to core which moves
> register mapping functionality.
>
> At the introduction of the CXL driver the only user of CXL MMIO was cxl_pci
> (then known as cxl_mem). As the driver has evolved it is clear that cxl_pci will
> not be the only entity that needs access to CXL MMIO. This series stops short of
> moving the generalized functionality into cxl_core for the sake of getting eyes
> on the important foundational bits sooner rather than later. The ultimate plan
> is to move much of the code into cxl_core.
>
> Via review of two previous patches [1] & [2] it has been suggested that the bits
> which are being used for DVSEC enumeration move into PCI core. As CXL core is
> soon going to require these, let's try to get the ball rolling now on making
> that happen.
>
> [1]: https://lore.kernel.org/linux-cxl/20210920225638.1729482-1-ben.widawsky@intel.com/
> [2]: https://lore.kernel.org/linux-cxl/20210920225638.1729482-1-ben.widawsky@intel.com/
>
> Ben Widawsky (7):
>   cxl: Convert "RBI" to enum
>   cxl/pci: Remove dev_dbg for unknown register blocks
>   cxl/pci: Refactor cxl_pci_setup_regs
>   cxl/pci: Make more use of cxl_register_map
>   PCI: Add pci_find_dvsec_capability to find designated VSEC
>   cxl/pci: Use pci core's DVSEC functionality
>   ocxl: Use pci core's DVSEC functionality

I also found:

siov_find_pci_dvsec()

...and an open coded one in:

drivers/mfd/intel_pmt.c::pmt_pci_probe()

This one looks too weird to replace:

arch/x86/events/intel/uncore_discovery.c::intel_uncore_has_discovery_tables()

In any event I'd expect this cover to also be cc'd to those folks.
