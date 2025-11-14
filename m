Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4C21D3EA;
	Fri, 14 Nov 2025 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080037; cv=fail; b=CjLUT5jKZC+qguC5Vz95+eKG2IfL260vVEXoZR7ASWdJ0UegUHEhucYyhIOOAqcZ4kqkh7BdHKcgyG4uR9ZO4uWk0I+t44KV96MMb5MNODP4nCy4n0E538uPPyYlzsEkpSRcFIgWRwdXmiA1nzg26MoFWRi5wZLeHdgjMBFxmo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080037; c=relaxed/simple;
	bh=PDKTvTvCBFECUgIrHqVAB8OlQ7BYiZ/cV9+GWP8oRB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jl6Mo2+EACPq1seMK5WKkGBQ3Imw1XfNDku0pCahqacoaBHReVlymrww+ZHCQHIAu6h1vS0azvZfsYcqBkEmWdfmT/wcqXy1xxuzjrZlIA5mpIpMajvfLYOC9dJwIKTdsrF7BTZZT91GcW4kFaAPNpH8bmT5iFhv2/wVrVMj8/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0f9GBu4e; arc=fail smtp.client-ip=40.93.195.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0f9GBu4e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSpjAMBDbUGDOPkiRoaxz+xgCiBomtF1GJE618jVtd/GqYzatgplp/gWL0Dps/rFXwdjAAU50usAs8fSZh4K8M+aKGWiw281cp5ELNeetzTteFLtvWXdTGVgsdqw2vyVAmtHmbTVhrLHqE9SA9AH/d+77Yi4dy+intV9Ds95MiiKB8uyiI6z2Gs3uARnzcItnvZMgapQkp8zLcC/2664D7FpSipNblwYJHkkxoswkrvYnvNyxeyUBrko/98wQnoXLifQtHbIp/1T1YgBYwYztceS8Hg87K12N2Vj0qr7OlTrLwFm0S56pu9MNYPy5U/DT0eLPUwMQcl9uAIgPkGGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7YjhxisUyINIEIMGA3R8nL9MOC8tdnfrtPYcdW7Dgk=;
 b=rrSkMW8C1N2l0Z1kTHqREmegPzrcD4poylh0teYJnp8hzggUs8F+v9h3ApIED3FszHr0gUrl4PBUu5pJG3n/uEbum50a49OgryP85L6RwM5dSB0G0+VugM3Z2nFmDU7HknzWDpNNhG7A591D+klMvaCl32YynAxNf0gQvtPfvZt7L6LxYATlQsApVFvL6KwAgK2BuvAxlxH6rLUxxIsn9nykOUvz/SGW1uyntBQ386wCWiiwuCc0gFHDW6pag8bvb9IdpkNEusHv4H/t0rVMiVb9XCal1W93ETskvmGaeIKr+Z2KGh8sjWIr/uRrXbvqDQOnLN3aMqS2rLLpFQrzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7YjhxisUyINIEIMGA3R8nL9MOC8tdnfrtPYcdW7Dgk=;
 b=0f9GBu4eQpchW7i9868+BUhGSUm1686Z6lRIm1NcTFUrcWEK0SYdg5WDw0rokFy77Xt6KiAqhDFUtx7poqbCry67DaZNEyQ6a7+2nZpcb0r60Uh2CeXK3OFHg0llHnx6MhSqSF5YZLozCH0WWHoJ0plktzt485Vknyb/i0KPpqY=
Received: from SN1PR12CA0078.namprd12.prod.outlook.com (2603:10b6:802:20::49)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 00:27:08 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::38) by SN1PR12CA0078.outlook.office365.com
 (2603:10b6:802:20::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:27:08 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:26:59 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 2/3] cxl/acpi: Group xor arithmetric setup code in a single block
