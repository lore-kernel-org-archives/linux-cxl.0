Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795045165;
	b=Pxq6obJIE6T7x1kCEoJp8/rif/L6GUeDCZwDsXkQ8TJ98ns3diK/MKHdKHg8Ydj+V3T9
	 7i8eMLY7EcPUIkAUZsnAuaftpmdhN3n2z18KK3O7PcX5VUvtx9K6h5f9H8EB4PXOIWR1h
	 ppKAldh2sQ36yo5UdpoCP8ByTij66KuQFobr9cfoolOCpwYjbsPPzFB/9sYCqNbNVWNnF
	 aKQ9W4NkIOy7acQ7LeTNA7joBSJ9Xh8/DgjDxaVhU/IpbuJrZ0PZkI5uxi7sCwnvevIfR
	 3sOGSKYHEXqnUsDo0olQGSi2ky4NSgv9EiFACKVJiIw6c4REaybPV4tROMZ/n7DeKbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=kMkEIc4XVSqEaAt9eQ5kZsf/cw8Dz9Khql9iUHQGII4=;
	b=gFZl26iYpjqFG0NwUg4AR0tkm24tS0feqP6NR4/h+cApXZJaP0zDabDMfAl3vnThiwz7
	 H0Remq4ylF7w8cFxju/+vjI1xYbAuwWHgpjBTtC4lb+FsbGMMGTJhK2h9miIDbOQ8gYxQ
	 a9iWvsjuVggSLYuxsztCjZd5oxu/MZTQKtsSeEB/C0RVAfUdLHH05cJA7VbzVnsD7Zqhq
	 6NUKeBEORwt1gdUM9bVrbB2k3y0STAdvDXLPMRAatla7K8bd0RflzsVvEatmxs7L3b+i5
	 bthY0yMl51gGUF1W5O2dq3aR5jWpHKEMDrvbqtiBFk5X3t8nz0mmOnXH9y6rUUU1Zog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TcptwZzz;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E4606A332
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 23:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 607E4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TcptwZzz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795045164; x=1826581164;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=mmlpjd67OKUe3jFEQr4Y07dtohbXFZCieR7Eg63Si1o=;
  b=TcptwZzzc7Z+pWjUEvL0qqtKi6sCLgQkbJKbS/7dXHgxkg7iP2AisHTs
   0xCEMVImB6rt+JvcNPYARGI8+McL7Lq4DqpwkRUAbHoaODYV0GyRq8VvT
   KM5O0GjXgjeD4JFhrWDxl45lxOyn3AL3T+Tbk7hOhQxBvQ//9CEKYsIlw
   HpNZH9qqeqEzzyiEvYHE6dDcw56ECXWovVRRtZFlAyO8LLIpczDSuIbdl
   ufYoREZsWS52kwJ040yMlhi3XH7K7otx23fLou9Qwu0Y7cJc1v2+TStkG
   7bewkMQQTef3mHIxE1GX4MfoQ3xWSdpq6hG52LTg7s1LwWNc4f+KVAm+E
   A==;
X-CSE-ConnectionGUID: NlmHVLPlT3GtbnRFpusJxw==
X-CSE-MsgGUID: WRzmaR5iQnGXxpFU7bByuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3800727"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3800727"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 15:39:23 -0800
X-CSE-ConnectionGUID: jNivU4AYSd2u+YEg9WwoYA==
X-CSE-MsgGUID: S71vKWZ/RYiUpSYo/OF/vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10635040"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 15:39:22 -0800
Message-ID: <58fdf73a-a33a-44fa-bd35-a9610624d3b3@intel.com>
Date: Wed, 18 Nov 2026 16:39:20 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Type2 unwinding ordering change
To: alucerop@amd.com, linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20261118191431.21781-1-alucerop@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261118191431.21781-1-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/26 12:14 PM, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> This RFC requires more work mainly with the tracepoints and surely with
> documentation which, I hope, will get better with help from reviewers.
> 
> Regarding the solution proposed for the described problem, I know there could
> be other solutions, so I'll be happy if someone comes with a better one, but
> my feeling is the current design based strongly on devm actions is adding
> complexity which would be desirable to reduce somehow.
> 
> 
> The summary
> ===========
> Current Type2 support is safe but semantically wrong: a Type2 driver could not
> be (temporarily) aware about the CXL region (the one creating the Host physical
> range to work with) is not there anymore. It could because it depends on the
> unwinding triggering point which changes the ordering of CXL objects unwinding.
> It is safe because for current Type2 expectations the physical mapping will
> remain: those HDM decoders building up the path and programmed by the BIOS will
> not be reset.

