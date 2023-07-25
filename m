Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24437C04A6A
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 18:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjGYSkN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGYSkF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 14:40:05 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9036212E
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 11:39:59 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230725183957usoutp01386a59245c416eb4887c2a2ab995ff0d~1MFnKlaFM1107111071usoutp01t;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230725183957usoutp01386a59245c416eb4887c2a2ab995ff0d~1MFnKlaFM1107111071usoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690310397;
        bh=378aU1/0ie9wyBAWxyGSYcYy2mOtEBM2RX8oNqSnjj4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=BpOYCvsYNGSfflipjLoaWrzqRrbHpIfIj/sw4BNgJ4nYioGESaJNyj3ipzAgqhnp0
         VCMfgiYdgnKYlxfr3ZoIJSypbyoyLJmnwVlUsQmNLdrxp/B8WycmkJYTLNJQot2EAQ
         BR0YUHmXctqRD8aXKk9+y78FKb9Tpjv8bzD5L1iI=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230725183957uscas1p29cab1dc7eab27d69683f931aa08285e5~1MFnAQJZs1580215802uscas1p24;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 39.4E.62237.DF610C46; Tue,
        25 Jul 2023 14:39:57 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230725183956uscas1p2008fba59779b70405c74d28a30e4fbaa~1MFmrSVuy1580215802uscas1p23;
        Tue, 25 Jul 2023 18:39:56 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-91-64c016fd67ca
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id E2.54.38326.CF610C46; Tue,
        25 Jul 2023 14:39:56 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 25 Jul 2023 11:39:56 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        25 Jul 2023 11:39:56 -0700
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
Subject: [Qemu PATCH v2 4/9] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Thread-Topic: [Qemu PATCH v2 4/9] hw/mem/cxl_type3: Add support to create DC
        regions to type3 memory devices
Thread-Index: AQHZvydoCwFjnM0gJE6KDcVANjM/Og==
Date:   Tue, 25 Jul 2023 18:39:55 +0000
Message-ID: <20230725183939.2741025-5-fan.ni@samsung.com>
In-Reply-To: <20230725183939.2741025-1-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djXc7p/xQ6kGCzayWLRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8ad5v9MBSskKhY1XGNsYNwt3MXIySEhYCLxa/N+dhBbSGAlo8SKpbxdjFxAdiuT
        xPIpv9lhik5f+8QOkVjLKLHxxwYWCOcTo0TD6wdMEM4yRok37b+YQVrYBBQl9nVtZwOxRQSM
        JY4dXsIMUsQs8JZF4uOaNywgCWGBTIl9246zQBTlSdz5uRzK1pO43r0HzGYRUJXoWLmDCcTm
        FbCUmPVkE9hQTgEriWdfZrOC2IwCYhLfT60Bq2EWEJe49WQ+E8TdghKLZu9hhrDFJP7tesgG
        YctLTP4xA8pWlLj//SU7RK+exI2pU9ggbG2JZQtfM0PsFZQ4OfMJC0S9pMTBFTeg7MmcEs/P
        23QxcgDZLhL7/qpAhKUlrl6fygwRTpZY9ZELIpwjMX/JFqhOa4mFf9YzTWBUmYXk6FlIjpiF
        5IhZSI5YwMiyilG8tLg4Nz212DgvtVyvODG3uDQvXS85P3cTIzC1nf53uGAH461bH/UOMTJx
        MB5ilOBgVhLhNYzZlyLEm5JYWZValB9fVJqTWnyIUZqDRUmc19D2ZLKQQHpiSWp2ampBahFM
        lomDU6qBacL8qHIrz7oZ3FcFWQLXenA+/LXnwJ7psjsndhp+uuckHLbx79aPtUFvXkjtcNFY
        v25u6sXfF9wPKS6dGNO3PWGXl0U529YrDOJRsyet+6e3Zff5Y2tF7Nl4J9VzXV4wYcv2VUl6
        19aesV3rb6R2g2lK3rNQ0Vj/s1qGK5ckGUQwPVAzLjLc1jrjKnORhMC/7AMru2P3uF/p3d8k
        2ni6/Yna6ZwkdtN7Sz5srfZvY9fcXflgnebPE61PNvPPyb7yqFLuRu7rO+cCnncbtP10rPp1
        SqdmXu/mYrWHYTHyGj61iT9X5AS+P8CQPq2KL/rk439Lf+SVHFdYmPJVeP+UnxvqJ/tkPJ5c
        nMH202fag5tKLMUZiYZazEXFiQDh7ToF3AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWS2cA0UfeP2IEUg+ZbWhbd5zcwWkyfeoHR
        YvXNNYwWDU2PWCxadr9nstj/9DmLxaqF19gszs86xWLxfOJzJoulSx4xWxzv3cHiwO1xYfIE
        Vo/FDa4eO2fdZfdoOfIWyNvzkslj48f/7B5Prm1m8tj8+gWzx9TZ9R6fN8kFcEVx2aSk5mSW
        pRbp2yVwZdxp/s9UsEKiYlHDNcYGxt3CXYycHBICJhKnr31i72Lk4hASWM0ocXF3BxOE84lR
        om3RaWYIZxmjxPzFqxlBWtgEFCX2dW1nA7FFBIwljh1ewgxiMwu8ZpH4dpEbxBYWyJTYt+04
        SxcjB1BNnsT36/IQ5XoS17v3sIDYLAKqEh0rdzCB2LwClhKznmxiAykXArK3TowDCXMKWEk8
        +zKbFcRmFBCT+H5qDRPEJnGJW0/mM0E8ICCxZM95ZghbVOLl43+sELa8xOQfM9ggbEWJ+99f
        skP06kncmDqFDcLWlli28DUzxAmCEidnPmGBqJeUOLjiBssERolZSNbNQtI+C0n7LCTtCxhZ
        VjGKlxYX56ZXFBvmpZbrFSfmFpfmpesl5+duYgSmhdP/DkfuYDx666PeIUYmDsZDjBIczEoi
        vIYx+1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8wq5TowXEkhPLEnNTk0tSC2CyTJxcEo1MImu
        a/q+c11zlr5K8+Poitnr9s2Uyr5sJf9iSXTPNsVSz8qF09SP8Uc9ei4ufXOjYvJlibxOXpGi
        l7u3+hTZKLot/bZZ+QnH5XNmqrNDvnQ7GHzLTm6wen5rj/f88h4zw8fzVq7fXjG3XvdrVPNs
        vpIaeU431onCr4TZq6auCYsO+fPEyF3U3MOap2fzPo/y5A/d872uyn14eucIZ5exFe9tCaZr
        OoWnzq1Z8f1UzAEfntWXlcLKu+VPhsdxH246W3CQq/65Sk1cpvt0prrUpL+VaTyhB/zXLo0P
        37bwTbiI86yGL90fBV5m7d7Eey9OsTJHKvjfLu/jm2zjeh+9Kde7WsnmcfW9pkl1kfNMJZbi
        jERDLeai4kQAM1kx7HoDAAA=
X-CMS-MailID: 20230725183956uscas1p2008fba59779b70405c74d28a30e4fbaa
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183956uscas1p2008fba59779b70405c74d28a30e4fbaa
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183956uscas1p2008fba59779b70405c74d28a30e4fbaa@uscas1p2.samsung.com>
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
index 3d7acffcb7..b29bb2309a 100644
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
@@ -1068,6 +1100,7 @@ static Property ct3_props[] =3D {
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
+    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.25.1
