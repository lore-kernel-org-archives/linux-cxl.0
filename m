Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806C0ECAA24
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Aug 2022 16:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbiHYQKO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241072AbiHYQKN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 Aug 2022 12:10:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C3CE11
        for <linux-cxl@vger.kernel.org>; Thu, 25 Aug 2022 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661443812; x=1692979812;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n7s4QvRWLEp7QXMJUGXcz/kCCPoUkloZTOlE+KDhw9U=;
  b=BtuthD4dviIJmWINlt+qRflN552rK3ZfAcogJ1uZCI7dT+2fwxEm+6wA
   OKlDHBdVAsQyGk4+IzqD68vCAU3azspTHCSCR9YU6c8GO5eZ4wDF/LcaM
   BKHZ9cv1riov1rMYU68ln/uMo/TKT9SUeQX7AoEEC8UJsdyn2fdJJx8HD
   JCuQHqt8421bQ5toPEevmkeeSuwKkoYy+MKTR8sy+tAdCUWeo1cuCwcGC
   qRjWrHZkVHh/yzJNIgz9XtekBQJ5H4KdT0U21oY5dWdqapKIxb7e14cWb
   UiGD3LhXFGgHJSSd9ISI5gXhkULuvSlLSci0S3hGIxdmoOkOjRd/62K0r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320363062"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="320363062"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:07:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="713555716"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:07:58 -0700
Subject: [PATCH v5 4/6] cxl: change cxl_port_attribute_groups naming to avoid
 confusion
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 25 Aug 2022 09:07:58 -0700
Message-ID: <166144367858.745916.5617777347082312832.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
References: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Both cxl/port.c and cxl/core/port.c have cxl_port_attribute_groups. Change
cxl_port_attribute_groups in cxl/port.c to cxl_port_dynamic_attr_groups in
order to avoid confusion.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/port.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5453771bf330..c4aa073b7e31 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -123,7 +123,7 @@ static struct attribute_group cxl_cdat_attribute_group = {
 	.is_bin_visible = cxl_port_bin_attr_is_visible,
 };
 
-static const struct attribute_group *cxl_port_attribute_groups[] = {
+static const struct attribute_group *cxl_port_dynamic_attr_groups[] = {
 	&cxl_cdat_attribute_group,
 	NULL,
 };
@@ -133,7 +133,7 @@ static struct cxl_driver cxl_port_driver = {
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
 	.drv = {
-		.dev_groups = cxl_port_attribute_groups,
+		.dev_groups = cxl_port_dynamic_attr_groups,
 	},
 };
 


