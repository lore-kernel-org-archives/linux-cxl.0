Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA4803
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJftLojJ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2342192
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 18:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986311; x=1728522311;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpI2N622JoMRugXjc75fETIHfXpPArKUc34Mst8KloM=;
  b=cJftLojJV51QZ18M82z0eL8Rtjjva0Ul1RMiozW2U1S3JClr7at/o+0J
   QVQPowiaUffjshg8/VaOk9X8Y1QLo6aESjpprfkj9QBgR0MnnFREA1QGu
   R+2yMAcbPeHjAz/Y6YMrkneTH06aLvt1FiKSvuEWKZd8nxCIs2fwqEhNd
   lH2IJryFsKuN404k1aWE2pGJRxO8vv9ByzcOFEbTYp3JcY1jDAn3q4qBn
   uC6spK4tpAQjgRXuQ0jSTEsWG/AJgr8AySfMpRDFP2uQjWwWGQxbjZLNa
   xAoow5H53DA7ir0Cuxve5xlSYOYDc4lcKy46j++ZRrfkv0Q6QeXWo9ZFw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369615329"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="369615329"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="897436806"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="897436806"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.35.251])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:03:26 -0700
Subject: [PATCH v10 02/22] cxl: Add checksum verification to CDAT from CXL
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 10 Oct 2023 18:05:09 -0700
Message-ID: <169698630997.1991735.6417205965487592455.stgit@djiang5-mobl3>
In-Reply-To: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A CDAT table is available from a CXL device. The table is read by the
driver and cached in software. With the CXL subsystem needing to parse the
CDAT table, the checksum should be verified. Add checksum verification
after the CDAT table is read from device.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |   30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c7a7887ebdcf..9321a3865c30 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -595,6 +595,16 @@ static int cxl_cdat_read_table(struct device *dev,
 	return 0;
 }
 
+static unsigned char cdat_checksum(void *buf, size_t size)
+{
+	unsigned char sum, *data = buf;
+	size_t i;
+
+	for (sum = 0, i = 0; i < size; i++)
+		sum += data[i];
+	return sum;
+}
+
 /**
  * read_cdat_data - Read the CDAT data on this port
  * @port: Port to read data from
@@ -634,15 +644,21 @@ void read_cdat_data(struct cxl_port *port)
 		return;
 
 	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_table, &cdat_length);
-	if (rc) {
-		/* Don't leave table data allocated on error */
-		devm_kfree(dev, cdat_table);
-		dev_err(dev, "CDAT data read error\n");
-		return;
-	}
+	if (rc)
+		goto err;
 
-	port->cdat.table = cdat_table + sizeof(__le32);
+	cdat_table = cdat_table + sizeof(__le32);
+	if (cdat_checksum(cdat_table, cdat_length))
+		goto err;
+
+	port->cdat.table = cdat_table;
 	port->cdat.length = cdat_length;
+	return;
+
+err:
+	/* Don't leave table data allocated on error */
+	devm_kfree(dev, cdat_table);
+	dev_err(dev, "Failed to read/validate CDAT.\n");
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 


