Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA03F6C42
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120871; cv=none; b=hHcf3q7U/XuwsdCH+BgdZicfnsf2eq4FwXjKgZF31vG3CTp4db/DkYsbqoijQhXYkTNc1MR/txsnBS6nAzIXJKuVtjtjyAaRwalmcRlplWrV1R1gLGwbnaFqr16RmXyULcjH3mZAN75L1z8NwnEaTNvpac5Nb/GHtDy4+UxNTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120871; c=relaxed/simple;
	bh=uHjVFBWSdewg42IPRw4XPV8nbs9oAoTlYx341WurTBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=neSIVCgQOha2UgirqujxO+1xbdUj9njz2TA9+ResUdI/GmUTxv8v7F3FOXhEDqZO0Y+46Wwdth5+tAIvhOKealxYB0Z3qsEOeM1GCw8T46ZIp3sPcZX7Id/Cx7tOMFtlnYEjHrYnKfNt7drPXxDnFw7hRfbeseIXy1MjjBN/cbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=JWZfNVCo; arc=none smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="JWZfNVCo"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D1CDD402391;
	Tue, 22 Sep 2026 23:39:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.99.73.60])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 90EFE4019D2;
	Tue, 22 Sep 2026 23:39:06 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Illegal: 280fc14119f22b7f_1790120350814_1787965571
X-MC-Loop-Signature: 1790120350814:1622219835
X-MC-Ingress-Time: 1790120350813
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.73.60 (trex/8.0.2);
	Tue, 22 Sep 2026 23:39:10 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4hqGlF5zDKzND;
	Tue, 22 Sep 2026 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1790120346;
	bh=0M45LNtTMnLVNVlIJ0wlvgPFGje174NwZEtXYI2/C4Y=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=JWZfNVCoyjoj85oNuJTeecMAK+PrZaFsABNB1FvwA+C4erDH/9puPFggQcyxXkPJA
	 JxIiRMAsiPrEDwXAWE4w7BVOJTun3Sfljhl54artRm5s5FcNgjczgV7opuCmYCEcvY
	 OVmBxtdFZJihroF+gccUHdCl65vzoF7nfdzfhRux52PiGJRlicEM6K20sc2i8RIftw
	 qk5AqewXFXBJz0j0/ndGWyn6QfLOa1eZ5G0MEphz/sJzkOIbRq0yuAzw4hswL1TmZl
	 dOXFWaUvN28s/ZWWYl67DYvbIKrjfZ+JwdmlSQFYven16rB9SimHS1Ic3PXon/5ISs
	 cw5a7kQUOSNdw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v9 09/10] cxl/test: Add mock BI topology support
Date: Tue, 22 Sep 2026 16:38:46 -0700
Message-Id: <113381dfa31a452a5522ed84b14a3b77b6e027f3.1790103847.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790103847.git.dave@stgolabs.net>
References: <cover.1790103847.git.dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the mock topology with a Back-Invalidate path
covering both the type3 memdevs and the type2 accelerator.

Following the framework's convention of substituting software state
for register programming, cxl_bi_probe_capable() gains a --wrap shim
dispatching through cxl_mock_ops, and the mock decoder setup enables
BI in software in place of cxl_bi_setup(). The mock setup mirrors
cxl_bi_enable_path()'s walk - dport nr_bi accounting up to the root,
unwound by a devm action - and the capability check keeps the
VH-only rule.

A single HDM-DB window (BI | DEVMEM | VOLATILE, targeting host
bridge 0) is emitted in every topology mode and parses into a
CXL_DECODER_F_BI root decoder; DEVMEM satisfies can_create_ram().
In type2 mode it coexists with the accelerator's HDM-D window.