Hi Alejandro,
I ran the series under cxl_test with type2_test=1 and KASAN. A plain unbind of
the accel driver oopses. delete_endpoint() unregisters the endpoint decoder,
then the devm action from add_hdm_decoder() unregisters it again. Binding the
accel with no CXL topology also oopses, on an ERR_PTR endpoint.

There's also a Type3 regression. detach_scheduled is never cleared, so after
one cxl_mem unbind/bind a Type3 memdev no longer detaches when its endpoint
is unbound.

With the crash fixed locally, the endpoint is never released after a Type2
teardown. detach_memdev() puts cxlmd->endpoint after delete_endpoint() has
set it to NULL.

The ordering isn't fixed either. schedule_detach() is async. On endpoint or
cxl_acpi unbind the decoders are torn down while the detach work runs the
driver teardown in parallel. A trace shows the two interleaved. The detach
can't run synchronously from the endpoint unbind. The PCI unbind takes the
PCI device lock and then needs the endpoint lock to remove the endpoint.

I don't think the driver needs to be unbound first. It needs to stop using
the HPA before the region goes away. Every region removal goes through
unregister_region(), so how about telling the driver there?

The diff below shows the intent. devm_cxl_probe_mem() takes an optional
revoke() callback. unregister_region() calls it after the region device is
deleted, while the decoders and HPA are still intact. A bus notifier disarms
it before the driver's own remove(). The async detach stays as it is.

Under cxl_test, mem0, endpoint, port and cxl_acpi unbind all call revoke()
before the first decoder teardown. If the driver unbind starts while
revoke() is still running, remove() waits for it to return.

I also tried your multi-PF v2 on top of this with mock functions under
cxl_test. It doesn't look like it needs a deterministic order either.
Deleting the region unbinds the other functions synchronously in
device_del(), before revoke() and before the decoders are torn down, for
every trigger above. cxl_get_range_and_link() needed changes for that. As
posted it can deadlock against PF0's unbind. The fixes are on the branch
after your v2 patches.

The branch [1] has the full set and the cxl_test changes I used. Please
take a look and see what you think.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=type2-revoke

DJ

---
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 787988e92965..50c2fcee54b6 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -752,6 +752,13 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct device *dev = &cxlmd->dev;

+	/*
+	 * The attach owner is unbinding and has already stopped using the
+	 * region. Don't call back into it while the region unwinds below.
+	 */
+	if (cxlmd->attach && cxlmd->attach->disarm)
+		cxlmd->attach->disarm(cxlmd);
+
 	cdev_device_del(&cxlmd->cdev, dev);
 	cxl_memdev_shutdown(dev);
 	put_device(dev);
@@ -834,6 +841,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 		dev->type = &cxl_class_memdev_type;
 	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
+	mutex_init(&cxlmd->attach_lock);

 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, fops);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 038233dfb142..e8a8843c2ddb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2559,6 +2559,41 @@ static struct cxl_region *to_cxl_region(struct device *dev)
 	return container_of(dev, struct cxl_region, dev);
 }

