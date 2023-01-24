Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9DFC38142
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 23:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjAXXeh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 18:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjAXXeg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 18:34:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94F9524B;
        Tue, 24 Jan 2023 15:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NsdAsF2PUF5UAK5t7f/F72faPpmR+nFRf2RtMk/vURo=; b=vypkss50JGh8cLkIxtQjDUnT27
        xd4W9Ds12rCxfuczCom8Be+38i6+lObilN1pNgg5jOyw5Y3gU6dIWCrIV4o8o1UpdLoLCEx2mKC1T
        hXQwZte/c4t36q9tNmbQIJy9S1UvH/wbeT2+ykac4qOjSvC0TkzRq1oPe8Y5TYOghwK4eh64InLfn
        EnfaXzKiitL3jmJKvil0blHuzNyocnI0SJGiNXtc+IznhCpdtKl3IlrZIPLR1dWeEwidllkIAdDLE
        ig6WutJZF9ZuT9U26q5qW/tGw3enG+43d9o49pAtHfBdzkFk8jnFcaUIWkKaIuJfnLWtJqj69lCWx
        Auv2kyOg==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKSoE-005eCD-Pf; Tue, 24 Jan 2023 23:34:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH] cxl: Kconfig: fix a spelling mistake
Date:   Tue, 24 Jan 2023 15:34:31 -0800
Message-Id: <20230124233431.21599-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Correct a spelling mistake (reported by codespell).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
---
 drivers/cxl/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -116,7 +116,7 @@ config CXL_REGION_INVALIDATION_TEST
 	depends on CXL_REGION
 	help
 	  CXL Region management and security operations potentially invalidate
-	  the content of CPU caches without notifiying those caches to
+	  the content of CPU caches without notifying those caches to
 	  invalidate the affected cachelines. The CXL Region driver attempts
 	  to invalidate caches when those events occur.  If that invalidation
 	  fails the region will fail to enable.  Reasons for cache