cxled_committed_bi() reads the BI bit from the HDM decoder
registers, so each mock port's cxl_hdm carries a page of plain
memory as that register block, maintained on decoder commit/reset
and restored on saved-decoder replay - letting a committed HDM-DB
region survive a cxl_acpi rebind. Endpoints get a second such page
standing in for BI Decoder Control, with BI Enable set, since
committing an HDM-DB region reads it back. The accelerator grows to
1G of capacity so the boot-time auto region leaves DPA for a BI
region.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/testing/cxl/Kbuild       |   1 +
 tools/testing/cxl/test/accel.c |   2 +-
 tools/testing/cxl/test/cxl.c   | 171 ++++++++++++++++++++++++++++++++-
 tools/testing/cxl/test/mock.c  |  13 +++
 tools/testing/cxl/test/mock.h  |   1 +
 5 files changed, 184 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..811fb43225b8 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -14,6 +14,7 @@ ldflags-y += --wrap=devm_cxl_switch_port_decoders_setup
 ldflags-y += --wrap=walk_hmem_resources
 ldflags-y += --wrap=region_intersects
 ldflags-y += --wrap=region_intersects_soft_reserve
+ldflags-y += --wrap=cxl_bi_probe_capable
 
 DRIVERS := ../../../drivers
 DAX_HMEM_SRC := $(DRIVERS)/dax/hmem
diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
index 8e6f4687ca02..f3800083ea27 100644
--- a/tools/testing/cxl/test/accel.c
+++ b/tools/testing/cxl/test/accel.c
@@ -31,7 +31,7 @@ static int cxl_mock_accel_probe(struct platform_device *pdev)
 
 	cxlds = &cxl_accel->cxlds;
 	cxlds->media_ready = true;
-	rc = cxl_set_capacity(cxlds, SZ_512M);
+	rc = cxl_set_capacity(cxlds, SZ_1G);
 	if (rc)
 		return rc;
 
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 62bd92b3be45..cddea44e780a 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -190,6 +190,10 @@ static struct {
 		struct acpi_cedt_cfmws cfmws;
 		u32 target[3];
 	} cfmws8;
+	struct {
+		struct acpi_cedt_cfmws cfmws;
+		u32 target[1];
+	} cfmws_bi;
 	struct {
 		struct acpi_cedt_cxims cxims;
 		u64 xormap_list[2];
@@ -373,6 +377,22 @@ static struct {
 		},
 		.target = { 0, 1, 2, },
 	},
+	.cfmws_bi = {
+		.cfmws = {
+			.header = {
+				.type = ACPI_CEDT_TYPE_CFMWS,
+				.length = sizeof(mock_cedt.cfmws_bi),
+			},
+			.interleave_ways = 0,
+			.granularity = 4,
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_BI |
+					ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
+					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
+			.qtg_id = FAKE_QTG_ID,
+			.window_size = SZ_256M * 4UL,
+		},
+		.target = { 0 },
+	},
 	.cxims0 = {
 		.cxims = {
 			.header = {
@@ -534,6 +554,12 @@ static int populate_cedt(void)
 		window->base_hpa = res->range.start;
 	}
 
+	res = alloc_mock_res(mock_cedt.cfmws_bi.cfmws.window_size,
+			     max_t(int, SZ_256M, PMD_SIZE));
+	if (!res)
+		return -ENOMEM;
+	mock_cedt.cfmws_bi.cfmws.base_hpa = res->range.start;
+
 	return 0;
 }
 
@@ -569,12 +595,17 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
 			handler_arg(h, arg, end);
 		}
 
