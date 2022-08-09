Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA65C19F2D
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 21:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiHIVrJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 17:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiHIVqj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 17:46:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A84B6BD4A
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660081598; x=1691617598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IcWmQxj6W9WB2xCBSLx+HRE3TtVwUllfQQwCFgcQTeU=;
  b=ntt1VbbLfkZV9ja0NicJnsten6ZYheQIRYICRdXefbJGFpr0/ClSB+HE
   1mUVzCJUToNlv3uNczNQGzLe+QHG+1OY0y0Fa+p5MfkrTewO8AueERkCS
   RnRmpwrvJkWOJlO6PWmfNSFXAWKzCwPTkmm2Gn1COwJiTdZLSz/Ly2AlY
   plvZz+EYLWGTumza46ECM37Y2P8xbFCzODY/0zXI0ic/66bdf/8uw9EjX
   7BlmWRS5C9iQeoEaAaZmYWBiqPKoiB3Ff+yVdeMicufdofB161shN1Ux+
   uCoFrNoP8lCPa3nBIejHmbdAOZNQC5CiVemYBC+v1GTiP0aRh4+DtDi9G
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="288506936"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="288506936"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 14:46:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="664607920"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 14:46:31 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 0/2] CXL XOR Interleave Arithmetic
Date:   Tue,  9 Aug 2022 14:44:08 -0700
Message-Id: <cover.1660079951.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

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
 drivers/cxl/acpi.c    | 96 ++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 106 insertions(+), 6 deletions(-)


base-commit: 1cd8a2537eb07751d405ab7e2223f20338a90506
-- 
2.31.1

