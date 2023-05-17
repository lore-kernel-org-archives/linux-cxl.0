Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303D3C77B75
	for <linux-cxl@archiver.kernel.org>; Wed, 17 May 2023 00:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEQAWk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 20:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEQAWj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 20:22:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A440DF
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 17:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684282958; x=1715818958;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aXs17F8Pc9fF60oenOWHbe9xuDdPTRIrfzE056coTic=;
  b=Onh4ZQb7aNcBR6CRcuhLnxCx/3aUVq/1YAgb3fJLGHZtTk7ub8YDTp7g
   oTBNEh1AZh1C46+Rj9ZKMFqvwMwbbPR0ej5QoAo2ht2+8C8Tz+ca5z5P5
   rGxbDWb2LAMOsY78wssYEIP8Iksef0ojKrd7OVj1n7vcp0dyJYzpEiKzO
   5HDvWIEdgm4XEYXP27QYMoCJFpLtMSuo6bo9/8ZP70+pM4Ngy/KlIfrts
   471BaIC4I176IuUMroK5smeMXQrMNjhUxA+moH7lVT3W25mJ1YvdiGuDC
   cEOfxG+q5VHTFagXTqers16yAISAdsLmpMYaNZagcCxn2rpLcQZ1txa1D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="350465289"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="350465289"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="679064045"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="679064045"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.5.122])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 17:22:33 -0700
Subject: [PATCH 0/3] cxl: Move operations after memory is ready
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Tue, 16 May 2023 17:22:32 -0700
Message-ID: <168428284429.2205351.8883627879572769367.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This series contains fixes broken out from the QTG ID series. It augments
the Memory_Info_Valid check and move the relevant operations that needs to
happen after memory is valid behind the check.

---

Dave Jiang (3):
      cxl: Wait Memory_Info_Valid before access memory related info
      cxl: Move identify and partition query from pci probe to port probe
      cxl: Move read_cdat_data() to after media is ready


 drivers/cxl/core/pci.c | 83 ++++++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxlpci.h   |  2 +
 drivers/cxl/pci.c      |  8 ----
 drivers/cxl/port.c     | 14 +++++--
 4 files changed, 88 insertions(+), 19 deletions(-)

--