-	if (id == ACPI_CEDT_TYPE_CFMWS)
+	if (id == ACPI_CEDT_TYPE_CFMWS) {
 		for (i = cfmws_start; i <= cfmws_end; i++) {
 			h = (union acpi_subtable_headers *) mock_cfmws[i];
 			end = (unsigned long) h + mock_cfmws[i]->header.length;
 			handler_arg(h, arg, end);
 		}
+		/* one HDM-DB window in every topology */
+		h = (union acpi_subtable_headers *)&mock_cedt.cfmws_bi.cfmws;
+		end = (unsigned long)h + mock_cedt.cfmws_bi.cfmws.header.length;
+		handler_arg(h, arg, end);
+	}
 
 	if (id == ACPI_CEDT_TYPE_CXIMS)
 		for (i = 0; i < ARRAY_SIZE(mock_cxims); i++) {
@@ -736,10 +767,65 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port,
 	cxlhdm->port = port;
 	cxlhdm->interleave_mask = ~0U;
 	cxlhdm->iw_cap_mask = ~0UL;
+
+	/*
+	 * A page of plain memory stands in for the HDM decoder register
+	 * block: cxled_committed_bi() reads the per-decoder BI bit from
+	 * it, which mock_decoder_commit()/reset() maintain below. All
+	 * other consumers of these registers are bypassed by the mocked
+	 * decoder setup and commit paths.
+	 */
+	cxlhdm->regs.hdm_decoder =
+		(void __iomem *)devm_get_free_pages(dev,
+						    GFP_KERNEL | __GFP_ZERO, 0);
+	if (!cxlhdm->regs.hdm_decoder)
+		return ERR_PTR(-ENOMEM);
+
+	/* likewise for the endpoint's BI Decoder block, BI Enable set */
+	if (is_cxl_endpoint(port) && !port->regs.bi_decoder) {
+		void __iomem *bi = (void __iomem *)
+			devm_get_free_pages(dev, GFP_KERNEL | __GFP_ZERO, 0);
+
+		if (!bi)
+			return ERR_PTR(-ENOMEM);
+		writel(CXL_BI_DECODER_CTRL_BI_ENABLE,
+		       bi + CXL_BI_DECODER_CTRL_OFFSET);
+		port->regs.bi_decoder = bi;
+	}
+
 	dev_set_drvdata(dev, cxlhdm);
 	return cxlhdm;
 }
 
+/* HPA-based, so replay after cxl_acpi rebind can re-derive it */
+static bool mock_hpa_is_bi(u64 hpa)
+{
+	struct acpi_cedt_cfmws *bi = &mock_cedt.cfmws_bi.cfmws;
+
+	return hpa >= bi->base_hpa && hpa < bi->base_hpa + bi->window_size;
+}
+
+static void mock_decoder_set_bi(struct cxl_decoder *cxld, bool bi)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	void __iomem *ctrl;
+	u32 val;
+
+	if (!is_endpoint_decoder(&cxld->dev) || !cxlhdm ||
+	    !cxlhdm->regs.hdm_decoder)
+		return;
+
+	ctrl = cxlhdm->regs.hdm_decoder +
+	       CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id);
+	val = readl(ctrl);
+	if (bi)
+		val |= CXL_HDM_DECODER0_CTRL_BI;
+	else
+		val &= ~CXL_HDM_DECODER0_CTRL_BI;
+	writel(val, ctrl);
+}
+
 struct target_map_ctx {
 	u32 *target_map;
 	int index;
@@ -974,6 +1060,7 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 
 		cxled->state = CXL_DECODER_STATE_AUTO;
 	}
+	mock_decoder_set_bi(cxld, mock_hpa_is_bi(cxld->hpa_range.start));
 	cxld_registry_update(cxld);
 
 	return 0;
@@ -1003,6 +1090,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 		cxled->state = CXL_DECODER_STATE_MANUAL;
 		cxled->skip = 0;
 	}
+	mock_decoder_set_bi(cxld, false);
 	if (decoder_reset_preserve_registry)
 		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
 			cxld->id);
@@ -1130,8 +1218,13 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
 	else
 		enabled = td->cxled.cxld.flags & CXL_DECODER_F_ENABLE;
 
-	if (enabled)
-		return !cxld_registry_restore(cxld, td);
+	if (enabled) {
+		if (cxld_registry_restore(cxld, td))
+			return false;
+		mock_decoder_set_bi(cxld,
+				    mock_hpa_is_bi(cxld->hpa_range.start));
+		return true;
+	}
 
 	init_disabled_mock_decoder(cxld);
 	return false;
@@ -1453,9 +1546,12 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	return 0;
 }
 
