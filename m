Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3A2741A0
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210211; cv=none; b=Welwj+PR1NOx9WbwaAec03Uw6zP58QaTcfSdLTo2jQLYDr0iKop3hlKnW2UqHUSjxGKz3pRC69U1CJ4laq96WbrzaVWpF567tqE04MGQ0VzdtOJ9/9e7RaLLXlQThznsjvXyRlFOFsnQI1bONxsj+VA4TvVvDPmijsfzQvu0t7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210211; c=relaxed/simple;
	bh=U/h8g8kyOjsFoSK6KGEL5phDI+MGe3ST2bxL167QkhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzx31PX/BiD8i8TlqQTYhaT24z5PIgxWUkz/8GGmUWIRwSG54hkv4chzI50BeKqPjBAO4tjIcyBa8czBCTVGDjMxhrUknmUO1ygQwF+9SILo/yLxKFQiRqHbr0rf1qa7q2SsGNwz6VKzN9dQgD7E1lu5JvmiPKYZlF1aSzMvt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C819CC4CEED;
	Thu, 14 Aug 2025 22:23:29 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com
Subject: [PATCH v8 11/11] tools/testing/cxl: Add decoder save/restore support
Date: Thu, 14 Aug 2025 15:21:51 -0700
Message-ID: <20250814222151.3520500-12-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814222151.3520500-1-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Record decoder values at init and mock_decoder_commit() time, and
restore them at the next invocation of mock_init_hdm_decoder(). Add 2
attributes to the cxl_test "cxl_acpi" device to optionally flush the
cache of topology decoder values, or disable updating the decoder at
mock_decoder_reset() time.

This enables replaying a saved decoder configuration when re-triggering
a topology scan by re-binding the cxl_acpi driver to "cxl_acpi.0" (the
cxl_test emulation of an ACPI0017 instance).

    # modprobe cxl_test
    # cxl list -RB -b cxl_test -u
    {
      "bus":"root3",
      "provider":"cxl_test",
      "regions:root3":[
        {
          "region":"region5",
          "resource":"0xf010000000",
          "size":"512.00 MiB (536.87 MB)",
          "type":"ram",
          "interleave_ways":2,
          "interleave_granularity":4096,
          "decode_state":"commit"
        }
      ]
    }
    # echo 1 > /sys/bus/platform/devices/cxl_acpi.0/decoder_registry_reset_disable
    # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/unbind
    # cxl list -RB -b cxl_test -u
    # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/bind
    # cxl list -RB -b cxl_test -u
    {
      "bus":"root3",
      "provider":"cxl_test",
      "regions:root3":[
        {
          "region":"region5",
          "resource":"0xf010000000",
          "size":"512.00 MiB (536.87 MB)",
          "type":"ram",
          "interleave_ways":2,
          "interleave_granularity":4096,
          "decode_state":"commit"
        }
      ]
    }

[dj: Added support for delayed dport initialization ]

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
- Will have a cxl-replay test script in CXL CLI package
- This allowed me to test assembly and replay for manually created CXL regions
---
 tools/testing/cxl/test/cxl.c | 300 ++++++++++++++++++++++++++++++++++-
 1 file changed, 298 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 2d50193d10fe..e0da2a48d2a8 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -47,6 +47,9 @@ struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
 static struct platform_device *cxl_rch[NR_CXL_RCH];
 static struct platform_device *cxl_rcd[NR_CXL_RCH];
 
+static DEFINE_XARRAY(decoder_registry);
+static bool decoder_registry_reset_disable;
+
 static inline bool is_multi_bridge(struct device *dev)
 {
 	int i;
@@ -671,6 +674,164 @@ static int map_targets(struct device *dev, void *data)
 	return 0;
 }
 
