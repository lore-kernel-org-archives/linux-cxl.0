Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75CBC7EE24
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbjEKSFY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239100AbjEKSFV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 14:05:21 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C4C9EC1
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 11:04:50 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230511175642usoutp021cee2a55ffb44c18cbdb5b6d3425d1da~eKHb8rVmO2433724337usoutp02U;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230511175642usoutp021cee2a55ffb44c18cbdb5b6d3425d1da~eKHb8rVmO2433724337usoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683827802;
        bh=UX2rYCNF7mEa58KU74awtybeT0Okf+CTLNXne31BcQ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=QSHBDzocbQfNwJi8lVZgIvQKzlLwxBLHkFKLgKTMus5xYTrKdYIJLxSOzBninaWFQ
         CQAOv0OrUhOgf29oWpBkoHa+fbKrjkQC4yUZU+OIMZY4CuOg3wplP15uPpZoFIp953
         btQBlW/od/URrF0dPgbrJCCDTfkTMEr3LgHuk1J8=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230511175642uscas1p1277c2430cf100d607b33b68fffa0c239~eKHbzQjpJ3115831158uscas1p17;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id C5.DA.42611.95C2D546; Thu,
        11 May 2023 13:56:41 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230511175641uscas1p13ee26532e3a1de36f6081f970190eeed~eKHbfQNCm0296202962uscas1p1F;
        Thu, 11 May 2023 17:56:41 +0000 (GMT)
X-AuditID: cbfec36f-249ff7000000a673-92-645d2c597ee0
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id D9.48.64580.95C2D546; Thu,
        11 May 2023 13:56:41 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 11 May 2023 10:56:40 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        11 May 2023 10:56:40 -0700
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
Subject: [RFC 3/7] hw/mem/cxl_type3: Add a parameter to pass number of DC
 regions the device supports in qemu command line
Thread-Topic: [RFC 3/7] hw/mem/cxl_type3: Add a parameter to pass number of
        DC regions the device supports in qemu command line
Thread-Index: AQHZhDHwgPX9k8X0Wk2f5wJohcsLYA==
Date:   Thu, 11 May 2023 17:56:40 +0000
Message-ID: <20230511175609.2091136-4-fan.ni@samsung.com>
In-Reply-To: <20230511175609.2091136-1-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djXc7qROrEpBs+fW1p0n9/AaDF96gVG
        i9U31zBaNDQ9YrFo2f2eyWL/0+csFqsWXmOzOD/rFIvF84nPmSyWLnnEbHG8dweLA7fHhckT
        WD0WN7h67Jx1l92j5chbIG/PSyaPjR//s3s8ubaZyWPz6xfMHlNn13t83iQXwBXFZZOSmpNZ
        llqkb5fAlfFg6znGgjeCFV3nj7A1MB7m62Lk5JAQMJFYdnoDaxcjF4eQwEpGic5dixkhnFYm
        iddfl7DDVP19vQ3MFhJYyyhx8kY2RNEnRolrs/awQzjLGCX+LrzLBlLFJqAosa9rO5gtImAs
        cezwEmaQImaBtywSH9e8YQFJCAvUSOyed5kFJCEi0Mgo8eboP1aIDj2J/Y33wfaxCKhKnLux
        gxHE5hWwlJhwt5EZxOYUsJLY0HyCCcRmFBCT+H5qDZjNLCAucevJfCaIuwUlFs3ewwxhi0n8
        2/WQDcKWl5j8YwaUrShx//tLdohePYkbU6ewQdjaEssWvmaG2CsocXLmExaIekmJgytugB0t
        ITCZU6Jr3jqgozmAHBeJF/t4IWqkJaavAXkMJJwsseojF0Q4R2L+ki1QY6wlFv5ZzzSBUWUW
        kqtnIbliFpIrZiG5YgEjyypG8dLi4tz01GKjvNRyveLE3OLSvHS95PzcTYzA9Hb63+H8HYzX
        b33UO8TIxMF4iFGCg1lJhPftkugUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGtieThQTSE0tS
        s1NTC1KLYLJMHJxSDUzyEr+3L817oWTFe0Dhn0dfNbul2fSfzjzyiUUeT234fZ3aClcIvDSf
        xasfWHYq8gQLK5/RNseKo7X5PiySJzOsRG8KbA6Y12Ku71hZa/Xbd1v2tjdi57SbVWQ2Sovf
        zRJ5b544I+qHzG5GSxf9vGcyKznWX7934WfgmsLfSc5uXN6qs2xePlPacyM4zj7as110iuG3
        NP/cnnWNT8JUhI89uigqu3feOYPI8Nr2gv9vF9yU33fgTfjyy2IW3xTbdvlVrgt/Xhh6+9qh
        u3KPr0nPuBS3jE2Oa3L2iRvanRqtP99v3zZvdSDPucyy96snscZo7kn1VddZsExbMPXmVc1v
        5X+al1df89yxUGMbixJLcUaioRZzUXEiANoiPT7eAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsWS2cA0UTdSJzbF4PQ6BYvu8xsYLaZPvcBo
        sfrmGkaLhqZHLBYtu98zWex/+pzFYtXCa2wW52edYrF4PvE5k8XSJY+YLY737mBx4Pa4MHkC
        q8fiBlePnbPusnu0HHkL5O15yeSx8eN/do8n1zYzeWx+/YLZY+rseo/Pm+QCuKK4bFJSczLL
        Uov07RK4Mh5sPcdY8Eawouv8EbYGxsN8XYycHBICJhJ/X29j72Lk4hASWM0osXr3ckYI5xOj
        xMf759kgnGWMEpsndzGCtLAJKErs69rOBmKLCBhLHDu8hBnEZhZ4zSLx7SI3iC0sUCOxe95l
        FpBmEYFGRolHT+4xQjToSexvvM8OYrMIqEqcu7EDLM4rYCkx4W4j2CAhIPvjz51gNZwCVhIb
        mk8wgdiMAmIS30+tYYJYJi5x68l8JogfBCSW7DnPDGGLSrx8/I8VwpaXmPxjBhuErShx//tL
        dohePYkbU6ewQdjaEssWvmaGuEFQ4uTMJywQ9ZISB1fcYJnAKDELybpZSNpnIWmfhaR9ASPL
        Kkbx0uLi3PSKYuO81HK94sTc4tK8dL3k/NxNjMDkcPrf4ZgdjPdufdQ7xMjEwXiIUYKDWUmE
        9+2S6BQh3pTEyqrUovz4otKc1OJDjNIcLErivB6xE+OFBNITS1KzU1MLUotgskwcnFINTAGJ
        DKI6f9QnsU0pZ74pzXTsivHrUL4VnHdF/uu4iVYf0n1wXWRH7IZ9TgsLfH8VP7yWVerz+fXx
        7p1KbWWMDkHhBszb8woy25sO7l7LrDhdemn0AdldfsZMSiFrPzxu3CbddTV/yZTzT7z4wxsy
        L69g5dumEP/y2u2Uip6nQr7/TKZ1GZpwqkhfWpYqle6/e+a8utW6311i7kneU37AkPz7S9c8
        FQVTNyUGsZ/CRRH/jvGVaaq1LTeMK5kq/98gpuv6ttPv/07xCEjbMC2HfYOiU5tvWcdzA2+J
        tc0Xknnf8+wTFdx/IWS5Y/SWFYKPzQLPuZye9TWGT6RLkV+5gv+8b7v5xe+bJJdOiElXYinO
        SDTUYi4qTgQAyB8Y830DAAA=
