Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9D19147D
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354894; cv=none; b=DwAbKYiw55WfNXtcFlohU3RSpRIbqTCucdGJEEl2KCuCoXz+pOCaNBglInceteGnWn2lhqrcpFmW+itJKo2qn71EICs5RwJ4UG9ylhzNbokBu+xQr/sRNOnP+gxe0GdImqs6dPF+0YYhUUNVU6KymQ3BjJ8Q7pzp0rB3NpF/xQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354894; c=relaxed/simple;
	bh=XPQw3hQQN3+U1bbSVr7wSFA//1yRzIP+HHd17RlHxEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtulSwLaGZcAQ9ip+S5tBx5BvZZ7pH3d6MbyOR4bSR4bTfsXU77J6mNHFiNanfva/LgR58xRB9mfveRNdZz2q+e4o0VPb8lAor3w8xta0Z48i/sjsGhclgGbRwtcBs7KwBoe4x0SQuP8EL//U2HKdG6iY8t1RbM1hEEdIdM1mB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Ye7+J4kF; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Ye7+J4kF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718354892; x=1749890892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XPQw3hQQN3+U1bbSVr7wSFA//1yRzIP+HHd17RlHxEg=;
  b=Ye7+J4kFZgx2qGxxsI1EsTjEbVXJkGlKIp7s3YdEmWwQk9Rl2FDnaSeN
   TzqxhMKrzZIzpkAkL4rqtmmpYx4LoV3G32hHqieeD4f0I82Gy3AZcU0ue
   PUeBEcRJypDubexCGIYYbdiaCTGv8ouPqAgNMUd0geCCONfMun+bvaV9h
   xtIjnIizOmRreoXRX8Hlqqh7AVbcwZYL9+yKwhYQw6+CjwEkqNV38HvvY
   Xp3oJ7V+EPTUcg7Ywm6rumr7XBPKXT5aVWgMDBRQ2ObKYkE7YMoAYHqm8
   47KXWyqflPaMYdl67AysK47Odo3YW6i1T/N/2ztEiiCuu6+hykzCS69Lz
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="142263675"
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="142263675"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 17:48:03 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E258CA1E6
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 17:48:01 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id DF81FD7723
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 17:48:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6E5442007CDD7
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 17:48:00 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id CF0601A000B;
	Fri, 14 Jun 2024 16:47:59 +0800 (CST)
From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	jim.harris@samsung.com
Cc: linux-cxl@vger.kernel.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v9 2/2] cxl: documentation: add missing files to cxl driver-api
Date: Fri, 14 Jun 2024 04:47:55 -0400
Message-Id: <20240614084755.59503-3-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240614084755.59503-1-yaoxt.fnst@fujitsu.com>
References: <20240614084755.59503-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28452.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28452.006
X-TMASE-Result: 10--5.333400-10.000000
X-TMASE-MatchedRID: GQw6Xh/XS6VSuJfEWZSQfLnHu4BcYSmtTfK5j0EZbyvJXqC6Lyv8hX6g
	ZpfnfKEjIvrftAIhWmLy9zcRSkKatUPu4/hW5W83rMZ+BqQt2NoF1iW/P2dTv6lOQjQcrzOlyL5
	QmWOgMfAwFy/oOZpRjHjXF+DNun/KwwX0o7eolMDTCZHfjFFBz94Z4Nykx3k2z1qdVCu81fd4oP
	BwjFVS7o42tlhcK0JDW9nf1ruwbIAfnE4I6vGRzZ4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyH4gK
	q42LRYkT36Di737tmsuu81cA3mJctcpFi5OTuld0CXIg3KUbVt+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Add the missing files into cxl driver api and fix the compile warning.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 Documentation/driver-api/cxl/memory-devices.rst | 15 +++++++++++++++
 drivers/cxl/cxlmem.h                            | 11 ++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 5149ecdc53c7..d732c42526df 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -328,6 +328,12 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/mem.c
    :doc: cxl mem
 
+.. kernel-doc:: drivers/cxl/cxlmem.h
+   :internal:
+
+.. kernel-doc:: drivers/cxl/core/memdev.c
+   :identifiers:
+
 CXL Port
 --------
 .. kernel-doc:: drivers/cxl/port.c
@@ -341,6 +347,15 @@ CXL Core
 .. kernel-doc:: drivers/cxl/cxl.h
    :internal:
 
+.. kernel-doc:: drivers/cxl/core/hdm.c
+   :doc: cxl core hdm
+
+.. kernel-doc:: drivers/cxl/core/hdm.c
+   :identifiers:
+
+.. kernel-doc:: drivers/cxl/core/cdat.c
+   :identifiers:
+
 .. kernel-doc:: drivers/cxl/core/port.c
    :doc: cxl core
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 7806194d2de1..af8169ccdbc0 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -395,9 +395,9 @@ enum cxl_devtype {
 
 /**
  * struct cxl_dpa_perf - DPA performance property entry
- * @dpa_range - range for DPA address
- * @coord - QoS performance data (i.e. latency, bandwidth)
- * @qos_class - QoS Class cookies
+ * @dpa_range: range for DPA address
+ * @coord: QoS performance data (i.e. latency, bandwidth)
+ * @qos_class: QoS Class cookies
  */
 struct cxl_dpa_perf {
 	struct range dpa_range;
@@ -464,13 +464,14 @@ struct cxl_dev_state {
  * @active_persistent_bytes: sum of hard + soft persistent
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
+ * @ram_perf: performance data entry matched to RAM partition
+ * @pmem_perf: performance data entry matched to PMEM partition
  * @event: event log driver state
  * @poison: poison driver state info
  * @security: security driver state info
  * @fw: firmware upload / activation state
+ * @mbox_wait: RCU wait for mbox send completely
  * @mbox_send: @dev specific transport for transmitting mailbox commands
- * @ram_perf: performance data entry matched to RAM partition
- * @pmem_perf: performance data entry matched to PMEM partition
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
-- 
2.37.3

