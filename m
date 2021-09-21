Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3ECC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 20:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4599461100
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 20:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhIUULa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Sep 2021 16:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhIUUL3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Sep 2021 16:11:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F40C061574
        for <linux-cxl@vger.kernel.org>; Tue, 21 Sep 2021 13:10:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p12-20020a17090adf8c00b0019c959bc795so490292pjv.1
        for <linux-cxl@vger.kernel.org>; Tue, 21 Sep 2021 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KH/kKXlPapxERxri3iYFJat8Wjjpq/bYtPaYTiMH5Ck=;
        b=lvXxDLk93HVkcX27/I5yF7q8MTeR97jquCl5BFdLLG0nhEtG4+fQZEMq61Q+NY7ZiH
         uJVif5oNBnQr5qFFt+tEt7c1tRjoo3K0Vq0Puwzh6+HVcklXRtmYXU35rrKXicbr8rG1
         RZ8m08b2ZxagnwoLDjfJGIbAPZ3/U4af5Tt7DNvFHSs4VHgVnUekgt4Q5qrOPTFxKzXg
         an7n6FUEt58UzTmZ4vm/ksPSdTc7AJnLD8bADT8MTJD+UnLaH1jbzhysUSI1ICkkdyKV
         j7I0CFIuL7clthHp2S+/jbaxngwAvKsfHWGB+GMWRdxZXWhvwT8dysFIigszVBogaWhp
         L2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KH/kKXlPapxERxri3iYFJat8Wjjpq/bYtPaYTiMH5Ck=;
        b=MashOesYv6YemN2P8R75n+arDaRujk3c0pv3iagVU5XTfrrnt5LgI1Jfc7WHHLz4cj
         5Bat6Hj7dl5Wcu/UUFOpUa7IAMdZ123KM/IkScPUi9qvr2ePenk8aXfB9va0HOqKcWn4
         BuVXvk304ZWaWshkWmE6D5pJHFvv8DOFehmeTlg6Fcw5OZWMBsRjQwEAgPHg8JtZlfNz
         V8L+L7MTqCr6Tciur4kvaoFUW3h4HUrseV5sI903GyZ4s911p8EPthM57Pir2hwqGqjt
         G+TAzLX65nH39dPQPVez/bxduA+Q3ZJohNRNi2qB+v+msuurSOxpGa3fF+HErhlGStud
         3/MA==
X-Gm-Message-State: AOAM533exwJyW+c0zsabPbbOBRnKVyZM1LKnKA86+RVhwowHx2beoiUs
        4pQQuVaUpRvoh5AP0fi21P3JE9ab2CTY8AahwHVlcw==
X-Google-Smtp-Source: ABdhPJxxKsdipZWdaSL3KePXfOAkyV0G4yZehHHbiMiLt/xDT1thfeLFkw3qXXm5LoEk22ADga7XHjTdXPA55vXTRrY=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr7263436pjb.220.1632255000613;
 Tue, 21 Sep 2021 13:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210920225638.1729482-1-ben.widawsky@intel.com>
 <CAPcyv4ja65PA5qjKPW4dYsVUCEiEDKD65_5vw15VryYL1h7=QQ@mail.gmail.com>
 <20210921164401.h46pjfwkpr7m2ven@intel.com> <CAPcyv4idgH7=4aVZWsUfeiqJyC_rh0+F5dkuWLiomL1oao7k7A@mail.gmail.com>
 <20210921190637.x54hh4aaom5auffs@intel.com> <CAPcyv4hmd=uSwrp=P+yHb=D2YCjM8WBEn0V8jC5VbqvGctMBpw@mail.gmail.com>
 <20210921192123.gzh3cich3cbiczp6@intel.com>
In-Reply-To: <20210921192123.gzh3cich3cbiczp6@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 21 Sep 2021 13:09:49 -0700
Message-ID: <CAPcyv4hyMCsq2Xq4TwJF651XW5fBAwZnt4ACb5HwF-Gr+wh1+Q@mail.gmail.com>
Subject: Re: [PATCH] cxl: Move register block enumeration to core
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 21, 2021 at 12:21 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-21 12:16:18, Dan Williams wrote:
> > On Tue, Sep 21, 2021 at 12:06 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-09-21 11:42:55, Dan Williams wrote:
> > > > On Tue, Sep 21, 2021 at 9:44 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > On 21-09-21 07:07:13, Dan Williams wrote:
> > > > > > On Mon, Sep 20, 2021 at 3:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > > > >
> > > > > > > CXL drivers or cxl_core itself will require the ability to map component
> > > > > > > registers in order to map HDM decoder resources amongst other things.
> > > > > > > Much of the register mapping code has already moved into cxl_core. The
> > > > > > > code to pull the BAR number and block office remained within cxl_pci
> > > > >
> > > > > s/office/offset - before anyone else notices...
> > > > >
> > > > > > > because there was no need to move it. Upcoming work will require this
> > > > > > > functionality to be available outside of cxl_pci.
> > > > > > >
> > > > > > > There are two intentional functional changes:
> > > > > > > 1. cxl_pci: If there is more than 1 component, or device register block,
> > > > > > >    only the first one (of each) is checked. Previous logic checked all
> > > > > > >    duplicate register blocks and additionally attempted to map unused
> > > > > > >    register blocks if present.
> > > > > > > 2. cxl_pci: No more dev_dbg for unused register blocks
> > > > > >
> > > > > > Why not break these out into separate patches before moving the code?
> > > > > > It makes it easier to review, and it increases the precision of future
> > > > > > Fixes: patches if necessary.
> > > > > >
> > > > >
> > > > > I can. Indeed it was my instinct to do so. I went against my instinct...
> > > > >
> > > > > What are you thinking (something like...)?
> > > > > 1. Change register locator identifiers to enum
> > > > > 2. refactor cxl_pci to use the new find() function.
> > > >
> > > > In order to ease the coordination pressure perhaps you could define a
> > > > __weak copy of this helper in the CXL core with a comment of:
> > > >
> > > > /* TODO: Delete once this same function is available from the PCI core */
> > > >
> > > > ...and then separately send the refactor series to all the stakeholders.
> > >
> > > You mean so I can work on the other drivers without being blocked on this?
> >
> > Yeah, so CXL development is not waiting on a stable commit-id for this
> > to show up, and so that other drivers are not needing to merge some
> > random point in the CXL development branch into their trees.
> >
> > > I
> > > think as long as you generally agree with the final outcome, I'll be okay to
> > > just keep working on top of this.
> >
> > I'm looking to let this soak with stable commit-ids in cxl.git/next.
> > It's hard to do that with external dependencies.
>
> Understood. Right now all the drivers have a dependency order, so couldn't the
> weakly defined helper just be the first patch in that series?

I expect the weakly defined dvsec helper would appear in this CXL
series and the strong symbol would appear in the first patch of the
independent refactor series.

> Or are you suggesting to send that and get it merged before anything else?

With the weak symbol definition in the CXL series the strong
definition can land whenever it's natural.
