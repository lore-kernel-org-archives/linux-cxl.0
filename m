Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC84625
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370899; cv=none; b=kT5OwV3w4t7tamH7onZ3CXG/Cw4h1iFelcHUvDWeyuYweytN6//JZhJyWgFykUiQLCtcm6rHshV0b9Z2V3V+njrKEiG3FcrhhFq2hyKSmxKm14iASpU9Iukiab87BCS+6US6Kz67Dv6t3a8swJJsgVT1KBj2uO319bxO/qznE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370899; c=relaxed/simple;
	bh=RlgXTx99TLMTe9dpY8FdJqkEG3sILk446QrE192dGH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9zYX6GE+qnD4Vvr96/gM3XgMja0xz/8Ajk4vIeTaNtkjJqIwWkOdzeswZWHMKv32OWJWsuFZ7utgj3b1l/pKkKZhzJ24jsH58IojYfqZrBMxFvvoDSxk8B9+3Q5E9+seW6bctxdv+xj+7blVzZVMBIW4iztq54K5GWfpOJH5Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05766C4CED1;
	Sat,  1 Feb 2025 00:48:18 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH resend v2 1/3] cxl: Add cxl_bus_get_by_provider()
Date: Fri, 31 Jan 2025 17:47:29 -0700
Message-ID: <20250201004815.474741-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250201004815.474741-1-dave.jiang@intel.com>
References: <20250201004815.474741-1-dave.jiang@intel.com>
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

