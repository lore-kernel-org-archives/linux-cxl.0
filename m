Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17686C43219
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 16:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiKBQus (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiKBQu3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 12:50:29 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401796395
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 09:50:20 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20221102165019usoutp012859815ebd7b5a95569ae66d528ae477~j0pO9vuxJ0037600376usoutp01H;
        Wed,  2 Nov 2022 16:50:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20221102165019usoutp012859815ebd7b5a95569ae66d528ae477~j0pO9vuxJ0037600376usoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667407819;
        bh=9MDQVYw3nc+LRbTfBlifywbwPY7H0kn9zGVnSieAN8o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Q+SytlJD6znlZLnl/THRWcupSlc/b/4uVuPLeDACmwBl5cXFpWgDKV9cf+B23Rzt/
         VeGgw3Q+gGvW+n8tHkJKluW/91kvGHRk1sgECo5tRJAcklCe8qcK4njHob76MXHx89
         2wz0oETZVxvvhztp9fgUVNX6Go3wD68s8p6HuwAk=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221102165018uscas1p25efe75e66c628ca9b8d815db54f67cd1~j0pO0isER0303403034uscas1p2w;
        Wed,  2 Nov 2022 16:50:18 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id C0.38.35398.ACF92636; Wed, 
        2 Nov 2022 12:50:18 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221102165018uscas1p1c27244ee88cc21dbabb7cc2656187e40~j0pOnPA5h0501505015uscas1p1s;
        Wed,  2 Nov 2022 16:50:18 +0000 (GMT)
X-AuditID: cbfec370-817ff70000028a46-f3-63629fca2d47
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id D4.97.19363.ACF92636; Wed, 
        2 Nov 2022 12:50:18 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 2 Nov 2022 09:50:17 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        2 Nov 2022 09:50:17 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 2/2] libcxl: Fix typos
