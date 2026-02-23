Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010036.outbound.protection.outlook.com [52.101.193.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0C286D5E
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856814; cv=fail; b=u/96FPuCC5la/Z19/MmosaLLX27aLsy/q1kEHhWv9YKpgaM8PONwyIyhpM25sILZVWkaM143qieWfQxlHHOnguBIP6av0ZWSupqmjdkdhXBjWjOCHyL/N31z0ilqYF8YbzQYwY9nIcBxgnGWPcHErdI5Kdc7s6NB3BSTvaFJ5eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856814; c=relaxed/simple;
	bh=Nx90BlvPxnoKF1YDk/TmPIgSb82adCfJFD9ZLN+yf3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3+2kaGaFqJtkOL1+Crrk88bsoruahNKrLKL5tSowJCgoaQ9hoaF6x/G0Q0Y94Bu50mnn9icp8HVx3bDUunRjqEV5C2MxNFpKSOh4VVfRAHP+OynSsM4jN0geEz9vCr3nDa/+lYdhDlSgQjtwWlSvNiI3DJBc8KPFSM0kjHEOI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K+B1W1Tg; arc=fail smtp.client-ip=52.101.193.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K+B1W1Tg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGsGZIOXPfixX4v+Ti1/Kr99FcNHDxuXyCCogr2irnpROC4BEg4BWyDqz16Igeo0uvm95d3rAQY8Rb/Patx8elTwJvgdYTRHYtYzFdb90BAjtwXMCYXkUhHqhKS3mv/4yGlZuKupOj+w9ppcyvz5KAlfVRPd7fC3vCqfE5fR73egtLshAoO76ZAaPDgRoDd2hPbRTCcNC3RJ54tVO4kE9yZQ8Bn4aMwgiobcojv225BBIaPeBHIUz7pR68YAkXZOZvkQdJlrvXVxyduipI8u5zCIPLmQYlQ4k96p0lAwYgXKawe+36ErPaMdXgUgNQuhHTWrHaz82Fn6MJMRo1CMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZwbK8IpDcAYA07QxmEmoji57hWSHiYKaeoc027d31M=;
 b=RHIPL/14DiUru53w9wKbDL/r+8MoaYLm0u1ANce53wxRc2IzLeyl43RSOq9BaaPO1m6jboXnJXLsE/SZzVuNnvsmfAXwfmr6B9VbPcmd8mrGOTzQh9y0VnUYJ9QJBqcrnZSJ3rUdspUgrPkKMoYm2jfUF21Hh5gpiiTLp6ukiNN43IOqtcnC95mHXo+qXGAC57MUILXQhPr9XZSGDr87ndN1BrlJIyrSuVe1z2Ns4HklAlWByxC6BEyBxRIli7LdA36Azp7tb4b4ACHpEESU+UHd9rTKtCtLxtfP1XAln4Ll5nTxoLlVQbkjFlXrDUxtqkFbp6Bx/p8o6DoS4xPg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZwbK8IpDcAYA07QxmEmoji57hWSHiYKaeoc027d31M=;
 b=K+B1W1TgNTohgC1uVTxIFRrrzOBfGqAfzBvzoyy/EVhOh1cmoo5Ia+dg56KXN8NLAwzromBV+DOVLJcoZ4qslhdwpLMQG0C/IhrfAM835M4Qp+ytdN62cy5xNg2Rt6/w7Dk6e0uWQegh+3J1Wvjrq3JIhgbsFCxfzjoPZ5tSMg4=
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by IA0PR12MB8908.namprd12.prod.outlook.com (2603:10b6:208:48a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 14:26:47 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::9f) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 14:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 14:26:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Feb
 2026 08:26:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Feb
 2026 08:26:45 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Feb 2026 08:26:44 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 3/3] cxl: Move pci generic code
