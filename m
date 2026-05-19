Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9543E2AB1
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224529; cv=none; b=qd28a/4+Agy7M4HSY1KocxjXkZXSfNKIENBhRkcZiOZmnGRzbiYMY9zMeBAf9jfMJcdv4z6sNm2GPLvpQDvxGOettqDwbDvI269u/SB8WMW+vrJCLDU38re//4dv5vxWKfpElkfRC17/xUmbbxHgktx4bYYZwLa6qLwapWUw/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224529; c=relaxed/simple;
	bh=XAQeoIDCBHB3XJ82IKlxaF77Um/eQJaIStReXE53XFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBFst2INdO3dMSD3oflrrPlHpSHNQtakvy+q0ZPgSSoawJJREzYhg4dWac6lGXkO3DFfIb2R1WUh830815QokfNUtDAiLAYuswh0QqZC6qsEBpV3M0EYs1yLhcb50G3FcHsACfsMS2MgRDb44vPF7hfEYIKIij6ATBG6oAdDaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IItukBoB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IItukBoB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5CF1F00896;
	Tue, 19 May 2026 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224528;
	bh=Boota40ZaejiEjbwepx2APO6M1fQHkzt0JR8S/et2Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IItukBoBFl37I4nsDVZTGu1RiHcwe6sZqHF6iYMH1GkqqsxYesuZzcLk0TUHEieyX
	 F6S7dpXfyIyZnouppDL6faiRqZgoD6PtGEM9UQTA1dNpZMJ7xVz8iV5zF2c6D8/K/s
	 mIPS2VIne3zbSUq6sImclYlhM0W1JXBAxHPeeP/kHHOknM+2RTNoAT/6/8VKr3IzQT
	 6OKWlotvFdUfWw7rqfarQl8f22dJMvoRbRadwgrFd5+QfIKkI4k3pmRnePsP4p9NRh
	 xLg1Cfe2dKXVouys4CW1zIMY0nm1JJBVHmMXPpnchN55/7APm+bQlsSnWhH1UqDoww
	 WyTOTP40lKPNg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6CDB3F40075;
	Tue, 19 May 2026 17:02:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 19 May 2026 17:02:07 -0400
X-ME-Sender: <xms:z88MauaImQJTKt0YxIiKpy6z2r6AdzsjQenxV-Hvgwz8aUCd_cLlNg>
    <xme:z88MalEv16s8GmJGJMo9z6P0hikeSOfkL3AF4MBbwCXjqzR2uC4E2OA1pl_eozAnf
    NOwkj_AXK9QBR6y69Ni09_gVrjEQekMlmMv04ls8cEOCJS_CnNNYGU>
X-ME-Received: <xmr:z88MaixGkaSgXd_c_rL8Oo6Cp98qWyH7LIPTJbUuyg-d-zkHl7l7LwqyHvsM_gPwuq_dHnF4mJHTQEVSuwr2pY5swsXM1peJOfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeffrghnucghihhllhhirghmshcuoegujhgsfieskhgvrhhnvghl
    rdhorhhgqeenucggtffrrghtthgvrhhnpeeuheffhfelleelgedutdfhleefjeejvedtke
    fgjeefgfettdeljeefvefhueeiveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegujhgsfidomhgvshhmthhprghuthhhphgvrhhsohhnrghlih
    hthidqudejjedvfedtgeehhedqfeeffeelgedtgeejqdgujhgsfieppehkvghrnhgvlhdr
    ohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepuggrvhgvrdhjihgrnhhgsehinhhtvghlrdgtohhmpdhrtg
    hpthhtoheprghlvghjrghnughrohdrlhhutggvrhhoqdhprghlrghusegrmhgurdgtohhm
    pdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghluh
    gtvghrohhpsegrmhgurdgtohhmpdhrtghpthhtohepughjsgifsehkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:z88MannYY1PXExhf7m3hd3uSlE7HzoNqz6a079wuL7NuNvtodFdeWg>
    <xmx:z88MarmwARpieqAqqowIKJCWEu66sV6YtG9IXO5F9UU3MubKSVSn0g>
    <xmx:z88MapyTOn9uKxmtVXnA9M2J5tMg4eKlziqH9F1kVK61jTm2GgaGUw>
    <xmx:z88Magp4ZzbzSaKFOIAKKEjovTOw7iEaRgHkK7W_XpJfqZw5EUHF-w>
    <xmx:z88Mao4c7XPIkgP4Jv-r7MdeMoHOeWfMj1tomYggepSWmIAe5oCRkeSU>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 17:02:06 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com,
	alejandro.lucero-palau@amd.com,
	jic23@kernel.org,
	Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH 4/5] cxl/memdev: Introduce cxl_class_memdev_type
