Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C99EC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 20 Apr 2022 00:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239338AbiDTAux (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 19 Apr 2022 20:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiDTAuw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 19 Apr 2022 20:50:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0FA35847
        for <linux-cxl@vger.kernel.org>; Tue, 19 Apr 2022 17:48:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id bx5so390778pjb.3
        for <linux-cxl@vger.kernel.org>; Tue, 19 Apr 2022 17:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/5Xml3UsJfHYBkyrgplWoxnlJfCyQ6iKbQrUrhsxdY=;
        b=WQM1KpmZa/Li49Mvjul50ifbFCTGPBMHsjM/qAceg4TINtaTSNT7PkJXaQZIixo+SU
         QW8mlmWkkWIP6R19l6cQKaN46E0zF4tFPSoezEJJuxGZtWvu5sxER8BqD98OfxCFxxI6
         dkAHhpOviVI1cMCU3TAPF44Oa8ZzueQtLqDUZITq59UU7fCYeK/XxNYmukoy59QbybjF
         aVt0pvrNrxWnvKM82uu1m7LNMI42/GRdi5Saa5fV5yfYYzDSyvW351ApdzHh4vVemotd
         WkUaAHRPpBk0Uw7lLYc+dWSLNVz30Rnv3nPzSW7mrZwX4hJKRSUYtm5TqkLG4vx0lqwj
         Xwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/5Xml3UsJfHYBkyrgplWoxnlJfCyQ6iKbQrUrhsxdY=;
        b=Uh4h0A6LMEbp6eo+A6kXVI+m/fUancqJ+mVdW6g1JG7/UBW5cWCq+Xlsd46izJHp5k
         xcvJODZsNGqoSDXQ5j2Q72K2cJhOAzC9sdUnnIi1sElkQhSD/wZ0zcvAbXvgaeteKKkC
         fKdPFMPRmw1ovRZs+Gud8TZfRNhW7HTYvUpbxu68twV1gTrW3Xgs7+2YfpCDlSAELGiH
         Ql+iVK6lacMRxRtP7cbRRmVFl4TSOQ7KknAN+4V6wi/FSNlgj4Dvrm+wgiVwvI06cbIp
         oGIqi7qGIb4WJvrExoOQE1aE9OpQxMYOXUN5Ua2Gj9eHys2ZClnAH4l/afs3hc7FcA82
         J58Q==
X-Gm-Message-State: AOAM533SzUl5iAFFNq260+1mbPmzuKz8YyfjuItpxkcyutNcFK713TFR
        cMDAf2cDRp8ay4NQgCMespHfa8sJKMiu1AwbC7nYsA==
X-Google-Smtp-Source: ABdhPJyF+Bogu+uAQK3/2kFuuJbnmsTKAy9Yr/FlQVt4ejHuUy1JqvwMPYiX9u0okDB9A+3YW6CIQu0QYoxYpTXD+XQ=
X-Received: by 2002:a17:90b:1e0e:b0:1d2:8906:cffe with SMTP id
 pg14-20020a17090b1e0e00b001d28906cffemr1449388pjb.220.1650415687743; Tue, 19
 Apr 2022 17:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
 <20220413183720.2444089-6-ben.widawsky@intel.com> <CAPcyv4iM13nzCpnF5S4oHSWF769t4Av96gQM_3n4E=RAPSnSig@mail.gmail.com>
 <20220419164313.GT2120790@nvidia.com> <CAPcyv4hPBw0yJmu7qzSZ_gsbVuj+_R7-_r3+_W9-JsLTD6Uscw@mail.gmail.com>
 <CAPcyv4hyTRm7K8gu4wdL_gaMm2C+Agg1V2-BbnmJ8Kf0OH4sng@mail.gmail.com> <20220419230412.GU2120790@nvidia.com>
In-Reply-To: <20220419230412.GU2120790@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Apr 2022 17:47:56 -0700
Message-ID: <CAPcyv4i5MZcMcCq8V7sZQjqup6MPOoOj2Zuu8HEECADfFi2Tcg@mail.gmail.com>
Subject: Re: [RFC PATCH 05/15] cxl/acpi: Reserve CXL resources from request_free_mem_region
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 19, 2022 at 4:04 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Apr 19, 2022 at 02:59:46PM -0700, Dan Williams wrote:
>
> > ...or are you suggesting to represent CXL free memory capacity in
> > iomem_resource and augment the FW list early with CXL ranges. That
> > seems doable, but it would only represent the free CXL ranges in
> > iomem_resource as the populated CXL ranges cannot have their resources
> > reparented after the fact, and there is plenty of code that expects
> > "System RAM" to be a top-level resource.
>
> Yes, something more like this. iomem_resource should represent stuff
> actually in use and CXL shouldn't leave behind an 'IOW' for address
> space it isn't actually able to currently use.

So that's the problem, these gigantic windows need to support someone
showing up unannounced with a stack of multi-terabyte devices to add
to the system. The address space is idle before that event, but it
needs to be reserved for CXL because the top-level system decode makes
mandates like "CXL cards of type X performance Y inserted underneath
CXL host-bridge Z can only use CXL address ranges 1, 4 and 5".

> Your whole description sounds like the same problems PCI hotplug has
> adjusting the bridge windows.

...but even there the base bounds (AFAICS) are coming from FW (_CRS
entries for ACPI described PCIe host bridges). So if CXL follows that
model then the entire unmapped portion of the CXL ranges should be
marked as an idle resource in iomem_resource.

The improvement that offers over this current proposal is that it
allows for global visibility of CXL hotplug resources, but it does set
up a discontinuity between FW mapped and OS mapped CXL. FW mapped will
have top-level "System RAM" resources indistinguishable from typical
DRAM while OS mapped CXL will look like this:

100000000-1ffffffff : CXL Range 0
  108000000-1ffffffff : region5
    108000000-1ffffffff : System RAM (CXL)

...even though to FW "range 0" spans across a BIOS mapped portion and
"free for OS to use" portion.
