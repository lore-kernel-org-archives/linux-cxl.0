Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173EEC433E0
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB28464EDB
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhBBBB0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:01:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:21915 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhBBBB0 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:26 -0500
IronPort-SDR: 3cNEIClTkUWYPFrVq3V0fdvf0KNtYdHYLKLi7ntdN0tQSna6QBrj5DNT/vun7CZ8vBLhetMUze
 pFS7t6D07sbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294627"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294627"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:08 -0800
IronPort-SDR: /z+0pVwxwNMP7YQ71xrIx2eOCE87V6iPya0VYdTKpVRu5XlaZMS1WjFSd6MB5O4hAR/gVp+vLf
 kaOBinkJf38w==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764177"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:07 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     qemu-devel@nongnu.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH v3 15/31] tests/acpi: remove stale allowed tables
Date:   Mon,  1 Feb 2021 16:59:32 -0800
Message-Id: <20210202005948.241655-16-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

     Scope (_SB)
     {
         Device (PCI0)
         {
             Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
-            Name (_ADR, Zero)  // _ADR: Address
             Name (_UID, Zero)  // _UID: Unique ID
+            Name (_ADR, Zero)  // _ADR: Address

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 tests/data/acpi/pc/DSDT                     | Bin 5065 -> 5065 bytes
 tests/data/acpi/pc/DSDT.acpihmat            | Bin 6390 -> 6390 bytes
 tests/data/acpi/pc/DSDT.bridge              | Bin 6924 -> 6924 bytes
 tests/data/acpi/pc/DSDT.cphp                | Bin 5529 -> 5529 bytes
 tests/data/acpi/pc/DSDT.dimmpxm             | Bin 6719 -> 6719 bytes
 tests/data/acpi/pc/DSDT.hpbridge            | Bin 5026 -> 5026 bytes
 tests/data/acpi/pc/DSDT.hpbrroot            | Bin 3084 -> 3084 bytes
 tests/data/acpi/pc/DSDT.ipmikcs             | Bin 5137 -> 5137 bytes
 tests/data/acpi/pc/DSDT.memhp               | Bin 6424 -> 6424 bytes
 tests/data/acpi/pc/DSDT.numamem             | Bin 5071 -> 5071 bytes
 tests/data/acpi/pc/DSDT.roothp              | Bin 5261 -> 5261 bytes
 tests/data/acpi/q35/DSDT                    | Bin 7801 -> 7801 bytes
 tests/data/acpi/q35/DSDT.acpihmat           | Bin 9126 -> 9126 bytes
 tests/data/acpi/q35/DSDT.bridge             | Bin 7819 -> 7819 bytes
 tests/data/acpi/q35/DSDT.cphp               | Bin 8265 -> 8265 bytes
 tests/data/acpi/q35/DSDT.dimmpxm            | Bin 9455 -> 9455 bytes
 tests/data/acpi/q35/DSDT.ipmibt             | Bin 7876 -> 7876 bytes
 tests/data/acpi/q35/DSDT.memhp              | Bin 9160 -> 9160 bytes
 tests/data/acpi/q35/DSDT.mmio64             | Bin 8932 -> 8932 bytes
 tests/data/acpi/q35/DSDT.numamem            | Bin 7807 -> 7807 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |  21 --------------------
 21 files changed, 21 deletions(-)

diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index f6173df1d598767a79aa34ad7585ad7d45c5d4f3..b516745128e3f1a297b6327e9057026a2d16229c 100644
GIT binary patch
delta 20
bcmX@9eo}oxJ7=h;3j;^Iqf5}n36{bDOsEE~

delta 20
bcmX@9eo}oxJEx;d5CcbisHe-u36{bDOlAhI

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index 67f3f7249eaaa9404ebf0f2d0a324b8c8e3bd445..aeae285c6434ae6cf3c53660e34425727a497871 100644
GIT binary patch
delta 20
bcmexn_|0%aJ7=h;3j;^Iqf5}n3271lRUHRT

