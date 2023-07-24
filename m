Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB01C001DF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjGXQXb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGXQXa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:23:30 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6471B0
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:23:25 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230724162324usoutp01264683b331c29389eb977a8fa8c1d281~02lGY3z5F2719927199usoutp01y;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230724162324usoutp01264683b331c29389eb977a8fa8c1d281~02lGY3z5F2719927199usoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690215804;
        bh=g5l7URI3CHFGaV1c3IODQfiJjEbKhZ8zpz4cb8chZLU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=GhgBLWKGnD7AtedUna1KQ0AhvUCp9smWHXqioH6wZ4dreqEUDhGtF5vXhzx+aTbPI
         h7AkAUxwzJYdT1bYaa5VnAYoSnv1Q7ztH/HWcJ85wBgnG0GlVrzaMnkX/ymmkmPb4t
         9CbTJ1qK6+T1gfkrMkNW4z+D7ECPhLsy3CrI1JPo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162324uscas1p2e674b3a7c575c22db2eba0ab094eed58~02lGPZ_LR0636506365uscas1p2E;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id F9.78.42611.B75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230724162323uscas1p131ecd295a7f6c8b3b95df5a6d5a98760~02lF4q3zg1472414724uscas1p1t;
        Mon, 24 Jul 2023 16:23:23 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-9c-64bea57b33d0
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id F4.9A.44215.B75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
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
Subject: [Qemu PATCH RESEND 4/9] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Thread-Topic: [Qemu PATCH RESEND 4/9] hw/mem/cxl_type3: Add support to
        create DC regions to type3 memory devices
Thread-Index: AQHZvksqkt0lMhZUQE+bOLebPq5xJA==
Date:   Mon, 24 Jul 2023 16:23:22 +0000
Message-ID: <20230724162313.34196-5-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djX87rVS/elGHx7YmHRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8b+nVtYC1ZIVLx484+1gXG3cBcjJ4eEgInE6Wm97F2MXBxCAisZJbZ92M4E4bQy
        Sbz62MACU7X4xhI2iMRaRolvqyYzQzifGCU6W55C9S9jlLi+oIcdpIVNQFFiX9d2NhBbRMBY
        4tjhJWAdzAJvWSQ+rnkDNldYIFfizv7nQAs5gIqKJNZsSoeo15PY+PsXM4jNIqAqcWhHP9hM
        XgFziQ9LzrCC2JwCFhIbLp0AsxkFxCS+n1rDBGIzC4hL3HoynwnibEGJRbP3MEPYYhL/dj1k
        g7DlJSb/mAFlK0rc//6SHaJXT+LG1ClsELa2xLKFr5kh9gpKnJz5BBoUkhIHV9xgAflFQqCf
        U+LZxpVQy1wkum80Q9nSEn/vLgP7S0IgWWLVRy6IcI7E/CVboOZYSyz8s55pAqPKLCRnz0Jy
        xiwkZ8xCcsYCRpZVjOKlxcW56anFRnmp5XrFibnFpXnpesn5uZsYgent9L/D+TsYr9/6qHeI
        kYmD8RCjBAezkgivYcy+FCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8hrYnk4UE0hNLUrNTUwtS
        i2CyTBycUg1MwYLPN6xLEGJSbrzls6HPoTJmndTXOdfibm1a86LrSWGx29Udlx6WlOefCpkm
        nXx6x/EYcb6lO3g5Xm/49nRXQnjrdbNKiw8RJ88feZy8TP66yDR3+7sVv7Uk5SsuPLU1Nj5z
        KftT539NJYMk699P+LY4zDvcqPfK4ZJgpZqhC2PDBct7xsE18b+evky8pNA4d7rSSfZ39x6x
        uzIHiFy374h496sp5fmNrld7864W3jrgfvHDG+45Kd8a2ZUyiv4HbHVguCL5SHl615sJi1Pr
        XUUqlyk68E7Pi95+8qfWlnB5J/HuqlRfr/iwc8k9X5a/fSi/RvXLnTLH1PSMd/VT5pbq5Jpt
        51TNZ+4NS2NTYinOSDTUYi4qTgQAQomnad4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWS2cA0Ubd66b4Ug00nFSy6z29gtJg+9QKj
        xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
        Sy3St0vgyti/cwtrwQqJihdv/rE2MO4W7mLk5JAQMJFYfGMJWxcjF4eQwGpGif6Dr1ghnE+M
        Em8uLmCHcJYxSrTPmMwG0sImoCixr2s7mC0iYCxx7PASZhCbWeA1i8S3i9wgtrBArsSd/c+Z
        IGqKJHo2bmaGsPUkNv7+BWazCKhKHNrRzw5i8wqYS3xYcoYVxBYCss9s2g8W5xSwkNhw6QRY
        nFFATOL7qTVMELvEJW49mc8E8YKAxJI955khbFGJl4//sULY8hKTf8xgg7AVJe5/f8kO0asn
        cWPqFDYIW1ti2cLXzBA3CEqcnPmEBaJeUuLgihssExglZiFZNwtJ+ywk7bOQtC9gZFnFKF5a
        XJybXlFslJdarlecmFtcmpeul5yfu4kRmBpO/zscvYPx9q2PeocYmTgYDzFKcDArifAaxuxL
        EeJNSaysSi3Kjy8qzUktPsQozcGiJM77MmpivJBAemJJanZqakFqEUyWiYNTqoEpN/VN/NvP
        P62ylqfWW/0/Oe+BTEZT2OZdd+RubTq63mFm/NZLO1V3is1r83srnCakzKbPJbb/0GbPrjMF
        EzITOeNP5r1gPCPyLWqbSolXy/YPd75WXr1/Xu23nN8v7e+fy9YlvoqT7Di09VWlqHS55um0
        yF/Jxm0GOeXHnE+v5bigkMcuO2f31dvhcr6x6Re323yOPsRTv3HbvQb5Q0K+Z5W0tNP2uiSG
        ViSxc/8RaLBsiubrva6o+ufMEjEli9lXNz3avf7V9y91s4q+c3HN9bP73KeWKT3nquB8/4kd
        d268mJ3A2eJ8YNopHjv9zUmBjpUX05eJLj6/uYGt8c/t0JnLeUwP7PMynjvVmoVTiaU4I9FQ
        i7moOBEAN7eqonwDAAA=
