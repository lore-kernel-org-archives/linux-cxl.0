Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C00C77B78
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 17:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDNRnI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDNRm5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 13:42:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE7189
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681494176; x=1713030176;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qdqmdgfUNxfyS6dl7ZKj+hKjiuO/PDNVv9QE5iTVu9g=;
  b=SCVBQO1G3kk3o0EAv2wVmv8ee+Iodz/8ngfwh9ILOIX3wughJtYuN+Ze
   BX8GoTVUBniiuX8ToeoGzg8tHRMpWeNZ3c4Z/h1LopIy1iE8oRRvvV8NN
   l3BqazdZrruru3zocKpwsf+7Opr9g3jbBbxKyZhhov20PSzyosoDDBASU
   0TA9zqu9fcaZa0IjcPRbSNoaVH3hPnfvHUWrKtGv7IEDRPLOfj9nRL6IC
   jSgezsK/QVKj2gk1kl1NAanHfAO/8WZA6Qj6atXhFH9i5jf3ttWCpwBdD
   sfAulx9nDlwlUdJJw+MjbvEhr6LIY28E7yapQ8snq9jJFULEPB7HE6E5o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="407405469"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="407405469"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:42:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="813967553"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="813967553"
Received: from tpattadx-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.122.87])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:42:56 -0700
Subject: [NDCTL PATCH 0/3] ndctl: Add support of QoS Throttling Group (QTG) id
 for CXL CLI
From:   Dave Jiang <dave.jiang@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org
Date:   Fri, 14 Apr 2023 10:42:55 -0700
Message-ID: <168149412855.4013891.16386221304030694671.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The series adds support for the kernel enabling [1] of QoS Throttling Group
(QTG) id. The kernel exports a QTG id for the root decoders (CFMWS) and as
well as for the CXL memory devices. The QTG id exported for a device is
calculated by the driver during device probe. Currently a QTG id is exported
for the volatile partition and another for the persistent partition. In the
future QTG id(s) will be exported for DCD regions. Display of QTG id is
through the CXL CLI list command.

A QTG id check as also been added for region creation. A warning is emitted
when the QTG id of a memory range of a CXL memory device being included in
the CXL region assembly does not match the QTG id of the root decoder. Options
are available to suppress the warning or to fail the region creation. This
enabling provides a guidance on flagging memory ranges being used is not
optimal for performance for the CXL region to be formed.

[1]: https://lore.kernel.org/linux-cxl/168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3/T/#t

---

Dave Jiang (3):
      ndctl: Add QTG ID support for the root decoder
      ndctl: Add QTG ID support for the memory device
      ndctl: add QTG ID check for region creation


 Documentation/cxl/cxl-create-region.txt |  9 ++++
 cxl/json.c                              | 22 +++++++++-
 cxl/lib/libcxl.c                        | 31 ++++++++++++++
 cxl/lib/libcxl.sym                      |  3 ++
 cxl/lib/private.h                       |  3 ++
 cxl/libcxl.h                            |  5 +++
 cxl/region.c                            | 57 ++++++++++++++++++++++++-
 7 files changed, 128 insertions(+), 2 deletions(-)

--

