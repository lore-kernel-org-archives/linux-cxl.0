Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB5E2AB39
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igfY0+Hm"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08892C0
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136835; x=1728672835;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpI2N622JoMRugXjc75fETIHfXpPArKUc34Mst8KloM=;
  b=igfY0+Hm/2uWs3KEsXw8kF+A9aT40RkWe52wyo1UAq4/4IcT0TZbKg8g
   vJB/piMIjXVeo1E0yj7pSTLHx4xlkT7dHQ6t9aAv+dQ46DpVq2A7NhRiz
   OlZxMHObVhkLUV94oQi+fKGhc6hGWyPHpl1Nv/lDIcq235kJjoI/obPhk
   PJyEYEL3ZXSK7x5XYIti/6ZD76XhE1xJkqYRCIiztgVmsbNYJYNnFVrR1
   +wjCJKj/DUyfTMnHjgm4uXhyRVTqVPB8o5IZWbpdo8ZfgIorjToUd2ebT
   hW3BKwlAY+JMgUEeimI2K4999NdgfKJts/ecXG60dUnUUq3h56l+ND+Ci
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="387864910"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="387864910"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="898245605"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="898245605"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:51:54 -0700
Subject: [PATCH v11 02/22] cxl: Add checksum verification to CDAT from CXL
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:53:42 -0700
Message-ID: <169713682277.2205276.2687265961314933628.stgit@djiang5-mobl3>
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 


