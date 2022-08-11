Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604ABC19F2A
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 20:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiHKUvk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiHKUvj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 16:51:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F081695
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660251098; x=1691787098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O/y0zrFMBYAr7Rt1Bex+sTF9rwxtD28pH056x5O0AZ0=;
  b=c31XD4vtOyNWT+FGJX+hB/fxfQVU1vqiSjEiMQBzENjeV2L/M7eeFRrK
   3f6sfdPVJh/PngSiJGqWpBEMf13s3WHFssnSaGO28h0ISBa3vxwITn0H3
   hGgG4qVkRCiF8x7rzAjRs9S+vYEjTNfJy2EjBWTGbM75qn+I2z/soia+X
   YjzzNHFXrUvgXpMGsO8Uxpm3qBqH5baonBqpMCSDJhcBbmJUG6TDmviy6
   MDxycO3U3qQrbidZB70ba3+G2wLHqzCmVBRK4GL5jTdBqTJkYvsh4gLr/
   xvFSwKwiTL57AmYQyLLPMfO5CxGr2KocbZOmMpWZk7s7/O/ZdbAIbEHFZ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292253072"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="292253072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:51:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="708764629"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:51:37 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/2] CXL XOR Interleave Arithmetic
Date:   Thu, 11 Aug 2022 13:49:10 -0700
Message-Id: <cover.1660250360.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes in v2:
- Use ilog2() of the decoded interleave ways to determine number
of xormaps, instead of using encoded ways directly. This fixes
3, 6, and 12 way interleaves. (Dan)


Add support for the new 'XOR' Interleave Arithmetic as defined
in the CXL 3.0 Specification [1].

A linux-ized ACPI patch is included here for reference. The actual
pull request is pending at https://github.com/acpica/acpica/pull/787

[1]: https://www.computeexpresslink.org/download-the-specification


Alison Schofield (2):
  For ACPICA: Add the CXIMS structure definition to the CEDT table
  cxl/acpi: Support CXL XOR Interleave Math (CXIMS)

 include/acpi/actbl1.h | 14 ++++++-
 drivers/cxl/cxl.h     |  2 +
 drivers/cxl/acpi.c    | 94 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 104 insertions(+), 6 deletions(-)


base-commit: 1cd8a2537eb07751d405ab7e2223f20338a90506
-- 
2.31.1

