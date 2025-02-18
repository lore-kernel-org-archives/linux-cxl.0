Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B3269896;
	Tue, 18 Feb 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885084; cv=fail; b=tul65r1NRw9hn9tvMlkDqSwKdyITgmTIDnKVMqAK25mwDtv0uBvdl1rLipMX+jx8BZuzUGHLLGqm5rImImjCsuAxI6JRoVfZ5TDuUW/41VyqK4Lplp+iVYqCyA/nY0YJUa7Y8rRAC0WZXCEpAWzEhZALyxMsV+EnXlAyFteK+oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885084; c=relaxed/simple;
	bh=Zq+T+8m3u5s5QsDbhlEIJ8aiS5hB3mmdW/poMMBcarM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXzF102pNNZxKrWdFnG2cO9tcEUKp9JCadp6Oc3zahIEpfN7O87Z5BnyVsw6F0+QvYL+QtlNwr5381WCs/JQmWlzj5hGoWdOXn/V2DE/BcuFxJn/0G1asilRkiuL4/7NVtPIpg+WM9EkToFWVttRdpJBAK+596DO99IH/5iwEmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B42kv+Y1; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B42kv+Y1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlnVyDtfDRY5JfZ5QfcCvwouooiGRPF9RIo+4kDEo8n5mCAkVOd1D2N8+uNMEnfv4VoiZEeT8pD9xanyY6nAquZqJH2vfLMiWSMzk3gjFeorXs8Ps4T/IOqBPQQlUROVZeFShwW0xhOYl6+dziM+hOyETnfR/uKZiB8PL8nSRNJpcm101f9EAGsZ8IlhSfd/iGUT/KzU6NF1qW69/KpoJFInw/2NgMN2Sl5uWNJFcT4BgODWyxrcBWRX/ytgI79lUlOvNFlq+jrknkxC8EcUih1PTYjrlSmYbSupgqJ3H89BZ9mr2GG7Y/xolehYoYu/UH2/aiAW2xp34lePD7lahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71ltdfWtqaOq0/tIsYbU2NGuTJTfrMknVMHQujVbyEc=;
 b=Jc3g3HW8+oRw5Fd20eH03fS2Pl3hIODkplPsFCzYYp9Tjn0H4EdqyAZ/0OhmIECLQ1YGDwnvUWRK+/LxSZZmz3dbCtQu4l8h3lOp+DKYh8PVNT+h8b8t00MZNt860n6Al2ChKl/opvSDxsd+bU5h9mT8mrCM8qyBxQTNiqUEFlr8wbJbxrdYhz3w3WRoJCdr0MNMBbz+Mbveo6ea5czAtWmJGetM1wGvqdUDfr5RQVrkcMx4VYUmuNhIzi+lQeEXs5iXHk3xAyZ00E3xGhL8rHAHIBzmRdukEAgfsXPUGbpMek4kzuznHV8AuslYSN7sMw7STiHQ8YWVLOIihzRblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71ltdfWtqaOq0/tIsYbU2NGuTJTfrMknVMHQujVbyEc=;
 b=B42kv+Y1LGzPIyqpT5Nqs4Cx6p3HjUSz8e1SAwQ0A3eZdFBVx3Gv44S4vwav+aaffNyACnS/17KSHjr/Mf118QzGw4MwVbtRYVV8tjAd1Z1KKddD/cbUQ7W4/8Amnq06mnFCTXkF0P/dcqDKlx0a4snF7BmIbEPQxFd1HykdVWg=
Received: from MN2PR05CA0062.namprd05.prod.outlook.com (2603:10b6:208:236::31)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 18 Feb
 2025 13:24:38 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::ce) by MN2PR05CA0062.outlook.office365.com
 (2603:10b6:208:236::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.13 via Frontend Transport; Tue,
 18 Feb 2025 13:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:24:38 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:24:35 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 02/15] cxl: Introduce callback to translate an HPA range from a port to its parent
