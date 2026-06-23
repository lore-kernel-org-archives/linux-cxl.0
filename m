Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013053.outbound.protection.outlook.com [40.93.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF33BED66;
	Tue, 23 Jun 2026 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195621; cv=fail; b=RqB9xBtDZjKHxMDWcCTqUNW/K36DCb01pd2lM5Ms84ljIBAWk6KjFA8nMw6EydJK2M4Q3ivE3c8kVnrxjLkWlJ1ZPQPfAfxf6McZ2xlpEXJMGtG7scqebq2VT65RJoy0UzV65OSFAlg5NLa1O2mTWXijpwe/p1mFp//ue7txkgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195621; c=relaxed/simple;
	bh=mYz5weSwaNI78nagQdP/muJyQY4z4wY6HyKXnE+0/5U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NaoKSZtb/+oTcvm5M7A3bADTxYFm2m9AMPL7V4k+oMrTuM13g/tu3+kA5jLzOt7sGBfOn4p7M09I5eWELLQv/TNaxkBQHkqB37SGNgjQDalPZoJUugCIbAyUwlF1Zyjfj3om4F6E+RWCj39DnMi+1E4kWCyR8M1Yy8nQvsDXUSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RUkc2aTR; arc=fail smtp.client-ip=40.93.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RUkc2aTR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cc1UE2DuiuP9dG9rVCR4mtA3bAH/SbXTDa4+IE9fGChQCT1NC3gz2jAFBGZFR+GU2W9ZV3hU8qWuvl95kIVAeuEH5lsbEqipZH06Dv/fTV46a2/FZ2k9gJhYPHwEHSNMobcTnl6AjDpHRpXvr4Sv1VSAxHk1T1BKDuKnLy7GTOJ16mAxqfmjfQvLPAVBOao5ERG8T9bRxUWTpgyH2A2PGE1cCmMkiXCf0u1nE3Vf8LkE90/LoHb41QIkPNFCK76RiIBrgJWhA4v9xa6gNbeYJn3LXVxNsJCP4IIZhy0N8xFtH8GaKHeLvoMBxFsfC9nL6MmILIJgQi/mvTmNwRO51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24NJ/9BmG65pwNXtppU0u2XnIJmL27A8J74GDZuITR0=;
 b=PnazAShqlKVVjQyjVEN3NfbS8UwVD0Y3JX/NtMvNee+ZDP1m+NucdrpVBQG5r0jniJ/nGC7d+BTUFyv7Bys38zs0euIPOeegUpJZXSvChhQKzcQcf45dRL7er53XnpOYx9elvfC1z8udPYj6pCgAtp6nu9tCa7421UQNhM9+oMH2C4F89gIfdpV9l4YxtLMD8MuKdFxHZFMObUBClU6Wb0Lz8FX1X1ileysJgP/yFnKosldwnz6jECyQjC3NkfdjckpFew+CQtOCJbk/87VirTJf44D+rZFWLyocxFr63kiLWvvuuqrv3yVm7VPfwRPZfF2kdIH/7iJgRgeOBr+grA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24NJ/9BmG65pwNXtppU0u2XnIJmL27A8J74GDZuITR0=;
 b=RUkc2aTRGj53GpR8v/tqoBJ1xOPuDhuUj3O+Ai8dfutrLyiSsq0BsHAowZcJnCAkUU6SBTRCH/an10yxMiK//Qcry2hVgrYLySvvGBFj39wDaEknJB0ph6yfT6wkJ8loiledxawIf74rX1Cr0yg6MJ0Nhj0La3gk5x/dHmAvywryq2x8nOAQm3f6FhczLhvuQH26rBGPRWiqlGq5x5+Q+hDdcDYAJF2fz8W/zTc5V8Gdiv9miYcZYuofQ6NqKdLva3od2W2rgApCGhDyXRHOPBCmZB3QKHp1c5kTwfSU3NjRn1yly2iZVev8Ini47jOhpi85cXrEOJGnBC8Z8tciJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 06:20:09 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 06:20:09 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	terry.bowman@amd.com,
	alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2] cxl: Convert PCIBIOS errors to errno on remaining DVSEC/PCIe accesses
