Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C10C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Nov 2022 21:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiKPVTE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiKPVTD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Nov 2022 16:19:03 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0093058BF4
        for <linux-cxl@vger.kernel.org>; Wed, 16 Nov 2022 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668633542; x=1700169542;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5rCSuA4+TK1hg8JkyQfTYnwSBA9AViDOvngw6qL/Tyo=;
  b=AAGWZFBPcU5Gq/LVjgkTM6LNZOaoFx9XUKM4mAKci5bX+iQgCl69jiCq
   C4CZToYPn7f7PR9k7K2NJK8Z76f1sDZPBkLZDlKepDSYXEPpwWazXEiyk
   5SznVCxDbJCP/oNjZuzZlkmctGNMhDZI0WBUIM8GCbibXGyjinfDuCps9
   /lTIS3dHWmrfqZD+R09JKi4dCFHhi02AZl6tRR1iUavqnz99YAOHgMU/J
   5gG3jPziYgWkpJq9CGkmpWpJr8ducJUOgNQnObeTc1BO6xR/gI56S/cRn
   Pgyuqg+xkiwc+FG5eTXOaGVig1397j1PWQkencGc+PHtR24jbD6Gu1Ube
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="314487774"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="314487774"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:19:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617330389"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="617330389"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:19:01 -0800
Subject: [PATCH v5 13/18] nvdimm/cxl/pmem: Add support for master passphrase
 disable security command
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        benjamin.cheatham@amd.com
Date:   Wed, 16 Nov 2022 14:19:00 -0700
Message-ID: <166863354077.80269.5491644530593312361.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
References: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The original nvdimm_security_ops ->disable() only supports user passphrase
for security disable. The CXL spec introduced the disabling of master
passphrase. Add a ->disable_master() callback to support this new operation
and leaving the old ->disable() mechanism alone. A "disable_master" command
is added for the sysfs attribute in order to allow command to be issued
from userspace. ndctl will need enabling in order to utilize this new
operation.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/security.c    |   21 ++++++++++++++++++---
 drivers/nvdimm/security.c |   33 ++++++++++++++++++++++++++-------
 include/linux/libnvdimm.h |    2 ++
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index 631a474939d6..13d591c64848 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -71,8 +71,9 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
 	return rc;
 }
 
-static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
-				     const struct nvdimm_key_data *key_data)
+static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
+				       const struct nvdimm_key_data *key_data,
+				       enum nvdimm_passphrase_type ptype)
 {
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
@@ -88,7 +89,8 @@ static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
 	 * will only support disable of user passphrase. The disable master passphrase
 	 * ability will need to be added as a new callback.
 	 */
-	dis_pass.type = CXL_PMEM_SEC_PASS_USER;
+	dis_pass.type = ptype == NVDIMM_MASTER ?
+		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
 	memcpy(dis_pass.pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_DISABLE_PASSPHRASE,
@@ -96,6 +98,18 @@ static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
 	return rc;
 }
 
+static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
+				     const struct nvdimm_key_data *key_data)
+{
+	return __cxl_pmem_security_disable(nvdimm, key_data, NVDIMM_USER);
+}
+
+static int cxl_pmem_security_disable_master(struct nvdimm *nvdimm,
+					    const struct nvdimm_key_data *key_data)
+{
+	return __cxl_pmem_security_disable(nvdimm, key_data, NVDIMM_MASTER);
+}
+
 static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
 {
 	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
@@ -163,6 +177,7 @@ static const struct nvdimm_security_ops __cxl_security_ops = {
 	.freeze = cxl_pmem_security_freeze,
 	.unlock = cxl_pmem_security_unlock,
 	.erase = cxl_pmem_security_passphrase_erase,
+	.disable_master = cxl_pmem_security_disable_master,
 };
 
 const struct nvdimm_security_ops *cxl_security_ops = &__cxl_security_ops;
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 8aefb60c42ff..92af4c3ca0d3 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -239,7 +239,8 @@ static int check_security_state(struct nvdimm *nvdimm)
 	return 0;
 }
 
-static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
+static int security_disable(struct nvdimm *nvdimm, unsigned int keyid,
+			    enum nvdimm_passphrase_type pass_type)
 {
 	struct device *dev = &nvdimm->dev;
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
@@ -250,8 +251,13 @@ static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
 
-	if (!nvdimm->sec.ops || !nvdimm->sec.ops->disable
-			|| !nvdimm->sec.flags)
+	if (!nvdimm->sec.ops || !nvdimm->sec.flags)
+		return -EOPNOTSUPP;
+
+	if (pass_type == NVDIMM_USER && !nvdimm->sec.ops->disable)
+		return -EOPNOTSUPP;
+
+	if (pass_type == NVDIMM_MASTER && !nvdimm->sec.ops->disable_master)
 		return -EOPNOTSUPP;
 
 	rc = check_security_state(nvdimm);
@@ -263,12 +269,21 @@ static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
 	if (!data)
 		return -ENOKEY;
 
-	rc = nvdimm->sec.ops->disable(nvdimm, data);
-	dev_dbg(dev, "key: %d disable: %s\n", key_serial(key),
+	if (pass_type == NVDIMM_MASTER) {
+		rc = nvdimm->sec.ops->disable_master(nvdimm, data);
+		dev_dbg(dev, "key: %d disable_master: %s\n", key_serial(key),
 			rc == 0 ? "success" : "fail");
+	} else {
+		rc = nvdimm->sec.ops->disable(nvdimm, data);
+		dev_dbg(dev, "key: %d disable: %s\n", key_serial(key),
+			rc == 0 ? "success" : "fail");
+	}
 
 	nvdimm_put_key(key);
-	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
+	if (pass_type == NVDIMM_MASTER)
+		nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
+	else
+		nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
 	return rc;
 }
 
@@ -473,6 +488,7 @@ void nvdimm_security_overwrite_query(struct work_struct *work)
 #define OPS							\
 	C( OP_FREEZE,		"freeze",		1),	\
 	C( OP_DISABLE,		"disable",		2),	\
+	C( OP_DISABLE_MASTER,	"disable_master",	2),	\
 	C( OP_UPDATE,		"update",		3),	\
 	C( OP_ERASE,		"erase",		2),	\
 	C( OP_OVERWRITE,	"overwrite",		2),	\
@@ -524,7 +540,10 @@ ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
 		rc = nvdimm_security_freeze(nvdimm);
 	} else if (i == OP_DISABLE) {
 		dev_dbg(dev, "disable %u\n", key);
-		rc = security_disable(nvdimm, key);
+		rc = security_disable(nvdimm, key, NVDIMM_USER);
+	} else if (i == OP_DISABLE_MASTER) {
+		dev_dbg(dev, "disable_master %u\n", key);
+		rc = security_disable(nvdimm, key, NVDIMM_MASTER);
 	} else if (i == OP_UPDATE || i == OP_MASTER_UPDATE) {
 		dev_dbg(dev, "%s %u %u\n", ops[i].name, key, newkey);
 		rc = security_update(nvdimm, key, newkey, i == OP_UPDATE
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index c74acfa1a3fe..3bf658a74ccb 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -183,6 +183,8 @@ struct nvdimm_security_ops {
 	int (*overwrite)(struct nvdimm *nvdimm,
 			const struct nvdimm_key_data *key_data);
 	int (*query_overwrite)(struct nvdimm *nvdimm);
+	int (*disable_master)(struct nvdimm *nvdimm,
+			      const struct nvdimm_key_data *key_data);
 };
 
 enum nvdimm_fwa_state {


