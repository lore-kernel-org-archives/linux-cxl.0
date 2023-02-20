Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975B7C6379F
	for <linux-cxl@archiver.kernel.org>; Mon, 20 Feb 2023 01:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBTBg1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 19 Feb 2023 20:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBTBg1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 19 Feb 2023 20:36:27 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F579D504
        for <linux-cxl@vger.kernel.org>; Sun, 19 Feb 2023 17:36:24 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230220013618epoutp023c6fdff5fe5592e5b0cfe8b20c985c38~FZIm1sKn_0161401614epoutp02w
        for <linux-cxl@vger.kernel.org>; Mon, 20 Feb 2023 01:36:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230220013618epoutp023c6fdff5fe5592e5b0cfe8b20c985c38~FZIm1sKn_0161401614epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676856978;
        bh=/IBwnt1tVu0nWCR1VNwMGDzLhw2dt8eo54Zi6bAqvDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p6I1wwbrPBbb/uAs/pi8juiwpf0N7ma2hA/UQTHl6IaV1HmTXSkxzMJhj9QSnkIaD
         Z+58q/EQVZQolYeRLsxQiSYoyHTLn4553ipYd+VR7i8Z8jle/eJFHL9430M/7swdJx
         V1MTBdMPKhiiyVaDEjA5da/u6Q6pnK+IK8yaUkn0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230220013618epcas2p284503f3f48eb531daa308a8b84c74c7f~FZImUzmE02984429844epcas2p2A;
        Mon, 20 Feb 2023 01:36:18 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.99]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PKlPY5ST1z4x9QH; Mon, 20 Feb
        2023 01:36:17 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.32.31307.09EC2F36; Mon, 20 Feb 2023 10:36:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230220013616epcas2p331fee08f8caaa0402ab33ebdd07d868e~FZIkpRO1r1401114011epcas2p3S;
        Mon, 20 Feb 2023 01:36:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220013616epsmtrp20f6066b49efcac868e28c486b9303477~FZIkojbjY0850708507epsmtrp2p;
        Mon, 20 Feb 2023 01:36:16 +0000 (GMT)
X-AuditID: b6c32a46-743fa70000007a4b-e1-63f2ce90fe5a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.BF.05839.09EC2F36; Mon, 20 Feb 2023 10:36:16 +0900 (KST)
Received: from dell-ArcherCity.dsn.sec.samsung.com (unknown [10.229.83.212])
        by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230220013616epsmtip1141e6676fc67c79f8cc7ea9c21e82985~FZIkd9RwJ2340523405epsmtip1J;
        Mon, 20 Feb 2023 01:36:16 +0000 (GMT)
From:   junhyeok.im@samsung.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        Junhyeok Im <junhyeok.im@samsung.com>
Subject: [ndctl 3/3] Documentation: add man page documentation for
 inject-poison
Date:   Mon, 20 Feb 2023 10:37:14 +0900
Message-Id: <20230220013714.22277-3-junhyeok.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220013714.22277-1-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTTHfiuU/JBj1fGC3uPr7AZtE8eTGj
        xfSpFxgtFh+dwWxxftYpFotbE44xObB5LN7zkslj06pONo++LasYPT5vkgtgicq2yUhNTEkt
        UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
        VtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzpj1ZDNbwSyp
        iptv5rM3MN4W7WLk5JAQMJF4eH4BYxcjF4eQwA5Gib077jBBOJ8YJVpOLWOBcL4xSpxZfYQR
        pqX71T5WiMReRonnPZOYIZxGJomXrctZQKrYBGQlrh6+wQ5iiwDZzesegM1lFpjAKLF07kFm
        kISwQJDE+XurgcZycLAIqErsvpkJEuYVsJH4+bCZCWKbvMT+g2eZQUo4BWwlth5jhSgRlDg5
        8wnYKmagkuats8FukBB4yS6xY8ouFoheF4mOIydZIWxhiVfHt7BD2FISn9/tZYOw8yWmHpwI
        FS+RaDtzAMo2lnh38zkryF5mAU2J9bv0QUwJAWWJI7eg1vJJdBz+yw4R5pXoaBOCaFSV2LLh
        BdQQaYmjEzdBHeMh0fZ4CjSkgIFwctlyxgmMCrOQfDMLyTezEBYvYGRexSiWWlCcm55abFRg
        BI/g5PzcTYzgtKjltoNxytsPeocYmTgYDzFKcDArifBKH/qQLMSbklhZlVqUH19UmpNafIjR
        FBjSE5mlRJPzgYk5ryTe0MTSwMTMzNDcyNTAXEmcV9r2ZLKQQHpiSWp2ampBahFMHxMHp1QD
        kwhrl0Cc1umW0zO1auSPamg/99SUmbRhx9cTZaxXnyRH8c9iXSmSaXOmlaE4psl9Vl7fgQ9r
        g1Kb+15wrzq68tJM9WtHLM63bSlf0z7zlG7JOa3uv3IyDB9+b3q60ew347TXl//XPTicGLXd
        YnrG600FynfWT93/6qY1Q/uSy7Jdz/QkLnxuULwXZX7AgP3M/haJawmFK5kEN/ReDf2gZ39f
        bGHyJsEb2guOy7rraYbp5s5clhKsMaPGLuTf4hcT7Uv82N581Z5+dVPrtLDzv59VRe3aEPf1
        7Jv333S6XkWwB38Pbk7KeR555VjA+j1FXCHOd7/YOGiKZL997++28Gf4hX7eaaEXp5U6WodG
        ZimxFGckGmoxFxUnAgBF76iHFAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnO6Ec5+SDR4skrK4+/gCm0Xz5MWM
        FtOnXmC0WHx0BrPF+VmnWCxuTTjG5MDmsXjPSyaPTas62Tz6tqxi9Pi8SS6AJYrLJiU1J7Ms
        tUjfLoErY9aTzWwFs6Qqbr6Zz97AeFu0i5GTQ0LARKL71T7WLkYuDiGB3YwSBz8sZYZISEvc
        eNTFBmELS9xvOQJV9J9RYtKjg2AJNgFZiauHb7CD2CJAdvO6B0wgNrPANEaJ7XsTQWxhgQCJ
        /4/nAg3l4GARUJXYfTMTJMwrYCPx82EzE8R8eYn9B8+ClXAK2EpsPcYKEhYCKml5PI8VolxQ
        4uTMJywgJcwC6hLr5wlBLJKXaN46m3kCo+AsJFWzEKpmIalawMi8ilEytaA4Nz232LDAMC+1
        XK84Mbe4NC9dLzk/dxMjONS1NHcwbl/1Qe8QIxMH4yFGCQ5mJRFe6UMfkoV4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgcu8wvd14PMeI4Y37mwUsQbdn
        BD1l79q2PvGWUkDKrul3K84lpFmfDw2Xf/IlkWdbh+b1SUfvyWta3GqZtLXav69v+STu9Gs2
        11Lm5AneDv6h9lL4GWda6NNH/lPOPVu4JyD29LfvXd9T1DPaOWabs/ltZllz6urnMx+nznz3
        867cg9QVBW+XGprMO+teZuPEc7D69oPUFLc49sYK1l9Ggav/2he9d7eIezcvQsj7kPKaDX1z
        OoLCH210EH19U1AnRjm4UTc04bXH53nX7q+crrzp/h//X8+1iu/q9NXoHFw44d7dHwcij00O
        3V9fphx1VaQqvnNRfVXLXIefpx5XvWJ+t3CFT7jyHHVz5ttM05RYijMSDbWYi4oTAbEU22Pk
        AgAA
