Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610652;
	b=r8rfa66PeEaELeEJm9j5Kg+lvwD+8/0Ghx5FkNo9tzUbEnzwL0tkoCLdXFsDtl78vCHD
	 GiJLEq2VHu5H+G3Uo+np6yHx445MlFHqTOpZiI8Sx+Zzm1llU24i8b1El4K203JOqE6+A
	 UdRci46b19h0QjROmgirovS2JSZlTwo5QU/Q4X5WFfhTjPxjsBlm46OJkJjGtee7/Bzjb
	 jHv6de3T11m88C4Qe9ob+0W3p33GCH1eiINZzvmd+/XCfXdB3WjOaViaQmHbPww6l5fFc
	 mH35m0Ch8HoTJic6INP1s9LjRP8sNTTtQ8YpdqxIZof7VhVfEL9NQ373eqrDdaTgrTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5e50Z3PErs95PfAYhGq7yMRJdGKt4KZmrCHuxtK1wds=;
	b=EUoYisMBXw5XU29lrmfLpzDXZ2sDvCaz5/ZiSqNLEeP+bo3QHVzRW/+71S3AVGB3Oxh9
	 ZdLRgRPikRnSVXeVEFAs8Wql1B4FThCMmwBedEAw0LKWKzLROA5NvvzwrSY0tM6pp3eqm
	 f7oXASBWe9R1gOoWaiqD7ikeIQac+yc4+ZIEZqckh5LjPyOyN/rRTP3hYJbdgJdGMB4rF
	 35b1wAZCq3/aXRNzpkevOB69F3cMpZj88mr79ulWeWwIdx7vXno+YBNLeOGAY94Ci1hcx
	 YXEG0+rWLwQJAP1WQ1lVy4XvPETQX0qnaoDDaipCouuWYfG64JQDCv1Dkz9jIcdUFpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGy9Byw8;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84120606A32A
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84120606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TGy9Byw8
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b589050416so361484c88.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795610651; x=1796215451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5e50Z3PErs95PfAYhGq7yMRJdGKt4KZmrCHuxtK1wds=;
        b=TGy9Byw8QzpWE8wR2ZRg+X8J+RKmq2M8itZ6D6dwJDfwxe6ePWraBJ7x7Txqjy7n33
         DT/bzX/6r3QiZhzahkJT7pW7UUUrPmSaHoKlF3gZEYC7t5Q9Ryb4hXlM9OdoUSrZsyjZ
         C+kN78+Ime2qfh02WAIXrZvjNprtIA5Ndq2Burfo99J1vwzHxDm7l+PWBRnccrANSuZ9
         cJ2eIlmIFmYujr2/EFsVWopCsgVJcrK4wycHAvocxRwQXdmQaqU953K53BfRgsNkQn6C
         JVSH/y7u5gE+yab7GnYcOTwqspk+ET48aMsx0+11jC9YrWLbEOB/BA1Xoor9fs//3edZ
         tbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610651; x=1796215451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5e50Z3PErs95PfAYhGq7yMRJdGKt4KZmrCHuxtK1wds=;
        b=gwxe32UJGqbJWBzNt18QMHPS9L6nByOCAUPNChwZnfsLltNQUqFkeMeqPffYdJLGOP
         DbYyF2R6KXNdDYZLRugDx3llqOHacTb+mpA8yd7+/PylIK1AQ6IKHsUkDIh3FI2hlHFI
         uRc3LOC71hqsvvkHHxivbYwbkaClulMsn9H2XX/EzVqhlSOyoUMTHz8pPWb2pmGLL/sN
         bbIGIAmFVE+ZT1C+eNKHAV4cSTiMagWGuuLqT7AFJU4CJGY+tulEDuWimaEE69M9ZsI5
         Ls6RhAXm67cOBNW6cLCqY8/uE/Hs6rKLIR+sa58ztAzUXeast0i4LpphorrqCestS705
         sb5Q==
X-Gm-Message-State: APuU4Z8mSiMJ+jCw9MvOYxcZwVFerQaLG3buD7sz9Qf0V8zGXbMXzqHd
	7gGMJsb0cWZYYmRDskokDS+5+99mOpFZ4WmzSARaYr6Jh2JjWibJOYbbADLftLTd
