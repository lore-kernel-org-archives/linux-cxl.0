Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C9EC433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Dec 2021 19:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382881AbhLCTcV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:32:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:9374 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382879AbhLCTcV (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 3 Dec 2021 14:32:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="261053625"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="261053625"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 11:28:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="541725223"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 11:28:56 -0800
Subject: [PATCH 0/2] cxl/mailbox: Replace racy error checking with timeouts
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, ben.widawsky@intel.com,
        Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com
Date:   Fri, 03 Dec 2021 11:28:56 -0800
Message-ID: <163855973642.1338601.12855868083437118567.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Quoting patch2:

    Device status can change without warning at any point in time. This
    effectively means that no amount of status checking before a command is
    submitted can guarantee that the device is not in an error condition
    when the command is later submitted. The clearest signal that a device
    is not able to process commands is if it fails to process commands.

So while "cxl/pci: Don't poll doorbell for mailbox access" [1] trimmed
cxl_pci_mbox_get() a bit, it still checks status in racy manner. Just
drop it altogether, add a doorbell sanity check to the initial
mailbox setup, and rely on timeouts to report errors.

Also, in anticipation of a 60s not being enough for device-bringup
scenarios, and a module parameter as an override.

This drops patch 3 [2], replaces patch 5 [3], and adds "cxl/pci: Defer
mailbox status checks to command timeouts" to the "CXL port prep work"
series [4]. Jonathan, given the policy tweaks and addition of a module
parameter I did not carry forward your reviewed-by for "cxl/pci:
Implement Interface Ready Timeout", please have another look when you
get a chance.

[1]: https://lore.kernel.org/r/20211129214721.1668325-6-ben.widawsky@intel.com
[2]: https://lore.kernel.org/r/20211129214721.1668325-4-ben.widawsky@intel.com
[3]: https://lore.kernel.org/r/20211129214721.1668325-6-ben.widawsky@intel.com
[4]: https://lore.kernel.org/r/20211129214721.1668325-1-ben.widawsky@intel.com

---

Ben Widawsky (1):
      cxl/pci: Implement Interface Ready Timeout

Dan Williams (1):
      cxl/pci: Defer mailbox status checks to command timeouts


 drivers/cxl/pci.c |  160 +++++++++++++++++++++--------------------------------
 1 file changed, 64 insertions(+), 96 deletions(-)
