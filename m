Received: from mail-m127105.qiye.163.com (mail-m127105.qiye.163.com [115.236.127.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A56109
	for <linux-cxl@vger.kernel.org>; Thu, 28 Dec 2023 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from ubuntu-22-04.. (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 12D15860271;
	Thu, 28 Dec 2023 14:05:18 +0800 (CST)
From: Dongsheng Yang <dongsheng.yang@easystack.cn>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	ave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [RFC PATCH 3/4] cxl/port: introduce cxl_disable_port() function
Date: Thu, 28 Dec 2023 06:05:09 +0000
Message-Id: <20231228060510.1178981-4-dongsheng.yang@easystack.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
References: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ0NCVkhPGUlCGBgYHUpOTFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlKQ1VCT1VKSkNVQktZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8caf06f706023ckunm12d15860271
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MC46Fgw*TDcxHyIaSxQyKzEs
	KjhPCxhVSlVKTEtITE9ITkpCS0lJVTMWGhIXVR8UFRwIEx4VHFUCGhUcOx4aCAIIDxoYEFUYFUVZ
	V1kSC1lBWUlKQ1VCT1VKSkNVQktZV1kIAVlBT01KSjcG

when we want to delete an port (e.g in cxlv), we want to
make sure there is no region attached to this port or
any child port. And more, we need to prevent region to
attach in port deleting.

cxl_disable_port() will return -EBUSY if there is any
region attached to this port or child port, otherwise it
will set any child endpoint decoder to CXL_DECODER_DEAD,
that means this port are going to be deleted, dont attach region
to it.

Signed-off-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
---
 drivers/cxl/core/port.c | 80 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  1 +
 2 files changed, 81 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8d2d54da45e5..59ab8fe2cff2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1508,6 +1508,86 @@ static void reap_dports(struct cxl_port *port)
 	}
 }
 
+/*
+ * Disable an endpoint decoder to prevent any more region attach.
+ */
+static int disable_decoder(struct device *device, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+
+	if (!is_endpoint_decoder(device))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(device);
+	cxled->mode = CXL_DECODER_DEAD;
+
+	return 0;
+}
+
+/*
+ * Disable a port, if it is an endpoint port, it will disable
+ * the related endpoint decoder, otherwise, disable all child ports.
+ */
+static int disable_port(struct device *device, void *data)
+{
+	struct cxl_port *port;
+	int ret;
+
+	if (!is_cxl_port(device))
+		return 0;
+
+	port = to_cxl_port(device);
+	if (is_cxl_endpoint(port)) {
+		ret = device_for_each_child(&port->dev, NULL, disable_decoder);
+	} else {
+		ret = device_for_each_child(&port->dev, NULL, disable_port);
+	}
+
+	return ret;
+}
+
+/*
+ * If there is any region attached to this port or child port, return -EBUSY.
+ */
+static int port_busy(struct device *device, void *data)
+{
+	struct cxl_port *port;
+
+	if (!is_cxl_port(device))
+		return 0;
+
+	port = to_cxl_port(device);
+	if (!xa_empty(&port->regions)) {
+		return -EBUSY;
+	}
+
+	return device_for_each_child(&port->dev, NULL, port_busy);
+}
+
+/*
+ * Disable any child endpoint decoder to prevent region attach,
+ * then we can delete this port safely.
+ *
+ * Returns -EBUSY if there is still region attached to this port
+ * or child port.
+ */
+int cxl_disable_port(struct cxl_port *port)
+{
+	int ret;
+
+	down_write(&cxl_region_rwsem);
+	if (port_busy(&port->dev, NULL)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = disable_port(&port->dev, NULL);
+unlock:
+	up_write(&cxl_region_rwsem);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_disable_port, CXL);
+
 struct detach_ctx {
 	struct cxl_memdev *cxlmd;
 	int depth;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1397f66d943b..a1343449f35c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -716,6 +716,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
 					 resource_size_t rcrb);
+int cxl_disable_port(struct cxl_port *port);
 
 #ifdef CONFIG_PCIEAER_CXL
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
-- 
2.34.1