X-CMS-MailID: 20230724162323uscas1p131ecd295a7f6c8b3b95df5a6d5a98760
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724162323uscas1p131ecd295a7f6c8b3b95df5a6d5a98760
References: <20230724162313.34196-1-fan.ni@samsung.com>
        <CGME20230724162323uscas1p131ecd295a7f6c8b3b95df5a6d5a98760@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

With the change, when setting up memory for type3 memory device, we can
create DC regions
A property 'num-dc-regions' is added to ct3_props to allow users to pass th=
e
number of DC regions to create. To make it easier, other region parameters
like region base, length, and block size are hard coded. If needed,
these parameters can be added easily.

With the change, we can create DC regions with proper kernel side
support as below:

region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
echo 1 > /sys/bus/cxl/devices/$region/interleave_ways

echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size

echo 0x40000000 > /sys/bus/cxl/devices/$region/size
echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
echo 1 > /sys/bus/cxl/devices/$region/commit
echo $region > /sys/bus/cxl/drivers/cxl_region/bind

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 237b544b9c..27b5920f7d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -707,6 +707,34 @@ static void ct3d_reg_write(void *opaque, hwaddr offset=
, uint64_t value,
     }
 }
=20
+/*
+ * Create a dc region to test "Get Dynamic Capacity Configuration" command=
.
+ */
+static int cxl_create_dc_regions(CXLType3Dev *ct3d)
+{
+    int i;
+    uint64_t region_base =3D (ct3d->hostvmem ? ct3d->hostvmem->size : 0)
+        + (ct3d->hostpmem ? ct3d->hostpmem->size : 0);
+    uint64_t region_len =3D (uint64_t)2 * 1024 * 1024 * 1024;
+    uint64_t decode_len =3D 4; /* 4*256MB */
+    uint64_t blk_size =3D 2 * 1024 * 1024;
+    struct CXLDCD_Region *region;
+
+    for (i =3D 0; i < ct3d->dc.num_regions; i++) {
+        region =3D &ct3d->dc.regions[i];
+        region->base =3D region_base;
+        region->decode_len =3D decode_len;
+        region->len =3D region_len;
+        region->block_size =3D blk_size;
+        /* dsmad_handle is set when creating cdat table entries */
+        region->flags =3D 0;
+
+        region_base +=3D region->len;
+    }
+
+    return 0;
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds =3D DEVICE(ct3d);
@@ -775,6 +803,10 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error =
**errp)
         g_free(p_name);
     }
=20
+    if (cxl_create_dc_regions(ct3d)) {
+        return false;
+    }
+
     return true;
 }
=20
@@ -1062,6 +1094,7 @@ static Property ct3_props[] =3D {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.25.1
