Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E8DC54EBE
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 15:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjAMPtJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 10:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjAMPsP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 10:48:15 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D61583E
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 07:40:12 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtlrQ0dDqz6J74W;
        Fri, 13 Jan 2023 23:36:22 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 13 Jan 2023 15:40:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC:     <linuxarm@huawei.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: [RFC PATCH 0/2] CXL UE RAS Multiple Header Logging support
Date:   Fri, 13 Jan 2023 15:40:09 +0000
Message-ID: <20230113154011.16205-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL UE RAS Error reporting allows an EP to report the capability of
recording Multiple Header Logs for uncorrectable errors.
Unlike equivalent feature in PCIe, there is no enable control
for this feature, so a supporting device may be expecting
a more complex software flow than that necessary for devices
that do not support this feature. Documentation of this feature
is sparse, with assumption it works the same as PCIe.

There are hardware implementation choices allowed in the
equivalent PCIe r6.0 base spec section (6.4.2.4) that could
be safely used with the existing code, even with Multiple
Header Recording support but there are others that cannot.

The issue is what happens when the EP is doing Multiple Header
Recording but then the software writes 1 to clear more than one
status bit at the time (PCIe spec warns against doing this
 - but it is what the current kernel code will do):
Option 1)
  It does the nice thing and clears all matching errors.
  Note this is a bit strange for the case where the device
  supports logging multiple instances of a given error - so
  the two can't be combined cleanly.  With that feature
  I can't see how anyone could implement hardware that coped
  cleanly with the wrong software flow.
Option 2)
  It clears only the first error bit leaving a bunch of error
  bits set (note that if it has recorded multiple errors of
  same type it might not even do that). These are sticky
  across resets, so you will probably end up coming back up
  and immediately seeing an error.

So whilst you can design an EP to safe against non MH recording
aware software, it isn't generally the case. As we don't have
an explicit enable on CXL we have to handle anything reporting
the capability in a MH safe fashion.

This feature was developed against emulation in QEMU.
The relevant patches have not yet been posted but can be found on
https://gitlab.com/jic23/qemu/-/commits/cxl-2023-01-11
along with description of how to inject errors in the patch
descriptions.  I'll post them for review for QEMU inclusion
shortly.

RFC simply because the lack of specification detail means I am
less sure on this code than I would normally be. Unfortunately it
could be argued that the first patch is a fix for the
current upstream CXL RAS support.  If we want a simpler fix
one option would be to just fail to enable RAS support if
Multiple Header recording capability bit is set.  Or we
decide that it doesn't matter for now and add support for this
feature via the normal merge cycle.

Second patch is just there to make this easier to test as
no additional software is needed to print the header log.

Base is rather messy due to a clash between multiple cxl tree
branches.
cxl/fixes with the trace move on cxl/next cherry picked on top
as it moves the code that was fixed.

Jonathan Cameron (2):
  cxl: RAS: Multiple header recording support
  cxl: Add tprintk support for header log hex dump

 drivers/cxl/core/pci.c   | 17 ++++++++++++-----
 drivers/cxl/core/trace.h |  7 +++++--
 drivers/cxl/cxl.h        |  1 +
 3 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.37.2

