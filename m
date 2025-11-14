Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012004.outbound.protection.outlook.com [40.93.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C762FE045;
	Fri, 14 Nov 2025 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107168; cv=fail; b=NAnF5N3fUGRlj/FbqzzltSt7RTBHOcJVTR3beykTUqJjTVRsLK40v+EIg4l7rkgVYYN0Il3PREF+iWaWL37yq2j6b6UUVBLHnG3M/tMv/E8j9eDCqhj+6u0uTuEDrIfEcMuuQkTSuTCFGIOLyfeb10spZAQTCEtvcxmcdXhOMfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107168; c=relaxed/simple;
	bh=ckXg6ciMIKMNSuzZ6QwXlf0MOR62pL44IbCPR6yOMIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5xJk3RdjGYp8JpZFEZdu33SaWc7/324chbiKYFB9dmYu/9X6q9t1ZguJg5GQYq+Kx2k0DohA1+bRGrGYjokUcKSe/bsh/5lSJhZLRJMqtfZANqsbghzG/KJKPeF8puK2oTleP1Ke1K4QyEDNnN7dSVUqPaw7EZywPgiRoUPmik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rbf5JAJL; arc=fail smtp.client-ip=40.93.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rbf5JAJL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOtuMwNnz4rBxG2tr8a6LxqAZMzxqmEu4mpq6Euf/X7HY5aZKCr9s4shRVtpfO4sFjXuob2J6g+ryseb1UdLmt805LdA7iDz7KvmGSnZfjLhOZkBQlS+0GGU049ZgtHDmS0wYZJT2NXdo/CaHdgIG24DF2tXdaA9pFnDrG+JcYAub5JrJqQbh8q8fW7Du+CMAeo+GilW77GMx50Y92azNnJy8QIY5ZswbCC8VhkOBWKnLH/LslPwPEJYpLWYmzFAAhNyTwXMAVakzvPo1jZaTw/Z4v1OF3VNgHlzL7PNtRjJbxWa1nG445NP4Zu2DEEWKS+4gxAq+etKf4Ur842XRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHUM8Cr2aTovnKH/qcEnQmX2YWUtgtlZRHY7Ca3gNDo=;
 b=npqnjxy0HDHSEL6uk+t2uykNr5xwxs2JKtt2nD8FadawJICKXOgMR4djlc7hnlU1aAshF/X4dyZCc/fPdcLFQtpb1l7JoFZGxrif4rk9gMgWBYkOPbb1JQDx84lPQg+CkfrzSVUOkshiSvqPvSHypwLC7Oh5Rs+cti2xo+mLqfBWGRbfYDDQWKKfbXdxREvME+pnFlH06GYe1b7WDNJlPD4o0/ewXwknZbmTaDiIBtgT7s+NWJWLFf/e3PHqvly9IZbrbmZmd4k2B36VJ9pMsrzdBFZlrtIXo+TK5s/CXVinRcTGGB0R09QTP8e+8j/pIbPYs+KskvJMjYFed6Q7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHUM8Cr2aTovnKH/qcEnQmX2YWUtgtlZRHY7Ca3gNDo=;
 b=rbf5JAJL+atlr63sXjotcfhRG4NfykDzod5ATYG93B3t5BfzoAIFv8aJlG5vno3Ztlo6ngqh1dFqTKWTz1T4DUWj1BAxbkslG0eqHcdNj9BW+ayJrma6bsGi9fXIWLQDHkEtcUCew8zCmYIBsbwoPgJsluUlpSCe/ImKYxM0Vv8=
Received: from BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::16)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:59:21 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:59d:cafe::fd) by BY1P220CA0008.outlook.office365.com
 (2603:10b6:a03:59d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 07:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Fri, 14 Nov 2025 07:59:21 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 23:59:18 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 3/3] cxl/region: Remove local variable @inc in cxl_port_setup_targets()
