Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0F176AB5
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972042; cv=none; b=VSdGvKkIgGeFXixLORmIxnPoUWoHq+9Env76QWPLTReSdpdnr/YPNO+cnpqoJihAS2xdESLNeLzPqOKvF64iWWzioHu1R9w16Zx/ArXKyRr6weW55l3kEKwn9lGAGpw0sYvjObuFH5CKu5pUSoYVnjnvBNZV97myFHAzQeqPGDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972042; c=relaxed/simple;
	bh=RlgXTx99TLMTe9dpY8FdJqkEG3sILk446QrE192dGH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHAiEUHpd9YrsWRBYjqB4sv3eNDkbatH/+qjSIVFx377zRaf8ER9DzVNc6BWfPKCl/IghnjO4iL2wS/1tSMTzHarZr66tkWLema/fKWpJC3r/GEP4fz+iQQqem13/REJL0STI1f5Om45LC+cqH4GhIRFD3MMU3zDMJ4PDkkXwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10386C4CED1;
	Fri,  7 Feb 2025 23:47:21 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH v3 1/3] cxl: Add cxl_bus_get_by_provider()
Date: Fri,  7 Feb 2025 16:46:33 -0700
Message-ID: <20250207234718.2387622-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207234718.2387622-1-dave.jiang@intel.com>
References: <20250207234718.2387622-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper function cxl_bus_get_by_provider() in order to support unit
test that will utilize the API call.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/lib/libcxl.c   | 11 +++++++++++
 cxl/lib/libcxl.sym |  5 +++++
 cxl/libcxl.h       |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 63aa4ef3acdc..bab7343e8a4a 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -3358,6 +3358,17 @@ CXL_EXPORT struct cxl_ctx *cxl_bus_get_ctx(struct cxl_bus *bus)
 	return cxl_port_get_ctx(&bus->port);
 }
 
+CXL_EXPORT struct cxl_bus *cxl_bus_get_by_provider(struct cxl_ctx *ctx,
+						   const char *provider)
+{
+	struct cxl_bus *bus;
+
+	cxl_bus_foreach(ctx, bus)
+		if (strcmp(provider, cxl_bus_get_provider(bus)) == 0)
+			return bus;
+	return NULL;
+}
+
 CXL_EXPORT void cxl_cmd_unref(struct cxl_cmd *cmd)
 {
 	if (!cmd)
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 0c155a40ad47..1fc33cc6e1a4 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -288,3 +288,8 @@ global:
 	cxl_memdev_trigger_poison_list;
 	cxl_region_trigger_poison_list;
 } LIBCXL_7;
+
+LIBCXL_9 {
+global:
+	cxl_bus_get_by_provider;
+} LIBECXL_8;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 0a5fd0e13cc2..3b309968a808 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -122,6 +122,8 @@ int cxl_bus_get_id(struct cxl_bus *bus);
 struct cxl_port *cxl_bus_get_port(struct cxl_bus *bus);
 struct cxl_ctx *cxl_bus_get_ctx(struct cxl_bus *bus);
 int cxl_bus_disable_invalidate(struct cxl_bus *bus);
+struct cxl_bus *cxl_bus_get_by_provider(struct cxl_ctx *ctx,
+					const char *provider);
 
 #define cxl_bus_foreach(ctx, bus)                                              \
 	for (bus = cxl_bus_get_first(ctx); bus != NULL;                        \
-- 
2.48.1