+/*
+ * Tell attach owners (Type2 drivers) the region is going away while its
+ * decoders and HPA are still intact. Every region removal goes through
+ * unregister_region(), so this is the one place the owner needs to hear
+ * about it.
+ */
+static void cxl_region_notify_attach(struct cxl_region *cxlr)
+{
+	struct cxl_memdev *cxlmds[CXL_DECODER_MAX_INTERLEAVE];
+	struct cxl_region_params *p = &cxlr->params;
+	int n = 0;
+
+	lockdep_assert_held(&to_cxl_root_decoder(cxlr->dev.parent)->regions_lock);
+
+	scoped_guard(rwsem_read, &cxl_rwsem.region) {
+		for (int i = 0; i < p->interleave_ways; i++) {
+			struct cxl_endpoint_decoder *cxled = p->targets[i];
+			struct cxl_memdev *cxlmd;
+
+			if (!cxled)
+				continue;
+			cxlmd = cxled_to_memdev(cxled);
+			if (!cxlmd->attach || !cxlmd->attach->region_lost)
+				continue;
+			get_device(&cxlmd->dev);
+			cxlmds[n++] = cxlmd;
+		}
+	}
+
+	for (int i = 0; i < n; i++) {
+		cxlmds[i]->attach->region_lost(cxlmds[i], cxlr);
+		put_device(&cxlmds[i]->dev);
+	}
+}
+
 static void unregister_region(struct cxl_region *cxlr)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
@@ -2568,6 +2603,13 @@ static void unregister_region(struct cxl_region *cxlr)
 	xa_erase(&cxlrd->regions, cxlr->id);
 	device_del(&cxlr->dev);

+	/*
+	 * device_del() unbound any device-link consumers of the region (e.g.
+	 * other functions of a multi-function device), so notify the owner
+	 * last. Its decoders and HPA are still intact.
+	 */
+	cxl_region_notify_attach(cxlr);
+
 	/*
 	 * Now that region sysfs is shutdown, the parameter block is now
 	 * read-only, so no need to hold the region rwsem to access the
@@ -4182,14 +4224,42 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 	if (rc)
 		return rc;

-	attach->hpa_range = (struct range) {
-		.start = cxlr->params.res->start,
-		.end = cxlr->params.res->end,
-	};
+	scoped_guard(mutex, &cxlmd->attach_lock) {
+		attach->hpa_range = (struct range) {
+			.start = cxlr->params.res->start,
+			.end = cxlr->params.res->end,
+		};
+		cxlmd->attach_region = cxlr;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");

+void cxl_memdev_attach_region_lost(struct cxl_memdev *cxlmd,
+				   struct cxl_region *cxlr)
+{
+	struct cxl_attach_region *attach =
+		container_of(cxlmd->attach, typeof(*attach), attach);
+
+	guard(mutex)(&cxlmd->attach_lock);
+	if (cxlmd->attach_region != cxlr)
+		return;
+	cxlmd->attach_region = NULL;
+
+	dev_dbg(&cxlmd->dev, "%s going away, revoking %pra\n",
+		dev_name(&cxlr->dev), &attach->hpa_range);
+	if (attach->revoke)
+		attach->revoke(cxlmd->cxlds);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region_lost, "cxl_mem");
+
+void cxl_memdev_attach_disarm(struct cxl_memdev *cxlmd)
+{
+	guard(mutex)(&cxlmd->attach_lock);
+	cxlmd->attach_region = NULL;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_disarm, "cxl_mem");
+
 /*
  * The presence of an attach method indicates that the region is designated for
  * a purpose outside of CXL core memory expansion defaults.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 35268d1c387c..675d7e21f6c1 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -44,6 +44,10 @@
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
  * @endpoint: connection to the CXL port topology for this memory device
  * @attach: creator of this memdev depends on CXL link attach to operate
+ * @attach_lock: protects @attach_region and serializes revoking it
+ * @attach_region: region the @attach owner uses, NULL once that region goes
+ *		   away or the owner unbinds. Lives with the memdev, not the
+ *		   owner's devm state, so a memdev reference is enough to read it.
  * @id: id number of this memdev instance.
  * @depth: endpoint port depth
  * @scrub_cycle: current scrub cycle set for this device
@@ -61,6 +65,8 @@ struct cxl_memdev {
 	struct cxl_nvdimm *cxl_nvd;
 	struct cxl_port *endpoint;
 	const struct cxl_memdev_attach *attach;
+	struct mutex attach_lock; /* protects @attach_region */
+	struct cxl_region *attach_region;
 	int id;
 	int depth;
 	u8 scrub_cycle;
