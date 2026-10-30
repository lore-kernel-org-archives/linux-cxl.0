Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793354380;
	b=cfb/oJ75DEXYDACObObA9YV2l503nZ0pLVCbcULYlRf/tLmGqWNv7QRPBv46VSWQ+dW1
	 8WTpyLXopgRWwwEsDgMzX/a6oOhHCJJqtQmSebwTYSPjTRYGjjVX+yit5bG1DuVk45zI7
	 8ARKHfuqMiCSo5Yxg7w8RH/Pav2QLzijI/6rXbdIz7mLQ+B6gpp4pCNRGbqZXFXeiTxch
	 Yi9TzToLPiqAJLs2eUhYaX6vwfbcHlxeFm2DWENft0MHR12vQiupbO5NFe3vqb4wcEe2m
	 JJgJGzv47t1FYhm1A12ooDhIrwvK5RgIMqI2Ppj6wlK2CkPPj1BvYZbtHwo4eGLNDlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354380;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WhVjyAuGzq/HjJ2e1N/h3uMAk8Q27f6RY2j6TS0nxfE=;
	b=pZKo5EyRI49rzye8f3ER/e3NQ7BHhDo8OQbEjuBqIt7h5JAWsE5RNyS3L7TXCJNPFCL6
	 FiVfuriuPv8KuvbS/e//n8o8rZLJCOroPRlHcMHDkUD/TE7D2+8cjUfI+5lASBzpf0o3K
	 RPbsDxX7o0kXlbNBoCUn8YoWSHoJVYwp1YDZhg0dZoJQXJr7DFIqlx5fbH6NOPaS+hU3o
	 8KMq3N5AkhHKsOAE8c7PyTAHoPxhtFZwrVhuBAWXAnCuQkCSGsROSXL9JzYBIFjOVT5Sk
	 tdo6IUApwddAxuWUawsxnBlN1Kt9IR+GI9/r+gOk4IsB81sMo6cop6bIEhUcN4ghypA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MAnYpcZj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.8
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E8606A31A;
	Fri, 30 Oct 2026 09:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC7E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MAnYpcZj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEKGj26aeQ5tv2MnMnp5BTVPZcdX6KCIXQbosDw3txkrlitRrZZklMWGVGbSlN5iT5OoWfX2A1y/UM4tUdOBIP7pOtElPwjKocO7x5cOR1mxOA45DImGv0MnwL3cKMUp4TXtxOZ9cXlNdT1AZQdat5hzyw3yLMiqfh5T+0qe/w7fRK1KaV6WSb7PcIF4crCPQaC0O1iQnXe27vZtE7wUL+IOnAzskgRgPVCY81miHXTbERMKoRhXkDT6QsOCx6nvFZi0RgjCvjQfySKfV855fE9k78zV8GesaiIF83vkyQ7wqkza2GzOJRZNf+XR/slZ+AFF1tKQ+MIEfm4E4dWTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhVjyAuGzq/HjJ2e1N/h3uMAk8Q27f6RY2j6TS0nxfE=;
 b=E5BbMH8RiHZw8BVKha3tutJqfpbRYEj5miQL/ZXVHUG3yTUPdFFMw1WgyiLLWN+SqaBKztVfDPYzTl/oCx678zhUfAzymIYL5tEqJRaAc6dskw0SNsVWyad0zbuxJ43ZUWdgMZiLBIwhYnoVM03cJ0pxuVGTqrPhYn9wrjGMdhBRFDcGDFRVWAaHxe9YJvUgbBvJRVwIebk2N3O/qhNC+xLk9dDI703eruX19+b0D9jEO9VJMhOH/q+a92+atnmVdaLPGiHoo7+eQ0zvItgxua+o8YqZxp6qF24YEsmB+oC18u38D7W8Md32iNuLpYGgEjfeLyzNWKeEHJGy0b18rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhVjyAuGzq/HjJ2e1N/h3uMAk8Q27f6RY2j6TS0nxfE=;
 b=MAnYpcZjNYlVDLjbUcZyhX5g8vnutKYIfqsiwF5oCotDEteG3OgS15OsifP7R4P9vOUjnGC1uicH9ely3TNT2j3bsyaQFUcyHbe8GWntXHAGB0oYEcj2I4A3FiLyFRRchgBLsG9I3XzGs1FdFFtbAcGGS9/s3EMS2AQqhwedH0SUNYLulmIVJPmphgaQlevgSIy+9PhMUZPkLas6KLL9XfH9r6dp4vCg21gEuSZDof+kQHssHMlanFo525c7qu9WgKWp40MHHi3XJKPsaMgXUzlbiyq4Aaj7Ejp9N3aY4F22Ps4udZVEmZ8+0iAfUx94PJMDabIo9pkVkwCiVQtrJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 09:59:36 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 09:59:36 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com
