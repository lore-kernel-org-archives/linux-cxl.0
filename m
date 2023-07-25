Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0609EC001DF
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 18:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGYSkK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjGYSkC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 14:40:02 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2F7212C
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 11:39:59 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230725183958usoutp02098aa930577900300c3ab4b93eb6e5a4~1MFoCBLjD1412514125usoutp02i;
        Tue, 25 Jul 2023 18:39:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230725183958usoutp02098aa930577900300c3ab4b93eb6e5a4~1MFoCBLjD1412514125usoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690310398;
        bh=xQl4UJjxwgWUuidcoMPZRlClhrcaaIQc0PdcqBYsE2k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ukuhph5hvdbyKTCWldG/TijP1m8EwkSKbvcxIFN6QF+pmR5hxAceFTX1EanDitQxc
         Mgt2NG7Qid68aad5DAFGpC7d+gcci08TsE+S9avkOvBLbbRNOM0aM6agCX+lDsy8DO
         S4xFti5WhZHirG8gICJIpzsy5cNsitQFyTpfZx98=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725183958uscas1p1b4981dae3ea41805cd27d82396dd9135~1MFnz1S8O0414404144uscas1p15;
        Tue, 25 Jul 2023 18:39:58 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 63.11.42611.DF610C46; Tue,
        25 Jul 2023 14:39:57 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230725183957uscas1p2ca5293c7229ab989ad1a2d95395436a6~1MFncI5Rb1972119721uscas1p2v;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-45-64c016fd5afe
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 89.DA.64580.DF610C46; Tue,
        25 Jul 2023 14:39:57 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
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
Subject: [Qemu PATCH v2 9/9] hw/mem/cxl_type3: Add dpa range validation for
 accesses to dc regions
Thread-Topic: [Qemu PATCH v2 9/9] hw/mem/cxl_type3: Add dpa range validation
        for accesses to dc regions