@@ -97,14 +103,30 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport_dev);
 }

+/**
+ * struct cxl_memdev_attach - memdev attach provider operations
+ * @probe: attach the memdev, runs in cxl_mem_probe() context
+ * @region_lost: @cxlr is being unregistered and @cxlmd is one of its
+ *		 targets. Called with the root decoder regions_lock held, after
+ *		 the region device is deleted and before its decoders are torn
+ *		 down.
+ * @disarm: the attach owner is unbinding; no further @region_lost
+ *	    notifications are wanted. Waits for an in-flight one to finish.
+ */
 struct cxl_memdev_attach {
 	int (*probe)(struct cxl_memdev *cxlmd);
+	void (*region_lost)(struct cxl_memdev *cxlmd, struct cxl_region *cxlr);
+	void (*disarm)(struct cxl_memdev *cxlmd);
 };

 /**
  * struct cxl_attach_region - coordinate mapping a region at memdev registration
  * @attach: common core attachment descriptor
  * @hpa_range: physical address range of the region
+ * @revoke: driver callback, stop all access to @hpa_range
+ * @unbind_nb: bus notifier, disarms before the driver's remove()
+ * @host: device whose unbind disarms @revoke (the cxlds->dev)
+ * @cxlmd: the memdev, set once devm_cxl_probe_mem() succeeds
  *
  * For the common simple case of a CXL device with private (non-general purpose
  * / "accelerator") memory, enumerate firmware instantiated region, or
@@ -113,15 +135,25 @@ struct cxl_memdev_attach {
 struct cxl_attach_region {
 	struct cxl_memdev_attach attach;
 	struct range hpa_range;
+	void (*revoke)(struct cxl_dev_state *cxlds);
+	struct notifier_block unbind_nb;
+	struct device *host;
+	struct cxl_memdev *cxlmd;
 };

 #ifdef CONFIG_CXL_REGION
 int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
+void cxl_memdev_attach_region_lost(struct cxl_memdev *cxlmd,
+				   struct cxl_region *cxlr);
+void cxl_memdev_attach_disarm(struct cxl_memdev *cxlmd);
 #else
 static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 {
 	return -EOPNOTSUPP;
 }
+
+#define cxl_memdev_attach_region_lost NULL
+#define cxl_memdev_attach_disarm NULL
 #endif

 struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 702ae9ebdcde..cd3db7646c64 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -219,10 +219,39 @@ struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");

+static int cxl_attach_unbind_notify(struct notifier_block *nb,
+				    unsigned long action, void *data)
+{
+	struct cxl_attach_region *attach =
+		container_of(nb, struct cxl_attach_region, unbind_nb);
+
+	if (data != attach->host)
+		return NOTIFY_DONE;
+	if (action != BUS_NOTIFY_UNBIND_DRIVER &&
+	    action != BUS_NOTIFY_DRIVER_NOT_BOUND)
+		return NOTIFY_DONE;
+
+	/*
+	 * Sent before remove(), or before devres unwind on probe failure:
+	 * wait out an in-flight revoke, block new ones.
+	 */
+	if (attach->cxlmd)
+		cxl_memdev_attach_disarm(attach->cxlmd);
+	return NOTIFY_OK;
+}
+
+static void cxl_attach_unregister_notifier(void *data)
+{
+	struct cxl_attach_region *attach = data;
+
+	bus_unregister_notifier(attach->host->bus, &attach->unbind_nb);
+}
+
 /**
  * devm_cxl_probe_mem - Add a CXL memory device and probe its region
  * @cxlds: CXL device state to associate with the memdev
  * @hpa_range: CXL.mem physical address range result
+ * @revoke: optional callback to stop HPA access before the region goes away
  *
  * Upon return the device will have had a chance to attach to the
  * cxl_mem driver, but may fail to attach if the CXL topology is not ready
@@ -233,12 +262,29 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");
  *
  * The parent of the resulting device and the devm context for allocations is
  * @cxlds->dev.
+ *
+ * @revoke, if set, is called once if the region backing @hpa_range is about
+ * to be torn down for a reason other than @cxlds->dev unbinding (CXL port,
+ * memdev or region unbind / delete, cxl_acpi removal). The region, its
+ * decoders and the HPA are still intact when it runs. On return the driver
+ * must no longer access @hpa_range. The driver is unbound later,
+ * asynchronously, as before.
+ *
+ * @revoke may run before this function returns, so it needs to synchronize
+ * with the rest of the driver's probe. It never runs concurrently with or
+ * after the driver's remove() or its probe failure unwind. The driver core
+ * notification for either waits for an in-flight @revoke and blocks new
+ * ones first. @revoke is called with CXL core locks held, so it must not call
+ * back into the CXL core nor take the device lock of @cxlds->dev. It may
+ * sleep.
  */
 struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