Date: Mon, 23 Feb 2026 14:26:33 +0000
Message-ID: <20260223142633.2994082-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
References: <20260223142633.2994082-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|IA0PR12MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: 7857fade-22ec-4006-45d0-08de72e79360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MSPu5XSsODYhTBCgbTCtB3rSVs9qcqQ6bKit5BOIBRMmp3Nnz9X0DvbRpM54?=
 =?us-ascii?Q?zeDjDR9Zeu4ae1tEsiu4GXAI4bMY1DeTbkSTBewG+J8rpP1RtG9ok1dmA8ta?=
 =?us-ascii?Q?M4ST1RQU4ty4GfZJoW58SXjhbiprcLqRdyXbhxieSelffySoAGmpmXImAfvO?=
 =?us-ascii?Q?/Wf6E34X0+9jJRxAec3v46yjYSRQNOhG/5rZy+kIUZGGxuxA5bL670JZPGUq?=
 =?us-ascii?Q?0G8oeThXQ+0SoR3nezGiTQ11qKZftHKtesewXk9Y9BYiBQc+CKGETPLBfRJ2?=
 =?us-ascii?Q?sCcyDN4qLzFWD9GTtmuOodDiSvHvFfIkWs/oMM3pxwSkhgiQ0siBD0eMHlkV?=
 =?us-ascii?Q?J8ETnzHLSYmDEJ36uhbNc1GMB/5tNW0fA2ZltcykAfgyRHZHDq4Nxe40QPWd?=
 =?us-ascii?Q?/1pxpEq1LvyXj/uOUTqRi8Nh1kbsvjSevqgXdszN36+iC+M1u+oG35FkA8AA?=
 =?us-ascii?Q?c67ONzJphVaLp3RIlClAkUV+SFzalITfjoNqKrP22XXOrG6eTU7JNqJjf/SO?=
 =?us-ascii?Q?ez80o/WV66mCs0zPQmk2PdnvU7zzroiGspgAdZPmu4tdGYmBTBjPHl30gLh/?=
 =?us-ascii?Q?Bg1AirFgjZgcWOmGZ9+H5+DeZCkAVAB6OnVRaIrRC/Mb6wUC1genSx+5CzcW?=
 =?us-ascii?Q?uRa2USGoLIpv/ph0OPA9ylhGhLrQXAtZHLCSN/Qgj+0l6qmSXJfLYpQe3YXM?=
 =?us-ascii?Q?LAOUYkeTInOSDE9ddVGqvyORln2VyC8u4Dbbvh9SbGObKJCXX0s56Uhl0KKs?=
 =?us-ascii?Q?ctpud9Dw8+uJ9BSStZ3eH/WlmXOx0Ou6kXblwjvpab4fBKipilW1iLbxj+hI?=
 =?us-ascii?Q?F2BwrdXIICSegpOCCXrFOYvVPhO90TRyfvoc4Ifrht7MCVyVtZ3Dc18PHomC?=
 =?us-ascii?Q?+gQSVZh6huKPB6odKKwf1cbBQXa2PDfB82DHLA1PmLC7qr+c9mjoY3f1uYWY?=
 =?us-ascii?Q?KWXXSOC/5HdpLYr+7ltT+ULPs7i24mTS5qeWlJmFcZAjQN24qH/pk0HJSrfe?=
 =?us-ascii?Q?5MCwZ0Pc3sfAe5Yobq1fHQoqrsE2QXmSuWLlMfJqr+c18mWl6hJwRVU/nbzG?=
 =?us-ascii?Q?eSfFT6tKcohHugYPMwSmV9ej/Nc5fzL6CUJT2NZ+SUS0LIq8yIDtHoio8BLo?=
 =?us-ascii?Q?q1bYrB9TC2iV7rIg45kPvYCs/bN+pfinI+bOgaObh+xfQT81DrIgkb4SSEO9?=
 =?us-ascii?Q?y+VD6rj/pt9rzgX4IEB3LNjEVd7JClSeoSCr2qi8eE05Q1b2zsFRNEE23v9C?=
 =?us-ascii?Q?0dl4qh5Uv24Ap4Wy5ELDls+qAeSxQ1jBkT5SgJ1Vy4g6m82N1L6su6PuVzgV?=
 =?us-ascii?Q?ZX86aTDkd5tTVrihapdDhOVfDHLMlX8tTYC78sdbdFMHc3jabuzTB8j8aaeq?=
 =?us-ascii?Q?zkXHYShp0OHl2C7zPD/Ec2cKLxg6puBA11ph90rAUABHQPxgRQNL4buAig93?=
 =?us-ascii?Q?0u+iesOf5oMbeKRoLrs6JLp7c/0KqG+NlzKvesX1wNhVjpAhjqlX9b0X4nJP?=
 =?us-ascii?Q?75gnQQ6+Ge4895R61LIXOTurZP1iKe00b2eFJSHtOgkbjiCr4O82FnkQ3+55?=
 =?us-ascii?Q?Vti5k6v9o04OucFsTDSP49/jSnX8Qcuw3SwAuRQqhuis+lVnRPsTUGknVPH+?=
 =?us-ascii?Q?xghOqByagh/TfmQkTiOSZRe6hDfe19uoWar3RTjCGVOiLJWJTZU1XisFPEZV?=
 =?us-ascii?Q?zan7Yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WSP94LfWLQcaqcQBddlewk9Yee93k/p8krNOG1LQYTaZOV99IS4sMLen5rXuDdHeoLDOTYKk/9hhHtTTmnL2oClSwkHYvH1N3+BqhvaxkPZwbgp1cLQua7np2REY/DDH8a3bZr63gl2gniWmD5/bYlbqIVK24L+teS5AkDQ8D5IUh4rj35ijBAl/rraazkJfgSn4Fr9tA5na5ORgAqvjEolkBwDlF9c5yYQ1HRcF5MGWeLr3IPe5j3sW7AB9SPfchgJ4ijd8STsh8WI0ewfWzlW0pULc41pyXVPutCgTJYo/wuj5wZXzWGJLI2vCFHlh5qIOvojVOWOyF7ltnOOo+WaZ0Kp61/VOGh6ojytYiRfnDJKGO4a6GvbBpS7RDTd28BAL/3jcsxTPSHqdUc4ys3vOGBQe7O9IpxCwAa5hlUlAVmjSBHDL1qqtf+fbM44L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:26:46.7415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7857fade-22ec-4006-45d0-08de72e79360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8908

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci_drv.c implements the functionality for a Type3 device
initialization.