Thread-Index: AQHZvydoZ/a421rE4EydfsE7dZC6xQ==
Date:   Tue, 25 Jul 2023 18:39:56 +0000
Message-ID: <20230725183939.2741025-10-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCLcRz3e55n27Nl7jHUT3k5qePEKOG5ZHXo7kGHc905ImZ7rFjFnhI5
        TJpeKKpFbZSojuSGXIlUJjH+mM5dKrlOV021Ysh7Y9uTu/77fD8v39/ne/fDUZGJ44nHxCXQ
        qjip0psrwKqbR8yLRt0b5Uu0mmDyjPk2IC/mvwLkzfZKQKpTujEy9eFHhGzotWBkRUkrlzTr
        XmCkJceCkGWl3Sj5LOs+FupGvco7z6GuqcOoWt07HpXaNOSY6voR6o7tL4/qaa1CqKrBDyiV
        rz9Bfbk7a7NguyBYTitjDtGqxZLdgujczj7sgDn4cOHXNJ4aZCzMBHwcEoGwtyCfmwkEuIi4
        AaA9tx+wgwaBP+3p3P+ugbdtY8ItAAc6P3Kcgoj4DKC1cx0rlDtw2i/UKXCJObA+s8aVnkos
        hc1PSlGnCSWGMGirtGJOYQohh9aUGow1xUBz6zMOi8Ww7luLi8cIX9jW1OR4GseFRBBsORvk
        pPkO2PdV77IDwh1+f1GJODFKeMCOnmKEbT0ZXtXXoSx2h/YH78eumQ3zfhSM4Tmw63s/j82K
        YVu+lstiP1heMujKCh17TIU9GOufDh9fb8Oct0Aijw/tKXZXN0isha8frWE9XvBi5WuMpWWw
        wiZgaSUsLr03tmYlLPljQM4DH9241rpxLXTjWujGtbgCsArgkcgwsQqaCYijk8SMNJZJjFOI
        ZfGxd4Hjt720P4m/D9502MRGgODACCCOek8V+u+ol4uEcumRZFoVv0uVqKQZI/DCMW8Pof8q
        k0xEKKQJ9H6aPkCr/qsIzvdUI8UjBh+9p/6ob+2oum9GHlN77eSjnIUjiqRcpdfp5aNb02ol
        UacsO7fI+VvClTn1WXONkiVFwzMV27TP0yfRy7IjTdpsrvXP24KG6nKFR+SKkCRNBJ087e/t
        li7PCWU5Bl/AZGQEDUfdLNq46GfawbpJjNZvaHi3IYbX8JSfuj7CPi/qEh4YGWopS86aGN0p
        O1e0fk82x0sSOn9f1V7gVhPqk04eEouPbAo0HXsc5aduHAgbVAZ+urXsXEhA44+EisZuk4w2
        ruLuiDi+QGMPkYV8SKxarW+/7N9uVWokmVeOb7AF/A5w64jt6qm+oOptDiP6Mh4eM8zVisJX
        /xaD694YEy31X4CqGOk/gPhra9wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWS2cA0Ufev2IEUg5kHZSy6z29gtJg+9QKj
        xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
        Sy3St0vgyph05xlLwXmbiplf2tkbGDt1uhg5OSQETCRe3b7B2MXIxSEksJpRYtfGk6wQzidG
        iXOnXkE5yxgl5i9ezQjSwiagKLGvazsbiC0iYCxx7PASZhCbWeA1i8S3i9wgtrBAisSbpu0s
        EDWZElen72aGsPUk9ny7CBZnEVCVuHHkCNBMDg5eASuJiz1WIKaQgKXE1olxIBWcQNFnX2az
        gtiMAmIS30+tYYLYJC5x68l8JogHBCSW7DnPDGGLSrx8/I8VwpaXmPxjBhuErShx//tLdohe
        PYkbU6ewQdjaEssWvgbr5RUQlDg58wkLRL2kxMEVN1gmMErMQrJuFpL2WUjaZyFpX8DIsopR
        vLS4ODe9otg4L7Vcrzgxt7g0L10vOT93EyMwLZz+dzhmB+O9Wx/1DjEycTAeYpTgYFYS4TWM
        2ZcixJuSWFmVWpQfX1Sak1p8iFGag0VJnNcjdmK8kEB6YklqdmpqQWoRTJaJg1OqgSlOZX25
        lECk6fkzJ/QTXB2qF+2Jmav+zcr6pODh5eoWBzMSeAUf8Zbxb53U9OVDskjcuWDulSW/Vk0p
        Pj7Di+etupV6n0jKdav9T7+IrTxZvuXr2+SgLfbJyQeeTF6jdmzFgcPHH+r0da67IxNf+f29
        C/eDpp6JV1K0q/iqzjwIivui+ZTpyJLCIn/GJ2nS3PuNrWfYXpQx7j7boTeJwSfJzHJe9Mzz
        m20OLp4bvlafp71eYV7XxG8rJZnKHtuvzvd7aHSOK3lzB++JGW8ijiWvCGt+1TfhMZNA5p2J
        a1wD7koyht53DpfoeecXe/DJ26n7Q92NXx/nvuF41KKc4ZK+0s9H5tq6XDtSeJ+cPK/EUpyR
        aKjFXFScCADcXZpwegMAAA==
X-CMS-MailID: 20230725183957uscas1p2ca5293c7229ab989ad1a2d95395436a6
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183957uscas1p2ca5293c7229ab989ad1a2d95395436a6
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183957uscas1p2ca5293c7229ab989ad1a2d95395436a6@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Not all dpa range in the dc regions is valid to access until an extent
covering the range has been added. Add a bitmap for each region to
record whether a dc block in the region has been backed by dc extent.
For the bitmap, a bit in the bitmap represents a dc block. When a dc
extent is added, all the bits of the blocks in the extent will be set,
which will be cleared when the extent is released.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c          | 155 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |   1 +
 2 files changed, 156 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 41a828598a..51943a36fc 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -787,13 +787,37 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
         /* dsmad_handle is set when creating cdat table entries */
         region->flags =3D 0;
=20
+        region->blk_bitmap =3D bitmap_new(region->len / region->block_size=
);
+        if (!region->blk_bitmap) {
+            break;
+        }
+
         region_base +=3D region->len;
     }
+
+    if (i < ct3d->dc.num_regions) {
+        while (--i >=3D 0) {
+            g_free(ct3d->dc.regions[i].blk_bitmap);
+        }
+        return -1;
+    }
+
     QTAILQ_INIT(&ct3d->dc.extents);
=20
     return 0;
 }