-				      struct range *hpa_range)
+				      struct range *hpa_range,
+				      void (*revoke)(struct cxl_dev_state *cxlds))
 {
 	struct cxl_attach_region *attach = devm_kmalloc_obj(cxlds->dev, *attach);
 	struct cxl_memdev *cxlmd;
+	int rc;

 	if (!attach)
 		return ERR_PTR(-ENOMEM);
@@ -246,12 +292,35 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 	*attach = (struct cxl_attach_region) {
 		.attach = {
 			   .probe = cxl_memdev_attach_region,
+			   .region_lost = cxl_memdev_attach_region_lost,
+			   .disarm = cxl_memdev_attach_disarm,
 		},
 		.hpa_range = { 0, -1 },
+		.revoke = revoke,
+		.unbind_nb.notifier_call = cxl_attach_unbind_notify,
+		.host = cxlds->dev,
 	};
+	if (revoke) {
+		rc = bus_register_notifier(cxlds->dev->bus, &attach->unbind_nb);
+		if (rc)
+			return ERR_PTR(rc);
+		rc = devm_add_action_or_reset(cxlds->dev,
+					      cxl_attach_unregister_notifier,
+					      attach);
+		if (rc)
+			return ERR_PTR(rc);
+	}

 	cxlmd = __devm_cxl_add_memdev(cxlds, &attach->attach);
+	if (IS_ERR(cxlmd))
+		return cxlmd;
+
+	/* Don't hand out a range whose region already went away */
+	guard(mutex)(&cxlmd->attach_lock);
+	if (!cxlmd->attach_region)
+		return ERR_PTR(-ENXIO);
 	*hpa_range = attach->hpa_range;
+	attach->cxlmd = cxlmd;
 	return cxlmd;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_probe_mem, "CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 348d7404cd7a..a82a0e2fc609 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -74,7 +74,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}

-	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
+	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range, NULL);
 	if (IS_ERR(cxl->cxlmd)) {
 		pci_err(pci_dev, "CXL accel memdev creation failed\n");
 		return PTR_ERR(cxl->cxlmd);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 1c04a7823f64..c672ec83d820 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -252,7 +252,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 	})

 struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
-				      struct range *range);
+				      struct range *range,
+				      void (*revoke)(struct cxl_dev_state *cxlds));

 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 #endif /* __CXL_CXL_H__ */
