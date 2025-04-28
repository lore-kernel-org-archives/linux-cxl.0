Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70275215180;
	Mon, 28 Apr 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876675; cv=fail; b=e8In4Cewke12oyGDtT7RVrn+aqSWMkCiW8ggzfpXRm6ui1uOpR3+LatOaCkaZyyCuatmBZyiL0MgOUirhnIg3klJY8dzC34hN6Sf+Uo++/3pP/le4fzanLCGURknZUoCqK7enOyec+Ri27wlKJZMnv3fFBcMwjF3SJkvyFzvwGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876675; c=relaxed/simple;
	bh=YAIuaIHC+eZnIeZOcmlAMXekZv1hF8IDJg84RvYkDaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gB0qa0zRhHNA2kROyZUaHNDR2j25QUREvkATpBDjHQE/i+hi1uJiuaiZQqcwtSVp4yv9DMIj2v20c1SfJocbBFZsYrOfCIsW3eGYRCnmWN4UjuaOmCKhmMQf+WwU4L/wSUOqjc8zLaLiEyTs5iMi/L6PfUE/pCd1b9j+xFaT5Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KT5saur2; arc=fail smtp.client-ip=40.107.92.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KT5saur2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4DnqtjiDkJhLK6oXsTBGsZg2nC71gr7dMjtOFxtP4O5GLbh4cX9ZxA2FDKFAEU7RNnukJBrICFSaah+EiRBn0Rl5NwMkBidt1wtK6IjiqcilIaf7a5OtyWqe7093FlM1XjZwk2je9mmcRwmY0xVJmtotV63wZQS0a5H1H+hNK+zGVlxTUX8dZPe+EeFwtfRAWzA64q3cu0jof+o4X8rjaxSgLjFqBtjpVzfbr8WvYBz6mDOBOzqWf/4JOfZsP8Rw5LKwzRiaidj9grO6AOISS9xv19GPqXtcjWUHetWkaGkbaCp0zO1iYYYw7pVyJjS0fHnHslGQDwE4uSpm8tbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLcK/3lt3qYGPt2ywuHFeZ5UvHGiNxWomEj2NJbyaDE=;
 b=H+s7ZaumgeiIJ/8iSle5DRfsqPWeWI+ofeDxXlvcfa6J6Pki3ZxqIBtbhN6YPamcwuV9x2/h/Eew0S8AbesKqw+LkTtUUWKi99ixJumIXflUWY1igHHVkXckolVaE6bcUxfU0iyKr58tFqJUz3m6b3EdaykJ9iQiJ6rzr3wo5+b5zL5jzte5CjG+ERm5pMN/tGQQTIMmjSxDXDcQ2Ht7IFBCZ60IVqW4pDfFh1pSyJmPro/OecUCpg2yRt8/4msf2fGKIka+pknaJoDaRXIYmFlPWzuM/qkko+jZSHP6diUjrnx2JOSImFzC8tX1DWiFLuKeQ28KF6GnuX6OFL3y5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLcK/3lt3qYGPt2ywuHFeZ5UvHGiNxWomEj2NJbyaDE=;
 b=KT5saur2hYbFM6Al9LQ/i+IvcYMXZUBUDMlpNpFKl0qdIuWCSmJicYOIOUAJe6L9h3dS8Owsc7Z4mFOXjoPC5YtBKuOYK+S8lcaBM3k9Ha/Nc/tv8j2cpVGA5cDm/PkP0VRS8bwo7jQVajQfm9odNpax/9ASzg8kKowivp1+ERs=
Received: from BYAPR05CA0075.namprd05.prod.outlook.com (2603:10b6:a03:e0::16)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:44:30 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::c7) by BYAPR05CA0075.outlook.office365.com
 (2603:10b6:a03:e0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 28 Apr 2025 21:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:44:30 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:44:27 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 13/14] cxl/region: Add a dev_err() on missing target list entries