X-Gm-Gg: AZFdTZcYA9GCkBIOQ1vxrSibw8imWE7Ae6UFHlQGvbvtfIIN22E5LorAfGRwUDlToAf
	o+nW1eP2LwHYBxwEjVf16FvJQnxbQAVj5218WpMN1FYAvWZIXGnEZMX5JRDzVDSU2joCmcLj3Jl
	gNrY11pATuWrbYvoRQjQzoRWxCgOeK0JPcWyynPe2it5CijJQbXwUWlrUz/0btV4JRrgKuLd1Vv
	YLTC3MDBwlBy6eJVg2E8Wozbra9fwyHFniPQC16DWPgOzhI9Bu87QY1PkYGXptMIKmHH+Wdgmzx
	IbVXa8fR0hbDgEvdTMcARWF0E6aXbYgsnvRZOaSIRuc8agzDxqXO6Yg2uSLUfG+S9OtxsQ9XlCb
	nA22LZTK1juD+li58cHJk9XwpFfLqJHsh5I3tSH2YT+bwFWBlytyc1lzoHSuybeP7ScPqIk0t+8
	1t+lDm5G5OX23kN4dIpjUIC6hYZoKJ+qq/F3W8U6Zugall2niwVYMjn4UKP7Hk7GSyoKCOGVnaV
	tCIJIo7ly0cu5VUBTcpdTTorUw5+s6ePVAQnLUNb+JpEegKMTcEQCapfPIGJwTcf2kQ4mhu8YYC
	qip2+OIRbAEbiUmx6vzm1TTS5Aw72WcHaFv8OdzkeqijVXMfuiZmlruLslKJ1SCyng==
X-Received: by 2002:a05:7022:f509:b0:1b2:41af:c21c with SMTP id a92af1059eb24-1b55694689amr15902754c88.39.1795610650375;
        Wed, 25 Nov 2026 04:44:10 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm55841836eec.6.2026.11.25.04.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:44:10 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	John Groves <jgroves@micron.com>
Subject: [RFC PATCH 3/4] cxl/memdev: Add firmware_activate to activate firmware without a reset
Date: Wed, 25 Nov 2026 21:43:57 +0900
Message-Id: <20261125124358.3583223-4-unsung0317@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125124358.3583223-1-unsung0317@gmail.com>
References: <20261125124358.3583223-1-unsung0317@gmail.com>
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

Linux activates newly uploaded firmware only on the next cold reset, so
running it requires a reboot or a power cycle even when the device
reports that it supports online activation (FW Activation Capabilities
bit 0 in Get FW Info).

Add a write-only memdev attribute, firmware_activate, that activates a
given slot online. Uploads are unchanged and still set up the new slot
for activation on the next cold reset, so nothing changes unless
userspace asks for an online activation.

Online activation is meant to let the device keep serving requests, but
the driver cannot tell how long a given device holds CXL.mem requests
while it switches firmware, and a stall the platform does not tolerate
would take the memory down. Apply the same condition as sanitize: the
memdev must be bound and no endpoint decoder may be committed, checked
under the device lock, which is held until the command completes, and
under cxl_rwsem.region. There a FW state bit is set that makes decoder
commit refuse the device until the command has completed, as
sanitize_active does for sanitize. cxl_rwsem.region is not held across
the command, which may take up to 30 seconds, so regions of other
devices are not held up. If the command times out the device may still
be activating, so the bit stays set until Get FW Info reports the slot
as running or an activation succeeds. An error from a later Activate FW
may come while the device is still busy with the earlier one, so it
leaves the bit set; a device that ends up keeping its old firmware then
refuses regions until cxl_pci is bound again. While the bit stays set
after a timeout, also refuse firmware uploads and sanitize, which would
otherwise send state changing commands to a device that may still be
activating and rely on it to answer Busy.

Userspace is expected to move the data away, take the memory offline and
destroy the regions before writing the attribute, and to recreate them
afterwards. The policy of when to do this, or to leave the activation to
the next reset, stays in userspace.

