Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A773DCD94
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386946; cv=none; b=c5+e5DQxo4z5PKMkB8iU3ZOBYFr7Zxliim/pA2y7DbI34ZDdBU2GczlYvRfsYxk1z62JzvZdhQVmZGQeu+cV04hDErZBxUHQCR0NftdRj7dH1swteZM06yABNQdjtsokDMuEK66isaDYC6s+rhAaaycNhG/oapubyfnrUm7yMgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386946; c=relaxed/simple;
	bh=soQnFMGvbmItdJspxhnlC/+mXbDswaSYeoXIXlQqP8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dTMuXSGw5d1Y77B26rHAIkbCky52Cj1NU4SZPkkFWj5b2JUVL6PAGpFyWMsca7eqEkyLYDy/tf8HoXBQghWx/NFtofHb4emigBYp3+pTk5TPxctqBQ1kt3R/ZxIwA7RG7un9sVrpn80Cmn0s2UPJ385yc3VledgVNvdvI+lPUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwDLxyrB; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwDLxyrB"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so5161745eec.0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386944; x=1782991744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAB2AFKTJqJsskQ8IKMyTeb3zPPHWQfTV+Ihw2RdXIE=;
        b=KwDLxyrBm8Pt8WLdzaw9SDu9U1cmt8c3T0sOT/7YZWTlA2VPjUvFfW9QIy1xeD9eYt
         T6Xfo1oT2RA+fZLNCxbBoj7DpjXPPfY+Y3QXuoIJbD9DnnR+H3A0tkw0AP4pHFo5BABX
         kn1OtcTny6SVHXyernJzPccsDoqvlE+BZ6ztQr8ejNEAJbDcDPf6OPCdTcqc1T8fgMf3
         7TE3iiIrr3WtNZVF1R2Z3P3A2kET/DNCypuqkPLz2C3w3WKZXjTckfXgcR4prR5Y2D4M
         JoZQn5RdaEi3DcLMPn7MNFgziIuh/3fnGHYX8/QCiiXXbcYo4zGArqIAuUbcMEsJR8+p
         g4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386944; x=1782991744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dAB2AFKTJqJsskQ8IKMyTeb3zPPHWQfTV+Ihw2RdXIE=;
        b=cuYS2pUGbUd+8Gv8GyKMiThcu2r84VpZF/SAd7fa+W3qJXScIPV3BOGzQDYOwRwQD1
         ES/XrdE6HjRleJ1GbBIA2HcFy2Yvy9fqDDbeZk8xFhlqdU+WihshEAz3klgG/ZvO99Gc
         yJ8yhU7N2YeOD0OYU+NqzgbsBBIJH7kHke/+mBoCRyuD0MhE4OlEfU8ricRUK6tncYNj
         ftI/rY7/22H/n9i2vwhi8WNKIOmzaKOixJBl9Hw/XnVcX/J5TE75A+HtFc/xqKYGQZ/Z
         FZthJ1+/TfmfcR0wmktPNOY+zGrletNsi52lokk1o3gVTw65kd8pqFg/cr6tZBhOockA
         rTaA==
X-Gm-Message-State: AOJu0YyOj1T+oa6MnQ1z7+Nip2goq8snbi/P2QzPCDRJFpZ6NuyG7BYW
	i/N6PoDPoiJ26OfyfWyOmTdY/HXUKAzdsuG+Q8U35ccWOeVr0be2wWL0E+8qgQ==
X-Gm-Gg: AfdE7cldIsJQE5j0I1k9DsqMB7+tQv/6+xH/moEoJ8LoUHc5QvXvUQbV0unAka35egT
	3oHMlc+BxDKevckSi9Sd94lrqxV0UmAiREbARvbvPL899qb4B37CNIlEstVRy+KHx4BaoNTQ0KY
	ElZOG/MrLBn/T8ptvJvPvES1Qq+JPYid7rut5CsPLojteU0tDT8KZ2MmJlkX5rA1fTHU5bpijFa
	xW1SAoWCgeVYnTWvLdlSFPi3lrE+dHBZE4xGWQ8Ozqi/uWuj+kEwryyM4mwf84hRIwmxf4OGPsX
	ZfU6l0vgs2p85bsQRk6LhsnIQVT3TZv00qCFTX9Db6LkFj+eVqsMYfLe9Ozi26UmLnuGtvuDaKh
	ehPLteKTNJGSOooGxo7ugpYq2QryE6Fl8xYSjsVSOAtKcWH6MShrLLwjLzBhl/ZsIgjKWgSNPIa
	9P7LNy80U2URcuzDBoXQJCo83eFcaUdzyaPF/2plaHblC7C4r3JcyBh7gtDa2zcCeEvWjf
X-Received: by 2002:a05:7300:188b:b0:2d1:d434:cfe3 with SMTP id 5a478bee46e88-30c848b8eedmr3169777eec.0.1782386944144;
        Thu, 25 Jun 2026 04:29:04 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:29:03 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v11 24/31] dax/bus: Add uuid sysfs attribute to dax devices
Date: Thu, 25 Jun 2026 04:05:01 -0700
Message-ID: <20260625112638.550691-25-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a read-write 'uuid' sysfs entry at
/sys/bus/dax/devices/daxX.Y/ with stubbed handlers: show returns the
null uuid and store returns -EOPNOTSUPP.  A follow-on patch wires both
directions to dax_resource tracking.

Document the attribute in the dax sysfs ABI.

Signed-off-by: Anisa Su <anisa.su@samsung.com>

---
Changes:
- uuid_show() emits the null uuid ("%pUb" of uuid_null) instead of "0".
- ABI: describe the no-uuid read value as a null uuid instead of "0";
  bump Date to June, 2026 and KernelVersion to v7.3.
---
 Documentation/ABI/testing/sysfs-bus-dax | 18 ++++++++++++++++++
 drivers/dax/bus.c                       | 14 ++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
index b34266bfae49..3219c09dea01 100644
--- a/Documentation/ABI/testing/sysfs-bus-dax
+++ b/Documentation/ABI/testing/sysfs-bus-dax
@@ -59,6 +59,24 @@ Description:
 		backing device for this dax device, emit the CPU node
 		affinity for this device.
 
+What:		/sys/bus/dax/devices/daxX.Y/uuid
+Date:		June, 2026
+KernelVersion:	v7.3
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) On read, reports the uuid identifying the capacity
+		backing this dax device.  A null uuid (all-zeroes) indicates
+		that the device has no associated uuid — either it is not
+		backed by DCD capacity, or the backing extents are untagged.
+
+		Writes are accepted only on dax devices in sparse (DCD)
+		regions; writes to non-sparse devices return -EOPNOTSUPP.
+		Writing a non-null uuid claims every dax_resource in the
+		parent region whose tag matches the written uuid, consuming
+		any available capacity in each matching resource.  Writing
+		"0" is shorthand for the null uuid and claims a single
+		untagged dax_resource.
+
 What:		/sys/bus/dax/devices/daxX.Y/target_node
 Date:		February, 2019
 KernelVersion:	v5.1
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index ffa6b303fc9b..f61309a6f934 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1573,6 +1573,19 @@ static ssize_t numa_node_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static ssize_t uuid_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%pUb\n", &uuid_null);
+}
+
+static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t len)
+{
+	return -EOPNOTSUPP;
+}
+static DEVICE_ATTR_RW(uuid);
+
 static ssize_t memmap_on_memory_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -1644,6 +1657,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_memmap_on_memory.attr,
+	&dev_attr_uuid.attr,
 	NULL,
 };
 
-- 
2.43.0