+static unsigned long cxld_registry_index(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	/*
+	 * Upper nibble of a kernel pointer is 0xff, chop that to make
+	 * space for a cxl_decoder id which should be less than 128
+	 * given decoder count is a 4-bit field.
+	 *
+	 * While @port is reallocated each enumeration, @port->uport_dev
+	 * is stable.
+	 */
+	dev_WARN_ONCE(&port->dev, cxld->id >= 128,
+		      "decoder id:%d out of range\n", cxld->id);
+	return (((unsigned long) port->uport_dev) << 4) | cxld->id;
+}
+
+struct cxl_test_decoder {
+	union {
+		struct cxl_switch_decoder cxlsd;
+		struct cxl_endpoint_decoder cxled;
+	};
+	union {
+		struct cxl_dport *targets[CXL_DECODER_MAX_INTERLEAVE];
+		struct range dpa_range;
+	};
+};
+
+static struct cxl_test_decoder *cxld_registry_find(struct cxl_decoder *cxld)
+{
+	return xa_load(&decoder_registry, cxld_registry_index(cxld));
+}
+
+#define dbg_cxld(port, msg, cxld)                                                       \
+	do {                                                                            \
+		struct cxl_decoder *___d = (cxld);                                      \
+		dev_dbg((port)->uport_dev,                                              \
+			"decoder%d: %s range: %#llx-%#llx iw: %d ig: %d flags: %#lx\n", \
+			___d->id, msg, ___d->hpa_range.start,                           \
+			___d->hpa_range.end + 1, ___d->interleave_ways,                 \
+			___d->interleave_granularity, ___d->flags);                     \
+	} while (0)
+
+static int mock_decoder_commit(struct cxl_decoder *cxld);
+static void mock_decoder_reset(struct cxl_decoder *cxld);
+
+static void cxld_copy(struct cxl_decoder *a, struct cxl_decoder *b)
+{
+	a->id = b->id;
+	a->hpa_range = b->hpa_range;
+	a->interleave_ways = b->interleave_ways;
+	a->interleave_granularity = b->interleave_granularity;
+	a->target_type = b->target_type;
+	a->flags = b->flags;
+	a->commit = mock_decoder_commit;
+	a->reset = mock_decoder_reset;
+}
+
+static void cxld_registry_restore(struct cxl_decoder *cxld, struct cxl_test_decoder *td)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
+
+		dbg_cxld(port, "restore", &td->cxlsd.cxld);
+		cxld_copy(cxld, &td->cxlsd.cxld);
+		WARN_ON(cxlsd->nr_targets != td->cxlsd.nr_targets);
+
+		/* convert saved dport devs to dports */
+		for (int i = 0; i < cxlsd->nr_targets; i++) {
+			struct cxl_dport *dport;
+			struct device *dev;
+
+			if (!td->cxlsd.target[i])
+				continue;
+			/* Recall this dport ptr is overloaded with a 'struct device' at save */
+			dev = (struct device *)td->cxlsd.target[i];
+			dport = cxl_find_dport_by_dev(port, dev);
+			if (!dport) {
+				cxld->target_map[i] = td->cxlsd.cxld.target_map[i];
+				continue;
+			}
+			cxlsd->target[i] = dport;
+			cxld->target_map[i] = dport->port_id;
+		}
+	} else {
+		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
+		dbg_cxld(port, "restore", &td->cxled.cxld);
+		cxld_copy(cxld, &td->cxled.cxld);
+		cxled->state = td->cxled.state;
+		cxled->skip = td->cxled.skip;
+		if (range_len(&td->dpa_range))
+			devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
+					     range_len(&td->dpa_range),
+					     td->cxled.skip);
+		if (cxld->flags & CXL_DECODER_F_ENABLE)
+			port->commit_end = cxld->id;
+	}
+}
+
+static void __cxld_registry_save(struct cxl_test_decoder *td,
+				 struct cxl_decoder *cxld)
+{
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(&cxld->dev);
+
+		cxld_copy(&td->cxlsd.cxld, cxld);
+		td->cxlsd.nr_targets = cxlsd->nr_targets;
+
+		/* save dport devs as a stable placeholder for dports */
+		for (int i = 0; i < cxlsd->nr_targets; i++) {
+			struct cxl_dport *dport;
+
+			if (!cxlsd->target[i])
+				continue;
+
+			dport = cxlsd->target[i];
+			/* Overloading target[] with a 'struct device' */
+			td->cxlsd.target[i] = (struct cxl_dport *)dport->dport_dev;
+			td->cxlsd.cxld.target_map[i] = dport->port_id;
+		}
+	} else {
+		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
+		cxld_copy(&td->cxled.cxld, cxld);
+		td->cxled.state = cxled->state;
+		td->cxled.skip = cxled->skip;
+		if (cxled->dpa_res) {
+			td->dpa_range.start = cxled->dpa_res->start;
+			td->dpa_range.end = cxled->dpa_res->end;
+		} else {
+			td->dpa_range.start = 0;
+			td->dpa_range.end = -1;
+		}
+	}
+}
+
+static void cxld_registry_save(struct cxl_test_decoder *td, struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	dbg_cxld(port, "save", cxld);
+	__cxld_registry_save(td, cxld);
+}
+
+static void cxld_registry_update(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_test_decoder *td = cxld_registry_find(cxld);
+
+	dev_WARN_ONCE(port->uport_dev, !td, "%s failed\n", __func__);
+
+	dbg_cxld(port, "update", cxld);
+	__cxld_registry_save(td, cxld);
+}
+
 static int mock_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
@@ -690,6 +851,13 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 
 	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		cxled->state = CXL_DECODER_STATE_AUTO;
+	}
+	cxld_registry_update(cxld);
 
 	return 0;
 }
@@ -700,7 +868,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 	int id = cxld->id;
 
 	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
-		return;
+		goto registry_update_out;
 
 	dev_dbg(&port->dev, "%s reset\n", dev_name(&cxld->dev));
 	if (port->commit_end == id)
