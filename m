Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B75C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2413860F45
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 16:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhKBRAs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Nov 2021 13:00:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:7348 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234879AbhKBRAi (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 2 Nov 2021 13:00:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="228769795"
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="228769795"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 09:58:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="577244687"
Received: from cmwolf-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.136.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 09:58:03 -0700
Date:   Tue, 2 Nov 2021 09:58:01 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 08/28] cxl/port: Introduce a port driver
Message-ID: <20211102165801.6mxobbz3ow55nkzl@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-9-ben.widawsky@intel.com>
 <CAPcyv4g9AUzNihcYJ3AzwZ+UnFquOf1VWX3fZgb-77ZNteFTAA@mail.gmail.com>
 <20211101175314.lrq3ccqkts725bjt@intel.com>
 <CAPcyv4hKxUXbmCkuf8Rw1vsOhErKMyZ8ivBjO9YkhxDgiogo-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hKxUXbmCkuf8Rw1vsOhErKMyZ8ivBjO9YkhxDgiogo-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-11-01 20:31:03, Dan Williams wrote:
> On Mon, Nov 1, 2021 at 10:53 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > On 21-10-29 18:37:36, Dan Williams wrote:
> > > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> >
> > [snip]
> >
> > > > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > > > index cf07ae6cea17..40b386aaedf7 100644
> > > > --- a/drivers/cxl/Makefile
> > > > +++ b/drivers/cxl/Makefile
> > > > @@ -1,5 +1,6 @@
> > > >  # SPDX-License-Identifier: GPL-2.0
> > > >  obj-$(CONFIG_CXL_BUS) += core/
> > > > +obj-$(CONFIG_CXL_MEM) += cxl_port.o
> > >
> > > It feel odd that CONFIG_CXL_MEM builds cxl_port, why not have a
> > > CONFIG_CXL_PORT that is simply selected by CONFIG_CXL_MEM, or a
> > > CONFIG_CXL_PORT that defaults to the value of CONFIG_CXL_BUS?
> > >
> >
> > Can you help me understand when CONFIG_CXL_MEM is useful when
> > #CONFIG_CXL_PORT=n? I was unable to figure out such a case and so I tied the two
> > together.
> 
> With a 'select' dependency it's impossible to have the
> CONFIG_CXL_PORT=n and CONFIG_CXL_MEM=m combination. The extra config
> symbol is for idiomatic (one config-symbol per module .ko) reasons to
> reflect the module dependency in the Kconfig.
> 

Should CXL_MEM also select CXL_PCI? I don't see a way CXL_MEM can work without
CXL_PCI.

[snip]

