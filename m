Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819E7C4321E
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6768A60D42
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243700AbhJPFRz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:1751 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243686AbhJPFRw (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489619"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489619"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743328"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:44 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 22/27] cxl/region: HB port config verification
Date:   Fri, 15 Oct 2021 22:15:26 -0700
Message-Id: <20211016051531.622613-23-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Host bridge root port verification determines if the device ordering in
an interleave set can be programmed through the host bridges and
switches.

The algorithm implemented here is based on the CXL Type 3 Memory Device
Software Guide, chapter 2.13.15

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .clang-format        |  1 +
 drivers/cxl/cxl.h    |  3 ++
 drivers/cxl/region.c | 90 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/trace.h  |  3 ++
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 55f628f21722..96c282b63e7b 100644
--- a/.clang-format
+++ b/.clang-format
@@ -171,6 +171,7 @@ ForEachMacros:
   - 'for_each_cpu_wrap'
   - 'for_each_cxl_decoder_target'
   - 'for_each_cxl_endpoint'
+  - 'for_each_cxl_endpoint_hb'
   - 'for_each_dapm_widgets'
   - 'for_each_dev_addr'
   - 'for_each_dev_scope'
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f1a13d5fa7d7..a2062e370c85 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -300,6 +300,7 @@ struct cxl_port {
  * @port: reference to cxl_port that contains this downstream port
  * @list: node for a cxl_port's list of cxl_dport instances
  * @root_port_link: node for global list of root ports
+ * @verify_link: node used for hb root port verification
  */
 struct cxl_dport {
 	struct device *dport;
@@ -308,6 +309,8 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct list_head list;
 	struct list_head root_port_link;
+
+	struct list_head verify_link;
 };
 
 bool is_cxl_region(struct device *dev);
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 024d562ad161..81fed05cad00 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -4,6 +4,7 @@
 #include <linux/genalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/sort.h>
 #include <linux/pci.h>
 #include "cxlmem.h"
 #include "region.h"
@@ -30,6 +31,11 @@
 	for (idx = 0, ep = (region)->targets[idx]; idx < region_ways(region);  \
 	     idx++, ep = (region)->targets[idx])
 
+#define for_each_cxl_endpoint_hb(ep, region, hb, idx)                          \
+	for (idx = 0, ep = (region)->targets[idx]; idx < region_ways(region);  \
+	     idx++, ep = (region)->targets[idx])                               \
+		if (get_hostbridge(ep) == (hb))
+
 #define for_each_cxl_decoder_target(target, decoder, idx)                      \
 	for (idx = 0, target = (decoder)->target[idx];                         \
 	     idx < (decoder)->nr_targets;                                      \
@@ -261,6 +267,29 @@ static bool region_xhb_config_valid(const struct cxl_region *region,
 	return true;
 }
 
+static int get_num_root_ports(const struct cxl_region *region)
+{
+	struct cxl_memdev *endpoint;
+	struct cxl_dport *dport, *tmp;
+	int num_root_ports = 0;
+	LIST_HEAD(root_ports);
+	int idx;
+
+	for_each_cxl_endpoint(endpoint, region, idx) {
+		struct cxl_dport *root_port = endpoint->root_port;
+
+		if (list_empty(&root_port->verify_link)) {
+			list_add_tail(&root_port->verify_link, &root_ports);
+			num_root_ports++;
+		}
+	}
+
+	list_for_each_entry_safe(dport, tmp, &root_ports, verify_link)
+		list_del_init(&dport->verify_link);
+
+	return num_root_ports;
+}
+
 /**
  * region_hb_rp_config_valid() - determine root port ordering is correct
  * @cfmws: CFMWS decoder for this @region
@@ -274,7 +303,66 @@ static bool region_xhb_config_valid(const struct cxl_region *region,
 static bool region_hb_rp_config_valid(const struct cxl_region *region,
 				      const struct cxl_decoder *cfmws)
 {
-	/* TODO: */
+	const int num_root_ports = get_num_root_ports(region);
+	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	int hb_count, i;
+
+	hb_count = get_unique_hostbridges(region, hbs);
+
+	/*
+	 * Are all devices in this region on the same CXL Host Bridge
+	 * Root Port?
+	 */
+	if (num_root_ports == 1)
+		return true;
+
+	for (i = 0; i < hb_count; i++) {
+		struct cxl_port *hb = hbs[i];
+		struct cxl_dport *rp;
+		int position_mask;
+		int idx;
+
+		/*
+		 * Calculate the position mask: NumRootPorts = 2^PositionMask
+		 * for this region.
+		 *
+		 * XXX: pos_mask is actually (1 << PositionMask)  - 1
+		 */
+		position_mask = (1 << (ilog2(num_root_ports))) - 1;
+
+		/*
+		 * Calculate the PortGrouping for each device on this CXL Host
+		 * Bridge Root Port:
+		 * PortGrouping = RegionLabel.Position & PositionMask
+		 */
+		list_for_each_entry(rp, &hb->dports, list) {
+			struct cxl_memdev *ep;
+			int port_grouping = -1;
+
+			for_each_cxl_endpoint_hb(ep, region, hb, idx) {
+				if (ep->root_port != rp)
+					continue;
+
+				if (port_grouping == -1) {
+					port_grouping = idx & position_mask;
+					continue;
+				}
+
+				/*
+				 * Do all devices in the region connected to this CXL
+				 * Host Bridge Root Port have the same PortGrouping?
+				 */
+				if ((idx & position_mask) != port_grouping) {
+					trace_hb_rp_valid(region,
+							  "One or more devices are not connected to the correct Host Bridge Root Port\n");
+					return false;
+				}
+			}
+
+			/* TODO: Check switch programming */
+		}
+	}
+
 	return true;
 }
 
diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
index 4de47d1111ac..57fe9342817c 100644
--- a/drivers/cxl/trace.h
+++ b/drivers/cxl/trace.h
@@ -41,6 +41,9 @@ DEFINE_EVENT(cxl_region_template, allocation_failed,
 DEFINE_EVENT(cxl_region_template, xhb_valid,
 	     TP_PROTO(const struct cxl_region *region, char *status),
 	     TP_ARGS(region, status));
+DEFINE_EVENT(cxl_region_template, hb_rp_valid,
+	     TP_PROTO(const struct cxl_region *region, char *status),
+	     TP_ARGS(region, status));
 
 #endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
 
-- 
2.33.1

