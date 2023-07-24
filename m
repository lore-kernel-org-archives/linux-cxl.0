Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F62C04A6A
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjGXQXe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGXQXa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:23:30 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3B718E
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:23:25 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230724162323usoutp016b556e1e7a95f83ea0248a2729d27aac~02lGKl4Eh2720227202usoutp01_;
        Mon, 24 Jul 2023 16:23:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230724162323usoutp016b556e1e7a95f83ea0248a2729d27aac~02lGKl4Eh2720227202usoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690215803;
        bh=C4aTzaNtGHKVgJ50XEww+sc4KO9zZq8bdfgSZbWIqXU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=vgiMdk8WDFMPvaWfRBSUpOZeJsmlnLZDGOEczbfT3qXRnP7eYaGyFFTbFRPoJu+aS
         pc90seXOA0JzdM5JU3x+0PgVntRG4Nkson13+mvTMmCCQPNQhNz5nTggl5pMzQ0xXh
         IOuAyvTVJeitaLRe6rpLmtEI2SM9Viltg+aQo9EE=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162323uscas1p2d430cfe9ef07dafe0e44de2b64b62ab8~02lF9a9cw0598305983uscas1p2a;
        Mon, 24 Jul 2023 16:23:23 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 19.78.42611.B75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230724162323uscas1p16c295c61b82f774fb23eedfab4dfff28~02lFiHjoY1496114961uscas1p10;
        Mon, 24 Jul 2023 16:23:23 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-9a-64bea57b50cf
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 1B.8B.38326.A75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 24 Jul 2023 09:23:22 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        24 Jul 2023 09:23:22 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [Qemu PATCH RESEND 1/9] hw/cxl/cxl-mailbox-utils: Add
 dc_event_log_size field to output payload of identify memory device command
Thread-Topic: [Qemu PATCH RESEND 1/9] hw/cxl/cxl-mailbox-utils: Add
        dc_event_log_size field to output payload of identify memory device command
