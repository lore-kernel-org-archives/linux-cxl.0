Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793354405;
	b=eZ/kF/9eLaoMcdenJopUsXgO811N7TfJ+s1YK/lqku+7Chr9r1IpaQ97uJSv/cTjedfR
	 qeRBLFBNxPgN1CNFVRfLwsPql7X1UgbCaMpNMkUPirkhIZhyNUox7fMm5dzFcLhtngCoT
	 aK3yf1m01/6YPTMeiHh//tPEL9wKsa0YigViPNfCx1G/W3StRd7rDBMie63tRdnl3oUnA
	 mYB4OYbC3QEjAh75liAQVzjUw/yKTceqcAVwQlJKHhuviAFHMFFbhwbfJ6fbmcJvXFVoQ
	 j8xGkWoBlJA4uEs92ynkGHcspUAiVHsdIEYwzm+MshOl1aYzggOB1UIcKFPnikycslA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354405;
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
	bh=S+u43rREVrMkVPXu7cEliSxpvRhsHHMQcJYNqncN7iw=;
	b=LIXgbKUlbZEhTDV+lWM3f0yXKm/9F7itjn4ThSKHny4V6W4bfPJJkw8rfPLhsGW3dxyd
	 IMd+4jjr0lMJaTpz5gXNlBJ01QAqayxVkhCCY6evcx1fPjFITtMooB1MY48XcoWB+/f8Y
	 sIZPOsRWBNgSFcwQCelCF+BFsg53k0ptj/NiNVVZMHynz3mMjTdObxohYXLCdKA9X27HX
	 zRffRGj57UM8AipYPbXYug6JPPsBd+j9CbpBOl1VCVKHhzsDhs2aDelXq+p2EH/42XdUW
	 7fJhthvi/v/vR/LXJ0JcfA/lrKI4be29KvlMz4//74Rzed8/+y35rB7+rQidTZudFIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="N/MSxLNv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.39
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E8606A324;
	Fri, 30 Oct 2026 10:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 942E8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=N/MSxLNv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPJu4GLaiCuI6PGcGmsCBlYHxdUhVF1y4n4jBjmu13+G/7WcrIzIO3lyM+8/VGFwlZe4rSMHblJO3wSNnDa8MElrcpR2UTl+NkevKFntjyf6e0cx99zCqHXqQEzYOoqiSAQLQEeTNd82sFpBIHrhzRyqN4CkQF5hOtwDAEZJdbMaaipyPYqIdwoXs/vx9lKR5WrdGuZL94j5h4AanRUfBOeOJVmP1A4iBc9n+VNC2Bzd5T3O+imCbeY0+1hPoNB9v/7jIenr/Nt+xa7VfMHlLadMj8lDa9Rh/JNkDcD85Molf5P+4kHH9GBvPhkU0cMZIVF+7VS57+TFZlAgLta5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+u43rREVrMkVPXu7cEliSxpvRhsHHMQcJYNqncN7iw=;
 b=D9tfrGmV/Dg2Wl8NFXaS8fhCI6UZ6qMqfs5E3U1pEM1H/hEb7AaXoeUsiQQD2gcc3jrVlja9GNACe0Xln5sjWRDMuucEHSGMeQ7brpYePOeIvunGA6Vib5OPz+yBcyXNw4RbFuEUmJjCtQzEeyvsyYXhuOxrbPOEdNCSSXI72DprIr8UO6hXn19aTqM14pIy81tyDtsPln1RzE4qYLtTF04lkXcpnM7sqWZ+7uNZcqbS012wij8Il3x98RwvFqx4Ld9+2B3huMbi5UpjUUElK+hx2VOw4MGPyc26pmLmTYf2Zy3+mLGCwysMw9cT0GSdAmk6UXezsxVwFTbLfXfLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+u43rREVrMkVPXu7cEliSxpvRhsHHMQcJYNqncN7iw=;
 b=N/MSxLNvwjl6bgzIpuUb/UoFhJgs76GKwiE3faG84NvRYJcO2DUadgIyAGYwlxXaZfT/dNZd56s06mTR1JWH72FTCO15G1utMdVBrYlusJgL5QF3WCKUf82GNoH4AyGKGLJan2hKZ9m9SEb483GUotSG0374CM3Lc4DlBlLFSOT+jwZTAFyzoXvzyyZdw03VtlpRTQX4kZpGlFqSObgxv9Dje2t51aQ7Zc3P3Nic+k/avKUGcyn1zEIdZvhnoncSNeyaHd70w9HXVOrCMVGlyzd5VCgpZAJkY8chGk+VwqdRpLx+Jzgw7GLfTIxU2pBGOuXI/PNfLcrPXGG/pNhZ3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 10:00:00 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 10:00:00 +0000
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
Subject: [PATCH] cxl/port: Unmask AER internal errors for VH endpoints
Date: Fri, 30 Oct 2026 17:59:51 +0800
Message-ID: <20261030095951.46080-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To BL0PR12MB2370.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 92442fa0-f9e6-41c4-0378-08df366c8dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|3023799007|261009223027099003|261022075727099003|261021121427099003|10067099003|261021123027099003|261026121527099003|11063799006|56012099006|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info:
	oyUHi1fHgj3QxabeeXYulAr7QGHG7dy1oxJG/3N5Iqv2ytXGnb4VB7h+dLlJoto8QONC7DTLkgR82n6ZhH9ks2oMlRx8qsubUtB5nBbi0YJt/oJuImKO0kmrTtyLiyHoBwcLlQ/WlhcRgLoaiiS2WI9/inRfyD/mSe19268groViTRlQ6zfyWYpxCmAewFZQZ5vv3jYqr38i/Qubra3nJHT76JaoTFu5k69nZ3BXwW3yWlgkn1jGV7zE4puZw36Btt9YQMfhROR4yA2oergooJz6uIS1+pUjvGbYkFx29QDRn8QqbuSGQuqbE8Vo2Kl9pP4lc7yjHm0ht+VJjkey5VPUxYPu+K6bgj5kwknVpg6KmlFZLGpG1tLBVby7TYoV9Co047tiZtXH55Gi5dQkFnmvK/2DLPBndJe0JvULk69U1AQKusu3fmTIutJKafGBTYznmvbhQefo5DKsKTE1y2cqkPwadvRocBp9DpGQIYGj+pwr0LMjfZ/3cGT4VjVzt13cCjWjYJ9J9HaWbMF7A+orfEgllDR2F4A4sFkYLj27Q0HcBxyyiGOiMqDOPmZZiVpH9b00pfIVV21MFQMwOllpaJGUzWlQr4Kr1g10rs7yBCsoWnq/UCuskxyueqBaoMcZBMP9I+yI7ZdvC/+cz3IIS11yWEyagWQvoGXfULk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(3023799007)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(261021123027099003)(261026121527099003)(11063799006)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMWf72IEbhoPZvHMHR1UIRyvuY1Colcqy8RiwD1rKOTEr9eCprlNg97DPxJv?=
 =?us-ascii?Q?waMFxj9kJ/7YzOuhu969fYxkKh75h2vTLdynviOAeXH/KnxxE2SRiOs5Mlu4?=
 =?us-ascii?Q?/FEMPFHv5HLXQ1fyKgF5obWqipow/8Qe7+Qm/0DUHiepAIRUwLz7W5YCWfgU?=
 =?us-ascii?Q?6Qyg5sYljAfFdcNpgznTE0+UahWEbHNKXmUDB3X9T6nG4EjZIlHcvU1SXoGF?=
 =?us-ascii?Q?NyqZ5DcVZZ6wphmyTADPhY4zhy/byoQV5STr0OZAs91zwiqqYp71g+gh+K69?=
 =?us-ascii?Q?jsf5HdeNcKICVA+OP8F2zj12xYyMiUi/POTEiOu3Q8NhfVBHoZrC6UH+ZEqc?=
 =?us-ascii?Q?DDyAoisuN7Hbg0ZQfSIe8hLAMPqZ9SU1aHAxqOpBnC/H22ylqf3e3RQj60SU?=
 =?us-ascii?Q?kdGfc5UgTw1r9UYcGW01i2IwotPb/fHPdeP4LNiYXk7VrEL/IgK2qdA/aQDm?=
 =?us-ascii?Q?zMw0D+zdHkVB0HYw1OdaBQ8rISVLdvF86q8mj9sVy/RY+gF4jhy03Fclifil?=
 =?us-ascii?Q?zNvHJq1aPbGeTQsfAZ2rDSuJJovjdMvRNa4RX2gMHGsoC9Mxoj8w3Hb2Bx+l?=
 =?us-ascii?Q?giM35+2tfocjTbIMqEbuwpK5hnpThMPiZv/qMRbrZtwx3JuxNpIhtFUr9Lhn?=
 =?us-ascii?Q?aj+HnpGmMvRWiuibL5qdBIy8XQ9lLtsSPhn0Y96J5a7t8jPdap9M/HgVv/z0?=
 =?us-ascii?Q?3OtJBX+mcccYZOdMi2HNx+ZMfb5eu2HPAqU0xOAfp5MtiJVX6ZhXd9PADl8a?=
 =?us-ascii?Q?2p/AcMwZ8WZH6ePaCoRShjHHfaXO7Wgvi6vGFWX1GT/rM2gWRk+o+qxz2sKC?=
 =?us-ascii?Q?iVmIgvvIMCo66syklyT3AsJKSYGOxTNYJGYkKCcLec/DiBC2rX75JJq2BGd7?=
 =?us-ascii?Q?8sY+eNo0S1RAc1IC18W3QMf9ZlF2ZrBp0BzCnnZNnrmR5plHEl7kmT5NBCuA?=
 =?us-ascii?Q?SztzyNeSPMaFNzmmb1vqTZGHG1mbsFtBbG6Rx0f1ry1cALsaqWQcpPYZ67iF?=
 =?us-ascii?Q?KpI+6mQdK5/nnZJoB90AwJ5j5HjWCNtnLKWloD+QVwf5mCUpQQUgOheIprzD?=
 =?us-ascii?Q?DRxurcVaskueq1j3RBNoUf8ChB5TIioAk14a+UCAyja4ssyKXDRIXI1+qaaB?=
 =?us-ascii?Q?39Kd9x7yDmQJnM1iljRo3HWeitWm2zj7ief8vQLw2GL4X2i9BXq3U5UbNFcq?=
 =?us-ascii?Q?DH/XhosTIzlPPIlg64Zt2ROngZUGwexi7vuDYUuUbw5PXSLOzdDHfCFNmjej?=
 =?us-ascii?Q?LdgF2uu8N4Uz+oWY1DKTRKUqmN8j15ipP5aXNpD5OQOIGYUEIippFveuShBn?=
 =?us-ascii?Q?8rkAndwshCle4+GymVp2wSyjLUoQLbMtDkywfllounFE1rdHIjizNzlxHjfI?=
 =?us-ascii?Q?tr0VEfFNhZxwJ/oFv13mg2JrqEEnzNL99TU5e4Hr1HwAb8y0rundo6B/cHnR?=
 =?us-ascii?Q?L7ymzM81Nab+MQW2cWoKDeH5BGMrqUzHa4fUZ2kpfGr08OFYYzFIYQKf5Wid?=
 =?us-ascii?Q?/10SvKk5bjDqBH2Z7nuBvOIgNCLjQxb0xhoT0nC+QbQKy8reC2RDdyHBuvNq?=
 =?us-ascii?Q?KYl1cMlxQJDdaCAPtDxYtB4E9PrxNOmW6knrO2MWe/MAE0Hx7YAL6zaFR/EV?=
 =?us-ascii?Q?h1tew3DzPkVnk2PaIPK4ZyxE3AnpAsrd8HoX78+w64jSgbtbjgE9IjNGOYs3?=
 =?us-ascii?Q?72ERZaZu1FMppaSwOKK1Buw/aCbYy1dMYbTJVmrGCRm4O2aBjyQNXP0MNl4K?=
 =?us-ascii?Q?bBdH78wSDg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92442fa0-f9e6-41c4-0378-08df366c8dd9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:59:59.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jylxRzjYR/BudiGvqfAL2lmi6QFGXUovFdiWlmLe7PVaWyzO/cL98TU8zLGSmaSHqAsZ/htju+Dbhjz8Sa/hnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

