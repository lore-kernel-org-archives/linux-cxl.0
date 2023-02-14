Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867C9C61DA4
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 11:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjBNLWP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 06:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjBNLV7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 06:21:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3446810425;
        Tue, 14 Feb 2023 03:21:56 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PGJf635BZz67HtH;
        Tue, 14 Feb 2023 19:20:14 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.244.26) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 11:21:54 +0000
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH V4 0/4] rasdaemon: Add support for the CXL error events
Date:   Tue, 14 Feb 2023 11:21:39 +0000
Message-ID: <20230214112143.798-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.244.26]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Log and record the following CXL errors reported through the kernel
trace events. CXL poison errors, CXL AER uncorrectable errors and CXL AER
correctable errors.

Note1: The default poll method in the rasdaemon to receive
the trace events does not work due to a commit in the kernel trace system.
Solution 1:
3e46d910d8acf94e5360126593b68bf4fee4c4a1("tracing: Fix poll() and select()
 do not work on per_cpu trace_pipe an……d trace_pipe_raw") in Linux 6.2-rc7
 or later. and
https://lore.kernel.org/lkml/20230204193345.842-1-shiju.jose@huawei.com/T/

Solution 2: 
Thus instead used the pthread way for testing the CXL error events.
To do so, please make following change in the ras-events.c
<change start ...>
/* rc = read_ras_event_all_cpus(data, cpus); */
rc = -255;
< ...change end >
/* Poll doesn't work on this kernel. Fallback to pthread way */
if (rc == -255) {
...

Shiju Jose (4):
  rasdaemon: Move definition for BIT and BIT_ULL to a common file
  rasdaemon: Add support for the CXL poison events
  rasdaemon: Add support for the CXL AER uncorrectable errors
  rasdaemon: Add support for the CXL AER correctable errors

Changes:
V3 -> V4
1. Modifications for the changes in the kernel patches
   a) https://lore.kernel.org/lkml/cover.1675983077.git.alison.schofield@intel.com/
   b) https://lore.kernel.org/linux-cxl/63e5ed38d77d9_138fbc2947a@iweiny-mobl.notmuch/T/#t

V2 -> V3
1. Fix for the comments from Dave Jiang.

RFC V1 -> V2
1. Rename uuid to region_uuid in the log and SQLite DB.
2. Rebase to the latest rasdaemon code.
3. Modify to match the name changes of interface structures and
   functions in the latest libtraceevent-dev, use in the rasdaemon. 


 Makefile.am                |   7 +-
 configure.ac               |  11 +
 ras-cxl-handler.c          | 398 +++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h          |  32 +++
 ras-events.c               |  33 +++
 ras-events.h               |   3 +
 ras-non-standard-handler.h |   3 -
 ras-record.c               | 209 +++++++++++++++++++
 ras-record.h               |  52 +++++
 ras-report.c               | 225 +++++++++++++++++++++
 ras-report.h               |   6 +
 11 files changed, 975 insertions(+), 4 deletions(-)
 create mode 100644 ras-cxl-handler.c
 create mode 100644 ras-cxl-handler.h

-- 
2.25.1

