Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023834;
	b=2FIVQfgjs+j/wkwgrhi3aMTvAR1ZC1HkjTwOuwtV2CBwlPriQvO6b/JzOhCbwUKLWETp
	 a+Rfig49pxeo05iqYJykTGsOg2WzgI9YKrSzqaf05CCynNX00XCk3p4KrPdpQRm8Gm8Ux
	 HI5UsP+SmXCUx/C73Y7DHa62nabEUOX7N7wjqaC+z28a4QRGCDzxMnXdbe1SQegRIj0fx
	 anUUvvwmVEkkeqFAH9KRTfYXoobGc+WJQ/dXrMMxA9lugTRcd3mo9ut25qgQ7GhKrPcbq
	 xjq4XA/DYAMQ7+0fP4Bd2IPF6nyeNB6DxaZU7WKQCcw3EwDk1cq+l2GiInrn/62ho1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023834;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=g5ujEU+6yi71hc5AR4/yJ+6B65hTZgT0mBF0k4VTV/8=;
	b=T/cFWxP/E2RXcswm6z8qL4Z9xRKaQQGoYVKn9/0OJfprV9qYE+dvWiaM785FkLY/EV8W
	 VSxrFd86uWCLwYvJQnpZFyYngL+vAKnwzBORmdoLJaAys7xOBOijnxCFoYDlXYtxPHtRG
	 6zd4X6PqpCdhlnH4avw8k6vQisDHIC3bx9z5NKy37S6YyG9f8dDR3/HFr4WOVOAVA/CrQ
	 BwOu6n3aFGlekYKHbCXhSsMCKEhetA51u378dCRMHvFMG/b3vywDhYuIkWzzDo5ENpFua
	 lyjq2B3y4QCi/5PkZyZWf2pgH1vP38D86UunTKtYliKnxWdTLSq7XmzBzMleQw1VP6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=22hh3TFB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.58
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F01606A32A
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 17:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93F01606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=22hh3TFB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gpza42Ct4sNi2s1m8b6SgctLWQUTo4nU7oIQKJj5y181EHLKxsg3DrfoevnfVZ7KcN5xMb5+qn7wD3F1Yoto1IDfwBzZk/yPJVDOcI+O+358AQCI5L0j/7TeeV5hRuj+zNLDwvp3beC5JrD/sZAMol1ABaW/DLSshCO+HqAZn8okhoBsDlOfLN+pRs/o/XLW0KivsVaEAOULTFUa3pRGgTpNvX71KkbkFwbRpdvmJGX7RHsSD+zhaI8egtjrBT/dyPc6HCHodjwph/lHQ8vpFiKtsd8COH7TS+i7xXzZNX6+gjeBbXlYxp9FbKxQrfmUHavz7pfy37bdgk0Uze7B9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5ujEU+6yi71hc5AR4/yJ+6B65hTZgT0mBF0k4VTV/8=;
 b=lFdv333EXvhn+ORH99agfmdckueTgRMsR3wpVVvCjmbSQwrMZjyIXchWKfHc1/rnBnKKNLVUeGShifAmrfJJp5tXDhSS5x6TildMoOwtTuTJbDG3W/5uQ+4nhj8z21ZGB73AP39EFRbTBmfVWEA9YeluI87S7Gl+trezQMxkxaOm3aim1QfFYbJVkeAWZiIx1ketstMpRZbx5Qr9fwrhVrzyGUWdPgRfK4RafPD7xM1zcIZXVkMn1C9SuMtsNa+gEFvFSIx590H67/QRbXQBdJAc0DyeEfGaHxS3aJMbaSxont5NwVNq5ZHWdKvzpaTcnnjAyWKXkefCmSVTPxjVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5ujEU+6yi71hc5AR4/yJ+6B65hTZgT0mBF0k4VTV/8=;
 b=22hh3TFBRLd5l0y15ZIIpPtaH+7h8jnWyrqSpVE9S9dTx4Bt2VX0pRyti8OJn4rx07VkyEwDWRtrPHKRRJm4LTk0NDV0IHRpROrpFrFll+RQt6R8lOOLQ2l8/+s7RL3tYAWgqcbn6q7YXykco9DuKKNJvojb0j6pfdhnBq/eXbk=
