Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACAFC25B0E
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Aug 2022 18:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiHPSPx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHPSPw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Aug 2022 14:15:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD45381B3B
        for <linux-cxl@vger.kernel.org>; Tue, 16 Aug 2022 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660673751; x=1692209751;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L2Yb34y4oly8bfP4jUQu+gHiBYbzNLpPb/9QGQX1udQ=;
  b=KaGGbquM630HzL4Hf6BS53mEsbLIPmO5eTRQ5o7N+Wx2SxjJLaa+0zJb
   PLJmsnvPbXQO1Kb94qLvOk7eDYq5K7cZoiWFsHK80wAtOqk3vR02C4StX
   h8LZdom4Nm1o+0vcGAAq4+4a9RF0ZYwjH1D+QuxQL6XdE3mWOgikup8uG
   x0r2mn+ypyeYAG0HrUx97aVMb9nEZwA0/SjzVxmBrl3snC5myRxVvZ7qP
   QdkPBT+6KSgRsS9asahsUI0giU4Qe+RkL+cgh8b/oKVijkhgO7Agsn4yW
   wPYjfp4gwNuBT1aDYbuuw6TbtS0NB5Hx/cfGsxvVFPeqtWsbZlTeo45iz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="354039462"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="354039462"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 11:15:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="557803104"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 11:15:51 -0700
Subject: [PATCH 1/2] cxl: export interleave address mask as port sysfs
 attribute
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Tue, 16 Aug 2022 11:15:51 -0700
Message-ID: <166067375099.1614719.8244364251253955254.stgit@djiang5-desk4.jf.intel.com>
In-Reply-To: <62f5c76060f1f_3ce6829494@dwillia2-xfh.jf.intel.com.notmuch>
References: <62f5c76060f1f_3ce6829494@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Export the interleave address mask as a sysfs attribute for a port. The
interleave address mask is created based off the CXL HDM Decoder Capability
Register (CXL spec v3 8.2.4.19.1) and sets the bits indicated by th "A11to8
Interleave Capable" bit and the "A14to12 Interleave Capable" bit. It
indicates the decoder supports interleaveing based on those address bits.
The exported sysfs attribute will help user region creation to do more valid
configuration checking.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/port.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5453771bf330..e3e93e1b663e 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -123,8 +123,30 @@ static struct attribute_group cxl_cdat_attribute_group = {
 	.is_bin_visible = cxl_port_bin_attr_is_visible,
 };
 
+static ssize_t interleave_mask_show(struct device *dev, struct device_attribute *attr,
+				     char *buf)
+{
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(dev);
+
+	if (!cxlhdm)
+		return 0;
+
+	return sysfs_emit(buf, "%#x\n", cxlhdm->interleave_mask);
+}
+static DEVICE_ATTR_RO(interleave_mask);
+
+static struct attribute *cxl_port_info_attributes[] = {
+	&dev_attr_interleave_mask.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_port_info_attribute_group = {
+	.attrs = cxl_port_info_attributes,
+};
+
 static const struct attribute_group *cxl_port_attribute_groups[] = {
 	&cxl_cdat_attribute_group,
+	&cxl_port_info_attribute_group,
 	NULL,
 };
 