Thread-Index: AQHZvksqhijwK0T7Vk+qA4s8EDYBFA==
Date:   Mon, 24 Jul 2023 16:23:22 +0000
Message-ID: <20230724162313.34196-2-fan.ni@samsung.com>
In-Reply-To: <20230724162313.34196-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0wTWRjFc2em7VBtMtRKP3WjQhSjxgpidBJlVyMmg8aExJgg8TWBEdBS
        sAPic202gBHLy4JKEQEBYwsGfEShIpWCCKgBNdKCEUQRRBBk0WUx+KCdmvDf79zvnPudm1wS
        lz8VzSWjNfGcVsOqfcRS4k7j19YVx0trI/wmHvnSZ1srEX0hpw3RZR3liNb985agk+6NYLT1
        fT9Bm4vaxXSrsYWg+7P6Mbq05C1OP0qrIjbMYNoMmSKmWLeZqTa+ljBJDZ+mVM0AxtwY/Slh
        ettvYcytwQ84k5N3ihm7OT9EGiZdH8Gpow9z2pV/7pNGVdgsKO6V7Ej6N6tEh9JmpCIPEqjV
        UNHwAKUiKSmnTAhaJq0iQSRjUHe+HP/tKpvQu13XEbTlFhKC+BdBX0q6WBBXEdgL9RJnREx5
        Q23qXbGTFVQANNaX4E4TTn0iYLR8yBWfRekRFI+VuDYqqCwEE4PnkBBRwbNLE5iTCWox2Koy
        XNfKqLUwWJriYg+KhsrnTSInI8oLxlvKXX6cUkJnbwEmNPeEK3k17ld4wQ9Lj1jgBWD4/6Kb
        vaF7fEAiZFXgyMkWC7wcrhYN4sJeT2jO7SUE/xyou+Zws8ED+pMXCRwEL3sy3LvmwUt7zhST
        UxwO5lGpcKyGgpLb7ug6KJqswDLRIuO01sZpLYzTWhintShEhBkpE3g+JpLjV2m4RBXPxvAJ
        mkhVeGzMTTT14x7/qI+tQvbOUZUNYSSyISBxH4XMf1dthFwWwR49xmlj92oT1BxvQ/NIwkcp
        8w9sDpdTkWw8d5Dj4jjt7ylGeszVYQtefNNhP62Zvc2ZKfbipo0pM/c7qsfC/r7W3DcZIrfk
        q6v2hyUlluV5894HQr1C4WTalXcn9XfsgQ8/PI57KKor0HguJ/w66zTIVE+hhYbuLDRTJJ3d
        Ea8PbHtw7nTI6YYAz4CD0Y4/7geT85NP5BmGuiyJ7/4LelJvMgcN3d6ZLovd/iTZt3HrsMWY
        P+6nvBGyxvQFt55K3xIc15Sb/9ch8vIO9uy2YkVllHin39OlF6MCujbtVtRcUFwfYLo12Hrl
        whOts/1re8x3t30fsb8Z2MgezhhbcsaUPZwYGUo7Dkhb+taxH9d0jKT51piGyqqD2/cM74lZ
        1rFhZfbnriNmH4KPYv2X4Vqe/QWV60Z/4AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA03Se0hTURwHcM597W4yuE7Toz3MlX+ktVpFXSoqTeGCEIUZqL1Gu63VNNtc
        WUGtB5ampqlpU3y/SlFbWatMa2Y6i3xQpkaYafkYGbmVzzLnJfC/z5dzvud3DhwSFVkwd1IZ
        EcWqI2QqMSHAlDrk5qpzRbXyNSN9JH29pQrQ6WmtgC7rKge07tIXjL7y9AdC130dwOi7eR0E
        3aJvxuiB5AGELir8gtKNCUZsuwPTmpKEMwW6AOax/hOPufLy+2yqGUKYez9neEx/x32EuW8Z
        RJm0zAuM1bBklyBUsEXOqpSnWPXqrYcERytNT0DkR2F04mQdTwcSHOIAn4TUelg2EQ/igIAU
        UWUATnRacC6MAlg+FktwoRjAqxkphL1CUJ6wNu7RnJ2pdfBVfSFqN0pZMPi7zcFecKLiASyw
        Fs4d5UwlA/gp9xnKNSSwLWsCsRujvKDJeINnt5DaCC1FMXMWzfqNoW7OfIqGVe1NuN2AcoFj
        zeUIN80VdvfnINwjKFhY04JyXgCH+v7inD1gyngGwdkT9owN8biuBHampRKcfWBxngXl7uAI
        zbf7MW6/G3xR2oklAaifN04/r66fV9fPq+cC7C5w1Wo04YpojTSCPS3RyMI12giF5PCJcAOY
        /Q+v/9aHGEFD90+JCSAkMAFIomJnoXRfrVwklMvOnGXVJw6qtSpWYwILSUzsKhQFJB8UUQpZ
        FHucZSNZ9f9VhOS76xBtz2L1n9sf/RTyqSRPa0Xthp6wreTlljgpXz4eqBp0m7RVll1rqPzd
        m7tzdJm2ZCQ7tPftdGtX4LO+/dsMw/ivM049mYb4IJdmcXCM7VJ6KW0733iPeLBo56bskwEh
        vua+DxnvqhK8K6TLzal6XxZKjv0xr7VJc6q7Uf8Vk8MePkvxfYO7dtccaOfjm5vj2+r6pz7M
        KKtWui/iTzkE+TWOdr9/Rd/JJ6ubQtKiI7uOjGsTb4V9H3hu5NmCEbz09JFiL0f/4pEwQexK
        ldYSczEfLRF5NOmVx8wew0ZrVk6u4sWU5JsV/+Y2OD0kEe7Y8zn8OE0EN4W5TY/O7H1oFWOa
        ozKpN6rWyP4Bd5T0hn4DAAA=
X-CMS-MailID: 20230724162323uscas1p16c295c61b82f774fb23eedfab4dfff28
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724162323uscas1p16c295c61b82f774fb23eedfab4dfff28
References: <20230724162313.34196-1-fan.ni@samsung.com>
        <CGME20230724162323uscas1p16c295c61b82f774fb23eedfab4dfff28@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Based on CXL spec 3.0 Table 8-94 (Identify Memory Device Output
Payload), dynamic capacity event log size should be part of
output of the Identify command.
Add dc_event_log_size to the output payload for the host to get the info.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ad7a6116e4..b013e30314 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -21,6 +21,8 @@
 #include "sysemu/hostmem.h"
=20
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
+/* Experimental value: dynamic capacity event log size */
+#define CXL_DC_EVENT_LOG_SIZE 8
=20
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -519,8 +521,9 @@ static CXLRetCode cmd_identify_memory_device(struct cxl=
_cmd *cmd,
         uint16_t inject_poison_limit;
         uint8_t poison_caps;
         uint8_t qos_telemetry_caps;
+        uint16_t dc_event_log_size;
     } QEMU_PACKED *id;
-    QEMU_BUILD_BUG_ON(sizeof(*id) !=3D 0x43);
+    QEMU_BUILD_BUG_ON(sizeof(*id) !=3D 0x45);
=20
     CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dstate=
);
     CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
@@ -543,6 +546,7 @@ static CXLRetCode cmd_identify_memory_device(struct cxl=
_cmd *cmd,
     st24_le_p(id->poison_list_max_mer, 256);
     /* No limit - so limited by main poison record limit */
     stw_le_p(&id->inject_poison_limit, 0);
+    stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
=20
     *len =3D sizeof(*id);
     return CXL_MBOX_SUCCESS;
--=20
2.25.1
