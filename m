Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B74C2B9F4
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 22:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D55361375
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 22:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhFQWSr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 18:18:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:38815 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231985AbhFQWSq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 18:18:46 -0400
IronPort-SDR: jnHTVNkVzSOJBsibj770TEc5KQZWytzy7DZZvrsNLzIbwkir3rZa+azQV0BhnWHHInVHF5zfX3
 H43qwxl+ohlg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="186151367"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="186151367"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 15:16:38 -0700
IronPort-SDR: nkcQT5dBkYf8rfMZZB4yFXuvIA8HEyqjgLQDET3vSRiyafqo9Ip2WTMgru2SsFA+e0abZj7PQ+
 okjGL4qk5VLA==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="622182863"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 15:16:37 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH V2 0/3] Query and use Partition Info
Date:   Thu, 17 Jun 2021 15:16:17 -0700
Message-Id: <20210617221620.1904031-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Three small patches which query and use Partition Info.  Specifically this
correctly accounts for partitionable space should a device support it.

Changes for V2:
	Feed back from Ben, Dan, and Jonathan
	Remove sysfs patch in favor of using ndctl to query values in the
	future.
	Add patch to create the correct ram/pmem range entries per the spec.

Ira Weiny (3):
  cxl/pci: Store memory capacity values
  cxl/mem: Account for partitionable space in ram/pmem ranges
  cxl/mem: Adjust ram/pmem range to represent DPA ranges

 drivers/cxl/mem.h |   9 ++++
 drivers/cxl/pci.c | 134 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 134 insertions(+), 9 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

