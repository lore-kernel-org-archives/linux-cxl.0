Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmT+ZUOw"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72111710
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701989934; x=1733525934;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9CZL8c1UJVhrO20QWiZbQt93Oa3xxGYldsGV8DoldGY=;
  b=UmT+ZUOwjjvVJsI0G6J3r8QQQT0cYogi1SPMxRyoDTWhunet7k6xQylP
   P5eHrdQ1xMFTLqFvuMbCahnBgatetSoynPaB18/Dj43KoVUiEHNCBm9NJ
   NKBW75iriRDdB6n0YStxxjPF+CJ0i8oG3yLi598icCXan/ZpP4Bw1XZiW
   r/mqBTeTIoEhgsBosB2DWJd7095XDIBa6RQY8ObSt47Klq9uLDuhgMXSN
   ml2YIpPFFqDQpZ/w5Oa803DvzsHE9loZ0t3smxHut2mzYoHbJehBTWPWd
   947uT1wdhhZVY9Lg6soes6d3bnmyR3z9aeQqCPF28aQ5Ld7UL1B9So6Oi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="398191259"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="398191259"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="19874055"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:58:53 -0800
Subject: [PATCH v13 05/19] acpi: Break out nesting for hmat_parse_locality()
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 15:58:52 -0700
Message-ID: <170198993298.3522351.17156759629073167911.stgit@djiang5-mobl3>
In-Reply-To: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
References: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
index 21722cbec324..4cae2e84251a 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -322,11 +322,28 @@ static __init void hmat_add_locality(struct acpi_hmat_locality *hmat_loc)
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
@@ -367,17 +384,8 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
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
 


