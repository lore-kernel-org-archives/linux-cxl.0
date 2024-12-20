Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5430B2156FD
	for <linux-cxl@vger.kernel.org>; Fri, 20 Dec 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713030; cv=pass; b=WgF1vnJzzJN+pXvU8AQ8Kv7qViXPuOFNHxT4XNlbSrE7YdhVKanTYR5emNQRZEI3pRPNZgJB2prALI0QIso9O686iORFwTvKP98aOcTgmRHWTT6fLtcQ8vWp0RRtmDgWgWPW5NVd2/06qBKezLUp6ncHPP9jDQuK8kK3oT2G1yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713030; c=relaxed/simple;
	bh=ew6qRswCmaSUUplxzSaCDNWZSw6i3NymhNZqQCUzs0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bix/T/WX2Kl9dxbE2UvJnYBgp5iQorsrzQjYdi+weYpQgUMDQsuHVq82g5n0oVMxfHYyMdT21Eqt7sEicMlbXM2sGbl1jsJm93R01ERV9PqqJddCd3/wuVoXYrASXg0A6/0DU4LtGKys+uSabL0kHj99ONdksElQAEsOhYiIRtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=R9fAixIc; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="R9fAixIc"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C7F3918408F;
	Fri, 20 Dec 2024 16:43:47 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.103.144.232])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5E158183FA6;
	Fri, 20 Dec 2024 16:43:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1734713027; a=rsa-sha256;
	cv=none;
	b=FnW1PI8WDYNBCm5SQE48e+qA/Qaj4u2s0fUv6NQ1+uG2BSoPHa6puHMfgRWfufjrDWker7
	E9kUBLWi/FNW/WbZO/TgjCG/8gO12ITsJbsZoeLZEaHzFqUhpE9jhuJ6W7IWqSTa8b4uDU
	h2tAc+6QTYsld84xVnlvq1Wy/T0VoADcg9FBBOs/f6tCqLqHzYGw32kz2K1uaP69ckznQs
	8or9DFLS/gqOH3qx4e/DXavFkRNmtRhhLO516Ub+FKdpiEy0UyYROwbbSY1mFML9r6LTg5
	mOugnqK6jcMwKQEi1BcD2fnYuLNFJvaixAgEg5X3xwOlalYCEyl1NF78fryQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1734713027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tUt02zNqmI7T1j/HAtHqrv6HOTN/B0PBFTW+8Lju63Q=;
	b=wkwLQoboJlT1utEPVmAjaHdz8a2cEiJe6vMUcuP0Q2/xcdusumEauAMd+cOXwGkee0Inoh
	Gn76amMfFVLKe0x26efXhUVmdb2BdKYzJbQxUI1S52yvJrV6QFdYlIW0N+YOaPBCd2QTcF
	v5G1XPobAb2x0o6N8lPxfCcH8LQEpxe1iqMFjf6zn3Xj2P+6pwl8t7Ftsic0PSDsyi5prz
	mlIpjnunZaFAdZkob3AsKcb92EiPjKhmYwZetvkCb8gLL7vwW4sLG+CYzaarC5KWQ+xta4
	QZLWp9eujYoaXWAQIQv7bhJN3k354udXOwQQ76g4zTUnB0BYVBu+DYMoJOVy8g==
ARC-Authentication-Results: i=1;
	rspamd-7d788bbf85-ds7ph;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Stupid: 065fcbcc2763bcf1_1734713027713_256184708
X-MC-Loop-Signature: 1734713027713:3673073662
X-MC-Ingress-Time: 1734713027713
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.144.232 (trex/7.0.2);
	Fri, 20 Dec 2024 16:43:47 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4YFCst3Z8ZzKm;
	Fri, 20 Dec 2024 08:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1734713027;
	bh=tUt02zNqmI7T1j/HAtHqrv6HOTN/B0PBFTW+8Lju63Q=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=R9fAixIcSreswWDDQ98MwM55jyzYMVM35+uOZINPrRWvXlutft43AZFkGLOe5+Tkd
	 8rkl/15pJL0bMCbChhpqsHjVxiCquBKSrt565l2KCEtBX636MI+i1yfbSy0ZX4QTNQ
	 u38MhMQRT36gOL45ji7KDR7BgimtKMPzu9s0XXGOw+rtXgM3NagHOEOmgMBK+ZQ5TM
	 Q8R8GEiGy8V3x7eGVMdddIGN0kQwt6ElmbCIslswp8FXPIyosD5t30O44vW+UtsP7g
	 56UtAVb0Sbqo3X0dsFH+bAod3SnSMvQu4OGApQQL0dL3IyAFuDmNoCPQwO2uV1vLLG
	 ylaBthzk1yr7A==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	seven.yi.lee@gmail.com,
	hch@infradead.org,
	a.manzanares@samsung.com,
	fan.ni@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH RFC 1/1] cxl/pci: Support Global Persistent Flush (GPF)
