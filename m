Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7439C7EE2A
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 02:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjERCqC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 May 2023 22:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjERCqA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 May 2023 22:46:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79583359D
        for <linux-cxl@vger.kernel.org>; Wed, 17 May 2023 19:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684377959; x=1715913959;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=qnWfb9hkooDpADyTqUEyDgZ2+WuSlil5+fqo5AwuI5M=;
  b=X0mKtULV2m6SctbX1Kgr4/IQbgimXG/FDFseZWB+oigIVxdg5BFpLYuf
   fGXrUqkdAMkVichHDUzcDPJN5ZTtrdSUJaJ2nsr8NBKnziljh3K78Obmw
   1FDdXlw90C4sCT2urRf0Udgv+PqvieIU9JLp2MbxfifTQWoHz/PT8KEMa
   e/Cll4dKN+0XOf4qbdZBnBsfCAEUgVjreBnV29JTzuw1WmApZTxEef8Fe
   cQ9qbm2ZdlH18V75soCuxVUWPTKrZOp+GS+Py1mxDBK5i6+JRJqMSKxv7
   Y4M4PhlF8CMjhIxF/lqNrQFoiiBW0ekqUsw1eVEo8F2R/2ejU3i6Sk23X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="380147084"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="380147084"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652466703"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="652466703"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.143.168])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 19:45:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
Date:   Wed, 17 May 2023 19:45:53 -0700
Message-Id: <20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGRZWQC/x2NQQrCMBAAv1L27NJmtZF6FXyAV/GwSTY2oLEkW
 pTSv5t4HJhhFsiSgmQ4NAskmUMOz1hAbRqwI8ebYHCFgTradr3aY/IWX99JCJ3MaMlprZgGN2g
 ojeEsaBJHO9bK7FonHuuD7xjfj+pMSXz4/J8XOJ+OcF3XH6fHoJeIAAAA
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684377956; l=1747;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=qnWfb9hkooDpADyTqUEyDgZ2+WuSlil5+fqo5AwuI5M=;
 b=6oT1KtD5b4/SFfQBd1NDLYZ2CM9xW4vAc340QFuWUMHD+FjqmjIFvtkNiNNGAzkBXc+O8veKR
 0Zzcls8SX0rAtPIvXplaRy0hEG4leNVeB1wdMG/tliFJXmFp1BiK/Vx
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Type 2 devices are not yet a reality.  Developing core kernel support
is difficult without some test device to model against.

Define a type 2 device 'cxl-accel'.  This device is derived from the
type 3 device and retains all that functionality for now.

Mock up a couple of accelerator features (Back Invalidate [BI] and
Unordered IO [UIO]) as examples for the RFC.  These have no
functionality other than to report the features as present for software
to key off of.

Defining these devices in qemu can be done with the following example:

...
  -device cxl-accel,bus=sw0p0,volatile-memdev=cxl-ac-mem5,id=cxl-dev5,sn=0xCAFE0005
...

NOTE: I'm leaving off Michael Tsirkin for now because this is really
rough and I'm mainly sending it out because it was talked about in the
CXL community call on 5/16.

Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (5):
      hw/cxl: Use define for build bug detection
      hw/cxl: Refactor component register initialization
      hw/cxl: Derive a CXL accelerator device from Type-3
      hw/cxl/accel: Add Back-Invalidate decoder capbility structure
      hw/cxl: Add UIO HDM decoder register fields

 docs/system/devices/cxl.rst    | 11 ++++++
 hw/cxl/cxl-component-utils.c   | 80 +++++++++++++++++++-----------------------
 hw/mem/cxl_type3.c             | 39 ++++++++++++++++++++
 include/hw/cxl/cxl_component.h | 51 +++++++++++++++++++--------
 include/hw/cxl/cxl_device.h    | 16 +++++++++
 include/hw/pci/pci_ids.h       |  1 +
 6 files changed, 141 insertions(+), 57 deletions(-)
---
base-commit: 8eb2a03258313f404ca0c8609a8f9009b9b4318c
change-id: 20230517-rfc-type2-dev-c2d661a29d96

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

