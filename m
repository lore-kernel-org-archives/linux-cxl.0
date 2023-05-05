Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5AFC77B7F
	for <linux-cxl@archiver.kernel.org>; Fri,  5 May 2023 16:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjEEQfc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 12:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjEEQfb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 12:35:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96CF19414
        for <linux-cxl@vger.kernel.org>; Fri,  5 May 2023 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683304524; x=1714840524;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UlNUhS4jlHzZTjW6KYfrT1AanSNucV1IcoSy9nHOghc=;
  b=UfarkEgIGraqdcvSZqdDFnoBdUvrKYwujOrSLhWoVVGZl+PZ3DYdtpBC
   M3avvfEb1IRnqX09hWpbk4htRZYjbHQh48C0kqa05JBGoog+m8bpkuh4x
   SXQ1RNAFRzUpzGxQzxNDJ1UJtj4ctkVUwJAKG9+iUvGefijpB0CMP038Z
   OSpbbUsEZUiRMg+ylmcCr2V+apzk3CKwDN8kzDcrXblG0NDTsvBt71InT
   ewVDyvGr3uafA/NulD6WUexlCzSxejYA2rpohkQSBE8PpkfhrkWuQ3wDa
   cDOJzX54vjLq/yjluWzVyLBNUaIi/FkjC3SSJWmYO5LoDZ+HpFCb349j9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="435566728"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="435566728"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="821765541"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="821765541"
Received: from nkonan-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:35:23 -0700
Subject: [PATCH 1/3] cxl: Export QTG ids from CFMWS to sysfs as qos_class
 attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Fri, 05 May 2023 09:35:22 -0700
Message-ID: <168330452292.1986478.17259063377180091918.stgit@djiang5-mobl3>
In-Reply-To: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
References: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Export the QoS Throttling Group ID from the CXL Fixed Memory Window
Structure (CFMWS) under the root decoder sysfs attributes as qos_class.

CXL rev3.0 9.17.1.3 CXL Fixed Memory Window Structure (CFMWS)

cxl cli will use this id to match with the _DSM retrieved id for a
hot-plugged CXL memory device DPA memory range to make sure that the
DPA range is under the right CFMWS window.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v5:
- Documentation rewrite. (Dan)
- Rename attrib to qos_class
- Move qtg_id to root decoder
v4:
- Change kernel version for documentation to v6.5
v2:
- Add explanation commit header (Jonathan)
---
 Documentation/ABI/testing/sysfs-bus-cxl |   15 +++++++++++++++
 drivers/cxl/acpi.c                      |    3 +++
 drivers/cxl/core/port.c                 |   11 +++++++++++
 drivers/cxl/cxl.h                       |    3 +++
 4 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3acf2f17a73f..2f24e42ef36d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -310,6 +310,21 @@ Description:
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
index 7e1765b09e04..e063df2bf876 100644
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
index 4d1f9c5b5029..a0130aeb8d42 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -276,6 +276,15 @@ static ssize_t interleave_ways_show(struct device *dev,
 
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
@@ -295,6 +304,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
 	&dev_attr_target_list.attr,
+	&dev_attr_qos_class.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
 	SET_CXL_REGION_ATTR(create_ram_region)
 	SET_CXL_REGION_ATTR(delete_region)
@@ -1625,6 +1635,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 	}
 
 	atomic_set(&cxlrd->region_id, rc);
+	cxlrd->qos_class = CXL_QOS_CLASS_INVALID;
 	return cxlrd;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 044a92d9813e..4577d808ac6d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -300,6 +300,7 @@ enum cxl_decoder_type {
  */
 #define CXL_DECODER_MAX_INTERLEAVE 16
 
+#define CXL_QOS_CLASS_INVALID -1
 
 /**
  * struct cxl_decoder - Common CXL HDM Decoder Attributes
@@ -411,6 +412,7 @@ typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
  * @calc_hb: which host bridge covers the n'th position by granularity
  * @platform_data: platform specific configuration data
  * @range_lock: sync region autodiscovery by address range
+ * @qos_class: QoS performance class cookie
  * @cxlsd: base cxl switch decoder
  */
 struct cxl_root_decoder {
@@ -419,6 +421,7 @@ struct cxl_root_decoder {
 	cxl_calc_hb_fn calc_hb;
 	void *platform_data;
 	struct mutex range_lock;
+	int qos_class;
 	struct cxl_switch_decoder cxlsd;
 };
 


