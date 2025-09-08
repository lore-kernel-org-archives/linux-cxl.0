Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3B12DDA1
	for <linux-cxl@vger.kernel.org>; Mon,  8 Sep 2025 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336602; cv=none; b=arGztVZeM4UdoovfWr9tkBQ+8AEzVjckSaRhxetEtYqHuLSGETW9FkciSMLHYUYp+Lai0J/TK+pN18c7cCdd6hL8h5K+q4463Fjc4rF+j+gkxOTq8oXlix/3ZisItR3HuPQEOTsnbNXjB0ZoJ7j+by4DSLYoDjP45JkIXUE3KKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336602; c=relaxed/simple;
	bh=GJ0QHTeajaUyuNVy5ZZLI0vj0YTsLtlz1zBE3aaFHOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=cH65It+4J3MPxpL22siHRktOzr7YOghdGtzCh53yMMVM4comttUSF5+STR9kYCl3cQeCclg2XfCiSn2bF5K1LCx/K8prHrOZiWqeohfA+Vhgt+GBAQaQOVyIXZ/5rKqj6AQcHFZOpAMnB9ujdx3WnpdbxKXTQHpDq1Qr8ggI+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bEK0K04F; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bEK0K04F"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250908130317epoutp01eba0238884ca8a688442a58f9bfcb33d~jUFM4px0H3178431784epoutp01a
	for <linux-cxl@vger.kernel.org>; Mon,  8 Sep 2025 13:03:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250908130317epoutp01eba0238884ca8a688442a58f9bfcb33d~jUFM4px0H3178431784epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757336598;
	bh=LN4sH3UwtU8HIQkrEetlva5pwUT35yq63hIpFGzCTV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bEK0K04F5SJ/9sHJneSvBjCuRA7V7M72gQco0MrRWUDRLigg0DNZp5zSREiJEDH6a
	 QwR0hg60OdMILmwmWXs9dXQS8j3vFCIWqrIoqLsIT1p8pxJetIZ1x5u+buYakgyOCZ
	 O2fThdZcvMCyqazooAq1zDt5CEF4IhVEIQGbQv2c=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250908130316epcas5p25fd6caaa932fdd13a4133e376d1bc338~jUFLhYoNP1212412124epcas5p2E;
	Mon,  8 Sep 2025 13:03:16 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cL6ZW3l7lz2SSKY; Mon,  8 Sep
	2025 13:03:15 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250908130314epcas5p35e0086154cafff6515126e01f7981d3b~jUFJ61k3a2761427614epcas5p3A;
	Mon,  8 Sep 2025 13:03:14 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250908130313epsmtip1d1c2bbfc880dc95c15605b896d1d6252~jUFIfPFrE1029310293epsmtip13;
	Mon,  8 Sep 2025 13:03:13 +0000 (GMT)
Date: Mon, 8 Sep 2025 18:33:03 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	dave@stgolabs.net, Jonathan.Cameron@huawei.com, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com,
	cpgs@samsung.com
