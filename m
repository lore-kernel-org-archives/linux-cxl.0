Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDEFC433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbiAXAvu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:51:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:17024 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235309AbiAXAvt (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985509; x=1674521509;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OpWGhmDpwX6rnzO1PJzfjee1WOk0ig2ikmHYuEnPsjc=;
  b=UcJZU4Y0+ScRXjgjg8/sM0wJSqHf5aLsRVxCrISmCwml9czd32QvdODM
   uFAyRp3W9bIdYOg6FnG1+AdIjmlhnVTWQ2cl51WT4zGfN8qbP+UWnNo6n
   TdX0qf9EWO00Eqv/9O+Xb1IWWxX9mJpvAJR1JCIdpJlefVTkAx+L/vBeq
   fMUuvm3Yo3CA5HEhY7jpBFBy9qb58E2Jc3zTBVYfrYdrsTQJZ3yLU0lfH
   Xja9loOxudM2BUhof3GSA3CRTRZOnMmHYyketsEby7Hm8IcCyqh63/7W0
   VLVy8GHYsuiw59w/FxEutQB95XmXkzrZDthGK3FTxfeEW/rTWqI077Jzo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="306652101"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="306652101"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:51:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="562476162"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:51:49 -0800
Subject: [ndctl PATCH 00/37] cxl: Full topology enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Date:   Sun, 23 Jan 2022 16:51:49 -0800
Message-ID: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In coordination with kernel enabling to enumerate switch ports and
validate the CXL.mem capability through the topology and in endpoints
[1], enhance the 'cxl list' command accordingly. The 'cxl list' command
gains the ability to enumerate buses (CXL root ports), ports (Switch
ports), endpoints (kernel port objects associated with the HDM Decoder
Capability in endpoints), decoders, and downstream ports. Similar to
'ndctl list', 'cxl list' supports the ability to cross filter the
listing by different object types. This allows 'cxl list' to answer
questions like, "which memdevs can decode a given root level CXL decoder
range?" ("cxl list -M -d $decoder_id"), "what are the set of decoders
that a memdev can contribute?" ("cxl list -D -m $memdev_id").

In addition to that functionality new commands for disabling/enabling
ports and memdevs are added.

See the 'cxl list' man page for more details. See the libcxl man page
for a description of APIs added to support the new commands.

[1]: https://lore.kernel.org/r/164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com

---

Dan Williams (37):
      test: Add 'suite' identifiers to tests
      ndctl: Rename util_filter to ndctl_filter
      build: Add tags
      json: Add support for json_object_new_uint64()
      cxl/json: Cleanup object leak false positive
      cxl/list: Support multiple memdev device name filter arguments
      cxl/list: Support comma separated lists
      cxl/list: Introduce cxl_filter_walk()
      cxl/list: Emit device serial numbers
      cxl/list: Add filter by serial support
      cxl/lib: Rename nvdimm bridge to pmem
      cxl/list: Cleanup options definitions
      Documentation: Enhance libcxl memdev API documentation
      cxl/list: Add bus objects
      util/json: Warn on stderr about empty list results
      util/sysfs: Uplevel modalias lookup helper to util/
      cxl/list: Add port enumeration
      cxl/list: Add --debug option
      cxl/list: Add endpoints
      cxl/list: Add 'host' entries for port-like objects
      cxl/list: Add 'host' entries for memdevs
      cxl/list: Move enabled memdevs underneath their endpoint
      cxl/list: Filter memdev by ancestry
      cxl/memdev: Use a local logger for debug
      cxl/memdev: Cleanup memdev filter
      cxl/memdev: Add serial support for memdev-related commands
      cxl/list: Add 'numa_node' to memdev listings
      util: Implement common bind/unbind helpers
      cxl/memdev: Enable / disable support
      cxl/list: Add decoder support
      cxl/list: Extend decoder objects with target information
      cxl/list: Use 'physical_node' for root port attachment detection
      cxl/list: Reuse the --target option for ports
      cxl/list: Support filtering memdevs by decoders
      cxl/list: Support filtering memdevs by ports
      cxl/port: Add {disable,enable}-port command
      cxl/list: Filter dports and targets by memdevs


 .clang-format                            |    7 
 Documentation/copyright.txt              |    2 
 Documentation/cxl/cxl-disable-memdev.txt |   37 +
 Documentation/cxl/cxl-disable-port.txt   |   46 +
 Documentation/cxl/cxl-enable-memdev.txt  |   34 +
 Documentation/cxl/cxl-enable-port.txt    |   43 +
 Documentation/cxl/cxl-list.txt           |  248 ++++++
 Documentation/cxl/lib/libcxl.txt         |  448 ++++++++++-
 Documentation/cxl/memdev-option.txt      |    5 
 Documentation/cxl/meson.build            |    8 
 config.h.meson                           |    3 
 cxl/builtin.h                            |    4 
 cxl/cxl.c                                |    4 
 cxl/filter.c                             | 1068 +++++++++++++++++++++++++
 cxl/filter.h                             |   50 +
 cxl/json.c                               |  283 +++++++
 cxl/json.h                               |   19 
 cxl/lib/libcxl.c                         | 1267 +++++++++++++++++++++++++++++-
 cxl/lib/libcxl.sym                       |   83 ++
 cxl/lib/private.h                        |   85 ++
 cxl/libcxl.h                             |  133 +++
 cxl/list.c                               |  167 ++--
 cxl/memdev.c                             |  153 +++-
 cxl/meson.build                          |    2 
 cxl/port.c                               |  253 ++++++
 daxctl/json.c                            |    2 
 meson.build                              |   25 +
 ndctl/dimm.c                             |    2 
 ndctl/filter.c                           |    4 
 ndctl/filter.h                           |   21 
 ndctl/json.c                             |   10 
 ndctl/lib/libndctl.c                     |  136 ---
 ndctl/list.c                             |   14 
 ndctl/monitor.c                          |   12 
 test/list-smart-dimm.c                   |   12 
 test/meson.build                         |   73 +-
 util/json.c                              |    9 
 util/json.h                              |   14 
 util/sysfs.c                             |  103 ++
 util/sysfs.h                             |   16 
 40 files changed, 4503 insertions(+), 402 deletions(-)
 create mode 100644 Documentation/cxl/cxl-disable-memdev.txt
 create mode 100644 Documentation/cxl/cxl-disable-port.txt
 create mode 100644 Documentation/cxl/cxl-enable-memdev.txt
 create mode 100644 Documentation/cxl/cxl-enable-port.txt
 create mode 100644 cxl/port.c

base-commit: e1b4076b742f2e7aab8e9c9612a9b5c247d0d8e9