Check the slot number against Get FW Info before the state checks, so
an invalid slot gets EINVAL rather than EBUSY; a device without online
activation support reports EOPNOTSUPP first. Also refuse while a
sanitize is running, and when another slot is set up for activation on
the next cold reset, since that reset would silently replace the
firmware activated now. Exclude concurrent uploads with a busy bit in
the FW state. After the command, read Get FW Info again and report the
slot the device runs, so that a failure shows whether the device kept
the old firmware, and warn if the device still reports another slot for
the next cold reset.

Only decoders of this host are visible, so devices shared with other
hosts are not covered by the check.

Signed-off-by: Unsung Lee <unsung0317@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  45 ++++++
 drivers/cxl/core/hdm.c                  |   7 +
 drivers/cxl/core/mbox.c                 |   5 +
 drivers/cxl/core/memdev.c               | 198 +++++++++++++++++++++++-
 drivers/cxl/cxlmem.h                    |   4 +
 5 files changed, 252 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index cf45b3fde0..d1135b2fb8 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -18,6 +18,45 @@ Description:
 		specification.
 
 
+What:		/sys/bus/cxl/devices/memX/firmware_activate
+Date:		November, 2026
+KernelVersion:	v7.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) Write a firmware slot number to activate the firmware in
+		that slot now, without a reset ("online" activation in the
+		Activate FW command). Firmware uploaded through
+		/sys/class/firmware/memX/ is set up for activation on the next
+		cold reset; this attribute lets userspace switch to it earlier.
+		Like sanitize, this requires the device to be disabled, that
+		is, not actively decoding any HPA ranges, so the caller has to
+		take its memory offline and destroy its regions first. The
+		write fails with EOPNOTSUPP if the device does not support
+		online activation, EINVAL for an invalid or already active
+		slot, and EBUSY if the device is decoding memory, a firmware
+		upload or a sanitize is in progress, or a different slot is set
+		up for activation on the next cold reset. Only the decoders of
+		this host are checked. If the device fails the command, the
+		write fails with the error of the mailbox command: ENXIO for
+		most device errors, including a device still busy with an
+		earlier activation, or ETIMEDOUT if the command does not
+		complete in time. While the device activates, committing a
+		region on it fails with EBUSY. If the command times out, the
+		device may still be activating. Until a later write finds the
+		slot running or an activation succeeds, committing a region
+		still fails with EBUSY, a firmware upload fails with the error
+		device-busy, and sanitize and secure erase fail with EBUSY. If
+		the device ends up keeping its old firmware, this lasts until
+		cxl_pci is bound again; firmware can be uploaded again after
+		that. If the device still reports another slot set up for
+		activation on the next cold reset after the online activation,
+		a warning is logged. The firmware_version attribute is read
+		once at probe and is not updated by an online activation; the
+		version of each slot is available from the Get FW Info command.
+		If this file is not present, the device does not support
+		firmware update.
+
+
 What:		/sys/bus/cxl/devices/memX/payload_max
 Date:		December, 2020
 KernelVersion:	v5.12
@@ -140,6 +179,9 @@ Description:
 		transitions between software programmed and hardware committed
 		states. If this file is not present, then there is no hardware
 		support for the operation.
+		While an online firmware activation started through
+		firmware_activate may still be running, the write fails with
+		EBUSY.
 
 
 What            /sys/bus/cxl/devices/memX/security/erase
@@ -156,6 +198,9 @@ Description:
 		transitions between software programmed and hardware committed
 		states. If this file is not present, then there is no hardware
 		support for the operation.
+		While an online firmware activation started through
+		firmware_activate may still be running, the write fails with
+		EBUSY.
 
 
 What:		/sys/bus/cxl/devices/memX/firmware/
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ad60be0964..503f8f4a18 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -923,6 +923,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	/*
 	 * For endpoint decoders hosted on CXL memory devices that
 	 * support the sanitize operation, make sure sanitize is not in-flight.
+	 * Likewise for an online firmware activation.
 	 */
 	if (is_endpoint_decoder(&cxld->dev)) {
 		struct cxl_endpoint_decoder *cxled =
@@ -937,6 +938,12 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 				dev_name(&cxld->dev));
 			return -EBUSY;
 		}
