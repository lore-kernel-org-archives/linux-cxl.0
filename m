Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fiiFWZaO"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5756ED0
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485716; x=1734021716;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUK7kxhoI3Dys7IlnkobSO5fMoeFOD14FMPV4Id/eNg=;
  b=fiiFWZaOca+Si2y6OYYLEhSr/qJMYz/XdXRwZ8Ma1DD3L+WMnjxgDgKZ
   NfZ4Wc9bN1hrGCjvl9oLtJKp3OkHZPss1Z2gsmK+qcSKSimwwH9edYW19
   9wGNEbdboXxKxMEcAGStSfyrEyb3AsW7Svu6s0QFn5D8dfxnShkGBaQTH
   pItrKgtga4IERrZqNwOWvwSUkx1biD2SRYzNxPsdy9tqen/sKRzqy7ZWV
   Cqs7kttZsJXxrInyetN/BUoiRioz2kppZALYACeL40Y5gX1v2rc9UWB3q
   nXqjXVkuhJw6zAnxNfR8dYZobX48wciR4tEg7Gum6XF1V4twmPNdjCBat
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="397775053"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="397775053"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767270416"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="767270416"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:41:55 -0800
Subject: [PATCH v14 06/19] acpi: numa: Add setting of generic port system
 locality attributes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:41:54 -0700
Message-ID: <170248571439.801570.1823321718093973626.stgit@djiang5-mobl3>
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

Add generic port support for the parsing of HMAT system locality sub-table.
The attributes will be added to the third array member of the access
coordinates in order to not mix with the existing memory attributes. It
only provides the system locality attributes from initator to the
generic port targets and is missing the rest of the data to the actual
memory device.

The complete attributes will be updated when a memory device is
attached and the system locality information is calculated end to end.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/numa/hmat.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 4cae2e84251a..70a6e775856d 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -61,6 +61,7 @@ struct target_cache {
 enum {
 	NODE_ACCESS_CLASS_0 = 0,
 	NODE_ACCESS_CLASS_1,
+	NODE_ACCESS_CLASS_GENPORT_SINK,
 	NODE_ACCESS_CLASS_MAX,
 };
 
@@ -327,10 +328,13 @@ static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_px
 {
 	struct memory_target *target = find_mem_target(tgt_pxm);
 
+	if (!target)
+		return;
+
 	if (mem_hier != ACPI_HMAT_MEMORY)
 		return;
 
-	if (target && target->processor_pxm == init_pxm) {
+	if (target->processor_pxm == init_pxm) {
 		hmat_update_target_access(target, type, value,
 					  NODE_ACCESS_CLASS_0);
 		/* If the node has a CPU, update access 1 */
@@ -338,6 +342,11 @@ static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_px
 			hmat_update_target_access(target, type, value,
 						  NODE_ACCESS_CLASS_1);
 	}
+
+	/* Update access from generic port target */
+	if (init_pxm == 0 && *(u16 *)target->gen_port_device_handle)
+		hmat_update_target_access(target, type, value,
+					  NODE_ACCESS_CLASS_GENPORT_SINK);
 }
 
 static __init int hmat_parse_locality(union acpi_subtable_headers *header,


