Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B275AC433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 05:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B64F61132
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 05:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245351AbhIIFNG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Sep 2021 01:13:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:15274 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350499AbhIIFNC (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 9 Sep 2021 01:13:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220360426"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="220360426"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 22:11:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="449748458"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 22:11:53 -0700
Subject: [PATCH v4 04/21] libnvdimm/labels: Fix kernel-doc for label.h
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, nvdimm@lists.linux.dev,
        ben.widawsky@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Wed, 08 Sep 2021 22:11:53 -0700
Message-ID: <163116431381.2460985.6990754901097922099.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Clean up existing kernel-doc warnings before adding new CXL label data
structures.

drivers/nvdimm/label.h:66: warning: Function parameter or member 'labelsize' not described in 'nd_namespace_index'
drivers/nvdimm/label.h:66: warning: Function parameter or member 'free' not described in 'nd_namespace_index'
drivers/nvdimm/label.h:103: warning: Function parameter or member 'align' not described in 'nd_namespace_label'
drivers/nvdimm/label.h:103: warning: Function parameter or member 'reserved' not described in 'nd_namespace_label'
drivers/nvdimm/label.h:103: warning: Function parameter or member 'type_guid' not described in 'nd_namespace_label'
drivers/nvdimm/label.h:103: warning: Function parameter or member 'abstraction_guid' not described in 'nd_namespace_label'
drivers/nvdimm/label.h:103: warning: Function parameter or member 'reserved2' not described in 'nd_namespace_label'
drivers/nvdimm/label.h:103: warning: Function parameter or member 'checksum' not described in 'nd_namespace_label'

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/label.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index 31f94fad7b92..7fa757d47846 100644
--- a/drivers/nvdimm/label.h
+++ b/drivers/nvdimm/label.h
@@ -34,6 +34,7 @@ enum {
  * struct nd_namespace_index - label set superblock
  * @sig: NAMESPACE_INDEX\0
  * @flags: placeholder
+ * @labelsize: log2 size (v1 labels 128 bytes v2 labels 256 bytes)
  * @seq: sequence number for this index
  * @myoff: offset of this index in label area
  * @mysize: size of this index struct
@@ -43,7 +44,7 @@ enum {
  * @major: label area major version
  * @minor: label area minor version
  * @checksum: fletcher64 of all fields
- * @free[0]: bitmap, nlabel bits
+ * @free: bitmap, nlabel bits
  *
  * The size of free[] is rounded up so the total struct size is a
  * multiple of NSINDEX_ALIGN bytes.  Any bits this allocates beyond
@@ -77,7 +78,12 @@ struct nd_namespace_index {
  * @dpa: DPA of NVM range on this DIMM
  * @rawsize: size of namespace
  * @slot: slot of this label in label area
- * @unused: must be zero
+ * @align: physical address alignment of the namespace
+ * @reserved: reserved
+ * @type_guid: copy of struct acpi_nfit_system_address.range_guid
+ * @abstraction_guid: personality id (btt, btt2, fsdax, devdax....)
+ * @reserved2: reserved
+ * @checksum: fletcher64 sum of this object
  */
 struct nd_namespace_label {
 	u8 uuid[NSLABEL_UUID_LEN];

