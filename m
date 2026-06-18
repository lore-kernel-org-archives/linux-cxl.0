Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021103.outbound.protection.outlook.com [40.107.208.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F8349CF0
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jun 2026 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.103
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802296; cv=fail; b=nzImrmfryGKUgGImmfsRYQHwvRewTZUOygjOtAGWzzMAnue30ugD+36YGzILgyWlTj2UFXjzMsQ+2jaRe/ZgdyywDrq0hiaJbfixaZ3wV0KYGtb0/9gQ59ax0J/RoMDHQOeyOL15oCVFO8oljjxARQvjZ4aTEjF83iK5VzEPpCk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802296; c=relaxed/simple;
	bh=No3XEvP05gMmtqZYwwJH1Vhs9OHttp3CRIYsL9Y3O2M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XawsZooyVW2CDoETIqDx1Wimk9F2XwElcih5oHIho6IV2AzkHbXSPkHbebMh/jB9wEAioVhbd38EndhuXl/I7sJ7FNSRoRohlnYE+HXyBvrvPB+dOgpZUi7ALukWaGL/oFeRsTrzTyRql8xulyO8vYMHF5dl8SOEqSpATGp1wrY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scaleflux.com; spf=pass smtp.mailfrom=scaleflux.com; dkim=pass (1024-bit key) header.d=scaleflux.com header.i=@scaleflux.com header.b=gVi2nmwH; dkim=pass (1024-bit key) header.d=scaleflux.com header.i=@scaleflux.com header.b=gVi2nmwH; arc=fail smtp.client-ip=40.107.208.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scaleflux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scaleflux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=scaleflux.com header.i=@scaleflux.com header.b="gVi2nmwH";
	dkim=pass (1024-bit key) header.d=scaleflux.com header.i=@scaleflux.com header.b="gVi2nmwH"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UoZjtkckeXsCWDKo3slYIcPSe9CSVlLuLdvgJOyZUV7Fnrwtgz7akaE+p0P4mXB6LHJdQNv4ELjx/9dczlP8IblO8/UrEYsvQiE2qxm3qfG3K3ciJdhCPMKduV0rr/eGf1ig+/TBtimH9cYIcW4Cb1jORdJQI/TK8hbgtScCx2p+SrhxwLvmA9G1fcLgEeWPfRp9CM+306bcL8cxkfG9kWP5Eh0sjB+WZYBGB73OZRKGOuSy7DMlgEfDARVFKaeNO/8oKGUpV9BZTYSRrbb7PmHWcktJXi8z3tF14uJK4k8e0KVqREA2XJzR8H5FDheZSVSv3SrkRJ9KZ69BY0tZ2w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEJSt70P9au9LzESJgjd2NAcFUAiiRZS5/HahY8N/Z8=;
 b=ioBIriSSnZOfF+vLXCNcOxJnoHonlMRrAFLFUMuYmp0lFt7DlXwpCYWsNKnQ84WmNRQ1pf2y6JZYHYET6BkZspbif+ts0aVlcABUwow9n9J+Drn0LjlILLxHikTElmYmFQs7uOJQS7IBJ1zJB6BeSaDwHA2G9O8ghwthLVe/5PsTrRGbFlLM6mU87TmEWLc9pAYT3cutzRoEAoCRbb23txDQlwis8KXkM9RaAy9u2nqtbsoPUpWE9rzq+IedKMmRiBecIglPMrY+uwxv+6eW3+yPyk6sjRtPugpqIy43Rf3bUsYG65WbEf0xT3iQdBRKP/UOrjOhQDjKo0fKtQrEuQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 51.8.25.87) smtp.rcpttodomain=intel.com smtp.mailfrom=scaleflux.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=scaleflux.com; dkim=pass (signature was verified)
 header.d=scaleflux.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=scaleflux.com] dkim=[1,1,header.d=scaleflux.com]
 dmarc=[1,1,header.from=scaleflux.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scaleflux.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEJSt70P9au9LzESJgjd2NAcFUAiiRZS5/HahY8N/Z8=;
 b=gVi2nmwHaQvXKZ0u0/0KSIzi0wEl+c1spjaZJwnrf7PDzuHfbO1mxDazxZQ/99Ee3hjWeWCpmoExdHwjpBb73df5Qip6puHmf1XVgR9WpVV1kHvBcWy1Q+BethxFZv2gQDb37TEuPH1YWUZ8M2aTgn+Lbx+ps+LbwmMHxJ63sKo=
Received: from CYXPR03CA0083.namprd03.prod.outlook.com (2603:10b6:930:d3::15)
 by DS7PR03MB5382.namprd03.prod.outlook.com (2603:10b6:5:2c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:51 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::66) by CYXPR03CA0083.outlook.office365.com
 (2603:10b6:930:d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 17:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 51.8.25.87)
 smtp.mailfrom=scaleflux.com; dkim=pass (signature was verified)
 header.d=scaleflux.com;dmarc=pass action=none header.from=scaleflux.com;
Received-SPF: Fail (protection.outlook.com: domain of scaleflux.com does not
 designate 51.8.25.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.8.25.87; helo=outbound-us1.az.dlp.m.darktrace.com;
Received: from outbound-us1.az.dlp.m.darktrace.com (51.8.25.87) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Thu, 18 Jun 2026 17:04:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOcWZ4S3URkNqN2N8W2zBDxe00BRbQg32hiIokf85JqoWSbCUx497NAXDwZNwDY8ZUOo3lngDb8uJ76bhdp7FIDxWrZxW/Pp9CmxMEivoyuowpYFNcNfoN3twMUhkCnnfCo+2b8BxxQiOmSrXB0aP1yJVN3gN3x/O+Hz1sIcgaFScmwzVWgnFIhRk+4fWYFb+O24XFMpS+IKrMOF59JDKesn580e6EwEGtHZyqcqVkEBiKBmBAPKlAnmRY7bT3CiJ+sCzZpssyB5QsJDWNlQa4M9Pp0HL9D+xErE5rKICL9nqXpJ/AszVje+8W3jwOPtindh742TGid8Nll+ityjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEJSt70P9au9LzESJgjd2NAcFUAiiRZS5/HahY8N/Z8=;
 b=YN8Q3Or5wVTsdbR4+qmX6lsyHwHFDKSdxh7SciVuzgw1QbjmUrnVRz5ESBExWeAyP0GNihp5LkQ2IUeyRj+nr1ZUP5KNuTYVIuHwzuSvdhVqUR9BgaPWekHbvhDAiSI5SL6peYcBE2N2mnWYrkziGtMI9Z90DKDy9yrI0IhXL/xQMEkqYYjBSbrAC2rtkLwxW8wsGe2x15yvHFn5lT5XBlNNr6pZuRBDb92vsYHfC//s0jwhzFiAb8m1KPDKfpbghcmmEC3wLRm7TA9oxp/21UqO5+LDB2IhtiLKr3N+L5/cr9phUYujCuUitBJGUO2sqW9U8m3epuhN/8A60NNY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=scaleflux.com; dmarc=pass action=none
 header.from=scaleflux.com; dkim=pass header.d=scaleflux.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scaleflux.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEJSt70P9au9LzESJgjd2NAcFUAiiRZS5/HahY8N/Z8=;
 b=gVi2nmwHaQvXKZ0u0/0KSIzi0wEl+c1spjaZJwnrf7PDzuHfbO1mxDazxZQ/99Ee3hjWeWCpmoExdHwjpBb73df5Qip6puHmf1XVgR9WpVV1kHvBcWy1Q+BethxFZv2gQDb37TEuPH1YWUZ8M2aTgn+Lbx+ps+LbwmMHxJ63sKo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=scaleflux.com;
Received: from MW4PR03MB6537.namprd03.prod.outlook.com (2603:10b6:303:124::13)
 by MN6PR03MB7766.namprd03.prod.outlook.com (2603:10b6:208:501::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 17:04:17 +0000
Received: from MW4PR03MB6537.namprd03.prod.outlook.com
 ([fe80::52db:7790:8726:4540]) by MW4PR03MB6537.namprd03.prod.outlook.com
 ([fe80::52db:7790:8726:4540%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 17:04:17 +0000
From: Wei Hou <wei.hou@scaleflux.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Wei Hou <wei.hou@scaleflux.com>
Subject: [PATCH] cxl/pci: Remove incorrect mbox.valid check in cxl_pci_type3_init_mailbox()
Date: Fri, 19 Jun 2026 01:03:56 +0800
Message-ID: <20260618170356.25382-1-wei.hou@scaleflux.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0041.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::19) To MW4PR03MB6537.namprd03.prod.outlook.com
 (2603:10b6:303:124::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	MW4PR03MB6537:EE_|MN6PR03MB7766:EE_|CY4PEPF0000E9DB:EE_|DS7PR03MB5382:EE_
X-MS-Office365-Filtering-Correlation-Id: d5643eab-55a6-4c32-f97d-08decd5bb5f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|42112799006|1800799024|376014|52116014|23010399003|38350700014|56012099006|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 o18vDPVvVCP7dK0hDpXdA0xHAEJZGXiQGxIrlGqIwLUhmOsjnZ+0Y3pwhLAjEMA2JKtk7kbGwjaQ2YAbY2Yg2jXMQuoHnq6FRLJ/paeth91vh+BEZNSLkgdZO/KORiqMWluimf4JOixLc7wmEziTk3jNOlsZnFOBrT/rDIjClAusn/BvmBtrAkFEaGyYSIrAKUsGP+Ug36hunV42dOsH4jBu99EI7D+cQ9oHVQ01RzbHvoQ3jSMe+ldrVxoLwSN7UJS6l2ClYTSHri68s/VTVw84kq22k77ZfubAFF5Xwks2TCXp9etzMSZK+SPiDmcRBW5NO6YVsJGMjLnB1OuZXfS1VfcNZGoSl7vZohQGBKLCMssXIoccRTJN6m2C5JI7dJ3dckT5D218+3v/2UfYPMyn7CceohsvlWVTf2K6XxXi2eUeeMJO+Ut8rYa96/xJTMFr+BHi6MCIr9SRIayRdcujUIPsu1eIOziE4gNM8RNDAdy7JECBZtwGMTLP15axfvFp+k5PFjhNPx0Me4+ixRdek18Qm2DGgUH7WQ1rPLFoBtNoVe1VWmqDt6CV2ZSvRUTazwK1rWvlThl3MXEROh6FL/S5ZKLbhR7WXOclh+whA85sPw0O2ww2kBFzA8afzE8JuXqxQ0aIne9mMuLadZNC5xWKebXjdx1hGFq7IwKUU5IR+IyItibkWqKlB7jfJQHohL1wiwUNENfnbj1Aqvj6dO6mwuz3zCQJO+aI1iL+tTOoUwplnNo+VOrh0GGl
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6537.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(1800799024)(376014)(52116014)(23010399003)(38350700014)(56012099006)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 NlASHKVcQpJST4ygNrOdDWIsc3UIb9blNpWmAVbOP13aNfobo3vupnEAVXmT6s/Hmmxwka/e14sbC4fKGqQ4T+3vS3AIHYDQXHEpLBB9SJRuc0rc64AMceq/sPFpG6jlMpGGtTqpzeJWqNaryOnRDpfB74VSgcXkmK+amB2Z+RUI0NL7IvU9y54MFAWI/htOlC3ovmp6gUmdRm14VgpeM+yEQ7vKmuDIWdDbMh2dRhwopmCkY6aRLE6ZtGs+ryBQOS6ITYLvdpefwBuH2qfniCwbWuAH+XKeUdP9Qw0B6Ge5TMBbdJ7J6nfKHbMYdTNkmM6n3Q1bOxfQAVvWNEgjzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7766
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4a1e6832-170a-4b8d-b410-08decd5ba169
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|35042699022|23010399003|14060799003|376014|42112799006|82310400026|1800799024|56012099006|3023799007|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/uEt6x4G338/WacwnDAJNjF1yRQsbKkYfiYtobjVNkyptHUqgNyeKD1jZmr+PU7s8myISwHSmdZssnHXSh/Ib/hvfgpq0E43L/t7MCEObqRQATkwn/cvgljFDrYt/WAB1qqaGB1v8q2ULXVB1jCyqO4i0R6eknxPEsVyedHeakbqQ76XTm8owZjnWCb28vaxC6C6xkzHOTq7tdeYQOXhnLOnHzuZMssruiVkXYSIYUv2sabpoQmYndV5ZFqmOGmy4vwwfg5aWhX7Xsh4MSzY/JjUjevZLOoezzWcfF5xcYKI824OWx4zdemJcT7audOBE3Gja/ONBjhJqpU5rdUPdP5mO5SHUXUcHW8Qm7sWD26nyn4gm5RYsoxTo5dN9BmT6NlK43WRS/owDxTb7JGBs46y/tLNbl90UrCM2urTRZyVFiqhsX+d+TSFMZQk0XPuney7bHiSwaW5X17yfBcp4yeuH9cRhYCh9XQxCEcOZ4XoxKtO87JjeVyBtd+AHi1huycTR3qOrvDJTCL82H4mxme7c/a2nymRTiz8WTTas753b1Ykx44Q2vqH4ri0w52ilEo32/xR8x4QORSvVDm2QqT4fbs9M9b7RzrjYCAtIVQ1BbdOO/nBtHeJrQZV7q5FbNZEk/KIkTDPzrk1hK74foVlcMCyHB2uxwsr9T8AIF+C/ESCTKIZpcevZlabApXOSp6/Owv/QxBse+x2XJw0kATB664UVNWjPVdmI8tJp7s=
X-Forefront-Antispam-Report:
	CIP:51.8.25.87;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-us1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(35042699022)(23010399003)(14060799003)(376014)(42112799006)(82310400026)(1800799024)(56012099006)(3023799007)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fCgkFSmNHIw+XUG6SMVHg6bMmazLHlySIsiZPfeHtp4Fg9xbTKwzcZyE83qDsBm1j+tLh4ZRIxrdCdSQH71u79hfozUYOrpQo5TX0HRn2ZFrI+57exgHReEdkH/qhWMyCFrel3udpPEggI/ox62kGapDvTC5ZvtR+JfIN+JjButiMrMY7FldgxyW5aOLJqMDwpmMfgcJLunJyKgpNpwTOHGALVsQXSXvURKAs2N3FsN/UJMHivCCxK9gfTw2v0vNkWBy9D+wBJC9jf5TJaTD6yhW9Gi8bULcGg/rU227uiEPQZlTryX9jZ/SoDNn/KoooQtpwFzhcon6zKSww9E8M1Gg4v5erj/tH57wefLX5XiShWU1CBxovklF2WvwKJaigiRvi0z3B9npgKdIYVmRTYtkEfJ/1fp64zK64WNjjr6EVaMLum7shhdrOX0wFmFJ
X-OriginatorOrg: scaleflux.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:04:50.8401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5643eab-55a6-4c32-f97d-08decd5bb5f1
X-MS-Exchange-CrossTenant-Id: 97919b17-0f1d-40f3-bb57-8fc93387f861
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=97919b17-0f1d-40f3-bb57-8fc93387f861;Ip=[51.8.25.87];Helo=[outbound-us1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5382

The driver's design intent is that missing or malformed component
registers should not prevent mailbox initialization. cxl_pci_probe()
already reflects this: the CXL_REGLOC_RBI_COMPONENT setup path only
emits a dev_warn() and continues when component registers are absent,
rather than returning an error.

The check 'if (!cxlds->reg_map.device_map.mbox.valid)' violates this
intent and is also technically incorrect for two reasons:

1. Wrong struct: the MEMDEV register block is enumerated into a local
   variable 'map', not into 'cxlds->reg_map'. The device_map.mbox.valid
   field inside cxlds->reg_map is never written by the MEMDEV probe and
   will always read as zero regardless of actual hardware capability.

2. Already validated: cxl_pci_setup_regs(CXL_REGLOC_RBI_MEMDEV) calls
   cxl_probe_regs() which explicitly checks mbox.valid and returns
   -ENXIO if the mailbox is absent. If that check passes, the mailbox is
   guaranteed to be present by the time cxl_pci_type3_init_mailbox() is
   called.

The value that the check actually reads is component_map.ras.valid,
which aliases device_map.mbox.valid in the union. This is populated by
the COMPONENT probe, not the MEMDEV probe. On devices where the
component register BAR does not implement a CXL Component Capability
Array (e.g. certain DCD devices), cxl_probe_component_regs() returns
early leaving ras.valid=false. Through the union, this makes mbox.valid
read as false, causing cxl_pci_type3_init_mailbox() to return -ENODEV
(-19) even though the mailbox hardware is fully functional.

Remove the check. Mailbox presence has already been validated by
cxl_pci_setup_regs(CXL_REGLOC_RBI_MEMDEV). The presence or absence of
component registers is irrelevant to mailbox initialization.

Signed-off-by: Wei Hou <wei.hou@scaleflux.com>
---
 drivers/cxl/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bace662dc988..e44e5d209900 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -691,12 +691,6 @@ static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
 {
 	int rc;
 
-	/*
-	 * Fail the init if there's no mailbox. For a type3 this is out of spec.
-	 */
-	if (!cxlds->reg_map.device_map.mbox.valid)
-		return -ENODEV;
-
 	rc = cxl_mailbox_init(&cxlds->cxl_mbox, cxlds->dev);
 	if (rc)
 		return rc;
-- 
2.24.1

