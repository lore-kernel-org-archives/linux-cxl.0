Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F6819
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrsIpft0"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E6898
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 18:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986334; x=1728522334;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hxIGuqOOmnR3cPDsIBqSqQ2DOFTEsTXaAHMHFrigFrY=;
  b=VrsIpft0DvT6ijim9buMy1OpjmzYEc/2nR1S9looSVBiHui9q7xKUBRt
   HirQMVYRpLrJdvyp5F6CKp1yw573Kq0d0iAwL0thCru7e63SGJEtHy0Jw
   ruQ+NP0Uw80StxRawgh6cl0wMDxEObfmF2tyc8JIpQmu2dcPjK0voVoIH
   WHJ8kcZbi2xumnheTvIHUOiMaeKNq24ZEhtL4Q7mArSZ2b+c1W7H10wBL
   rAjxU4F+OusAap17/twTKudiZtXI54fWyqsSLM5Y5U//LVZ9q3FyCifhA
   x2uOx0wFS1tHU9LhMtohpBUSrdXsNJLVkn6nkuF3pW5vOuMVzzB43/jdf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374893228"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="374893228"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730307031"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730307031"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.35.251])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:05:34 -0700
Subject: [PATCH v10 06/22] base/node / acpi: Change 'node_hmem_attrs' to
 'access_coordinates'
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 10 Oct 2023 18:05:33 -0700
Message-ID: <169698633344.1991735.1745201451434063116.stgit@djiang5-mobl3>
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

Dan Williams suggested changing the struct 'node_hmem_attrs' to
'access_coordinates' [1]. The struct is a container of r/w-latency and
r/w-bandwidth numbers. Moving forward, this container will also be used by
CXL to store the performance characteristics of each link hop in
the PCIE/CXL topology. So, where node_hmem_attrs is just the access
parameters of a memory-node, access_coordinates applies more broadly
to hardware topology characteristics. The observation is that seemed like
an excercise in having the application identify "where" it falls on a
spectrum of bandwidth and latency needs. For the tuple of read/write-latency
and read/write-bandwidth, "coordinates" is not a perfect fit. Sometimes it
is just conveying values in isolation and not a "location" relative to
other performance points, but in the end this data is used to identify the
performance operation point of a given memory-node. [2]

