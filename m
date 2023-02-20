Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45217C05027
	for <linux-cxl@archiver.kernel.org>; Mon, 20 Feb 2023 04:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBTE4S (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 19 Feb 2023 23:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBTE4Q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 19 Feb 2023 23:56:16 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5846CAD0F
        for <linux-cxl@vger.kernel.org>; Sun, 19 Feb 2023 20:56:14 -0800 (PST)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230220045612epoutp02a311608604de0e242391e04a158bd15d~Fb3IimEiO0251302513epoutp02C
        for <linux-cxl@vger.kernel.org>; Mon, 20 Feb 2023 04:56:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230220045612epoutp02a311608604de0e242391e04a158bd15d~Fb3IimEiO0251302513epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676868972;
        bh=Pfrzu8Wbex/JgffOTP9GKaek8xOiG+IofFAMFv8YnRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3g+rvwfxydFaVl6HYgHzgL/vNnBkKHEKc7V6WcmiWuoOp+AavtJDpHKH5YY1dvyh
         E6iKReZMNzm4qMK5nz+1wRhMSmPZ4Occ2/t73crGcIV1szs3e0jkJAFlyvKTnQk+Vx
         unEDpC+zOmyvnSlrxwqMPBcKOjmyQCaxXpOiAJic=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230220045611epcas2p207db0f79cd4059e14ec98437cc811975~Fb3INj-Q41274112741epcas2p2C;
        Mon, 20 Feb 2023 04:56:11 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PKqrC2Vzxz4x9Pt; Mon, 20 Feb
        2023 04:56:11 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.1A.61927.B6DF2F36; Mon, 20 Feb 2023 13:56:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230220045610epcas2p269c76f9b80a8d18d357af396b2968970~Fb3HTJWbd1274112741epcas2p29;
        Mon, 20 Feb 2023 04:56:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220045610epsmtrp259f02d9e0c55e74c79ca47579018902c~Fb3HQwYgt0918909189epsmtrp2W;
        Mon, 20 Feb 2023 04:56:10 +0000 (GMT)
X-AuditID: b6c32a45-e942ca800001f1e7-61-63f2fd6bb2cb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.63.05839.A6DF2F36; Mon, 20 Feb 2023 13:56:10 +0900 (KST)
Received: from dell-ArcherCity.dsn.sec.samsung.com (unknown [10.229.83.212])
        by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220045610epsmtip2e07fa35a96cbe13dc1c4fd1fab22963f~Fb3HC-1T73014230142epsmtip2I;
        Mon, 20 Feb 2023 04:56:10 +0000 (GMT)
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        Junhyeok Im <junhyeok.im@samsung.com>
Subject: [ndctl 3/3] Documentation: add man page documentation for
 inject-poison
Date:   Mon, 20 Feb 2023 13:57:09 +0900
Message-Id: <20230220045709.94027-4-junhyeok.im@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220045709.94027-1-junhyeok.im@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTVDf776dkg+YnghZ3H19gs2ievJjR
        YvrUC4wWi4/OYLY4P+sUi8WtCceYHNg8Fu95yeSxaVUnm0ffllWMHp83yQWwRGXbZKQmpqQW
        KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
        K+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZzyZPpGx4LVk
        xfQ73xgbGDeLdjFyckgImEgcu7OItYuRi0NIYAejxPtJv9kgnE+MEpN2LoByvjFK/Nm0lh2m
        5e7tuewQib0gLZ1Q/Y1MEmemfmcBqWIT0Jb42z+dEcQWEZCVaF73gAmkiFlgAqPE0rkHmUES
        wgJBEufvrQYrYhFQlbj0fQbYCl4BG4mXE76xQayTl9h/8CxYPaeArcSu50tYIWoEJU7OfAK2
        jBmopnnrbGaQBRICL9kl/m75C7SNA8hxkVj8MQdijrDEq+NboF6Qkvj8bi/U/HyJqQcnQsVL
        JNrOHICyjSXe3XzOCjKGWUBTYv0ufYiJyhJHbkFt5ZPoOPyXHSLMK9HRJgTRqCqxZcMLqCHS
        EkcnbmKBsD0kLlw5DA1QYCjcfbOUeQKjwiwkz8xC8swshMULGJlXMYqlFhTnpqcWGxUYwmM4
        OT93EyM4MWq57mCc/PaD3iFGJg7GQ4wSHMxKIrzShz4kC/GmJFZWpRblxxeV5qQWH2I0BQb1
        RGYp0eR8YGrOK4k3NLE0MDEzMzQ3MjUwVxLnlbY9mSwkkJ5YkpqdmlqQWgTTx8TBKdXAtI5F
        NfaWxRdPPYe/R61vWhfkiG2JjF8Q+cnYoW2O6/MvK7kcr8cXsAhLJYW83ZzmMmGtcnZR1p3D
        PyRZ3/9sm3F8icCL9V0uzN21e+e+0RSYyR5wrMLU9dSzB/O+yxcUskWs/ZYi4XajR+HQkbWF
        s6+kJNa5+F40X/Hzj2bdGvNLS5eoMnywcEi/9k5U8snSsBU9xt1fAicLrVj1aMExh+mf86JU
        loZ8m1+1VHPC5tNBohEBJa+WaNgqrNh34rWmmYd7T+zFPU21fF8btk6eHWnLUFWUz+yy99jn
        xWZHdghE/+7KKOuYz1KrZf7fK9b4y2MLm46NN0RtnF6qyl/tStly1DWxYrsT8/YUj/1OSizF
        GYmGWsxFxYkAXHp2ehUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvG7W30/JBr2X9CzuPr7AZtE8eTGj
        xfSpFxgtFh+dwWxxftYpFotbE44xObB5LN7zkslj06pONo++LasYPT5vkgtgieKySUnNySxL
        LdK3S+DKeDJ9ImPBa8mK6Xe+MTYwbhbtYuTkkBAwkbh7ey57FyMXh5DAbkaJvbOXM0MkpCVu
        POpig7CFJe63HGEFsYUE/jNKHP+uDGKzCWhL/O2fzghiiwjISjSve8AEYjMLTGOU2L43EcQW
        FgiQ+P94LthMFgFViUvfZ7CD2LwCNhIvJ3yDmi8vsf/gWbAaTgFbiV3Pl0DtspH4OeshVL2g
        xMmZT1i6GDmA5qtLrJ8nBLFKXqJ562zmCYyCs5BUzUKomoWkagEj8ypGydSC4tz03GLDAsO8
        1HK94sTc4tK8dL3k/NxNjOBg19Lcwbh91Qe9Q4xMHIyHGCU4mJVEeKUPfUgW4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgWn7r8JYj6oXGwUjPk0LMpIM
        MHknYpObE160T+3bemCEm0Zc55mp5dObW7ia6XPisSwn9XIemUmX826UJ5ndnjrdt1IioWHG
        Pp8Fwu/buBTq7laruwbsceqbpHdFv4fnqIra+aZbW6wi+kuuf3vwboZb/zRzXh+jO5c9hWs+
        Ppv2wvsa/7dQ5zVGty/uZ7DpfWxz2qzIe8Hh1Zy3/stxMWxY4Sx8I7E/6cPU4Fy3W1XWXSW7
        zt3UjHt57DXH8VcXzm7elTZH1fB4yez1x1siVZf8lOep5LM/6v++7cavaQba59R69Lf6s9yN
        L3z5gMFbZvbF2079qx+Jfcy+LTD3pc+HyRLFTat8Tn958enrRSWW4oxEQy3mouJEALPMx/zl
        AgAA
X-CMS-MailID: 20230220045610epcas2p269c76f9b80a8d18d357af396b2968970
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220045610epcas2p269c76f9b80a8d18d357af396b2968970
References: <20230220045709.94027-1-junhyeok.im@samsung.com>
        <CGME20230220045610epcas2p269c76f9b80a8d18d357af396b2968970@epcas2p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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

