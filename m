Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D626918A937
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 05:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054812; cv=fail; b=OGASE7V8Ziq0Alv8IU5x8GLbCG6uSi8m5YxaJs97NWsYV5pKPBY6JzMHfwfERnSAE8oJOpzma+LJOPeRUhZErhRLAiFhMyXiJDihebtsWmg5mm6S6MXtc0uDJIFM8Lvs1Whjc8dJkjAUKWSxJjmo+5sl8M+RjejwvK89ub4VYbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054812; c=relaxed/simple;
	bh=zqYXw5Ztc5s1ylSnp3QXQVsW4HNG1ET86GME9G+5Bug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RPLwFv32KGulmyPBMgMwWqDGNSjQb+zGCcqYOw6zt3KgAPHqK7VQiIOPvUGqhui6Kwf5IiefmZkzxA3qMC5nsDBJeJ3m2Bt04oBsVOqGS7YQYOVOJ/NM4DZmmawOdljn3QcRMUYinW/1cl1AblxwsnjQvdx09ktRYlsILT+B8DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=NRoKf9sV; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="NRoKf9sV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6Om4vT7+TSWqh4MbZISbxe6rD1Ow+zHWZXsqH+NS125gAaRwwZtUVOpB4OA0eVNXE34GZKgZc9wrdBSzsGu7X2rx06xRDei8VBLO44Ey69QBxOgp6TMp4hkqlpMf7l3Ag/B26HMSLNNp9uuJLLAsC4eYZjrWmA03plV9Kztk46MDfEK6kr0esjApthzXDdPavFN/bkH+pVHlrwWI9uzbL33T0j58yBQ2mjvAa9sbOgsEqNupEHi5hbYoRXcDu6Kfrh1hV5plKubNBTdi+JMkDb71wg6CTTdAzK1YTbT+yZ687RJDee0aBeb2Knah8ZqAUF/rvgrWo/Ngi9ebmAZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4teBY2FGkn5rZqFRxLi4WELeeaKBLhzJjGXsCU8B8M=;
 b=J6UpgghH+5n3xrWijMN7YIylqo0DngIjpZAVwep0ge1hHlX1O2NwJ6DyaKQuZBoQJAF80mLR4MC66FT149CwOkf3njuc8UEFMBeAwJXf+4F/deEE8tgA/tm1WpxE/B+rLhiFi0OC4oBT+8MWpaFQfQBiUcdiXwKwpYxkNPAA+OB1LoWbJ7lh5EJher4HiH/CUvLkwPY4lb7PKBa41RbpVfjdZOFlpQ/M+2H2TmZqsgJzDHSPlpFfhYVX/X6E+TXOfSUYBK2a0BrGiVAwiCnWEca6GJ7K75alTYQqZskI1l7kN5/77gBtY3QBxiEr/ecSDSgPhkPeAHudbB+n6v1Meg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=jagalactic.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4teBY2FGkn5rZqFRxLi4WELeeaKBLhzJjGXsCU8B8M=;
 b=NRoKf9sVMmm0Ah40lkTZ5X3GcAbOLAYS0TVKKLJqWW3T0YYdOjRrEsPEjJkF1vbSs06kDJfQgX5xU0XdH6mm5ed+XegmLSoJI7GgE6sgXvHHmEg7fhWWceoY+WQNAfp0cheNkv9+zv5lfdVfoW2CfcTE0QG/tHIw2mjtP5QXA44xX+3GL/iorRE7+yOBQrydGZkFE6ILGXs9OpYGbEXFK7qaRi4pNJ5NvvLogR/UheWgZwnP/Ckut/tqayAldmeZXLV634Xfyv0hDy+kRPRCi9HJBf4W74UdlwL6p4HkLtKJjcsUNkvSWDCQscrKS1BMiL4Qc7bk+gBugumbXbb+ZQ==
