Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06020C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 21:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbiHQVWA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 17:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiHQVV7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 17:21:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5399BA598F
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660771319; x=1692307319;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T/pSJqcSTEdpoMuCFrcd+/my6mKmMgTWveifoWDRxhw=;
  b=H2K7n78c4v7Jr3k3G4CihWtHdTRRGojsXBxvc4tP6/5FQEVy37EGYI5C
   ocnNqcWuwDJwgdwZ2K3KYfhz0jG+TxL1O51uVem7hqFexGp34YwBkb3Kl
   NLX5mFdULsFYR2DTrgMXocnkkT/jgd1ssD7cgQvhWvDLhE8JUAnzGqCSq
   +5PsMqPJMOMbkwNQ5i/wozRLpkxnG0Cf0YVtex/qQFUrDKIMfYgbS+F0j
   BKjue29fYBRKwsCVa2BsbiyCpwFrKkqwRYLdruw4fBrpt/nJSweSHeWMB
   SJHN0FMZjc0UQEcNetOm5OnlGR7fumhmOY5STpkDSv+/taSsucsTnu3ht
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="279571156"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="279571156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:21:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="640615849"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:21:58 -0700
Subject: [PATCH v4 4/6] cxl: change cxl_port_attribute_groups naming to avoid
 confusion
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Wed, 17 Aug 2022 14:21:58 -0700
Message-ID: <166077131892.1743055.1029132844466334751.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
References: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Both cxl/port.c and cxl/core/port.c have cxl_port_attribute_groups. Change
cxl_port_attribute_groups in cxl/port.c to cxl_port_dynamic_attr_groups in
order to avoid confusion.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/port.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5453771bf330..c4aa073b7e31 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -123,7 +123,7 @@ static struct attribute_group cxl_cdat_attribute_group = {
 	.is_bin_visible = cxl_port_bin_attr_is_visible,
 };
 
-static const struct attribute_group *cxl_port_attribute_groups[] = {
+static const struct attribute_group *cxl_port_dynamic_attr_groups[] = {
 	&cxl_cdat_attribute_group,
 	NULL,
 };
@@ -133,7 +133,7 @@ static struct cxl_driver cxl_port_driver = {
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
 	.drv = {
-		.dev_groups = cxl_port_attribute_groups,
+		.dev_groups = cxl_port_dynamic_attr_groups,
 	},
 };
 


