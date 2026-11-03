Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793687662;
	b=z9NaVGbQw2RqX3NwOCWSfI3rq13fNrM1hSE6Yb9SrkghqsdGp1hGVVYI3ld+rUFCBl1e
	 y1eYFgQo/RU+2UpMGgC8Mva9QwQM55hgoXZ8umMpC12QSeu2TMamMHEJGL5UPLLV9x402
	 /PWhlZnoExpuNmBnLBMW1Y6BmC8gCZ0686mlALR8Ekvw+d7Hm9R5bSjTr/dJSl0f/ZZ4B
	 Lp1tXVme1fOxFECM+ivbbRRJsEKZfHYybo5RjQIfRpkmvADW4esjvSAzEtR6pSuYtZFRb
	 NcyGurQNfqQshNbzrXQbGWw8ckGvy0qAwnggcAO0FEU54wMCfc5GxEbsms84yoxg0TQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687662;
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
	bh=q9WT78x1YkiedwXkVrU2HXeaX2R8w0dBRyEKN5ob4Ow=;
	b=Y0hnWcQ1Nl6Gn7SRVtA9U84C1G+aWpzJlg+5cAopAVjcA/AJuW9TXtX+fZg1tqbBxKSY
	 IkK78wKLTIGt+CZD457RSMrK8J793tZjqAKtmnymfhPern21E5T4VP+KPMMBBcCUHxk6t
	 ljOB3wP+Qmuw7QJKhmpQ/hsL5NcWAZO9DhyPJaA1svtidxF7inDKg2LVf8toVFrdBylTn
	 oEGJyjL4pURY5B9wInjrqYhoneByVIhC5HdiLtUPDcsDU3EBwim4fdWboG/7PHHwhI9Xv
	 FSEGCKO5Ac73oRL5K2MApXylGHBGXbdstA0JqXCTqizYx6FGNcBR+Iy3xW27WC6Cxjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=olZ4YE5V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.70
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB7606A324;
	Tue,  3 Nov 2026 06:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34AB7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=olZ4YE5V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FC39dFrhDeIMaO+Ch9HBgnoloXzPYXueFQSOhpQQrT/d9XASQ8Ib2qwOQ0doOIUhI0S1OGjLFs61ifX1QIV0TEcv//zi7lG0SA1nwjv5VTw7+PCpxC1qb2Zv8msPAPzWiJDzyc1Zbg/5t0TVin4psQNUO8fuxBBe9Hot4qxjVRnZp1igIWjYdx4d+tA/bn231Ry5DJDrm7gtAl+CDve1U8YXpdKnukNzc/vLL0h1MlRA92S382huOPOcJPDD4Cmx20Vj5aYHGESETG7UCh1cfGIVn8/VfdzFRG6jf9ce9Yr3DqGg2VGxnHt5n9wvlYXifLEgZNUNai3sLKRNUxJ3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9WT78x1YkiedwXkVrU2HXeaX2R8w0dBRyEKN5ob4Ow=;
 b=CQqBxxFxkqQrIXhtj6gaCm5Q3VRdHJgcpvDXrYy1HYVpK0rmFNkMAKscrC6P88oCsBc36fcOzC+mlSAA8CYUZ0WfHw9JDcvxM8zNjK5zf/0mxr/nL3BtG9nveyJQr0kY/IKAlM1OXprU7gB6dOBTty8eROuf8NiOmHxVOPgHbMALHga7KD7OWeTPt7gJrIY1hkBxXsPyTuCH1honG1fpMj7Xzb6hakxJdV3m6s7XaQOSTEGw2r2adU7r8PWBLbl3M/JRjGQ7USroHqR1vGulbrJHwHQmsLpOxGR4xPix8jMdoYdrBcjFazZAAZbCDxZHwm3TA1qWYA8gCcSy/QAXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9WT78x1YkiedwXkVrU2HXeaX2R8w0dBRyEKN5ob4Ow=;
 b=olZ4YE5VTukIebwnhVUs63jPTaNoWQMnu5WN/nkXUAAVglyBbA64I8KBDn1sARjQ3KdeNhz5xWRwAKlTLkHdPpFSlxM4ypZA7LPiMmkzvMz18lWkKlyyPwrdjLVkHRh+TQSNeXktXjtvOLNuKVZNl+4KMbLpwYC5hlr0skw5AgsYKU/SCvUosI4npXD7jPZTwBKj4gz57FEzOGm3tZadlXBWxrfGpXn5FXuyI5bKpAGZmY9Kj0Q0oh/bObudzjXmBBydH7aevmIq6F00E/m2L5f+eV3TZXGtiPdYWuI3lMOdQYRevpZQlHb15Lf82lm4XISCszWjjaMOqwwqKeouWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:34:18 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 06:34:18 +0000
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
Subject: [PATCH v2] cxl/port: Fix endpoint RAS error unmasking
Date: Tue,  3 Nov 2026 14:34:09 +0800
Message-ID: <20261103063409.18275-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:990:57::6) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e43abf-6f7b-47d9-3ee2-08df39747bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261102123227099003|261022105027099003|261021123027099003|261022075727099003|261026140227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+6P8kPl+kQEp6eWh2MPHY3V2RtkamBBbOE7udm6DC711TskTLb8o3U+HuuA3JqJ6PGRjftG3c/srS4MlM4VWQz/JZS7UnCEu3rNaB2fZ4Th2uvd3ATsBwgvKluzCq49e9b4PKjrpYcyy3WtmByEngCGoiYLTlP8nF/gZ0AVgaItBirqBWeYUpBd4exIC5tuib9bR509Bj4nG37vWPPkl0YrTEY0XWxN7pwCIvMvInuV7uxqpUkTwMmO/yQU7evf46NppKrcxWJJhM/vXA1JWLFX0ZROqsZvSLbD770mOs3FTNlOouJ+LxgxheIk9zrv6dq7wAl8bxpJMnYOdyjmyH2aMZvs8mDspVis8mpc4rYK5NK4jrXcPPcRE6F5y81baIL6jf+CArhabv5y7SOX34NYR+7mMSDCsRRox37/b/wZ/jLyS7zH09Or1uq1Ej2KhTeMhLPtGAkK0IKRy60/r8Rp+VZ37EQEqqyJzRVuuFTbPHwNUuWa6libX03yfpDO+my6BxrxoO2LGdGKVwvHV7d75+/DoNIU6Bgl3oXhN9NDssyVBRiaAa9ndkYIuwfXgNdmeIkqry1slR8ru7YJgNakXOKWmeRdk5XJd+RxqufxqkyPP1mCcINiqs05ig/RjLXS5RAN6V4aDNymkE2r2tvK8F7daapA3554hYSdiedw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261102123227099003)(261022105027099003)(261021123027099003)(261022075727099003)(261026140227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F5NEWp3NE7fU72qDDHFcSUUdsilCT6eb5WiXOkZn6ukS6g4lA2PTd+4RuPc6?=
 =?us-ascii?Q?FHA3OSCQyB/qAA3QjU8cqxFUenJQJRdR32Lm0GRJMxBRhK3dmEFLsAjEvSfW?=
 =?us-ascii?Q?tCmPmZKiSx+OZOHrfdNyAO4cAibKjjGKuJZK2/tzj3zOSySSKObqWbw8xAPD?=
 =?us-ascii?Q?9AA1PWDFCF04nL8ucvizX92XBJC2hQYq92L6jMSkBKeZVQM0R5TMFJ0AWp05?=
 =?us-ascii?Q?uMlPFF5pHMq8HgWorTSF1fpdz9GotgMY91tbO73JDuBmtkzDABy0mjLvaju/?=
 =?us-ascii?Q?OwlYQtFSN3bvxlMa7WYfBFHeLtk956bbXPd6Q24vetEeXwGdFmhsCPW0yjKP?=
 =?us-ascii?Q?UaUYad8EYkLhKCPhTsjRZapy7FBaaB8+3+yR44vHz88O0yrPAO1wELNZX2MA?=
 =?us-ascii?Q?VRjtWyEx3KiivKd8dlkFHRUN3a2ti0MkeVNAupKcHAiuMMjdbKcEllgt05pZ?=
 =?us-ascii?Q?UzYuUlJCkS9hNOxvNddG3f84dSPzWbJeRCRAZi+zT09ptCnnJd1JaPX+BbKZ?=
 =?us-ascii?Q?tsjsj7QKSh0EOIrMsL4BBwtEIkXPL2OTUtf+fBaoiUy+BlfN0X+PPwuJW9Z/?=
 =?us-ascii?Q?FzdtTwnHSVoerwRJ/nnAOcK2j1hsGjvUQbRdIug2sH3gYPDqRr0KzMPV5lBP?=
 =?us-ascii?Q?NTCdI/p886PDHDh5rdPnUwdK6EGNV6C+5VzjqCwn8LQjqQ0aciYUKlU0KCOl?=
 =?us-ascii?Q?uSVr53vVNnLCwvA1hOuh1unZqY1LTFJdxj+PyPdcTZV0WedfqMlGOfAVaRU1?=
 =?us-ascii?Q?AKtgK8z1VHPzAFV7zR/WN0byu9v5RLe3vHhoFLhDKSF4gnwLVLOl1HEKwswh?=
 =?us-ascii?Q?5/SJH8CE/KUfJLA21UYjYWBZ4yUvqXUqbzLKp07hmX/VjoSJtyd1U1DBG4C1?=
 =?us-ascii?Q?Ny6zNlC1d/QW1gFYj+gpQnVscnDxhO9yDCq3w2IOWG0kPkUeth3611Y0hrmj?=
 =?us-ascii?Q?GN8VpkNzVQXmtxK+EaE/hi91u2NVCqgSNomVWBoeqx7V0hlLZrjMBQXsrj89?=
 =?us-ascii?Q?go+GNmV37WUoC9bkC2TSctQgZNq5ipUdtEGU8WMkfnft17FBzQ7MiGzqd+87?=
 =?us-ascii?Q?4ktwNK0cMtdMWqSSMgxNVeAN6iIXlM1zcc3uj+JdzMR6ShiVGVipGUiouKpv?=
 =?us-ascii?Q?8PrVAc8mnEKByspFUFAxjPDCMz9Oh4cQ8Ew4nNWWOqlpOALAfaLidSesE91P?=
 =?us-ascii?Q?xnBD9jPIrXIBzlSyGJCUK3HgpC1OsKhUbn+6MY1Wlo+QdzqTOjsVXUkwrHvb?=
 =?us-ascii?Q?X2Cm+tCSTmXtpajhRwxvgwMj8iI63FlofCDXhJJt3vylqS41OE4JL6+B5srm?=
 =?us-ascii?Q?oqotY6x6xc6ZKE9gxjwENiKtR+0+jeM2PpfUQIjFLGIIgKlFbMNFgpI57itw?=
 =?us-ascii?Q?tTSQR0HsIU3wzkPwOIZaVxa+2acx2tvKJ/qULW6YnH8Gw6Fr1P0EpifqI409?=
 =?us-ascii?Q?qVQBBiFdK/yQcam7AqQ+5UG3bScR5IdntFEIKq2VuuTY1LcKkmxcPiTNIjy9?=
 =?us-ascii?Q?kpsmSSv3gC1xNF4aO1FS2HIEe/c0XFRWrDo9f172igSQKX/feNtB8rPR817u?=
 =?us-ascii?Q?4ne02OjAftEPirXr0tjjb718k9NQnpDQ7wZlDVFIYtOJbh7zpMtoahmNwjf6?=
 =?us-ascii?Q?xFnHJn/cGtz69p3ZIWHiSSMFmuJdQol6ko8cr0cER08B5G4KFUb3fkYqZMpp?=
 =?us-ascii?Q?v3n839AzTWygvI21ACMt1Ebr2tzQveWRER8i2cwM1kXEe3s9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e43abf-6f7b-47d9-3ee2-08df39747bd9
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:34:18.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfNzA7Vf5+WTxoNj9K/cHIGRSsX6AnYwVGNCqANySLTd0jLW3Te7R3Y2l8Ka3jo8Az0/yH5c3i4WgQ2EZXPUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

Moving endpoint RAS handling from cxl_pci to cxl_port left
cxl_ras_unmask() checking whether port->uport_dev is a PCI device.
Endpoint ports always use a cxl_memdev as uport_dev, so this check
returns early and leaves the CXL RAS error masks unchanged.

Resolve the PCI device directly through the memdev's parent. Rename
helper to cxl_endpoint_ras_unmask() and its param to endpoint to make
its endpoint-only scope explicit.

Fixes: dab7162d0ae7 ("cxl/port: Move endpoint component register management to cxl_port")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1 -> v2:
- Clarify that endpoint ports always use a cxl_memdev as uport_dev, so
  the PCI device check always skips endpoint RAS unmasking
- Simplify the PCI device lookup to use the memdev's parent directly
- Rename cxl_ras_unmask() to cxl_endpoint_ras_unmask() and its param to
  endpoint to make the endpoint-only scope explicitly
- Rephrase commit messages.

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
 drivers/cxl/port.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c12fd0b89883..7b4726c7276d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -72,19 +72,21 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	return 0;
 }
 
