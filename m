Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937595;
	b=ThNFGHxL6Yvq0D70pbz9X38+WbH05RFAgrbTVX43UFbRi//vYKms9IJfs0OCTCECMjRc
	 g+/Ue1LMwTe0JUDEf1MA+9J21hTwBpJvLBD1W1QBwa05foSLywkwsvWi5i2CkYuf9gr+j
	 KhCFRtStVXEgKBmDmYGtEB+/jRSHio04i3cpxTBKbXppykDb3FdSflj+nUUDKU0j/Jq3g
	 qkWS+1udPi6uAssssWtI39j8tlZDK5BIilLB7P4ikBfcyvT3li5OF+rcXu1SvOqpVceQh
	 GuUnRkSaOQS+/ItD7S0HzGSZ800gjEuhK0EIdKdBJ1gugWrJmUOLx9TR+zd6hEQd9Yw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937595;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HnSR126Mj/CA+uu/s3FWAAG6SpgpWIB9AL4klC7KutY=;
	b=xIliVjcYm7Kd4Rq8+2x8Pdb1Xz2mqoPL5zZRTdAOK1eqwRKlzHjFPT0Gps4ks3cPZLGj
	 v09yYH4H1R6kCyMXK17KmjlvVkXhXVgAE0mxtsvvbHMdI7a3Q9Z/tBKk3bcuEayZCOg7C
	 7z6kQtcxVakfhAO8YsaZcsGi5gmh660GUdR6t5jwlvyr8UnMN3A2908ITEmGX41kYyA1T
	 +0wt2AhSa89ajKDIABjeV/ANIEK7Sfvbvs1NLbNPyuCRK0/oWebPTIRcKxzYPCqkEyGgg
	 hOYIofWRWznL47FmKzedoAStg/dxDsDtEgittWru8mgd3gtJGOe6oNAAQqt7j9IN11g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="pYipSYs/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.41
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBE606A31B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 03:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14BBE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pYipSYs/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1x/IqU+FOtubOUCw1BNdFfV2V9V00CyA+tpiSxImDgpWqceC8PgMuACmzkjHE9Y3E3UUKTkQlV8AkYFN3574tSiQmI0dO2bAeBsWYDJAyJd4+xazHJF2bKo3aaqHuJVfRtYWEaJ0A2vh/GHiKEBhkP8N41fNZ0V/cWwZzBEEOPxlTrlUiLILo1wFmOCcMO9pU7lnUCGil5FCa+S22rIOgruxfqoKP7EetNhr70iAHcsyF9kn9XIYk50rhTCvRlwOHgjK840yBWj2/6h9gSASDtzl6z440fsAdFQcZLfKF1CwGep7PieghapU0apcSArz6UC9bCXjAgl/bOjJZ5Ttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnSR126Mj/CA+uu/s3FWAAG6SpgpWIB9AL4klC7KutY=;
 b=clGruNd/CXQCHsHA+3SCyHBwKqxgFJRhUeTXk2m1OYndGJTSBfdBgiFNYxX1BKlfyxObbq7Xuxh+VU9UwzW8GAeCKkBMZwiY5oGaV3wSYwyPhzFixWDlXeKs9jNKpCj5EAuOmdevWTKwmwfGGY9s1KEVrt5VWns3UCRRCuO/t47rEUgwUMnaMTlWPhLY0PdeaxweR+O6jXjBTSL40sI5S8ukguwAKhSoGNfyzClx4UbMTroK2IHsIyJ0gQq6RS10VXfd+Qnh+j4ocaszV94UgolvyOFk+U2kA6y403b5F+bEHwooWh8uh5pEjdahtdMcbgMgHDSyPr0bENCdWmxGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnSR126Mj/CA+uu/s3FWAAG6SpgpWIB9AL4klC7KutY=;
 b=pYipSYs/d9VbFXESzu+TZkDWGYMzYK4ykPT8FqoP3Ee951ppWG9P78SRLiy6ArDr/9ZY6fTL4evqyCa3X+zRJQp43yx9r3h49wNqDBk2gBN+3mUTvG95yHkeU5GDPfK3U5X3ULTDRuReFZPHAWt9t5BXqvdo6s4pvY0KWz1LQI+IqAPsuisxCnvdyl51B7iaGosu4ZCnzqHhkal4wkBSWxxs03XAC49Qe5T0CqiD1KWAe1kCilYKJmzFugQKcPwXyW95ovC4WKi64t3fKhYyUoW3lXx+xvsgoN8LF0yAgHPmkOHe8kschwp+h+jvWa/GtBONjto3C5jhOKEZ6IQwmg==
