Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795023846;
	b=CM2OO47y4626QZjFfpqv9fEEyQQdfw7px2bSKGBHoioJma03K7p6HfwkJz7VSPyyo0ri
	 bra8O1rBE4ePDY3d0flUqbz6rjOWHc19Q+WnIt6G6J8HlmpqtN9xU20pwRuMUs5axKQIz
	 5kWm6r06l661YYBJg1pfXa8N5oUhOYpPhpxbjuXmz8jmKjimnO3lmUFoG4VVWcvBUAtW8
	 uPvsuNVviVOwBnYeDBsZEznrv7JAg1c7iscP3FWZPu2q4FSvliodInJMR7iUbHypsOUP5
	 ujH0o6l8CFfDcp1Zwmr+gwjfAqJfhJ1ko2HAOemCf7l7fFJvJ8N/GM8XKgBZQkOvdBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023846;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=Bb8M6jvnGOaZ0wkjMl/FVxsXE9kqCNNJZOGSXFU/Ew4=;
	b=asH8kKN7/PpYLa19/13TMWPQuA4CaLKXDsAUr+V1XspNVBGYNeJwWZDqLAwvSkSYcEPq
	 da827njvHMZSpxknxIRWZTjkV5JflTPvFaEYSlATX7BiHdTh0SvH2Vl22x+V+XP65Kwds
	 /+hBbEWo2x6tGa7TMmjFmVkggeJHiMYuOWBoCnG+oA2BlVFtYL6IVE4eDHT95rm2OyOE7
	 FvFqvAYi0AFTwcB/8b6A+fmHVivDmu1wx4F368lIcQgFjgeIKEhHugqJJi4oOQWgAG4HY
	 135gL4OGuWacrnofMXUY0u5R4vW5uzgjHKwzh9Ykxvumnv1Zh/vS5jQVT0R+dApIOfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zvms7zoJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.25
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A2606A31C
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 17:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C4A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zvms7zoJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xidPpGnWngFDaKVYn6VS40HCnrgjgn7DXMwBU85o04+0Y5BA8ue/i72DwmUEYHbpHNJBFZrQoOxSj/uJThBt38fnZaWVEHvjO5+l98f9on2OuSY3xl1dyr2UTgggWMVmuLh5UlBErG+LUvG1rpLqwROeM4u+SSfnNaExy4RuPeWp1KTOVpDaResAehSq2u5DkQbJbL28XEYVjlsDUTS4uYfI2Elg6LrnP9Jlp07sCmR1KQerU+wKerU81RVwrfLvflGidsfXGL7nuWuLTVs18qfyrTNGi3nXdW3VCB3F5Kg+znCVl793pSk24Nm1bLbse2iTRYoi8alOmmDqzZvUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb8M6jvnGOaZ0wkjMl/FVxsXE9kqCNNJZOGSXFU/Ew4=;
 b=AqOwUaGqYW1lAzkgRyIWZR1rwICsEgbTeozOU0XKx2c38p0AjxdOcdjaArhKNA5YYACqZxMj0HgDd7hYQCLG3Q5XrG0u/THSW4dmuMUEPurONExBwBl0CyOxWAsLmxnzNT53TPEDz8zeLqFZfa8drfpPvnuxstzQTjFVsYg2MG2LKRxRP2CU/Leu9Afjxf+RSP+xV04pABaLUJoTmlBdebnHkN8Ap1pSilT3mQUdQjby4XhxrM+pPy1GkNkW1aOAZP6oUpVadtGErWvuAWxnmZ36/XMg9pJ5dXlzi7zDTWWudr4paS9SNv2pRN9QJXCV4KWJk0TeKjQoPc7vXZpm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb8M6jvnGOaZ0wkjMl/FVxsXE9kqCNNJZOGSXFU/Ew4=;
 b=zvms7zoJDHKW97PgdtyeE/JSX8R39CnWFhN/f0dzTcag+yAl9o3mR4KPK6rb8C2TCWzYMPP3IrIJOAYLoO+7jqFsE5yvds5vyPnJaOAR4E0HiyCMZpPp7cn57FTJfsgnW61eC1Cw2oVBQt/LHHjkFf/iFVvfF4uSPgOq7eVDuNY=
