Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C056C4332F
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 00:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKDAbE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 20:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKDAbD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 20:31:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859822B2E
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 17:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667521862; x=1699057862;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QDJ8IrHIuM4ehXzADp5KlaQhWKqCayOWZCrsPYJYhjM=;
  b=ie2uQCYei4RqJlAK0qZ/8ifT4ULNB+0mscA9S+t2BpSe8JEHC8ULGvsM
   sGZy6gzqbMZi3/VMLOA/yjrYg3aHhtSHflHjGnwwdmn3RfWw9E8ng24z4
   1pc9BKtC649sVWNJDDH8hdsGNde4RE37mXEP6OIiY9+jEtrGA9Q28INwV
   UOsQYKpKeAL+a6bCp+nVT5qY4hpM0fmRwV7QNof0oTS0RfzLcPdv8KhK5
   NZUhV5D/GsiPn8y4crrTDVxPgoG0R5GFbzvJQm/cDSbHeFWbHOGEEmTpo
   xo7neBVsDJ86tb5k3nCVAjUnXSocD1Efqs53XfFDYawiLhGPJ/ykvU1G0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="293165327"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="293165327"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 17:31:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="964151895"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="964151895"
Received: from arunvasu-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.53.48])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 17:31:01 -0700
Subject: [PATCH 7/7] cxl/region: Recycle region ids
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        dave.jiang@intel.com
Date:   Thu, 03 Nov 2022 17:31:00 -0700
Message-ID: <166752186062.947915.13200195701224993317.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
References: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

At region creation time the next region-id is atomically cached so that
there is predictability of region device names. If that region is
destroyed and then a new one is created the region id increments. That
ends up looking like a memory leak, or is otherwise surprising that
identifiers roll forward even after destroying all previously created
regions.

Try to reuse rather than free old region ids at region release time.

While this fixes a cosmetic issue, the needlessly advancing memory
region-id gives the appearance of a memory leak, hence the "Fixes" tag,
but no "Cc: stable" tag.

Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c0253de74945..f9ae5ad284ff 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1534,9 +1534,24 @@ static const struct attribute_group *region_groups[] = {
 
 static void cxl_region_release(struct device *dev)
 {
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
 	struct cxl_region *cxlr = to_cxl_region(dev);
+	int id = atomic_read(&cxlrd->region_id);
+
+	/*
+	 * Try to reuse the recently idled id rather than the cached
+	 * next id to prevent the region id space from increasing
+	 * unnecessarily.
+	 */
+	if (cxlr->id < id)
+		if (atomic_try_cmpxchg(&cxlrd->region_id, &id, cxlr->id)) {
+			memregion_free(id);
+			goto out;
+		}
 
 	memregion_free(cxlr->id);
+out:
+	put_device(dev->parent);
 	kfree(cxlr);
 }
 
@@ -1598,6 +1613,11 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 	device_initialize(dev);
 	lockdep_set_class(&dev->mutex, &cxl_region_key);
 	dev->parent = &cxlrd->cxlsd.cxld.dev;
+	/*
+	 * Keep root decoder pinned through cxl_region_release to fixup
+	 * region id allocations
+	 */
+	get_device(dev->parent);
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_region_type;

