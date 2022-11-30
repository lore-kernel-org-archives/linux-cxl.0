Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF666C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 04:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiK3Eer (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Nov 2022 23:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiK3Eem (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Nov 2022 23:34:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89255FD1
        for <linux-cxl@vger.kernel.org>; Tue, 29 Nov 2022 20:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669782881; x=1701318881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1/bg90ZdKfJepPJmELKkNN6dGpufwqaAZWW5kSr3egM=;
  b=X6PCCEmmMVFZlrvxWcL3w0ruyEuN3xBexUX7xb9Gns93B3DJA9gu7V0Z
   cRrewf7SIUZB+rkF4sGh3sDzb/cwGtaa8Z9s7YN4dd3snYG0FQqX2mQj4
   BuI1S8STfrPRat8yU3ofVBZIZUY2V5OrpqNDX+qXGiQWk31UQbUUGXSL5
   kOH9T8C0NYVOm+SurqWHIWXHZn+ruR/b9z6M0PlkjdqstHuIULsujoVTk
   wRhY7c8AmO28I2VaoaI9SOb82VbBH6QkirzLck7pnVXuyW3hns/V975tc
   jlwhLdqU06QNCbMYIBOZmZThISzXrHFiN3S/V/M92hLHbaSppb9bIsQfl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379583227"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="379583227"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:34:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="594525679"
X-IronPort-AV: E=Sophos;i="5.96,205,1665471600"; 
   d="scan'208";a="594525679"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.50.166])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 20:34:41 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 0/5] cxl: CXL Inject & Clear Poison
Date:   Tue, 29 Nov 2022 20:34:32 -0800
Message-Id: <cover.1669781852.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Introducing Inject and Clear Poison support for CXL Devices.

These are optional commands, meaning not all CXL devices must support
them. The sysfs attributes, inject_poison and clear_poison, are only
visible for devices reporting support of the capability.

AFAICS the spec does not say support has to come in pairs. A device
could support Inject and not Clear, or the reverse.

Patches 1 & 2 are the required driver implementation.
Patches 3 & 4 are required for testing with cxl_test.

Then there's patch 5. I built on top of the Get Poison Patchset[1]
because Get Poison is useful for checking on the success of Inject
and Clear Poison. Patch 5 teaches the mock of Get Poison how to use
the injected poison list.

That could all be flipped. Inject & Clear could merge first, then
Get Poison would have the capabilities of Patch 5 from the onset.
Or, they can all roll together into one happy patchset.

Example:
# cxl list -m mem1 --media-errors -u
Now you see the default mock media-errors:
{
  "memdev":"mem1",
  "pmem_size":"1024.00 MiB (1073.74 MB)",
  "ram_size":"1024.00 MiB (1073.74 MB)",
  "serial":"0x1",
  "host":"cxl_mem.1",
  "media_errors":{
    "nr_media_errors":2,
    "media_error_records":[
      {
        "dpa":"0x40000000",
        "length":64,
        "source":"Internal",
        "flags":"",
        "overflow_time":0
      },
      {
        "dpa":"0",
        "length":64,
        "source":"Internal",
        "flags":"",
        "overflow_time":0
      }
    ]
  }
}

# echo 0x41000000 > /sys/bus/cxl/devices/mem1/inject_poison
# echo 0x30000000 > /sys/bus/cxl/devices/mem1/inject_poison
Now you see the injected mock media-errors:
# cxl list -m mem1 --media-errors -u
{
  "memdev":"mem1",
  "pmem_size":"1024.00 MiB (1073.74 MB)",
  "ram_size":"1024.00 MiB (1073.74 MB)",
  "serial":"0x1",
  "host":"cxl_mem.1",
  "media_errors":{
    "nr_media_errors":2,
    "media_error_records":[
      {
        "dpa":"0x41000000",
        "length":64,
        "source":"Injected",
        "flags":"",
        "overflow_time":0
      },
      {
        "dpa":"0x30000000",
        "length":64,
        "source":"Injected",
        "flags":"",
        "overflow_time":0
      }
    ]
  }

Alison Schofield (5):
  cxl/memdev: Add support for the Inject Poison mailbox command
  cxl/memdev: Add support for the Clear Poison mailbox command
  tools/testing/cxl: Mock the Inject Poison mailbox command
  tools/testing/cxl: Mock the Clear Poison mailbox command
  tools/testing/cxl: Use injected poison for Get Poison List

 Documentation/ABI/testing/sysfs-bus-cxl |  36 +++++
 drivers/cxl/core/memdev.c               | 100 ++++++++++++++
 drivers/cxl/cxlmem.h                    |   9 ++
 tools/testing/cxl/test/mem.c            | 170 +++++++++++++++++++++---
 4 files changed, 295 insertions(+), 20 deletions(-)

-- 
2.37.3

