Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BFCA934
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591959; cv=none; b=mvu2kBgH54/qZaIJe8Q19B6AvRlEcNilD3h63p51RuGxSiuefu3EBBnKwoUM8uqKq28W/bKmKxuKNQzWvIRiCo8dHAiEFGAHOt6j2cdClnqwUkVDETklz1nu9ZmuP7AvgfgZnE4GgreJtjQFeX6oglxAffLXTZmkcgMYwM2AGZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591959; c=relaxed/simple;
	bh=C2MOQyjDW+N1Y4WqNe8wjUNU8wx9Wzwi/pDVLowu/BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAbxGXgt1tge35bo77mJPBUdR3d+vBJYNXHhHtAI0YbdCs8/lre+Ucygl8YCsCMcFhpgx7fgfYiI694SfjQXuA+bZTYrbG38C8GZ6A2RwB1J9dbFGZ3zrJo0GzmDXI7D/fn1ByD79+OOLZ4uMoetj4DiprMNP/ORAdXmpttj9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04570C4CED2;
	Thu, 23 Jan 2025 00:25:58 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH resend 4/5] cxl: Associate CXL features device with CXL endpoint
Date: Wed, 22 Jan 2025 17:24:53 -0700
Message-ID: <20250123002530.2762440-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123002530.2762440-1-dave.jiang@intel.com>
References: <20250123002530.2762440-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of cxl_features_get_bus() by setting up the association
between 'cxl endpoint' and 'cxl features'. Add related helper functions
for assisting the setup of the relationship with 'features' and 'endpoint'.
The 'endpoint' is considered as the parent device of 'features' given a
'features' device is exported per CXL mailbox. The association is
established by matching the feature's parent device with the endpoint's
uport deivce. For example, on cxl_test bus provider, both should match
to cxl_memN device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/lib/libcxl.c   | 107 +++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |   4 ++
 cxl/lib/private.h  |   3 ++
 cxl/libcxl.h       |   4 ++
 4 files changed, 118 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index f2da48278cb0..f13b0055f332 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -213,6 +213,7 @@ static void free_port(struct cxl_port *port, struct list_head *head)
 static void free_endpoint(struct cxl_endpoint *endpoint, struct list_head *head)
 {
 	__free_port(&endpoint->port, head);
+	free(endpoint->uport_host);
 	free(endpoint);
 }
 
@@ -2044,6 +2045,7 @@ static void *add_cxl_endpoint(void *parent, int id, const char *cxlep_base)
 	struct cxl_endpoint *endpoint, *endpoint_dup;
 	struct cxl_port *port = parent;
 	struct cxl_ctx *ctx = cxl_port_get_ctx(port);
+	char *uport_path, *host_path;
 	int rc;
 
 	dbg(ctx, "%s: base: \'%s\'\n", devname, cxlep_base);
@@ -2057,6 +2059,17 @@ static void *add_cxl_endpoint(void *parent, int id, const char *cxlep_base)
 	if (rc)
 		goto err;
 
+
+	uport_path = strdup(endpoint->port.uport);
+	if (!uport_path)
+		goto err;
+
+	host_path = dirname(uport_path);
+	endpoint->uport_host = strdup(devpath_to_devname(host_path));
+	free(uport_path);
+	if (!endpoint->uport_host)
+		goto err;
+
 	cxl_endpoint_foreach(port, endpoint_dup)
 		if (endpoint_dup->port.id == endpoint->port.id) {
 			free_endpoint(endpoint, NULL);
@@ -2168,6 +2181,11 @@ cxl_endpoint_get_memdev(struct cxl_endpoint *endpoint)
 	return NULL;
 }
 
