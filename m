Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B08C7EE24
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbjEKSAE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbjEKR7x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 13:59:53 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC15A5EF
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683827973; x=1715363973;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CzsWt8T9nmEYJ5DD59h6yT2X4Rmm2yYVBltFO1nWdW4=;
  b=dGdGglLA6Z9yHB/y2Er8QzzdFGlvpzoh8buNMphnX41CUAcGhXhdNh5d
   RNEfTB86P0fQCt6UIR+/ONi1vxLvYMZbHJkvTgTZ4gOqNMYs/rgOdNPIp
   3/097K7raBFN21y1XwrVRtHxDrWaxZxJ7UMs4ipjurMJalSWk8EPNMQOi
   F5QVVlz0dkPTZbLqtt7KrSvad9Ci+NzrBz78JeeHMDlLhXQaKiCeIwSrw
   hFje45qAEx1Ahhe35ji/732R+8KdavBvaS92UJMSFc8rH197OMkVUMo3I
   Hyr0UdORZm45nbdtj3TLackSOczaESOiEkL54d5FDhaQqhShIxrPb9B1C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335091958"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="335091958"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:58:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="693904303"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="693904303"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.95.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:58:55 -0700
Subject: [PATCH v2 2/4] cxl: add missing return to cdat read error path
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Thu, 11 May 2023 10:58:55 -0700
Message-ID: <168382793506.3510737.4792518576623749076.stgit@djiang5-mobl3>
In-Reply-To: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
References: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a return to the error path when cxl_cdat_read_table() fails. Current
code continues with the table pointer points to freed memory.

Fixes: 4f8a8f10c2f5 ("cxl/pci: Simplify CDAT retrieval error path")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index bdbd907884ce..f332fe7af92b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -571,6 +571,7 @@ void read_cdat_data(struct cxl_port *port)
 		/* Don't leave table data allocated on error */
 		devm_kfree(dev, cdat_table);
 		dev_err(dev, "CDAT data read error\n");
+		return;
 	}
 
 	port->cdat.table = cdat_table + sizeof(__le32);


