Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9F5C4332F
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Dec 2022 01:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiLQBda (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 20:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQBd2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 20:33:28 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2085A7331C
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 17:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671240808; x=1702776808;
  h=subject:from:to:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nmsGWbC6z6XtKXwmwcV+yNR8C7ewaPt6wRU0ql1cOFc=;
  b=P+ZdPORk1WbTMxPmdu4Al3UtK67Kc2eN7Ru+270fR0G+63JLSxyqEvgR
   1q8JWj3mKCC5QH7mPxmrNzrskJv5ji5/LrW+D8f90RtKrUvC/XUVMnWce
   Zo6x83HkCmtt+nogrLxKUvCsqaKZe+HLiEo7y7nfv4QFh0eb4cbrWned3
   GT7W8CKIm3QxDYtSyq5z8Le+CcrW5iPJFeHIGiMBH/teTBUUtSXdSwlSm
   YSUVZLoaUYJ3biHVR/vIzZkdr5eL0CVPVV+Kf5ATsicXZfBvtUTP3qaVq
   6xv9ct/3VE4YgdL21akrzbt80gX03SgZNZhbQezBY80D0PkvPyeg/6T6D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="302513768"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="302513768"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 17:33:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="649993064"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="649993064"
Received: from smukhe4-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.110.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 17:33:27 -0800
Subject: [PATCH 0/3] cxl: Misc fixups that missed v6.2
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Fri, 16 Dec 2022 17:33:27 -0800
Message-ID: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

While working on volatile region enumeration in the v6.1 timeframe I put
together these small fixups and a new attribute to help topology
walking. I overlooked them for v6.2, but will now target them for v6.3.

The most significant change is a 'parent_dport' attribute so 'cxl list'
has a simple method to identify the downstream port that routes to the
descendant cxl_port (upstream port).

---

Dan Williams (3):
      cxl/mem: Quiet port walking warning
      cxl/region: Clarify when a cxld->commit() callback is mandatory
      cxl/port: Link the 'parent_dport' in portX/ and endpointX/ sysfs


 Documentation/ABI/testing/sysfs-bus-cxl |   15 +++++++++++++++
 drivers/cxl/core/port.c                 |   31 +++++++++++++++++++++++++++++--
 drivers/cxl/core/region.c               |   19 +++++++++++++++++--
 3 files changed, 61 insertions(+), 4 deletions(-)

base-commit: f04facfb993de47e2133b2b842d72b97b1c50162
