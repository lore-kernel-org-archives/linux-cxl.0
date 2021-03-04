Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FBBC433E0
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Mar 2021 19:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7942664F65
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Mar 2021 19:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhCDTxX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Mar 2021 14:53:23 -0500
Received: from server.avery-design.com ([198.57.169.184]:49984 "EHLO
        server.avery-design.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhCDTwy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Mar 2021 14:52:54 -0500
Received: from ool-44c0a99c.dyn.optonline.net ([68.192.169.156]:52191 helo=[192.168.1.180])
        by server.avery-design.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <cbrowy@avery-design.com>)
        id 1lHtzD-00008B-PE; Thu, 04 Mar 2021 19:50:15 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH v2 1/2] Basic PCIe DOE support
From:   Chris Browy <cbrowy@avery-design.com>
In-Reply-To: <20210304192158.00004296@Huawei.com>
Date:   Thu, 4 Mar 2021 14:50:14 -0500
Cc:     armbru@redhat.com, Ben Widawsky <ben.widawsky@intel.com>,
        dan.j.williams@intel.com, david@redhat.com, f4bug@amsat.org,
        imammedo@redhat.com, ira.weiny@intel.com, jgroves@micron.com,
        linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
        vishal.l.verma@intel.com, Huai-Cheng <hchkuo@avery-design.com.tw>
Reply-To: "20210304192158.00004296@huawei.com" 
          <20210304192158.00004296@Huawei.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <E4FC0C46-FAED-4F9B-BC7B-B770DA517F6F@avery-design.com>
References: <1612900760-7361-1-git-send-email-cbrowy@avery-design.com>
 <1612902949-9992-1-git-send-email-cbrowy@avery-design.com>
 <20210304192158.00004296@Huawei.com>
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



> On Mar 4, 2021, at 2:21 PM, Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> On Tue, 9 Feb 2021 15:35:49 -0500
> Chris Browy <cbrowy@avery-design.com> wrote:
> 
> Hi Chris,
> 
> One more thing hit whilst debugging linux side of this.
> 
>> +static void pcie_doe_irq_assert(DOECap *doe_cap)
>> +{
>> +    PCIDevice *dev = doe_cap->doe->pdev;
>> +
>> +    if (doe_cap->cap.intr && doe_cap->ctrl.intr) {
> 
> 
> need something like
> 
> doe_cap->status.intr = 1;
> 
> I think or anyone checking the status register is going to think
> this interrupt is spurious.

You’re absolutely right, good catch!

> 
> Otherwise all seems to work. I need to do a bit of tidying up on
> kernel code but should be able to send out early next week.
> 

We’re putting out the v3 by end of this week.  We’re spent a bit longer
tidying up on our end but sounds like coming together real soon in 5.12 
release!

>> +        /* Interrupt notify */
>> +        if (msix_enabled(dev)) {
>> +            msix_notify(dev, doe_cap->cap.vec);
>> +        } else if (msi_enabled(dev)) {
>> +            msi_notify(dev, doe_cap->cap.vec);
>> +        }
>> +        /* Not support legacy IRQ */
>> +    }
>> +}