Received: from MW4PR03CA0107.namprd03.prod.outlook.com (2603:10b6:303:b7::22)
 by IA1PR08MB8713.namprd08.prod.outlook.com (2603:10b6:208:451::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 05:00:05 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::cd) by MW4PR03CA0107.outlook.office365.com
 (2603:10b6:303:b7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Wed, 16 Oct 2024 05:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:00:05 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW36EX19B.micron.com
 (137.201.85.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Oct
 2024 23:00:02 -0600
Received: from BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3]) by
 BOW17EX19B.micron.com ([fe80::1c0a:12aa:1e25:d8a3%6]) with mapi id
 15.02.1544.011; Tue, 15 Oct 2024 23:00:02 -0600
From: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>
CC: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>, "john@jagalactic.com"
	<john@jagalactic.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: [RFC PATCH v2 4/4] cxl/mbox: Add Populate Log support
Thread-Topic: [RFC PATCH v2 4/4] cxl/mbox: Add Populate Log support
Thread-Index: AQHbH4hCL4VC+jh+7kyZyYtwksPD8w==
Date: Wed, 16 Oct 2024 05:00:02 +0000
Message-ID: <d37a0cc0e3d847afa0ef87b1fbab34de@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>,<20241015205633.127333-5-ravis.opensrc@micron.com>,<a67bf703fe3f4e9c8d1d8588d734d2b0@micron.com>
In-Reply-To: <a67bf703fe3f4e9c8d1d8588d734d2b0@micron.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mt-whitelisted: matched
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|IA1PR08MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 686412e4-5d26-4f16-307d-08dced9f6656
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?ArfoKJFn7QPUUe3eA/+HW9tggql17QkoAwe/vFzuKxrB1li3iJMlVkT/94?=
 =?iso-8859-1?Q?aDWbBeod1EkIBPpORB4AV7jWTUWUHRKBP66IuoQsoGI5l23OAYVZgw/OAw?=
 =?iso-8859-1?Q?i720DOmI7+msK43vJJMG0BzS6+EXEyKmCmTMO8JY/W03Y3ergBlZWCgrRK?=
 =?iso-8859-1?Q?mKD4cBsqNUun+jV3c8lzw2iYkuqZ6TngrABjmXfLV53OJMdyR0gzUDXsUn?=
 =?iso-8859-1?Q?f+UXgXfsAJ4o7oNSj/IqSRfwa/MtqA/qLaFI+u6mTQb3JqI4x3LLF6isyR?=
 =?iso-8859-1?Q?ZhMb6qUuFgU25xdkGRHIA9ClwW33cGeTX/db3k3ZC5h7hkUtyNECdgpd5B?=
 =?iso-8859-1?Q?WET5z/vB/P306SRxrDao0opWgchnk27cV//7aaZ8zntCRIbpIyq+8rNG05?=
 =?iso-8859-1?Q?vxFXb6G242ADK9KsdHYtC9J3zSZ0NB22K3IAER5wR2OZ3ygMiRPb+YWsWB?=
 =?iso-8859-1?Q?chG5s2ppUmlUC5eGvf8SBswZ5DZZQ4GyALQc7PTHRSwx1ymoI7oiCwO9tH?=
 =?iso-8859-1?Q?wG53ZzkzkwIZJKM5FE94lUpT+fww+iLgvEGD5rUJeucEOWBQ7qyYUgyX+l?=
 =?iso-8859-1?Q?Xc3mad9ImFkjNw9Hmzs4dOppGRFoow61+9iv7Vokw93NxRo9FUXk+3goZz?=
 =?iso-8859-1?Q?WtkVQ0ZTmn/xZ1W/TD+vBtSlqOUY0TK/9qOgq4ZNsq+OPlrl+vfkMVPCfJ?=
 =?iso-8859-1?Q?rpQlnZRGDpy2RziN8vvKUcU1UbMXOuz31VsF161AdAzDbQgySXyM0MpnMU?=
 =?iso-8859-1?Q?IXTi8kAizSI+p8lWJ3G4IpZkLWNKWr9IvL7oW9BYcyanpsF6SZyVI9Hum4?=
 =?iso-8859-1?Q?lGSX88uKFQNoE2d0Wbyc95yqi+xGeGV6kGPvS1dNZEeL4dySNUC17mx9sd?=
 =?iso-8859-1?Q?ZPMgIUQHa3e+N/tu0dD4Si7+SAcaL92MiI3Rbfo+q5sr+YfWsCds01raKB?=
 =?iso-8859-1?Q?u4a6YjWvqNnYdKtk5rQqPkczXSxt5r2ivcCN9NE9uwORdgmJKdLnq1mtAA?=
 =?iso-8859-1?Q?y260vlRYk6WzVGGvac9X0PQiEXsAVT/toP/YHJ9oFpnWe0Ge0jMtoRYoYI?=
 =?iso-8859-1?Q?tQlHlv934PohBe5A5fqjnPx0LmcYdjQnIcM/luIzZjDTrXkUhP/jI4NqMm?=
 =?iso-8859-1?Q?U0jZIXUbcdLoIJTYv8/xuYXxw28VxoHP4TeSe9x4I2JV9TrnYAH3vT3rMW?=
 =?iso-8859-1?Q?qtBbsbC7F2TJVx/aw/HsBDTyn6GsnHoh6Ar9EYZI2ACnUBzsNusQN+S4fN?=
 =?iso-8859-1?Q?r1wkEm9yomOw5C7s4+cAbAhARU1mjyKwJTYNOLsqmAuvRZ56s7s6y/n3E3?=
 =?iso-8859-1?Q?GIVHu1dKYWfKLsqD3U/TlVr4rQC6T+fuF1JYKJg+4MAOPBdc3B5N0CmkeO?=
 =?iso-8859-1?Q?k4Rxaq/bqIHGM4D+naRNieqQJxpdSnGOKRR5U9FLi2xgaBgT2rn5uKQlsx?=
 =?iso-8859-1?Q?3uo1JLTBljlzjsQI?=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:00:05.1650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686412e4-5d26-4f16-307d-08dced9f6656
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR08MB8713

