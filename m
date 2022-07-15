Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B31BC43334
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 06:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiGOG0K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiGOG0J (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 02:26:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5F110FDF
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 23:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657866368; x=1689402368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xn9r5O+bolINQGPwGnn2lHCCcrCKqIydA/HZpyOLVY4=;
  b=UW2Nmmpgd12ThHQeRGo/4vkpP77uLywggUEb0/665C/ZUtjvGlhQ7WMC
   iZYV/fzuiJ89Mn7khy6+cuib8uv0DPAF4baICOaM2VUeCYeWRUwvssGEx
   KPhff6k9n7KxKFJW/yFI1gJPok/6p4f1M1pzidnwkP9/BmrcST42Ok1ca
   t5B/8aZfk/WAivCnK56Er4z6uuxW4r54fCUpxkokSBtxJmsj+bB60ByIQ
   D918cEzn5Kq3AU423YJOrczNMl7UlqOWxKmkOO5f3Ysjr/xYb2axZFSdR
   dN3s4uaEsWvsL20kesDw6DtpCp1/4O2CqOVriM/7b5JXunPBnATpqmlSJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286852209"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="286852209"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 23:26:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="546544601"
Received: from saseiper-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.71.32])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 23:26:07 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 0/8] cxl: add region management
Date:   Fri, 15 Jul 2022 00:25:42 -0600
Message-Id: <20220715062550.789736-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4192; h=from:subject; bh=Xn9r5O+bolINQGPwGnn2lHCCcrCKqIydA/HZpyOLVY4=; b=owGbwMvMwCXGf25diOft7jLG02pJDEkXObJO835QMZqyXSKezXnS021it39xyOzh27Pu2a07StdP ds7e21HKwiDGxSArpsjyd89HxmNy2/N5AhMcYeawMoEMYeDiFICJJPxj+B8Rz7bqwTTV60v26EWd6l pQndi8c/EuhseWQeIueSufHtrL8M9w6icRaY0z0TpR4fndF2NZ/nTpJs14rmMvusrNIa/tBjcA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Introduce the first cut at a 'cxl create-region' command, which uses the
ABI proposed by the kernel patches in [1], and builds on the
create-region foundation laid out in [2].

This introduces libcxl objects for regions and their memdev mappings,
adds listing support for them, and libcxl APIs to create, enable,
disable, and destroy regions. These are consumed by respective cxl-cli
commands to perform the same region management operations.

The 'cxl create-region' command deserves a bit more detail. Its current
version can be considered a fundamental 'plumbing' implementation. It
allows, and in some cases, requires the user to specify the parameters
for the region being created. Future enhancements to this will allow a
simple 'cxl create-region' invocation to automatically pick suitable
root decoders, memdev endpoints, and interleave settings to create a
maximally sized and interleaved region.

Today, the create-region command requires the following from the user:

  -d <root decoder> : the root decoder (CFMWS window) under which to
  create the region

  -m or -e <targets>: the memdev or endpoint decoder targets that will
  form the new region

It can pick the following settings automatically (though the user can
also override these if desired):

  -w : interleave ways - picked based on the number of memdev / endpoint
  decoder targets supplied

  -g : interleave granularity - defaults to the interleave granularity
  advertised by the root decoder

  -t : type of region - defaults to pmem. The ram (volatile) type is not
  supported yet.

  -s : size of region - deduced based on sizes of the specified targets

[1]: https://lore.kernel.org/linux-cxl/165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com/
[2]: https://lore.kernel.org/linux-cxl/165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com/

Vishal Verma (8):
  libcxl: add a depth attribute to cxl_port
  cxl/port: Consolidate the debug option in cxl-port man pages
  libcxl: Introduce libcxl region and mapping objects
  cxl-cli: add region listing support
  libcxl: add low level APIs for region creation
  cxl: add a 'create-region' command
  cxl: add commands to {enable,disable,destroy}-region
  cxl/list: make memdevs and regions the default listing

 Documentation/cxl/cxl-create-region.txt  | 111 ++++
 Documentation/cxl/cxl-destroy-region.txt |  39 ++
 Documentation/cxl/cxl-disable-port.txt   |   5 +-
 Documentation/cxl/cxl-disable-region.txt |  34 +
 Documentation/cxl/cxl-enable-port.txt    |   5 +-
 Documentation/cxl/cxl-enable-region.txt  |  34 +
 Documentation/cxl/cxl-list.txt           |  13 +-
 Documentation/cxl/debug-option.txt       |   4 +
 Documentation/cxl/decoder-option.txt     |   6 +
 Documentation/cxl/region-description.txt |   7 +
 cxl/lib/private.h                        |  37 ++
 cxl/lib/libcxl.c                         | 795 ++++++++++++++++++++++-
 cxl/builtin.h                            |   4 +
 cxl/filter.h                             |   6 +
 cxl/json.h                               |   5 +
 cxl/libcxl.h                             |  64 +-
 cxl/cxl.c                                |   4 +
 cxl/filter.c                             | 121 +++-
 cxl/json.c                               | 123 ++++
 cxl/list.c                               |  26 +-
 cxl/region.c                             | 699 ++++++++++++++++++++
 .clang-format                            |   2 +
 Documentation/cxl/meson.build            |   7 +
 cxl/lib/libcxl.sym                       |  36 +
 cxl/meson.build                          |   1 +
 25 files changed, 2143 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/cxl/cxl-create-region.txt
 create mode 100644 Documentation/cxl/cxl-destroy-region.txt
 create mode 100644 Documentation/cxl/cxl-disable-region.txt
 create mode 100644 Documentation/cxl/cxl-enable-region.txt
 create mode 100644 Documentation/cxl/debug-option.txt
 create mode 100644 Documentation/cxl/decoder-option.txt
 create mode 100644 Documentation/cxl/region-description.txt
 create mode 100644 cxl/region.c

-- 
2.36.1

