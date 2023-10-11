Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F480D
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AprqEZbW"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A946B92
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 18:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986305; x=1728522305;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vn/8WJWlGwbF8QwLOPLf3/SNazRSw7bVFzAGSBnmx10=;
  b=AprqEZbWfXUYdnOo2B+HeXD+3O0B/snI6RQMWmFdz3upJJyK7Egzm8Ex
   t7TA9hWgcrAlX94/NTOjNy7GrBv+eGHezpO73PQngpXQ/IfQ1hXmvS+8r
   sxaqfBB2xKuDZpx9/6yNai6JSq5JUzipYuup+vRFY5iSLM5jVhIkO603J
   dl0sh/kAebwm8OfaEOql2cjpOExhWBoF04hW0FyPejaIU9DGkDjDXG8mC
   syZm6otH1xt9uElC4CYrstXlsfYnSQXALl54vbc/1LRlHLUCf+5KsCIp5
   kZurJ8dE1Oe4ZIXQk77pjZewAqlRr3SITx/aUwfGA0lYU4vrb8GS2GgFd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369615317"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="369615317"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897436756"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897436756"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.35.251])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:03:20 -0700
Subject: [PATCH v10 01/22] cxl: Export QTG ids from CFMWS to sysfs as
 qos_class attribute
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 10 Oct 2023 18:05:04 -0700
Message-ID: <169698630413.1991735.9174638637613438805.stgit@djiang5-mobl3>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Export the QoS Throttling Group ID from the CXL Fixed Memory Window
Structure (CFMWS) under the root decoder sysfs attributes as qos_class.

CXL rev3.0 9.17.1.3 CXL Fixed Memory Window Structure (CFMWS)

cxl cli will use this id to match with the _DSM retrieved id for a
hot-plugged CXL memory device DPA memory range to make sure that the
DPA range is under the right CFMWS window.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   15 +++++++++++++++
 drivers/cxl/acpi.c                      |    3 +++
 drivers/cxl/core/port.c                 |   11 +++++++++++
 drivers/cxl/cxl.h                       |    3 +++
 4 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 087f762ebfd5..44ffbbb36654 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -369,6 +369,21 @@ Description:
 		provided it is currently idle / not bound to a driver.
 
 
+What:		/sys/bus/cxl/devices/decoderX.Y/qos_class
+Date:		May, 2023
+KernelVersion:	v6.5
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) For CXL host platforms that support "QoS Telemmetry" this
+		root-decoder-only attribute conveys a platform specific cookie
+		that identifies a QoS performance class for the CXL Window.
+		This class-id can be compared against a similar "qos_class"
+		published for each memory-type that an endpoint supports. While
+		it is not required that endpoints map their local memory-class
+		to a matching platform class, mismatches are not recommended and
+		there are platform specific side-effects that may result.
+
+
 What:		/sys/bus/cxl/devices/regionZ/uuid
 Date:		May, 2022
 KernelVersion:	v6.0
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 40d055560e52..2034eb4ce83f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -289,6 +289,9 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 			}
 		}
 	}
+
+	cxlrd->qos_class = cfmws->qtg_id;
+
 	rc = cxl_decoder_add(cxld, target_map);
 err_xormap:
 	if (rc)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7ca01a834e18..fc31ff8954c0 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -278,6 +278,15 @@ static ssize_t interleave_ways_show(struct device *dev,
 
 static DEVICE_ATTR_RO(interleave_ways);
 
+static ssize_t qos_class_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+
+	return sysfs_emit(buf, "%d\n", cxlrd->qos_class);
+}
+static DEVICE_ATTR_RO(qos_class);
+
 static struct attribute *cxl_decoder_base_attrs[] = {
 	&dev_attr_start.attr,
 	&dev_attr_size.attr,
@@ -297,6 +306,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
 	&dev_attr_target_list.attr,
+	&dev_attr_qos_class.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
 	SET_CXL_REGION_ATTR(create_ram_region)
 	SET_CXL_REGION_ATTR(delete_region)
@@ -1691,6 +1701,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 	}
 
 	atomic_set(&cxlrd->region_id, rc);
+	cxlrd->qos_class = CXL_QOS_CLASS_INVALID;
 	return cxlrd;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af29..eb7924648cb0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -321,6 +321,7 @@ enum cxl_decoder_type {
  */
 #define CXL_DECODER_MAX_INTERLEAVE 16
 
+#define CXL_QOS_CLASS_INVALID -1
 
 /**
  * struct cxl_decoder - Common CXL HDM Decoder Attributes
@@ -432,6 +433,7 @@ typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
  * @calc_hb: which host bridge covers the n'th position by granularity
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
+ * @qos_class: QoS performance class cookie
  * @cxlsd: base cxl switch decoder
  */
 struct cxl_root_decoder {
@@ -440,6 +442,7 @@ struct cxl_root_decoder {
 	cxl_calc_hb_fn calc_hb;
 	void *platform_data;
 	struct mutex range_lock;
+	int qos_class;
 	struct cxl_switch_decoder cxlsd;
 };
 


