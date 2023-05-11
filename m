Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F543C77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 17:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbjEKR7m (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 13:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239131AbjEKR70 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 13:59:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C016195
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683827939; x=1715363939;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zmtKCxzEB2eCaiYSIvfweDYzrtmXFJA4u3jy5WAlwrg=;
  b=N80Ew5PLASsoq4Lnl77c6/GaWxsJK6UsblEABqccEXk9ErrxiFpKJU8A
   GuqU5e1MApJ0PnNaYsblKsNxJiucv9uHnIx71BbUeQZbc1LiWFMKEUi1I
   jGLo9ONVQv999mnwEdblt+6cHAiyuo82wVpVtgP9ZJCXC03hy2Ya1RZQM
   rITptRyu0DTVvk8QKE4MEQJCbQK2g9IThkhMT9gbHs5+/W6DSKIvNr++B
   BhX1SqOMhPInMCHYCK6rQf2xKLeL+jDbLDG+9MseTSgHCLN6vmN8vxisw
   RFkb2/Ro/d53aKOLCc5odxKYhRk8eeq98qfy3adRFAF4du2A2sRumTaps
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="349422772"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="349422772"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730470597"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="730470597"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.95.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:58:49 -0700
Subject: [PATCH v2 1/4] cxl: Export QTG ids from CFMWS to sysfs as qos_class
 attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Thu, 11 May 2023 10:58:48 -0700
Message-ID: <168382792890.3510737.9466824452406784924.stgit@djiang5-mobl3>
In-Reply-To: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
References: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
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

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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
 


