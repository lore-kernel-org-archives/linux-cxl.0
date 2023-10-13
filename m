Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A16273F9
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 21:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThRXy9Dk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0CABF
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697232702; x=1728768702;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tgBbk8gOSqgBD2DlDTK8CU6KFCJPGbAn23a6k5M2eCY=;
  b=ThRXy9Dk/ypxUdP1RPbCWYJtpGAAzp+w3XVcDBfisibrSoHGySoybJzh
   aFckb7gSJX2a24oDTbPuVMwKuE1cGn8cFNbAACbE3F4cOWOmId1llV0eO
   EKq+oCrhszHYmb5LHf0fA+NcpWkyAoJRdKTojHEGkcG+ivgdlbKSB5dZ3
   lZzy7HTPNMRv5pSyWpBtIrzK9okSQnlHIpfzdwotoxu9JFwbuBoE1GeSN
   lw39t7Q2nuFQ80Eep5ay2Vid6D/EQQ7Fdw+/V03Vrtq7KqJ0UT1k2zR3d
   zZjs3HvDiPyphc36bBnbklnMxTZomRvk+bL/MYMqFvK5kIpQHwQrcUpsI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="6833162"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="6833162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 14:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="898707608"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="898707608"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.1.223])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 14:29:50 -0700
Subject: [PATCH v2 2/2] cxl: Add decoders_committed sysfs attribute to
 cxl_port
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com
Date: Fri, 13 Oct 2023 14:31:41 -0700
Message-ID: <169723270125.66903.9705024211129163971.stgit@djiang5-mobl3>
In-Reply-To: <169723269532.66903.10556183191413240496.stgit@djiang5-mobl3>
References: <169723269532.66903.10556183191413240496.stgit@djiang5-mobl3>
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
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This attribute allows cxl-cli to determine whether there are decoders
committed to a memdev.  This is only a snapshot of the state, and
doesn't offer any protection or serialization against a concurrent
disable-region operation.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Use cxl_region_rwsem to protect reading of decoder info. (Dan)
---
 drivers/cxl/core/port.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fd1cc307759f..a448e1439b68 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -534,8 +534,33 @@ static void cxl_port_release(struct device *dev)
 	kfree(port);
 }
 
+static ssize_t decoders_committed_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct cxl_port *port = to_cxl_port(dev);
+	int rc;
+
+	down_read(&cxl_region_rwsem);
+	rc = sysfs_emit(buf, "%d\n", cxl_decoders_committed(port));
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+
+static DEVICE_ATTR_RO(decoders_committed);
+
+static struct attribute *cxl_port_attrs[] = {
+	&dev_attr_decoders_committed.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_port_attribute_group = {
+	.attrs = cxl_port_attrs,
+};
+
 static const struct attribute_group *cxl_port_attribute_groups[] = {
 	&cxl_base_attribute_group,
+	&cxl_port_attribute_group,
 	NULL,
 };
 


