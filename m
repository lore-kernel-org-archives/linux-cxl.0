Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937692;
	b=UqNunsmjahJTRAuIp8nuzpnHOLIj4LlxD98g8nN/8y04QJFA7UufRWUGXtBKPENZXY8m
	 HQr8InqeZ6b3ZrzUGILYqbK4aZe7WBDwMPBQvXFo6zSr5HNTSvjWHgIhSUZlx3IXuq41a
	 zE1/wfNw3mpL3N5EGneV+VuDbQWha+bUEpmkggVLikbvZRnW3cP4SO1xkODUEu2PEQdl3
	 AvgDzWoWM+MKZbMxtY3HblbJgh0APZOtiy/ts2BRRcKRRysDr+FO7jFLO9EApdVDvbwtD
	 7s78oepyqH0qcbX6tMi63RHMvKwpWWNJr8XOaqQuHue5+/X2VeSkc4AOfLSLz/JexSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937692;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qMkpQpdpOM5j55X7AZ/ANf2xFdgq1TuxAGzEHriNSBs=;
	b=wC3ES13OSd9yln+UteICQ7hij+1sk/3PwGsfYgMtSqpL0QvL+T6DtjI/4ohfsOG8/WdT
	 XIpyLXif1JRejjMg3NRFeB+E86nezA1LskZA4LGbgNpo5nQhAQ9At6WpD0OlzBw3V/E3C
	 /6yzR1gF/2FRVqnKqa1u9aeps0JtLsJ8rqLw7sTaPdNOWCr+gEWYWJICiK5YwyyYWQrir
	 Tj56BrooiojEUKh58zwPI6pb1ythAO6UmCBNrLnh647y1uf+P+JuveOkMGykFdHXBueco
	 Y2Bjx3/3gZ3RfEaQ1O0Z8BmORi8sFiTtNud638jbRjN6Qqfr7VRxYV0Rwi3Pl9BIRvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bms2dao7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.48
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFDA606A31B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCFDA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bms2dao7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ky5Jy090I0LdFlVuDZaIJU+S4api4QvDv7ZTBMnwgKtFl8hU77HNrlqm7dUWZPLBOWZ02lDf03PsGYD/Hx3NJNfMtUH3sTV8ftjj8SsRK1iRLIgPvuFHiDCWhgSPVYebPn1CB55bT47DOYteHkTPtnGvEBy8lHfd/EdNix//0mXSKr4l1PtejXCMe7nXoQ8xXtzDz1nbTY1dM8ObwSEf6qn2MNQLBDW6SaVL2tT4WAKCXteRp1TrC0Jol4CdKpaqipVj439s3d30zLhJWZ/Q4XBUz8cZiuhWf47G73TdD69cOXg3QKqTEkCpvLatF+JjmfD8kYwpDRAXpaBrlb2P+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMkpQpdpOM5j55X7AZ/ANf2xFdgq1TuxAGzEHriNSBs=;
 b=sPwvb7o7gr6UAubjHxPzbqMXKZ8RillOBfw92umVPqgskA/ydPBYlrmHyl4H8dpgTAQRYYgcGRXx+Enbn+rSSca1pfVMxu0Mh+Xl2QrBJ6zTkJwJt2/uD91PLQEdzR5RhyhA2QfExCAxujj/YDa/p3aF7cBGPoa2abY4tSjU0IZ9vsuYs0p3wLlxRgHC0eBb+Lq40trUtKLX+vCuUwH3r78C71fKSyttgOZzYtImhlvqy+FjqdpWmh6ilV0O1vvEZCLN5HKQTjmvFUUT6cjL40Vhdxgqq8/DsQ3uHesLCgy/F27AkpRBMn1y4OBwykbA+msOtDHe/KEE6IBIzw1DAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMkpQpdpOM5j55X7AZ/ANf2xFdgq1TuxAGzEHriNSBs=;
 b=Bms2dao7V1/4U1gxr23pOiIGKWCEN/tYmAjemt9qiY9q0DGYcDKlXiVW/V6gb9bGKX08NJcdfbKbY/ByoBcqTjtmlCkPK1oNBRlUxI5y9VC6vlCO68IEpMX2i7T/KtuUtsnwLJjyJAvJbtolAahdDqo7dwK+dTHfXlXyXa6ahVRB537S5qPQVGDdG6bFI0w6wBoTDW9OyIUKDpR8HrAFbRcB0hgVRsyqFayR7J6w4gZ6pOLmWijKskH8Wsl1eHeQa2/cmyASf+thF12WmS0xcPRsucBZqm/8UwN1e8JbKa/CoHjQRpcjGYb/nHIrMdPA+BQqR8Q1qQRtMOYem1dw7w==