Subject: Re: [PATCH v3 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250908130303.hxqdq5yldwpguojo@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2d731c30-bf0c-49c6-b519-4b558d794b08@oracle.com>
X-CMS-MailID: 20250908130314epcas5p35e0086154cafff6515126e01f7981d3b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f81a4_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250904131944epcas5p351c0e073a975b1347c4a61aa0dd511f3
References: <20250904131904.725758-1-arpit1.kumar@samsung.com>
	<CGME20250904131944epcas5p351c0e073a975b1347c4a61aa0dd511f3@epcas5p3.samsung.com>
	<20250904131904.725758-3-arpit1.kumar@samsung.com>
	<2d731c30-bf0c-49c6-b519-4b558d794b08@oracle.com>

------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f81a4_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 05/09/25 02:18PM, ALOK TIWARI wrote:
>
>>@@ -4791,6 +4907,28 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>>      cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
>>      cci->d = d;
>>      cci->intf = intf;
>>+    CXLUpstreamPort *pp;
>>+    int pn = 0;
>>      cxl_init_cci(cci, payload_max);
>>      cxl_set_phy_port_info(cci);
>>+    /* physical port control */
>>+    pp = CXL_USP(cci->d);
>>+    for (int byte_index = 0; byte_index < (CXL_MAX_PHY_PORTS / BITS_PER_BYTE);
>>+         byte_index++) {
>>+        unsigned char byte = pp->pports.active_port_bitmask[byte_index];
>>+
>>+        for (int bit_index = 0; bit_index < 8; bit_index++, pn++) {
>>+            if (((byte) & (1 << bit_index)) != 0) {
>>+                qemu_mutex_init(&pp->pports.perst[pn].lock);
>>+                pp->pports.perst[pn].issued_assert_perst = false;
>>+                /*
>>+                 * Assert PERST involves physical port to be in
>>+                 * hold reset phase for minimum 100ms. No other
>>+                 * physcial port control requests are entertained
>
>typo physcial -> physical
>
Thanks for pointing out!
>>+                 * until Deassert PERST command.
>>+                 */
>>+                pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
>>+            }
>>+        }
>>+    }
>>  }
>>diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>>index 9fc720ec10..033d9bf11a 100644
>>--- a/include/hw/cxl/cxl_device.h
>>+++ b/include/hw/cxl/cxl_device.h
>>@@ -130,6 +130,7 @@
>>                    (1 << 16))
>>  #define CXL_MAX_PHY_PORTS 256
>>+#define ASSERT_WAIT_TIME_MS 100 /* Assert - Deassert PERST */
>>  /* physical port control info - CXL r3.2 table 7-19 */
>>  #define CXL_PORT_CONFIG_STATE_DISABLED           0x0
>>@@ -196,6 +197,14 @@ typedef struct CXLPhyPortInfo {
>>      uint8_t supported_ld_count;
>>  } QEMU_PACKED CXLPhyPortInfo;
>>+/* Assert - Deassert PERST */
>>+typedef struct CXLPhyPortPerst {
>>+    bool issued_assert_perst;
>>+    QemuMutex lock; /* protecting assert-deassert reset request */
>>+    uint64_t asrt_time;
>>+    QemuThread asrt_thread; /* thread for 100ms delay */
>>+} CXLPhyPortPerst;
>>+
>>  /* CXL r3.1 Table 8-34: Command Return Codes */
>>  typedef enum {
>>      CXL_MBOX_SUCCESS = 0x0,
>>diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
>>index 5c918c53a9..5c31023590 100644
>>--- a/include/hw/cxl/cxl_mailbox.h
>>+++ b/include/hw/cxl/cxl_mailbox.h
>>@@ -88,6 +88,7 @@ enum {
>>      PHYSICAL_SWITCH = 0x51,
>>          #define IDENTIFY_SWITCH_DEVICE      0x0
>>          #define GET_PHYSICAL_PORT_STATE     0x1
>>+        #define PHYSICAL_PORT_CONTROL       0X2
>
>use 0X2 -> 0x2
>
Thanks for pointing out the typo's, will update the same in v4.
>>      TUNNEL = 0x53,
>>          #define MANAGEMENT_COMMAND     0x0
>>      MHD = 0x55,
>>diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
>>index 3b7e72bfe0..4b9da87d77 100644
>>--- a/include/hw/pci-bridge/cxl_upstream_port.h
>>+++ b/include/hw/pci-bridge/cxl_upstream_port.h
>>@@ -30,6 +30,7 @@ typedef struct CXLUpstreamPort {
>>          uint8_t num_ports;
>>          uint8_t active_port_bitmask[CXL_MAX_PHY_PORTS / BITS_PER_BYTE];
>>          CXLPhyPortInfo pport_info[CXL_MAX_PHY_PORTS];
>>+        CXLPhyPortPerst perst[CXL_MAX_PHY_PORTS];
>>      } pports;
>>  } CXLUpstreamPort;
>>-- 2.34.1
>>
>
>Thanks,
>Alok
>

------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f81a4_
Content-Type: text/plain; charset="utf-8"


------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f81a4_--