+static int mock_cxl_bi_setup(struct cxl_port *endpoint);
+
 static int __mock_cxl_decoders_setup(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
+	int rc;
 
 	cxlhdm = mock_cxl_setup_hdm(port, NULL);
 	if (IS_ERR(cxlhdm)) {
@@ -1464,6 +1560,13 @@ static int __mock_cxl_decoders_setup(struct cxl_port *port)
 		return PTR_ERR(cxlhdm);
 	}
 
+	/* as the real setup: BI between the HDM state and the decoders */
+	if (is_cxl_endpoint(port)) {
+		rc = mock_cxl_bi_setup(port);
+		if (rc)
+			dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);
+	}
+
 	return mock_cxl_enumerate_decoders(cxlhdm, NULL);
 }
 
@@ -1652,6 +1755,67 @@ mock_region_intersects_soft_reserve(resource_size_t start, size_t size)
 	return -1;
 }
 
+/*
+ * All-software mirror of the BI enable path: no BI RT registers exist
+ * on mock devices, so capability and enablement are asserted directly
+ * while the dport nr_bi accounting - the part with driver-visible
+ * semantics (shared transit dports, teardown order) - follows the same
+ * walk the real cxl_bi_enable_path() takes.
+ */
+static void mock_cxl_bi_probe_capable(struct cxl_port *endpoint)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	/* BI is VH-only, mirroring cxl_bi_probe_capable() */
+	cxlds->bi_capable = !cxlds->rcd;
+}
+
+static void mock_cxl_bi_dealloc(void *data)
+{
+	struct cxl_port *endpoint = data;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_dport *dport_iter;
+	struct cxl_port *port_iter;
+
+	cxlds->bi = false;
+	dport_iter = endpoint->parent_dport;
+	port_iter = dport_iter->port;
+	while (port_iter->parent_dport) {
+		scoped_guard(mutex, &port_iter->bi_lock) {
+			if (!WARN_ON_ONCE(dport_iter->nr_bi == 0))
+				dport_iter->nr_bi--;
+		}
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+}
+
+static int mock_cxl_bi_setup(struct cxl_port *endpoint)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_dport *dport_iter;
+	struct cxl_port *port_iter;
+
+	if (!cxlds->bi_capable)
+		return 0;
+
+	dport_iter = endpoint->parent_dport;
+	port_iter = dport_iter->port;
+	while (port_iter->parent_dport) {
+		scoped_guard(mutex, &port_iter->bi_lock)
+			dport_iter->nr_bi++;
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+	cxlds->bi = true;
+
+	return devm_add_action_or_reset(&endpoint->dev, mock_cxl_bi_dealloc,
+					endpoint);
+}
+
 static struct cxl_mock_ops cxl_mock_ops = {
 	.is_mock_adev = is_mock_adev,
 	.is_mock_bridge = is_mock_bridge,
@@ -1670,6 +1834,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.walk_hmem_resources = mock_walk_hmem_resources,
 	.region_intersects = mock_region_intersects,
 	.region_intersects_soft_reserve = mock_region_intersects_soft_reserve,
+	.cxl_bi_probe_capable = mock_cxl_bi_probe_capable,
 	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
 };
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 6454b868b122..eabc9bba0fac 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -181,6 +181,19 @@ int __wrap_devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_endpoint_decoders_setup, "CXL");
 
+void __wrap_cxl_bi_probe_capable(struct cxl_port *endpoint)
+{
+	int index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(endpoint->uport_dev))
+		ops->cxl_bi_probe_capable(endpoint);
+	else
+		cxl_bi_probe_capable(endpoint);
+	put_cxl_mock_ops(index);
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_cxl_bi_probe_capable, "CXL");
+
 int __wrap_cxl_await_media_ready(struct cxl_dev_state *cxlds)
 {
 	int rc, index;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 846d7c5d6eaa..c7919c3eb875 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -35,6 +35,7 @@ struct cxl_mock_ops {
 				 unsigned long flags, unsigned long desc);
 	int (*region_intersects_soft_reserve)(resource_size_t start,
 					      size_t size);
+	void (*cxl_bi_probe_capable)(struct cxl_port *endpoint);
 };
 
 int hmem_test_init(void);
-- 
2.39.5

