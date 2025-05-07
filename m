Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BDD15E8B
	for <linux-cxl@vger.kernel.org>; Wed,  7 May 2025 00:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578603; cv=none; b=ud4tE8ADaayijxpKug0ZRtFP9srBlOv/qHYFByDN0nYIdgAvtvmM18hKvqgttnvB1gJo0LsyQr0iIemfw/rkqI6DpLPaCuRREyaJQXu/JDGNf4dFtNfRpUB4SH12yR57GEYkabJa/CLqacmbQ09F2HGUf9XFjUsvBQBkBVJLVFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578603; c=relaxed/simple;
	bh=cCCdWf2UVr7vzg9k3pEvaPvj7qJKpzB6A44ro8e8gBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqsZp5M+9f/ka97ywJwIK7MIAv+WvMs7utEri11oIhybWPkoO7bdRpYnSNMY/UgqvRHlviLOC7dPMs5mzGF5/d62HgA+mgikbdcOLWAmS51kexL4Z5BkOosiUWsAoMQV5GT11aUA/i/Ssj+p4GHiEgx/RLZrp7Bb34tvVP7V0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947CAC4CEE4;
	Wed,  7 May 2025 00:43:23 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH v2 08/10] cxl: Add helper to detect top of CXL device topology
Date: Tue,  6 May 2025 17:43:08 -0700
Message-ID: <20250507004310.3536991-9-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507004310.3536991-1-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper to replace the open code detection of CXL device hierarchy
root. The helper will be used for delayed hostbridge port creation later
on.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e212bc2faada..259b217e812f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -39,6 +39,15 @@ DECLARE_RWSEM(cxl_region_rwsem);
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
+/*
+ * The terminal device in PCI is NULL and @platform_bus
+ * for platform devices (for cxl_test)
+ */
+static bool is_cxl_hierarchy_head(struct device *dev)
+{
+	return (!dev || dev == &platform_bus);
+}
+
 int cxl_num_decoders_committed(struct cxl_port *port)
 {
 	lockdep_assert_held(&cxl_region_rwsem);
@@ -1774,11 +1783,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		struct device *uport_dev;
 		struct cxl_dport *dport;
 
-		/*
-		 * The terminal "grandparent" in PCI is NULL and @platform_bus
-		 * for platform devices
-		 */
-		if (!dport_dev || dport_dev == &platform_bus)
+		if (is_cxl_hierarchy_head(dport_dev))
 			return 0;
 
 		uport_dev = dport_dev->parent;
-- 
2.49.0

