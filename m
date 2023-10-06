Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35163DB
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mtfx20aY"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A083E9
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577249; x=1728113249;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KwmZBVREe1rJtwrTBTB2URrTzTDXNM8HysQkkcqUC1I=;
  b=Mtfx20aYxGWpEMuCdVTSTgRtdEMe8ohwonbng4aKeeOb007z0nkc5461
   8peJubFUpmvj83xVQih9kjt0qFKYnDl+CzLwRjQk6J3Xe+jreXSjF0+7U
   wh4gSHwIvKCDk4rsx3rk8z4MhAKQ8v1PRHNyIs7/WSmFud3XASARwKCze
   ZcAWCD8k8NtFpOxNGje7QnmWqfWcvFoKVJAjnJ+yd3zYXZmUbWcelG7G/
   1aT+CwS7mFeOISnk0XHRYkFMU7G3YcwHsQf6uVSwuSCXBaXI8jxiIFdJc
   WcoSbwUw6mqSmFBXE4nb3XGiXYJj1ZFHvsGBJrrQEEWxZlfalSNi+zbaN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368775247"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368775247"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:27:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842735620"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842735620"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:58 -0700
Subject: [PATCH v3 10/10] tools/testing/cxl: Add 'sanitize notifier' support
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>
Date: Fri, 06 Oct 2023 00:26:57 -0700
Message-ID: <169657721756.1491153.17305814762884004365.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
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

Allow for cxl_test regression of the sanitize notifier. Reuse the core
setup infrastructure, and trigger notifications upon any sanitize
submission with a programmable notification delay.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/mem.c |   68 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index ab311b59899a..76bdb1ac5816 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -89,6 +89,12 @@ static struct cxl_cel_entry mock_cel[] = {
 		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_COLD_RESET) |
 				      EFFECT(CONF_CHANGE_IMMEDIATE)),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_SANITIZE),
+		.effect = cpu_to_le16(EFFECT(DATA_CHANGE_IMMEDIATE) |
+				      EFFECT(SECURITY_CHANGE_IMMEDIATE) |
+				      EFFECT(BACKGROUND_OP)),
+	},
 };
 
 /* See CXL 2.0 Table 181 Get Health Info Output Payload */
@@ -152,6 +158,7 @@ struct cxl_mockmem_data {
 	struct cxl_memdev_state *mds;
 	u8 event_buf[SZ_4K];
 	u64 timestamp;
+	unsigned long sanitize_timeout;
 };
 
 static struct mock_event_log *event_find_log(struct device *dev, int log_type)
@@ -567,9 +574,26 @@ static int mock_partition_info(struct cxl_mbox_cmd *cmd)
 	return 0;
 }
 
+void cxl_mockmem_sanitize_work(struct work_struct *work)
+{
+	struct cxl_memdev_state *mds =
+		container_of(work, typeof(*mds), security.poll_dwork.work);
+
+	mutex_lock(&mds->mbox_mutex);
+	if (mds->security.sanitize_node)
+		sysfs_notify_dirent(mds->security.sanitize_node);
+	mds->security.sanitize_active = false;
+	mutex_unlock(&mds->mbox_mutex);
+
+	dev_dbg(mds->cxlds.dev, "sanitize complete\n");
+}
+
 static int mock_sanitize(struct cxl_mockmem_data *mdata,
 			 struct cxl_mbox_cmd *cmd)
 {
+	struct cxl_memdev_state *mds = mdata->mds;
+	int rc = 0;
+
 	if (cmd->size_in != 0)
 		return -EINVAL;
 
@@ -585,7 +609,16 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
 		return -ENXIO;
 	}
 
-	return 0; /* assume less than 2 secs, no bg */
+	mutex_lock(&mds->mbox_mutex);
+	if (schedule_delayed_work(&mds->security.poll_dwork,
+				  msecs_to_jiffies(mdata->sanitize_timeout))) {
+		mds->security.sanitize_active = true;
+		dev_dbg(mds->cxlds.dev, "sanitize issued\n");
+	} else
+		rc = -EBUSY;
+	mutex_unlock(&mds->mbox_mutex);
+
+	return rc;
 }
 
 static int mock_secure_erase(struct cxl_mockmem_data *mdata,
@@ -1419,6 +1452,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	mds->mbox_send = cxl_mock_mbox_send;
 	mds->payload_size = SZ_4K;
 	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
+	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
 
 	cxlds = &mds->cxlds;
 	cxlds->serial = pdev->id;
@@ -1458,6 +1492,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
+	if (rc)
+		return rc;
+
 	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
 
 	return 0;
@@ -1526,10 +1564,38 @@ static ssize_t fw_buf_checksum_show(struct device *dev,
 
 static DEVICE_ATTR_RO(fw_buf_checksum);
 
+static ssize_t sanitize_timeout_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%lu\n", mdata->sanitize_timeout);
+}
+
+static ssize_t sanitize_timeout_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
+	unsigned long val;
+	int rc;
+
+	rc = kstrtoul(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	mdata->sanitize_timeout = val;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(sanitize_timeout);
+
 static struct attribute *cxl_mock_mem_attrs[] = {
 	&dev_attr_security_lock.attr,
 	&dev_attr_event_trigger.attr,
 	&dev_attr_fw_buf_checksum.attr,
+	&dev_attr_sanitize_timeout.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cxl_mock_mem);