Subject: [PATCH] cxl/port: Fix endpoint RAS error unmasking
Date: Fri, 30 Oct 2026 17:59:23 +0800
Message-ID: <20261030095923.46051-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 7117f87c-708c-48d8-091b-08df366c80d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|261009223027099003|261028144727099003|261022075727099003|261021121427099003|10067099003|261021123027099003|261022105027099003|261026140227099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	2YcZ7oEn5ucjmznodIusXQAzev+UI6ZYi3hCEZ01jRP/s8NiReWD3t57IImlnUSjmP9MKndGTt01EjrDiUVQoyZH7yeFvCxQcSSCjrLfG2mHJjXYIA/QfXgjY2B6HWwzdhY1BnnxL9YZf08m7OhKFWZN151UfGThVXxaaAsFjv41U3tlLLElFHLwfyMBcqXjQ0sShqOhuqYz/F2xUmw79uUZ1vR/FrKni6acvBGOAp43yVeWRbuzSF3q5t+xPE3eGCrSyaToCjOSWBysJjhlQNEzkFw8pt6+JRFhmH6OlDjPyPWRjHZDGtqfKgF2u0mnb+PoLZr1WrxaJC53ucaF0BTqzUZq4/VicO55ezQGmYzK1G+ZNGcILwtKr+hKvb9xysDqG0QKQ5wotoWx91KAUI3ozY5tqBUrKYuC0hKxujhW8R+lU5ooRY6pyDQUtpRJ/FlFdDxHY5tJGFIukrM2KMhCdVYh0iEcXRBIE7FWGgUQ+zHPR3Yi9OMC7Kn3OOlO4nuZPnawalnP+IJznFidF+u2c/jz/4We9Ot/8wYqKcxCfpYQG0BNcrl64sO8xJTUIyKD1PkuL8SgGpJc4zsq8c1MwJpmN70I34PRCfBsg+alpBE+e/yLrWxlOL0OCyf97kKbWYOceYNwcvX76toDuHYUDDzFAnF172bCqBpMdlI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(261009223027099003)(261028144727099003)(261022075727099003)(261021121427099003)(10067099003)(261021123027099003)(261022105027099003)(261026140227099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?THOdJPdc2sCoI6MeTaIus6Drb6SpoJNslKd4fYrLjsIZWMSCPqbXLbD55dqG?=
 =?us-ascii?Q?kBWT8q8hGIvFVayHyiuazjA3vKJx37YCCvQyVNu1dv35S7hInFvKYFEpHBft?=
 =?us-ascii?Q?BOMCBtMqfqdZ3TYIpWhzNnD71o5iOmLiGb15XY05L00aSY/8XANKE+XaPme5?=
 =?us-ascii?Q?DBtbRpgGnkYl6DrAQ2gbB3YBUgU+ozgTIFPTEJdTXg8fBapwRXcj24gCVCKr?=
 =?us-ascii?Q?2s1Kl0LkOofHzytXtIDDo2CpU3zhkji3HRQj9BGkOAbTh94xvzXAtub9rB/S?=
 =?us-ascii?Q?r45uF6UIWsZCS85OwIWaUz03o0u+QqCimrIS7ZPi6X8uq9ita4YLXQGbBDIy?=
 =?us-ascii?Q?Qo/47F2ecDIoD8NWL1KUoJvPZGx12UuxhhviMBAAq4LAAT1JVXUkXbUh8wJO?=
 =?us-ascii?Q?8EmMr6g0STO9XK9jpVq+5OAgyUTBx0e6SIUx+81gpifSCOqBONKLeCYLsLfF?=
 =?us-ascii?Q?0tcwROSpWoQIarjOCKWFLEmEO19v8tWEpDXwfld8B74ffa+Nrr6ok6GQCFSI?=
 =?us-ascii?Q?Z3wZbeyqi2RHE+TzFtdA0Y3xVYJHWsvZYe6J4YbvmSURslHFITKqPXfflhrI?=
 =?us-ascii?Q?J0NFk6SnFQB5NJA9exgSW6S1rt7BQmMT/T95qNF2OLDpsrHPa4BxoUBtgocD?=
 =?us-ascii?Q?IfzkjQ27lRiPe7jksoGns+tquqAPAfwKUNLDf+qbPxEk+BZ9d0IB6q2NivGX?=
 =?us-ascii?Q?gSdwdmWpy+s9/SKN89XUj13ES4CyPYeJd0elvZyUiAVuUm1abnBDZcZHyctS?=
 =?us-ascii?Q?0sKhd4Z9FSXGHU9JL3eQK5AV1dFbv8AuIZnzWpHVixagIiqVoPcqPQDQ5pC5?=
 =?us-ascii?Q?QN/QXnO4ge3PijrH1XG4vrTLgoV9YXBKbHtx08jyaBGkL9+m5R3xdwXkzKcW?=
 =?us-ascii?Q?r7lvHniKJo9fN67rd5X94mYgxVIoerT8IykpAiY84BYpySMui5dZrdbdFD7m?=
 =?us-ascii?Q?OeFj2fxEr4n0dSHyg860PMsGavVTsB/R0u7W5W1gJEtARlAPwodTeVTNCBUu?=
 =?us-ascii?Q?e5wBnjy367VjYqAr9qxCJvIDTdE2zXWz1LILWU4tTzsN1c6w+KdX8s3JnQzu?=
 =?us-ascii?Q?H7bT2ZOiVdJ0ZrhfsSyvG7rUI3/5tTSz0cGxCzsbxNAVX5RuAX6ox7YMJC2Q?=
 =?us-ascii?Q?Le1oGIa+OskaipsH/fJH27T6m2QUlj+vAgaF4HdAk8HSs+MUz4JzZ4TLTXme?=
 =?us-ascii?Q?NGwFXXDqS2SSwxlHYy+L3MLgh/6T0Mnu5/UreX0J1xsnoNIit6nTzDmxnQGl?=
 =?us-ascii?Q?bPmsrRZRZJFn0pcIyTWvia8TM3loNNiTMVhWXawrCN89bLXDsbtDEWDMbMV4?=
 =?us-ascii?Q?G2MBdwUZybsjD6lsKkNXCOsTyplncgbVpfRSSs6j3SciqZq0rsOaCOKB/KQf?=
 =?us-ascii?Q?MdgnOtULcHC9TNK108I0XjGFLiNxqrQhf2tC3co46p2z5Am23100FBRjuBCn?=
 =?us-ascii?Q?K4AiZdFCtPZ/Vs42OdGxVa7Qs3BMlsN7HMZAkL2SanclGZxAarkIVbm7qKUm?=
 =?us-ascii?Q?/hMGr/5L+rXaxat70a6N7Hk0XHZz+dLwUZexzN/qzUECdce5RuNPU7zN2mal?=
 =?us-ascii?Q?l8rSyxcGibTSh1cbLfjHi4WbtERfVi6NhR1+t8F/SaQZg9bs1j6XRI2Lx4Wv?=
 =?us-ascii?Q?F3Gwm+3vns46WPh+FxzB5XZHRZU8fK8KKM27g6i5YoLo7FeUYDDg+OXTGblX?=
 =?us-ascii?Q?vXR2j5tXumqSDIMoGIiIpSyoVLYPvObsE5xPPmxp6dAZE2pw+ywswYmIBuPP?=
 =?us-ascii?Q?1K7YqkR5NQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7117f87c-708c-48d8-091b-08df366c80d0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:59:36.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fa5PHc55CgLWxGQjUlhuECSqseHxdVsc49lMvkp+vcw3fINGGte6/nXHZMahssIhz/aQTzxzdo7Wg5VhQThGKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

Commit dab7162d0ae7 ("cxl/port: Move endpoint component register
management to cxl_port") moved EP RAS handling from cxl_pci to cxl_port,
while cxl_ras_unmask() have the assumption that port->uport_dev is a PCI
device.
If the topology use cxl_memdev as uport_dev, the PCI check will fail and
CXL RAS masks remain set.

Resolve memdev uports to their parent dev and verify the device is PCI.

Fixes: dab7162d0ae7 ("cxl/port: Move endpoint component register management to cxl_port")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Reproducer is a QEMU Type-3 guest

1. Ensure no CXL region is active and PCIe AER is enabled.
2. Restore the emulated RAS registers to their reset masks.
3. Reprobe cxl_pci and read the masks again.

```
BDF=$(basename "$(dirname "$(readlink -f /sys/bus/cxl/devices/mem0)")")
BAR0=$(awk 'NR == 1 { print $1 }' /sys/bus/pci/devices/$BDF/resource)
UNC_MASK=$(printf '0x%x' $((BAR0 + 0x1084)))
COR_MASK=$(printf '0x%x' $((BAR0 + 0x1090)))

busybox devmem "$UNC_MASK" 32 0x1cfff
busybox devmem "$COR_MASK" 32 0x7f

echo "$BDF" > /sys/bus/pci/drivers/cxl_pci/unbind
echo "$BDF" > /sys/bus/pci/drivers/cxl_pci/bind
udevadm settle

busybox devmem "$UNC_MASK" 32
busybox devmem "$COR_MASK" 32
```

Before the fix, the masks remain 0x1cfff and 0x7f. After the fix,
both masks read as zero.

Best regards,
Richard Cheng.
---
 drivers/cxl/port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c12fd0b89883..c48216e5078f 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -74,15 +74,18 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 static int cxl_ras_unmask(struct cxl_port *port)
 {
+	struct device *host = port->uport_dev;
 	struct pci_dev *pdev;
 	void __iomem *addr;
 	u32 orig_val, val, mask;
 	u16 cap;
 	int rc;
 
-	if (!dev_is_pci(port->uport_dev))
+	if (is_cxl_memdev(host))
+		host = host->parent;
+	if (!host || !dev_is_pci(host))
 		return 0;
-	pdev = to_pci_dev(port->uport_dev);
+	pdev = to_pci_dev(host);
 
 	if (!port->regs.ras) {
 		pci_dbg(pdev, "No RAS registers.\n");

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.43.0