=20
+static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
+{
+    int i;
+    struct CXLDCD_Region *region;
+
+    for (i =3D 0; i < ct3d->dc.num_regions; i++) {
+        region =3D &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds =3D DEVICE(ct3d);
@@ -1021,6 +1045,7 @@ err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -1043,6 +1068,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -1053,6 +1079,110 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
=20
+/*
+ * This function will marked the dpa range [dpa, dap + len) to be backed a=
nd
+ * accessible, this happens when a dc extent is added and accepted by the
+ * host.
+ */
+static void set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+        uint64_t len)
+{
+    int i;
+    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
+
+    if (dpa < region->base
+            || dpa >=3D region->base + ct3d->dc.total_capacity)
+        return;
+
+    /*
+     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+     * Region 0 being used for the lowest DPA of Dynamic Capacity and
+     * Region 7 for the highest DPA.
+     * So we check from the last region to find where the dpa belongs.
+     * access across multiple regions is not allowed.
+     **/
+    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
+        region =3D &ct3d->dc.regions[i];
+        if (dpa >=3D region->base) {
+            break;
+        }
+    }
+
+    bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_si=
ze,
+            len / region->block_size);
+}
+
+/*
+ * This function check whether a dpa range [dpa, dpa + len) has been backe=
d
+ * with dc extents, used when validating read/write to dc regions
+ */
+static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+        uint64_t len)
+{
+    int i;
+    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
+    uint64_t nbits;
+    long nr;
+
+    if (dpa < region->base
+            || dpa >=3D region->base + ct3d->dc.total_capacity)
+        return false;
+
+    /*
+     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+     * Region 0 being used for the lowest DPA of Dynamic Capacity and
+     * Region 7 for the highest DPA.
+     * So we check from the last region to find where the dpa belongs.
+     * access across multiple regions is not allowed.
+     */
+    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
+        region =3D &ct3d->dc.regions[i];
+        if (dpa >=3D region->base) {
+            break;
+        }
+    }
+
+    nr =3D (dpa - region->base) / region->block_size;
+    nbits =3D len / region->block_size;
+    return find_next_zero_bit(region->blk_bitmap, nbits, nr) >=3D nr + nbi=
ts;
+}
+
+/*
+ * This function will marked the dpa range [dpa, dap + len) to be unbacked=
 and
+ * inaccessible, this happens when a dc extent is added and accepted by th=
e
+ * host.
+ */
+static void clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+        uint64_t len)
+{
+    int i;
+    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
+    uint64_t nbits;
+    long nr;
+
+    if (dpa < region->base
+            || dpa >=3D region->base + ct3d->dc.total_capacity)
+        return;
+
+    /*
+     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+     * Region 0 being used for the lowest DPA of Dynamic Capacity and
+     * Region 7 for the highest DPA.
+     * So we check from the last region to find where the dpa belongs.
+     * access across multiple regions is not allowed.
+     */
+    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
+        region =3D &ct3d->dc.regions[i];
+        if (dpa >=3D region->base) {
+            break;
+        }
+    }
+
+    nr =3D (dpa - region->base) / region->block_size;
+    nbits =3D len / region->block_size;
+    bitmap_clear(region->blk_bitmap, nr, nbits);
+}
+
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *d=
pa)
 {
     uint32_t *cache_mem =3D ct3d->cxl_cstate.crb.cache_mem_registers;
@@ -1145,6 +1275,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *=
ct3d,
         *as =3D &ct3d->hostpmem_as;
         *dpa_offset -=3D vmr_size;
     } else {
+        if (!test_region_block_backed(ct3d, *dpa_offset, size)) {
+            return -ENODEV;
+        }
+
         *as =3D &ct3d->dc.host_dc_as;
         *dpa_offset -=3D (vmr_size + pmr_size);
     }
@@ -1944,6 +2078,27 @@ static void qmp_cxl_process_dynamic_capacity_event(c=
onst char *path,
     }
=20
     g_free(extents);
+
+    /* Another choice is to do the set/clear after getting mailbox respons=
e*/
+    list =3D records;
+    while (list) {
+        dpa =3D list->value->dpa * 1024 * 1024;
+        len =3D list->value->len * 1024 * 1024;
+        rid =3D list->value->region_id;
+
+        switch (type) {
+        case DC_EVENT_ADD_CAPACITY:
+            set_region_block_backed(dcd, dpa, len);
+            break;
+        case DC_EVENT_RELEASE_CAPACITY:
+            clear_region_block_backed(dcd, dpa, len);
+            break;
+        default:
+            error_setg(errp, "DC event type not handled yet");
+            break;
+        }
+        list =3D list->next;
+    }
 }
=20
 void qmp_cxl_add_dynamic_capacity_event(const char *path,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 01a5eaca48..1f85c88017 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -412,6 +412,7 @@ typedef struct CXLDCD_Region {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCD_Region;
=20
 struct CXLType3Dev {
--=20
2.25.1