Date: Tue, 23 Jun 2026 14:20:02 +0800
Message-ID: <20260623062002.21447-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d95ea6e-9668-463b-39fe-08ded0ef79d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	WWk6XpvmI0b2t9kmur5RjtWW6dBrfYzjtNDXfv8rwfyfkr/JYNFLntouOgbmVbvUN8NnzpClGE0C1KPOw2NKRyID1KaaB2/DH/IV/dbtFhSJrMZs/3HqUi4k3A8+EA7iL14/cZUY3E8dKtf1LkC7Qvt/DhWKKBNyZCFBQm7LpNaJOgD/PglOXeQ1oKY4wnkF+Aaa24Y544PiXgMwZFkNgVGV0xL0TIqrQDLUc4pyMEjMdFZC0vyzjcTAxh/rbvsdc3AVD3+TiUVZMJIj3bkLgMi6/pXZIiS5BQbWl3c9gd4tNKJGtutQZj+GctG7xuc53R07Qt5l9elT17noy8v+1mBHcfaxsDBBTruaFl3TGMDFRDtbrb98jKNPLt85hqIBzATfrYJSV938J1F4JatJ8/IURaSamJj9IQNJKD2FcCHW3aqw0xy+wHOedXVglR5pxvZIheF1VIIXk0cMxWvv7+zIOCJtT2N3kcAM3Ju/SwUpYhUYEs9/mnTEe6BE5YBFbclGHnZ8jsiEKwxTJMjwbGo3pHiW6M/W5gYHKpnvqAyY3GMG8GAuJpHyqCHlFYzm+HsImQboGMDAkY0E6MML58bAALLJR45GH/tKpLcH4gWCLl+1rMpfAPmZKWmR9ksq6AD1GFHHxcyDcgnQAesIVjCCA3ydp4VSnICXWdt87nI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u5l9lbBMH4nChp7nEy69ZFxIa0WCg6u/OSDAfpC1aOvJGMQna7hk6e9zpT0b?=
 =?us-ascii?Q?eN6cIIVsLpWNcWEpxxrcf+aHn4PiUdPv5KeeVIgNjX2anrUk9v6SEeyXVxtF?=
 =?us-ascii?Q?WVOsf90knnAb2DDg+EdAqH+LU3dYVfi7E17mD8N/LwSyMwiPJxbkFBnOSnEu?=
 =?us-ascii?Q?BUAlYKQ0w4y0Q2SGY2AhF0FOwxzvJ8Fvchdhq7nNFe+/O6tSMWirObHY67Yg?=
 =?us-ascii?Q?Nz+SY48+KodpZvTnJ3+yUiNloqMaMdFqkaljvAkFtK8W1Qs2UzK6Vbrial39?=
 =?us-ascii?Q?IQdO9LLptbj6m0r2fEVKAzfB99A5o2U1EojKlBHVd+k5vYFI1SpwTAIqQeHe?=
 =?us-ascii?Q?VWBsDtXjUnZG0NjP3Jr2VjdL/5ZPhX7N7Lc10BAv62urQJ2ZPWXCzkq8Ugd6?=
 =?us-ascii?Q?yv0wQcNiZmggzemqlz/2hMTOMTTzI3AVvEuiTFgdD2aZtoYoCRtM25urIQHB?=
 =?us-ascii?Q?rORQD7Kb85uWcuWh6F82whng2jlMqx23OelYPI53QGrSgZhW82sx7g705FIb?=
 =?us-ascii?Q?SNDQa95LE+R0CAiHRpJgqbDsIClMOqo3OzhLgdOZxJyMzlmzFytUtKosJ+BG?=
 =?us-ascii?Q?wFVmCpYOW0REEt0Eyi98imZvQJYWSTN5HLKIpDq7VLnEmSc8rQqxR7TpsrnL?=
 =?us-ascii?Q?KPNeLaMOHCiBU87fiUtYvFuwvVGKoEGdQYebJY3bTN0m23TuuSRVgJuBh2sg?=
 =?us-ascii?Q?TzrEPRdARZUzBygVxYhV82DzzXSv4YE1g2aWyM1cq5HE9dey8P82EwUm+TGY?=
 =?us-ascii?Q?iDoCSPD2e4XmTkOv6uAiLgcHImQBkn9AhCYH7o9ac3pnogEsk5QFQVt4Ehn8?=
 =?us-ascii?Q?m6e+11eGqCcoCdyLeDL+nafTUKv6pME49L10RweQudeMsXJO0hXCeu3yJX9i?=
 =?us-ascii?Q?fwr3gScP/GDVxD6HF4fvjHmpNq2IP8HOnUlNxD8NSBydeOy5NLENJCTGOc6a?=
 =?us-ascii?Q?YzlqUc0fwTEuQedMIhxhMGAXr9w8ggTQ6Ea8M/ci7Met4y9AdTPdZTxQT62Y?=
 =?us-ascii?Q?jCMQI6b8p1kS40YkVHveWAayxb8+OQ8jMM42bD26gVhPs0g3voaTTRwrTL+t?=
 =?us-ascii?Q?qE27Wz0z8oBXth5++QKFMv/F+zTNfrb64PVQn/WH/QRbN0qCrouAGYKcQalb?=
 =?us-ascii?Q?KBxAK/8nDhwK6fWyq39vejuHPnyYSI9o8LKFUVic3rWzUtJ72SUwpw6kyzFO?=
 =?us-ascii?Q?RIAfgVRHien8BgblyZdJCbFu4UrqrKNv8syq1s6LKVjwwrxrJXbbVwiwUnfJ?=
 =?us-ascii?Q?XHyJ90r8VZwfy9MlQTsZ+TqVWXg+fEmk4n5VXgxjN0510GMYu4TLES7/pt7m?=
 =?us-ascii?Q?6yNIJLkjQZ6bAgapPAQam2Mx6BeKjC9RwAtG1PS2n2VPaRyAD6V6MkeZ1tqk?=
 =?us-ascii?Q?BoV7kD/jSNXIE0bx9oN+TPqFxeGJ8bpMeGM4+IYQWWyGNZjt9sCl7lFaEBTd?=
 =?us-ascii?Q?dR/Kogh88g7DUQ9DjgVub4gcZxVxZ6SISPdJ/o5mOhuJmsLsESajnWKwlXtA?=
 =?us-ascii?Q?HF+R3EfHAG8/CbNAY30wrn2+XznEkm5rXQaA4ZMjJIslRMozFp5Tyk6rwfYS?=
 =?us-ascii?Q?liC8DahLKwqpGkG+tlKe+QSSdwqaj2654qBTswvIrA/YGOKQ+InDiPBpltsh?=
 =?us-ascii?Q?4zYWqT8QNubmI+RQzsIDFBU2g7gRyGbRCB5Ye9WnIjnvsWs0WMqwvY8Wy9E5?=
 =?us-ascii?Q?HmpMtZBZHTIkzsUI4PnwFc6XqEYYtq+6LK3bazQfap9EZj4h/a4MljgI+cQG?=
 =?us-ascii?Q?iqXg9dkReg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d95ea6e-9668-463b-39fe-08ded0ef79d8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:20:09.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDITFW+O0XNs9ycFjPjZ9eIv1Qx2ndtfg/gRrQkrs5R0KQIEYXmyIk5uJhSF29qh3W3dek632NNcD03CyEJnxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803