Adding UAPI support for
=A0CXL r3.1 8.2.9.5.5 Populate Log.

Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
---
=A0drivers/cxl/core/mbox.c=A0=A0=A0=A0=A0 | 1 +
=A0drivers/cxl/cxlmem.h=A0=A0=A0=A0=A0=A0=A0=A0 | 1 +
=A0include/uapi/linux/cxl_mem.h | 1 +
=A03 files changed, 3 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8c0144913b9e..48c2fc8b4bcd 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -59,6 +59,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_CO=
MMAND_ID_MAX] =3D {
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(GET_SUP_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAY=
LOAD, 0),
+=A0=A0=A0=A0=A0=A0 CXL_CMD(POPULATE_LOG, 0x10, 0, 0),
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(SET_LSA, CXL_VARIABLE_PAYLOAD, 0, 0),
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(GET_ALERT_CONFIG, 0, 0x10, 0),
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 808fb8712145..6320d8cd3ca3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -530,6 +530,7 @@ enum cxl_opcode {
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_LOG=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 0x0401,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_LOG_CAPS=A0=A0=A0=A0=A0=A0=A0 =3D =
0x0402,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_CLEAR_LOG=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D 0x0403,
+=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_POPULATE_LOG=A0=A0=A0=A0=A0=A0=A0 =3D 0x040=
4,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_SUP_LOG_SUBLIST =3D 0x0405,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_IDENTIFY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D 0x4000,
=A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_PARTITION_INFO=A0 =3D 0x4100,
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c6c0fe27495d..040ca37046ed 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -50,6 +50,7 @@
=A0=A0=A0=A0=A0=A0=A0=A0 ___C(GET_LOG_CAPS, "Get Log Capabilities"),=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0=A0 ___C(CLEAR_LOG, "Clear Log"),=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0=A0 ___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-=
List"),=A0=A0=A0=A0=A0=A0=A0=A0 \
+=A0=A0=A0=A0=A0=A0 ___C(POPULATE_LOG, "Populate Log"),=A0=A0=A0=A0=A0=A0 \
=A0=A0=A0=A0=A0=A0=A0=A0 ___C(MAX, "invalid / last command")
=A0
=A0#define ___C(a, b) CXL_MEM_COMMAND_ID_##a
--=20
2.43.0

=A0=A0=A0     =
