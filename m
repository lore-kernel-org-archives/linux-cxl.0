Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0700C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 23:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJMXjR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 19:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiJMXjP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 19:39:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B718DD77
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 16:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665704354; x=1697240354;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6gEW5eDpcXcP9ftEKEoxli8QEZf2PjnG400RLgjW1jc=;
  b=HRaRdBdm3tVnq/pvAoUIwQraNmzwq2jmS5tpbFvSAjwJoz65TqcFu0GL
   R+uCEj240FTkaBndwspQniLmqsLgN83G+GyG0Sj/S3H/Vlg/9nIWveqIH
   cf+VjHrZbXrBfPFBOdla2YK6b3V/C3hasQIMFDYhVk83sk2A5+udJjTYk
   S/sssuioFRMNATxvJs1sTdV+nwKp0p85V+a58Rp9aAzrJEwuAguxr3KJz
   YO1f+24+7I0M+R7GoiPtSW/eX3CK6Qh8/A1sL321+ek7iFJRMux7Fkwnc
   TeKx0QZ14wcwDuJlBp4lGlQQOR03PBoUHm4hvyzBYzmFv3oPQoZBjho5/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="303977907"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="303977907"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 16:39:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="872527636"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="872527636"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.171.186])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 16:39:05 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [ndctl RFC 0/3] Support poison list retrieval
Date:   Thu, 13 Oct 2022 16:39:00 -0700
Message-Id: <cover.1665699750.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The RFC label is because this is built upon in flight patchsets
making it unlikely others can try it out. It depends upon the
tracing support in Dave's monitor patchset [1], and the kernel
driver support for poison in this patchset [2].

The first patch adds a libcxl API for triggering the read of a
poison list from a memory device. Users of that API will need to
trace the kernel events to collect the error records.

Patches 2 & 3 offer a pretty option, --media-errors to cxl list 
where the the poison list is read, results collected and parsed,
and the media error records included in the JSON list output.

The JSON output of 'cxl list' does not include all the same fields
that are available in the 'cxl_poison' trace event.

Trace events of 'cxl_poison' always include these fields:
region: memdev: pcidev: hpa: dpa: length: source: flags: overflow_time:

'cxl list --media-errors' omits fields that seem useless in the
context of the cxl list command:
- Do not repeat the memdev, region, or pcidev's that are
  already included in the list output.
- Only include 'hpa' when media errors are listed by region.

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
      "nr media-errors":2,
      "media-error records":[
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
      "nr media-errors":2,
      "media-error records":[
        {
          "memdev":"mem2",
          "hpa":0,
          "dpa":0,
          "length":64,
          "source":"Reserved",
          "flags":"",
          "overflow_time":0
        },
	{
          "memdev":"mem5",
          "hpa":0,
          "dpa":384,
          "length":256,
          "source":"Injected",
          "flags":"",
          "overflow_time":0
        }
      ]
    }
  }
]

[1] https://lore.kernel.org/nvdimm/166363103019.3861186.3067220004819656109.stgit@djiang5-desk3.ch.intel.com/
[2] https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/

Alison Schofield (3):
  libcxl: add interfaces for GET_POISON_LIST mailbox commands
  cxl/list: collect and parse the poison list records
  cxl/list: add --media-errors option to cxl list

 Documentation/cxl/cxl-list.txt |  66 +++++++++++
 cxl/filter.c                   |   2 +
 cxl/filter.h                   |   1 +
 cxl/json.c                     | 197 +++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.c               |  40 +++++++
 cxl/lib/libcxl.sym             |   6 +
 cxl/libcxl.h                   |   2 +
 cxl/list.c                     |   2 +
 8 files changed, 316 insertions(+)

-- 
2.37.3