CXL protocol errors are reported through PCIe AER internal errors.
Unmasking the endpoint's CXL RAS register alone leaves the AER internal
errors masked, thus the notification can't reach the Root Port.

Unmask AER internal errors during native endpoint RAS setup for VH
devices. Allow cxl_port to use pci_aer_unmask_internal_errors() through
its module-restricted export.

Verified with QEMU mem-data-ecc injection: the Root Port AER interrupt
fires, the CXL correctable-error trace is emitted, and the endpoint's
CorrIntErr counter increments.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/port.c     | 7 +++++++
 drivers/pci/pcie/aer.c | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c48216e5078f..c94a310061b0 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -121,6 +121,13 @@ static int cxl_ras_unmask(struct cxl_port *port)
 			orig_val, val);
 	}
 
+	/*
+	 * RCH errors are reported by the RCEC. VH endpoints report CXL
+	 * protocol errors as PCIe AER internal errors.
+	 */
+	if (!is_cxl_restricted(pdev))
+		pci_aer_unmask_internal_errors(pdev);
+
 	return 0;
 }
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index db4f607f889c..94eca22422b7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1287,7 +1287,8 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
  * Internal errors are too device-specific to enable generally, however for CXL
  * their behavior is standardized for conveying CXL protocol errors.
  */
-EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
+EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors,
+			  "cxl_core,cxl_port");
 
 #ifdef CONFIG_CXL_RAS
 bool is_aer_internal_error(struct aer_err_info *info)

base-commit: f0c48323b0402349530abc60ea908b5f5f40c395
-- 
2.43.0

