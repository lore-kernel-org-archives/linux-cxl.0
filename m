Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E708C64EC4
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 19:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjBGTQ4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 14:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjBGTQz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 14:16:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC33252BD
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 11:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675797414; x=1707333414;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Cj2RALqAObYfvR8W+o15d2ZFKZgU2s7oBAZfRhTwT90=;
  b=PTweWXaxNP26aMRUCq0xeK7URJNvYCswnJiCkLe2Gf1tJdBOTZAe+WXl
   gHbg5TXgr9ykNmnXuI/ZxhaZrDaSJ63BHp74dot8k3+t0dGx+oONkgz38
   WGRqsUI79KnPLojuemoLYQdperPBsJVQgWSskjIMrpa7jMDHQnMYMpL9u
   C6qguBoQ7Xp4d32gQHAQIskc2ALqpW3MYiKcQif9BAitSm18f5AtLFRV5
   WFCs/xouSRNStru98m69BFIMBBrZXvYXsPNaKN1+UCTKhmwoHZ34Axe7k
   bpf3ZW9RyBC3e4rFhs4Zc2nhjF9GieKHQxhK0HybY8g0N82WGjWx91x30
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331733978"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="331733978"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 11:16:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735649801"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="735649801"
Received: from fvanegas-mobl.amr.corp.intel.com (HELO vverma7-desk1.local) ([10.209.109.6])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 11:16:52 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl 0/7] cxl: add support for listing and creating
 volatile regions
Date:   Tue, 07 Feb 2023 12:16:26 -0700
Message-Id: <20230120-vv-volatile-regions-v1-0-b42b21ee8d0b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIqj4mMC/x2NQQqDQAxFryJZNxBHLNirlC7GMY4BiZKUQRDv3
 rHLx/uPf4KzCTu8mhOMi7hsWqF9NJCWqJlRpsoQKHTUBsJSsGxr/MrKaJzr3JGe3dBT4rkfCGo
 5RmccLWpa7nZnnUTzbXbjWY7/3/tzXT/a1m0JfwAAAA==
To:     linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>, nvdimm@lists.linux.dev
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=openpgp-sha256; l=2900;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=Cj2RALqAObYfvR8W+o15d2ZFKZgU2s7oBAZfRhTwT90=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDMmPFi8u89tU83H1g7mFwubfZygkPdfzb79nfk85zKBWa
 qHPgVrnjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEyEYwojw73VkqJcj8yzpBX9
 t8zkuRfUw5YWaLmRW0svoOMhQ3xKD8P/1GkXDSOuzg8/v25fbtm2Y/3TdzRPaPmacnj6vE+h0xx
 zWAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

While enumeration of ram type regions already works in libcxl and
cxl-cli, it lacked an attribute to indicate pmem vs. ram. Add a new
'type' attribute to region listings to address this. Additionally, add
support for creating ram regions to the cxl-create-region command. The
region listings are also updated with dax-region information for
volatile regions.

This also includes fixed for a few bugs / usability issues identified
along the way - patches 1, 4, and 6. Patch 5 is a usability improvement
where based on decoder capabilities, the type of a region can be
inferred for the create-region command.

These have been tested against the ram-region additions to cxl_test
which are part of the kernel support patch set[1].
Additionally, tested against qemu using a WIP branch for volatile
support found here[2]. The 'run_qemu' script has a branch that creates
volatile memdevs in addition to pmem ones. This is also in a branch[3]
since it depends on [2].

These cxl-cli / libcxl patches themselves are also available in a
branch at [4].

[1]: https://lore.kernel.org/linux-cxl/167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com/
[2]: https://gitlab.com/jic23/qemu/-/commits/cxl-2023-01-26
[3]: https://github.com/pmem/run_qemu/commits/vv/ram-memdevs
[4]: https://github.com/pmem/ndctl/tree/vv/volatile-regions

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Dan Williams (2):
      cxl/list: Include regions in the verbose listing
      cxl/list: Enumerate device-dax properties for regions

Vishal Verma (5):
      cxl/region: skip region_actions for region creation
      cxl: add a type attribute to region listings
      cxl: add core plumbing for creation of ram regions
      cxl/region: accept user-supplied UUIDs for pmem regions
      cxl/region: determine region type based on root decoder capability

 Documentation/cxl/cxl-create-region.txt |  6 ++-
 Documentation/cxl/cxl-list.txt          | 31 +++++++++++++
 Documentation/cxl/lib/libcxl.txt        |  8 ++++
 cxl/lib/private.h                       |  2 +
 cxl/lib/libcxl.c                        | 72 ++++++++++++++++++++++++++++--
 cxl/filter.h                            |  3 ++
 cxl/libcxl.h                            |  3 ++
 cxl/filter.c                            |  1 +
 cxl/json.c                              | 21 +++++++++
 cxl/list.c                              |  3 ++
 cxl/region.c                            | 79 ++++++++++++++++++++++++++++++---
 cxl/lib/libcxl.sym                      |  7 +++
 cxl/lib/meson.build                     |  1 +
 cxl/meson.build                         |  3 ++
 14 files changed, 229 insertions(+), 11 deletions(-)
---
base-commit: 08720628d2ba469e203a18c0b1ffbd90f4bfab1d
change-id: 20230120-vv-volatile-regions-063950cef590

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