+CXL_EXPORT const char *cxl_endpoint_get_uport_hostname(struct cxl_endpoint *endpoint)
+{
+	return endpoint->uport_host;
+}
+
 static bool cxl_region_is_configured(struct cxl_region *region)
 {
 	return region->size && (region->decode_state != CXL_DECODE_RESET);
@@ -4884,3 +4902,92 @@ CXL_EXPORT int cxl_features_get_minor(struct cxl_features *features)
 {
 	return features->minor;
 }
+
+CXL_EXPORT const char *cxl_features_get_hostname(struct cxl_features *features)
+{
+	return features->hostname;
+}
+
+CXL_EXPORT const char *cxl_features_get_devname(struct cxl_features *features)
+{
+	return devpath_to_devname(features->dev_path);
+}
+
+static struct cxl_endpoint *
+cxl_port_recurse_endpoint_by_features(struct cxl_port *parent_port,
+				      struct cxl_features *features)
+{
+	struct cxl_endpoint *endpoint;
+	struct cxl_port *port;
+
+	cxl_port_foreach(parent_port, port) {
+		cxl_endpoint_foreach(port, endpoint)
+			if (strcmp(cxl_endpoint_get_uport_hostname(endpoint),
+				   cxl_features_get_hostname(features)) == 0)
+				return endpoint;
+		endpoint = cxl_port_recurse_endpoint_by_features(port, features);
+		if (endpoint)
+			return endpoint;
+	}
+
+	return NULL;
+}
+
+static struct cxl_endpoint *
+cxl_port_find_endpoint_by_features(struct cxl_port *parent_port,
+				   struct cxl_features *features)
+{
+	struct cxl_endpoint *endpoint;
+
+	cxl_endpoint_foreach(parent_port, endpoint)
+		if (strcmp(cxl_endpoint_get_uport_hostname(endpoint),
+			   cxl_features_get_hostname(features)) == 0)
+			return endpoint;
+	return cxl_port_recurse_endpoint_by_features(parent_port, features);
+}
+
+CXL_EXPORT struct cxl_endpoint *
+cxl_features_get_endpoint(struct cxl_features *features)
+{
+	struct cxl_ctx *ctx = cxl_features_get_ctx(features);
+	struct cxl_endpoint *endpoint = NULL;
+	struct cxl_bus *bus;
+
+	if (features->endpoint)
+		return features->endpoint;
+
+	cxl_bus_foreach(ctx, bus) {
+		struct cxl_port *port = cxl_bus_get_port(bus);
+
+		endpoint = cxl_port_find_endpoint_by_features(port, features);
+		if (endpoint)
+			break;
+	}
+
+	if (!endpoint)
+		return NULL;
+
+	if (endpoint->features && endpoint->features != features)
+		err(ctx, "%s assigned to %s not %s\n",
+		    cxl_endpoint_get_devname(endpoint),
+		    cxl_features_get_devname(endpoint->features),
+		    cxl_features_get_devname(features));
+	features->endpoint = endpoint;
+	endpoint->features = features;
+
+	return endpoint;
+}
+
+CXL_EXPORT struct cxl_bus *cxl_features_get_bus(struct cxl_features *features)
+{
+	struct cxl_endpoint *endpoint = cxl_features_get_endpoint(features);
+
+	if (!endpoint)
+		return NULL;
+	return cxl_endpoint_get_bus(endpoint);
+}
+
+CXL_EXPORT struct cxl_ctx *cxl_features_get_ctx(struct cxl_features *features)
+{
+	return features->ctx;
+}
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 6d70d5b90377..a29d42e1414b 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -296,4 +296,8 @@ global:
 	cxl_features_get_next;
 	cxl_features_get_major;
 	cxl_features_get_minor;
+	cxl_features_get_hostname;
+	cxl_features_get_bus;
+	cxl_features_get_ctx;
+	cxl_features_get_devname;
 } LIBECXL_8;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 34785af4e64f..b38ee7d33a40 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -37,6 +37,7 @@ enum cxl_fwl_loading {
 struct cxl_features {
 	int id, major, minor;
 	struct cxl_ctx *ctx;
+	struct cxl_endpoint *endpoint;
 	void *dev_buf;
 	size_t buf_len;
 	char *host_path;
@@ -122,6 +123,8 @@ struct cxl_bus {
 struct cxl_endpoint {
 	struct cxl_port port;
 	struct cxl_memdev *memdev;
+	struct cxl_features *features;
+	char *uport_host;
 };
 
 struct cxl_target {
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 5dcc60c8bf1a..610c13051b6d 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -499,6 +499,10 @@ struct cxl_features *cxl_features_get_first(struct cxl_ctx *ctx);
 struct cxl_features *cxl_features_get_next(struct cxl_features *features);
 int cxl_features_get_major(struct cxl_features *features);
 int cxl_features_get_minor(struct cxl_features *features);
+const char *cxl_features_get_devname(struct cxl_features *features);
+const char *cxl_features_get_hostname(struct cxl_features *features);
+struct cxl_bus *cxl_features_get_bus(struct cxl_features *features);
+struct cxl_ctx *cxl_features_get_ctx(struct cxl_features *features);
 
 #ifdef __cplusplus
 } /* extern "C" */
-- 
2.47.1

