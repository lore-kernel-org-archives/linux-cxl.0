Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE4CC433F5
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6647B6124F
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243696AbhJPFRz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:31045 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243695AbhJPFRx (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="214961677"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="214961677"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:46 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743346"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:45 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 25/27] cxl/region: Gather HDM decoder resources
Date:   Fri, 15 Oct 2021 22:15:29 -0700
Message-Id: <20211016051531.622613-26-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Prepare for HDM decoder programming by iterating through all components
and obtaining a cxl_decoder for each.

Programming a CXL region to accept memory transactions over a set of
devices requires programming HDM decoders for every component that is
part of the hierarchy enabling the region (host bridges, switches, and
endpoints). For this to be possible, each of these components must have
an available HDM decoder, which is a limited hardware resource.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c |  8 ++++++
 drivers/cxl/cxl.h      |  3 ++
 drivers/cxl/port.c     | 53 +++++++++++++++++++++++++++++++++++
 drivers/cxl/region.c   | 63 +++++++++++++++++++++++++++++++++++++++---
 drivers/cxl/region.h   |  4 +++
 5 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index edde7df70fdf..6b0cd1cbd9f7 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -301,6 +301,14 @@ static bool is_endpoint_decoder(struct device *dev)
 	return dev->type == &cxl_decoder_endpoint_type;
 }
 
+bool is_cxl_decoder(struct device *dev)
+{
+	return dev->type == &cxl_decoder_switch_type ||
+	       dev->type == &cxl_decoder_endpoint_type ||
+	       dev->type == &cxl_decoder_root_type;
+}
+EXPORT_SYMBOL_GPL(is_cxl_decoder);
+
 bool is_root_decoder(struct device *dev)
 {
 	return dev->type == &cxl_decoder_root_type;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a2062e370c85..24e4a14b531c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -331,11 +331,14 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 struct cxl_dport *cxl_get_root_dport(struct device *dev);
 struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 					struct device *dev);
+struct cxl_decoder *cxl_pop_decoder(struct cxl_port *port);
+void cxl_push_decoder(struct cxl_decoder *cxld);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 				      unsigned int nr_targets);
+bool is_cxl_decoder(struct device *dev);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 4d65560eb739..87b36565fa6a 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -35,6 +35,59 @@
  * presenting APIs to other drivers to utilize the decoders.
  */
 
