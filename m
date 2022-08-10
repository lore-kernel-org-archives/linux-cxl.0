Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E79C25B06
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Aug 2022 23:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiHJXJn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiHJXJk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 Aug 2022 19:09:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3503C74CDC
        for <linux-cxl@vger.kernel.org>; Wed, 10 Aug 2022 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660172978; x=1691708978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IgDPZkTj8OWicxyeDb2nka/I4dLrq3fbpj7i9AcVc+0=;
  b=iuK4eVXLkSg55UTGsREVp24IXw7Mg77M68KGRy0MDBp/70gSEQdcAg+D
   1wk6mAn/Oo1QEhMY3f2CoQIVNX9hJtywT9vdaEJswiHzxF+TnuUSJpx1k
   R16g5oqQN16jTJOA5F8Fcb3fHF4ynvyx9qb3nVRbjov0q52X7RL9ZxJBD
   eW1n6YwMovxfpmqnCeIoEwCebwPYT41GnLBqsKdEb0JNOZROFRle38amw
   2pBcwesB7aMC8LptPwAFzX6jnCy/Xbr+AQtNOWTO5bBLfcdyWwAz+YwsV
   FKKdklgrP9ls9aVQgOv5R3IC/x9PIKIdxdQ6E/5MhrRHxyoG3eCbncDHB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271599774"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271599774"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:09:32 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="581429410"
Received: from maughenb-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.94.5])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:09:30 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v2 00/10] cxl: add region management
Date:   Wed, 10 Aug 2022 17:09:04 -0600
Message-Id: <20220810230914.549611-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5805; h=from:subject; bh=IgDPZkTj8OWicxyeDb2nka/I4dLrq3fbpj7i9AcVc+0=; b=owGbwMvMwCXGf25diOft7jLG02pJDElfrKb8i34rxxl4REllksfUPQ49s+t0LtvEK7VEezyRyD6f XaXYUcrCIMbFICumyPJ3z0fGY3Lb83kCExxh5rAygQxh4OIUgIkkVzAyzH3+ycu7ccvik5bWcncnh+ ud2XIqr23+6a//uufsyfm38SDDPwupGed7tr1j+XR0+YRHyzc8FfC39ktm5VJZ7mJ5W9EgnwcA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v1[1]:
- Collect review tags
- Fix order of setting region size vs UUID (Dan)
- Rename region_{commit,decommit} to region_decode{commit,reset} everywhere (Dan)
- Add a -b <bus> option to all region management commands
- Add a cxl-create-region unit test
- Use walk_children pattern for root decoders vs. regions (Dan)
- Add bus, port, and (root) decoder based filters for regions (Dan)
- Add a 'REGIONS' section to the libcxl(3) documentation (Dan)
- s/--interleave-ways/--ways/ and
  s/interleave-granularity/--granularity/ (Dan)
- Rename and clarify memdev_match_set_size() with a comment (Dan)
- Remove a double init in memdev_match_set_size() (Dan)
- Rework granularity determination (Dan)
- Ensure ep_decoder is free before changing its mode (Dan)
- Fix a mid-series compile breakage in region_action() (Dan)
- Fix missing whitespace in region_action() (Dan)
- Refactor region_action for too much indentation (Dan)
- Save error state from multi-region operations in region_action()
- Free leaky region objects (when the parent decoder is freed)
- Consider root decoder's available size before creating a region (Dan)


[1]: https://lore.kernel.org/linux-cxl/20220715062550.789736-1-vishal.l.verma@intel.com/

---

Introduce the first cut at a 'cxl create-region' command, which uses the
ABI merged in the kernel in [2], and builds on the create-region foundation
laid out in [3].

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

  -g : interleave granularity - selects the interleave granularity
  advertised by the root decoder

  -t : type of region - defaults to pmem. The ram (volatile) type is not
  supported yet.

  -s : size of region - deduced based on sizes of the specified targets

[2]: https://git.kernel.org/torvalds/c/c235698355fa94df7073b51befda7d4be00a0e23
[3]: https://lore.kernel.org/linux-cxl/165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com/


Vishal Verma (10):
  libcxl: add a depth attribute to cxl_port
  cxl/port: Consolidate the debug option in cxl-port man pages
  libcxl: Introduce libcxl region and mapping objects
  cxl-cli: add region listing support
  libcxl: add low level APIs for region creation
  cxl: add a 'create-region' command
  cxl: add commands to {enable,disable,destroy}-region
  cxl/list: make memdevs and regions the default listing
  test: add a cxl-create-region test
  cxl/decoder: add a max_available_extent attribute

 Documentation/cxl/bus-option.txt         |   5 +
 Documentation/cxl/cxl-create-region.txt  | 114 +++
 Documentation/cxl/cxl-destroy-region.txt |  41 ++
 Documentation/cxl/cxl-disable-port.txt   |   5 +-
 Documentation/cxl/cxl-disable-region.txt |  36 +
 Documentation/cxl/cxl-enable-port.txt    |   5 +-
 Documentation/cxl/cxl-enable-region.txt  |  36 +
 Documentation/cxl/cxl-list.txt           |  13 +-
 Documentation/cxl/debug-option.txt       |   4 +
 Documentation/cxl/decoder-option.txt     |   6 +
 Documentation/cxl/lib/libcxl.txt         |  69 ++
 Documentation/cxl/region-description.txt |   7 +
 cxl/lib/private.h                        |  38 +
 cxl/lib/libcxl.c                         | 889 ++++++++++++++++++++++-
 cxl/builtin.h                            |   4 +
 cxl/filter.h                             |   6 +
 cxl/json.h                               |   5 +
 cxl/libcxl.h                             |  67 +-
 cxl/cxl.c                                |   4 +
 cxl/filter.c                             | 158 +++-
 cxl/json.c                               | 131 ++++
 cxl/list.c                               |  26 +-
 cxl/region.c                             | 797 ++++++++++++++++++++
 .clang-format                            |   2 +
 Documentation/cxl/meson.build            |   7 +
 cxl/lib/libcxl.sym                       |  37 +
 cxl/meson.build                          |   1 +
 test/cxl-create-region.sh                | 126 ++++
 test/meson.build                         |   2 +
 29 files changed, 2598 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/cxl/bus-option.txt
 create mode 100644 Documentation/cxl/cxl-create-region.txt
 create mode 100644 Documentation/cxl/cxl-destroy-region.txt
 create mode 100644 Documentation/cxl/cxl-disable-region.txt
 create mode 100644 Documentation/cxl/cxl-enable-region.txt
 create mode 100644 Documentation/cxl/debug-option.txt
 create mode 100644 Documentation/cxl/decoder-option.txt
 create mode 100644 Documentation/cxl/region-description.txt
 create mode 100644 cxl/region.c
 create mode 100644 test/cxl-create-region.sh

-- 
2.37.1

