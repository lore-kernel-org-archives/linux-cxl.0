Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99B176FDB
	for <linux-cxl@vger.kernel.org>; Tue, 25 Jun 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335322; cv=none; b=kaq9j9LVED5x5r5it6R2LA8gtgWd6gwrlpdSJqmaMdEHNzpUn7NOffKVMOgf66xCq0Ptw/xCsRQ7J4dnuuoWz2DSuP0Iwr25v2pMru4tSFyrVueg578EdseJpqGjE+txtJzJUVJ5xa50Y2D7qqJWvwe+sjDHOq10z2vnBXWaTWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335322; c=relaxed/simple;
	bh=X+eBuSykF/nP2WJiY54V0tm7NCQGE29eDWXoYpOl/eY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0j9nNKiu/boPersb4D9IqdHD3eya4tk8zsva3ZY1SHncBewmATdlOhkLteyOmiI+PdJRLx4UiKFOS6Hw3BwtSOS1FnBoDSrJFlJrcQJDYVpvgPXFKDAnYBdCejFMIKsNryluHVFGK4Pcj3VeyDPX9+EOOpD+jSpUj7TKSLhybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W7rqx53Vkz6K6HQ;
	Wed, 26 Jun 2024 01:07:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 00FFC140A79;
	Wed, 26 Jun 2024 01:08:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 18:08:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>,
	<linux-cxl@vger.kernel.org>, <mst@redhat.com>, <armbru@redhat.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH 1/2] hw/cxl/events: Improve QMP interfaces and documentation for add/release dynamic capacity.
Date: Tue, 25 Jun 2024 18:08:04 +0100
Message-ID: <20240625170805.359278-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625170805.359278-1-Jonathan.Cameron@huawei.com>
References: <20240625170805.359278-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

New DCD command definitions updated in response to review comments
from Markus.

- Used CxlXXXX instead of CXLXXXXX for newly added types.
- Expanded some abreviations in type names to be easier to read.
- Additional documentation for some fields.
- Replace slightly vague cxl r3.1 references with
  "Compute Express Link (CXL) Specification, Revision 3.1, XXXX"
  to bring them inline with what it says on the specification cover.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
I can break this up into a separate patches, but that's going to be
quite a lot of churn as often multiple of the above affect the same
paragraph.
---
 qapi/cxl.json            | 152 ++++++++++++++++++++++++---------------
 hw/mem/cxl_type3.c       |  18 ++---
 hw/mem/cxl_type3_stubs.c |   8 +--
 3 files changed, 107 insertions(+), 71 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index 57d9f82014..a38622a0d1 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -363,9 +363,11 @@
  'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
 
 ##
-# @CXLDynamicCapacityExtent:
+# @CxlDynamicCapacityExtent:
 #
-# A single dynamic capacity extent
+# A single dynamic capacity extent.  This is a contiguous allocation
+# of memory by Device Physical Address within a single Dynamic
+# Capacity Region on a CXL Type 3 Device.
 #
 # @offset: The offset (in bytes) to the start of the region
 #     where the extent belongs to.
@@ -374,7 +376,7 @@
 #
 # Since: 9.1
 ##