In preparation for type2 support, move helper functions from cxl/pci.c to
cxl/core/pci.c in order to be exported and used by type2 drivers.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/core.h |  2 ++
 drivers/cxl/core/pci.c  | 62 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 -
 drivers/cxl/cxl.h       |  2 --
 drivers/cxl/cxlpci.h    | 13 ++++++++
 drivers/cxl/pci.c       | 70 -----------------------------------------
 6 files changed, 77 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 007b8aff0238..19494a8615d3 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -206,4 +206,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u16 *return_code);
 #endif
 
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f96ce884a213..c32cc62c501d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -696,6 +696,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
 
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  struct cxl_register_map *map,
+				  struct cxl_dport *dport)
+{
+	resource_size_t component_reg_phys;
+
+	*map = (struct cxl_register_map) {
+		.host = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	map->resource = component_reg_phys;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map)
+{
+	int rc;
+
+	rc = cxl_find_regblock(pdev, type, map);
+
+	/*
+	 * If the Register Locator DVSEC does not exist, check if it
+	 * is an RCH and try to extract the Component Registers from
+	 * an RCRB.
+	 */
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) =
+			cxl_pci_find_port(pdev, &dport);
+		if (!port)
+			return -EPROBE_DEFER;
+
+		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
+		if (rc)
+			return rc;
+
+		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
+		if (rc)
+			return rc;
+
+	} else if (rc) {
+		return rc;
+	}
+
+	return cxl_setup_regs(map);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index a010b3214342..93710cf4f0a6 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0d350b69f1c8..031846eab02c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
-resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
-					   struct cxl_dport *dport);
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0cf64218aa16..b826eb53cf7b 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
 }
 
+/*
+ * Assume that the caller has already validated that @pdev has CXL
+ * capabilities, any RCiEP with CXL capabilities is treated as a
+ * Restricted CXL Device (RCD) and finds upstream port and endpoint
+ * registers in a Root Complex Register Block (RCRB).
+ */
+static inline bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+
 struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
@@ -101,4 +112,6 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 #endif
 
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index a42f273ff72b..adc7c4bcb03a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -465,76 +465,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	return 0;
 }
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-static bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-
-static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
-				  struct cxl_register_map *map,
-				  struct cxl_dport *dport)
-{
-	resource_size_t component_reg_phys;
-
-	*map = (struct cxl_register_map) {
-		.host = &pdev->dev,
-		.resource = CXL_RESOURCE_NONE,
-	};
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
-	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return -ENXIO;
-
-	map->resource = component_reg_phys;
-	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
-	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
-
-	return 0;
-}
-
-static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
-{
-	int rc;
-
-	rc = cxl_find_regblock(pdev, type, map);
-
-	/*
-	 * If the Register Locator DVSEC does not exist, check if it
-	 * is an RCH and try to extract the Component Registers from
-	 * an RCRB.
-	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
-		struct cxl_dport *dport;
-		struct cxl_port *port __free(put_cxl_port) =
-			cxl_pci_find_port(pdev, &dport);
-		if (!port)
-			return -EPROBE_DEFER;
-
-		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
-		if (rc)
-			return rc;
-
-		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
-		if (rc)
-			return rc;
-
-	} else if (rc) {
-		return rc;
-	}
-
-	return cxl_setup_regs(map);
-}
-
 static void free_event_buf(void *buf)
 {
 	kvfree(buf);
-- 
2.34.1