Date: Fri, 14 Nov 2025 08:58:43 +0100
Message-ID: <20251114075844.1315805-4-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114075844.1315805-1-rrichter@amd.com>
References: <20251114075844.1315805-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: abc2af39-04ac-4339-3e87-08de2353b864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DFVipWsXBTB2dPM+mkBPSptaeLOBI86IZbDJkEiD9bXEv6aa4lk6C6jRbz6v?=
 =?us-ascii?Q?RmedqtqOndrFxsqYZN3GReqvYh3Of3X3YFsMjGiN+A1WCPuGFRAemtegjVfb?=
 =?us-ascii?Q?Lic2F89CK+5PzmWZ87XALVJdo1D2Y8KCrexkAgANxIgVJwIrCs2wMNP/GaD6?=
 =?us-ascii?Q?FLNIijdaPEr4RSwbWQiEAH/TKcCFw2ehy7lxb1OgWasktxlhpCV91u2dkPYa?=
 =?us-ascii?Q?e716JNxOHhou2TVh2ywYEECoyhk+dsJXS5aXTwQpM2uYilLGlqrc8X3kp5Bz?=
 =?us-ascii?Q?ByJ93+lv+s8pqapYXgEoifvqbzG/R+1f/YNZKKhUCNeApURv8qvB2kPF+4o9?=
 =?us-ascii?Q?VUvPM5pU+hQhioCLMME7I4lGdggf8ov3q3VmRL0Q1jZ7WQPoJvi1YZpbtZCg?=
 =?us-ascii?Q?VL4mh05zPuD1LwMbgaRzFv3DjtxoTEgdDLEopXIqTyYKjN1RARGbtHRKySSs?=
 =?us-ascii?Q?u89nKEZUCM4AaE+1FLTkMS89ciytmfyF0Sy4EUNoiHE0/FZvcBYuEw6rHttA?=
 =?us-ascii?Q?98RZwPcznNRNu9293hun+QhfGMU+hD5BIxakO/Qh2XOFXB4LFR9r4U9kf7Zd?=
 =?us-ascii?Q?RkdX0pOsl2UejuzKOn+ALx4RsOKqzIM5S3h9SiNzTG+RA7b/TU54XXfvRdHV?=
 =?us-ascii?Q?JUeULf+3gqyrCZCypms2PF/XdYcwoRdyF012c4H4N8P11PhQMp33kqHi1F0H?=
 =?us-ascii?Q?gZdUv9yYUfvw60vkpEzvTf+WeDOHGh8bpUbcUxdQ9rfHhc5NlTLq4Y9KYxBO?=
 =?us-ascii?Q?RWI2o9LCbA8RQP/QhQOkkep9PDhaSgzd8vElyYnQCde8zxnfz80Zgln6LGLb?=
 =?us-ascii?Q?WZcyvi/kvXtnxA4dFmgxS1XnqXhVMJu8hj4qYCVUr9Lo/IKC0duu/5JMKX5u?=
 =?us-ascii?Q?qVJFiI4Q1b+vASJwH7GZwFGrOz5rNla8rvGsBwe3RFZpeqkVDClHj+vzn8aM?=
 =?us-ascii?Q?o251YK7Xoyg39B8qebgn0j51IBruxJ3y2jDEe1WkuppyKDo70Aw55Zgcx6/p?=
 =?us-ascii?Q?WMowr0/GiqYcwdKrOpKnCIVcRYFxqGRTw0k08RBRViryY1U7IEmJROem65v5?=
 =?us-ascii?Q?Kjy0J1KfePJHMrmr7wGvfm8zgRSO5Lh3qR7YgVEN7e41gn099bpcQOrqQjzL?=
 =?us-ascii?Q?91s4M+f/6jQkcNZmK8Xy0bPbcDyLifIVGMlpnFtL+Y5fAWcOWVCa3b+qlMPa?=
 =?us-ascii?Q?yz6EI1nnAZuD4w5UphekEPEFP+70GSnUv8a47hfmSH+olMMJoar0umWwKAh5?=
 =?us-ascii?Q?A7gKYNJbeHIQfIEWIiJIYxDVJ/UXJiZaGpTS8spRcw0mW5FphTrKYEauXDYd?=
 =?us-ascii?Q?DwfrnVio0vupAaJkuK/wjvF5XdG6cxhl4u8G8T1syoUQ7EPNDXkOTA7gZwp6?=
 =?us-ascii?Q?wWDZ7klp7gvfG+TSoEJM4+ZftL0hxWY/g5oLKyIy/bshyYfL/dTjxyHSdv3t?=
 =?us-ascii?Q?j5LbsFRG3hYrV7HC+jNxfFfsV0RY8ddwDrcPwPJocgiLattB0xkayKDe3d1F?=
 =?us-ascii?Q?MYzfPPvjiOAUDoB0awjbjuJV7eFxiGxEWHo3yxvpW2v3CCHkODFeYDFR2CBK?=
 =?us-ascii?Q?fV+zh7/boUwPBjxqCyo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:59:21.4682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc2af39-04ac-4339-3e87-08de2353b864
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398

Simplify the code by removing local variable @inc. The variable is not
used elsewhere, remove it and directly increment the target number.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 095af0f4760f..8cdb6a935289 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1328,7 +1328,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
-	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
+	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1520,9 +1520,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
 		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
 	}
-	inc = 1;
+	cxl_rr->nr_targets_set++;
 out_target_set:
-	cxl_rr->nr_targets_set += inc;
 	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
 		dev_name(port->uport_dev), dev_name(&port->dev),
 		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport_dev),
-- 
2.47.3