X-CMS-MailID: 20230511175641uscas1p13ee26532e3a1de36f6081f970190eeed
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175641uscas1p13ee26532e3a1de36f6081f970190eeed
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175641uscas1p13ee26532e3a1de36f6081f970190eeed@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Add a property 'num-dc-regions' to ct3_props to allow users to create DC
regions.
With the change, users can control the number of DC regions the device
supports.
To make it easier, other parameters of the region like region base, length,
and block size are hard coded. If desired, these parameters
can be added easily.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2b483d3d8e..b9c375d9b4 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -684,6 +684,34 @@ static void ct3d_reg_write(void *opaque, hwaddr offset=
, uint64_t value,
     }
 }
=20
+/*
+ * Create a dc region to test "Get Dynamic Capacity Configuration" command=
.
+ */
+static int cxl_create_toy_regions(CXLType3Dev *ct3d)
+{
+	int i;
+	uint64_t region_base =3D ct3d->hostvmem?ct3d->hostvmem->size
+		+ ct3d->hostpmem->size:ct3d->hostpmem->size;
+	uint64_t region_len =3D 1024*1024*1024;
+	uint64_t decode_len =3D 4; /* 4*256MB */
+	uint64_t blk_size =3D 2*1024*1024;
+	struct CXLDCD_Region *region;
+
+	for (i =3D 0; i < ct3d->dc.num_regions; i++) {
+		region =3D &ct3d->dc.regions[i];
+		region->base =3D region_base;
+		region->decode_len =3D decode_len;
+		region->len =3D region_len;
+		region->block_size =3D blk_size;
+		/* dsmad_handle is set when creating cdat table entries */
+		region->flags =3D 0;
+
+		region_base +=3D region->len;
+	}
+
+	return 0;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds =3D DEVICE(ct3d);
@@ -752,6 +780,9 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error *=
*errp)
         g_free(p_name);
     }
=20
+	if (cxl_create_toy_regions(ct3d))
+		return false;
+
     return true;
 }
=20
@@ -1036,6 +1067,7 @@ static Property ct3_props[] =3D {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
+	DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.25.1
