Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E740C4332F
	for <linux-cxl@archiver.kernel.org>; Sat, 17 Dec 2022 01:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLQBdf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 20:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQBde (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 20:33:34 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37B73325
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 17:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671240813; x=1702776813;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cOIZLngsvqV8wDzzAmvNVtCqhVbofpyAswiK7OaTYL8=;
  b=Q6ZRty3zS4P32rfQBUHwliA+UyqOeleyk3vZfXsiR+C7wDn92Wkis+BW
   6Gjifc+1iJX2+nH8dKXaLAH2R8PTz15/sNo7pYnDdPJfSXgZVtSuvZtyr
   Z3weskN3FCHNvCPQfmkWm1M+BvDkY/0JuzyIq8Eq8MwY9SdvqVucKX6mg
   BypnVJWEGjbuExZsOLJJoWJ0+J2TYboX5BhVUjYAs01grU97zNdYd5WQY
   IU9r/ZEYvat28Se/8tacocqH8QJvvLntghPFwImQnYPGAwTCY5Ehf3hno
   +3BKownAUFMU9NmFMiEyoWmR0GkYJjDwwNLED9kmxSzdO628FDsQ3YEHq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="302513777"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="302513777"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 17:33:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="649993069"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="649993069"
Received: from smukhe4-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.110.159])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 17:33:33 -0800
Subject: [PATCH 1/3] cxl/mem: Quiet port walking warning
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Fri, 16 Dec 2022 17:33:32 -0800
Message-ID: <167124081278.1626103.4792472728150764118.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The cxl_mem driver attempts to establish, or revalidate, the cxl_port
hierarcy to attach a cxl_memdev to a CXL platform topology. There is a
natural race (on ACPI platforms) between when the cxl_mem driver
attempts to attach and when the cxl_acpi driver establishes the root of
the topology.

If cxl_mem_probe() runs first it will iterate to the top of the device
topology without finding the CXL platform root. That situation is benign
/ expected, so stop warning about it. The cxl_acpi driver will poke
cxl_mem_probe() to try again once the CXL platform root is established.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 810e60cc331c..6296d2bc909a 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1400,8 +1400,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
 		uport_dev = dport_dev->parent;
 		if (!uport_dev) {
-			dev_warn(dev, "at %s no parent for dport: %s\n",
-				 dev_name(iter), dev_name(dport_dev));
+			dev_dbg(dev, "at %s no parent for dport: %s\n",
+				dev_name(iter), dev_name(dport_dev));
 			return -ENXIO;
 		}
 