Received: from CH2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:5a::12)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:43:44 +0000
Received: from BL6PEPF0006C3DE.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::2b) by CH2PR08CA0002.outlook.office365.com
 (2603:10b6:610:5a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Wed,
 18 Nov 2026 17:43:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DE.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 17:43:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 11:43:43 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 11:43:43 -0600
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 18 Nov 2026 11:43:42 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<jic23@kernel.org>, <alison.schofield@intel.com>, <vishal.l.verma@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 0/3] Type2 unwinding ordering change
Date: Wed, 18 Nov 2026 19:14:28 +0000
Message-ID: <20261118191431.21781-1-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DE:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f08cc9-11be-435a-a47e-08df459b7e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|261022075727099003|261102123227099003|261026121527099003|11063799006|5023799004|261028144727099003|56012099006|261026140227099003|261022105027099003|261021121427099003|261021123027099003|10067099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QMo82lXhkA272/CLPC52n7PBGuftmtMsV1cb9qmWU0Y5dWU8RPiYmrRxN6BZWAPadIrdwff5t/Uf569udMa4MAswXODOx4n2KUdS66R3r6Xzr3IsC2c1Nt/+o3FW3lDUsJwC3y4fs/oN4vkQOdoBiGq1F67UTQc/Va12xm+x1UCmdD627F5RogP6zXpgd/6Lj/G5fKHjbMntz5ZKt6BEdD+3TpuIzZtTQ10C2WyHl2lYBF0k0GdghTEWkR4csrlTezRH1GwubDgqW1dmDNfRbxQRd94cpLdf2n97usIPmNb1FlpP43WEBZq3Q0U7XxQ7fL4CANIjgSNwT2sYUrIFysDwVFerC9RP0K58iGwiBN5ktdXtKeVIy2Zsl0SRLg9DjQtnGxvgIBEbSvpi9F8Ubr4Yg6C8lNWzRj/EPWekNL+K5S9FC76IQwRYM/vABw+EVVPQXddk4eaR4u6FqmatVXfLxAXNKn6GIl+WHHDyH7XllHQ87x0O1U/ei155Om2U0qiYzKjeGXipgz8VfGu+yFfpT3grmZejbCTAZtVP4E8/pYb85kohv5i0W5qcfEKPpfnmrgNRkWgkWH7XpKps3lwkKZx55hpBWMW6lSJhaOrSrVBapTrhP3TQ9rCfFdShxYRtkZFdXAWhc+QKfX0RkIFE0ReOoaEYaEpVMrLgogHWIobgHtzSfcSFntaSAusqmw9gVbqeT+XVMxzjKjsgiw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(261022075727099003)(261102123227099003)(261026121527099003)(11063799006)(5023799004)(261028144727099003)(56012099006)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Jt/isYhsya5RmK63OrIE59XIoRI1yVBe/jptxw5hef7M/64B0sJ9/dt1EJKS7rkxz8yS/zY8xB6hLlZxWsuyQab8sM4eckMFG6XQLwlgUQjcEsI+ZgQWEqZA7QQNhIrCHDDTo2zYQi3apG0HTVqxlgmi41cTa+r/4UohTcxts2zbzzmqs3bA/xCpEU2ziy+tzc/nFwBC/TXzBqr3XDFs3gLYsBrS5tF8z1FWSlaA/K8bmuSoHaqBu4VXVJ20btaB+RGwkR2sMw4uSVloeiC/SfBz0Cxr8/xeldEfemHrhIbFeeh6nUsKwiBvNpyuJdwbW15O8Ry+mEK5D7mlfaYzQrC7FzuTa27vrTRRqf/MTsY41nmaBSmZIuFJ78aY4KpZeRinlThoZP1nsu7z3p1D/NLEQy8AD4pdeFsJigmtc92sXu2Ca3mtfg/Fl2s43on
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:43:44.5798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f08cc9-11be-435a-a47e-08df459b7e02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826