Date: Mon, 28 Apr 2025 23:43:16 +0200
Message-ID: <20250428214318.1682212-14-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428214318.1682212-1-rrichter@amd.com>
References: <20250428214318.1682212-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: db5a8c51-f675-48ab-3c4e-08dd869ddb7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KgF1ZZNRAe8XWlvBeW2VCeTRohJrw4B2WJt/6wRsKoggJteElbNe1foaZb/u?=
 =?us-ascii?Q?MhwHcP3sWJoLOt+v3Gqx+g1tHnC8s2zhOzNzgDuhsoMwp4vcZ+EaUH1Crecn?=
 =?us-ascii?Q?XtA/qPdR835r4FEbMrpvVyU7AE9Uz53JxQG4q195emq1a48XgOorQJqJLRaR?=
 =?us-ascii?Q?gPfqpHWjsWzcnXwbxIC99nz7zDZiIcaFobq2OMw20MCfp7Dn80OkHOPz0YVw?=
 =?us-ascii?Q?AAOpLXMG5Os6yTH7MW+0LM63IniEVIw3qYqYD7q2Y1QGS8VF539/lntIbUfm?=
 =?us-ascii?Q?TIBkvVWZ+HGfD37U0iML6kEdsUDu/uS+L0Jm9HL42Y3abkR62rfLhW+kHE/c?=
 =?us-ascii?Q?XtBNwoFT5F4Js0Ume1fuJJXxgyRtv5kH5ZdRQ+E2A8V+FGlHtUIK8vAetwle?=
 =?us-ascii?Q?DB5OcNazBkTerEebvMiMxT1wCCRj4OGnmnjF3939XYA2lTYHqpmb2V3c1J6D?=
 =?us-ascii?Q?HqikdA2tQ1wp0ctMwNlJ994wSr0iEzKlcEubUbkqDi/tLzk/SGZSJwtTKxyr?=
 =?us-ascii?Q?nBCx+3bSeRZJ5QlwNbNCNszUuqF2AE9GzXxDr2MiewNEh9iyNTcdJLJP1HRD?=
 =?us-ascii?Q?ESLk64KPFUn3mv+CHPk03+BbT6MpwJR6LxsAkggBFs2+1geQlUsLg6Yzxn7a?=
 =?us-ascii?Q?sIjUlxayGb3NqspGVZ8jQTpQS25PyR0luONNMOqn7h+spQ1D1UzM9zY37B7D?=
 =?us-ascii?Q?AnO8adS69lDw0LqHwNbhxFrqaUhLO4xFrTbbILmgsBa83xW6tVV6HOqtnXha?=
 =?us-ascii?Q?euNLyUcm/0R9PthFrb9HNtFj5hw9yFMBCrNXrx3wDD0ex0Ry+aep7VRmiBL+?=
 =?us-ascii?Q?eo+OqCB1AKK8Btb3B5iqN0rSiAdvaZfIc/opv33IbaXXs2b7YkmI+fizivmm?=
 =?us-ascii?Q?Fze7XNNRPKF6KfPw1tECHfU7hAdKTzPj5lNvQOGvMxPYt54JEK6aBwbFbnsS?=
 =?us-ascii?Q?OF0H+uwzANPRCJXAMmbZGH5jTCT1QBvOIo6iZ+oxAOy52r8bZ1fhjx6AAmBP?=
 =?us-ascii?Q?Qysh5jZIVykTb56+a0JMCsiDeCkjFp1sABYH9OZaSdVDFNkUjFNZy7l0x0Kq?=
 =?us-ascii?Q?XMwKDhKIS/DSgEa2fZPB06maUZtz120DB3EG6P1WdxpGkj5nosSKLM0QnAgt?=
 =?us-ascii?Q?VpsbNJvJOhCbv99afKaigVyT3SytVtUQjJ1+lTG69NrU9bIyjDAuXVSCkzDf?=
 =?us-ascii?Q?5pW+uq2JSSAewQCt8I3a+aEgVnx0WJte9R1BDNFf+WsaTCnL6pqL+GlWqVx1?=
 =?us-ascii?Q?/jrTmXjYyJFLUcQwWVI6PMSLKlVQ7PETnvR3lXeBfXxs4GMvIlvhGyh97WhO?=
 =?us-ascii?Q?3ton4sXS55dQxftuWbs+lUdUgANd8SzOizEYZEFWieBVyEiTHuxVbJuNAkj4?=
 =?us-ascii?Q?959hJ4A4ZKVUN2yQbynORHhCu+hCQ/7y3z5s9tUiPBxrhYhTqiF5Hfjzg/eO?=
 =?us-ascii?Q?iLNPLrW1BGPFVKJLeajCv17sIb+GBo+JKblXzy2d/6QaKOUJlGpceERTw5nP?=
 =?us-ascii?Q?Ve/ZteSqBw/H8Su3C5hCg0RWjXkFS7xgR6jt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:44:30.5347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db5a8c51-f675-48ab-3c4e-08dd869ddb7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733

Broken target lists are hard to discover as the driver fails at a
later initialization stage. Add an error message for this.

Example log messages:

  cxl_mem mem1: failed to find endpoint6:0000:e0:01.3 in target list of decoder1.1
  cxl_port endpoint6: failed to register decoder6.0: -6
  cxl_port endpoint6: probe: 0

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 560c447d8136..1d06295c7eda 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1812,6 +1812,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	}
 	put_device(dev);
 
+	if (rc)
+		dev_err(port->uport_dev,
+			"failed to find %s:%s in target list of %s\n",
+			dev_name(&port->dev),
+			dev_name(port->parent_dport->dport_dev),
+			dev_name(&cxlsd->cxld.dev));
+
 	return rc;
 }
 
-- 
2.39.5

