Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EF4C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 19:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDE5E611CE
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Nov 2021 19:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhKDTM6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhKDTM6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Nov 2021 15:12:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15369C061714
        for <linux-cxl@vger.kernel.org>; Thu,  4 Nov 2021 12:10:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m26so6784709pff.3
        for <linux-cxl@vger.kernel.org>; Thu, 04 Nov 2021 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sH1H/SSb7145613St9QR+4X9xXT5SuXQ4PmNmNtE4SY=;
        b=RkQ2Up/010tXpZunvFScYS1oeir9SkeWNgN7vNOqLE5K8VWoaQxeKLcItA3qP3u0Nb
         Xx1zZ5EDXP+Od3tXRAEXyGhqhQ39UHgMpnOeiC89dNuOQA4lV6Ste473faE6SWbS0oVZ
         NbZynGdbePUpAcx8y3av/zJobXk2In0ZrL2pY4ZZDL1YcZd9zk5yEfPUilbaZBgLqgWs
         nL59oz38ItY/lL9ZHnIumVCAKqe8VBv0KoupGKDInbw/LwlZCUW0Cl7fVQSA/RFyhteN
         NGhoxF4rosCJvTJ3wkoeTW5j6mlSGjurJtUG3me+sLzHXWAYvzbo3bTJty3SxPvBcTcd
         H0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sH1H/SSb7145613St9QR+4X9xXT5SuXQ4PmNmNtE4SY=;
        b=L9oOeNBXlgsRdFQxnNKawumfHGW4+/F9/GDgDvG2W2GVjuxnfvoJkdJvEw8Qwwkfsu
         JsuSmZ7yfipmeDkcGd3Xt+0PLu9nA0ycGVgeSp+AWLjaT/svDUXfUnz7DyO1LGkgOoQu
         VDOWS7sETgrGNK5+A5pnt2UEvnxBZCJPiRdE8paWM1pvnnn2HiSBhnSkT+RpqH0M4mU3
         CXR8lxa+qYZqpCRljNT42eB4/MmcstjzNpmm7cSb3cxeKWcGUI4Rvy197PSs5c3UG1wj
         o4FeKobK6K1on/v22uPHQfbtsYdFClMFd8GE6uEHVuq5Pz8Sd3HtKTj9rRXwRb2VpYQM
         p01A==
X-Gm-Message-State: AOAM533rF40LxUIQ/80BH8RJ4p68I3h/sYT7Gbc1fDd+ERIxg0DfRuXj
        670WIB2N/3T3Gg27VKM5LMfnWyl2P7l276Gl8jtWZA==
X-Google-Smtp-Source: ABdhPJw1ZMHx2dxdoz6TwtXVkAXo3hN4N/9EQRT8mwAdNFVAONMtLYyNH8vjR0t+Pc/AaaXfCZn9ur57A+LxmG0NksM=
X-Received: by 2002:a05:6a00:1254:b0:481:2730:a52a with SMTP id
 u20-20020a056a00125400b004812730a52amr20821412pfi.86.1636053019607; Thu, 04
 Nov 2021 12:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com> <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
 <20211101175314.lrq3ccqkts725bjt@intel.com> <CAPcyv4hKxUXbmCkuf8Rw1vsOhErKMyZ8ivBjO9YkhxDgiogo-w@mail.gmail.com>
 <20211102165801.6mxobbz3ow55nkzl@intel.com>
In-Reply-To: <20211102165801.6mxobbz3ow55nkzl@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Nov 2021 12:10:09 -0700
Message-ID: <CAPcyv4hyEmj+d-81hFqf0gaoOp+ZJJ+Yr=28yAOZCVNjcgsphA@mail.gmail.com>
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

On Tue, Nov 2, 2021 at 9:58 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-01 20:31:03, Dan Williams wrote:
> > On Mon, Nov 1, 2021 at 10:53 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 21-10-29 18:37:36, Dan Williams wrote:
> > > > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > >
> > > [snip]
> > >
> > > > > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > > > > index cf07ae6cea17..40b386aaedf7 100644
> > > > > --- a/drivers/cxl/Makefile
> > > > > +++ b/drivers/cxl/Makefile
> > > > > @@ -1,5 +1,6 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0
> > > > >  obj-$(CONFIG_CXL_BUS) += core/
> > > > > +obj-$(CONFIG_CXL_MEM) += cxl_port.o
> > > >
> > > > It feel odd that CONFIG_CXL_MEM builds cxl_port, why not have a
> > > > CONFIG_CXL_PORT that is simply selected by CONFIG_CXL_MEM, or a
> > > > CONFIG_CXL_PORT that defaults to the value of CONFIG_CXL_BUS?
> > > >
> > >
> > > Can you help me understand when CONFIG_CXL_MEM is useful when
> > > #CONFIG_CXL_PORT=n? I was unable to figure out such a case and so I tied the two
> > > together.
> >
> > With a 'select' dependency it's impossible to have the
> > CONFIG_CXL_PORT=n and CONFIG_CXL_MEM=m combination. The extra config
> > symbol is for idiomatic (one config-symbol per module .ko) reasons to
> > reflect the module dependency in the Kconfig.
> >
>
> Should CXL_MEM also select CXL_PCI? I don't see a way CXL_MEM can work without
> CXL_PCI.

The "select" dependency should be an "I use services from module X"
relationship. CXL_MEM uses port services and can't operate unless that
module is present. CXL_MEM does not strictly need CXL_PCI especially
since drivers/cxl/core/memdev.c abandoned all PCI refernces.