Thread-Topic: [PATCH 2/2] libcxl: Fix typos
Thread-Index: AQHY7tsvBzqgBNLMekOH8hjsI1vNsg==
Date:   Wed, 2 Nov 2022 16:50:17 +0000
Message-ID: <20221102165004.171776-3-fan.ni@samsung.com>
In-Reply-To: <20221102165004.171776-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduzred1T85OSDaZeMrSYPvUCo8Xqm2sY
        Lc7POsVicWvCMSYHFo/Fe14yeUydXe/xeZNcAHMUl01Kak5mWWqRvl0CV8blI/OYCibyVrxb
        7tjA+J+ri5GTQ0LARGLG+1fMXYxcHEICKxkl7p34wg7htDJJvNnUww5Ttb77JFTVWkaJ8+82
        QDkfGSUa5razQjhLGSWWPJ4G1sImoCixr2s7G4gtIlAkcX3zXLAOZoGNjBL3r11hBEkIC6hJ
        LFi1mxGiSFviwr2vzBC2nsTjG9PAbBYBFYmdl6aC1fAKWEhsW9gAFucUsJTovbifBcRmFBCT
        +H5qDROIzSwgLnHryXwmiLsFJRbN3sMMYYtJ/Nv1kA3CVpS4//0lO0S9nsSNqVPYIGxtiWUL
        XzND7BKUODnzCQtEvaTEwRU3WEAekBCYyyFx484vRoiEi8S9hnXQQJKWuHp9KtSyaokzPeeY
        IBpaGCUuNW6GSlhL/Ou8BrWZT+Lvr0eMExiVZyE5fBaSo2YhOWoWkqMWMLKsYhQvLS7OTU8t
        Ns5LLdcrTswtLs1L10vOz93ECEwsp/8dLtjBeOvWR71DjEwcjIcYJTiYlUR4689GJwvxpiRW
        VqUW5ccXleakFh9ilOZgURLnjZqhlSwkkJ5YkpqdmlqQWgSTZeLglGpgWq6zp/mibhDP3sMB
        MrFW6bOkUpcd+HtiRuHe71anWb6zdKjPesAb9kVn5YM5gteDbh5jYnDQNeO21mH3ep8h4sO6
        bFfwqhmsQdGbtI5nmgmauE/7pX4xf7IDh91jia2pqpvSmjltPTR3PRT/stlQae+mtRs/vRdV
        TWT5pvBA4tr229qTZN/qSq3iDP26quOJTMdVvQmrBd1vPrns4XLxxZnJP3yjo96Fb1h78J53
        5HuT0w+uFryJskmcwGY+/dN5BV+lWbH7uVJe8P1ImHm3U0lyrtCD+AtJZUsaDtrGzIveF+Fr
        vbiPLTjuxpFFNnsF3/5jEik65HxbqnH7r8OabHLC7q4He9aXiM523Offp8RSnJFoqMVcVJwI
        AHxfTw2bAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWS2cA0UffU/KRkg+13lCymT73AaLH65hpG
        i/OzTrFY3JpwjMmBxWPxnpdMHlNn13t83iQXwBzFZZOSmpNZllqkb5fAlXH5yDymgom8Fe+W
        OzYw/ufqYuTkkBAwkVjffZK5i5GLQ0hgNaPEhWWT2CGcj4wSS9Z3MEI4Sxklft3azAjSwiag
        KLGvazsbiC0iUCRxffNcsHZmgY2MEvevXQErEhZQk1iwajcjRJG2xIV7X5khbD2Jxzemgdks
        AioSOy9NBavhFbCQ2LawASwuBGQfe/sFLM4pYCnRe3E/C4jNKCAm8f3UGiYQm1lAXOLWk/lM
        ED8ISCzZc54ZwhaVePn4HyuErShx//tLdoh6PYkbU6ewQdjaEssWvmaG2CsocXLmExaIekmJ
        gytusExgFJ+FZMUsJO2zkLTPQtK+gJFlFaN4aXFxbnpFsWFearlecWJucWleul5yfu4mRmDk
        nf53OHIH49FbH/UOMTJxMB5ilOBgVhLhrT8bnSzEm5JYWZValB9fVJqTWnyIUZqDRUmcV8h1
        YryQQHpiSWp2ampBahFMlomDU6qBaauPZeB+tthExx0nHeb7G9TdaN5jM2Xz5H13bGaac3Xt
        0FF5InFjvkS6/IyJGvdY2Gu+7XDW8pkxI1ut7pyAq8oxdTl2bt6z3s93utRx/xQ4uFhMPfVC
        1YH4RQeMl2z/FH/FxVrRmv1Y6bqbi3vkdb387yeezdgrcPnvOeeTwmuDVeblLeo747ZoDc/X
        rNUz9CdEyK1vcDDdKM6cIymSmNygXXT//ITe+Bi7I+prfXXiGlbr5Jw4eOO/F+PuGUlPS+Ry
        X7zLWL/qyq2U8D/aFxK+nFJq5lrxRuXn1CdPlI7ISe0S28h6iEX0gOfBJyyM6lLygge+LV40
        bcPxwLV/OQUiDRzya6Oqo55MvMawRomlOCPRUIu5qDgRAEc4OcwrAwAA
X-CMS-MailID: 20221102165018uscas1p1c27244ee88cc21dbabb7cc2656187e40
CMS-TYPE: 301P
X-CMS-RootMailID: 20221102165018uscas1p1c27244ee88cc21dbabb7cc2656187e40
References: <20221102165004.171776-1-fan.ni@samsung.com>
        <CGME20221102165018uscas1p1c27244ee88cc21dbabb7cc2656187e40@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fix typos caught by Davidhohr Bueso in Documentation/cxl/lib/libcxl.txt.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 Documentation/cxl/lib/libcxl.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcx=
l.txt
index edc852d..7404efa 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -110,7 +110,7 @@ may appear in the topology that were not previously enu=
merable.
=20
 NOTE: cxl_memdev_disable_invalidate() will force disable the memdev
 regardless of whether the memory provided by the device is in active use
-by the operating system. Callers take responisbility for assuring that
+by the operating system. Callers take responsibility for assuring that
 it is safe to disable the memory device. Otherwise, this call can be as
 destructive as ripping a DIMM out of a running system. Like all other
 libcxl calls that mutate the system state or divulge security sensitive
@@ -327,7 +327,7 @@ const char *cxl_dport_get_physical_node(struct cxl_dpor=
t *dport);
 int cxl_dport_get_id(struct cxl_dport *dport);
 bool cxl_dport_maps_memdev(struct cxl_dport *dport, struct cxl_memdev *mem=
dev);
 ----
-The id of a dport is the hardware idenfifier used by an upstream port to
+The id of a dport is the hardware identifier used by an upstream port to
 reference a downstream port. The physical node of a dport is only
 available for platform firmware defined downstream ports and alias the
 companion object, like a PCI host bridge, in the PCI device hierarchy.
--=20
2.25.1
