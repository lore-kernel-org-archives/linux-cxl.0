Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCE7C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Aug 2022 23:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiHJXJp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiHJXJl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 Aug 2022 19:09:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B127858F
        for <linux-cxl@vger.kernel.org>; Wed, 10 Aug 2022 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660172979; x=1691708979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8MiiEmJrUVg6tXUUT3jHHbUKQ3S9VPBvZYaANeWql+s=;
  b=hdvBERTmBK6YU+7btvOXITFhBEYT9SJJfUGmzLb7EXJxRmJO9IV1yUkP
   oohp0HGyHIFVmm88uz2ueTIzrUtUAwYuN5F7swIbmF0A7U80hUMXRfsvF
   4+uRUHgYH4+rzRu/8ECQVJ1QNCdLER11XFB0lWqmPK1PxJUlBmy4eULWP
   KcF77hC3EnYFErEa0G4/ZI5DEB4PHvi+xbd8oVEvCACMVkAfUx1q9uBh0
   wFkm12/E6yGHgoZoytZY3rm/9f/oA/b1J32WcPh0xBlydTBN+VL1f5ak5
   GAPOQV5ijgxrxDw8lAdu71pCG04L4Ui8Y+bNxnlnp53NkLASOzWc7fHra
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271599776"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271599776"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:09:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="581429423"
Received: from maughenb-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.94.5])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:09:31 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v2 01/10] libcxl: add a depth attribute to cxl_port
Date:   Wed, 10 Aug 2022 17:09:05 -0600
Message-Id: <20220810230914.549611-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810230914.549611-1-vishal.l.verma@intel.com>
References: <20220810230914.549611-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; h=from:subject; bh=8MiiEmJrUVg6tXUUT3jHHbUKQ3S9VPBvZYaANeWql+s=; b=owGbwMvMwCXGf25diOft7jLG02pJDElfrGZszihIW76TQ/Cixj9e5uPxF1Lu2hgosfvL6GwRelxx 7tOdjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEzk2B1GhkOOv+btDfofq7DNsn7NKR ++xU93fvWeudIyWXaXoCLr3SZGhgfaJ+vfNf0LrUnVtDmQuPj0kaVl/ndmlO19+O9dn3v1OgYA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a depth attribute to the cxl_port structure, that can be used for
calculating its distance from the root port, and will be needed for
interleave granularity calculations during region creation.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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
2.37.1

