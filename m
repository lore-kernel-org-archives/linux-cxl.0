Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F841C7EE22
	for <linux-cxl@archiver.kernel.org>; Wed, 10 May 2023 18:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbjEJSoz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 May 2023 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjEJSox (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 May 2023 14:44:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44BD192
        for <linux-cxl@vger.kernel.org>; Wed, 10 May 2023 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683744288; x=1715280288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NfoRdAcWIpZiBUmLDyQdOxAswwlz5g4XpU706H4ZUjA=;
  b=ZtJuCqYi4elnWm/ASa/7hycIU0wh/strwJUwtR3UduDPvkW9cnnU134n
   1E3ELrBGAIBuKeaTddDm5OusLxngjDkmzIqMLDeSjeqKxgITEH2kh94RI
   sXRPnl95wjvI+z1Cp9Ch5TnR39oBswkfbP5YzpDpdms4xI0ijdvy7Yaec
   PkQcddGjjvEXxzJWNuvtHCf5OuvH7mqJfHwipNmxRPTCKZ7LsAprgn6eU
   gRZqrdF9GxeI8AKXJWSHE3gHtP49F9TOPOlNYYZgehZf69BZRed69gqmI
   V732T0P0ytCSG6B7xsH6PFbRwaoBhQ04bhauE7jaKNqRROYjd4dn09uNc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="353370157"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="353370157"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="769004652"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="769004652"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.34.89])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 11:44:35 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [RFC 3/3] ACPI: NUMA: Apply SRAT proximity domain to entire CFMWS window
Date:   Wed, 10 May 2023 11:44:28 -0700
Message-Id: <79a10b7101a8fab56f9ff3f9a4de73bee3156b40.1683742429.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1683742429.git.alison.schofield@intel.com>
References: <cover.1683742429.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
CFMWS not in SRAT") did not account for the case where an SRAT entry
only partially describes a CFMWS window. It assumed an SRAT entry
covered the entire CFMWS HPA range, start through end.

Broaden the search for an SRAT defined NUMA node, by replacing the
previously used phys_to_targe_node(start) search, with the recently
introduced, numa_find_node(), that can discover a NUMA node anywhere
in the CFMWS HPA range.

If any NUMA node is discovered, proactively cleanup, by removing any
memblks, partial or whole, in the HPA range, and add one memblk that
encompasses the entire range. That has the effect of applying the SRAT
defined proximity domain to the entire range, as well as doing a memblk
cleanup at the point a redundancy is created.

Considered and rejected, letting numa_cleanup_meminfo() try to remove
the redundancy. It doesn't currently address this case, because these
memblks will be moved to numa_reserved_meminfo, before any numa_meminfo
merge is done. Also, the merge logic in numa_cleanup_meminfo() works
on adjacent memblks, so it would need to grow in complexity to search
for these potential cases.

Considered and ready to reconsider,  allow an extra memblk for every
CFMWS HPA range that is also described in the SRAT. Is that a concern?
If not a concern to have the extra memblk, then skip the memblk remove
work entirely.

Fixes: fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/acpi/numa/srat.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 1f4fc5f8a819..f41b65e9b085 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -301,27 +301,47 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 				   void *arg, const unsigned long table_end)
 {
+	int node, found_node, *fake_pxm = arg;
 	struct acpi_cedt_cfmws *cfmws;
-	int *fake_pxm = arg;
 	u64 start, end;
-	int node;
 
 	cfmws = (struct acpi_cedt_cfmws *)header;
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
-	/* Skip if the SRAT already described the NUMA details for this HPA */
-	node = phys_to_target_node(start);
-	if (node != NUMA_NO_NODE)
+	/*
+	 * The SRAT may have already described the NUMA details for
+	 * this CFMWS HPA range, yet it may not have created memblks
+	 * for the entire range. Look for a node with a memblk covering
+	 * any part of the HPA range. Don't bother figuring out if it
+	 * is partially or wholly described. Replace any memblks in the
+	 * range with one single memblk that covers the entire range.
+	 *
+	 * This preserves the SRAT defined node and Proximity Domain.
+	 */
+
+	found_node = numa_find_node(start, end);
+	if (found_node != NUMA_NO_NODE) {
+		numa_remove_memblks(found_node, start, end);
+		if (numa_add_memblk(found_node, start, end) < 0) {
+			/* CXL driver must handle the NUMA_NO_NODE case */
+			pr_warn("ACPI NUMA: failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
+				found_node, start, end);
+		}
 		return 0;
+	}
 
+	/*
+	 * SRAT did not describe this window at all.
+	 * Create a new node with a fake proximity domain. Add a
+	 * memblk covering the entire HPA range.
+	 */
 	node = acpi_map_pxm_to_node(*fake_pxm);
 
 	if (node == NUMA_NO_NODE) {
 		pr_err("ACPI NUMA: Too many proximity domains while processing CFMWS.\n");
 		return -EINVAL;
 	}
-
 	if (numa_add_memblk(node, start, end) < 0) {
 		/* CXL driver must handle the NUMA_NO_NODE case */
 		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
-- 
2.37.3