@@ -709,7 +877,51 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 		dev_dbg(&port->dev,
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
+
+registry_update_out:
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		cxled->state = CXL_DECODER_STATE_MANUAL;
+	}
+	if (decoder_registry_reset_disable)
+		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
+			cxld->id);
+	else
+		cxld_registry_update(cxld);
+
+	return;
+}
+
+static void cxld_registry_invalidate(void)
+{
+	unsigned long index;
+	void *entry;
+
+	xa_for_each(&decoder_registry, index, entry) {
+		xa_erase(&decoder_registry, index);
+		kfree(entry);
+	}
+}
+
+static struct cxl_test_decoder *cxld_registry_new(struct cxl_decoder *cxld)
+{
+	struct cxl_test_decoder *td __free(kfree) = kzalloc(sizeof(*td), GFP_KERNEL);
+
+	if (!td)
+		return NULL;
+
+	if (xa_insert(&decoder_registry, cxld_registry_index(cxld), td,
+		      GFP_KERNEL)) {
+		WARN_ON(1);
+		return NULL;
+	}
+
+	cxld_registry_save(td, cxld);
+	return no_free_ptr(td);
 }
 
 static void default_mock_decoder(struct cxl_decoder *cxld)
@@ -724,6 +936,9 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
+
+	if (!cxld_registry_new(cxld))
+		dev_dbg(&cxld->dev, "failed to add to registry\n");
 }
 
 static int first_decoder(struct device *dev, const void *data)
@@ -745,6 +960,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *port, *iter;
+	struct cxl_test_decoder *td;
 	const int size = SZ_512M;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dport *dport;
@@ -774,6 +990,12 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		port = cxled_to_port(cxled);
 	}
 
+	td = cxld_registry_find(cxld);
+	if (td) {
+		cxld_registry_restore(cxld, td);
+		return;
+	}
+
 	/*
 	 * The first decoder on the first 2 devices on the first switch
 	 * attached to host-bridge0 mock a fake / static RAM region. All
@@ -802,6 +1024,8 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	devm_cxl_dpa_reserve(cxled, 0, size / cxld->interleave_ways, 0);
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
+	if (!cxld_registry_new(cxld))
+		dev_dbg(&cxld->dev, "failed to add to registry\n");
 
 	/*
 	 * Now that endpoint decoder is set up, walk up the hierarchy
@@ -850,6 +1074,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 			.start = base,
 			.end = base + size - 1,
 		};
+		cxld_registry_update(cxld);
 		put_device(dev);
 	}
 }
@@ -902,7 +1127,7 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
 		mock_init_hdm_decoder(cxld);
 
-		if (target_count) {
+		if (target_count && !decoder_registry_reset_disable) {
 			rc = device_for_each_child(port->uport_dev, &ctx,
 						   map_targets);
 			if (rc) {
@@ -1407,6 +1632,73 @@ static int cxl_mem_init(void)
 	return rc;
 }
 
+static ssize_t decoder_registry_invalidate_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	unsigned long index;
+	bool empty = true;
+	void *entry;
+
+	xa_for_each(&decoder_registry, index, entry) {
+		empty = false;
+		break;
+	}
+
+	return sysfs_emit(buf, "%d\n", !empty);
+}
+
+static ssize_t decoder_registry_invalidate_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t count)
+{
+	bool invalidate;
+	int rc;
+
+	rc = kstrtobool(buf, &invalidate);
+	if (rc)
+		return rc;
+
+	guard(device)(dev);
+
+	if (dev->driver)
+		return -EBUSY;
+
+	cxld_registry_invalidate();
+	return count;
+}
+
+static DEVICE_ATTR_RW(decoder_registry_invalidate);
+
+static ssize_t
+decoder_registry_reset_disable_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", decoder_registry_reset_disable);
+}
+
+static ssize_t
+decoder_registry_reset_disable_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	int rc;
+
+	rc = kstrtobool(buf, &decoder_registry_reset_disable);
+	if (rc)
+		return rc;
+	return count;
+}
+
+static DEVICE_ATTR_RW(decoder_registry_reset_disable);
+
+static struct attribute *cxl_acpi_attrs[] = {
+	&dev_attr_decoder_registry_invalidate.attr,
+	&dev_attr_decoder_registry_reset_disable.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(cxl_acpi);
+
 static __init int cxl_test_init(void)
 {
 	int rc, i;
@@ -1537,6 +1829,7 @@ static __init int cxl_test_init(void)
 
 	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
 	acpi0017_mock.dev.bus = &platform_bus_type;
+	cxl_acpi->dev.groups = cxl_acpi_groups;
 
 	rc = platform_device_add(cxl_acpi);
 	if (rc)
@@ -1606,6 +1899,9 @@ static __exit void cxl_test_exit(void)
 	depopulate_all_mock_resources();
 	gen_pool_destroy(cxl_mock_pool);
 	unregister_cxl_mock_ops(&cxl_mock_ops);
+
+	cxld_registry_invalidate();
+	xa_destroy(&decoder_registry);
 }
 
 module_param(interleave_arithmetic, int, 0444);
-- 
2.50.1

