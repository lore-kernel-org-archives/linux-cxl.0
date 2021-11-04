Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6B7C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 20:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276AF61241
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 20:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhKDUHD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Nov 2021 16:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhKDUHC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Nov 2021 16:07:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A778C061714
        for <linux-cxl@vger.kernel.org>; Thu,  4 Nov 2021 13:04:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id r5so9145495pls.1
        for <linux-cxl@vger.kernel.org>; Thu, 04 Nov 2021 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMEXPSmdzso0DjS3cu2ZrTCl+myK6/SwdvDVyW8BmVc=;
        b=mTtOsw6GTce3SWAKE8/t9fcJ4sWt/EUfYcwItTvZgJDexx7fUzJdtUUUjndeE7gtZ3
         NenzV+2EJKUOIPFnDC/YXFvgqy9cbIg32qVzchg7WPNVn0KFZ/REuc1BQZ+Hoi6H/hge
         iPpjMo/kJQJMTiZd86AQm3sf++d45kPDUDjx3WokUB9HU15Kci4NkAdy0AsjNVbAt58A
         SWY2cUSch1Gdf7ab44edgSM9n9uSLWUf3ZwyzsDlVt4kDI0Bt0VmH+RRL02HKFTvrdfV
         aebY0VdkFF/MjGH2cwVnoCdJhps+SxZWOVDqSiTc0SdhvZqDzTV+vS770B9i4Xs5MZi2
         A7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMEXPSmdzso0DjS3cu2ZrTCl+myK6/SwdvDVyW8BmVc=;
        b=ys7RUNYhNK9bqd3WzqAUgN8uFyYjFUXBuTMbzr7aMjyzFdOp1CeV54jblAWMBYjSAw
         qyejQNaCh612k5ch+XI5xmVpOudxB2udDgn/woQG2lrq+leVLWoa84y7cFFdFUZI0cWR
         VspMQ1dov3KcnxwlCt/FUd15AUF71aDAc1yrTgxeNeUWvp4Saw+GYF9B4Ydr0HfYCUlK
         CyjZdoqVAYgDZIkhl29wAbkM6EghXl1lkJXjp7+Z4T54GEMIZ/AmfoXln6HKXWaCgB4L
         CR3Y4KGi9wS9vuRLs8gjqiHdil+7bgcHvIypFDS6Ssyr/+z5Nn5o0lmdSNsGQS3sAN3D
         F9Ag==
X-Gm-Message-State: AOAM530wKn5aO2BxRAXi0ELhwRkCPKXTbTlGgkVgka5mQ0gzLTSXIbVJ
        pptdfPTE9pj9AC/C0i7FiWAOFAAn+p6kRgGnXRlreg==
X-Google-Smtp-Source: ABdhPJyRjkHqaw605uc8+TY3MtAQ1VflcNFYQy6q9ReIZ/fw2yBJUmuK8aokYa3s2/sMnK8M0psCVN8kg2GLJ3jrKPM=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr1834357pjb.220.1636056263986;
 Thu, 04 Nov 2021 13:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com> <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
 <20211101175314.lrq3ccqkts725bjt@intel.com> <CAPcyv4hKxUXbmCkuf8Rw1vsOhErKMyZ8ivBjO9YkhxDgiogo-w@mail.gmail.com>
 <20211102165801.6mxobbz3ow55nkzl@intel.com> <CAPcyv4hyEmj+d-81hFqf0gaoOp+ZJJ+Yr=28yAOZCVNjcgsphA@mail.gmail.com>
 <20211104194906.6du3jtcpkxeumhsf@intel.com>
In-Reply-To: <20211104194906.6du3jtcpkxeumhsf@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Nov 2021 13:04:13 -0700
Message-ID: <CAPcyv4hZxrJGRT1HuigAJacGzG37gRmOfFVDKm-0fUM5XfJrKw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/28] cxl/port: Introduce a port driver
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Nov 4, 2021 at 12:49 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-04 12:10:09, Dan Williams wrote:
> > On Tue, Nov 2, 2021 at 9:58 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-11-01 20:31:03, Dan Williams wrote:
> > > > On Mon, Nov 1, 2021 at 10:53 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > On 21-10-29 18:37:36, Dan Williams wrote:
> > > > > > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > > > >
> > > > >
> > > > > [snip]
> > > > >
> > > > > > > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > > > > > > index cf07ae6cea17..40b386aaedf7 100644
> > > > > > > --- a/drivers/cxl/Makefile
> > > > > > > +++ b/drivers/cxl/Makefile
> > > > > > > @@ -1,5 +1,6 @@
> > > > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > > > >  obj-$(CONFIG_CXL_BUS) += core/
> > > > > > > +obj-$(CONFIG_CXL_MEM) += cxl_port.o
> > > > > >
> > > > > > It feel odd that CONFIG_CXL_MEM builds cxl_port, why not have a
> > > > > > CONFIG_CXL_PORT that is simply selected by CONFIG_CXL_MEM, or a
> > > > > > CONFIG_CXL_PORT that defaults to the value of CONFIG_CXL_BUS?
> > > > > >
> > > > >
> > > > > Can you help me understand when CONFIG_CXL_MEM is useful when
> > > > > #CONFIG_CXL_PORT=n? I was unable to figure out such a case and so I tied the two
> > > > > together.
> > > >
> > > > With a 'select' dependency it's impossible to have the
> > > > CONFIG_CXL_PORT=n and CONFIG_CXL_MEM=m combination. The extra config
> > > > symbol is for idiomatic (one config-symbol per module .ko) reasons to
> > > > reflect the module dependency in the Kconfig.
> > > >
> > >
> > > Should CXL_MEM also select CXL_PCI? I don't see a way CXL_MEM can work without
> > > CXL_PCI.
> >
> > The "select" dependency should be an "I use services from module X"
> > relationship. CXL_MEM uses port services and can't operate unless that
> > module is present. CXL_MEM does not strictly need CXL_PCI especially
> > since drivers/cxl/core/memdev.c abandoned all PCI refernces.
>
> The problem I see is cxl_mem devices have a soft dependency on cxl_pci. For
> example what we discussed regard DVSEC range registers. My plan was if the
> endpoint driver can't determine range registers aren't in use, it won't bind. It
> can't make this determination without cxl_pci. DOE has a similar implication
> though not fatal.

I think this gets back to my original preference of just making the
port driver a part of the core rather than its own independent module
for no real reason. In fact it makes the validation job harder because
it expands the testing surface for different combinations of module
loading and device binding.

For the specific issue of CXL_MEM dependencies on CXL_PCI, isn't
CXL_PCI passing in cacheed data for CXL_MEM? CXL_MEM has no idea that
CXL_PCI exists, but it certainly knows that CXL_PORT exists,