Received: from MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::24)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 04:01:28 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::89) by MW4P222CA0019.outlook.office365.com
 (2603:10b6:303:114::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:01:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:01:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:01:12 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:01:06 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 18/18] docs/cxl: Document the CXL Type-2 device
Date: Fri, 6 Nov 2026 09:29:11 +0530
Message-ID: <20261106035911.1280066-19-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
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
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a97dfd-7fd6-428f-bc69-08df3bbaa1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|82310400026|36860700016|261009223027099003|921020|261021123027099003|261021121427099003|11063799006|56012099006|261028144727099003|261022105027099003|261026121527099003|261026140227099003|10067099003|18002099003|261102123227099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LzEsvsrtzlZdUxKWgDyH5Ix31EYDlbEoUdw0T17N+LebNb7GczaH15yJU4DK8QoJR88pusKRAq9eOO+sQ9t/oyKU2N+STFHUh9hK7q5qGRo2Hr+qd5YlEITN1xN0r6dHaV8fahWXyOCplWMgbCdgbMrOyAPMWaHQM5OGyh6K6QjdDPi2BL4ARIIYYX7JSD2BXbI9/uTWdlEbDe9D8zw21gDZp0sAwVOz6fsuzLv1Qo1WSP29MOOq9DMr/9/F2BvG45mY6CAMfIac/toA5MUFBsotgq6iFeYYDga4RZMNwNAouSgbrTnnrJETJ76OcNV/t8+Q92gWIXh2+pyryzWGfMN/L87hMuVnrNN//jp9MbtyYE5Yv649RI+IoSGGmMG7X8LNg8XwIkK1Gs9QgE/f4lSi3FHDjaT6aAelsvtjgoOyQ+9SlWG5nwp9ph3H79B33nWEb9xPItF+oa5MbJ7mSW7xeUyGcHg+3NXDuPA02pMDbdSQ4OfBaekkTK71aWAKfSl1m0gmuqQykHpjwxW42S1dZYs8Pot+gWLIG/DNwf7ObrFSytaJfcDywbMhLHez4j8/nv5+ytc+SdmkyKiKvECZH4jXKmSQKPHumeaCt2XNrvjHgw10934TaBumiowAl0ZQCzWqJeBeE9G5dcoenaxiqF5JzM5db+PytJX68MPiDdP4ePeW8nd2JxUBt55Nj3lLLJf6EYMMFqPyuvv+NWBNYr29QnRJSJySEzlRwegM8bAtauzagVmmCTqVCEA8
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(261009223027099003)(921020)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(261102123227099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H6o+IgXKjdtzI4bJbQDeRX6zFwAsX8qfdPSU27JC43bcTZn+Uk0P2lAsXDApzYA5L9vODk+3XqzQWeoKeWHIWeTynuGdKRiOvSQRgT+R9FiqNAzJ8XCYZF6oR/PlMmz1OA2/Se8TCf91DmDmVdCDSCtjViXbVEAufaEmXxcAWqsDTiJBRJS42VM8g9wF+J/z8Yy0lioDrCnzd0Y9eVPQvfBNd1HIvkOV1mrRToB25Fz/nNrXGCjX59ryGGCktvmkbHiIv4fn/ervTPSGzvnTQPuzw9JYoNNYro/5cnwXfAQJXB57oTj7IbgahTepcBQnvXelja/R+sRBuoCAkQgmVwpOAz/w0vPlDrkimqn7OMPv7W9KInPKc6243t++80alB6g814CIZlhd7GVI0ZuiUuT2Qxju84cUcJFQbSR8RiONzbz7jIvdrVUl5cHjMAFv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:01:27.4957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a97dfd-7fd6-428f-bc69-08df3bbaa1e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

From: Manish Honap <mhonap@nvidia.com>

Describe cxl-type2, how a guest uses it, its CXL.cache support, where
it can be placed, the decoder state it gets at reset, CXL Reset, and
example command lines for q35 and virt.

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 docs/system/devices/cxl.rst | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 6bee339cea..b98a066919 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -147,6 +147,53 @@ though in these EP devices, the decoder is responsible not for
 routing but for translation of the incoming host physical address (HPA)
 into a Device Physical Address (DPA).
 
+CXL Devices - Type 2
+~~~~~~~~~~~~~~~~~~~~
+``cxl-type2`` is a CXL Type 2 device with volatile device memory. It
+emulates the registers that host software uses to find and set up such
+a device.
+
+The device uses the processing accelerator class code 0x1200, so the
+generic CXL memory device driver does not bind to it, and no other Linux
+driver claims it on its own. A guest uses it through vfio-pci, which
+hands a CXL Type 2 device to the proposed vfio-cxl driver, or through a
+driver of its own that calls the Linux CXL core Type 2 interface. Its
+Device DVSEC reports CXL.cache, CXL.mem, one HDM range, cache write-back
+and invalidate, and CXL Reset with memory clear.
+
+CXL.cache is advertised but not modelled. The device does not send
+CXL.cache requests, and its memory is host RAM. A cache write-back and
+invalidate request completes at once and reports Cache Invalid. The
+capability is set because vfio-cxl takes a device as CXL Type 2 only when
+it reports both CXL.cache and CXL.mem.
+
+The device must be at slot 0, function 0, directly below a CXL root
+port of a pxb-cxl, and cannot be hotplugged or hot-unplugged. A pxb-cxl
+can have one ``cxl-type2`` below it. The size of its ``volatile-memdev``
+must be a multiple of 256 MiB. ``fmw-index``, 0 by default, selects the
+fixed memory window. That window must target only the device's pxb-cxl,
+allow device-coherent memory and hold the whole memory backend.
+
+At every reset QEMU does what platform firmware does at boot. It
+commits the host bridge HDM decoder for the device memory, enables
+CXL.cache and CXL.mem, and commits the device HDM decoder at the window
+base with Lock On Commit set. The locked decoder is read only until the
+next system reset.
+
+The device memory is reachable only while Mem_Enable in DVSEC Control
+and HDM Decoder Enable in HDM Decoder Global Control are both set.
+Otherwise the direct mapping is disabled and accesses through the
+window fail.
+
+Software starts a CXL Reset through DVSEC Control2. The locked decoder
+stays committed. DVSEC Control and the range bases return to their
+defaults unless CONFIG_LOCK is set, and HDM Decoder Global Control
+returns to 0, so the memory is not reachable until software sets
+Mem_Enable and HDM Decoder Enable again.
+A CXL Reset does not repeat the firmware setup, and it leaves the PCI
+Command register and the BARs as they were. With CXL Reset Mem Clr Enable
+set, the reset zeroes the memory backend.
+
 CXL Memory Interleave
 ---------------------
 To understand the interaction of different CXL hardware components which
@@ -332,6 +379,27 @@ The same volatile setup may optionally include an LSA region::
   -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,lsa=cxl-lsa0,id=cxl-vmem0 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
 
+A CXL Type 2 device directly attached to a CXL root port. The fixed
+window holds its 256 MiB of memory::
+
+  qemu-system-x86_64 -M q35,cxl=on -m 4G -smp 4 \
+  ...
+  -object memory-backend-ram,id=t2mem0,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-type2,bus=root_port13,volatile-memdev=t2mem0,id=cxl-t2 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=256M
+
+The same device on an Arm virt machine::
+
+  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4G -smp 4 -cpu max \
+  ...
+  -object memory-backend-ram,id=t2mem0,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-type2,bus=root_port13,volatile-memdev=t2mem0,id=cxl-t2 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=256M
+
 A setup suitable for 4 way interleave. Only one fixed window provided, to enable 2 way
 interleave across 2 CXL host bridges.  Each host bridge has 2 CXL Root Ports, with
 the CXL Type3 device directly attached (no switches).::
-- 
2.53.0

