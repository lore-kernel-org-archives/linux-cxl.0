Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9931CDA2D
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919040; cv=fail; b=QzOMyBoQpyI274YE31gHdUX9IzocLeJ1piIGBlkzrnGjRhGmUKqgFKEf/K+aLCqnO0egluhp/bwd7pkrbHzgYJMD2sHY3CgX/xTTL75k2L43Ha7I5ZfMif8FzQ/2JUfuNAQwqcGoSAAcbapQUmABB+gCcDYDmsgakajR24oQEPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919040; c=relaxed/simple;
	bh=gyds3R53LCAqnLzTEJdYZ9MDqXvtDJ1TZQIvN94uvQg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aZCoCiDcNmBRu8GfE7zNHl0hM+P6zSmB7LSGylfQIKFtKlQQDou6Tui/cDYYfbeSGJeF+/TcM0t7SdkhLWHQexMKJ33WWnzOci0xwXPpL+SVZ0RqqkI7Mr6zQzqQlOPt+EzZNwImVLR/uxamzMdqEE2QSaYz3L8QmbA24ial7UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aXZi2Cxe; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aXZi2Cxe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orQ1ClgbtKoMNj+v2OdQSLiU1vQtAOyNTbklPeLbSaxBYLeiAq9G2PxCChEkaw7FZBRg2roFKISkLvHAno4lhtr5vcYIWAPnijHqU+iWPhG3uZhD6H5YUclyCBYIkvYkeK6tqpiIn4n0we6VnF4deWTQ0asxn33ums1ow/Ew7/7YERW+AaFodqSschfV7EzYiVOkYDslwxSZ3LKNsLQuv7bRP8RAZpi7trvUSkt47wqrEQ3HKZSYxD3embiMCAumLKMA+KrRrO7aAT4Freugvtr0cQEjrOWSANl1vr00HmPjqIZrJaEpp2zNFFR2kupyrYxinBbJNRxHC0FzKIBOyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMAGQ98/2W/PT0aCmtxPuoLJFiOf4YxCzNkcW/2FAmY=;
 b=NsH67Y6GUNBvRQtcmyxyWfe55gPyEKi0sv6M2XYDB/NTF4yS/i3IuXghYVrZJ96nXUDMqxO7r0taAnvSniYH46zHBsaxc+Odx6IltbUXc3X9xskbb9t5guCJoYnGQMmhTgCexo3tqd2S3lcleDVaRO0/yLzTqZxHW6cknFU6R9jObW2XrsLcBLqL+qrkQ5wVQBVpNfplIQHU0uFdOiABEY0hfkKbX462Pmj5aE0/c3IOkUWtVXL0MOKTarQrmUHa66V9WwKIok7iGK9CDr1mChyfb48gX0h60C/rRMkyalpgqXDH+RcxR5Y7oJM7QcNRXBDQysBFKlAyxGBqQ4MtMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMAGQ98/2W/PT0aCmtxPuoLJFiOf4YxCzNkcW/2FAmY=;
 b=aXZi2CxeJCg7Y3XSg7rZdX0/rCPSUzWGgK+G9x0LVym4mDGgBayCJjXLhMv5DCj9w0+rwngLUZgsIIlViPD2hgzrQ6PzoqEzvZOXrHRVlQVgM6ZsoCbcB5fbuMYRvRDqSxdbRcon35mKgr1uqi9iCSVPfdPdJFgU3GW3RezHJ94ttPTp1aFbjT6yiJMDRQv5GSsoKaqZ70qIFK8yiUQDo5SJEGv8E+TChtz6m/QYekbWNUfSSlwC/lXBAEHHpbRKx6ZK4YGN3kk6QZkhweou3oQBlFntvl2lM9ugIqhM8b+dbGdOkUQlglUVG8FSNeAL/rP3TlVTBlEKoyIi2TRTdQ==