+static int unused_decoder(struct device *dev, void *data)
+{
+	struct cxl_decoder *cxld;
+
+	if (!is_cxl_decoder(dev))
+		return 0;
+
+	if (dev_WARN_ONCE(dev, is_root_decoder(dev),
+			  "Root decoders can't be present"))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+	if (cxld->flags & CXL_DECODER_F_EN)
+		return 0;
+
+	/*
+	 * Mark this decoder as enabled to prevent other entities from thinking
+	 * it's available.
+	 */
+	cxld->flags |= CXL_DECODER_F_EN;
+
+	return 1;
+}
+
+/**
+ * cxl_pop_decoder() - Obtains an available decoder resource
+ * @port: Owner of the decoder resource
+ */
+struct cxl_decoder *cxl_pop_decoder(struct cxl_port *port)
+{
+	struct device *cxldd;
+
+	cxldd = device_find_child(&port->dev, NULL, unused_decoder);
+	if (!cxldd)
+		return ERR_PTR(-EBUSY);
+
+	/* Keep the reference */
+
+	return to_cxl_decoder(cxldd);
+}
+EXPORT_SYMBOL_GPL(cxl_pop_decoder);
+
+/**
+ * cxl_push_decoder() - Restores decoder resource to the port
+ * @cxld: the decoder resource to replace
+ */
+void cxl_push_decoder(struct cxl_decoder *cxld)
+{
+	cxld->flags &= ~CXL_DECODER_F_EN;
+	put_device(&cxld->dev);
+}
+EXPORT_SYMBOL_GPL(cxl_push_decoder);
+
 struct cxl_port_data {
 	struct cxl_component_regs regs;
 
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index d5a326c7e369..8849633afb23 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -450,9 +450,32 @@ static struct cxl_decoder *find_cfmws(const struct cxl_region *region,
 	return NULL;
 }
 
+static void put_all_decoders(struct decoder_programming *p)
+{
+	int i;
+
+	for (i = 0; i < CXL_DECODER_MAX_INTERLEAVE; i++) {
+		if (p->hbs[i].cxld) {
+			cxl_push_decoder(p->hbs[i].cxld);
+			p->hbs[i].cxld = NULL;
+		}
+
+		if (p->ep_cxld[i]) {
+			cxl_push_decoder(p->ep_cxld[i]);
+			p->ep_cxld[i] = NULL;
+		}
+	}
+}
+
+static void release_decoders(void *p)
+{
+	put_all_decoders(p);
+}
+
 /**
  * gather_hdm_decoders() - Amass all HDM decoders in the hierarchy
  * @region: The region to be programmed
+ * @p: Programming state that will gather decoders
  *
  * Programming the hardware such that the correct set of devices receive the
  * correct memory traffic requires all connected components in the hierarchy to
@@ -461,10 +484,42 @@ static struct cxl_decoder *find_cfmws(const struct cxl_region *region,
  * Returns 0 if an HDM decoder was obtained for each component, else returns a
  * negative error code.
  */
-static int gather_hdm_decoders(const struct cxl_region *region)
+static int gather_hdm_decoders(const struct cxl_region *region, struct decoder_programming *p)
 {
-	/* TODO: */
-	return 0;
+	struct cxl_memdev *ep;
+	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	int i, hb_count = get_unique_hostbridges(region, hbs);
+
+	for_each_cxl_endpoint(ep, region, i) {
+		struct cxl_port *port = ep->uport;
+
+		p->ep_cxld[i] = cxl_pop_decoder(port);
+		if (IS_ERR(p->ep_cxld[i])) {
+			int err = PTR_ERR(p->ep_cxld[i]);
+
+			p->ep_cxld[i] = NULL;
+			put_all_decoders(p);
+			return err;
+		}
+	}
+
+	/* TODO: Switches */
+
+	for (i = 0; i < hb_count; i++) {
+		struct cxl_port *hb = hbs[i];
+
+		p->hbs[i].cxld = cxl_pop_decoder(hb);
+		if (IS_ERR(p->hbs[i].cxld)) {
+			int err = PTR_ERR(p->hbs[i].cxld);
+
+			p->hbs[i].cxld = NULL;
+			put_all_decoders(p);
+			return err;
+		}
+	}
+
+	return devm_add_action_or_reset((struct device *)&region->dev,
+					release_decoders, p);
 }
 
 static int bind_region(const struct cxl_region *region)
@@ -513,7 +568,7 @@ static int cxl_region_probe(struct device *dev)
 	if (ours)
 		put_device(&ours->dev);
 
-	ret = gather_hdm_decoders(region);
+	ret = gather_hdm_decoders(region, &region->state);
 	if (ret)
 		return ret;
 
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
index 51f442636364..4c0b94c3c001 100644
--- a/drivers/cxl/region.h
+++ b/drivers/cxl/region.h
@@ -23,6 +23,8 @@
  * @state.hbs: Host bridge state. One per hostbridge in the interleave set.
  * @state.hbs.rp_count: Count of root ports for this region
  * @state.hbs.rp_target_list: Ordered list of downstream root ports.
+ * @state.hbs.cxld: an available decoder to set up the programming.
+ * @state.ep_cxld: available decoders for endpoint programming.
  */
 struct cxl_region {
 	struct device dev;
@@ -44,7 +46,9 @@ struct cxl_region {
 		struct {
 			int rp_count;
 			struct cxl_dport *rp_target_list[CXL_DECODER_MAX_INTERLEAVE];
+			struct cxl_decoder *cxld;
 		} hbs[CXL_DECODER_MAX_INTERLEAVE];
+		struct cxl_decoder *ep_cxld[CXL_DECODER_MAX_INTERLEAVE];
 	} state;
 };
 
-- 
2.33.1

