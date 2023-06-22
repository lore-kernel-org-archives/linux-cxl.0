Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0958FEB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 14:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjFVOFB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 10:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjFVOEs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 10:04:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE451994
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 07:04:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn29m61VCz6J6L8;
        Thu, 22 Jun 2023 22:02:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 15:04:44 +0100
Date:   Thu, 22 Jun 2023 15:04:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 11/12] cxl/port: Enumerate cxl link capabilities
Message-ID: <20230622150443.000059ce@Huawei.com>
In-Reply-To: <648cb4f62a6a8_34cf08294de@dwillia2-xfh.jf.intel.com.notmuch>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
        <168679263707.3436160.10946564604121831708.stgit@dwillia2-xfh.jf.intel.com>
        <648ba7a78f549_142af8294c9@dwillia2-xfh.jf.intel.com.notmuch>
        <648cb4f62a6a8_34cf08294de@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 16 Jun 2023 12:16:06 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Dan Williams wrote:
> > Dan Williams wrote:  
> > > Per CXL 3.0 9.14 "Back-Invalidation Configuration", in order to enable
> > > an HDM-DB range (CXL.mem region with device initiated back-invalidation
> > > support), all ports in the path between the endpoint and the host bridge
> > > must be in 256-bit flit-mode.
> > > 
> > > Even for typical Type-3 class devices it is useful to enumerate link
> > > capabilities through the topology for debug purposes.
> > > 
> > > See CXL 3.0 Table-64 "256B Flit Mode vs. 68B Flit Mode Operation", for
> > > how to determine 64B vs 256B Flit mode operation.
> > > 
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/core/pci.c  |  113 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/core/port.c |    6 ++
> > >  drivers/cxl/cxl.h       |    7 +++
> > >  drivers/cxl/cxlpci.h    |   24 +++++++++-
> > >  drivers/cxl/port.c      |    5 ++
> > >  5 files changed, 153 insertions(+), 2 deletions(-)  
> > 
> > Going back over this again I noticed that it fails to actually store the
> > "features" in the port object, and it fails to claim that the root CXL
> > device can support all the capabilities. Here are those fixups to fold
> > in:  
> 
> ...and now it occurs to me that this approach falls over for RCH
> topologies as the link status registers potentially move into the RCRB
> space. So I want to test this on an RCH topology before this moves
> forward. The cxl_test RCH topology does not suffice since it only
> emulates the topology, not the register behavior, and QEMU is VH only.

Indeed awkward to test. Other than that, LGTM but I'll wait for the update
for any tags.

Thanks,

Jonathan

p.s. still open to someone adding an RCH to QEMU if anyone wants to :)
