Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF06024466C;
	Wed, 15 Oct 2025 02:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496090; cv=fail; b=c/JGX6cwaWvtNksjYRgpACEwrTmqlTU3jnOLQMqEhnuYiB8wVPWH3kqNGqymHsDYJ89bmsWhyPRaaVm/yJO/Gacg2JszzH1NRsRbUWkYrKhEIbx/jfsz4FGyDMgehCc4bAI/3vsmuzMU5tqXlt+102h8RFaQonmHX+WQYKBF2ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496090; c=relaxed/simple;
	bh=0k2qWE8pyL2eQ4tEpE68tUF2KYUDURJRNw1uaWPD/Uo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gS7o0yqmaUMhCJJgFFSMa2kC4zRjcZLSF5idjYkUhKS/x7KFO39wYBfiXBn71R8lgSIeOieUETLtwwHu2iqm/bLby27OauGou/zZD4U2QYAXQAWD2Ws/UAJhpD17gIUJn5RVbhxNsGIcbjsvGOPASFDsCPtRqshgv96hx8WUYPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AS+W+5/9; arc=fail smtp.client-ip=52.101.53.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AS+W+5/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qe6OHcJjHwxN4GZzkwq+7S1ec7VVaccSxALXzRZqOdOJ8N77ZT8rfwxJtLAG0t3EAnN+9UCXdZxSPkVIuYbmz4s8H651vC382qyDGToldhGNwl/dMbjyyRAHVZnR4eyD6sM73xYMVGFLJip1OjT5U+d13IXpFBxSnWmLrsHVIfI0AWt4jHCM21Ytq5GUJJtCIGkvK9NqqNrtamBvU+jjg3hChWx9Sjcgnb8xY6t9D8r3TS8O97QSZnIvpgtm66nnOu6+NRV5V2+YzgIEoaWqdgElmA3Q+I0dFD4eUgqnEToDrUoP/O732+R78zR5pbwFWwROs8lpJ7JtfVJf68JI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+acRXVFOSBbti/F8bE/LTYjrmexsVNPVvz6wMu6Eco=;
 b=H+9PKT6tvHuLYB1au1mARuDk/PkLtuVmwpAaZsV6JF9JesXIyjEPymxBGiPqX0cYbnXYr2c6pksdd8zlTAmG5+HX3UxlT/wrW/43LYkYrVJZm6Ys59MQDtdlw/IJJ7Psh8MzD1iu9kL5kJMT3H8kg25xUkWNcVKJMNbIYeEZlsQbjkBGBtIHOjx3hNclps92HBuLyTpXj4FwF9rnzE02ULvL1Uq3CxLIElwN/MM4RysLlWkf6C1XDG0LKiJ9JpuwbWF5JKvWi+s6ymfyPyB6fHvz3Az//1dOdEu0jVZxu6WwMD1jb1LU6NCO7QRe3TX/JIH9+v5YzT5XIcAkiZjy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+acRXVFOSBbti/F8bE/LTYjrmexsVNPVvz6wMu6Eco=;
 b=AS+W+5/9zmTYMeCfAfHEHDFeeV6oQO+hi/+ECQp/x4f9mC4oxxqOBdH2GmpeNnC+Ok/BTUBJbwZ4hExWMd4IlgNS6pgJN3/dU9OR1QV9F1PCl4xl6GE0wcqM6HISzt9TsvPZB1cd/3Ow8jl8MSCLwKkzjEDwMrKiB+puQzzuk6ryzfiVGFH/D9X7NosLq7/Dfg3cNl7ssf8jKeRu0+3g6k0BcnCAtNIiAHrJ/MCaM8pVRJYSpXeAjW6pKeqaMn17O+8NOu7kQ6OxNM04qeke9Hh/Ga2qPgJWyrTlXal96BGEbVQP2swVSwc3CexnG9Ve3bn5A/egreo9Q2mhHEc4Mg==
Received: from BN8PR04CA0044.namprd04.prod.outlook.com (2603:10b6:408:d4::18)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 02:41:23 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::c0) by BN8PR04CA0044.outlook.office365.com
 (2603:10b6:408:d4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 02:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:41:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 14 Oct
 2025 19:41:09 -0700
Received: from vaslot-linux-dev.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Oct 2025 19:41:08 -0700
From: Vishal Aslot <vaslot@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, Vishal Aslot
	<vaslot@nvidia.com>, "open list:COMPUTE EXPRESS LINK (CXL)"
	<linux-cxl@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] Support zero-sized decoders
