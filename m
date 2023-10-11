Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBEB20E0
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ajb2YrHl"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7ACAF
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986353; x=1728522353;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zW8LpVbVXgtqAQBMzLcnbEadqdI9sMYSZiggNxif8C4=;
  b=Ajb2YrHlBJQY3RFHL6bfE77GoXKd/NvhO/sVuZVCl+DniL1k1V6CeteV
   CpAnqd3/ZGDlivuh2ezrQ1y8L6TQtp7ZbmF9L04KJKNTk9x7JvePh4ZIN
   SwTr7WvUS2+NugH8rQOH/peLI4qvLSeVDoWN9gm7tZOwiAKsyhInJoR67
   IpnP50cQslPva7wZt9yNX4ofpbe9a25spraCVd7/NOsJSXozhjYXKMEV/
   FPLnCnMt+YYWxSdJUcCQkm5Fam0+2hdnEYMWiFiE6H25A7TO5t4iJbahP
   2/jtXSn9xml+vC0kk6DXq+tId66DEKhXa//Sn68xoJ1LK7V05HjoESrNv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374893256"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="374893256"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730307070"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730307070"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.35.251])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:05:52 -0700
Subject: [PATCH v10 09/22] acpi: Break out nesting for hmat_parse_locality()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 10 Oct 2023 18:05:52 -0700
Message-ID: <169698635203.1991735.6398873742864022861.stgit@djiang5-mobl3>
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

Refactor hmat_parse_locality() to break up the deep nesting of the
function.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/numa/hmat.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 8380460cfee2..957a38137c7e 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -321,11 +321,28 @@ static __init void hmat_add_locality(struct acpi_hmat_locality *hmat_loc)
 	}
 }
 
+static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_pxm,
+				      u8 mem_hier, u8 type, u32 value)
+{
+	struct memory_target *target = find_mem_target(tgt_pxm);
+
+	if (mem_hier != ACPI_HMAT_MEMORY)
+		return;
+
+	if (target && target->processor_pxm == init_pxm) {
+		hmat_update_target_access(target, type, value,
+					  NODE_ACCESS_CLASS_0);
+		/* If the node has a CPU, update access 1 */
+		if (node_state(pxm_to_node(init_pxm), N_CPU))
+			hmat_update_target_access(target, type, value,
+						  NODE_ACCESS_CLASS_1);
+	}
+}
+
 static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 				      const unsigned long end)
 {
 	struct acpi_hmat_locality *hmat_loc = (void *)header;
-	struct memory_target *target;
 	unsigned int init, targ, total_size, ipds, tpds;
 	u32 *inits, *targs, value;
 	u16 *entries;
@@ -366,17 +383,8 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 				inits[init], targs[targ], value,
 				hmat_data_type_suffix(type));
 
-			if (mem_hier == ACPI_HMAT_MEMORY) {
-				target = find_mem_target(targs[targ]);
-				if (target && target->processor_pxm == inits[init]) {
-					hmat_update_target_access(target, type, value,
-								  NODE_ACCESS_CLASS_0);
-					/* If the node has a CPU, update access 1 */
-					if (node_state(pxm_to_node(inits[init]), N_CPU))
-						hmat_update_target_access(target, type, value,
-									  NODE_ACCESS_CLASS_1);
-				}
-			}
+			hmat_update_target(targs[targ], inits[init],
+					   mem_hier, type, value);
 		}
 	}
 