+		if (mds && test_bit(CXL_FW_ACTIVATING, mds->fw.state)) {
+			dev_dbg(&cxlmd->dev,
+				"attempted to commit %s during firmware activation\n",
+				dev_name(&cxld->dev));
+			return -EBUSY;
+		}
 	}
 
 	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f9f1c6ce79..5eef96d39f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1339,6 +1339,11 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	guard(device)(&cxlmd->dev);
 	endpoint = cxlmd->endpoint;
 	guard(rwsem_read)(&cxl_rwsem.region);
+
+	/* An online FW activation that timed out may still be running */
+	if (test_bit(CXL_FW_ACTIVATING, mds->fw.state))
+		return -EBUSY;
+
 	/*
 	 * Require an endpoint to be safe otherwise the driver can not
 	 * be sure that the device is unmapped.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index cdbebd1225..cc9ff0dd9c 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -51,6 +51,35 @@ static ssize_t firmware_version_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(firmware_version);
 
+static int cxl_mem_activate_fw_online(struct cxl_memdev_state *mds,
+				      unsigned int slot);
+
+static ssize_t firmware_activate_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	unsigned int slot;
+	int rc;
+
+	if (!mds)
+		return -EOPNOTSUPP;
+
+	rc = kstrtouint(buf, 0, &slot);
+	if (rc)
+		return rc;
+
+	/* Exclude a firmware upload and a second activation */
+	if (test_and_set_bit(CXL_FW_BUSY, mds->fw.state))
+		return -EBUSY;
+	rc = cxl_mem_activate_fw_online(mds, slot);
+	clear_bit(CXL_FW_BUSY, mds->fw.state);
+
+	return rc ? rc : len;
+}
+static DEVICE_ATTR_WO(firmware_activate);
+
 static ssize_t payload_max_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -412,6 +441,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
+	&dev_attr_firmware_activate.attr,
 	&dev_attr_payload_max.attr,
 	&dev_attr_label_storage_size.attr,
 	&dev_attr_numa_node.attr,
@@ -475,6 +505,18 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 {
 	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
 		return 0;
+
+	if (a == &dev_attr_firmware_activate.attr) {
+		struct device *dev = kobj_to_dev(kobj);
+		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+		struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+		/* Same condition as devm_cxl_setup_fw_upload() */
+		if (!mds || !test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO,
+				      mds->cxlds.cxl_mbox.enabled_cmds))
+			return 0;
+	}
+
 	return a->mode;
 }
 
@@ -936,6 +978,7 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
  * cxl_mem_activate_fw - Activate Firmware
  * @mds: The device data for the operation
  * @slot: slot number to activate
+ * @action: CXL_FW_ACTIVATE_ONLINE or CXL_FW_ACTIVATE_OFFLINE
  *
  * Activate firmware in a given slot for the device specified.
  *
@@ -943,7 +986,8 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
  *
  * See CXL-3.0 8.2.9.3.3 Activate FW
  */
-static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
+static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot,
+			       u8 action)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_activate_fw activate;
@@ -966,13 +1010,136 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
 		.poll_count = 30,
 	};
 
-	/* Only offline activation supported for now */
-	activate.action = CXL_FW_ACTIVATE_OFFLINE;
+	activate.action = action;
 	activate.slot = slot;
 
 	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 }
 
