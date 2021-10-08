Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA08C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Oct 2021 18:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C432260F9D
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Oct 2021 18:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhJHSPi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhJHSPg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Oct 2021 14:15:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31EAC061755
        for <linux-cxl@vger.kernel.org>; Fri,  8 Oct 2021 11:13:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so3861756pgc.6
        for <linux-cxl@vger.kernel.org>; Fri, 08 Oct 2021 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jEIeAPoyRMgA20w/xQDPk0p4pIc0nWm+IAJ6memPPBo=;
        b=USfGgGW4lUN8/H/kqsFFKYp7DlmFa5psWIxFsEE6R1VyKjKb5c7wH3nqzXXgTp6gQO
         5FrobQeUXbE3F5Kie/wnNASgo4Cix2Jvl0vEItbAvjuZH6hvhkdU/W7qrdS2SnE6BW78
         QFIFEFq50gX0szCDAbNpX1VY5rvSYnFi7334eWpQF6QdFpmyFZsHd9Syg2R7NgiMOnQy
         oVxVyXAmdwhywYAs/z1+E9NlEa6eIcmd2Xr+eYRJr1q147smDpqIlPTLqFCHcUeImoHQ
         h4+XIrqDG1QBJTF7yD7TG6Gf4EeXuXNNOcW1NvY3ajE+yDp8FECVJ9zEMJhsBhbgtT8n
         BZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEIeAPoyRMgA20w/xQDPk0p4pIc0nWm+IAJ6memPPBo=;
        b=2800Nn1FSAjfq5XsYKv5ikum/tzNASP0/NP60jostujZ4fLxvrgNn0pssULf6X7y//
         Z5n5DbQaPIInMuoTjQRcRHLsExRHQhTVNGZUOekKbM9a/PM2LM9KgI7pkBwDgC1kSnXR
         elZy7PUhIrGVeFeXxhQlNbEVNqX7uZAefdcgqDbh25zXahn4AJCs99/6kvpR2Cpvdz1Q
         BqDsBPE+vkK0cEzHAiWj7oL/npKp0ANHfvjmRwhmqEpslCP46f4vmQ2qAbVsvSKiHmOv
         g0IPS8tkHISSUMFMDteUmLp60CPJII9DLvoSG+wAvVgBIBucCafY5/23FFtk1gP+LytH
         FNlQ==
X-Gm-Message-State: AOAM532kraU4C6khgLKjFrIRr+503ixQCB7VIpLvVawo94m7a7p+WUw6
        BOPHCCWOWCpC1mTnjhbLn9aznl1DvqD+tLPUPB46Kw==
X-Google-Smtp-Source: ABdhPJwjnP/cS8XS0TM6T5YG4xj9CHGmUZwllprApDCixSI472uUHGMk240AOU9yVe7UJU2/ty3gIn/amUuxCzoCl+U=
X-Received: by 2002:a63:1262:: with SMTP id 34mr5866345pgs.356.1633716820225;
 Fri, 08 Oct 2021 11:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211007213426.392644-1-alison.schofield@intel.com> <7e44a7bd8701a6926fbcb6150dd20ed8557d88c4.camel@intel.com>
In-Reply-To: <7e44a7bd8701a6926fbcb6150dd20ed8557d88c4.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 8 Oct 2021 11:13:29 -0700
Message-ID: <CAPcyv4i8qWShspzuhnEmOHNKAaaijJjJWV9ZGSrWJEyngX4y9w@mail.gmail.com>
Subject: Re: [PATCH] cxl/acpi: Do not fail cxl_acpi_probe() based on a missing CHBS
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Schofield, Alison" <alison.schofield@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 3:51 PM Verma, Vishal L <vishal.l.verma@intel.com> wrote:
>
> On Thu, 2021-10-07 at 14:34 -0700, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > When an ACPI0016 Host Bridge device is present yet no corresponding
> > CEDT Host Bridge Structure (CHBS) exists, the ACPI probe method
> > fails.
> >
> > Rather than fail, emit this warning and continue:
> > cxl_acpi ACPI0017:00: No CHBS found for Host Bridge: ACPI0016:02
> >
> > This error may occur on systems that are not compliant with the
> > ACPI specification. Compliant systems include a CHBS entry for
> > every CXL host bridge that is present at boot.
> >
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/acpi.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
>
> Tested with a non-compliant system, and works as expected (remaining
> roots and decoders still show up). You can add:
>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>

Applied to cxl/pending.

Thanks!
