Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD44C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Nov 2022 13:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbiKQNyC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Nov 2022 08:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiKQNx4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Nov 2022 08:53:56 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE0E56EC5
        for <linux-cxl@vger.kernel.org>; Thu, 17 Nov 2022 05:53:54 -0800 (PST)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NChCf00Kyz689QS;
        Thu, 17 Nov 2022 21:51:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 14:53:52 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 13:53:52 +0000
Date:   Thu, 17 Nov 2022 13:53:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gregory.price@memverge.com>
CC:     Gregory Price <gourry.memverge@gmail.com>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
        <marcel.apfelbaum@gmail.com>, <imammedo@redhat.com>,
        <ani@anisinha.ca>, <alison.schofield@intel.com>,
        <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        <bwidawsk@kernel.org>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <20221117135351.00003609@Huawei.com>
In-Reply-To: <Y3LIq0CvRMI5i4U3@memverge.com>
References: <20221026004737.3646-1-gregory.price@memverge.com>
        <20221026004737.3646-4-gregory.price@memverge.com>
        <20221114175341.000036c4@Huawei.com>
        <Y3LIq0CvRMI5i4U3@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 14 Nov 2022 18:00:59 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Mon, Nov 14, 2022 at 05:53:41PM +0000, Jonathan Cameron wrote:
> > Hi Gregory,
> > 
> > I've not been rushing on this purely because we are after the feature
> > freeze for this QEMU cycle so no great rush to line up new features
> > (and there was some fun with the pull request the previous set of QEMU
> > CXL features were in - unrelated to those patches).
> > 
> > A few comments inline.
> > 
> > Once I've chased down a segfault on power down of my qemu setup (that
> > seems to have nothing to do with the CXL support. *sigh*) I'll push out
> > an updated tree with this on it for testing purposes.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> All good, I've been wrapped up in other work.  Just ping me when you are
> pushing a new branch and i'll gladly rebased and address the notes.

https://gitlab.com/jic23/qemu/-/tree/cxl-2022-11-17

Has two patches from this series on top currently.  I'll switch those out
for your next version when available.

There is a segmentation fault on powering down the qemu VMs at the moment,
but it's not connected to the cxl code, but rather just memory backends
(happens with upstream, including when cxl is turned off and the memory
backends aren't being used).

I'm not currently carrying Ira's error injection series yet but otherwise this
has pretty much everything that is in flight.

Jonathan

> 
> Regards
> Gregory

