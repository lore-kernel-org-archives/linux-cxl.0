Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83CBC678D5
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 08:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCGIUN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 03:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCGITs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 03:19:48 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA45206A1
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 00:19:24 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230307081919epoutp043f7c6a1d2e815583a48f76ea46e443ec~KFTwjMmwQ0037200372epoutp04u
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 08:19:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230307081919epoutp043f7c6a1d2e815583a48f76ea46e443ec~KFTwjMmwQ0037200372epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678177159;
        bh=KGL9ojWmMtRFLna4hkq7D+CeXrW+e1kC0rgPsUN9svY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Sc2vmlQtc+BogGBVq7Si1qT7HqZUi0FdfsY9+1A+QyruyztILxe/5QjZ9UC6ON1JB
         42mr1i2/ZrQMtAcbYSfpbhlk7gnIzn7b9Cuxc9bFm57KQi1OCcqm4wHta0zQuzTlTU
         0pWMtXiEsl7cAQhuOmH9orbK4MJfxHiSDHTeqVLM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230307081918epcas2p432d41abf692b836336df04b273cdb4b6~KFTv-VHuu0062400624epcas2p4Y;
        Tue,  7 Mar 2023 08:19:18 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PW7dd62t4z4x9QJ; Tue,  7 Mar
        2023 08:19:17 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.29.61927.583F6046; Tue,  7 Mar 2023 17:19:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788~KFTu85ry-1880318803epcas2p1X;
        Tue,  7 Mar 2023 08:19:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230307081917epsmtrp2fa2aee965bb19820e77554ead7112e7c~KFTu7jxfE0592305923epsmtrp2c;
        Tue,  7 Mar 2023 08:19:17 +0000 (GMT)