Date: Fri, 20 Dec 2024 08:43:37 -0800
Message-Id: <20241220164337.204900-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220164337.204900-1-dave@stgolabs.net>
References: <20241220164337.204900-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for GPF flows. It is found that the CXL specification
around this to be a bit too involved from the driver side. And while
this should really all handled by the hardware, this patch takes
things with a grain of salt.

Timeout detection is based on dirty Shutdown semantics. The driver
will mark it as dirty, expecting that the device clear it upon a
successful GPF event. The admin may consult the device Health and
check the dirty shutdown counter to see if there was a problem
with data integrity.

Timeout arming is done throughout the decode hierarchy, upon device
probing and hot-remove. These timeouts can be over-specified,
particularly T1. Set the max timeout to 20 seconds for T1, which is
the NMI watchdog default for lockup detection. For T2, the policy
is to use the largest device T2 available in the hierarchy.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/driver-api/cxl/maturity-map.rst |   2 +-
 drivers/cxl/core/mbox.c                       |  17 +++
 drivers/cxl/core/pci.c                        | 104 ++++++++++++++++++
 drivers/cxl/core/port.c                       |  68 ++++++++++++
 drivers/cxl/cxl.h                             |   3 +
 drivers/cxl/cxlmem.h                          |  24 ++++
 drivers/cxl/cxlpci.h                          |  64 +++++++++++
 drivers/cxl/pci.c                             |  97 ++++++++++++++++
 8 files changed, 378 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index df8e2ac2a320..99dd2c841e69 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -130,7 +130,7 @@ Mailbox commands
 * [0] Switch CCI
 * [3] Timestamp
 * [1] PMEM labels
-* [0] PMEM GPF / Dirty Shutdown
+* [1] PMEM GPF / Dirty Shutdown
 * [0] Scan Media
 
 PMU
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 548564c770c0..c82cf1547027 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1308,6 +1308,23 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
 
+int cxl_set_shutdown_state(struct cxl_memdev_state *mds, bool dirty)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mbox_set_shutdown_state in;
+
+	in.state = dirty;
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_SET_SHUTDOWN_STATE,
+		.size_in = sizeof(in),
+		.payload_in = &in,
+	};
+
+	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_shutdown_state, "CXL");
+
 int cxl_set_timestamp(struct cxl_memdev_state *mds)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d58ab9d33c5..9b1e110817f2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1054,3 +1054,107 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 
 	return 0;
 }
