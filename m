Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A493EEB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbjFOBaA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjFOB37 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:29:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8772126
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792598; x=1718328598;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eGw7vIjahhTQd2enCMeh7qVOK9O06XBMmC29hn8mzyA=;
  b=JdrmqVReHdORifLoLKp20QxPQ+ewaJ+6n/1wVk2mdfSxCyaQvavJBoni
   4DtU5R3/083lONVuB7pUc8vXhoAl9RHhYnSKblpr6WYg8HrBZM73VTlDs
   vcACth67fxQxeuB3+1WJl1FsqRx2AAjXyu1sr5+bFnCL3o2UyZlSBRQ2D
   M9XY+scmLKqWIJUciyCFZOcBkKuiw4rPe0DGDbahZ2hlhNBnNKz8sS0Nq
   +LJFEUwBeLPUgwqI6ndekSN5CgWFg22AurU2mJXRjAzmgwFbYoCThnnUe
   ERqwpf+wNeJGMRtXagq76nCM8xZLMNXtxhjaGtYqLPTcJf3u3cyroBmuK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="445150683"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="445150683"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:29:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="689600086"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="689600086"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:29:57 -0700
Subject: [PATCH v2 04/12] cxl: Remove leftover attribute documentation in
 'struct cxl_dev_state'
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date:   Wed, 14 Jun 2023 18:29:57 -0700
Message-ID: <168679259703.3436160.12583306507362357946.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

commit 14d788740774 ("cxl/mem: Consolidate CXL DVSEC Range enumeration
in the core")

...removed @info from 'struct cxl_dev_state', but neglected to remove
the corresponding kernel-doc entry. Complete the removal.

Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Closes: http://lore.kernel.org/r/20230606121054.000069e1@Huawei.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxlmem.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8e4ba5b52902..66896fc6c43f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -287,7 +287,6 @@ struct cxl_poison_state {
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
  * @component_reg_phys: register base of component registers
- * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @event: event log driver state
  * @poison: poison driver state info