X-AuditID: b6c32a45-671ff7000001f1e7-56-6406f3855ae7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        75.22.18071.583F6046; Tue,  7 Mar 2023 17:19:17 +0900 (KST)
Received: from dell-Precision-7920-Tower.dsn.sec.samsung.com (unknown
        [10.229.83.133]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230307081917epsmtip231b9fb7641f509c3376b6c916a2220df~KFTuwQfLT3147031470epsmtip2D;
        Tue,  7 Mar 2023 08:19:17 +0000 (GMT)
From:   Jehoon Park <jehoon.park@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        bwidawsk@kernel.org, jehoon park <jehoon.park@samsung.com>
Subject: [ndctl patch RFC 0/2] add support for IDENTIFY command
Date:   Tue,  7 Mar 2023 17:21:00 +0900
Message-Id: <20230307082102.27195-1-jehoon.park@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7bCmhW7rZ7YUgx9HDCzuPr7AZtE8eTGj
        xfSpFxgt9j99zmJx4HUDu8X5WadYLG5NOMbkwO6xeM9LJo9NqzrZPPq2rGL0+LxJLoAlKtsm
        IzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gCJYWyxJxS
        oFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xsG2
        G4wF/8QqJl/9zdzA2CfQxcjJISFgInFl6jzmLkYuDiGBHYwSs0/2s4AkhAQ+MUpsWesAYX9j
        lOg5rAPTcGniHUaIhr2MEtM3fYXq7maSuH3lIitIFZuAtsT97RvYQGwRAVmJ5nUPmECKmAWW
        M0os3v+TGSQhLGAv0bfxCROIzSKgKvHy03Ywm1fARuLUo1PsEOvkJVZvOAC2QUJgGbvE++6z
        bBAJF4nLy49BFQlLvDq+BcqWkvj8bi9UTb7Ez5O3WCHsAolPXz6wQNjGEu9uPgeKcwBdpCmx
        fpc+iCkhoCxx5BZYBbMAn0TH4b/sEGFeiY42IYhGVYmu4x8YIWxpicNXjjJD2B4Sc3ouMEIC
        K1aiuW8vywRG2VkI8xcwMq5iFEstKM5NTy02KjCEx1Fyfu4mRnCa0nLdwTj57Qe9Q4xMHIyH
        GCU4mJVEeN++Y0sR4k1JrKxKLcqPLyrNSS0+xGgKDK6JzFKiyfnARJlXEm9oYmlgYmZmaG5k
        amCuJM4rbXsyWUggPbEkNTs1tSC1CKaPiYNTqoFpecH9Z5/zbHY+VHnkwFEaYb0zJUt1gff9
        A/HfZt+/Z2chsL199SO+eZNEY1Pv5fCp5SfZhWVM3qu5Qe1WqQzL5ltMVpf99mz/lzeziUVr
        +Rzd6oRY3duXF8YeNOiuieXfs69i1eIKTn/3RUdKPn9n7ihY+3DfhszofvnX0w5tSnx7eIea
        /5vHYUfWvHj/8HvwLEbWD9P2SvnVsor7X3q3LYSdo/j0GuF5Lm4OGQv/WP87dTRwWvpVQbvG
        28EZ9+RMzG5+aelaa+596ZIyk+ZB37VLGx1Kb098dnvZlbDfsUcaHlvs/u3W9VoxdE/1hDlV
        J86r/VE4m57mMPX96f/pt3L8jy9Wcrocw+AYLmx0U4mlOCPRUIu5qDgRAMGL8BzcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJMWRmVeSWpSXmKPExsWy7bCSvG7rZ7YUg/tnRS3uPr7AZtE8eTGj
        xfSpFxgt9j99zmJx4HUDu8X5WadYLG5NOMbkwO6xeM9LJo9NqzrZPPq2rGL0+LxJLoAlissm
        JTUnsyy1SN8ugSvjYNsNxoJ/YhWTr/5mbmDsE+hi5OSQEDCRuDTxDiOILSSwm1HiziI+iLi0
        xL3mK+wQtrDE/ZYjrF2MXEA1nUwS02ddAGtgE9CWuL99AxuILSIgK9G87gETiM0ssJZR4lyb
        MIgtLGAv0bfxCVicRUBV4uWn7WA2r4CNxKlHp6AWyEus3nCAeQIjzwJGhlWMkqkFxbnpucWG
        BYZ5qeV6xYm5xaV56XrJ+bmbGMGho6W5g3H7qg96hxiZOBgPMUpwMCuJ8L59x5YixJuSWFmV
        WpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA1PA1I3zH9y0DX5h+PHt
        o4qKqAvtz+7+ninQYj6vNcXKI7HgtGPta8YzRgv2zd9+N6OVe+aSn4W/9DdPqDtxTfKZwhU3
        q+wop7sZ9gzWuV+mNyze6iaf3XQ38l2m3YpFa9ivikXM8Y45ynLEYVW3nvDTP4+0AzYrvtTV
        W83LNEX58M20LblySToe7W1Fy1+12nfEfPwyecVE5+T7zL0mvblLnJOvHs6JrUve4M2zVqCg
        yEks8pB+4uyZ3Cm37ixtk4vtXtez7N3/8kt/F26099JYVOJrV3nlvO+OlbNcFfc8X+1+K1Yy
        YHWNz0yZB7fvXGk88G++aijLzLfL1L+G9C9ex9rb+TA5f6LhHF4F0X4lluKMREMt5qLiRADW
        MEa0jAIAAA==
X-CMS-MailID: 20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788
References: <CGME20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: jehoon park <jehoon.park@samsung.com>

This patchset supports CXL IDENTIFY mailbox command and corresponding
cxl tool interface command.

CXL 3.0 Spec 8.2.9.8.1 defines IDENTIFY command which retrieves basic
information about CXL memory device. The information consist of device's
firmware version, capacity, LSA size, event log size, poison list size,
inject poison limit, poison handling capabilities and QoS telemetry
capabilities. Firmware version, capacity and LSA size are already supported
and used for partition commands or sysfs attributes while others are not.
Since patches about event log [1] and poison [2] are discussed recently,
support for those information will be helpful.

Example:
# cxl identify mem0
FW Revision                              : BWFW VERSION 00
Total Capacity                           : 1.00 GB
Volatile Only Capacity                   : 1.00 GB
Persistent Only Capacity                 : 0 B
Partition Alignment                      : 0 B
Informational Event Log Size             : 0
Warning Event Log Size                   : 0
Failure Event Log Size                   : 0
Fatal Event Log Size                     : 0
LSA Size                                 : 0 B
Poison List Maximum Media Error Records  : 256
Inject Poison Limit                      : 0
Poison Handling Capabilities
Injects Persistent Poison                : Not Supported
Scans for Poison                         : Not Supported
QoS Telemetry Capabilities
Egress Port Congestion                   : Not Supported
Temporary Throughput Reduction           : Not Supported
cxl memdev: cmd_identify: identified 1 mem

This patch is RFC because some of the information are already provided by
"list -m <memdev>" command and sysfs attributes.
I think a separate cxl tool interface command for identify is useful to provide
device's information clearly. In case of nvme-cli, there are separate
interface commands for identifying controller and namespace: id-ctrl and id-ns.

[1] https://lore.kernel.org/linux-cxl/20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com/
[2] https://lore.kernel.org/linux-cxl/cover.1676685180.git.alison.schofield@intel.com/

jehoon park (2):
  libcxl: add accessors for IDENTIFY command
  cxl: add identify command to cxl tool

 Documentation/cxl/cxl-identify.txt |  57 ++++++++++++
 Documentation/cxl/meson.build      |   1 +
 cxl/builtin.h                      |   1 +
 cxl/cxl.c                          |   1 +
 cxl/lib/libcxl.c                   |  73 +++++++++++++++
 cxl/lib/libcxl.sym                 |  11 +++
 cxl/lib/private.h                  |  11 +++
 cxl/libcxl.h                       |  16 ++++
 cxl/memdev.c                       | 141 +++++++++++++++++++++++++++++
 9 files changed, 312 insertions(+)
 create mode 100644 Documentation/cxl/cxl-identify.txt


base-commit: b830c4af984e72e5849c0705669aad2ffa19db13
-- 
2.17.1