+
+int cxl_pci_update_gpf_port(struct pci_dev *pdev,
+			    struct cxl_memdev *cxlmd, bool remove)
+{
+	u16 ctrl;
+	int port_t1_base, port_t1_scale;
+	int port_t2_base, port_t2_scale;
+	unsigned long device_tmo, port_tmo;
+	int rc, dvsec;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	dvsec = pci_find_dvsec_capability(
+		pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PORT_GPF);
+	if (!dvsec) {
+		dev_warn(&pdev->dev,
+			 "GPF Port DVSEC not present\n");
+		return -EINVAL;
+	}
+
+	/* check for t1 */
+	rc = pci_read_config_word(
+		pdev,
+		dvsec + CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET,
+		&ctrl);
+	if (rc)
+		return rc;
+
+	port_t1_base = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK,
+				 ctrl);
+	port_t1_scale = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK,
+				  ctrl);
+	if (port_t1_scale > GPF_TIMEOUT_SCALE_MAX) {
+		dev_warn(&pdev->dev, "GPF: invalid port phase 1 timeout\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Set max timeout such that vendors will optimize GPF flow to
+	 * avoid the implied worst-case scenario delays.
+	 */
+	device_tmo = gpf_timeout_us(7, GPF_TIMEOUT_SCALE_MAX);
+	port_tmo = gpf_timeout_us(port_t1_base, port_t1_scale);
+
+	dev_dbg(&pdev->dev, "Port GPF phase 1 timeout: %lu us\n", port_tmo);
+
+	if ((remove && device_tmo != port_tmo) || device_tmo > port_tmo) {
+		/* update the timeout in DVSEC */
+		ctrl = FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK,
+				   7);
+		ctrl |= FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK,
+				   GPF_TIMEOUT_SCALE_MAX);
+		rc = pci_write_config_word(
+			pdev,
+			dvsec + CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET,
+			ctrl);
+		if (rc)
+			return rc;
+
+		dev_dbg(&pdev->dev,
+			"new GPF Port phase 1 timeout: %lu us\n", device_tmo);
+	}
+
+	/* check for t2 */
+	rc = pci_read_config_word(
+		pdev,
+		dvsec + CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET,
+		&ctrl);
+	if (rc)
+		return rc;
+
+	port_t2_base = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK,
+			    ctrl);
+	port_t2_scale = FIELD_GET(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK,
+			     ctrl);
+	if (port_t2_scale > GPF_TIMEOUT_SCALE_MAX) {
+		dev_warn(&pdev->dev, "GPF: invalid port phase 2 timeout\n");
+		return -EINVAL;
+	}
+
+	device_tmo = gpf_timeout_us(mds->gpf.t2_base, mds->gpf.t2_scale);
+	port_tmo = gpf_timeout_us(port_t2_base, port_t2_scale);
+
+	dev_dbg(&pdev->dev, "Port GPF phase 2 timeout: %lu us\n", port_tmo);
+
+	if ((remove && device_tmo != port_tmo) || device_tmo > port_tmo) {
+		/* update the timeout in DVSEC */
+		ctrl = FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK,
+				   mds->gpf.t2_base);
+		ctrl |= FIELD_PREP(CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK,
+				   mds->gpf.t2_scale);
+		rc = pci_write_config_word(
+			pdev,
+			dvsec + CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET,
+			ctrl);
+		if (rc)
+			return rc;
+
+		dev_dbg(&pdev->dev,
+			"new GPF Port phase 2 timeout: %lu us\n", device_tmo);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_update_gpf_port, "CXL");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..0bd09669af68 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1370,6 +1370,73 @@ static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
 	return port;
 }
 