From: Alejandro Lucero <alucerop@amd.com>

This RFC requires more work mainly with the tracepoints and surely with
documentation which, I hope, will get better with help from reviewers.

Regarding the solution proposed for the described problem, I know there could
be other solutions, so I'll be happy if someone comes with a better one, but
my feeling is the current design based strongly on devm actions is adding
complexity which would be desirable to reduce somehow.


The summary
===========
Current Type2 support is safe but semantically wrong: a Type2 driver could not
be (temporarily) aware about the CXL region (the one creating the Host physical
range to work with) is not there anymore. It could because it depends on the
unwinding triggering point which changes the ordering of CXL objects unwinding.
It is safe because for current Type2 expectations the physical mapping will
remain: those HDM decoders building up the path and programmed by the BIOS will
not be reset.

While implementing multiPF support for Type2 I found this behaviour specially
annoying because potential concurrency problems due to this non deterministic
unwinding order of Type2 related objects. Adding to this the semantical problem
which will likely be a bigger problem when adhoc Type2 regions are supported, I
propose a change to how the current design works for the unwinding of objects
for a Type2 device.

I seize the necessity of explaining below the problem in detail for also
proposing to add to the CXL kernel documentation such (adjusted) explanation for
helping other to understand how the CXL subsystem works.


The long story
==============
Current CXL subsystem relies on the linux kernel device abstraction for
representing the different componentes building up the subsystem itself. The
core or root devices of the subsystem are created from data coming through ACPI
and are not discussed in this document, with the target being Type2 devices and
the binding/unbinding of those physical devices into the CXL subsystem.

Along with logical devices come CXL drivers which allow to perform this
binding/unbinding through usual kernel probe mechanisms. Moreover, current CXL
subsystem design relies on devres (managed resources) kernel functionality
linking actions to device unbinding from drivers helping with all the unwinding
required.

When a device is unbound the kernel will first invoke those devm actions linked
to the device and then, if there is no further references to the device kobject,
it will be released or freed. This implies actions linked to the unbinding
happen at the unbinding time but the final device release can happen at a later
time. Furthermore, those actions can lead to other related objects to be removed
as well as their existence depends on the current one being removed. For a Type2
device doing CXL initialization, these are the objects created with order from
left to right and with dependencies in the opposite direction:

  cxl_memdev --> endpoint (cxl_port) --> cxl_decoder --> cxl_region

A CXL region defines the Host physical range where the device memory (HDM) is
mapped and someone, a client, will likely be using it somehow. For a Type2 this
client is the Type2 "generic" driver, like a network driver using CXL for some
kind of acceleration. For a Type3 the client could be the kernel memory
management or some user space functionality using such a physical range through
a dax device, with the driver taking over the device being the CXL core mem
driver. Note this last driver is also used in Type2 for the cxl_memdev created,
as next paragraph does explain.

The above object chain is created when a new memdev device is added to the
kernel device core and such a device binding to the cxl_mem driver. This will
trigger port(s) creation, at least one, a cxl_port device which will bind to
the cxl_port driver when added to the kernel device core. For a decoder only a
device is created (or as many as decoders advertises the Type2 device) but no
binding as there is no decoder driver to bind to. Finally, the region device
will be automatically created during initialization for current Type2 devices
expectation (this is called autodiscovery but work for supporting adhoc region
creation is in the way) and it will bind to the cxl_region driver. Once there
exists a driver bound to a device, it can be unbound through the sysfs files
created by default by the kernel device core.


Unwinding expectation
=====================
One could think a Type2 driver creating all those objects should control the
unwinding of all of them, not necessarily because some driver action but maybe
because the kernel signals the driver about that necessity. However, with the
current design those objects can end up being unbound through different paths
and not always the Type2 driver receives the signal or not in time to safely
stop using the CXL pathway created:

 1) The pci device owning the Type2 CXL "device" unbinds from its driver.
 2) The type2 driver is removed triggering the pci device unbinding.
 3) The cxl memdev is unbound from the cxl mem driver through sysfs.
 4) The cxl endpoint port is unbound from the cxl port driver through systfs.
 5) The cxl_region is unbound from the cxl region driver through sysfs.
 8) Root port linked to the device is unbound frmo the cxl port through sysfs.
 9) cxl acpi kernel module is removed.


