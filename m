Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793792287;
	b=gZty1bQW5fVXjN7r1VQd4L7pxswt1NnIOoq4/Lni/wOAOSUltnJUEVUs9sECBVMu/h8a
	 o/VC1qtcytojaOU521oYjyHxWccM4Dg5rIsDi93rPTJ4wleC6y1fjVZsJF1ho9KW/NNcq
	 Y5g+V6Wdd4Y7JDG/Kd13PjN5zK/G8+4B/PgpILy0K0/6Zuci6Bdu0mMNbWItUzG92rwkj
	 CkrxTOHFx2p0cMGL0nBGy7MbsxyVdjdu0rJA+/Q6/5D2keGhaze/Mn/sq1X+K3x882+YH
	 jXpNW9inZSZWgfhxN2WmCcxnXISZHhFxsakFa8hBIvjgF5NIn52PZ4n7n/uE1LdaIvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792287;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:MIME-Version:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:X-CPGSPASS:
	 X-Hop-Count:X-CMS-RootMailID:References;
	bh=xoWhSvTg6fY+bu1sbnwUxbdA5T90p3JpGb15UCwiuac=;
	b=AjGhy3zXqQXaLx8auYDEK2nAg46tuu/yXmzyrCWVz4hUx8gpJB2+7jMeXM7ZJQZrM5CR
	 +C4QzvIT1idhMWBwdIZhDpTiBCQhc5O36m3F7x4aErGVqEZPSqACEK7UYqcKjY1hnAzDn
	 B3VwkTrgoGbIc+ZaewN4a1llad0K9hwL38HDskCcJpDRpCtL8XFAgFDG5tiWKZ8tIUJ99
	 +gh2hsmMe0LVpZM2FXx+TPA4bXgdnoI3J+VQYMCtSP4OhaxqcWrlZ2K3GFOkSKOcsEjjF
	 uRPG8apkwVS6ivkf9nNsaV0nBEgk1d8f6sZaUFJQEZFBeAmn7LuNTGvNMhd4TfSvcog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="MenO/nYT";
	arc=none smtp.remote-ip=203.254.224.33
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3B606D822
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 11:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88F3B606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=MenO/nYT
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261104113804epoutp031b78e70001b7ea41be090ebc3d90a1f7~k1JQoem4W1674116741epoutp03C
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 11:38:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261104113804epoutp031b78e70001b7ea41be090ebc3d90a1f7~k1JQoem4W1674116741epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793792284;
	bh=xoWhSvTg6fY+bu1sbnwUxbdA5T90p3JpGb15UCwiuac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MenO/nYTihP4cb4n/nNvlPqEg315uN0Lq8iKjZWlfUCYJMQqqeet/qrljzpC0j0Bs
	 tslIaz1U0v0jX4qXoL1BtoQhZYrFELljJMOdaPUmG4k7gIt615zdL8jzxJe2VBOMSu
	 OiPSxSIEyuFRuhGTlz4wP4U0XgOviGGKwbmw/i/Q=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261104113803epcas5p2f56d2b7ae8773bb15e157a7db8bc7a50~k1JPzXVbt1387013870epcas5p2S;
	Wed,  4 Nov 2026 11:38:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4jKNjR3KrDz6B9m4; Wed,  4 Nov
	2026 11:38:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20261104113020epcas5p312cb465740fb11b04b576aa6d026a81f~k1CgjSlA51814518145epcas5p3A;
	Wed,  4 Nov 2026 11:30:20 +0000 (GMT)
Received: from unvme-SYS-221H-TN24R.samsungds.net (unknown [107.99.40.127])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261104113017epsmtip10536a07f8b7f0d7456c9d5eace70cd7b~k1CePRkmm2317923179epsmtip1k;
	Wed,  4 Nov 2026 11:30:17 +0000 (GMT)
From: Shrihari E S <shrihari.s@samsung.com>
To: jic23@kernel.org, junjie.cao@linux.dev, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, qemu-devel@nongnu.org, anisa.su887@gmail.com,
	mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: shrihari.s@samsung.com, arun.george@samsung.com, cpgs@samsung.com,
	dave@stgolabs.net, dongjoo.seo1@samsung.com, gost.dev@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, anisa.su@samsung.com,
	junjie.cao@intel.com
Subject: [PATCH qemu v1 2/8] hw/pci: Move 'x-256b-flit' property from
 cxl_root_port to pcie_root_port
Date: Wed,  4 Nov 2026 17:22:36 +0530
Message-Id: <2052256418.81793792283466.JavaMail.epsvc@epcpadp2new>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104115242.2035807-1-shrihari.s@samsung.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261104113020epcas5p312cb465740fb11b04b576aa6d026a81f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20261104113020epcas5p312cb465740fb11b04b576aa6d026a81f
References: <20261104115242.2035807-1-shrihari.s@samsung.com>
	<CGME20261104113020epcas5p312cb465740fb11b04b576aa6d026a81f@epcas5p3.samsung.com>

Relocate the 'x-256b-flit' property from cxl_root_port to its parent
pcie_root_port so that all root port types inherit the property.

The cxl_root_port and cxl_downstream_port no longer carry a local
property definition; the property is inherited from pcie_root_port
and PCIEPort respectively.

Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
---
 hw/pci-bridge/cxl_root_port.c  | 1 -
 hw/pci-bridge/pcie_root_port.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 01463dbb07..e82685d1ab 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -237,7 +237,6 @@ static const Property gen_rp_props[] = {
                                 speed, PCIE_LINK_SPEED_64),
     DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
                                 width, PCIE_LINK_WIDTH_32),
-    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
 };
 
 static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index fe3ced5685..bc173dbf30 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -152,6 +152,7 @@ static const Property rp_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
+    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
 };
 
 static void rp_instance_post_init(Object *obj)
-- 
2.34.1