Link: http://lore.kernel.org/r/64471313421f7_1b66294d5@dwillia2-xfh.jf.intel.com.notmuch/
Link: https://lore.kernel.org/linux-cxl/645e6215ee0de_1e6f2945e@dwillia2-xfh.jf.intel.com.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/numa/hmat.c |   20 ++++++++++----------
 drivers/base/node.c      |   12 ++++++------
 include/linux/node.h     |    8 ++++----
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index bba268ecd802..f9ff992038fa 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -62,7 +62,7 @@ struct memory_target {
 	unsigned int memory_pxm;
 	unsigned int processor_pxm;
 	struct resource memregions;
-	struct node_hmem_attrs hmem_attrs[2];
+	struct access_coordinate coord[2];
 	struct list_head caches;
 	struct node_cache_attrs cache_attrs;
 	bool registered;
@@ -227,24 +227,24 @@ static void hmat_update_target_access(struct memory_target *target,
 {
 	switch (type) {
 	case ACPI_HMAT_ACCESS_LATENCY:
-		target->hmem_attrs[access].read_latency = value;
-		target->hmem_attrs[access].write_latency = value;
+		target->coord[access].read_latency = value;
+		target->coord[access].write_latency = value;
 		break;
 	case ACPI_HMAT_READ_LATENCY:
-		target->hmem_attrs[access].read_latency = value;
+		target->coord[access].read_latency = value;
 		break;
 	case ACPI_HMAT_WRITE_LATENCY:
-		target->hmem_attrs[access].write_latency = value;
+		target->coord[access].write_latency = value;
 		break;
 	case ACPI_HMAT_ACCESS_BANDWIDTH:
-		target->hmem_attrs[access].read_bandwidth = value;
-		target->hmem_attrs[access].write_bandwidth = value;
+		target->coord[access].read_bandwidth = value;
+		target->coord[access].write_bandwidth = value;
 		break;
 	case ACPI_HMAT_READ_BANDWIDTH:
-		target->hmem_attrs[access].read_bandwidth = value;
+		target->coord[access].read_bandwidth = value;
 		break;
 	case ACPI_HMAT_WRITE_BANDWIDTH:
-		target->hmem_attrs[access].write_bandwidth = value;
+		target->coord[access].write_bandwidth = value;
 		break;
 	default:
 		break;
@@ -701,7 +701,7 @@ static void hmat_register_target_cache(struct memory_target *target)
 static void hmat_register_target_perf(struct memory_target *target, int access)
 {
 	unsigned mem_nid = pxm_to_node(target->memory_pxm);
-	node_set_perf_attrs(mem_nid, &target->hmem_attrs[access], access);
+	node_set_perf_attrs(mem_nid, &target->coord[access], access);
 }
 
 static void hmat_register_target_devices(struct memory_target *target)
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 493d533f8375..cb2b6cc7f6e6 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -74,14 +74,14 @@ static BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
  * @dev:	Device for this memory access class
  * @list_node:	List element in the node's access list
  * @access:	The access class rank
- * @hmem_attrs: Heterogeneous memory performance attributes
+ * @coord:	Heterogeneous memory performance coordinates
  */
 struct node_access_nodes {
 	struct device		dev;
 	struct list_head	list_node;
 	unsigned int		access;
 #ifdef CONFIG_HMEM_REPORTING
-	struct node_hmem_attrs	hmem_attrs;
+	struct access_coordinate	coord;
 #endif
 };
 #define to_access_nodes(dev) container_of(dev, struct node_access_nodes, dev)
@@ -167,7 +167,7 @@ static ssize_t property##_show(struct device *dev,			\
 			   char *buf)					\
 {									\
 	return sysfs_emit(buf, "%u\n",					\
-			  to_access_nodes(dev)->hmem_attrs.property);	\
+			  to_access_nodes(dev)->coord.property);	\
 }									\
 static DEVICE_ATTR_RO(property)
 
@@ -187,10 +187,10 @@ static struct attribute *access_attrs[] = {
 /**
  * node_set_perf_attrs - Set the performance values for given access class
  * @nid: Node identifier to be set
- * @hmem_attrs: Heterogeneous memory performance attributes
+ * @coord: Heterogeneous memory performance coordinates
  * @access: The access class the for the given attributes
  */
-void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
+void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 			 unsigned int access)
 {
 	struct node_access_nodes *c;
@@ -205,7 +205,7 @@ void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
 	if (!c)
 		return;
 
-	c->hmem_attrs = *hmem_attrs;
+	c->coord = *coord;
 	for (i = 0; access_attrs[i] != NULL; i++) {
 		if (sysfs_add_file_to_group(&c->dev.kobj, access_attrs[i],
 					    "initiators")) {
diff --git a/include/linux/node.h b/include/linux/node.h
index 427a5975cf40..25b66d705ee2 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -20,14 +20,14 @@
 #include <linux/list.h>
 
 /**
- * struct node_hmem_attrs - heterogeneous memory performance attributes
+ * struct access_coordinate - generic performance coordinates container
  *
  * @read_bandwidth:	Read bandwidth in MB/s
  * @write_bandwidth:	Write bandwidth in MB/s
  * @read_latency:	Read latency in nanoseconds
  * @write_latency:	Write latency in nanoseconds
  */
-struct node_hmem_attrs {
+struct access_coordinate {
 	unsigned int read_bandwidth;
 	unsigned int write_bandwidth;
 	unsigned int read_latency;
@@ -65,7 +65,7 @@ struct node_cache_attrs {
 
 #ifdef CONFIG_HMEM_REPORTING
 void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs);
-void node_set_perf_attrs(unsigned int nid, struct node_hmem_attrs *hmem_attrs,
+void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
 			 unsigned access);
 #else
 static inline void node_add_cache(unsigned int nid,
@@ -74,7 +74,7 @@ static inline void node_add_cache(unsigned int nid,
 }
 
 static inline void node_set_perf_attrs(unsigned int nid,
-				       struct node_hmem_attrs *hmem_attrs,
+				       struct access_coordinate *coord,
 				       unsigned access)
 {
 }


