Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D82C43381
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 00:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B17964EC7
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 00:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhBSAuS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Feb 2021 19:50:18 -0500
Received: from server.avery-design.com ([198.57.169.184]:49972 "EHLO
        server.avery-design.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhBSAuN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 Feb 2021 19:50:13 -0500
Received: from ool-944ab965.dyn.optonline.net ([148.74.185.101]:55696 helo=[192.168.1.180])
        by server.avery-design.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <cbrowy@avery-design.com>)
        id 1lCtpB-00011R-WB; Fri, 19 Feb 2021 00:39:14 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH v2 1/2] Basic PCIe DOE support
From:   Chris Browy <cbrowy@avery-design.com>
In-Reply-To: <20210218191143.00000cdf@Huawei.com>
Date:   Thu, 18 Feb 2021 19:46:54 -0500
Cc:     "20210212162442.00007c1d@huawei.com" 
        <20210212162442.00007c1d@Huawei.com>, armbru@redhat.com,
        Ben Widawsky <ben.widawsky@intel.com>,
        dan.j.williams@intel.com, david@redhat.com, f4bug@amsat.org,
        imammedo@redhat.com, ira.weiny@intel.com, jgroves@micron.com,
        linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
        vishal.l.verma@intel.com
Reply-To: "20210218191143.00000cdf@huawei.com" 
          <20210218191143.00000cdf@Huawei.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DDBDE314-FA91-4E43-9484-F83E446B6EE4@avery-design.com>
References: <1612900760-7361-1-git-send-email-cbrowy@avery-design.com>
 <1612902949-9992-1-git-send-email-cbrowy@avery-design.com>
 <20210212162442.00007c1d@Huawei.com>
 <8A5C244A-DF9A-4EB5-8C24-568A606E75B0@avery-design.com>
 <20210218191143.00000cdf@Huawei.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.avery-design.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avery-design.com
X-Get-Message-Sender-Via: server.avery-design.com: authenticated_id: cbrowy@avery-design.com
X-Authenticated-Sender: server.avery-design.com: cbrowy@avery-design.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Feb 18, 2021, at 2:11 PM, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> On Fri, 12 Feb 2021 16:58:21 -0500
> Chris Browy <cbrowy@avery-design.com> wrote:
> 
>>> On Feb 12, 2021, at 11:24 AM, Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>>> 
>>> On Tue, 9 Feb 2021 15:35:49 -0500
>>> Chris Browy <cbrowy@avery-design.com> wrote:
>>> 
>>> Run ./scripts/checkpatch.pl over the patches and fix all the warnings before
>>> posting.  It will save time by clearing out most of the minor formatting issues
>>> and similar that inevitably sneak in during development.
>>> 
>> Excellent suggestion.  We’re still newbies!
>> 
>>> The biggest issue I'm seeing in here is that the abstraction of
>>> multiple DOE capabiltiies accessing same protocols doesn't make sense.
>>> 
>>> Each DOE ecap region and hence mailbox can have it's own set of
>>> (possibly  overlapping) protocols.
>>> 
>>> From the ECN:
>>> "It is permitted for a protocol using data object exchanges to require
>>> that a Function implement a unique instance of DOE for that specific
>>> protocol, and/or to allow sharing of a DOE instance to only a specific
>>> set of protocols using data object exchange, and/or to allow a Function
>>> to implement multiple instances of DOE supporting the specific protocol."
>>> 
>>> Tightly couple the ECAP and DOE.  If we are in the multiple instances
>>> of DOE supporting a specific protocol case, then register it separately
>>> for each one.  The individual device emulation then needs to deal with
>>> any possible clashes etc.  
>> 
>> Not sure how configurable we want to make the device.  It is a simple type 3
>> device after all. 
> 
> Agreed, but what I (or someone else) really doesn't want to have to do
> in the future is reimplement DOE because we made design decisions that make
> this version hard to reuse.  Unless it is particularly nasty to do we should
> try to design something that is generally useful rather than targeted to
> closely at the specific case we are dealing with.
> 
> I'd argue the ECAP and the DOE mailbox are always tightly coupled 1-to-1.
> Whether the device wants to implement multiple protocols on each DOE mailbox
> or indeed run individual protocols on multiple DOE mailboxes is a design
> decision, but the actual mechanics of DOE match up with the config
> space structures anything else is impdef on the device.

Yes I agree that there is 1-to-1 between DOE extended cap (ECAP) and DOE
Mailbox.  If we want to provide complete flexibility we should let the user pass 
device property arrays to QEMU command for how many DOE ECAP’s to build 
out and how to assign protocol(s) to each of them.  Array index is the DOE 
instance #.

Also we can provide a property for cdat binary (blob) filename to initialize 
the CDAT structure[entries].  This just reads in whatever mix of CDAT structure
types are in the blob.

-device cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M \
    doe-ecap-instances=2 \
    doe-ecap[0]=5 // bitwise OR for protocols shared
    doe-ecap[1]=2 //bitwise OR for protocols shared
    doe-ecap-cdat[1]=mycdat.bin

where let’s say protocols bitvector
bit [0]=CMA
bit [1]=CDAT
bit [2}=Compliance

Let me know if you some better alternatives and we’ll implement it.


> 
>> 
>> The DOE spec does leave it pretty arbitrary regarding N DOE instances (DOE 
>> Extended Cap entry points) for M protocols, including where N>1 and M=1.  
>> Currently we implement N=2 DOE caps (instances), one for CDAT, one for 
>> Compliance Mode.[
>> 
>> Maybe a more complex MLD device might have one or more DOE instances 
>> for the CDAT protocol alone to define each HDM but currently we only have 
>> one pmem (SLD) so we can’t really do much more than what’s supported.
>> 
>> Open to further suggestion though.  Based on answer to above we’ll follow 
>> the suggestion lower in the code review regarding 
>> 
> ...
> 

