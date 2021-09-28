Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D270FC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 17:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEC461352
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Sep 2021 17:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhI1RnR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbhI1RnR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Sep 2021 13:43:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E764C06161C
        for <linux-cxl@vger.kernel.org>; Tue, 28 Sep 2021 10:41:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id x191so15042065pgd.9
        for <linux-cxl@vger.kernel.org>; Tue, 28 Sep 2021 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkidfBLNDflGiXs0oP3mDBZ5il/79hD91IY+k5Xsxuc=;
        b=bA7yAxAI4PivPTDL2tmtUWSug8cFLm+Lp/M/J8tWpOX7VThwyhD1uHRnHWyn1gypjz
         /XzmjC9sfErVDuGFsyJvSSHvvhu9nQ7Kso3E+RGxpZnlV1rpwx4LYj/P5l6Z38Y/UEfp
         dNeWL6kK9unlsA8wG5GEhkIZ+4tvRDOMk+TJy7HzL9rdoix0FJNsfZcPFnfoMkxbst93
         a/G0KXVU8o79EfFIKtiBKh5+QiY7b/PJds1zfTAHCkczgYa7RB5dkQrraBWKo6v3QHEl
         TcfvQ5mM+1T1aqcT9TKMJNtVWXVgUrfew9Eem3OwSym9y2/TAeOib1Yk9gpHI3xIahD9
         clDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkidfBLNDflGiXs0oP3mDBZ5il/79hD91IY+k5Xsxuc=;
        b=oBjdaPuIZQdm3OjTp0qbmNtExeUQccAHRjVuarDXpjJtCPcmgwrv0oR3aUGfc/007W
         MJ60xr4hoBLrh2SJbPYRkFGUSTmLjsFJmS2UFXXlgOLe20LkQbB5eA0NbNN41x/Rlcxu
         eDZtWrdVhyNlGAzsjMgoJ3McwiaWRmlJQnad87d27Htoa6Wg6YtmsJjv0EjhuuZ0QdZA
         gfshzgpWIWz6FaiXhSbV1CUBPg9voFcC0r6RnNp4zNIe6Q9Bde9zm4gA53wS2q4xXjBb
         UR/rz4zrXhuhIRGpkiWnuGl+bn4KMBT0VGDJ1PW24XhK5EHQj1yNb3xET4nvSt1qnGZj
         tXcw==
X-Gm-Message-State: AOAM530cl4zYenC/EbTxb3/vtJrNo0IVwHiffyDLJkpds25fOBJLmhZ3
        9SJsMpmjmN1CvNoAUt5W+WgVHnZ1+UT5DUL6YfO8BQ==
X-Google-Smtp-Source: ABdhPJxE685ihjSuTSw0+w9d2q6ixqqWA3MsNeG+SfMab1LeeuIrmS8uWL0F1Ylm1UNzWyahPTQwxwoyCoYk+d5LLKY=
X-Received: by 2002:a63:1e0e:: with SMTP id e14mr5684055pge.5.1632850896968;
 Tue, 28 Sep 2021 10:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210923172647.72738-1-ben.widawsky@intel.com> <20210923172647.72738-6-ben.widawsky@intel.com>
In-Reply-To: <20210923172647.72738-6-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 28 Sep 2021 10:41:24 -0700
Message-ID: <CAPcyv4j5aRTEX=FDjYv21J0uDWbP66j-xaDPkvjmwdnKmvAWDA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] cxl/pci: Make more use of cxl_register_map
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

On Thu, Sep 23, 2021 at 10:27 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The structure exists to pass around information about register mapping.
> Using it more extensively cleans up many existing functions.

I would have liked to have seen "add @base to cxl_register_map" and
"use @map for @bar and @offset arguments" somewhere in this changelog
to set expectations for what changes are included. That would have
also highlighted that adding a @base to cxl_register_map deserves its
own patch vs the conversion of @bar and @offset to instead use
@map->bar and @map->offset. Can you resend with that split and those
mentions?