X-CMS-MailID: 20230220013616epcas2p331fee08f8caaa0402ab33ebdd07d868e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220013616epcas2p331fee08f8caaa0402ab33ebdd07d868e
References: <20230220013714.22277-1-junhyeok.im@samsung.com>
        <CGME20230220013616epcas2p331fee08f8caaa0402ab33ebdd07d868e@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Junhyeok Im <junhyeok.im@samsung.com>

Add man page documentation for inject-poison command in cxl,
also add the content of cxl_memdev_inject_poison in libcxl.

Signed-off-by: Junhyeok Im <junhyeok.im@samsung.com>
---
 Documentation/cxl/cxl-inject-poison.txt | 42 +++++++++++++++++++++++++
 Documentation/cxl/lib/libcxl.txt        |  4 +++
 Documentation/cxl/meson.build           |  1 +
 3 files changed, 47 insertions(+)
 create mode 100644 Documentation/cxl/cxl-inject-poison.txt

diff --git a/Documentation/cxl/cxl-inject-poison.txt b/Documentation/cxl/cxl-inject-poison.txt
new file mode 100644
index 0000000..d438d33
--- /dev/null
+++ b/Documentation/cxl/cxl-inject-poison.txt
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-inject-poison(1)
+====================
+
+NAME
+----
+cxl-inject-poison - send inject poison command to specified CXL memdev
+                    targeting given DPA.
+
+SYNOPSIS
+--------
+[verse]
+'cxl inject-poison <memdev> -a <dpa> [<options>]'
+
+DESCRIPTION
+-----------
+Add the <dpa> to the <memdev> poison list and the error source shall be set
+to an injected error. In addition, the device shall add an appropriate poison
+creation event to its internal Informational Event Log, update the Event Status
+register, and if configured, interrupt the host.
+
+OPTIONS
+-------
+<memory device>::
+        A 'memX' device name, or a memdev id number. Restrict the operation to
+        the specified memdev.
+
+-a::
+--address=::
+        Physical address of a CXL memdev to inject poison into.
+
+-S::
+--serial=::
+        Specify CXL memory device serial number(s) to filter the listing
+
+include::verbose-option.txt[]
+
+
+SEE ALSO
+--------
+CXL-2.0 8.2.9.5.4.2
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcxl.txt
index f9af376..95f5662 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -132,6 +132,7 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t length,
 			  size_t offset);
 int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t length,
 			   size_t offset);
+int cxl_memdev_inject_poison(struct cxl_memdev *memdev, const char *address);
 struct cxl_cmd *cxl_cmd_new_get_partition(struct cxl_memdev *memdev);
 struct cxl_cmd *cxl_cmd_new_set_partition(struct cxl_memdev *memdev,
 					  unsigned long long volatile_size);
@@ -172,6 +173,9 @@ cxl_memdev{read,write,zero}_label() are helpers for marshaling multiple
 label access commands over an arbitrary extent of the device's label
 area.
 
+cxl_memdev_inject_poison supports injecting poison into a physical address
+on a specified CXL memory device.
+
 cxl_cmd_partition_set_mode() supports selecting NEXTBOOT or IMMEDIATE
 mode. When CXL_SETPART_IMMEDIATE mode is set, it is the caller’s
 responsibility to avoid immediate changes to partitioning when the
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index a6d77ab..a972467 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -46,6 +46,7 @@ cxl_manpages = [
   'cxl-enable-region.txt',
   'cxl-destroy-region.txt',
   'cxl-monitor.txt',
+  'cxl-inject-poison.txt',
 ]
 
 foreach man : cxl_manpages
-- 
2.34.1

