Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692D1DE8AE;
	Sun,  7 Jun 2026 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780815783; cv=fail; b=gLwv+qSjHn1ia4kNaf8cYwDJWK5k5ssf2zPEmDQnZojySvpT55LO/hViEmTZZogy5Ab5+dZrW6FJT6voNXN67cGZ9Q3fh+/EsC5HNE8P8ttsojnb7AZgISWQDRVrKigE09sdvmWM6EVnFZiB0I3GPlq8jUG10nYK5FXcVa4Vsno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780815783; c=relaxed/simple;
	bh=ct8Uj5UZYKYCpZp2WQpAFT0gvc3I2FieZ+QxwIGykPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BFs6Wp37uqK0cUu23JixPHqCrbDsaH3kl47gaSa6XVRoB2DUjaMXkxjXFFKkQyofwpzF9WItIptVXrW/+1HCTpk5pTeoeKQikfWU7psSZPQ9rnG6nHBhDZPWZ3eBrHtS8gcNh8sqN0wJkrphtQRt0+ScsYTd1lwYsTIBwVKsL6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0H59RSV; arc=fail smtp.client-ip=52.101.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0H59RSV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5VK/+PUqOeaShPLq1VmsblJm+3sjiC0NweVyDkipp1ioxs04+h2EREmT7QITwJJaWLtdp8BNdHZh+o33MZS6od20cLvNfdfUI9XV9eJHr3XT+NR/sQOBffM4z7UIN/lz26XPLe/1KoM1WXD1kQQtsmGf2ZDc9WRSWYzRRqS2PQz9DgUkb//1skgfmGYhXmVsnF7Rpr34rMSowtGAli+padW0l7Fus2itFk4DCtvy1RE+1QFhApkCb3hTS6N9kAq9aZq24NOTtVUBBwV4hJCgUUl6cp9acT3HH5l2fP+gijX8XHFXyQzTpEJJow+4LSwUGIPfLDIHbVP8qXk+MnrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDyeNGCiUwUKB5p8vIR6VyT05jVDQ8v3iwXaXZRfxNs=;
 b=QK/N4987Dw68WFeK+F9RY2t//Ykb/DDf1O0Tu/dt3zc88jUdSLYPbZ2urCuorrVhBUXGDnqRr/j06nbF7U53xQZQVnSMgVXASWw2NTpq7CvZx1uuIcy+MQ6eQ+KJhDNRL0hNGlnRUAcTS+wc24V2aN4QwszdV+VItcUrLCiy8+DDX+6ffdbxe9LKWOiao/xw0icLiAeje1YNBm5Tp777rg8yR1MQ0q3qjmLIey2fR0gRhTZri0sp3yvDrWZ6S5Gt40d0DAKJ6zooIyMa1kPA34OZl4GFnEqD7koSF8Ip4m0f9KfVwJ0Am41iFQARIse8GrJdvRBTHodQ6V0dPQPg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDyeNGCiUwUKB5p8vIR6VyT05jVDQ8v3iwXaXZRfxNs=;
 b=C0H59RSVefe8umAxrocD45fHu4dMtvc6gKvSOJ4KcEYM4Eok6+DiDtgs2X8UpdqXmNhJKqgJA0dmJMItriSwIITbIcfbJOkRHPeTrPyJX890g2lJmBXF68EnRkDfTSxnWr0wsXZxES3KMatBp5I6ARSN7hMAbhxNbhQx7YhWAg1mOepjxKSDqzhZ5LzRA+76jyGRceYNxiqk0nL+yDUzBpte2GT37gnxaJ+DpRGJYiPPE8Fna1trt1/+VPH4qtgYncWjUrc0zkkD56Y4MpvVCPSpvYEokadyAzuqgYZF12Z/SLtovmQ4SRnmvxOcTaSgHbGSw111w8JqVopOjF5cCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 07:02:58 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 07:02:58 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Cc: terry.bowman@amd.com,
	gourry@gourry.net,
	ming.li@zohomail.com,
	alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	smadhavan@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH 1/2] cxl: Convert PCIBIOS errors to errno on remaining DVSEC/PCIe accesses