Date: Tue, 19 May 2026 14:01:57 -0700
Message-ID: <20260519210158.1499795-5-djbw@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519210158.1499795-1-djbw@kernel.org>
References: <20260519210158.1499795-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for memdev's without mailbox related infrastructure,
introduce cxl_class_memdev_type as a superset of a cxl_memdev_type.
Effectively the only difference is that cxl_class_memdev_type exports
common sysfs attributes where cxl_memdev_type has none.

Related to this is all the cxl_mem_probe() paths that assume the presence
of a class device mailbox are updated to skip that requirement.

Co-developed-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 drivers/cxl/core/memdev.c | 16 +++++++++++---
 drivers/cxl/mem.c         | 45 +++++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 91c99eeea92c..33a3d2e7b13a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -574,16 +574,23 @@ void cxl_memdev_update_perf(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_perf, "CXL");
 
-static const struct device_type cxl_memdev_type = {
+static const struct device_type cxl_class_memdev_type = {
 	.name = "cxl_memdev",
 	.release = cxl_memdev_release,
 	.devnode = cxl_memdev_devnode,
 	.groups = cxl_memdev_attribute_groups,
 };
 
+static const struct device_type cxl_memdev_type = {
+	.name = "cxl_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+};
+
 bool is_cxl_memdev(const struct device *dev)
 {
-	return dev->type == &cxl_memdev_type;
+	return (dev->type == &cxl_class_memdev_type ||
+		dev->type == &cxl_memdev_type);
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
@@ -712,7 +719,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->parent = get_device(cxlds->dev);
 	dev->bus = &cxl_bus_type;
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
-	dev->type = &cxl_memdev_type;
+	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
+		dev->type = &cxl_memdev_type;
+	else
+		dev->type = &cxl_class_memdev_type;
 	device_set_pm_not_required(dev);
 	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index fcffe24dcb42..ff858318091f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -65,6 +65,26 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_debugfs_poison_clear, "%llx\n");
 
+static void cxl_memdev_poison_enable(struct cxl_memdev_state *mds,
+				     struct cxl_memdev *cxlmd,
+				     struct dentry *dentry)
+{
+	/*
+	 * Avoid poison debugfs for DEVMEM aka accelerators as they rely on
+	 * cxl_memdev_state.
+	 */
+	if (!mds)
+		return;
+
+	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_inject_fops);
+
+	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+				    &cxl_poison_clear_fops);
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -92,12 +112,7 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	cxl_memdev_poison_enable(mds, cxlmd, dentry);
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -206,16 +221,24 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_poison_list);
 
-static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+static bool cxl_poison_attr_visible(struct kobject *kobj, struct attribute *a)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
-	if (a == &dev_attr_trigger_poison_list.attr)
-		if (!test_bit(CXL_POISON_ENABLED_LIST,
-			      mds->poison.enabled_cmds))
-			return 0;
+	if (!mds ||
+	    !test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
+		return false;
+
+	return true;
+}
+
+static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	if (a == &dev_attr_trigger_poison_list.attr &&
+	    !cxl_poison_attr_visible(kobj, a))
+		return 0;
 
 	return a->mode;
 }
-- 
2.53.0

