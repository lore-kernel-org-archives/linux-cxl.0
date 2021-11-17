Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253BBC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Nov 2021 17:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0787D61BFB
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Nov 2021 17:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhKQRfG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Nov 2021 12:35:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4102 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbhKQRfF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Nov 2021 12:35:05 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HvVNV1r9Xz67KQL;
        Thu, 18 Nov 2021 01:31:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 17 Nov 2021 18:32:04 +0100
Received: from localhost (10.52.126.160) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 17 Nov
 2021 17:32:04 +0000
Date:   Wed, 17 Nov 2021 17:32:01 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     Saransh Gupta1 <saransh@ibm.com>, <linux-cxl@vger.kernel.org>,
        <qemu-devel@nongnu.org>
Subject: Re: Follow-up on the CXL discussion at OFTC
Message-ID: <20211117173201.00002513@Huawei.com>
In-Reply-To: <20211117165719.pqig62t5z2grgjvv@intel.com>
References: <OF255704A1.78FEF164-ON0025878E.00821084-0025878F.00015560@ibm.com>
        <20211117165719.pqig62t5z2grgjvv@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.160]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 17 Nov 2021 08:57:19 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Hi Saransh. Please add the list for these kind of questions. I've converted your
> HTML mail, but going forward, the list will eat it, so please use text only.
> 
> On 21-11-16 00:14:33, Saransh Gupta1 wrote:
> >    Hi Ben,
> > 
> >    This is Saransh from IBM. Sorry to have (unintentionally) dropped out
> >    of the conversion on OFTC, I'm new to IRC.
> >    Just wanted to follow-up on the discussion there. We discussed about
> >    helping with linux patches reviews. On that front, I have identified
> >    some colleague(s) who can help me with this. Let me know if/how you
> >    want to proceed with that.  
> 
> Currently the ball is in my court to re-roll the RFC v2 patches [1] based on
> feedback from Dan. I've implemented all/most of it, but I'm still debugging some
> issues with the result.
> 
> > 
> >    Maybe not urgently, but my team would also like to get an understanding
> >    of the missing pieces in QEMU. Initially our focus is on type3 memory
> >    access and hotplug support. Most of the work that my team does is
> >    open-source, so contributing to the QEMU effort is another possible
> >    line of collaboration.  
> 
> If you haven't seen it already, check out my LPC talk [2]. The QEMU patches
> could use a lot of love. Mostly, I have little/no motivation until upstream
> shows an interest because I don't have time currently to make sure I don't break
> vs. upstream. If you want more details here, I can provide them, and I will Cc
> the qemu-devel mailing list; the end of the LPC talk [2] does have a list.
Hi Ben, Saransh

I have a forward port of the series + DOE etc to near current QEMU that is lightly tested,
and can look to push that out publicly later this week.

I'd also like to push QEMU support forwards and to start getting this upstream in QEMU
+ fill in some of the missing parts.

Was aiming to make progress on this a few weeks ago, but as ever other stuff
got in the way.

+CC qemu-devel in case anyone else also looking at this.

Jonathan



> 
> > 
> >    Thanks for your help and guidance!
> > 
> >    Best,
> >    Saransh Gupta
> >    Research Staff Member, IBM Research  
> 
> [1]: https://lore.kernel.org/linux-cxl/20211022183709.1199701-1-ben.widawsky@intel.com/T/#t
> [2]: https://www.youtube.com/watch?v=g89SLjt5Bd4&list=PLVsQ_xZBEyN3wA8Ej4BUjudXFbXuxhnfc&index=49

