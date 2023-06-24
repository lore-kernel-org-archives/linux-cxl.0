Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E201EB64D7
	for <linux-cxl@archiver.kernel.org>; Sat, 24 Jun 2023 01:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjFXBZF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jun 2023 21:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFXBZD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 23 Jun 2023 21:25:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579AE272D
        for <linux-cxl@vger.kernel.org>; Fri, 23 Jun 2023 18:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687569902; x=1719105902;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vnzm7KfU6f5c4TyX5SpEy1dkWl+v1+JJ0IxesAUf9aY=;
  b=JuFCD7V2+DEISEEPhz3djGZaG2c4I5jr0GKX+Q7XLIsn2+/OSm1F5Wfw
   bdV2YpbxWmotKVFq493pY4c4Av7KN3Fde1P934ov8sPYHkF7iY05IqYFM
   tv4NZrcZNFKpW6K3twZ9tKy7nHTYRUL0uFSY5y2HdNQR40iQX6x3glJyJ
   fvUMPiwH7l8VVlwGrjoJbmoCf/PYUY66DYje0pC3ZRZB2YtQyB0onJFl7
   Yf1lLqoQYgP9NzLkItb+LSkIsQqSp8uLiim55jOOzSFmO4TCINZ7hEL5E
   Ui1LzW8rVW68ZyyeF15nX97xBKDRGF1ED+TSTyIyiqGMN9Hfl9rV0HanL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="341241787"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="341241787"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 18:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="780767780"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="780767780"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.28.92])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 18:25:00 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 0/2] cxl/region: Improve Soft Reserved resource handling
Date:   Fri, 23 Jun 2023 18:24:55 -0700
Message-Id: <cover.1687568084.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Make the cxl/region drivers handle these 2 observed scenarios:

1) Soft reserved resources were observed as sometimes being the parent
and sometimes being the child of a region resource. Patch 1 clears up
that inconsistency.

2) Soft reserved resources were also observed as stranded after region 
teardown, making the address space the region released unavailable for
reallocation. Patch 2 implements soft reserved resource removal.


Alison Schofield (2):
  cxl/region: Try to add a region resource to a soft reserved parent
  cxl/region: Remove a soft reserved resource at region teardown

 drivers/cxl/core/region.c | 164 +++++++++++++++++++++++++++++++++++---
 1 file changed, 153 insertions(+), 11 deletions(-)


base-commit: a70fc4ed20a6118837b0aecbbf789074935f473b
-- 
2.37.3

