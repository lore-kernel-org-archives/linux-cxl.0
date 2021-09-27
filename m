Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0DC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Sep 2021 23:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB6761157
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Sep 2021 23:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbhI0XP2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Sep 2021 19:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhI0XP2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Sep 2021 19:15:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDFDC061604
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 16:13:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g14so17324820pfm.1
        for <linux-cxl@vger.kernel.org>; Mon, 27 Sep 2021 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4MzJ0yx9cD5fkatxhkgcIgfFDenItN2Wh8q8r9GPSA=;
        b=y3IML/IiRF9nk6cBsuR66v5EtYFXcqv9+kamXCWPCMEmblkdaeE1LDv5amUzTxiTzH
         smbfxg0LwR2V218iRSPpiFuCgmVRLUSkj7pYqhqmgQnV5vv2TqB24J5ubT28yxUUYXTo
         D0zbXxwlcZAJWgl4utsPM0PlopLNEmdM3vvLKn57U+H86myKPhwnJQq7IG/s2DwoyAAJ
         nYdarsvxXFoR6m5U8Ax9XOiRnxhWpSyPG8W9Gzhas3B0QBaG653TjG/ZCDCl3ABXKDFA
         NhSdzNY1WenPjh42aOdKY/IDxtuxgqRAmxJI5ZgWIONXlzwMUE/HGOxi3qv7aXY9d0cU
         8TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4MzJ0yx9cD5fkatxhkgcIgfFDenItN2Wh8q8r9GPSA=;
        b=Il0cnUK/Lynmc/GN4bbM7XMZsNcFEyGDlRCf0jMkeIEGuoePGpj5sYGHK/wgCEyfFe
         EixDgM7dOPqItSs85C5zPCoG0jRxkTsRGEJoWRpiwLiEEAhgFunGG8lep32r+4vgX+jW
         chxxMyw+I8R+QdqwahsfvjTPvc6skX5+i4UE8CooG8jn3JO87XkdBFwOhV5Qj8ylOwxt
         oyBI53bgjQGN1inbwMcO2/qCTdymjWbqiY7dY9eVMvyJ42uVGyaxTq3HAFcu18ll1aCL
         46rIzIE+dzZOgEFTJOa3ldmuFMce9r0vTSQdfcqksYHPRlfECohT+jg3YpqqWmNAiFnW
         qrAg==
X-Gm-Message-State: AOAM531rmqt/J7VO06hi/3MUU1yHs6XcdqB7zUmvemBtCUyKEBTKBl6i
        2TnbHEuE1/NkIqYOtL0wW1oQiZT/XkA7VfHI66J8Gw==
X-Google-Smtp-Source: ABdhPJzlhMrLY74o1cFWM7LDOyTRznwGcz5LuxyrnypmeeMmsbLgr6YqtHQ2yRKjvE547QjRsLHUH/2m9VYlflG4fcU=
X-Received: by 2002:a62:7f87:0:b0:444:b077:51ef with SMTP id
 a129-20020a627f87000000b00444b07751efmr2120157pfd.61.1632784429227; Mon, 27
 Sep 2021 16:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com> <20210923172647.72738-2-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-2-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 27 Sep 2021 16:13:41 -0700
Message-ID: <CAPcyv4gXiW7ap3dULCwcWLy1qkGOrgdJTBonfw5V7h6ZOQ-+AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] cxl: Convert "RBI" to enum
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Please spell out "register block indicator" in the subject so that the
shortlog remains somewhat readable.

On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> In preparation for passing around the Register Block Indicator (RBI) as
> a parameter, it is desirable to convert the type to an enum so that the
> interface can use a well defined type checked parameter.

C wouldn't type check this unless it failed an integer conversion,
right? It would need to be a struct to get useful type checking.

I don't mind this for the self documenting properties it has for the
functions that will take this as a parameter, but maybe clarify what
you mean by type checked parameter?

>
> As a result of this change, should future versions of the spec add
> sparsely defined identifiers, it could become a problem if checking for
> invalid identifiers since the code currently checks for the max
> identifier. This is not an issue with current spec, and the algorithm to
> obtain the register blocks will change before those possible additions
> are made.

In general let's not spend changelog space trying to guess what future
specs may or may not do. I.e. I think this text can be dropped,
especially because enums can support sparse number spaces.
