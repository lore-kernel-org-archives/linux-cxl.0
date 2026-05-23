Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C338837D
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529464; cv=none; b=R2xFCWZ+iAUVZpMb8sTE5uny1rWIam5HSp2KgHCLJ4nOjZZepRz+MYOl5A78YQlIMxGUIv25mZnymijcPWZ2zOUPldOXncBpP04RfMRgydsvVbd4y4APrtqcI9EZX7MpjPIt+Qed0jgaR2zhG8DS415hkFzSBgmJxTUPl9sdD6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529464; c=relaxed/simple;
	bh=9HSZkj8sz7iE2pO/UoR8wmVGm/iBP6zckVKXnScvJhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1vsu/twkMjqXy3a3t3/l2B3+qEsT5yg6TAjx9nyRXug+I2DrNtEGIDDff/+wtk5Rnp5lsocEmTcYHxySGcnOUvya7YyP+xP/Y0W9mqPXHZpftUjTzpMqiEFeX8TkGJU/TtCvqbQle4y8qq3v1kcSw1UFLNbR91kIl92G61a+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjiJn0TF; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjiJn0TF"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12ddbe104ccso6054300c88.0
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529462; x=1780134262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cftZ9CN3nyhvsXby1K+8vux5FcbG22mvmTiGFrN7YKo=;
        b=AjiJn0TFecZk2JmMQTbY5PaLpTRnOyj/k9ePODy/MnIZ/QQXXaJVWShDbm/XLEwE9d
         TJA/BLTZ6msx342jDEPnSPtjZv0noPExLhPEboYbNv385dBIVHD68Fe/vMRotkqBGfhx
         DcEDqf55ApbWltuUnaQpqm4G+DcttjQXs7wlnpsdgIh6+71DWhgNLXbmz+D98G/S1TwH
         ukQFqQN8qH+8mfu62SlFFzs0Ovf65QNMF7FO/hBxMiAUIxbfMNiOVdaJ90Y0KPPV9hcO
         PVmW3DaDTqJCR/a+6dph2QL58yj+rpa5o/ToNJ1O0eCT9ctVN/vCXIsBM8+ppKGZznIw
         MBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529462; x=1780134262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cftZ9CN3nyhvsXby1K+8vux5FcbG22mvmTiGFrN7YKo=;
        b=Z1Yq8GYhFmAPgqEhQoyuJJK9aYlW2/z/yforos7tvlCyz+sWvOjw03wNV1N/i5lRtL
         Cq4yhLx/SDrbRc11Py1Sl7Fe5nE39b7LsR9EEv4QlbipSk7XwOb8B9iymO/30rYKH59m
         xoFoHhNS676Sxgpy9rlORD/aTRk4GgCoxL0m/tpjGEn8KE6YdAD9pDnC51Vrlsn6mrNo
         5/OUNCaWWP561m/iQdXcA5wrgFFR9E8Krq0ZuXTpMnLJZXa4Pr7kGF+nTHmfRWKTbzFd
         75DfLQy/MEUfMl7TWboIwcwa+a3ykbEIql8D51FBMCrKDx8PB/1ft7TQ5HPeHUxkln5Q
         brXA==
X-Gm-Message-State: AOJu0YxcL4buMh8v+AM1FYEXwn3jw/ksSQh/KjGRp7ELbRC8MT1CcVEs
	VEhbwBZ3ZawW1ZEeo9DOnZ7Kqt8PFAx2VE7iD/YccY4lRTPRjOWKEbGNefmAdg==
X-Gm-Gg: Acq92OGpBhyOSMxsMh1I/gxnVdtOU4f7ciFAGqtkKe0+H01p0AeH/ifPm/PIGrzFFVU
	vd0hNQkssJ5dmb8/ZR5pVOZGipcwYj/HYnlqzIZs+DkH7ni1rvj3yjJ6Jii2kjErWchNy4Y+BB9
	rfiTJGarJyDUo/xVEtyKiGzzO2aIvCokldLWv+y8E+LFqdtjy+bqXhbE+TeUhKMKwehfb46zq8e
	tWkn2di4NnC5ahxFIvqrrX9kY1XBYboq1iM5hTDqalNnGlV/vwKLQEONDuBtC7gPDbGYkuBfvQA
	W0HYIhcf6Yk11gtUW4nBlQTgsL10ljQztcsMFYdbeLfTmgnktSqjstpEMnEG6h8lHl5+OWZXDOX
	rlWN0N5bahxm/3GYruvnLaBn2bhzFwZ7IN7qYk7xRUABp/v0m7wZixZQUft2ZMpUvWXRDRhu70F
	W2TJrLC3Y+URhvdWxmZe3l9fzoOIpNwd0/d0LfFyDkcAm2FzyIXPELuqMPpGwBWHlDi/3mSLjEw
	gSLHxk=
X-Received: by 2002:a05:7022:fe09:b0:134:ff2e:a71c with SMTP id a92af1059eb24-1365f600b14mr2361648c88.9.1779529462407;
        Sat, 23 May 2026 02:44:22 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:44:21 -0700 (PDT)
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
Subject: [PATCH v10 24/31] dax/bus: Add uuid sysfs attribute to dax devices
Date: Sat, 23 May 2026 02:43:18 -0700
Message-ID: <00e5da991afc1c96ca1074152ec10d0d8484b673.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a read-write 'uuid' sysfs entry at
/sys/bus/dax/devices/daxX.Y/ with stubbed handlers: show returns "0"
and store returns -EOPNOTSUPP.  A follow-on patch wires both
directions to dax_resource tracking.

Document the attribute in the dax sysfs ABI.

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 Documentation/ABI/testing/sysfs-bus-dax | 18 ++++++++++++++++++
 drivers/dax/bus.c                       | 14 ++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
index b34266bfae49..23400824073b 100644
--- a/Documentation/ABI/testing/sysfs-bus-dax
+++ b/Documentation/ABI/testing/sysfs-bus-dax
@@ -59,6 +59,24 @@ Description:
 		backing device for this dax device, emit the CPU node
 		affinity for this device.
 
+What:		/sys/bus/dax/devices/daxX.Y/uuid
+Date:		May, 2026
+KernelVersion:	v6.16
+Contact:	nvdimm@lists.linux.dev
+Description:
+		(RW) On read, reports the uuid identifying the capacity
+		backing this dax device.  A value of "0" indicates that the
+		device has no associated uuid — either it is not backed by
+		DCD capacity, or the backing extents are untagged.
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
index 5c1b93890d30..1d6f82920be6 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1526,6 +1526,19 @@ static ssize_t numa_node_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static ssize_t uuid_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", 0);
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
@@ -1597,6 +1610,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
 	&dev_attr_memmap_on_memory.attr,
+	&dev_attr_uuid.attr,
 	NULL,
 };
 
-- 
2.43.0

