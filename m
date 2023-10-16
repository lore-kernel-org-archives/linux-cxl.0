Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B5E541
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E2102
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 05:54:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8HB54Th1z6K90h;
	Mon, 16 Oct 2023 20:54:21 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 13:54:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/4] PCI: Add PCI_CLASS_SERIAL_CXL_SWITCH_CCI class ID to pci_ids.h
Date: Mon, 16 Oct 2023 13:53:22 +0100
Message-ID: <20231016125323.18318-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016125323.18318-1-Jonathan.Cameron@huawei.com>
References: <20231016125323.18318-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This ID is used for CXL Switch Mailbox CCIs.
Incorporate the Programming Interface in the definition in common
with similar entries.

See CXL rev3.0 81.1.3.1 PCI Header Class Code Register

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9..27d1bac65256 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -128,6 +128,7 @@
 #define PCI_CLASS_SERIAL_IPMI_SMIC	0x0c0700
 #define PCI_CLASS_SERIAL_IPMI_KCS	0x0c0701
 #define PCI_CLASS_SERIAL_IPMI_BT	0x0c0702
+#define PCI_CLASS_SERIAL_CXL_SWITCH_CCI	0x0c0b00
 
 #define PCI_BASE_CLASS_WIRELESS			0x0d
 #define PCI_CLASS_WIRELESS_RF_CONTROLLER	0x0d10
-- 
2.39.2