+/*
+ * cxl_mem_activate_fw_online - Activate a FW slot without a reset
+ *
+ * How long a device holds CXL.mem requests while it switches to the new
+ * firmware is not known here, and a stall the platform does not tolerate
+ * would take the memory down. Like sanitize, only proceed when the device
+ * is not decoding any HPA range, i.e. no endpoint decoder is committed,
+ * and set CXL_FW_ACTIVATING under cxl_rwsem.region so that none can be
+ * committed until the command has completed. After a timeout the device
+ * may still be activating: keep CXL_FW_ACTIVATING until Get FW Info
+ * reports the slot as running or an activation succeeds. A device that
+ * keeps its old firmware then refuses regions until cxl_pci is bound
+ * again.
+ *
+ * Decoders of other hosts sharing the device are not visible here.
+ */
+static int cxl_mem_activate_fw_online(struct cxl_memdev_state *mds,
+				      unsigned int slot)
+{
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
+	int rc, info_rc;
+
+	rc = cxl_mem_get_fw_info(mds);
+	if (rc)
+		return rc;
+
+	/* An activation that timed out has completed (cur_slot is never 0) */
+	if (mds->fw.activating_slot == mds->fw.cur_slot) {
+		mds->fw.activating_slot = 0;
+		clear_bit(CXL_FW_ACTIVATING, mds->fw.state);
+	}
+
+	if (!(mds->fw.activation_cap &
+	      CXL_FW_INFO_ACTIVATION_CAP_HAS_LIVE_ACTIVATE))
+		return -EOPNOTSUPP;
+
+	if (!slot || slot > mds->fw.num_slots || slot == mds->fw.cur_slot)
+		return -EINVAL;
+
+	/*
+	 * A different slot set up for activation on the next cold reset
+	 * would silently replace this firmware at that reset.
+	 */
+	if (mds->fw.pending_slot && mds->fw.pending_slot != slot &&
+	    mds->fw.pending_slot != mds->fw.cur_slot) {
+		dev_err(&cxlmd->dev,
+			"slot %d is pending activation on reset, not activating slot %u\n",
+			mds->fw.pending_slot, slot);
+		return -EBUSY;
+	}
+
+	/*
+	 * synchronize with cxl_mem_probe(), sanitize and decoder write
+	 * operations
+	 */
+	guard(device)(&cxlmd->dev);
+
+	/* A running sanitize owns the device until it completes */
+	scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
+		if (mds->security.sanitize_active)
+			return -EBUSY;
+	}
+
+	scoped_guard(rwsem_read, &cxl_rwsem.region) {
+		/* Without a bound endpoint the device may still be mapped */
+		if (!cxlmd->dev.driver ||
+		    cxl_num_decoders_committed(cxlmd->endpoint)) {
+			dev_err(&cxlmd->dev,
+				"device is decoding memory, not activating firmware online\n");
+			return -EBUSY;
+		}
+		set_bit(CXL_FW_ACTIVATING, mds->fw.state);
+	}
+
+	rc = cxl_mem_activate_fw(mds, slot, CXL_FW_ACTIVATE_ONLINE);
+	if (rc == -ETIMEDOUT) {
+		mds->fw.activating_slot = slot;
+		dev_warn(&cxlmd->dev,
+			 "slot %u may still be activating, refusing regions on this device\n",
+			 slot);
+	} else if (!rc || !mds->fw.activating_slot) {
+		/*
+		 * After a timeout only a success shows that the device is
+		 * done. Any error may come while it is still busy with the
+		 * activation that timed out, so the mark stays.
+		 */
+		mds->fw.activating_slot = 0;
+		clear_bit(CXL_FW_ACTIVATING, mds->fw.state);
+	}
+
+	/* Report the slot the device runs now, also after a failure */
+	info_rc = cxl_mem_get_fw_info(mds);
+	if (info_rc)
+		dev_warn(&cxlmd->dev, "cannot read FW slot state: %d\n",
+			 info_rc);
+
+	if (rc) {
+		if (info_rc)
+			dev_err(&cxlmd->dev,
+				"online activation of slot %u failed: %d\n",
+				slot, rc);
+		else
+			dev_err(&cxlmd->dev,
+				"online activation of slot %u failed: %d, active slot %d\n",
+				slot, rc, mds->fw.cur_slot);
+		return rc;
+	}
+
+	dev_info(&cxlmd->dev, "firmware slot %u activated online\n", slot);
+
+	/*
+	 * Whether a reset-activation set up by the upload stays pending
+	 * after an online activation is up to the device. Tell the user if
+	 * the next cold reset would switch to another slot.
+	 */
+	if (!info_rc && mds->fw.pending_slot &&
+	    mds->fw.pending_slot != mds->fw.cur_slot)
+		dev_warn(&cxlmd->dev,
+			 "slot %d is still set up for activation on the next cold reset\n",
+			 mds->fw.pending_slot);
+	return 0;
+}
+
 /**
  * cxl_mem_abort_fw_xfer - Abort an in-progress FW transfer
  * @mds: The device data for the operation
@@ -1015,6 +1182,7 @@ static void cxl_fw_cleanup(struct fw_upload *fwl)
 	struct cxl_memdev_state *mds = fwl->dd_handle;
 
 	mds->fw.next_slot = 0;
+	clear_bit(CXL_FW_BUSY, mds->fw.state);
 }
 
 static int cxl_fw_do_cancel(struct fw_upload *fwl)
@@ -1041,18 +1209,33 @@ static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
 	if (!size)
 		return FW_UPLOAD_ERR_INVALID_SIZE;
 
+	/* Exclude an online activation running from sysfs */
+	if (test_and_set_bit(CXL_FW_BUSY, mds->fw.state))
+		return FW_UPLOAD_ERR_BUSY;
+
+	/* ... and one that timed out, which the device may still be running */
+	if (test_bit(CXL_FW_ACTIVATING, mds->fw.state)) {
+		clear_bit(CXL_FW_BUSY, mds->fw.state);
+		return FW_UPLOAD_ERR_BUSY;
+	}
+
 	mds->fw.oneshot = struct_size(transfer, data, size) <=
 			    cxl_mbox->payload_size;
 