Received: from MW4PR04CA0281.namprd04.prod.outlook.com (2603:10b6:303:89::16)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 03:59:48 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:303:89:cafe::a8) by MW4PR04CA0281.outlook.office365.com
 (2603:10b6:303:89::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 03:59:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 03:59:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:33 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:27 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 00/18] hw/cxl: Add a CXL Type-2 device
Date: Fri, 6 Nov 2026 09:28:53 +0530
Message-ID: <20261106035911.1280066-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: bf37dd54-2c1e-48ee-e76b-08df3bba66dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|18002099003|6133799003|10067099003|13003099007|921020|11063799006|261026121527099003|56012099006|261028144727099003|261102130727099003|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	qxGUzILoJ6DJvro8anl/B7Dcp5peZxDvfRxYbMRLewQS/VMoZIV8i8ZjLp0hUHWqFo08QGMrHP2XcaS8tFgMmRlgDn5xD+PCZHNIpH37ifMa6DqxQ1BKxz8jMH22QChb9DauukHF10FJ9WkxN3MPmesOmLZ9o+9Is2hSS4FTtiAUGyKoFtgldF9YvNSuYY3kOtNDaO9RK/9qR2qrrJQM91cVmXvcG/mbO4uMJ2Lc30XvdqUcIOKW396cr1dt0BC5xfUKeKzSvxiu86mCEpNP2uno8K7ZS7+BDO5hZJv28ga+V7rGQv1tq6TGDRvNtI3yamdXwsmljDV9AHwUgcpscYiZc1XjLPeBvShUqScOPr1D5LDxHLvw8wEi5LFcYDxSnVNL/dWOBMs3ifMtxwD8r3MFTD73MgqYkpuDmGzvIiKLuTaoAit3zW/5S+DVPT65BsTkHMkVVe5avwbCdj2zX+0fVZY9XaHNkxMZGL92fyx34dsNAwP+C4YT+OaTo+uiamOPkXgdbgyG3RMSOWbKabDBBmQuFt06d8JsEJNeBEnjh3WHTzM7qZcZXJerxSIX0y7VsYSP4kMtrKrYQgNII9Cepx5Bthw/cvrw4/TtjlyDRmMW9bj/Nm4PeZW9pGVCak7apvXrcPuMtQ0tdGbSl/TZr2xjJ8aHYMn7af9ya9phE5pvqgzpW0YS4FNZxNZJZnYugb0g4WgwZSWdkg1tAHo21RhPPI1FEwI2CjvwraL2IvHxaghId9TF39WkUpdf
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(18002099003)(6133799003)(10067099003)(13003099007)(921020)(11063799006)(261026121527099003)(56012099006)(261028144727099003)(261102130727099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	on7Fbw+cEcmkjXdZW1/n09ruNK8fV9KDO5rG4myQqy3X7dPSgtoWrVtkM0UdCK6pPlyTVwsGgGL0RWCWlla+/DDWNd16G+I3bPiz2ZKqkUH/b3gJAizas9Da6grdNEjyrP6DfvXUA04cDrzCzRz6iJG2s1jZp7VIT0dVK3RHu+05JKiV2i1Pcg0JCRBc1jx5m2L5PrcxNHoGTZVTFjw11Wc1Hcv+iJGACpVFkyLOovrKj9vn6rO9VPTdHsZRmcm+QMclFM7EmiAQ+RLfXNMzMqs/ySVQKikMoEjKn7TwVDOJpM0QXZsYJT5rk0SEn82pBFOsnVcFu9ENE10ySSI5Ayh9CJUgYHndQyHCYZzv0XhQShwc+dlxVVls9iFbFnuLayNl19pHWIjxYreN6VQ3ds3huzg3MGWg+L+Kw5a6TMLo5xg9YcgDu/rXzVVXyOBS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:59:48.4686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf37dd54-2c1e-48ee-e76b-08df3bba66dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032

From: Manish Honap <mhonap@nvidia.com>

Hello,

This series adds cxl-type2, an emulated CXL Type-2 device with volatile
device memory. It is emulated in such a way that all the Linux checks
are satisfied so that CXL passthrough using vfio-pci (vfio-cxl) can be
developed and tested in a guest without Type-2 hardware.

This series builds on the Type-2 model from Zhi's series (carried in
Cédric's tree) and carries one fix from Shuai's tree. Shuai's tree also
set up the decoders through device properties and stubbed CXL Reset; the
firmware setup and CXL Reset here are new code.
Carried patches keep their authors, with a note for each change.

The device:
- PCI ID 1b36:0017 and the processing accelerator class 0x1200;
- PCIe DVSEC for CXL Devices with CXL.cache, CXL.mem, one HDM range,
  cache write-back and invalidate, CXL Reset and Mem Clr; Register
  Locator and Flex Bus Port DVSECs;
- CXL.cache advertised but not modelled. The device sends no CXL.cache
  requests, and its memory is host RAM, which is coherent already. A
  cache write-back and invalidate completes at once. The capability is
  set because vfio-cxl takes a device as Type-2 only when it reports
  both CXL.cache and CXL.mem;
- component registers with one HDM decoder;
- slot 0, function 0 below a CXL root port of a pxb-cxl, memory in one
  fixed memory window selected with fmw-index, cold plug only (no
  hotplug or unplug), not migratable.

No Linux driver claims the device on its own. cxl_pci does not bind to
the accelerator class, and sfc, the other driver that calls the CXL
core Type-2 interface, matches only its own devices. A guest binds
cxl-type2 to vfio-pci, which hands it to vfio-cxl. Testing the CXL core
Type-2 interface without vfio-cxl needs a driver for 1b36:0017 that
calls it. There is none yet.

QEMU has no firmware that commits the HDM decoders of a CXL route at
boot, and Linux attaches a Type-2 device only to a committed region
(devm_cxl_probe_mem()). So QEMU does that step itself. cxl-type2
registers its range with its pxb-cxl at realize (patch 13). At every
reset the pxb-cxl commits HDM decoder 0 for it (patch 12), and the
device commits its own decoder with Lock On Commit and enables
CXL.cache, CXL.mem and HDM decoding (patch 14). A pxb-cxl with a
registered range keeps its HDM decoder even with a single root port,
where it would otherwise pass accesses through. Type-3 devices, and
pxb-cxl without a registered range, are not affected.

A CXL Reset keeps the locked decoder committed, as RWL fields are not
affected by CXL Reset once locked (CXL r4.0 Table 8-1). DVSEC Control,
the range bases and HDM Decoder Global Control return to their
defaults, which leaves Mem_Enable and HDM Decoder Enable at 0. While
either is 0 the device drops CXL.mem, so guest accesses to its memory
fail until software sets both bits again. The CXL.io part of the reset
is not emulated. CONFIG_LOCK makes the RWL DVSEC fields read only until
a system reset.

Patches:
- 1-7:   Shared CXL code: read-0 ops for the CXL.io range of the
         component registers, helpers from Zhi, an HDM decoder count,
         DVSEC bit names, a device-neutral view for the direct mapping
         code, PCI IDs;
- 8-17:  The device; patch 16 also exports the default component
         register write handling, so the device can check the enable
         bits after a write;
- 18:    Docs;

Left for later series:
- The CXL device registers with the mailbox, event logs and MSI-X, and
  the CDAT;
- Direct mapping lifecycle fixes for Type-3 and switch topologies, and
  Lock On Commit in host bridges and switches;
- Fixes for guest-triggered aborts on 1 and 2 byte mailbox writes and a
  repeated DOE Go;
- Software-programmed decoders, for Linux-created Type-2 regions;
- A Type-2 device below a CXL switch, and migration.

Testing:
- Build every commit for x86_64 and aarch64, checkpatch for style.
- vfio-cxl selftest (vfio_cxl_type2_test) in an Arm L1 guest on KVM,
  with the device below a CXL root port and an SMMUv3: 19 of 19 pass

- Not tested: x86_64 L1, a build without CONFIG_CXL_TYPE2_DEVICE.

The Linux vfio-cxl series(v5) this was tested with:
https://lore.kernel.org/r/20260916183540.3813685-1-mhonap@nvidia.com

Sent as RFC to get comments on the series structure and to request
1b36:0017 devid for cxl-type2 device allocation.

References:
[PATCH RFC 0/5] hw/cxl: Type 2 Device RFC
https://lore.kernel.org/linux-cxl/20230517-rfc-type2-dev-v1-0-6eb2e470981b@intel.com/

Type-2 emulation trees:

[1] Zhi Wang
https://github.com/zhiwang-nvidia/qemu/commits/zhi/qemu-type2-emulation-for-review

[2] Cédric Le Goater
https://github.com/legoater/qemu/tree/cxl-type2

[3] Shuai Xue
https://gitee.com/axiqia/qemu-kvm/tree/cxl-type2-test

Manish Honap (12):
  hw/cxl: Make HDM decoder initialization count-aware
  hw/cxl: Define the CXL Device DVSEC capability and control bits
  hw/cxl: Find the memory of a CXL device through one helper
  hw/pci: Add PCI IDs for the CXL Type-2 device
  hw/mem: Require a CXL root port of a pxb-cxl for cxl-type2
  hw/pci-bridge: Add firmware HDM decoder state to pxb-cxl
  hw/mem: Bind cxl-type2 to a fixed memory window
  hw/mem: Commit the cxl-type2 HDM decoder at reset
  hw/mem: Add CXL.cache with cache write-back and invalidate to
    cxl-type2
  hw/mem: Implement CXL Reset for cxl-type2
  hw/mem: Clear the cxl-type2 volatile memory on a CXL Reset request
  docs/cxl: Document the CXL Type-2 device

Shuai Xue (1):
  hw/cxl: Give the component register .io sub-region read-0 ops

Zhi Wang (5):
  hw/cxl: Factor out cxl_host_addr_to_dpa()
  hw/cxl: Introduce cxl_component_update_dvsec()
  hw/cxl: Introduce CXL type-2 device emulation
  hw/cxl: Add the CXL type-2 DVSECs and component registers
  hw/cxl: Map the CXL type-2 device memory through the fixed windows

 MAINTAINERS                             |   1 +
 docs/specs/pci-ids.rst                  |   2 +
 docs/system/devices/cxl.rst             |  68 +++
 hw/cxl/cxl-component-utils.c            | 227 +++++++++-
 hw/cxl/cxl-host.c                       | 130 ++++--
 hw/mem/Kconfig                          |   5 +
 hw/mem/cxl_type2.c                      | 580 ++++++++++++++++++++++++
 hw/mem/cxl_type2_stubs.c                |  20 +
 hw/mem/cxl_type3.c                      |  68 +--
 hw/mem/meson.build                      |   2 +
 hw/pci-bridge/pci_expander_bridge_cxl.c |  27 +-
 include/hw/cxl/cxl.h                    |   1 +
 include/hw/cxl/cxl_component.h          |  26 ++
 include/hw/cxl/cxl_device.h             |  27 ++
 include/hw/cxl/cxl_pci.h                |  31 ++
 include/hw/pci/pci.h                    |   1 +
 include/hw/pci/pci_bridge.h             |   6 +
 include/hw/pci/pci_ids.h                |   3 +
 18 files changed, 1102 insertions(+), 123 deletions(-)
 create mode 100644 hw/mem/cxl_type2.c
 create mode 100644 hw/mem/cxl_type2_stubs.c


base-commit: f71afb409a87c4ecd0f9d63a5963eb645dfab780
-- 
2.53.0

