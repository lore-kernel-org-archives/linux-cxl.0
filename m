Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32E26AC0
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ez4ZXfM6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA53D0
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 15:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003081; x=1731539081;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3eQJczOQ2vMCwhQzl8GWcCxcrOepB+Rhc14RqbUAn6U=;
  b=ez4ZXfM6F0+Ee+tyhCEqsFjfk6EN8p9Okq3KJ4qQlsu4JyXxiGN38Int
   v8fgxYEftht6Gq0knU56ubRbMDdZVfwiJnTRs7lF1oh6M+aE4Zl9PSzBv
   mJA2dtczPbwZjM0zPhzk2xNvaDVuJboDvHhd/I2YHQx9xEBirWV+Ifa0C
   WKpBDgZntW+Zmob0Llul3SGyxfH4AZOuHnK4yzM+0dSWpUNWDRMYTAW7Z
   hRwYC5SkI3V0xhuySVf/ztjFCc241cpnoklgsplFGWVkrpmLF/MODtnRi
   HTC/PxkpxtyQZiKrA881axqkHU5KlNpdvVC6+tOnSi+FV1lzA1514psSf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="9403059"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="9403059"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:04:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741237413"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="741237413"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:04:39 -0800
Subject: [PATCH v12 06/18] acpi: numa: Add setting of generic port system
 locality attributes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 14 Nov 2023 16:04:38 -0700
Message-ID: <170000307866.1974471.9834665480168887740.stgit@djiang5-mobl3>
In-Reply-To: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
References: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
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
v12:
- Make sure all genport target domains are updates only once
- Check entire length encompasses EISA int encoding of "ACPI"
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