-static int cxl_ras_unmask(struct cxl_port *port)
+static int cxl_endpoint_ras_unmask(struct cxl_port *endpoint)
 {
+	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
+	struct device *parent = cxlmd->dev.parent;
 	struct pci_dev *pdev;
 	void __iomem *addr;
 	u32 orig_val, val, mask;
 	u16 cap;
 	int rc;
 
-	if (!dev_is_pci(port->uport_dev))
+	if (!dev_is_pci(parent))
 		return 0;
-	pdev = to_pci_dev(port->uport_dev);
+	pdev = to_pci_dev(parent);
 
-	if (!port->regs.ras) {
+	if (!endpoint->regs.ras) {
 		pci_dbg(pdev, "No RAS registers.\n");
 		return 0;
 	}
@@ -98,7 +100,7 @@ static int cxl_ras_unmask(struct cxl_port *port)
 		return rc;
 
 	if (cap & PCI_EXP_DEVCTL_URRE) {
-		addr = port->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
+		addr = endpoint->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
 		orig_val = readl(addr);
 
 		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK |
@@ -110,7 +112,7 @@ static int cxl_ras_unmask(struct cxl_port *port)
 	}
 
 	if (cap & PCI_EXP_DEVCTL_CERE) {
-		addr = port->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
+		addr = endpoint->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
 		orig_val = readl(addr);
 		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
 		writel(val, addr);
@@ -152,7 +154,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		devm_cxl_dport_rch_ras_setup(dport);
 
 	devm_cxl_port_ras_setup(port);
-	if (cxl_ras_unmask(port))
+	if (cxl_endpoint_ras_unmask(port))
 		dev_dbg(&port->dev, "failed to unmask RAS interrupts\n");
 
 	/*

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.43.0