Date: Fri, 14 Nov 2025 01:26:29 +0100
Message-ID: <20251114002632.1309139-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114002632.1309139-1-rrichter@amd.com>
References: <20251114002632.1309139-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: f50e7252-a9b4-4dcd-426e-08de23148c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qoHL3ni7/V7l7C9ArshBC+XAKVIjw1nzAYRB6hofb6yLu6e+FrHbLQuF3hJF?=
 =?us-ascii?Q?T1P37w5ViORotDSMuvYpSUDvkPaUvH9Boq5WgnxFj69KUFA9yNYKNLPxdgjK?=
 =?us-ascii?Q?yx/yIl5cHhzz3l5xKr4e9FsU2DAPN657p1yvt5KeyS2du8/DBznUpgiKSKqA?=
 =?us-ascii?Q?CxYgFcSOPplk05Etie48RLfhtRravZW0vuA02h5Lo1/+GTwjlWX5v14EdtnC?=
 =?us-ascii?Q?p228YYFVb/iYAY9EXnEpfPoR821+ZOLIoleUmy7HyYh5baPesT8gMrbPN6sT?=
 =?us-ascii?Q?4TUPr3ftYjZ022B2fiGJbX8GFSrXOj1Rqu2GVr7q7QomrRl05zs1dVMU/lA5?=
 =?us-ascii?Q?Jn5ng0Vf/S0zyzHzSbgGxQmes7a+mrBkfNg9BuT06Iw5/xT4tnYKR4YTlPoP?=
 =?us-ascii?Q?iQTHQKO5Neh8IiRNMgmbU9kUKoh/L0EcJiB6Stnr36661dF1naxeEhuHD8YU?=
 =?us-ascii?Q?DQoYquDtsR7QyuDshFsa0PN+PGU0qqXYYSdgOcNLy402VTEintGwEdzb+v35?=
 =?us-ascii?Q?X4DnPIw82UKzWV9Y186TiEs0JhPpBatiF3ShfJHvSomy4/CS/G4Z2na0fdxb?=
 =?us-ascii?Q?J15Hz6XdlujXIIN8KCO3XfSwgbfut54iBCOERCPBDfcodDc0UVuEFKa496A/?=
 =?us-ascii?Q?kVkwn17aH2bIJMxQZtiyLlogwReaMNOrApPYjJQrOEPsJoMzpGzkpgjWglEA?=
 =?us-ascii?Q?CFY/a+VB28LorOnQXcDioAg4XJ7fmC0QXJ/+kHEKGcVGpLoaw7fcbTF5zN0n?=
 =?us-ascii?Q?GSOfCM2tewP7Q8HxH2dzJ9liXtm5edqICqs/PHSfzhaJ6yo8l8BX+u9lVTO3?=
 =?us-ascii?Q?v7c0TLT8jfjQUu/BdI/o0fidtNAcRMAf6H+HhfQdYtDIMDuQ8nod4pV6Vt1n?=
 =?us-ascii?Q?EvPcuzs6hcGQBVzkav0mXmPi/H3bJec5pRh3DVY8HL5b9JGYsyBbjFju3glF?=
 =?us-ascii?Q?JAww25DDrce9p7gTallTS+laUlNbQYE9ldrn+cueiba4pyXcBvyxPKm/+Oz5?=
 =?us-ascii?Q?4QcRaNVQKWoV9gZZG8Iy44r6ggz1EY8B1V8axZEsVjHWTV12m4nAPGWMkeR6?=
 =?us-ascii?Q?2Jziw72kKCQxYr81GVgkqPD4aqmb/fSsK01BDKrONUwiHtLi6VIaUStfeKtT?=
 =?us-ascii?Q?h6c0qtmJ6oZXKf5zSmhjlklsHKyIR1Ise0LgflAy5Rqp1nb1g6uO8wqJfqUE?=
 =?us-ascii?Q?r/JXrkBq5+3l9KhiGugJWgQLL0ZhJI+vtMZmXwvkNbEBxiTXzdj2RIAt+7jy?=
 =?us-ascii?Q?a09X9MOp3p3oDBNdhLOutKbtcJrfAu6rh2Cf6HB3rY1uWtdwVTAepaUYZkUl?=
 =?us-ascii?Q?E3EHeY/8ypi22TDG/KvDlnScu97aeoqWeciLhm4abvzOXp6EK0cxjqd/+CKz?=
 =?us-ascii?Q?ogqGSm9idnv7k4iFn6omjruUsPVK+wUJ6OQLr7/QDFDHNGENKfcWsEdiNJwc?=
 =?us-ascii?Q?yWKfBVw77F7gsdmHloHIQvNf3tV1mbwrO8bGotbatm/oDam0Coq3qaBcLxJR?=
 =?us-ascii?Q?HGT03mWxqpAau7y9VxpP0IkG4mSffhosFPKsLBv/ruqunZEdsP1qkX/L088O?=
 =?us-ascii?Q?9ao6eDCcgEav4JNvk1A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:27:08.7777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f50e7252-a9b4-4dcd-426e-08de23148c01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042

Simplify the xor arithmetric setup code by grouping it in a single
block. No need to split the block for QoS setup.

It is safe to reorder the call of cxl_setup_extended_linear_cache()
because there are no dependencies.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v2: spell fix in descripton (Jonathan),
---
---
 drivers/cxl/acpi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cef3e07244fd..0a1bad3cafa7 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -453,8 +453,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		ig = CXL_DECODER_MIN_GRANULARITY;
 	cxld->interleave_granularity = ig;
 
-	cxl_setup_extended_linear_cache(cxlrd);
-
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		if (ways != 1 && ways != 3) {
 			cxims_ctx = (struct cxl_cxims_context) {
@@ -470,15 +468,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 				return -EINVAL;
 			}
 		}
-	}
-
-	cxlrd->qos_class = cfmws->qtg_id;
-
-	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		cxlrd->ops.hpa_to_spa = cxl_apply_xor_maps;
 		cxlrd->ops.spa_to_hpa = cxl_apply_xor_maps;
 	}
 
+	cxl_setup_extended_linear_cache(cxlrd);
+
+	cxlrd->qos_class = cfmws->qtg_id;
+
 	rc = cxl_decoder_add(cxld);
 	if (rc)
 		return rc;
-- 
2.47.3

