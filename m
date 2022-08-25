Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F90ECAA25
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Aug 2022 16:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbiHYQHi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 Aug 2022 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiHYQHh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 Aug 2022 12:07:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6CAAC249
        for <linux-cxl@vger.kernel.org>; Thu, 25 Aug 2022 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661443656; x=1692979656;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=21m/NXVGw0EE9czJlMv9VW+2c7/Qkb4r8xPvwArwWgI=;
  b=B3V1lgm5NJgnk5jiv+imIzS0qpaf8DRQb76yVqb83XJm5iNsY7bNgmV4
   zD9jXSS065Lp01j6vcuQPIt1jXpYRxQbWRK3m7WpK/IQellGPNppXYQXP
   AYa8iSQgvwgOaIbEZY+h0qkOGVlUMaGbiy2o06RZslt8zTgz/Hbgn6ioO
   6EWZTmZDYSye1zE1kJ6zviqeUnPnm0xur6tmZG2i6xrvaf862QhsaJqKa
   5e6hemb32CZpAm0nAqcH9wGkW8whTJ2MGzDr2ftnsMKcrS/R2ksbW/V/K
   C/x5OCpz1eaz9/+8Lr0dUT29jz9oPr200y1/zLKL3A7jjdU67xf7Y2wUR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295558206"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="295558206"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:07:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="671054156"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:07:35 -0700
Subject: [PATCH v5 0/6] Add sanity check for interleave setup
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Thu, 25 Aug 2022 09:07:34 -0700
Message-ID: <166144343809.745916.16054560464363829844.stgit@djiang5-desk3.ch.intel.com>
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

v5:
- Various spelling errors (Jonathan)
- Make "CXL spec rev3.0" changes throughout to be consistent (Jonathan)
- Change CXL_HDM_INTERLEAVE_CAP_DEFAULT to CXL_HDM_INTERLEAVE_CAP_BASELINE
  (Jonathan)
- Fix up commit header in reference to cxl_interleave_verify() to
  cxl_interleave_capable() (Jonathan)
- Move dev_set_drvdata() for cxl_test to first patch (Jonathan)

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