Date: Tue, 18 Feb 2025 14:23:43 +0100
Message-ID: <20250218132356.1809075-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb4ee00-51d6-4d78-395f-08dd501f983e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2MDUzt6dHjTRB0qcyVtwjSGo1KNTVnNEiU7vzYEACwBufOGUVU/1SlCOlJp/?=
 =?us-ascii?Q?LTWhINTQaOdgEqkuB9I3ddlpQLqYOqEunOGxKYXwE2ULK1NonJvPoaZ/8khg?=
 =?us-ascii?Q?xgkr1V17d+8JiC3YhjRA/trk580w+LDh1JRzgTfS346FGXxeVgBJPGL1Gi2h?=
 =?us-ascii?Q?eXW678sfWPbyaOaluwTnv1DFFAcOPujXA8Pw0SBWhaWKV0+zWqBQWSFF+vrp?=
 =?us-ascii?Q?YxUl4mWuhPVTmAAC/WKsvxvy2RZ6kKAaGWPtX/e9PayKqnLpjnw9dtSM+9F1?=
 =?us-ascii?Q?Nz1e27Hlqdke8jlhC9Jva3V9ridXu39539zo/taTh92b2SGd0Ycp6G1AfuyR?=
 =?us-ascii?Q?BWYoLt7c5s7RLoH+ZWq9Np+LLFBdMYL5riUGdurWISFIwzkH/4magd1/O4/8?=
 =?us-ascii?Q?ucGco3ABi/bfiTGncsOh18Tz6rL0h1qIXH3tVrr3I4LmjFXcUtg+dT0QrA6w?=
 =?us-ascii?Q?0V0pvzTt1Ph5IbJ2C7VXdvePr9PQeI83UQf8A3oIcSGsqHkuknuOu25j3E5S?=
 =?us-ascii?Q?W8lFZHWWVe7fOCLnKBK7cFSrl6ulrHKi/JiIyENksRniSHdd4US6XSEex4co?=
 =?us-ascii?Q?69MzDRBF9E4745qbjJuG84OVMIDDpBpOHTp8xpUwxB+J0MaNmCrVbTGq6lQH?=
 =?us-ascii?Q?ptCtKbVE0XtXfyanq2zVCiJOv07gT9wgAbwdfpzuk8FxmdcQ8vjrFeLONEiN?=
 =?us-ascii?Q?6VUwYh3SZxDRdRP89P9/dqvFAmHj2aK1zNCdQyGCIB63N1a3jz6XQnD8lWaF?=
 =?us-ascii?Q?05BD0bZ8CzBa4aA44F0SU37BM2gJS025Q1do5J1mjfYQpgo2DVx+K/nmEh+p?=
 =?us-ascii?Q?j9CBhctTGqV6X5SCdg8e2Rl7QQO9342y3zAfXD2jBay6KDJQrLOehmvuw0ei?=
 =?us-ascii?Q?O/Q1o2Ya6MXT0yv0fW1Q53YsuEUmbWN3u6AZBJX+9PDGGz9G+2f1HMOD+SkU?=
 =?us-ascii?Q?vE2LtnBnC/zqYkVIQ141Ntyd3HmAgjinql0FaJm6drpVJA5o9kz67E5uaJJ3?=
 =?us-ascii?Q?ou3Uz2zZ+8jS2YSJbtJiSRiuiBbEjmuG8I+yIijexWP6m2Kvq6flIeEbZIe6?=
 =?us-ascii?Q?2394C8JftAKd1ce78bmJGPcQRWGLIKiB5AwxeF0eetjR/aIbxI5priIfAa38?=
 =?us-ascii?Q?LrfFr52/NFh/ABrsaNBFAb2Q3TZOk38VR3njOIb0J0NFJYaHbDlsEjmlfG/G?=
 =?us-ascii?Q?BPVoQXCkTKjcKKEZTAwXXwqea7jCZ94QDOhRNAp0x0xw9rWzbV8SHerIGDiR?=
 =?us-ascii?Q?YaV6MkjICzRYqRmHQY6rQNfiCkwcas+txHdSxIl+R3J02efsFir5VCgWrwTK?=
 =?us-ascii?Q?6cwWTFjmSrILJkWJ00CPlN8KmM7b7ao5zMrmYRvL+G1nPnXMLpGuUtwIArcI?=
 =?us-ascii?Q?dv85Ng5v/2VNQVmgIfutFuI76TL0QHkZusrMlRUOMbz27D62LNz9FjrEY6Im?=
 =?us-ascii?Q?nZfiTv+9yZ5bWBAU1VS40D2gBtqqsYV/ecyly3jGcwm+GZpCOCD4ZHzrrADu?=
 =?us-ascii?Q?feHiCUwjvaGxToE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:24:38.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb4ee00-51d6-4d78-395f-08dd501f983e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616

To enable address translation, the endpoint's HPA range must be
translated to each of the parent port's address ranges up to the root
decoder. Traverse the decoder and port hierarchy from the endpoint up
to the root port and apply platform specific translation functions to
determine the next HPA range of the parent port where needed:

  if (cxl_port->to_hpa)
    hpa = cxl_port->to_hpa(cxl_decoder, hpa)

The root port's HPA range is equivalent to the system's SPA range.

Introduce a callback to translate an HPA range from a port to its
parent.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/cxl.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b19ba47242c6..17496784f021 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -418,6 +418,15 @@ struct cxl_switch_decoder {
 	struct cxl_dport *target[];
 };
 
+/**
+ * cxl_to_hpa_fn - type of a callback function to translate an HPA
+ * @cxld: cxl_decoder to translate from
+ * @hpa: HPA of the @cxld decoder's address range
+ *
+ * The callback translates a decoder's HPA to the next upper domain
+ * which is the address range of the decoder's parent port. The return
+ * value is the translated HPA on success or ULLONG_MAX otherwise.
+ */
 typedef u64 (*cxl_to_hpa_fn)(struct cxl_decoder *cxld, u64 hpa);
 
 /**
@@ -581,6 +590,7 @@ struct cxl_dax_region {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @reg_map: component and ras register mapping parameters
+ * @to_hpa: Callback to translate a child port's decoder address to the port's HPA address range
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -602,6 +612,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	struct cxl_register_map reg_map;
+	cxl_to_hpa_fn to_hpa;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-- 
2.39.5

