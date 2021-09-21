Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76042C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 19:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5AB603E9
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Sep 2021 19:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhIUTSB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbhIUTR7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Sep 2021 15:17:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A485FC061574
        for <linux-cxl@vger.kernel.org>; Tue, 21 Sep 2021 12:16:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so347355pjb.5
        for <linux-cxl@vger.kernel.org>; Tue, 21 Sep 2021 12:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HVikvdk2hzq8yZpk9guuA5YVOBHI449zL5EZpSrS6lE=;
        b=fTxd9mXpScfpmlEMMM4C2cmKzs7GnricB91rXko5gKwD9CXk3MkQ9dqTYnB+KYulm8
         fYmSdwAhjdj2DS7RRQQkiKWCWW7QBCYwP/TCyuHNCl1IKK2DovwthkrZqFEoUhpUjSgY
         WXCV2Z4CwCVeK3kBlc9tmoFyXQUz1gG/V5luUFwohN7hRbpMY5s2+ScSzSaO+kUqiS4H
         WY1TxU7vW5XtDgEI6PhO6vcm7Oqg5ctpwQZPQrS9FY2coSRwFfTU6Q6i4WDTUoJoZyvM
         CAE9aRjWhk+rNkgep0Fr354opeUZgxKdGrD6XBf2Wv26//Qi4ewWOMpLjYF+fuJHdCn5
         8KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HVikvdk2hzq8yZpk9guuA5YVOBHI449zL5EZpSrS6lE=;
        b=ChC37XL5G7qIgqciTUpkEkjMl+HwkWej5l3ONt0wi58c7u+yxkbvwAPkvpRqg58MaG
         +pEqjvcLx8MVK9gZdWwMhYVas7Sxozz5dXTn9CyMOIHx8jWfEV9lf/hLqaMyBgipoIRp
         Yuw5jUZUyeFPbooHvfkwpOzR8U2W8EkjyjlgnhWpFYnCh2wD7UgLX808oafuSw1BUiYH
         cFZ6l4CT/a+7C1R6jw+cjCNhkP2hC+fWjzsqvHp8+sxQHZI60yB7uX93+S5ApY/r6SSs
         dg7y+ovB68yqjQ4beSsH7bea+1f6UIYSJn5AqY4o7nMT/Nf8u4zxkhglIWaDMx+wNes5
         tG6w==
X-Gm-Message-State: AOAM5329c/0NONDhS2ZPpSFcNYsSTLmC9Kywk0jH5ba9GSg0z8n7bqdF
        o+A9IH5WtYke9y1E8adSa611GfrU3uXnrMG4jISlYTKL8wM=
X-Google-Smtp-Source: ABdhPJxhdnYa2WANv/QYE6MiSkFcJB/lSV62JiR6SGgth0tTYL6qAL5KKKJCxe9XM9CW7Bfe6Vw/zm07PzGDHElsukM=
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id
 q13-20020a170902bd8d00b0013a08c8a2b2mr29016340pls.89.1632251790100; Tue, 21
 Sep 2021 12:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210920225638.1729482-1-ben.widawsky@intel.com>
 <CAPcyv4ja65PA5qjKPW4dYsVUCEiEDKD65_5vw15VryYL1h7=QQ@mail.gmail.com>
 <20210921164401.h46pjfwkpr7m2ven@intel.com> <CAPcyv4idgH7=4aVZWsUfeiqJyC_rh0+F5dkuWLiomL1oao7k7A@mail.gmail.com>
 <20210921190637.x54hh4aaom5auffs@intel.com>
In-Reply-To: <20210921190637.x54hh4aaom5auffs@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 21 Sep 2021 12:16:18 -0700
Message-ID: <CAPcyv4hmd=uSwrp=P+yHb=D2YCjM8WBEn0V8jC5VbqvGctMBpw@mail.gmail.com>
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

On Tue, Sep 21, 2021 at 12:06 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-21 11:42:55, Dan Williams wrote:
> > On Tue, Sep 21, 2021 at 9:44 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-09-21 07:07:13, Dan Williams wrote:
> > > > On Mon, Sep 20, 2021 at 3:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > CXL drivers or cxl_core itself will require the ability to map component
> > > > > registers in order to map HDM decoder resources amongst other things.
> > > > > Much of the register mapping code has already moved into cxl_core. The
> > > > > code to pull the BAR number and block office remained within cxl_pci
> > >
> > > s/office/offset - before anyone else notices...
> > >
> > > > > because there was no need to move it. Upcoming work will require this
> > > > > functionality to be available outside of cxl_pci.
> > > > >
> > > > > There are two intentional functional changes:
> > > > > 1. cxl_pci: If there is more than 1 component, or device register block,
> > > > >    only the first one (of each) is checked. Previous logic checked all
> > > > >    duplicate register blocks and additionally attempted to map unused
> > > > >    register blocks if present.
> > > > > 2. cxl_pci: No more dev_dbg for unused register blocks
> > > >
> > > > Why not break these out into separate patches before moving the code?
> > > > It makes it easier to review, and it increases the precision of future
> > > > Fixes: patches if necessary.
> > > >
> > >
> > > I can. Indeed it was my instinct to do so. I went against my instinct...
> > >
> > > What are you thinking (something like...)?
> > > 1. Change register locator identifiers to enum
> > > 2. refactor cxl_pci to use the new find() function.
> >
> > In order to ease the coordination pressure perhaps you could define a
> > __weak copy of this helper in the CXL core with a comment of:
> >
> > /* TODO: Delete once this same function is available from the PCI core */
> >
> > ...and then separately send the refactor series to all the stakeholders.
>
> You mean so I can work on the other drivers without being blocked on this?

Yeah, so CXL development is not waiting on a stable commit-id for this
to show up, and so that other drivers are not needing to merge some
random point in the CXL development branch into their trees.

> I
> think as long as you generally agree with the final outcome, I'll be okay to
> just keep working on top of this.

I'm looking to let this soak with stable commit-ids in cxl.git/next.
It's hard to do that with external dependencies.