Received: from SJ0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:33a::9)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:43:50 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::ac) by SJ0PR03CA0004.outlook.office365.com
 (2603:10b6:a03:33a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 18
 Nov 2026 17:43:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 17:43:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 11:43:47 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 11:43:46 -0600
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 18 Nov 2026 11:43:46 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 3/3] Documentation/cxl: add document about Type2 binding and unbinding
Date: Wed, 18 Nov 2026 19:14:31 +0000
Message-ID: <20261118191431.21781-4-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118191431.21781-1-alucerop@amd.com>
References: <20261118191431.21781-1-alucerop@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e32f69-8686-400c-e6fb-08df459b8101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|5023799004|261026121527099003|261022105027099003|56012099006|11063799006|261102123227099003|10067099003|261021121427099003|261021123027099003|261022075727099003|261026140227099003|261009223027099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4tb+KzTg4qrZNqq5cw7nTRcg7r15S6GNJDjMhiBPc1ldDaBFLyqzVmdnazxVXZR7af9ufSEiFTTpUGYoU4uX6oI9V6PtxCdc8UyDoWoSf2ymH0G6V0BrOT/ZVsL3als6aje7AwLuVJ35mZuhvM7WxOSWdkRTMCQX4o6ZF+XcOkPKFae8bOsEn8NyNFDVjbXYpKOlbos1LGm3GQMPac84XZoYl1Zg1epeY0J1UKzKE2Hncuf0eCnFyan9fug5k89pY+YhzmNBTensZ6N0+kd6Pc4rmqrG9d4Rme26ufbUKb2YumpzmJJaFZ5IALrCvQ29TB/60VIc460Hol/Yp3gDXPuxXzsJKVecfiJfrDibEdUtOT73rxE1p0htp/BVasLFQ54h+yuC/mV7zPgND+JuJEFVO1kw/9FJBR2Pj6lzbljFxuWONdqT0CMM4O4xnX3nBNvcP7Cff0WGE0+PkBLuAE+MKm7LpnDmeG+39+BPpP66YdjNbxuumAL+2On0gjPog3xlMXs197P0upDPrGhADKa8M4MYApeGwutW0uI31/JNe1ZM2Vm2Jb11wVqRq/4TKbGm+KWhOSkdtcwt/IaF1VxtR63rYzTkKjb1a5sURn+y32fVINohAb/kCbJsBgxIGkYAwrI0dWFOHmDbbysPVTrlr62dpFBnBlj/LOkLt6irBMRBSVwB/1rrVhBXJUcSqnU3UVhlpJHnT8iwElV3yg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(5023799004)(261026121527099003)(261022105027099003)(56012099006)(11063799006)(261102123227099003)(10067099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/+8uAkXsQQt/WgyPYkSdJotLQnCCOmDEzHZQemVrljRpByy0ZDftkjec0FotLcpKlUNGoKuuHklbvhK6hCXrWNJ+uOLSg56eFegdJRRVE6oNomEj2Rw6b+oC211RWrvNMrXlMnIwDMNalXN7762SlD8ppNl9Jgy5MhcNN3QEFf7wb3j1RW532eYIG7htoIzuiLSeoBx2Y/nw/nobNkQoZEbeWxtVTlUux5XtpVJoLZGsvrbqtk9iMEojpOAHmddbPSVEeWExotTuxpM4JsvlBbsZxX6wq9AAdisUQ2Se1mU3bgkY18deLSq8ItFvfpreyttIVOq6f+wRb3eWT741Ker/IHdTB22XIrFlw5+ZqrTxB/0obSieFgiUczHEMI/65ABvOoE4dHtCNxzlUMuIPFizw8JMAwtaNYgxRTtOJWSmTXaOBTIJvYzlM/I0KJDw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:43:49.5215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e32f69-8686-400c-e6fb-08df459b8101
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771

From: Alejandro Lucero <alucerop@amd.com>

CXL subsystem relies on kernel device model and dev managed
infrastructure for helping with device unwinding. This is not trivial
as different objects are created for each CXL Type2 or Type3 device and
with Type2 relying on an external driver to the CXL core.

Explain here:

 1) the device chain creation when a Type2 device binds to its driver and
    Type2 CXL API is used for CXL initialization.

 2) the device chain unwinding and the potential starting points for it.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 .../cxl/type2/cxl_type2_objects_unwinding.rst | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/type2/cxl_type2_objects_unwinding.rst

