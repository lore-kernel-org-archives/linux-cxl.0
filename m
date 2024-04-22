Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DC18AED
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820708; cv=none; b=DOjj+qwa5OF299LrCPOO44piciaSpcPL63omzo/N4cLgDj1CSdHzYiuERCS/vKwioG5RCoTsP/LgjCZpB4HD6fwmGESqlkjBQZ7VyJx+9eyiAXe5AfQMaY3ENIGfQVjssY6FT3tGNBDfZxyn+rixNDako56LsBS1iFu8CGnwhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820708; c=relaxed/simple;
	bh=4COJo8pl+nwcujvfUx/hMgNO9Nqo+49jbluKuucKtPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwMG8NfPH37Qnkm2mLw1979p36WZ0AXYvbOpLGZHshtvlWvOnMJ9ccXB4taTKP7Zw1/nkWGnYuJp5HAXLm8pYGcitivh0lvFVVBnROfgTXmYE5r2SLvzor65nnUrcZO9TK8N66UfO6JGD37DHzrJUWl+uTBGtJWqETwyd+0S7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FAFC113CC;
	Mon, 22 Apr 2024 21:18:28 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: vishal.l.verma@intel.com,
	Dan Williams <dan.j.williams@intel.com>
Subject: [NDCTL PATCH v3] ndctl: cxl: Remove dependency for attributes derived from IDENTIFY command
Date: Mon, 22 Apr 2024 14:17:55 -0700
Message-ID: <20240422211755.417632-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A memdev may optionally not host a mailbox and therefore not able to execute
the IDENTIFY command. Currently the kernel emits empty strings for some of
the attributes instead of making them invisible in order to keep backward
compatibility for CXL CLI. Remove dependency of CXL CLI on the existance of
these attributes and only expose them if they exist. Without the dependency
the kernel will be able to make the non-existant attributes invisible.

Link: https://lore.kernel.org/all/20230606121534.00003870@Huawei.com/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Check against SIZE_MAX (Vishal)
---
 cxl/lib/libcxl.c | 48 ++++++++++++++++++++++++++----------------------
 cxl/memdev.c     | 18 +++++++++++++-----
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index 91725ac7ffd8..91eedd1c4688 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1280,14 +1280,12 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	memdev->minor = minor(st.st_rdev);
 
 	sprintf(path, "%s/pmem/size", cxlmem_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		goto err_read;
-	memdev->pmem_size = strtoull(buf, NULL, 0);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		memdev->pmem_size = strtoull(buf, NULL, 0);
 
 	sprintf(path, "%s/ram/size", cxlmem_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		goto err_read;
-	memdev->ram_size = strtoull(buf, NULL, 0);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		memdev->ram_size = strtoull(buf, NULL, 0);
 
 	sprintf(path, "%s/pmem/qos_class", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
@@ -1302,18 +1300,22 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 		memdev->ram_qos_class = atoi(buf);
 
 	sprintf(path, "%s/payload_max", cxlmem_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		goto err_read;
-	memdev->payload_max = strtoull(buf, NULL, 0);
-	if (memdev->payload_max < 0)
-		goto err_read;
+	if (sysfs_read_attr(ctx, path, buf) == 0) {
+		memdev->payload_max = strtoull(buf, NULL, 0);
+		if (memdev->payload_max < 0)
+			goto err_read;
+	} else {
+		memdev->payload_max = -1;
+	}
 
 	sprintf(path, "%s/label_storage_size", cxlmem_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		goto err_read;
-	memdev->lsa_size = strtoull(buf, NULL, 0);
-	if (memdev->lsa_size == ULLONG_MAX)
-		goto err_read;
+	if (sysfs_read_attr(ctx, path, buf) == 0) {
+		memdev->lsa_size = strtoull(buf, NULL, 0);
+		if (memdev->lsa_size == ULLONG_MAX)
+			goto err_read;
+	} else {
+		memdev->lsa_size = SIZE_MAX;
+	}
 
 	sprintf(path, "%s/serial", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
@@ -1340,12 +1342,11 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	host[0] = '\0';
 
 	sprintf(path, "%s/firmware_version", cxlmem_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		goto err_read;
-
-	memdev->firmware_version = strdup(buf);
-	if (!memdev->firmware_version)
-		goto err_read;
+	if (sysfs_read_attr(ctx, path, buf) == 0) {
+		memdev->firmware_version = strdup(buf);
+		if (!memdev->firmware_version)
+			goto err_read;
+	}
 
 	memdev->dev_buf = calloc(1, strlen(cxlmem_base) + 50);
 	if (!memdev->dev_buf)
@@ -4570,6 +4571,9 @@ static int lsa_op(struct cxl_memdev *memdev, int op, void *buf,
 	if (length == 0)
 		return 0;
 
+	if (memdev->payload_max < 0)
+		return -EINVAL;
+
 	label_iter_max = memdev->payload_max - sizeof(struct cxl_cmd_set_lsa);
 	while (remaining) {
 		cur_len = min((size_t)label_iter_max, remaining);
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 35920fc81d66..6e44d1578d03 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -487,10 +487,13 @@ static int action_zero(struct cxl_memdev *memdev, struct action_context *actx)
 	size_t size;
 	int rc;
 
-	if (param.len)
+	if (param.len) {
 		size = param.len;
-	else
+	} else {
 		size = cxl_memdev_get_label_size(memdev);
+		if (size == SIZE_MAX)
+			return -EINVAL;
+	}
 
 	if (cxl_memdev_nvdimm_bridge_active(memdev)) {
 		log_err(&ml,
@@ -523,6 +526,9 @@ static int action_write(struct cxl_memdev *memdev, struct action_context *actx)
 	if (!size) {
 		size_t label_size = cxl_memdev_get_label_size(memdev);
 
+		if (label_size == SIZE_MAX)
+			return -EINVAL;
+
 		fseek(actx->f_in, 0L, SEEK_END);
 		size = ftell(actx->f_in);
 		fseek(actx->f_in, 0L, SEEK_SET);
@@ -561,11 +567,13 @@ static int action_read(struct cxl_memdev *memdev, struct action_context *actx)
 	char *buf;
 	int rc;
 
-	if (param.len)
+	if (param.len) {
 		size = param.len;
-	else
+	} else {
 		size = cxl_memdev_get_label_size(memdev);
-
+		if (size == SIZE_MAX)
+			return -EINVAL;
+	}
 	buf = calloc(1, size);
 	if (!buf)
 		return -ENOMEM;
-- 
2.44.0