+static void delete_update_gpf(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *port = cxlmd->endpoint;
+	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_memdev *max_cxlmd = NULL;
+	struct cxl_memdev_state *mds;
+	struct cxl_ep *ep;
+	unsigned long index;
+
+	/* first calculate the new max T2 timeout */
+	xa_for_each(&parent_port->endpoints, index, ep) {
+		struct cxl_memdev *this_cxlmd;
+		struct cxl_memdev_state *max_mds;
+
+		this_cxlmd = to_cxl_memdev(ep->ep);
+		if (cxlmd == this_cxlmd) /* ignore self */
+			continue;
+		if (!max_cxlmd) {
+			max_cxlmd = this_cxlmd;
+			continue;
+		}
+
+		mds = to_cxl_memdev_state(this_cxlmd->cxlds);
+		max_mds = to_cxl_memdev_state(max_cxlmd->cxlds);
+
+		if (gpf_timeout_us(mds->gpf.t2_base, mds->gpf.t2_scale) >
+		    gpf_timeout_us(max_mds->gpf.t2_base, max_mds->gpf.t2_scale))
+			max_cxlmd = this_cxlmd;
+	}
+
+	if (!max_cxlmd) /* no other devices */
+		goto clean_shutdown;
+
+	while (1) {
+		struct cxl_dport *dport;
+
+		parent_port = to_cxl_port(port->dev.parent);
+		xa_for_each(&parent_port->dports, index, dport) {
+			if (!dev_is_pci(dport->dport_dev))
+				continue;
+
+			cxl_pci_update_gpf_port(to_pci_dev(dport->dport_dev),
+						max_cxlmd, true);
+		}
+
+		if (is_cxl_root(parent_port))
+			break;
+
+		port = parent_port;
+	}
+
+clean_shutdown:
+	/*
+	 * Device can still dirty the shutdown upon detecting any
+	 * failed internal flush.
+	 */
+	if (resource_size(&cxlmd->cxlds->pmem_res)) {
+		mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+		if (mds->dirtied_shutdown) {
+			if (cxl_set_shutdown_state(mds, false))
+				dev_warn(&cxlmd->dev,
+					 "could not clean Shutdown state");
+		}
+	}
+}
+
 /*
  * All users of grandparent() are using it to walk PCIe-like switch port
  * hierarchy. A PCIe switch is comprised of a bridge device representing the
@@ -1400,6 +1467,7 @@ static void delete_endpoint(void *data)
 	struct device *host = endpoint_host(endpoint);
 
 	scoped_guard(device, host) {
+		delete_update_gpf(cxlmd);
 		if (host->driver && !endpoint->dead) {
 			devm_release_action(host, cxl_unlink_parent_dport, endpoint);
 			devm_release_action(host, cxl_unlink_uport, endpoint);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6015f24ad38..a83f8ed8d80b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -911,6 +911,9 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_pci_update_gpf_port(struct pci_dev *pdev,
+			    struct cxl_memdev *mds, bool remove);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..670cf4f91c6a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -450,6 +450,21 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
 	return dev_get_drvdata(cxl_mbox->host);
 }
 
+/**
+ * struct cxl_gpf_device - Device GPF information
+ *
+ * Cached Device Global Persistent Flush data (Phase 2).
+ *
+ * @t2_base: Base component of the timeout.
+ * @t2_scale: Scale component of the timeout.
+ * @power_nwatts: Required power from the device.
+ */
+struct cxl_gpf_dev {
+	u16 t2_base;
+	u16 t2_scale;
+	u32 power_mwatts;
+};
+
 /**
  * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
  *
@@ -477,6 +492,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @poison: poison driver state info
  * @security: security driver state info
  * @fw: firmware upload / activation state
+ * @gpf: cached Device GPF information
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -503,6 +519,9 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
+
+	struct cxl_gpf_dev gpf;
+	bool dirtied_shutdown;
 };
 
 static inline struct cxl_memdev_state *
@@ -693,6 +712,10 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+struct cxl_mbox_set_shutdown_state {
+	u8 state;
+} __packed;
+
 /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
 struct cxl_mbox_set_timestamp_in {
 	__le64 timestamp;
@@ -829,6 +852,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
 			    const uuid_t *uuid, union cxl_event *evt);
+int cxl_set_shutdown_state(struct cxl_memdev_state *mds, bool dirty);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..fe7d92ef538f 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -40,9 +40,20 @@
 
 /* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
 #define CXL_DVSEC_PORT_GPF					4
+#define   CXL_DVSEC_PORT_GPF_PHASE_1_CONTROL_OFFSET		0x0C
+#define     CXL_DVSEC_PORT_GPF_PHASE_1_TMO_BASE_MASK		GENMASK(3, 0)
+#define	    CXL_DVSEC_PORT_GPF_PHASE_1_TMO_SCALE_MASK		GENMASK(11, 8)
+#define   CXL_DVSEC_PORT_GPF_PHASE_2_CONTROL_OFFSET		0xE
+#define     CXL_DVSEC_PORT_GPF_PHASE_2_TMO_BASE_MASK		GENMASK(3, 0)
+#define	    CXL_DVSEC_PORT_GPF_PHASE_2_TMO_SCALE_MASK		GENMASK(11, 8)
 
 /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
 #define CXL_DVSEC_DEVICE_GPF					5
+#define   CXL_DVSEC_DEVICE_GPF_PHASE_2_DURATION_OFFSET		0xA
+#define     CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_BASE_MASK		GENMASK(3, 0)
+#define	    CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_SCALE_MASK	GENMASK(11, 8)
+#define   CXL_DVSEC_DEVICE_GPF_PHASE_2_POWER_OFFSET		0xC
+#define	    CXL_DVSEC_DEVICE_GPF_PHASE_2_ACTIVE_POWER_MASK	GENMASK(31, 0)
 
 /* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
 #define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
@@ -129,4 +140,57 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+
+#define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
+
+static inline unsigned long gpf_timeout_us(int base, int scale)
+{
+	unsigned long tmo, others;
+
+	switch (scale) {
+	case 0: /* 1 us */
+		tmo = 1;
+		break;
+	case 1: /* 10 us */
+		tmo = 10UL;
+		break;
+	case 2: /* 100 us */
+		tmo = 100UL;
+		break;
+	case 3: /* 1 ms */
+		tmo = 1000UL;
+		break;
+	case 4: /* 10 ms */
+		tmo = 10000UL;
+		break;
+	case 5: /* 100 ms */
+		tmo = 100000UL;
+		break;
+	case 6: /* 1 s */
+		tmo = 1000000UL;
+		break;
+	case GPF_TIMEOUT_SCALE_MAX:
+		tmo = 10000000UL;
+		break;
+	default:
+		tmo = 0;
+		break;
+	}
+
+	tmo *= base;
+	/*
+	 * The spec is over involved. Do not account for any ad-hoc
+	 * host delays. Ie: propagation delay, host-side processing
+	 * delays, and any other  host/system-specific delays.
+	 */
+	others = 0;
+	tmo += others;
+
+	/*
+	 * Limit max timeout to 20 seconds (per phase), which is
+	 * already the default for the nmi watchdog.
+	 */
+	return min(20000000UL, tmo);
+}
+
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6d94ff4a4f1a..37d5616b6fc8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -900,6 +900,101 @@ static struct attribute_group cxl_rcd_group = {
 };
 __ATTRIBUTE_GROUPS(cxl_rcd);
 
