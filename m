Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE669C433E6
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59EB64EB8
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 12:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBSMft convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 Feb 2021 07:35:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2590 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhBSMfo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 Feb 2021 07:35:44 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DhrVy0H5Xz67nNQ;
        Fri, 19 Feb 2021 20:29:46 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Feb 2021 13:35:01 +0100
Received: from localhost (10.47.77.222) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Feb
 2021 12:35:00 +0000
Date:   Fri, 19 Feb 2021 12:33:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chris Browy <cbrowy@avery-design.com>
CC:     "20210218191143.00000cdf@huawei.com" 
        <20210218191143.00000cdf@Huawei.com>,
        "20210212162442.00007c1d@huawei.com" 
        <20210212162442.00007c1d@Huawei.com>, <armbru@redhat.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <f4bug@amsat.org>,
        <imammedo@redhat.com>, <ira.weiny@intel.com>, <jgroves@micron.com>,
        <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
        <qemu-devel@nongnu.org>, <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 1/2] Basic PCIe DOE support
Message-ID: <20210219123356.000046de@Huawei.com>
In-Reply-To: <DDBDE314-FA91-4E43-9484-F83E446B6EE4@avery-design.com>
References: <1612900760-7361-1-git-send-email-cbrowy@avery-design.com>
        <1612902949-9992-1-git-send-email-cbrowy@avery-design.com>
        <20210212162442.00007c1d@Huawei.com>
        <8A5C244A-DF9A-4EB5-8C24-568A606E75B0@avery-design.com>
        <20210218191143.00000cdf@Huawei.com>
        <DDBDE314-FA91-4E43-9484-F83E446B6EE4@avery-design.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.77.222]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 18 Feb 2021 19:46:54 -0500
Chris Browy <cbrowy@avery-design.com> wrote:

> > On Feb 18, 2021, at 2:11 PM, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> > 
> > On Fri, 12 Feb 2021 16:58:21 -0500
> > Chris Browy <cbrowy@avery-design.com> wrote:
> >   
> >>> On Feb 12, 2021, at 11:24 AM, Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >>> 
> >>> On Tue, 9 Feb 2021 15:35:49 -0500
> >>> Chris Browy <cbrowy@avery-design.com> wrote:
> >>> 
> >>> Run ./scripts/checkpatch.pl over the patches and fix all the warnings before
> >>> posting.  It will save time by clearing out most of the minor formatting issues
> >>> and similar that inevitably sneak in during development.
> >>>   
> >> Excellent suggestion.  We’re still newbies!
> >>   
> >>> The biggest issue I'm seeing in here is that the abstraction of
> >>> multiple DOE capabiltiies accessing same protocols doesn't make sense.
> >>> 
> >>> Each DOE ecap region and hence mailbox can have it's own set of
> >>> (possibly  overlapping) protocols.
> >>> 
> >>> From the ECN:
> >>> "It is permitted for a protocol using data object exchanges to require
> >>> that a Function implement a unique instance of DOE for that specific
> >>> protocol, and/or to allow sharing of a DOE instance to only a specific
> >>> set of protocols using data object exchange, and/or to allow a Function
> >>> to implement multiple instances of DOE supporting the specific protocol."
> >>> 
> >>> Tightly couple the ECAP and DOE.  If we are in the multiple instances
> >>> of DOE supporting a specific protocol case, then register it separately
> >>> for each one.  The individual device emulation then needs to deal with
> >>> any possible clashes etc.    
> >> 
> >> Not sure how configurable we want to make the device.  It is a simple type 3
> >> device after all.   
> > 
> > Agreed, but what I (or someone else) really doesn't want to have to do
> > in the future is reimplement DOE because we made design decisions that make
> > this version hard to reuse.  Unless it is particularly nasty to do we should
> > try to design something that is generally useful rather than targeted to
> > closely at the specific case we are dealing with.
> > 
> > I'd argue the ECAP and the DOE mailbox are always tightly coupled 1-to-1.
> > Whether the device wants to implement multiple protocols on each DOE mailbox
> > or indeed run individual protocols on multiple DOE mailboxes is a design
> > decision, but the actual mechanics of DOE match up with the config
> > space structures anything else is impdef on the device.  
> 
> Yes I agree that there is 1-to-1 between DOE extended cap (ECAP) and DOE
> Mailbox.  If we want to provide complete flexibility we should let the user pass 
> device property arrays to QEMU command for how many DOE ECAP’s to build 
> out and how to assign protocol(s) to each of them.  Array index is the DOE 
> instance #.
> 
> Also we can provide a property for cdat binary (blob) filename to initialize 
> the CDAT structure[entries].  This just reads in whatever mix of CDAT structure
> types are in the blob.
> 
> -device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M \
>     doe-ecap-instances=2 \
>     doe-ecap[0]=5 // bitwise OR for protocols shared
>     doe-ecap[1]=2 //bitwise OR for protocols shared
>     doe-ecap-cdat[1]=mycdat.bin
> 
> where let’s say protocols bitvector
> bit [0]=CMA
> bit [1]=CDAT
> bit [2}=Compliance
> 
> Let me know if you some better alternatives and we’ll implement it.
> 

Gut feeling for DOE is that the particular combination of protocol and
ECAP/DOE is device dependent. As such...

I'm not sure we actually want to expose it as command line controllable at all.
If we do, I'd suggest a small number of sane choices that exercise cases
we want to check.

From a testing point of view, 2 DOE, one of which supports multiple
protocols and we will have enough to test likely failure modes in the code.

The one protocol running on multiple mailboxes is already covered by the
discovery protocol which they all support.  That might not exercise
all the potential problems on the emulator side (as no need to do
locking etc) but it will proabbly exercise those in the OS and firmware.

Almost all users of DOE functionality in QEMU in the long run are likely
to be emulating a particular device so will hard code the DOE instances present
on that device in their emulation of whatever PCIe device they are
emulating.

This is no different to picking a particular layout for config space.
We could make it fully flexible, but it's rarely useful to do so.

If anyone wants to check something unusual, they can hack it into
QEMU.

As a side note, a protocol bit vector is going to unmaintainable as
there will be lots of protocols and last thing we want is that vector
to mean different things on different emulated PCI devices.

Jonathan



> 
> >   
> >> 
> >> The DOE spec does leave it pretty arbitrary regarding N DOE instances (DOE 
> >> Extended Cap entry points) for M protocols, including where N>1 and M=1.  
> >> Currently we implement N=2 DOE caps (instances), one for CDAT, one for 
> >> Compliance Mode.[
> >> 
> >> Maybe a more complex MLD device might have one or more DOE instances 
> >> for the CDAT protocol alone to define each HDM but currently we only have 
> >> one pmem (SLD) so we can’t really do much more than what’s supported.
> >> 
> >> Open to further suggestion though.  Based on answer to above we’ll follow 
> >> the suggestion lower in the code review regarding 
> >>   
> > ...
> >   
> 