The first two cases go through the driver remove code path allowing a Type2
aware driver to stop using the CXL region memory range while all the CXL
objects are still there. Devm actions will start the CXL unwinding just after
that code path is executed with the cxl_memdev object being the first one
getting the unwinding signal, but the order here is not so relevant as there is
no client using the CXL region after the driver exit code path execution.

The next case makes ordering an issue. A cxl_memdev unbindng triggers several
demv release/clean actions:

        - cxl_detach_ep
                - endpoint_unregister_region
                - cxld_unregister
                - schedule_detach_memdev

As we can see, the chain-reaction leads to the endpoint unbinding, which in
turn leads to such endpoint unregistered from a region and that implying the
region unregistered itself and the related HDM decoder(s) "likely" being reset.
The related memdev is also scheduled for detachment. What about the Type2 driver
using the HPA linked to those objects?

Currently a Type2 driver is signalled to unbind when its memdev is going to be
removed. Following this previous chain, that happens when the memdev is going
to detach, but not when its detachment is scheduled. As stated earlier, that
implies the Type2 driver keeps using the mapping region after the objects
creating it have already disappeared. Linking a devm action between endpoint
and memdev is not so trivial and the locking issues arise quickly.

Using sysfs unbind for endpoint and region objects leads to the same problem.
Trying to change the devm chain could fix one case but easily destroying the
proper unwinding for the other ones leaving objects which should not be there
anymore.

This problem is solvable changing the way some devm action are used for Type2:

        1) Any object unbinding should make the memdev to be detached first,
           implying the Type2 driver will be removed as the first step in the
           unwinding chain.

        2) Make explicit the removal of endpoint and decoder from the memdev
           detachment.

This solution implies to remove some of current devm actions linking region and
endpoint port unbinding to cxl memdev detach without allowing other actions to
happen independently of such memdev unbinding. Then some of those actions to
be invoked at the right time within the general unwinding of the chain.

For helping other people to study and visualize the problem, some tracepoints
are added hopefully showing the current unwinding and the new one after the
full patchset is applied.

Another consequence coming with this change is the state of those objects linked
to a memdev owned by a Type2 driver can only disappear through a specific order
facilitating handling potential concurrency of related functionlities like
supporting multipf where other non-PF0 functions will link to a cxl_memdev which
can onbly disappear through a well-protected and deterministic path precluding
problems with potential concurrency.

Alejandro Lucero (3):
  cxl: add tracepoints to the unwinding code path
  cxl: make explicit removal of endpoint and decoder for Type2
  Documentation/cxl: add document about Type2 binding and unbinding

 .../cxl/type2/cxl_type2_objects_unwinding.rst | 102 ++++++++++++++++++
 drivers/cxl/core/memdev.c                     |  26 ++++-
 drivers/cxl/core/port.c                       |  39 ++++++-
 drivers/cxl/core/region.c                     |  42 +++++++-
 drivers/cxl/cxl.h                             |   3 +
 drivers/cxl/cxl_memdev_tracepoints.h          |  58 ++++++++++
 drivers/cxl/cxl_port_tracepoints.h            |  91 ++++++++++++++++
 drivers/cxl/cxl_region_tracepoints.h          |  78 ++++++++++++++
 drivers/cxl/cxlmem.h                          |  11 ++
 drivers/cxl/port.c                            |   5 -
 10 files changed, 443 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/type2/cxl_type2_objects_unwinding.rst
 create mode 100644 drivers/cxl/cxl_memdev_tracepoints.h
 create mode 100644 drivers/cxl/cxl_port_tracepoints.h
 create mode 100644 drivers/cxl/cxl_region_tracepoints.h


base-commit: 9d66f26fefacebfeed15de31c1123451a17ff119
-- 
2.34.1