delta 20
bcmexn_|0%aJEx;d5CcbisHe-u3271lRNDtm

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index 643390f4c4138b37fc481656d3f555d0eeedcb02..4cd26a87dd11d96e10bf6de786b9d56ebfe0a4f9 100644
GIT binary patch
delta 20
bcmeA%>oJ?q&Kc_I!oU&l=n}MXLX8vvMneXi

delta 20
bcmeA%>oJ?q&gtk9#J~|B>glp^LX8vvMgaz#

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index 1ddcf7d8812f5d8d4d38fe7e7b35fd5885806046..fecb784812cbb2308ef58acf4a2c580f56d35c39 100644
GIT binary patch
delta 20
bcmbQKJyUx^J7=h;3j;^Iqf5}n37nz;MY;wk

delta 20
bcmbQKJyUx^JEx;d5CcbisHe-u37nz;MR*1%

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index c44385cc01879324738ffb7f997b8cdd762cbf97..f2c31e150ead16e4931367a6dab42704950a21e9 100644
GIT binary patch
delta 20
bcmdmQvfpGvJ7=h;3j;^Iqf5}n3F{>RP4WjY

delta 20
bcmdmQvfpGvJEx;d5CcbisHe-u3F{>RO|S<r

diff --git a/tests/data/acpi/pc/DSDT.hpbridge b/tests/data/acpi/pc/DSDT.hpbridge
index 4ecf1eb13bf49499f729b53a6d0114672a76e28d..7a8955cdbc52c025a2fd8f160cf8aff9442c985b 100644
GIT binary patch
delta 20
bcmZ3azDRvSJ7=h;3j;^Iqf5}n2|~gEMvw+M

delta 20
bcmZ3azDRvSJEx;d5CcbisHe-u2|~gEMotDf

diff --git a/tests/data/acpi/pc/DSDT.hpbrroot b/tests/data/acpi/pc/DSDT.hpbrroot
index a3046226ec1dcb234b726029b3790dfedb3b9221..88d23fca4743c2ee57493e7d77d6297a60964d3c 100644
GIT binary patch
delta 20
bcmeB?=#iMv&Kc_I!oU&l=n}MXLJc<nLHq_$

delta 20
bcmeB?=#iMv&gtk9#J~|B>glp^LJc<nLAnM}

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index f1638c5d079a9442c09390426a913010df6efd8d..d670ae793b5778c095a7f8c79ff1a046889d1a56 100644
GIT binary patch
delta 20
bcmbQJF;QbeJ7=h;3j;^Iqf5}n35~)4MGOXr

delta 20
bcmbQJF;QbeJEx;d5CcbisHe-u35~)4M9Kz;

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index 4c19e45e66918c61674785c99e4474e58866f125..a7de3d9fd94e62e8fc357fe3093bf7f394a39219 100644
GIT binary patch
delta 20
bcmbPXG{a~@J7=h;3j;^Iqf5}n2^|suN0A1$

delta 20
bcmbPXG{a~@JEx;d5CcbisHe-u2^|suM^6T}

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index 40cfd933259af05ac2aee07fca32f22122255211..57958b6cec216c1fb8731f4ed2da67f0fad7484a 100644
GIT binary patch
delta 20
bcmX@FeqMb-J7=h;3j;^Iqf5}n3HHJOO_&D2

delta 20
bcmX@FeqMb-JEx;d5CcbisHe-u3HHJOO;!fL

diff --git a/tests/data/acpi/pc/DSDT.roothp b/tests/data/acpi/pc/DSDT.roothp
index 078fc8031b479cc77b6527a2b7b4bd576b6e6028..624d0e367693fe267a4237a5fc97295cee2ebd60 100644
GIT binary patch
delta 20
bcmeCx?A4sm&Kc_I!oU&l=n}MX!e3zkMUV#m