Date: Tue, 14 Oct 2025 19:40:04 -0700
Message-ID: <20251015024019.1189713-1-vaslot@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: d65ee9a4-1a24-4290-8101-08de0b94541d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/HpxzyoA9x0mNc7i+W5EUIhyQqtApzu4ZDhZ2OoECqIwGkQ6isMTqMj7puE/?=
 =?us-ascii?Q?olOMdEtdYtp4PXdBVrp86WcrimYAxD+JDg/U2PAQTwqZHBLA4uGhvmHJ9yr6?=
 =?us-ascii?Q?yRDBFtz7NrNIQRIDdmnRT5buXFAmE3S3qdsVr/+Abt4oaiLI6vB+LsyDcKwN?=
 =?us-ascii?Q?CZE4h59aT62+V1ZIbkKigKtB9PY7TZR+EYoFcYS9wgxs1e/TpPH/TdPXpMmo?=
 =?us-ascii?Q?h8SzRiRupF5SMEf52U0u5ILJlaxr6bfJqkqL/JTS/zViW9R+qUCMiEtChFd/?=
 =?us-ascii?Q?JguOjgNkEzdl4Z4fsPTLuU5mT60ZRdDGi3nvP7+PDvx3UoZWZuekm0ih/N4S?=
 =?us-ascii?Q?hVgRu5wLmH1jAYCqdICw5trmn8pqpN1vTVJ1dJr8+U+zIRy49avoMH3lLZGr?=
 =?us-ascii?Q?7FGv+Z/w5uN+PUbhyltlYxTFqJKgYFvmAYKp6ex88EVTdvKYMhtQ2dbQWwng?=
 =?us-ascii?Q?matQ5ZI5z/xdEGXwIK01PX8ifAmzYcmwyfrWVPEULf8eC2t9WwC7rOMmHeWP?=
 =?us-ascii?Q?eh7APQsdNkjLcEuffzKlfA270hyAwDzSNL2ShdjumPkGfjg8OqUr/GSCpZK/?=
 =?us-ascii?Q?CyPBppRGT86EoaC/WK2m+u52bfMZ1GLAmfFDZgE4wSLCikokAP4Zh6WPoheH?=
 =?us-ascii?Q?RcT1hTn4GtGs667fquChW/eF4jEG4lwUMI53GsG/XMMoKmk87g5fzanzN3BP?=
 =?us-ascii?Q?EPsK6JajNnFVjuWuLsyjK+ieEZZAY18DqqV57oeeGIYrW6mOundTI2tHTwYZ?=
 =?us-ascii?Q?o1vsNfya5nJ1sCM8tgh8qfDJmg60Sh3dlQM9v6ElGgcZrtoFgD6KA6AwHaZt?=
 =?us-ascii?Q?ZvbiCsQYhqzUtmO8NxcfGSngjcqCav6r5FGV1xismyvBpAoUVVqUxXvaclb0?=
 =?us-ascii?Q?driC8yTrDYt33/jZSyxvyIJdIx7Ee5zPdN2SqYaAeGjrl5144KydRoEmOLrl?=
 =?us-ascii?Q?C3ZWlLFqs9wzdgeThkF2mdWfcRCrVT1lsWkF12JqZtaXMOZrML0frNky5mDJ?=
 =?us-ascii?Q?uDkBq8tamdHSa3vcFK5MpNuBNEb1f1ruifLBPyUtJ01YBK4wX3l2Yu6WyNyA?=
 =?us-ascii?Q?UKeXfceMQqZ6j97zVR0TaoxSsJL8aUevuIpw/KXkTr7OMFQgvUUIwbh8FFGD?=
 =?us-ascii?Q?+tmgz6Ag5zkb6ighdnS5kOq5CGdoddpBcqK49vJKwUnW+HxAgTfajMyIvg/8?=
 =?us-ascii?Q?52oGmNDud3VUVwykREzbHgnVcfWo2bDkhO5YBVx4roR68kb6iOAMywGAMwPs?=
 =?us-ascii?Q?hqfrUNhJoF6ph4IF9CywLpIeVsMRl/sCa3X/uqGmtMwE7cS9FiNumjI0LGrb?=
 =?us-ascii?Q?oppkbLsZik9++CA7mCroY1NiJHli3NZ2uMURy5FZda2yI4cdDXPJ+1W4Ae8t?=
 =?us-ascii?Q?oiFdlWLGwniPN0o2RI2dTMWM9kTUW6wL7yfQpAXPLNXInPhrdmkKmAqvJXYl?=
 =?us-ascii?Q?9zt7yq4daDcl00tG+5OyZ+x2V/uawlPg/5m+4J2EujajeaGjTmw3mfqLY/Tm?=
 =?us-ascii?Q?vpxjYWG+OvzloMyqlmmXKXH3OMcQja35EpvUCkPfQDCN6yuuwt4RlhCa4EKd?=
 =?us-ascii?Q?YTLiq5HJTapP30+Qc/rgd54eyeBV2gCi+Ft06CLD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:41:22.5605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65ee9a4-1a24-4290-8101-08de0b94541d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

This patchset adds support for committed decoders
of size 0. It also extends cxl_test with zero-sized
decoders.

Vishal Aslot (2):
  [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
  [PATCH v1 2/2] cxl: Allow zero sized HDM decoders

 drivers/cxl/core/hdm.c       |  9 ++--
 tools/testing/cxl/test/cxl.c | 96 +++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 5 deletions(-)

-- 
2.43.0