+
+static int cxl_gpf_setup(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct cxl_port *port;
+	int rc, gpf_dvsec;
+	u16 duration;
+	u32 power;
+	int device_t2_base, device_t2_scale;
+
+	/* get the timeouts for phase 2, given by the hardware */
+	gpf_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					      CXL_DVSEC_DEVICE_GPF);
+	if (!gpf_dvsec) {
+		dev_warn(&pdev->dev,
+			 "GPF Device DVSEC not present\n");
+		return -EINVAL;
+	}
+
+	rc = pci_read_config_word(
+		pdev,
+		gpf_dvsec + CXL_DVSEC_DEVICE_GPF_PHASE_2_DURATION_OFFSET,
+		&duration);
+	if (rc)
+		return rc;
+
+	device_t2_base = FIELD_GET(CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_BASE_MASK,
+			    duration);
+	device_t2_scale = FIELD_GET(CXL_DVSEC_DEVICE_GPF_PHASE_2_TIME_SCALE_MASK,
+			     duration);
+	if (device_t2_scale > GPF_TIMEOUT_SCALE_MAX) {
+		dev_warn(&pdev->dev, "GPF: invalid device timeout\n");
+		return -EINVAL;
+	}
+
+	/* cache device GPF timeout and power consumption for phase 2 */
+	mds->gpf.t2_base = device_t2_base;
+	mds->gpf.t2_scale = device_t2_scale;
+
+	rc = pci_read_config_dword(
+		pdev,
+		gpf_dvsec + CXL_DVSEC_DEVICE_GPF_PHASE_2_POWER_OFFSET,
+		&power);
+	if (rc)
+		return rc;
+
+	mds->gpf.power_mwatts = power;
+
+	dev_dbg(&pdev->dev, "Device GPF timeout: %lu us (power needed: %dmW)\n",
+		gpf_timeout_us(device_t2_base, device_t2_scale),
+		mds->gpf.power_mwatts);
+
+	/* iterate up the hierarchy updating max port timeouts where necessary */
+	port = cxlmd->endpoint;
+	while (1) {
+		struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+		struct cxl_dport *dport;
+		unsigned long index;
+
+		device_lock(&parent_port->dev);
+		xa_for_each(&parent_port->dports, index, dport) {
+			if (!dev_is_pci(dport->dport_dev))
+				continue;
+
+			cxl_pci_update_gpf_port(to_pci_dev(dport->dport_dev),
+						cxlmd, false);
+		}
+		device_unlock(&parent_port->dev);
+
+		if (is_cxl_root(parent_port))
+			break;
+
+		port = parent_port;
+	}
+
+	/*
+	 * Set dirty shutdown now, with the expectation that the device
+	 * clear it upon a successful GPF flow. The exception to this
+	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
+	 *
+	 * XXX: For non-fail scenarios, this is cleared by the driver
+	 * at hot-unplug. But, what about reboot/shutdown case? Is this
+	 * done by hw if no data integrity failure is detected?
+	 */
+	if (resource_size(&cxlds->pmem_res)) {
+		rc = cxl_set_shutdown_state(mds, true);
+		if (!rc)
+			mds->dirtied_shutdown = true;
+	}
+
+	return rc;
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -1038,6 +1133,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (cxl_pci_ras_unmask(pdev))
 		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
 
+	cxl_gpf_setup(pdev);
+
 	pci_save_state(pdev);
 
 	return rc;
-- 
2.39.5

