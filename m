Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CEEC2B9F4
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 22:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A731E610C8
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Jun 2021 22:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhFNW7A (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Jun 2021 18:59:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:17568 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231649AbhFNW67 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 14 Jun 2021 18:58:59 -0400
IronPort-SDR: i8tzZEvhyzOn4ZByW56YsXnpxF0bcr3PhVILxFjtxS7WfLDEHMeSxepNfbnvTh2SASNoSk5I3s
 MHKSKVcofAOw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205850317"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="205850317"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 15:56:55 -0700
IronPort-SDR: UUesACHT6kWPEiMvg9+nB19l4u0g/WZ3JAF0qc2A8o02mj6U3JC4LnHqCMZHWfWwj39Z80W+kp
 FBs8qDhUCDkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="478523185"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2021 15:56:54 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] CXL ACPI tables for object creation
Date:   Mon, 14 Jun 2021 15:52:40 -0700
Message-Id: <cover.1623705308.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Parse the ACPI CXL Early Discovery Table (CEDT) and use the CHBS & CFMWS
when creating port and decoder objects.

CHBS: CXL Host Bridge Structure - Patch 1
CFMWS: CXL Fixed Memory Window Structure - Patch 2

Alison Schofield (2):
  cxl/acpi: Add the Host Bridge base address to CXL port objects
  cxl/acpi: Use the ACPI CFMWS to create static decoder objects

 drivers/cxl/acpi.c | 211 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 205 insertions(+), 6 deletions(-)


base-commit: 195d5a63f0f9a47aa128a5050fe4ad7f5d27a901
-- 
2.26.2

