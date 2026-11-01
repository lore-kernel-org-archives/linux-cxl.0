Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.209.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569891;
	b=aqSdI3UnPWpJm3iMZjQvTiWmC5sMU4EXAw4HLMxlTKWa5zWGCJgd/ZvhTxdeJHdr3wjS
	 ICWaWxKR7wssUKgyf3OBmsEWkijHu58wIImT1zmy88K/QMe6uE4aXieFxTnN1BUOikmLQ
	 qai5oHehChX6ASZql/tk6PRcjQbP/ko4dVLAU2P+1SwpsxorI8hPurF4C5xMmb1+VX33I
	 sz+ZqkKCwndGJkCMNAovNlACqpOY68zJl3ZL0tua3JKobWvHxE9VG5svVFHFX+dxS2Inu
	 jZK7lkZIYyFCFeJHWsM+XOhacOEEbnFv98ykVXI3L/uS/3VvH54k8qjsN5KE5k0OUhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569891;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Power-Wide-Eyed:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=scbRwJEYto2YCwi0LEctsxh0tpM+U5ih35WfZ7Xo/R8=;
	b=XcCIFovt2JBvDIDbjAs9TXt9EhWbgOPjbQRMDtszZP8R/zf+84xpRXjKBD57wDVCNPf5
	 6oisY3fCPKS9/xffCWhAFPpTELNZLi3P/PAM8VvKdgIRos23M6M4CLNpBPtk8qcKZRc/G
	 rTJxKI3sMalcjLMRF6itBNqdBEJZ7/mzGZV7J6e9kvBbbAqwrWSHd/sxvhuhfX3+v6Vdn
	 LiBAKSWcopqD1Bck4UZXLAywp4GZ5+Jv30Lbzfs9HB5I2PGAjB44qCYi9m1F0lMgH9QxK
	 M0AnFmE4WaFXUBcyDFjNaWcwJg4jF0FUIGEojTlquBIlM6/Xj7Kfgxe4S01G6eZnepg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b="U8/OKtDJ";
	arc=none smtp.remote-ip=23.83.209.151
Received: from quail.birch.relay.mailchannels.net (quail.birch.relay.mailchannels.net [23.83.209.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F69606A324
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 21:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F69606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=U8/OKtDJ
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 74D5F38109C;
	Sun, 01 Nov 2026 21:51:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a242.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.99.188.114])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 30827381A35;
	Sun, 01 Nov 2026 21:51:20 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Power-Wide-Eyed: 4e13b8dc76f3d49c_1793569884431_2365160870
X-MC-Loop-Signature: 1793569884431:695209185
X-MC-Ingress-Time: 1793569884431
Received: from pdx1-sub0-mail-a242.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.188.114 (trex/8.0.2);
	Sun, 01 Nov 2026 21:51:24 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a242.dreamhost.com (Postfix) with ESMTPSA id 4jHpSR3cFdz103y;
	Sun,  1 Nov 2026 13:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793569880;
	bh=scbRwJEYto2YCwi0LEctsxh0tpM+U5ih35WfZ7Xo/R8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=U8/OKtDJ3IhBk/euUPW3fzyD+y69bc3E3afkfUH1DOTvkRotdHwsopx13pRY6M7U8
	 OvNAp/xwYg3hJG51+Fj+sSLQLMMKMkN/LUm99dC+C4guHNUqQV7Hcwx9iKLn860O/G
	 iFedkeyldnTJckjSH3kpBV2JR6/7UKPgkLLvaiQK6Ud/+ORTLtZsb31PyBuTM4eQpm
	 Mu7lzXrQYZQLH9de/mkZOpdNHhxOye9Akli1/jBaJS3RuyZ83qBv5glF9X9qr8Gk6Q
	 dJjohB9EWSRI+iVTvz0SrNk0t0WehdzPVxX1C9f/iDu3HCPoGR3Z/SvezIjaY09+sw
	 o/x4arKTyW6Aw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v10 09/10] cxl/test: Add mock BI topology support
