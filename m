Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYF8ifjW"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF69191
	for <linux-cxl@vger.kernel.org>; Tue, 21 Nov 2023 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700593137; x=1732129137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCQ70vdYjxDHwuJdyELr8v4z/AkpiRccZ5YJoLFptiU=;
  b=EYF8ifjWttqeQuYuykOzT8eQpoo1Rbgxi4NJbYpz+ugh0Zl4uVCgZxHW
   dJVVaXW49mz98i2HdiNH6Y+eddcClMQHfW0HzjpQFqD77DuC/dkjqLvI9
   cokTP6bNGNQ+KyaFv0pN3+1Ka1eV+m08BI8/YW4HvwyVyGl+RIa8/Axp/
   8+Wwxx4T6f1OE/vxrrYhL5iGtc6ZYGgVQoRx4plbBOb2kAGznQkxa7NNd
   Q8x56vmpSzN1NZttcKmAyLyEz7t3pdnXpSuUvLoQTaGX5wOL5X26mhW+Z
   grRWp0nKYN0zdtRelulXBrKpUWe7wd8ZFml+lcT5CpxuGkIBldBZAm8sU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="376939714"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="376939714"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:58:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="743139577"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="743139577"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.90.75])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:58:55 -0800
From: alison.schofield@intel.com
To: Vishal Verma <vishal.l.verma@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v4 4/5] cxl/list: add --poison option to cxl list
Date: Tue, 21 Nov 2023 10:58:50 -0800
Message-Id: <216ab396ab0c34fc391d1c3d3797a0d832a8d563.1700591754.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1700591754.git.alison.schofield@intel.com>
References: <cover.1700591754.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The --poison option to 'cxl list' retrieves poison lists from
memory devices supporting the capability and displays the
returned poison records in the cxl list json. This option can
apply to memdevs or regions.

Example usage in the Documentation/cxl/cxl-list.txt update.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/cxl/cxl-list.txt | 58 ++++++++++++++++++++++++++++++++++
 cxl/filter.h                   |  3 ++
 cxl/list.c                     |  2 ++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
index 838de4086678..ee2f1b2d9fae 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -415,6 +415,64 @@ OPTIONS
 --region::
 	Specify CXL region device name(s), or device id(s), to filter the listing.
 
+-L::
+--poison::
+	Include poison information. The poison list is retrieved from the
+	device(s) and poison records are added to the listing. Apply this
+	option to memdevs and regions where devices support the poison
+	list capability.
+
+----
+# cxl list -m mem11 --poison
+[
+  {
+    "memdev":"mem11",
+    "pmem_size":268435456,
+    "ram_size":0,
+    "serial":0,
+    "host":"0000:37:00.0",
+    "poison":{
+      "nr_records":1,
+      "records":[
+        {
+          "dpa":0,
+          "dpa_length":64,
+          "source":"Internal",
+        }
+      ]
+    }
+  }
+]
+# cxl list -r region5 --poison
+[
+  {
+    "region":"region5",
+    "resource":1035623989248,
+    "size":2147483648,
+    "interleave_ways":2,
+    "interleave_granularity":4096,
+    "decode_state":"commit",
+    "poison":{
+      "nr_records":2,
+      "records":[
+        {
+          "memdev":"mem2",
+          "dpa":0,
+          "dpa_length":64,
+          "source":"Internal",
+        },
+        {
+          "memdev":"mem5",
+          "dpa":0,
+          "length":512,
+          "source":"Vendor",
+        }
+      ]
+    }
+  }
+]
+----
+
 -v::
 --verbose::
 	Increase verbosity of the output. This can be specified
diff --git a/cxl/filter.h b/cxl/filter.h
index 3f65990f835a..1241f72ccf62 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -30,6 +30,7 @@ struct cxl_filter_params {
 	bool fw;
 	bool alert_config;
 	bool dax;
+	bool poison;
 	int verbose;
 	struct log_ctx ctx;
 };
@@ -88,6 +89,8 @@ static inline unsigned long cxl_filter_to_flags(struct cxl_filter_params *param)
 		flags |= UTIL_JSON_ALERT_CONFIG;
 	if (param->dax)
 		flags |= UTIL_JSON_DAX | UTIL_JSON_DAX_DEVS;
+	if (param->poison)
+		flags |= UTIL_JSON_MEDIA_ERRORS;
 	return flags;
 }
 
diff --git a/cxl/list.c b/cxl/list.c
index 93ba51ef895c..13fef8569340 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -57,6 +57,8 @@ static const struct option options[] = {
 		    "include memory device firmware information"),
 	OPT_BOOLEAN('A', "alert-config", &param.alert_config,
 		    "include alert configuration information"),
+	OPT_BOOLEAN('L', "poison", &param.poison,
+		    "include poison information "),
 	OPT_INCR('v', "verbose", &param.verbose, "increase output detail"),
 #ifdef ENABLE_DEBUG
 	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
-- 
2.37.3

