Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3BBC77B7F
	for <linux-cxl@archiver.kernel.org>; Fri,  5 May 2023 16:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjEEQfX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjEEQfW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 12:35:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF3819420
        for <linux-cxl@vger.kernel.org>; Fri,  5 May 2023 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683304518; x=1714840518;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bDUeIO1ZTyhsQvjRt3cLYCZPAP6oov1I0t8s68dnKYc=;
  b=KmnTuerHRvN6WM5NjEHOth2m2otZ1ULDOfxYU8TlnJe0lmfos9SAaroo
   wPnF3z3/d67e2t1xlDFQUVBYs89m7jvrc04zOUM0otqc2XDd/zEKWp4MF
   mq1tw34ncI9tzdwQTMe84gUGk3heypfA1+RxDZu6zW6pjTmGbEoEAPqu/
   M2Rq/9kEK5NoY4O85ViemkJ6/xvB4AvPZGYraVzuOczuAWr/+VKyMoyw9
   NzRNyyxQfw57DqQp6veNakkRxHu2t7Pxj4AqylsL3iqovFY0+rF+K7iKw
   YDlrmXBYBTn8KdNFGkX5a1KqMj5W+97/osjJB2EujQEbd0P8lj0Rf6lAs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="435566695"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="435566695"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:35:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="821765522"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="821765522"
Received: from nkonan-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:35:17 -0700
Subject: [PATCH 0/3] cxl: Prep for QoS class support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Fri, 05 May 2023 09:35:16 -0700
Message-ID: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

With the "cxl: Add support for QTG ID retrieval for CXL subsystem" series
getting larger and larger and span multiple maintainers, I'm going to try
to break them up into smaller parts. These 3 patches are just preparation
for QTG retrieval. See this series [1] for full series. Full git tree
available at [2]. 

[1]: https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg

---

Dave Jiang (3):
      cxl: Export QTG ids from CFMWS to sysfs as qos_class attribute
      cxl: Add checksum verification to CDAT from CXL
      cxl: Add support for reading CXL switch CDAT table


 Documentation/ABI/testing/sysfs-bus-cxl | 15 ++++++++++
 drivers/cxl/acpi.c                      |  3 ++
 drivers/cxl/core/pci.c                  | 39 +++++++++++++++++++++----
 drivers/cxl/core/port.c                 | 11 +++++++
 drivers/cxl/cxl.h                       |  3 ++
 drivers/cxl/port.c                      |  3 ++
 6 files changed, 69 insertions(+), 5 deletions(-)

--

