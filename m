Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9OdITrR"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB9DB9
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485696; x=1734021696;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FhWwVP2pa39BQ0FcRUD/Fxj8kJP4mJEiM3+d6nJ1aq0=;
  b=F9OdITrRZy5m2IIWVqqWEuVoyD1zHznOcUugvBrcn6ujWsqW3F2j0+FB
   roQ+E/Y0U5eKVUgvGJS3H6eMYTpq/EAl2bulYbA7gm7CKUQuUFtpDEY3C
   Lu4qzoMkOX1HIbjaVHIwmuN0AVqgPgQYwKasYMjIEmHuk0HI7semSzPT8
   4dmqw+C/FZvxtADZ8AuQV3aSifAipgukuPtDZVey9yYvZV7l4pWcf6Xpw
   G74HxcK40KRfZKMEBxBouuiWdhl8aeVSdJPVp6rBZL3msu7DEaFKd3PS6
   pe0w4Tiod7QIwH1FQmmasy7MqxzddqiVvINaH6nAFRVA6tk8LufZqLm63
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459309795"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="459309795"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:41:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="17675814"
Received: from mmaccool-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:41:35 -0800
Subject: [PATCH v14 03/19] acpi: numa: Create enum for memory_target access
 coordinates indexing
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:41:35 -0700
Message-ID: <170248569503.801570.5225789038727718905.stgit@djiang5-mobl3>
In-Reply-To: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Create enums to provide named indexing for the access coordinate array.
This is in preparation for adding generic port support which will add a
third index in the array to keep the generic port attributes separate from
the memory attributes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/numa/hmat.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 83bc2b69401b..ca7aedfbb5f2 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -58,12 +58,18 @@ struct target_cache {
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
@@ -339,10 +345,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
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
@@ -726,8 +734,8 @@ static void hmat_register_target(struct memory_target *target)
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


