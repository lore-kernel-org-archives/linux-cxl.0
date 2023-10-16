Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357981F61D
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoIYHsej"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B588EB
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697479076; x=1729015076;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ARA+bM14xbu4ten7aDuxBv3JSuLNbJ17IczZik4tqgg=;
  b=CoIYHsej0d/I4E0SNJnfoBiTBpo84T36PIOj7bivCCSiGk0KUFloHqu7
   E7vr+eCvqRF9O0q1SZyHzGeXNxKXtYzGvTYEp1qn/6ozoo2VWc0GQJrA5
   uCv2bJikkWwzMCkrumKTFuEoxMV4ZqXGBVGe1lff3HRNkhzUIIqbwOSeN
   Gx7AsnWQ/Ij94hhNQMgFtSR0uBKaOarAPPgyAMf5KrvZJQEYhcS7dc8tX
   kK2ZiUlmHGdQH96mnkKklN1i1TqQ3gSy3nU0/Zq4pK1S9mKAr6biPArfn
   ykgCYSDA1Yd4GiSn5YU+wIUKWCz5e0fEvxCekEvPnzEn9E8JjQrv3ym+N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="452085322"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="452085322"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="821658489"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="821658489"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.75.77])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 10:57:54 -0700
Subject: [PATCH v3 2/2] cxl: Add decoders_committed sysfs attribute to
 cxl_port
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jim Harris <jim.harris@samsung.com>,
 Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com
Date: Mon, 16 Oct 2023 10:57:54 -0700
Message-ID: <169747907439.272156.10261062080830155662.stgit@djiang5-mobl3>
In-Reply-To: <169747906849.272156.1729290904857372335.stgit@djiang5-mobl3>
References: <169747906849.272156.1729290904857372335.stgit@djiang5-mobl3>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This attribute allows cxl-cli to determine whether there are decoders
committed to a memdev.  This is only a snapshot of the state, and
doesn't offer any protection or serialization against a concurrent
disable-region operation.

Reviewed-by: Jim Harris <jim.harris@samsung.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Use cxl_region_rwsem to protect reading of decoder info. (Dan)
---
 drivers/cxl/core/port.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d0ed98a6bade..0adee1e406ec 100644
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
+	rc = sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
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
 