-{ 'struct': 'CXLDynamicCapacityExtent',
+{ 'struct': 'CxlDynamicCapacityExtent',
   'data': {
       'offset':'uint64',
       'len': 'uint64'
@@ -382,22 +384,40 @@
 }
 
 ##
-# @CXLExtSelPolicy:
+# @CxlExtentSelectionPolicy:
 #
 # The policy to use for selecting which extents comprise the added
-# capacity, as defined in cxl spec r3.1 Table 7-70.
-#
-# @free: 0h = Free
-#
-# @contiguous: 1h = Continuous
-#
-# @prescriptive: 2h = Prescriptive
-#
-# @enable-shared-access: 3h = Enable Shared Access
+# capacity, as defined in Compute Express Link (CXL) Specification,
+# Revision 3.1, Table 7-70.
+#
+# @free: Device is responsible for allocating the requested memory
+#     capacity and is free to do this using any combination of
+#     supported extents.
+#
+# @contiguous: Device is responsible for allocating the requested
+#     memory capacity but must do so as a single contiguous
+#     extent.
+#
+# @prescriptive: The precise set of extents to be allocated is
+#     specified by the command.  Thus allocation is being managed
+#     by the issuer of the allocation command, not the device.
+#
+# @enable-shared-access: Capacity has already been allocated to a
+#     different host using free, contiguous or prescriptive policy
+#     with a known tag.  This policy then instructs the device to
+#     make the capacity with the specified tag available to an
+#     additional host.  Capacity is implicit as it matches that
+#     already associated with the tag.  Note that the extent list
+#     (and hence Device Physical Addresses) used are per host, so
+#     a device may use different representations on each host.
+#     The ordering of the extents provided to each host is indicated
+#     to the host using per extent sequence numbers generated by
+#     the device.  Has a similar meaning for temporal sharing, but
+#     in that case there may be only one host involved.
 #
 # Since: 9.1
 ##
-{ 'enum': 'CXLExtSelPolicy',
+{ 'enum': 'CxlExtentSelectionPolicy',
   'data': ['free',
            'contiguous',
            'prescriptive',
@@ -407,54 +427,60 @@
 ##
 # @cxl-add-dynamic-capacity:
 #
-# Command to initiate to add dynamic capacity extents to a host.  It
-# simulates operations defined in cxl spec r3.1 7.6.7.6.5.
+# Initiate adding dynamic capacity extents to a host.  This simulates
+# operations defined in Compute Express Link (CXL) Specification,
+# Revision 3.1, Section 7.6.7.6.5. Note that, currently, establishing
+# success or failure of the full Add Dynamic Capacity flow requires
+# out of band communication with the OS of the CXL host.
 #
-# @path: CXL DCD canonical QOM path.
+# @path: path to the CXL Dynamic Capacity Device in the QOM tree.
 #
-# @host-id: The "Host ID" field as defined in cxl spec r3.1
-#     Table 7-70.
+# @host-id: The "Host ID" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-70.
 #
 # @selection-policy: The "Selection Policy" bits as defined in
-#     cxl spec r3.1 Table 7-70.  It specifies the policy to use for
-#     selecting which extents comprise the added capacity.
+#     Compute Express Link (CXL) Specification, Revision 3.1,
+#     Table 7-70.  It specifies the policy to use for selecting
+#     which extents comprise the added capacity.
 #
-# @region: The "Region Number" field as defined in cxl spec r3.1
-#     Table 7-70.  The dynamic capacity region where the capacity
-#     is being added.  Valid range is from 0-7.
+# @region: The "Region Number" field as defined in Compute Express
+#     Link (CXL) Specification, Revision 3.1, Table 7-70.  Valid
+#     range is from 0-7.
 #
-# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-70.
+# @tag: The "Tag" field as defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Table 7-70.
 #
-# @extents: The "Extent List" field as defined in cxl spec r3.1
-#     Table 7-70.
+# @extents: The "Extent List" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-70.
 #
 # Since : 9.1
 ##
 { 'command': 'cxl-add-dynamic-capacity',
   'data': { 'path': 'str',
             'host-id': 'uint16',
-            'selection-policy': 'CXLExtSelPolicy',
+            'selection-policy': 'CxlExtentSelectionPolicy',
             'region': 'uint8',
             '*tag': 'str',
-            'extents': [ 'CXLDynamicCapacityExtent' ]
+            'extents': [ 'CxlDynamicCapacityExtent' ]
            }
 }
 
 ##
-# @CXLExtRemovalPolicy:
+# @CxlExtentRemovalPolicy:
 #
 # The policy to use for selecting which extents comprise the released
-# capacity, defined in the "Flags" field in cxl spec r3.1 Table 7-71.
+# capacity, defined in the "Flags" field in Compute Express Link (CXL)
+# Specification, Revision 3.1, Table 7-71.
 #
-# @tag-based: value = 0h.  Extents are selected by the device based
-#     on tag, with no requirement for contiguous extents.
+# @tag-based: Extents are selected by the device based on tag, with
+#     no requirement for contiguous extents.
 #
-# @prescriptive: value = 1h.  Extent list of capacity to release is
-#     included in the request payload.
+# @prescriptive: Extent list of capacity to release is included in
+#     the request payload.
 #
 # Since: 9.1
 ##
-{ 'enum': 'CXLExtRemovalPolicy',
+{ 'enum': 'CxlExtentRemovalPolicy',
   'data': ['tag-based',
            'prescriptive']
 }
@@ -462,45 +488,55 @@
 ##
 # @cxl-release-dynamic-capacity:
 #
-# Command to initiate to release dynamic capacity extents from a
-# host.  It simulates operations defined in cxl spec r3.1 7.6.7.6.6.
+# Initiate release of dynamic capacity extents from a host.  This
+# simulates operations defined in Compute Express Link (CXL)
+# Specification, Revision 3.1, Section 7.6.7.6.6. Note that,
+# currently, success or failure of the full Release Dynamic Capacity
+# flow requires out of band communication with the OS of the CXL host.
 #
-# @path: CXL DCD canonical QOM path.
+# @path: path to the CXL Dynamic Capacity Device in the QOM tree.
 #
-# @host-id: The "Host ID" field as defined in cxl spec r3.1
-#     Table 7-71.
+# @host-id: The "Host ID" field as defined in Compute Express Link
+#     (CXL) Specification, Revision 3.1, Table 7-71.
 #
-# @removal-policy: Bit[3:0] of the "Flags" field as defined in cxl
-#     spec r3.1 Table 7-71.
+# @removal-policy: Bit[3:0] of the "Flags" field as defined in
+#     Compute Express Link (CXL) Specification, Revision 3.1,
+#     Table 7-71.
 #
-# @forced-removal: Bit[4] of the "Flags" field in cxl spec r3.1
-#     Table 7-71.  When set, device does not wait for a Release
-#     Dynamic Capacity command from the host.  Host immediately
-#     loses access to released capacity.
+# @forced-removal: Bit[4] of the "Flags" field in Compute Express
+#     Link (CXL) Specification, Revision 3.1, Table 7-71.  When set,
+#     the device does not wait for a Release Dynamic Capacity command
+#     from the host.  Instead, the host immediately looses access to
+#     the released capacity.
 #
-# @sanitize-on-release: Bit[5] of the "Flags" field in cxl spec r3.1
-#     Table 7-71.  When set, device should sanitize all released
-#     capacity as a result of this request.
+# @sanitize-on-release: Bit[5] of the "Flags" field in Compute
+#     Express Link (CXL) Specification, Revision 3.1, Table 7-71.
+#     When set, the device should sanitize all released capacity as
+#     a result of this request. This ensures that all user data
+#     and metadata is made permanently unavailable by whatever
+#     means is appropriate for the media type. Note that changing
+#     encryption keys is not sufficient.
 #
-# @region: The "Region Number" field as defined in cxl spec r3.1
-#     Table 7-71.  The dynamic capacity region where the capacity
-#     is being added.  Valid range is from 0-7.
+# @region: The "Region Number" field as defined in Compute Express
+#     Link Specification, Revision 3.1, Table 7-71.  Valid range
+#     is from 0-7.
 #
-# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
+# @tag: The "Tag" field as defined in Compute Express Link (CXL)
+#     Specification, Revision 3.1, Table 7-71.
 #
-# @extents: The "Extent List" field as defined in cxl spec r3.1
-#     Table 7-71.
+# @extents: The "Extent List" field as defined in Compute Express
+#     Link (CXL) Specification, Revision 3.1, Table 7-71.
 #
 # Since : 9.1
 ##
 { 'command': 'cxl-release-dynamic-capacity',
   'data': { 'path': 'str',
             'host-id': 'uint16',
-            'removal-policy': 'CXLExtRemovalPolicy',
+            'removal-policy': 'CxlExtentRemovalPolicy',
             '*forced-removal': 'bool',
             '*sanitize-on-release': 'bool',
             'region': 'uint8',
             '*tag': 'str',
-            'extents': [ 'CXLDynamicCapacityExtent' ]
+            'extents': [ 'CxlDynamicCapacityExtent' ]
            }
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3274e5dcbb..35ac59883a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1874,7 +1874,7 @@ static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
  */
 static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
         uint16_t hid, CXLDCEventType type, uint8_t rid,
-        CXLDynamicCapacityExtentList *records, Error **errp)
+        CxlDynamicCapacityExtentList *records, Error **errp)
 {
     Object *obj;
     CXLEventDynamicCapacity dCap = {};
@@ -1882,7 +1882,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
     CXLType3Dev *dcd;
     uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
     uint32_t num_extents = 0;
-    CXLDynamicCapacityExtentList *list;
+    CxlDynamicCapacityExtentList *list;
     CXLDCExtentGroup *group = NULL;
     g_autofree CXLDCExtentRaw *extents = NULL;
     uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
@@ -2032,13 +2032,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
 }
 
 void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
-                                  CXLExtSelPolicy sel_policy, uint8_t region,
-                                  const char *tag,
-                                  CXLDynamicCapacityExtentList  *extents,
+                                  CxlExtentSelectionPolicy sel_policy,
+                                  uint8_t region, const char *tag,
+                                  CxlDynamicCapacityExtentList  *extents,
                                   Error **errp)
 {
     switch (sel_policy) {
-    case CXL_EXT_SEL_POLICY_PRESCRIPTIVE:
+    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
         qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id,
                                                       DC_EVENT_ADD_CAPACITY,
                                                       region, extents, errp);
@@ -2050,14 +2050,14 @@ void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
 }
 
 void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
-                                      CXLExtRemovalPolicy removal_policy,
+                                      CxlExtentRemovalPolicy removal_policy,
                                       bool has_forced_removal,
                                       bool forced_removal,
                                       bool has_sanitize_on_release,
                                       bool sanitize_on_release,
                                       uint8_t region,
                                       const char *tag,
-                                      CXLDynamicCapacityExtentList  *extents,
+                                      CxlDynamicCapacityExtentList  *extents,
                                       Error **errp)
 {
     CXLDCEventType type = DC_EVENT_RELEASE_CAPACITY;
@@ -2070,7 +2070,7 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
     }
 
     switch (removal_policy) {
-    case CXL_EXT_REMOVAL_POLICY_PRESCRIPTIVE:
+    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
         qmp_cxl_process_dynamic_capacity_prescriptive(path, host_id, type,
                                                       region, extents, errp);
         return;
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index 45419bbefe..c1a5e4a7c1 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -70,24 +70,24 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 
 void qmp_cxl_add_dynamic_capacity(const char *path,
                                   uint16_t host_id,
-                                  CXLExtSelPolicy sel_policy,
+                                  CxlExtentSelectionPolicy sel_policy,
                                   uint8_t region,
                                   const char *tag,
-                                  CXLDynamicCapacityExtentList *extents,
+                                  CxlDynamicCapacityExtentList *extents,
                                   Error **errp)
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
 
 void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
-                                      CXLExtRemovalPolicy removal_policy,
+                                      CxlExtentRemovalPolicy removal_policy,
                                       bool has_forced_removal,
                                       bool forced_removal,
                                       bool has_sanitize_on_release,
                                       bool sanitize_on_release,
                                       uint8_t region,
                                       const char *tag,
-                                      CXLDynamicCapacityExtentList *extents,
+                                      CxlDynamicCapacityExtentList *extents,
                                       Error **errp)
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
-- 
2.43.0