diff --git a/Documentation/driver-api/cxl/type2/cxl_type2_objects_unwinding.rst b/Documentation/driver-api/cxl/type2/cxl_type2_objects_unwinding.rst
new file mode 100644
index 000000000000..873f95d9c202
--- /dev/null
+++ b/Documentation/driver-api/cxl/type2/cxl_type2_objects_unwinding.rst
@@ -0,0 +1,102 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Compute Express Link: Type2 unwinding
+=====================================
+
+The CXL subsystem relies on the linux kernel device abstraction for representing
+the different componentes building up the subsystem itself. The core or root
+devices of the subsystem are created from data coming through ACPI and are not
+discussed in this document, with the target being Type2 devices and the binding
+and unbinding of those physical devices into the CXL subsystem.
+
+Along with logical devices come CXL drivers which allow to perform this binding
+and unbinding through usual kernel probe mechanisms. Moreover, current CXL
+subsystem design relies on devres (managed resources) kernel functionality
+linking actions to device unbinding from drivers helping with all the unwinding
+required.
+
+When a device is unbound the kernel will first invoke those devm actions linked
+to the device and then, if there is no further references to the device kobject,
+it will be released or freed. This implies actions linked to the unbinding
+happen at the unbinding time but the final device release can happen at a later
+time. Furthermore, those actions can lead to other related objects to be removed
+as well as their existence depends on the current one being removed. For a Type2
+device doing CXL initialization, these are the objects created with order from
+left to right and with dependencies in the opposite direction:
+
+
+  cxl_memdev --> endpoint (cxl_port) --> cxl_decoder --> cxl_region
+
+
+A CXL region defines the Host physical range where the device memory (HDM) is
+mapped and someone, a client, will likely be using it somehow. For a Type2 this
+client is the Type2 "generic" driver, like a network driver using CXL for some
+kind of acceleration. For a Type3 the client could be the kernel memory
+management or some user space functionality using such a physical range through
+a dax device, with the driver taking over the device being the CXL core mem
+driver. Note this last driver is also used in Type2 for the cxl_memdev created,
+as next paragraph does explain.
+
+The above object chain is created when a new memdev device is added to the
+kernel device core and such a device binding to the cxl_mem driver. This will
+trigger port(s) creation, at least one, a cxl_port device which will bind to
+the cxl_port driver when added to the kernel device core. For a decoder only a
+device is created (or as many as decoders advertises the Type2 device) but no
+binding as there is no decoder driver to bind to. Finally, the region device
+will be automatically created during initialization for current Type2 devices
+expectation (this is called autodiscovery and relies on the system BIOS doing
+the proper physical HDM decoders programming, but work for supporting adhoc
+region creation is in the way) and it will bind to the cxl_region driver. Once
+there exists a driver bound to a device, it can be unbound through the sysfs
+files created by default by the kernel device core.
+
+
+Unwinding expectation
+=====================
+
+One could think a Type2 driver creating all those objects should control the
+unwinding of all of them, not necessarily because some driver action but maybe
+because the kernel signals the driver about that necessity. However, with the
+current design those objects can end up being unbound through different paths:
+
+ 1) The pci device owning the Type2 CXL "device" unbinds from its driver.
+ 2) The type2 driver is removed triggering the pci device unbinding.
+ 3) The cxl memdev is unbound from the cxl mem driver through sysfs.
+ 4) The cxl endpoint port is unbound from the cxl port driver through systfs.
+ 5) The cxl_region is unbound from the cxl region driver through sysfs.
+ 8) Root port linked to the device is unbound frmo the cxl port through sysfs.
+ 9) cxl acpi kernel module is removed.
+
+The first two cases go through the driver remove code path allowing a Type2
+aware driver to stop using the CXL region memory range while all the CXL
+objects are still there. Devm actions will start the CXL unwinding just after
+that code path is executed with the cxl_memdev object being the first one
+getting the unwinding signal, but the order here is not relevant as there is
+no client using the CXL region after the driver exit code path execution.
+
+The next cases rely on devm actions linked to those logical CXL devices created
+and depending on each of them, the order changes ... for a Type3 device. A Type2
+needs the first step in any unwinding chain to be the Type2 driver stopping
+the consumption of the HPA, so devm action are different for obtaining just
+this deterministic order in any case. This implies the code linked to some
+devm actions are explicitly invoked by the unwinding code at the right point.
+In other words, the unwinding relies on both, devm and explicit calls.
+
+
+Visualizing the different unwinding cases
+=========================================
+
+For helping with the debugging and/or understanding of current Type2, or even
+Type3 devices, unwinding some tracepoints are available for enabling them all:
+
+
+   # echo 1 > /sys/kernel/debug/tracing/events/cxl_unwinding/enable
+
+or individually as for example:
+
+   # echo 1 > /sys/kernel/debug/tracing/events/cxl_unwinding/cxl_memdev_release/enable
+
+	or
+
+   # echo "cxl_unwinding:cxl_memdev_release" > /sys/kernel/debug/tracing/set_event
-- 
2.34.1

