Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA95C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 06:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiGOG0K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiGOG0K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 02:26:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90176237FF
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657866369; x=1689402369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PTUSsSk2CbP4ECnciH7F628Xix45xxUjqyby8J8SofY=;
  b=aNVNvXfGgXLM7p1/FSd1EK0jAgSZp3EhnkEpcbsBJnwZ/rycQCWdnfF7
   Sbnt4Wwyka8ZnxKT+5BuM1swm3sL7Xj1NAxJhf85sGbTzOwLILekeqv60
   /XPQ6Al+LarylspdkEMHbhP/RGWyNXTQed2FEx+lCRa5gYBPmoSCCepiv
   eS+dfOqDvqG8u0+DTjRqbdXSdogNzagw3gT9f5/nZ+DfocuBCC3R/HYQy
   i8HKmTjoTbAjr+oCSoBDx6ILz0KT5ebsAP2+56yb4E6+A35C6A3swWeWj
   iUJ5S9tvTfsSGbX9ekdnclUa0iZU48eQ0cy/MXhHBSJk2dovmr9hZ68VH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286852210"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="286852210"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 23:26:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="546544604"
Received: from saseiper-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.71.32])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 23:26:08 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 1/8] libcxl: add a depth attribute to cxl_port
Date:   Fri, 15 Jul 2022 00:25:43 -0600
Message-Id: <20220715062550.789736-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220715062550.789736-1-vishal.l.verma@intel.com>
References: <20220715062550.789736-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; h=from:subject; bh=PTUSsSk2CbP4ECnciH7F628Xix45xxUjqyby8J8SofY=; b=owGbwMvMwCXGf25diOft7jLG02pJDEkXOXJDgy9ej3oWcPMm42bf+khxwyWO06dPOcxzoH2pCCOr te6HjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAExEyp7hn6FM1zpm7o7wb+ftufsYOB /Je8e+qHK8uPmf4o4OE0HDEwz/098biE28z7PbpEfg/OJzrMJvZNoVr7yeotHjUHE47+AuBgA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a depth attribute to the cxl_port structure, that can be used for
calculating its distance from the root port, and will be needed for
interleave granularity calculations during region creation.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/lib/private.h | 1 +
 cxl/lib/libcxl.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index f6d4573..832a815 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -66,6 +66,7 @@ struct cxl_port {
 	int decoders_init;
 	int dports_init;
 	int nr_dports;
+	int depth;
 	struct cxl_ctx *ctx;
 	struct cxl_bus *bus;
 	enum cxl_port_type type;
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index be6bc2c..946cd4b 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -744,6 +744,7 @@ static int cxl_port_init(struct cxl_port *port, struct cxl_port *parent_port,
 	port->type = type;
 	port->parent = parent_port;
 	port->type = type;
+	port->depth = parent_port ? parent_port->depth + 1 : 0;
 
 	list_head_init(&port->child_ports);
 	list_head_init(&port->endpoints);
-- 
2.36.1