delta 20
bcmeCx?A4sm&gtk9#J~|B>glp^!e3zkMNS6(

diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index d25cd7072932886d6967f4023faac1e1fa6e836c..17e2aebde98e0a3161d93e9b2e200737b13699ac 100644
GIT binary patch
delta 21
dcmexq^V4R+<cTvI**M}IU4j@kOEJdF0sv{z2gd*a

delta 19
bcmexq^V4R+WEMx4Aclz(n>R}_#>)Z#RX+z<

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index 722e06af83abcde203a2b96a8ec81fd3bab9fc98..7b3d659352a0923822f6a5db1dbd0a6ad853c446 100644
GIT binary patch
delta 21
dcmZ4HzRZ2X<cTvI**M}IU4j@kOELB+0RUdw2WbER

delta 19
bcmZ4HzRZ2XWEMx4Aclz(n>R}__9y`WOK1lA

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index 06bac139d668ddfc7914e258b471a303c9dbd192..5961b55b1067c3090b2f1f4cd3386d71efee241d 100644
GIT binary patch
delta 21
ccmeCS?Y5mTdE(4QHja2lmmr4CQjCSN09fk={{R30

delta 19
acmeCS?Y5mTnZ?m1h+*Qy=FL)!g|Yxf4F-?^

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 2b933ac482e6883efccbd7d6c96089602f2c0b4d..09c92d52f92bb346ed807945b9638cad958446f8 100644
GIT binary patch
delta 21
dcmX@<aMEGI<cTvI**M}IU4j@kOEK!p0{~)+2SES;

delta 19
bcmX@<aMEGIWEMx4Aclz(n>R}_>dONFPN@dc

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index bd8f8305b028ef20f9b6d1a0c69ac428d027e3d1..1da97afb32dddafefe7f27934acbcb7d56a67489 100644
GIT binary patch
delta 21
dcmaFw`QCHF<cTvI**M}IU4j@kOEF$m1^{az2uT0{

delta 19
bcmaFw`QCHFWEMx4Aclz(n>R}_UR4GFR)YuH

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index a8f868e23c25688ab1c0371016c071f23e9d732f..c7e68432b66e7b4d03284c882c65bbf3066825dc 100644
GIT binary patch
delta 21
dcmX?Nd&G9a<cTvI**M}IU4j@kOEIpJ1ps122dV%7

delta 19
bcmX?Nd&G9aWEMx4Aclz(n>R}_u95`+PJ;(K

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 9a802e4c67022386442976d5cb997ea3fc57b58f..3af457dd550461b2d2ea85aa85d7740452913b34 100644
GIT binary patch
delta 21
dcmX@%e!_ji<cTvI**M}IU4j@kOEIof0sv%g2hRWi

delta 19
bcmX@%e!_jiWEMx4Aclz(n>R}_u2TX4P;>`i

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index 948c2dc7264c31932b490ca00691a7c4d9aefdb0..a4d20f676ac173e6846dcd4e076220d512215963 100644
GIT binary patch
delta 21
dcmaFj`owj@<cTvI**M}IU4j@kOEI2O1ORBc2p#|c

delta 19
bcmaFj`owj@WEMx4Aclz(n>R}_o>Bw=R96SD

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 44ec1b0af400da6d298284aa959aa38add7e6dd5..bbab0d10a2a064528519fa69e90c799430129b75 100644
GIT binary patch
delta 21
dcmexw^WSE|<cTvI**M}IU4j@kOEIR(0sv~w2iX7s

delta 19
bcmexw^WSE|WEMx4Aclz(n>R}_rpf{URwD;$

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 5c695cdf37..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,22 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.hpbridge",
-"tests/data/acpi/pc/DSDT.hpbrroot",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/pc/DSDT.roothp",
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.dimmpxm",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.numamem",
-"tests/data/acpi/q35/DSDT.tis",
-- 
2.30.0

