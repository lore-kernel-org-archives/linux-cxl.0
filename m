Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D36BC4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Feb 2022 01:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiBHBFK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245482AbiBGXGQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Feb 2022 18:06:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA2BC0612A4
        for <linux-cxl@vger.kernel.org>; Mon,  7 Feb 2022 15:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275175; x=1675811175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JFS3oCQeAlST4R4Lawyyy7QjftNOyORmMpZIXJ9X6d4=;
  b=fu8NIvJoPlpCICek3JKITJaNghgF5JNwshR8cUAmJtA+q6ySAnHfj0jB
   sGnNkRdCXwGf7YZNiZd2tMVjdHgn8I080awgDahgKsSQUDad0HsidPqBe
   uyhQ4WZWvZ9hPewSRTiVxbhgnWeMxokMV5Dt1D15prFSKXmDyNjd1WnGS
   d5H1Ar2MxWzINaI3As0IAFAyyyYzPJKml9W03pvp9hWb2bFBb1fW6TCkr
   jM8HAnIQBsnOY000miPCDC9r4OqGTh/GJ4uk+pWt0gkK/1QuCPddVVnbu
   8Wde/Y9COECVK2qAWj8syGBooYs/U5XkJeEFe1n3UZMHf3MtsRQbKY8nx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="246416772"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="246416772"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:06:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="481742150"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:06:14 -0800
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH v4 0/6] Add partitioning support for CXL memdevs
Date:   Mon,  7 Feb 2022 15:10:14 -0800
Message-Id: <cover.1644271559.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Users may want to view and change partition layouts of CXL memory
devices that support partitioning. Provide userspace access to
the device partitioning capabilities as defined in the CXL 2.0
specification.

The first 4 patches add accessors for all the information needed
to formulate a new partition layout. This info is accessible via
the libcxl API and a new option in the cxl list command:

    "partition_info":{
      "active_volatile_bytes":273535729664,
      "active_persistent_bytes":0,
      "next_volatile_bytes":268435456,
      "next_persistent_bytes":273267294208,
      "total_bytes":273535729664,
      "volatile_only_bytes":0,
      "persistent_only_bytes":0,
      "partition_alignment_bytes":268435456
    }

Patch 5 introduces the libcxl interfaces for the SET_PARTITION_INFO
mailbox command and Patch 6 adds the new CXL command: 

Synopsis:
cxl set-partition <mem0> [<mem1>..<memN>] [<options>]

-t, --type=<type>       'pmem' or 'volatile' (Default: 'pmem')
-s, --size=<size>       size in bytes (Default: all partitionable capacity)
-a, --align             allow alignment correction
-v, --verbose           turn on debug

The CXL command does not offer the IMMEDIATE mode option defined
in the CXL 2.0 spec because the CXL kernel driver does not support
immediate mode yet. Since userspace could use the libcxl API to
send a SET_PARTITION_INFO mailbox command with immediate mode
selected, a kernel patch that rejects such requests is in review
for the CXL driver.

Changes in v4: (from Dan's review)
- cxl set-partition command: add type (pmem | volatile),
  add defaults for type and size, and add an align option.
- Replace macros with return statements with functions.
- Add cxl_set_partition_set_mode() to the libcxl API.
- Add API documentation to Documentation/cxl/lib/libcxl.txt.
- Use log_err/info mechanism.
- Display memdev JSON info upon completion of set-partition command.
- Remove unneeded casts when accessing command payloads.
- Name changes - like drop _info suffix, use _size instead of _bytes.

Changes in v3:
- Back out the API name change to the partition align accessor.
  The API was already released in v72.
- Man page: collapse into one .txt file. 
- Man page: add to Documentation/meson.build 

Changes in v2:
- Rebase onto https://github.com/pmem/ndctl.git djbw/meson.
- Clarify that capacities are reported in bytes. (Ira)
  This led to renaming accessors like *_capacity to  *_bytes and 
  a spattering of changes in the man pages and commit messages.
- Add missing cxl_cmd_unref() when creating json objects. (Ira)
- Change the cxl list option to: -I --partition (Dan) 
- Use OPT_STRING for the --volatile_size parameter (Dan, Vishal)
- Drop extra _get_ in accessor names. (Vishal)
- Add an accessor for the SET_PARTITION_INFO mbox cmd flag.
- Display usage_with_options if size parameter is missing.
- Drop the OPT64 define patch. Use OPT_STRING instead.

Alison Schofield (6):
  libcxl: add GET_PARTITION_INFO mailbox command and accessors
  libcxl: add accessors for capacity fields of the IDENTIFY command
  libcxl: return the partition alignment field in bytes
  cxl: add memdev partition information to cxl-list
  libcxl: add interfaces for SET_PARTITION_INFO mailbox command
  cxl: add command set-partition

 Documentation/cxl/cxl-list.txt          |  23 +++
 Documentation/cxl/cxl-set-partition.txt |  60 ++++++++
 Documentation/cxl/lib/libcxl.txt        |   5 +
 Documentation/cxl/meson.build           |   1 +
 cxl/builtin.h                           |   1 +
 cxl/cxl.c                               |   1 +
 cxl/filter.c                            |   2 +
 cxl/filter.h                            |   1 +
 cxl/json.c                              | 113 ++++++++++++++
 cxl/lib/libcxl.c                        | 123 ++++++++++++++-
 cxl/lib/libcxl.sym                      |  10 ++
 cxl/lib/private.h                       |  18 +++
 cxl/libcxl.h                            |  18 +++
 cxl/list.c                              |   2 +
 cxl/memdev.c                            | 196 ++++++++++++++++++++++++
 util/json.h                             |   1 +
 util/size.h                             |   1 +
 17 files changed, 575 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/cxl/cxl-set-partition.txt

-- 
2.31.1

