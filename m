Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA12C48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 00:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3DF613C3
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 00:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhFKAY0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:24:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:56891 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231266AbhFKAY0 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 10 Jun 2021 20:24:26 -0400
IronPort-SDR: qy7CKiVtHZIslj9spu84S6UqnXk4CXP2Rj5hcArecOGgZ/p5kwxf7XkaKlQClkYn4zxVVKXN7E
 DH8/TwUjYdbw==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185807212"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="185807212"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 17:22:28 -0700
IronPort-SDR: DWE0g5ohmQVuz2ieYbl45JW5lHewExB9bB0ononwCxpKGkzPfhm+nstGbdZTrcjkFRR88vPxz0
 yxIUCUFtDUTQ==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="483064881"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 17:22:27 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 0/3] Query and use Partition Info
Date:   Thu, 10 Jun 2021 17:22:21 -0700
Message-Id: <20210611002224.1594913-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Three small patches which query and report Partition Info.  In addition,
correct ram and pmem size calculations to account for potential partitioned
space.

Ira Weiny (3):
  cxl/pci: Store memory capacity values
  cxl/mem: Report correct ram/pmem size in sysfs
  cxl/mem: Add partition information to sysfs

 drivers/cxl/mem.h |   4 ++
 drivers/cxl/pci.c | 178 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 174 insertions(+), 8 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