-	if (cxl_mem_get_fw_info(mds))
+	if (cxl_mem_get_fw_info(mds)) {
+		clear_bit(CXL_FW_BUSY, mds->fw.state);
 		return FW_UPLOAD_ERR_HW_ERROR;
+	}
 
 	/*
 	 * So far no state has been changed, hence no other cleanup is
-	 * necessary. Simply return the cancelled status.
+	 * necessary. Simply return the cancelled status. ->cleanup() is
+	 * not called when ->prepare() fails.
 	 */
-	if (test_and_clear_bit(CXL_FW_CANCEL, mds->fw.state))
+	if (test_and_clear_bit(CXL_FW_CANCEL, mds->fw.state)) {
+		clear_bit(CXL_FW_BUSY, mds->fw.state);
 		return FW_UPLOAD_ERR_CANCELED;
+	}
 
 	return FW_UPLOAD_ERR_NONE;
 }
@@ -1142,7 +1325,8 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 	if (mds->fw.oneshot || remaining == 0) {
 		dev_dbg(&cxlmd->dev, "Activating firmware slot: %d\n",
 			mds->fw.next_slot);
-		rc = cxl_mem_activate_fw(mds, mds->fw.next_slot);
+		rc = cxl_mem_activate_fw(mds, mds->fw.next_slot,
+					 CXL_FW_ACTIVATE_OFFLINE);
 		if (rc < 0) {
 			dev_err(&cxlmd->dev, "Error activating firmware: %d\n",
 				rc);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a67e451a62..7674390a73 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -379,6 +379,8 @@ struct cxl_mbox_activate_fw {
 /* FW state bits */
 #define CXL_FW_STATE_BITS		32
 #define CXL_FW_CANCEL			0
+#define CXL_FW_BUSY			1
+#define CXL_FW_ACTIVATING		2
 
 /**
  * struct cxl_fw_state - Firmware upload / activation state
@@ -390,6 +392,7 @@ struct cxl_mbox_activate_fw {
  * @next_slot: Slot number for the new firmware
  * @pending_slot: Slot to be activated on the next cold reset, 0 if none
  * @activation_cap: FW Activation Capabilities from Get FW Info
+ * @activating_slot: Slot of an online activation that timed out, 0 if none
  */
 struct cxl_fw_state {
 	DECLARE_BITMAP(state, CXL_FW_STATE_BITS);
@@ -399,6 +402,7 @@ struct cxl_fw_state {
 	int next_slot;
 	int pending_slot;
 	u8 activation_cap;
+	int activating_slot;
 };
 
 /**
-- 
2.34.1