Follow-up to Dav Jiang's commit 26aa60e02762 ("cxl/pci: Convert PCIBIOS
errors to errno on DVSEC config accesses") .

PCI config and PCIe capability accessors return positive PCIBIOS_*
status codes on failure, not negative errnos. update_gpf_port_dvsec()
and cxl_ras_unmask() still return the raw status on their accessor error
paths, inconsistent with the errno convention they otherwise use.
Convert it with pcibios_err_to_errno()

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - update_gpf_port_dvsec(): Also convert the pci_read_config_word()
      failure path. v1 converted only the write path.
    - Drop patch 2/2. On a failed config read the accessor returns ~0,
      which cxl_decode_regblock() already rejects, so
__cxl_find_regblock_instance() already returns -ENODDEV with
map-resource cleared. There's no bug, so the change is dropped.
    - Fix the commit message, the second call site is cxl_ras_unmask(),
      not cxl_setup_parent_dport(), fix a "Convert" typo.
---
 drivers/cxl/core/pci.c | 4 ++--
 drivers/cxl/port.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e4338fd7e01b..bf6d566b2d6b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -838,7 +838,7 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 
 	rc = pci_read_config_word(pdev, dvsec + offset, &ctrl);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (FIELD_GET(base, ctrl) == GPF_TIMEOUT_BASE_MAX &&
 	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
@@ -852,7 +852,7 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 		pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
 			phase, GPF_TIMEOUT_BASE_MAX);
 
-	return rc;
+	return pcibios_err_to_errno(rc);
 }
 
 int cxl_gpf_port_setup(struct cxl_dport *dport)
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 99cf77b6b699..8db4d15e9427 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -92,7 +92,7 @@ static int cxl_ras_unmask(struct cxl_port *port)
 
 	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (cap & PCI_EXP_DEVCTL_URRE) {
 		addr = port->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;

base-commit: ef0c9f75a19532d7675384708fc8621e10850104
-- 
2.43.0

