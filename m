Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42612C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Nov 2022 03:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiKKDUO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Nov 2022 22:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKKDUO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Nov 2022 22:20:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16EB47301
        for <linux-cxl@vger.kernel.org>; Thu, 10 Nov 2022 19:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668136811; x=1699672811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jUkCAYfbxlEUpB+Kch5mmsGnTydZUzk+4WocmIT1Hm4=;
  b=aHcn41O+PKGHWLAgI1jaBeMMd8AtJOhfSxQk9Wpr+0plQSNP0U5yvHfx
   gjmyRG4rUDKhHNy5mNFcGagYbme9XE1eb5iT0l58zIn7o7nfHuTdF5Qxy
   zvN6fe1D329h2AlYfdR6qrVB97OFEp+yHTIXvztlrjXwEfvxAePEjGqsw
   i8I51fs6UvBliam9Xv0R3anmS6mpqMn9GNKW89pPy8tnNKWNuoQt7NtSb
   crI6bTo0AK5lvotyIw5ntcjHza5VF4AqEqC03Hf3nldFivfbEurQfJOyb
   Tt54NlrFn4kMIcs1KUkxDdK3bMBkpBaHmxYjRXhQBv+SSqAht14+BGgV2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397807323"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="397807323"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:20:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="743129950"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="743129950"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.161.45])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:20:11 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl PATCH 0/3] Support poison list retrieval
Date:   Thu, 10 Nov 2022 19:20:03 -0800
Message-Id: <cover.1668133294.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Changes RFC->v1:
- Resync with DaveJ's v5 monitor patchset. [1]
  (It provides the event tracing functionality used here.)
- Resync with the kernel patchset adding poison list support. [2]
- Add cxl-get-poison.sh unit test to cxl test suite.
- JSON object naming cleanups, replace spaces with '_'.
- Use common event pid field to restrict events to this cxl list instance.
- Use json_object_get_int64() for addresses.
- Remove empty hpa fields. Add back with dpa->hpa translation.

[1] https://lore.kernel.org/linux-cxl/166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com/
[2] https://lore.kernel.org/linux-cxl/cover.1668115235.git.alison.schofield@intel.com/

The first patch adds a libcxl API for triggering the read of a
poison list from a memory device. Users of that API will need to
trace the kernel events to collect the error records.

Patches 2 adds a PID filtering option to event tracing and then
patches 3 & 4 add a pretty option, --media-errors to cxl list.
The last patch (5) adds a unit test to the cxl test suite.

Examples:
cxl list -m mem2 --media-errors
[
  {
    "memdev":"mem2",
    "pmem_size":1073741824,
    "ram_size":0,
    "serial":2,
    "host":"cxl_mem.2",
    "media_errors":{
      "nr_media_errors":2,
      "media_error_records":[
        {
          "dpa":64,
          "length":128,
          "source":"Injected",
          "flags":"Overflow,",
          "overflow_time":1656711046
        },
        {
          "dpa":192,
          "length":192,
          "source":"Internal",
          "flags":"Overflow,",
          "overflow_time":1656711046
        },
      ]
    }
  }
]

# cxl list -r region5 --media-errors
[
  {
    "region":"region5",
    "resource":1035623989248,
    "size":2147483648,
    "interleave_ways":2,
    "interleave_granularity":4096,
    "decode_state":"commit",
    "media_errors":{
      "nr_media_errors":2,
      "media_error_records":[
        {
          "memdev":"mem2",
          "dpa":0,
          "length":64,
          "source":"Internal",
          "flags":"",
          "overflow_time":0
        },
	{
          "memdev":"mem5",
          "dpa":0,
          "length":256,
          "source":"Injected",
          "flags":"",
          "overflow_time":0
        }
      ]
    }
  }
]

Alison Schofield (5):
  libcxl: add interfaces for GET_POISON_LIST mailbox commands
  cxl: add an optional pid check to event parsing
  cxl/list: collect and parse the poison list records
  cxl/list: add --media-errors option to cxl list
  test: add a cxl-get-poison test

 Documentation/cxl/cxl-list.txt |  64 ++++++++++++
 cxl/event_trace.c              |   5 +
 cxl/event_trace.h              |   1 +
 cxl/filter.c                   |   2 +
 cxl/filter.h                   |   1 +
 cxl/json.c                     | 185 +++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.c               |  44 ++++++++
 cxl/lib/libcxl.sym             |   6 ++
 cxl/libcxl.h                   |   2 +
 cxl/list.c                     |   2 +
 test/cxl-get-poison.sh         |  78 ++++++++++++++
 test/meson.build               |   2 +
 12 files changed, 392 insertions(+)
 create mode 100644 test/cxl-get-poison.sh

-- 
2.37.3

