Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FA9C3F6B0
	for <linux-cxl@archiver.kernel.org>; Mon, 15 Aug 2022 21:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345230AbiHOV2W (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347323AbiHOVZh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 17:25:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546992F018
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660591364; x=1692127364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8MiiEmJrUVg6tXUUT3jHHbUKQ3S9VPBvZYaANeWql+s=;
  b=bKCVozSv3zrzsUt6LnM6CAhbv4j1e/slSRBiaxzgt+sCmwjGjaNmYURF
   3b2gKuk/t33zQY+ApeLSYZQfiEND3pk934wQk5ii+Bg9YoXECEzThFh57
   oihFZoE2qSW97DLe/8KcT9XSSpkAo7MiHSycLPP9BYrqv8ohNtXe2cpe4
   BQk4pwXP3lejHb6ncmkDxyGTcAdmaDkzctEx8OxsmoVtOeslS1D22kxZL
   YLihJq9SxDWcQ5RxK/nbkf6giP/ye4DmLlURCNoLD6eRKUlDCF782Uln1
   wIuydxA3lf+IJHOq4zto8c4QsIXC8DjdRbQUJKhi1Dqsmxev7JELT5BfO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293313121"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="293313121"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 12:22:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="606758239"
Received: from smadiset-mobl1.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.5.99])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 12:22:18 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v3 01/11] libcxl: add a depth attribute to cxl_port
Date:   Mon, 15 Aug 2022 13:22:04 -0600
Message-Id: <20220815192214.545800-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815192214.545800-1-vishal.l.verma@intel.com>
References: <20220815192214.545800-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; h=from:subject; bh=8MiiEmJrUVg6tXUUT3jHHbUKQ3S9VPBvZYaANeWql+s=; b=owGbwMvMwCXGf25diOft7jLG02pJDEm/5jzdnFGQtnwnh+BFjX+8zMfjL6TctTFQYveX0dki9Lji 3Kc7HaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZiIox0jwwwDhYW7uzTk5viJ6fYaXN tw+s09s49cN7NYbz1Pye/8soHhf/qht/cdmy1uRbI7PbbIv3v70tK9hnvEvm6eIx9a8j9jMRcA
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

