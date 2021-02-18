Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92814C433E0
	for <linux-cxl@archiver.kernel.org>; Thu, 18 Feb 2021 19:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4498264E6F
	for <linux-cxl@archiver.kernel.org>; Thu, 18 Feb 2021 19:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhBRTl6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:41:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2587 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbhBRTNe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 Feb 2021 14:13:34 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DhPNR00G3z67nfQ;
        Fri, 19 Feb 2021 03:07:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Feb 2021 20:12:48 +0100
Received: from localhost (10.47.67.19) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Feb
 2021 19:12:47 +0000
Date:   Thu, 18 Feb 2021 19:11:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     "20210212162442.00007c1d@huawei.com" 
        <20210212162442.00007c1d@Huawei.com>, <armbru@redhat.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <f4bug@amsat.org>,
        <imammedo@redhat.com>, <ira.weiny@intel.com>, <jgroves@micron.com>,
        <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
        <qemu-devel@nongnu.org>, <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 1/2] Basic PCIe DOE support
Message-ID: <20210218191143.00000cdf@Huawei.com>
In-Reply-To: <8A5C244A-DF9A-4EB5-8C24-568A606E75B0@avery-design.com>
References: <1612900760-7361-1-git-send-email-cbrowy@avery-design.com>
        <1612902949-9992-1-git-send-email-cbrowy@avery-design.com>
        <20210212162442.00007c1d@Huawei.com>
        <8A5C244A-DF9A-4EB5-8C24-568A606E75B0@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.67.19]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 12 Feb 2021 16:58:21 -0500
Chris Browy <cbrowy@avery-design.com> wrote:

> > On Feb 12, 2021, at 11:24 AM, Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > On Tue, 9 Feb 2021 15:35:49 -0500
> > Chris Browy <cbrowy@avery-design.com> wrote:
> > 
> > Run ./scripts/checkpatch.pl over the patches and fix all the warnings before
> > posting.  It will save time by clearing out most of the minor formatting issues
> > and similar that inevitably sneak in during development.
> >   
> Excellent suggestion.  We’re still newbies!
> 
> > The biggest issue I'm seeing in here is that the abstraction of
> > multiple DOE capabiltiies accessing same protocols doesn't make sense.
> > 
> > Each DOE ecap region and hence mailbox can have it's own set of
> > (possibly  overlapping) protocols.
> > 
> > From the ECN:
> > "It is permitted for a protocol using data object exchanges to require
> > that a Function implement a unique instance of DOE for that specific
> > protocol, and/or to allow sharing of a DOE instance to only a specific
> > set of protocols using data object exchange, and/or to allow a Function
> > to implement multiple instances of DOE supporting the specific protocol."
> > 
> > Tightly couple the ECAP and DOE.  If we are in the multiple instances
> > of DOE supporting a specific protocol case, then register it separately
> > for each one.  The individual device emulation then needs to deal with
> > any possible clashes etc.  
> 
> Not sure how configurable we want to make the device.  It is a simple type 3
> device after all. 

Agreed, but what I (or someone else) really doesn't want to have to do
in the future is reimplement DOE because we made design decisions that make
this version hard to reuse.  Unless it is particularly nasty to do we should
try to design something that is generally useful rather than targeted to
closely at the specific case we are dealing with.

I'd argue the ECAP and the DOE mailbox are always tightly coupled 1-to-1.
Whether the device wants to implement multiple protocols on each DOE mailbox
or indeed run individual protocols on multiple DOE mailboxes is a design
decision, but the actual mechanics of DOE match up with the config
space structures anything else is impdef on the device.

> 
> The DOE spec does leave it pretty arbitrary regarding N DOE instances (DOE 
> Extended Cap entry points) for M protocols, including where N>1 and M=1.  
> Currently we implement N=2 DOE caps (instances), one for CDAT, one for 
> Compliance Mode.[
> 
> Maybe a more complex MLD device might have one or more DOE instances 
> for the CDAT protocol alone to define each HDM but currently we only have 
> one pmem (SLD) so we can’t really do much more than what’s supported.
> 
> Open to further suggestion though.  Based on answer to above we’ll follow 
> the suggestion lower in the code review regarding 
> 
...