Date: Sun,  1 Nov 2026 13:51:06 -0800
Message-Id: <3d78865a3f681c41951e0347c266105258cf1de8.1793567979.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793567979.git.dave@stgolabs.net>
References: <cover.1793567979.git.dave@stgolabs.net>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
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

Committed BI state is a decoder flag, so the mock sets
CXL_DECODER_F_BI on decoder commit and clears it on reset, and
restores it on saved-decoder replay - letting a committed HDM-DB
region survive a cxl_acpi rebind with no register to emulate.
Endpoints get a page of plain memory standing in for BI Decoder
Control, with BI Enable set, since committing an HDM-DB region reads
it back. The accelerator grows to 1G of capacity so the boot-time
auto region leaves DPA for a BI region.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/testing/cxl/Kbuild       |   1 +
 tools/testing/cxl/test/accel.c |   2 +-
 tools/testing/cxl/test/cxl.c   | 149 ++++++++++++++++++++++++++++++++-
 tools/testing/cxl/test/mock.c  |  13 +++
 tools/testing/cxl/test/mock.h  |   1 +
 5 files changed, 162 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index e49ce644b4b1..39b4bb2e0404 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -14,6 +14,7 @@ wrap_cxl_core += --wrap=devm_cxl_add_dport_by_dev
 wrap_cxl_core += --wrap=devm_cxl_switch_port_decoders_setup
 wrap_cxl_core += --wrap=devm_cxl_endpoint_decoders_setup
 wrap_cxl_core += --wrap=cxl_endpoint_parse_cdat
+wrap_cxl_core += --wrap=cxl_bi_probe_capable
 LDFLAGS_cxl_acpi.o += $(wrap_cxl_core)
 LDFLAGS_cxl_pmem.o += $(wrap_cxl_core)
 LDFLAGS_cxl_port.o += $(wrap_cxl_core)
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
index 3eb1051b1ee8..12fe1c3bdc92 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -191,6 +191,10 @@ static struct {
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
@@ -374,6 +378,22 @@ static struct {
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
@@ -535,6 +555,12 @@ static int populate_cedt(void)
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
 
@@ -570,12 +596,17 @@ static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
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
@@ -737,10 +768,43 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port,
 	cxlhdm->port = port;
 	cxlhdm->interleave_mask = ~0U;
 	cxlhdm->iw_cap_mask = ~0UL;
+
+	/* a page stands in for the endpoint's BI Decoder block, Enable set */
+	if (is_cxl_endpoint(port)) {
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
+/* committed BI state is a decoder flag, so no register to emulate */
+static void mock_decoder_set_bi(struct cxl_decoder *cxld, bool bi)
+{
+	if (!is_endpoint_decoder(&cxld->dev))
+		return;
+
+	if (bi)
+		cxld->flags |= CXL_DECODER_F_BI;
+	else
+		cxld->flags &= ~CXL_DECODER_F_BI;
+}
+
 struct target_map_ctx {
 	u32 *target_map;
 	int index;
@@ -974,6 +1038,7 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 
 		cxled->state = CXL_DECODER_STATE_AUTO;
 	}
+	mock_decoder_set_bi(cxld, mock_hpa_is_bi(cxld->hpa_range.start));
 	cxld_registry_update(cxld);
 
 	return 0;
@@ -1003,6 +1068,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 		cxled->state = CXL_DECODER_STATE_MANUAL;
 		cxled->skip = 0;
 	}
+	mock_decoder_set_bi(cxld, false);
 	if (decoder_reset_preserve_registry)
 		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
 			cxld->id);
@@ -1163,8 +1229,13 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
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
@@ -1523,9 +1594,12 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
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
@@ -1534,6 +1608,13 @@ static int __mock_cxl_decoders_setup(struct cxl_port *port)
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
 
@@ -1722,6 +1803,67 @@ mock_region_intersects_soft_reserve(resource_size_t start, size_t size)
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
@@ -1740,6 +1882,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
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

