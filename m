Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF9814
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPp6RdoW"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A8B0
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 18:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986340; x=1728522340;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aKn0SPEHGlZv/ogsxW74cETbi4HUtSWJPu7/P3VITpo=;
  b=aPp6RdoWRSq9PjgtqJv22GmBKyEFJwp+dYX7YR6J6UYwPWtQ3+eVw8fT
   NE5crpmSyJOpVxXXv+Rmo6qhKRRdX01EEkMc7gsCpiLoRgvHCIo19X0/l
   G4/QXTjLSOnNZM6zi4hFBW0ekpw3w9yU+HYd2N5TFFRnFkVrMYtlmDy3r
   3CA/lKzufqtRhI8k8b/fiC/LnJoCiUG6BoHncN5n8CODqvcUo5gMdyPY3
   vUkt9n+d/hcnEXeEoYFfqoYZERiJP1PQkbxiJB9TrMWO+jseEhmYAYw2h
   6iQV5PIfQxa8s03JhlJ5Q3WtwfX3OHJwQod32ZQzWYPwyZEyCBXaCZscE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374893240"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="374893240"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730307045"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730307045"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.35.251])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:05:40 -0700
Subject: [PATCH v10 07/22] acpi: numa: Create enum for memory_target access
 coordinates indexing
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 10 Oct 2023 18:05:39 -0700
Message-ID: <169698633971.1991735.34513057888809594.stgit@djiang5-mobl3>
In-Reply-To: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Create enums to provide named indexing for the access coordinate array.
This is in preparation for adding generic port support which will add a
third index in the array to keep the generic port attributes separate from
the memory attributes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/numa/hmat.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index f9ff992038fa..abed728bf09d 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -57,12 +57,18 @@ struct target_cache {
 	struct node_cache_attrs cache_attrs;
 };
 
+enum {
+	NODE_ACCESS_CLASS_0 = 0,
+	NODE_ACCESS_CLASS_1,
+	NODE_ACCESS_CLASS_MAX,
+};
+
 struct memory_target {
 	struct list_head node;
 	unsigned int memory_pxm;
 	unsigned int processor_pxm;
 	struct resource memregions;
-	struct access_coordinate coord[2];
+	struct access_coordinate coord[NODE_ACCESS_CLASS_MAX];
 	struct list_head caches;
 	struct node_cache_attrs cache_attrs;
 	bool registered;
@@ -338,10 +344,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 			if (mem_hier == ACPI_HMAT_MEMORY) {
 				target = find_mem_target(targs[targ]);
 				if (target && target->processor_pxm == inits[init]) {
-					hmat_update_target_access(target, type, value, 0);
+					hmat_update_target_access(target, type, value,
+								  NODE_ACCESS_CLASS_0);
 					/* If the node has a CPU, update access 1 */
 					if (node_state(pxm_to_node(inits[init]), N_CPU))
-						hmat_update_target_access(target, type, value, 1);
+						hmat_update_target_access(target, type, value,
+									  NODE_ACCESS_CLASS_1);
 				}
 			}
 		}
@@ -600,10 +608,12 @@ static void hmat_register_target_initiators(struct memory_target *target)
 	 */
 	if (target->processor_pxm != PXM_INVAL) {
 		cpu_nid = pxm_to_node(target->processor_pxm);
-		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
+		register_memory_node_under_compute_node(mem_nid, cpu_nid,
+							NODE_ACCESS_CLASS_0);
 		access0done = true;
 		if (node_state(cpu_nid, N_CPU)) {
-			register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
+			register_memory_node_under_compute_node(mem_nid, cpu_nid,
+								NODE_ACCESS_CLASS_1);
 			return;
 		}
 	}
@@ -644,12 +654,13 @@ static void hmat_register_target_initiators(struct memory_target *target)
 			}
 			if (best)
 				hmat_update_target_access(target, loc->hmat_loc->data_type,
-							  best, 0);
+							  best, NODE_ACCESS_CLASS_0);
 		}
 
 		for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
 			cpu_nid = pxm_to_node(i);
-			register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
+			register_memory_node_under_compute_node(mem_nid, cpu_nid,
+								NODE_ACCESS_CLASS_0);
 		}
 	}
 
@@ -681,11 +692,13 @@ static void hmat_register_target_initiators(struct memory_target *target)
 				clear_bit(initiator->processor_pxm, p_nodes);
 		}
 		if (best)
-			hmat_update_target_access(target, loc->hmat_loc->data_type, best, 1);
+			hmat_update_target_access(target, loc->hmat_loc->data_type, best,
+						  NODE_ACCESS_CLASS_1);
 	}
 	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
 		cpu_nid = pxm_to_node(i);
-		register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
+		register_memory_node_under_compute_node(mem_nid, cpu_nid,
+							NODE_ACCESS_CLASS_1);
 	}
 }
 
@@ -746,8 +759,8 @@ static void hmat_register_target(struct memory_target *target)
 	if (!target->registered) {
 		hmat_register_target_initiators(target);
 		hmat_register_target_cache(target);
-		hmat_register_target_perf(target, 0);
-		hmat_register_target_perf(target, 1);
+		hmat_register_target_perf(target, NODE_ACCESS_CLASS_0);
+		hmat_register_target_perf(target, NODE_ACCESS_CLASS_1);
 		target->registered = true;
 	}
 	mutex_unlock(&target_lock);


