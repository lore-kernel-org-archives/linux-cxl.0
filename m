Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B6C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 21:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiHQVVj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 17:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiHQVVi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 17:21:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B2FA598F
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660771298; x=1692307298;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TdpUEyXIfpj07P3DxshBBcyUXOgH9B8yZRVPowBCcso=;
  b=DNUFJ60i8dcoFgTwCZC48cNZ2xswBbR0tKo57NA9cz5m27lClAHXWEUy
   rds7yEJnG91/IrVdguS31jyEYVMlVvAtVTyf3D9NF/tMpINJGZlyLmCf6
   2O79mSjcTwMjlLdDuW+RoNBUUiN+Mm3Pi7y6pRqBf5y4jBoiPp23M5fIK
   t7wMZwMrczdwdpWZSDu1Sh4Mn6lvlG/+rAeqrAT4A9ClldIlmbX6jg8U/
   BqtrbVLSkRefQQqavP9yyyT0NXu1hgFhZtbNRyPVQP4UGYIcJuNzLAb2v
   1NRJbLuQCMyB3Xcd9J3DXT+yn4K7+x790zzaQa8u7ucz1nP+jAolmaT8L
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="378898274"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="378898274"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:21:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="710712166"
Received: from djiang5-desk4.jf.intel.com ([10.165.157.96])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 14:21:37 -0700
Subject: [PATCH v4 0/6] Add sanity check for interleave setup
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Wed, 17 Aug 2022 14:21:37 -0700
Message-ID: <166077102447.1743055.17158560277276060113.stgit@djiang5-desk4.jf.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The small series adds sanity check for the combination of interleave ways
and interleave granularity during region and port configuration. The
calculation references CXL spec 3.0 8.2.4.19.13 implementation note #3. The
checks also added HDM CAP retrieval for the support of new interleave ways
where 3, 6, and 12 ways support as well as 16 ways support.

v4:
- Add documentation for sysfs entries (Dan)
- Remove unneeded checks for drvdata validity (Dan)
- Add renaming of cxl_port_attribute_groups to cxl_port_dynamic_attr_groups
  (Dan)

v3:
- Move cxl_interleave_capable() to core/region.c. (Dan)
- Open code verify of interleave ways against cap mask. (Dan)

v2:
- Change cxl_interleave_verify() to cxl_interleave_capable(). (Dan)
- Move error output inside verify function. (Dan)
- Remove unneeded enums. (Dan)
- Use is_power_of_2() to detect encoded interleave ways. (Dan)
- Change iw to eiw and ig to eig for encoded values. (Alison)
- Change interleave capabilities to mask for easier comparison. (Dan)
- Change valid_interleave() to valid_interleave_ways()
- Add setting fo interleave_cap to cxl_test. (Dan)

---

Dave Jiang (6):
      cxl: Add check for result of interleave ways plus granularity combo
      cxl: Add CXL spec v3.0 interleave support
      tools/testing/cxl: Add interleave check support to mock cxl port device
      cxl: change cxl_port_attribute_groups naming to avoid confusion
      cxl: export interleave address mask as port sysfs attribute
      cxl: export intereleave capability as port sysfs attribute


 Documentation/ABI/testing/sysfs-bus-cxl | 24 ++++++++++++
 drivers/cxl/core/hdm.c                  |  6 +++
 drivers/cxl/core/region.c               | 50 ++++++++++++++++++++++++-
 drivers/cxl/cxl.h                       |  2 +
 drivers/cxl/cxlmem.h                    |  5 +++
 drivers/cxl/port.c                      | 33 +++++++++++++++-
 tools/testing/cxl/test/cxl.c            |  3 ++
 7 files changed, 120 insertions(+), 3 deletions(-)

base-commit: 1cd8a2537eb07751d405ab7e2223f20338a90506
--