Date: Sun,  7 Jun 2026 15:02:40 +0800
Message-ID: <20260607070241.48978-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607070241.48978-1-icheng@nvidia.com>
References: <20260607070241.48978-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df32e84-4164-4c10-66ab-08dec462ce74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	37b5gpA8x5qPuTXzqz1sCw3O/YT7MEiPlSqn/eMW4GP4ZP1Vnn/IIlnr8r+m98ShbdFWy5qKWQXI46vadHXptmE1dMBK1qd01atB13orpItaAQt5cg9PiFsHdpifOf0PJJ3/0GIVcKLMeN1dreMN3s8nvOxyCEgg/TY5LlpIqQqkVuehFuMx/Da7p0eV+HHTMAgEPEvZQ3YLfohFleFSXEFH/sHmhksvAP6/9L/sCNeMVhgTxa6JpmoeSvmtEpiUhRXrPS9qP0o8mTbeGEYw9iT0GgUyVlqeMJQmGOaotnGMNkI2TzXy3rgyWYUCa9FjofQ8qFSUh5oonP6nC6FxWcM9DGMtlzOONEmDvWyJUEP4JW6yHogUjVCKzWvaJjZww0l1+eq6yd+T3ANqhCe7Scpr1JOQiq0cbUBCcI6cggbfqHHWGXPqzC14T7rELMJoDumFwFLmu1fUlhXbOqm8O10E5Wox5uktI2z4hZuvVZGhfsALpFo71mukxpKvUt+mOeC/xjkd9q8um3G8tWwwIfz7sWmuW1gzP3912xaKkvTq9sZYp4I/daaPDZWyxbJplGold85ytexUEAVLKgxZQl5AJjKKORqd4s4R0M5vLDl22kPKcitXTzgFYSbyruiSM908l9WnYQ+KoVhKGtQXOqwZK+/l/fH+5KO0sLRKFCIkFJrJ/YWwkvAs6acJz4NO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JmxSqMc2Y+oGn47Plfi1uiztMbPTQily6uCnaEEpLRpXuX7we8RQCnFxWe9t?=
 =?us-ascii?Q?4bCyZxiCFsy4jFVbWjEKEijXSg8y+3NC/31GWr7DvfiwhFnpT5WRt5/XkQS1?=
 =?us-ascii?Q?NFX964hyLBg5unBndJUtMBnOPX7k+szZUFYkhGSsAKLDTbIiC+Gop2MzsCEs?=
 =?us-ascii?Q?OsxtVnNhT4u+T6w6sdR3+6E2nvPYRJimUEuhP7hOwg2ic82+O0WUaeMULr1Z?=
 =?us-ascii?Q?uAcXj3u/MordVkQJ7qXUTjMuxqB2zkb0D0GFFrDcqOpSFR1RFHYYcDOp0cx6?=
 =?us-ascii?Q?xxNlEbkpfZMA2YmXjKOAmSpDMuTHWf6NjOH/VYV7V6Evxic/0hZRpXpvy90O?=
 =?us-ascii?Q?Qkziu9piKD8nDEb+dlHMM5/8RZCUOAzAJNeLMqGja57UVgT+MrR8z2rHDJ0i?=
 =?us-ascii?Q?ID2n+r/6J7+QBERmxD1C3Yxuo+yz/CqWfra/i+ccYcCW4jSb9IJ1Pv4sXmdU?=
 =?us-ascii?Q?OBq7oAfZde6jZpUgudknuMnL6r34DV2E+/xRlnkYncObdECUsseHTUN2o9SP?=
 =?us-ascii?Q?ZRXSXeVuRJiUdC2wDF0nxOQhKOgLiZjMi9owO2a7Jqt+waSHeceJmz2w63Tw?=
 =?us-ascii?Q?fWVZCis1KIEqXHBugPiYtmLxzpN9lxcxsH03+y6i8cl4Wna6Opf7+bNe8T4T?=
 =?us-ascii?Q?qLGygDE0P/XMV2RJ8lNhDXXQyBtXfeCnoc/rMkZ4xkRX3tY4kFZL/ENm+wzJ?=
 =?us-ascii?Q?rsrURq1h6rdLtpBcysGGLt5faCJ6IOmYVm3xw2Y/IABFazyn59K32Sqwm1ks?=
 =?us-ascii?Q?HF3pSeeZV31rVl2WVcbbtqcAm3bcsCmE6ugEcqkiDd0Cjl3G2P5Qws0yTJsx?=
 =?us-ascii?Q?kGPFvLmqFtjXTRA45YXrbn6IwEd2XDRFaTF+Z+YYtFMeyt+HKUFVSBAGlWJ2?=
 =?us-ascii?Q?nNK9deQfiKd5U0j+dt72zq/ZXC0wZm0wDYosXAitnFcXunzRe4kO1NVucES4?=
 =?us-ascii?Q?XOUqRr6z/JQAOgMvRNmJwO4ximI0hR4HXzsjBdao44nSVQn7o0fRx7kTn4We?=
 =?us-ascii?Q?S0fKIrVabS2Mv8smNqR9+rxbtF509Mxuy/1XjeMOzEonDybFY6ap4/ID4gcl?=
 =?us-ascii?Q?pRnDcZqC+NtTY2CDATQCVRaUArzGaDSeA9psGXw1+Lmu+mETXQvUG7JuZNpM?=
 =?us-ascii?Q?0yUFtnI/7zQ47m3OqiNLSxhmnmJXnwZAdplsVY1LKRrlZ5ExBpew7NcVM8AK?=
 =?us-ascii?Q?Ib1sk6AEfrvqSI17Fz2m12xqW7Chdaa3iZMkvFLSib6GkL6StC5nJNbz70WR?=
 =?us-ascii?Q?WAPTVEhJnHETDagZJbUxhNQNBKX0ZNgXSGx1Awac91Mkt6HlO5R1xQIo7KEn?=
 =?us-ascii?Q?zdz7OM8KVovI8SoHKL2ktOtI/rVqvgjU90yoTR/NjKO2QPYLHjBZTtdXHD5L?=
 =?us-ascii?Q?k7ry8NdXopmrGFh5jmr9MMKoAkxb2A39pvamh9bJTcNfZaJsBVaG0YReUvxo?=
 =?us-ascii?Q?aPFUQPUqRteV5pyZj9pqRrpOa+QHfSC7Z9IyyfYKkSE0c55td/d3Swd9zhIt?=
 =?us-ascii?Q?uatU3nwTDFAjCW6JH9M0RoE6GK5g9bIY6Ygd36xk0zo0TtKxzvM1joorbvoZ?=
 =?us-ascii?Q?bd/k4l6JKZkaMBBI8GJ1XD6SFaNuxJNi2mz5sTUg1eHNi22hBjhjDjXXez2S?=
 =?us-ascii?Q?sXIh13a6tdvgvfhuPVbpCz/QDn3WgVIaXyoETt0kUbdX/Qi/hn+/g4nlFl+S?=
 =?us-ascii?Q?N+u5jjJ8xFp+aU92e/GxIPVfvaQIftyNCLVvF2+2uVKVi7pIMIiuxXp5QeXe?=
 =?us-ascii?Q?waYZeQSJPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df32e84-4164-4c10-66ab-08dec462ce74
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 07:02:58.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mp1kvW9Imn/MOGnp886wnBAw6KsuTNgziXqVJ6BL4nQqkTTnAMq3XqoeMD7Hs9P4GALkOaIz9salPF3eALPz1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

PCI config and PCIe capability accessors return positive PCIBIOS_*
status codes on failure, not negative errnos. update_gpf_port_dvsec()
and cxl_setup_parent_dport() propagate these raw values to callers that
test for failure with "if (rc)" and expect a negative errno, which can
misreport the error.

Conver the positive PCIBIOS status with pcibios_err_to_errno() on these
error paths.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/pci.c | 2 +-
 drivers/cxl/port.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e4338fd7e01b..ea81a170132f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -852,7 +852,7 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
 		pci_dbg(pdev, "Port GPF phase %d timeout: %d0 secs\n",
 			phase, GPF_TIMEOUT_BASE_MAX);
 
-	return rc;
+	return pcibios_err_to_errno(rc);
 }
 
 int cxl_gpf_port_setup(struct cxl_dport *dport)
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ada51948d52f..dc3029efb087 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -92,7 +92,7 @@ static int cxl_ras_unmask(struct cxl_port *port)
 
 	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (cap & PCI_EXP_DEVCTL_URRE) {
 		addr = port->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
-- 
2.43.0