Received: from SN7PR04CA0103.namprd04.prod.outlook.com (2603:10b6:806:122::18)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.28; Fri, 7 Feb
 2025 09:03:55 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::80) by SN7PR04CA0103.outlook.office365.com
 (2603:10b6:806:122::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 09:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 09:03:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Feb 2025
 01:03:37 -0800
Received: from 181d492-lcedt.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Feb 2025 01:03:37 -0800
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>
CC: Zhi Wang <zhiw@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v1 0/1] Add CXL Reset Support for CXL Devices
Date: Fri, 7 Feb 2025 01:03:26 -0800
Message-ID: <20250207090327.172478-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7cc1dd-a364-4b1f-0ac8-08dd4756596f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J2oW7TeZXijBO14N1P1Ew995iM0EXHt9Bj+3BTUbWZ34Ynm6fTVcCeCDit2J?=
 =?us-ascii?Q?pbCWRzk9oGvI+HQNEhg35+AymzgQJvtgRmXIq4/5vMV/nYJDp0gwjxoHflP+?=
 =?us-ascii?Q?PBuFJVcjTUprQ373C5Qqo6mq/3gWCsUP8QsqD7sc0VSvoJ7RL0xqnenyCx1r?=
 =?us-ascii?Q?e9JrvnYUVUQFmqry5tRk7ZscQTqGMPFuof5P/OXqQ2DmGxDkZVcwjs0WJ7qb?=
 =?us-ascii?Q?gug5UCvZpdRbf77Du4KfZg3sIpuBoEJj5WdoiOWNRlDPYMrhHmxLLN7OCkNt?=
 =?us-ascii?Q?Mxf1Bx2q0X+6SWfCEi5LiRiC8k6LNejhkWA9Iw+HbfYjlzdajW9NNfNx5qk7?=
 =?us-ascii?Q?Vm6xvsj/FzNsPqiTUZ+fq/cHRc41Hrctp3h8yU7hiAs3JaldxG9cJGPXqWpO?=
 =?us-ascii?Q?SdhX30h8dRoFQ6Stm6Rn0DVc5FoxHvEjCUEl2YwlRVO+5xAdrqt8HS7YIJ+d?=
 =?us-ascii?Q?J9owM+kiQV20VMCVaC9/eYASWy2t9YAcIEIRFtGTOMU7M4DvwlqnFZxu50QU?=
 =?us-ascii?Q?78i1/T7Puw+K6CNpFSUAUQCIWhONePlCpV31S86EgvyMDm2rCYIMaVm3ep6/?=
 =?us-ascii?Q?Mj27Bdg6TBgghtHqWJr2GqHqQl0afa5RtIxa66WwwrFNIel1QjEDVmrIM6IR?=
 =?us-ascii?Q?0Ub3W4LBm85o/97C7x6KGFqEqooIGTmyHZqHT774Q2IpDMsyfmXvtDJJHWpm?=
 =?us-ascii?Q?ZdovVax06LC8ye287Chvz3/+y68Cgob6zS1282FOrtgrR00qvLF+K+zAfdRP?=
 =?us-ascii?Q?O6Q0rLyZG6oh58SEu5e4BxWQWiUdMDNMOHT5V8X4EXNHy/RJYwOypK+NB1Pb?=
 =?us-ascii?Q?Ggd7nEnmTGvhy35DfU6tIv9AXsDcuvjW7ZBCJMogs4mSiGS0SHo88ptIS/OA?=
 =?us-ascii?Q?bOT4/q7KzA7ZrwSbdNF+ba1msoXciNrKjRA0XWkcidddQqvWv27L1pxRyac2?=
 =?us-ascii?Q?MXcppxDzI0zbmXGsU3QgT/llI/xyMjvpE9zCMvQkhMdhIakvffxA0Wq8t3v+?=
 =?us-ascii?Q?5agMhBKGD1T1jH2fHsNjCnsYd1GRa48Z68oSPZFEE+cL+TVM2qI94QraTvzs?=
 =?us-ascii?Q?86OB0rXzMWgaclMJ+9r6WCAbrTAZxiP1S+ffMaewxVoD6jfbNB4GrbbKC7Yj?=
 =?us-ascii?Q?ZiKtACtpKnpz6n6zQ3YaYwqDOfHRHH/16qV96f4MuAs8dpHarLp3pHNl7PTn?=
 =?us-ascii?Q?o0pNfShusJZmCq7a4SqcWSQh7utXSilKV6C+Z9pxZY12b3riHy2+aewhXvlK?=
 =?us-ascii?Q?lEuXAlG31MbUHZQNW6/88frP8VZB6zQebPQPB4pGSrVJCkdwCjNU37Dj6WKq?=
 =?us-ascii?Q?Z1YX5aeEzH0a87qUXhUDyCidRoT/B/FbDLJaveKgivTKaEmYHGSansgFj7dz?=
 =?us-ascii?Q?P9995pwPjJgHW4/Rw4iq8jKhXcSb4AH0RjUe0TMCCUDE+1bmU4p/8fFKiZCs?=
 =?us-ascii?Q?2m2pjfZJg2QPM3vgQeLOzVmpPfrn+lFP2nRW8Vex/jKIUbhvWw6LyiCw9IZb?=
 =?us-ascii?Q?CMW4Pct4cKAKKpg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 09:03:54.8281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7cc1dd-a364-4b1f-0ac8-08dd4756596f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608

This patch introduces support for the CXL Reset method
for CXL devices, implementing the reset procedure outlined in
CXL Spec [1] v3.1, Sections 9.6 and 9.7.

RFC -> v1:
- Added cover letter and dropped the RFC.

The RFC patche can be found here [2]

Motivation:
-----------
This change is broadly useful for reasons including but not limited to the
following:
- As support for Type 2 devices [3] is being introduced, more devices will
  require finer-grained reset mechanisms beyond bus-wide reset methods.
- FLR does not affect CXL.cache or CXL.mem protocols, making CXL Reset
  the preferred method in some cases.
- The CXL spec (Sections 7.2.3 Binding and Unbinding, 9.5 FLR) highlights use
  cases like function rebinding and error recovery, where CXL Reset is
  explicitly mentioned.

Change Description:
-------------------
The patch implements the required steps for CXL reset and introduces a new reset
method in the pci_reset_fn_methods. It also defines the necessary CXL DVSEC
register macros. The actual steps for rest are broadly: disable cache lines and
asserts WB+I, wait for cache and memory clear signals, initial reset, wait for
complete and return status.

Command line to test the CXL reset on a capable device:
    echo cxl_reset > /sys/bus/pci/devices/<pci_device>/reset_method
    echo 1 > /sys/bus/pci/devices/<pci_device>/reset

[1] https://computeexpresslink.org/wp-content/uploads/2024/02/CXL-3.1-Specification.pdf
[2] https://lore.kernel.org/all/20241213074143.374-1-smadhavan@nvidia.com/
[3] https://lore.kernel.org/linux-cxl/20241216161042.42108-1-alejandro.lucero-palau@amd.com/

Srirangan Madhavan (1):
  cxl: add support for cxl reset

 drivers/pci/pci.c             | 183 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h           |   2 +-
 include/uapi/linux/pci_regs.h |  25 +++++
 3 files changed, 209 insertions(+), 1 deletion(-)

-- 
2.25.1

