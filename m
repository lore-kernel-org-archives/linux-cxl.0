Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B242F0696
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034363; cv=fail; b=BJAZh+xerXfA2zh6dm2sI6Q16iDfRAKevROcWKrE4S141q9mf7kk5h5ikFx5eOyySL090HrJLR17Lg2PzY6gztNP+OjHoXxikTS1jeSypwpTyn3Pp2QZV6zkgD8+xw/WCl86Bjx60EJ1zCllGOS6DXFuPY51XFkr8vLtGUGG2J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034363; c=relaxed/simple;
	bh=UWMpdx+JHNW9XTbKIWpcBnMChheDK3k82UuUI3xtLWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9VaZ/ck1wrFYf5TAv9zN11GogEFI3zEEs+6k2LflQVQSwtuXy4SFRNRSJnKWd3twA540k/guhRFSI8ctNUxpX99wP/8BlSdrBItlZLpkDr1GRcj4pySjXy6DzT2KP6jk/KR6Cg/eJ3Au/R+PjP8ApEBiHfi2dyfpqNVxyHLFew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F/loJgqC; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F/loJgqC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skpwgpeDTLJ1GBs0sELhYN5OMLFsueC6X1qjbh3jGOauHW3Cz4lyeqLDq3yBysxFGIrlvMLO8SXINifv6rnzXm5x9J7FmByArtdpRblbyGvu899kTgVgk46n9M7AINo8smxzreVtygPTWJKm2CHy+s30/W0t+Blpbqk09jJaQQvnNGLlUOKT7QX8Nj//XkXF8fcjkHaXdeM4WBSBu8OqD3YumU0u/6uFjV92tssMCgpl+D19zes03Mm7NMCZc7t/l45oQ+c7R5Aj10dobv3+JJcbO7tAQVITUcbJgD7P0B+FBE4As6+knhaI69Y6WjYSs3a5Vl1FAOXxetQrTmVzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C58SsCJqW+r3vvt0oVx0chJFjqair8ZTy2rZmIvDkZA=;
 b=x/1aQ9qGZnzzeLzAkv35fKk/Q4RDFRl92TS21Bpx9X1LDDNFBNHnYbQZBWY4WZy+uYQSNzlEz6GAPyEbW2V+ajpxqF/D26BTH32o4a90RD+wrPZ9MkdCP5O6zzfw33/uHW7vx117F7L7fMweu9QVRYC6ZGKC4W7IlOcsKxy7zeDRdR7X/QGJ+ATm6NdJ8rQMs4BKVpC2KA2rM/k4LU2qtrlVMvtFMhaeYL7awDfyXa4HbtncmS5+JJzjro9aeeUfCLTrcgVRacHhjByqcP2oT1gumZxk1qCLInTtto8MVBXxyx02tfxcYSd5AHJ0fihCg/BBGz76E4sXFvuyaRbdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C58SsCJqW+r3vvt0oVx0chJFjqair8ZTy2rZmIvDkZA=;
 b=F/loJgqCqS0K9aL+ItCbpD0vm8vAWEmRM8oC788m4b1oEzvTjwpLfxE5CTtf2+PkpuBWENnXgMa2u83nxDubM8J/PwGLw7BLY48O8dRBShMiBB3cLAtWAFmQclpIsi3FlX/LDs90wDslxb6P7CPMVCemMhB2tcT4Xox3F0Txv+0=
Received: from DM5PR08CA0044.namprd08.prod.outlook.com (2603:10b6:4:60::33) by
 LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 21:32:39 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::c9) by DM5PR08CA0044.outlook.office365.com
 (2603:10b6:4:60::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 21:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:32:39 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:32:38 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 13/18] cxl/cache: Implement Cache ID Route Table programming
Date: Tue, 12 Aug 2025 16:29:16 -0500
Message-ID: <20250812212921.9548-14-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|LV3PR12MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 136c394f-b265-403a-ca6f-08ddd9e7c35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ox4b8SegO5uqEnkYe1sdRi4Puxaj3K2K0Rs47O6KenWa1fzhVWY82JPvpYYe?=
 =?us-ascii?Q?ZvbyZMR1mFjkOlPZk3LrVOZyZGMQ0BGz4wFr7KSyaqbyl5VHnsVqAEoplz/F?=
 =?us-ascii?Q?iQcSeOdGg88+k0S+Toau+vXPWDtHNR47twfuWbZ+qF3KE5vYjlOE5gh/ABK0?=
 =?us-ascii?Q?wUSVjf7mNRsysz/UUfZGL0Bg+tGzi03nORVPlrUax5rMxzxaZ1BDk5h1CUzq?=
 =?us-ascii?Q?9J5FXJxXGv7Qrz+0FAUX9W7RVfZDPD0d3lZ8mCLxCdz+U1e2VAFt5nhOEyNN?=
 =?us-ascii?Q?Ny56Ea9Cv1jOVRwQRqtLo2m2Jmhjb8A4K7zenEAP515TV/tTLLei3SHxIn6B?=
 =?us-ascii?Q?Hbp5nnHt5ByHfQcy2lwqNdncYkkFyZRCgXc4lO29SoMEzwEGLeYABXS/q96j?=
 =?us-ascii?Q?TH59QP4P6DHu3e/ft4mFrUoC6bV2QvzAHtFRK0xFUcaLUM7pmlgAMOZn3EO8?=
 =?us-ascii?Q?zEKakE5rADmISYsHcUM701t1s+38UJoYttE2J3gOW26QgXZ6pwY4BDn6s1/C?=
 =?us-ascii?Q?F14vwn17PZ4h54sfenc8aDTElE5M893fhf2GAtw7Oe7jtL0Uh8Pg2Vgr06Ea?=
 =?us-ascii?Q?apa0nTgeEgj7/vYlaXNj95Px7SXXTUj0za48RyrhZfXSCciH8LoXQ0pKs2e0?=
 =?us-ascii?Q?189GyimaPuOjo91s7ZoedHbEom4AsOUGFvqAIiWbVrQ5H5kZnaWkQndWVVhn?=
 =?us-ascii?Q?l+Ob5fmalxOTkQnk2DrZ9N0oFSiOowKws4RQ/35mi9kb0SqMTPCnYiEVRLNn?=
 =?us-ascii?Q?LsKcbYwRdiOvZvXb7RBvyw5gfKR/LUkh68IrFojfyFwOF1gss6zUi9ncxL5Q?=
 =?us-ascii?Q?C1wSBmhzyAx1recygOZyeVqkHm89OSQ7x9+uj8LnOEDyzgifLLxlwJUulMde?=
 =?us-ascii?Q?mYoWaa7389QeABX32ScxRyQQwn46uAo68zKlgLMvHcaKSM1V26/jVnFCv0tE?=
 =?us-ascii?Q?zIEwBrm2nDX6XXEZMg6RyxCOQhGqvFRAAGrvbAUI6dCVzq+vEOZEXs2ttU3R?=
 =?us-ascii?Q?whDHmbRBEV8olja/FUy1XS6zaDBoFPvnRqsnfTXcm6Q7rATuEZyQtp86eVuC?=
 =?us-ascii?Q?PMXM/mLh4vgilTbLOkMLF5cxvtpnCTWjRbIflbW2rZeStw/ZiXYR+KFgYLCD?=
 =?us-ascii?Q?dEIEzKQyMpAX1+BIC5Edla85wjBhsZ1GMGFgCcK1V3wjrO35oiO2+VmkcGz2?=
 =?us-ascii?Q?uGLOTF/FI53cTvCQ0Lxh36pK4P4xTPv4CEpWFK6laWpuEhGgLV9f5058c+c2?=
 =?us-ascii?Q?eK+N8Q68NNJNnlogan2m7A7PyPTN121e1H159MBAS9KwWr6P8NprxcVZ2Wv4?=
 =?us-ascii?Q?ZkM8mE8gDLcerLS3cbL4RUfjC8iQd2O6fbmJqgnp/S4ZwvRy6LCS+OWJsn/v?=
 =?us-ascii?Q?2aMYmUmXFCLO0fz3KzzPRpfoGAdzAgFHsuln3+krEUXP9l+2nX7aP+2nOk0N?=
 =?us-ascii?Q?nJRZqsLi8s/+Y2G+7Lj3JVp30aHNnoGGh2Gf7fguY9ePLC7iIdmy90ilNfu8?=
 =?us-ascii?Q?1lswCHOXSJ/TAC0lPm9MB9+8nyIK3js6y1PQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:32:39.4032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 136c394f-b265-403a-ca6f-08ddd9e7c35d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215

The CXL Cache ID Route Table is an optional capability for CXL-enabled
upstream switch ports and CXL host bridges. This capability is required
for having multiple CXL.cache enabled devices under a single port
(CXL 3.2 8.2.4.28).

Implement route table programming. In the case BIOS has already
programmed the route table(s), check the configuration for validity.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c     |   4 ++
 drivers/cxl/core/port.c | 135 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  10 +++
 drivers/cxl/cxlcache.h  |   4 ++
 4 files changed, 153 insertions(+)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index fd2ae1fa44bc..24559b9ba8e8 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -134,6 +134,10 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
 			if (rc)
 				return rc;
 		}
+
+		rc = devm_cxl_port_program_cache_idrt(port, dport, cxlcd);
+		if (rc)
+			return rc;
 	}
 
 	return 0;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 26ea22a2638c..f491796f6e60 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -945,6 +945,141 @@ int cxl_dport_setup_snoop_filter(struct cxl_dport *dport)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dport_setup_snoop_filter, "CXL");
 
+static int cxl_port_commit_idrt(struct cxl_port *port)
+{
+	unsigned long timeout, start, end;
+	u32 cap, ctrl, status;
+	int i;
+
+	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
+	if (!(cap & CXL_CACHE_IDRT_CAP_COMMIT))
+		return 0;
+
+	ctrl = readl(port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
+	if (ctrl & CXL_CACHE_IDRT_CTRL_COMMIT) {
+		ctrl &= ~CXL_CACHE_IDRT_CTRL_COMMIT;
+		writel(ctrl, port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
+	}
+
+	ctrl |= CXL_CACHE_IDRT_CTRL_COMMIT;
+	writel(ctrl, port->regs.cidrt + CXL_CACHE_IDRT_CTRL_OFFSET);
+
+	status = readl(port->regs.cidrt + CXL_CACHE_IDRT_STAT_OFFSET);
+
+	i = FIELD_GET(CXL_CACHE_IDRT_STAT_TIMEOUT_SCALE_MASK, status);
+	timeout = 1 * HZ;
+	while (i-- > 3)
+		timeout *= 10;
+
+	timeout *= FIELD_GET(CXL_CACHE_IDRT_STAT_TIMEOUT_BASE_MASK, status);
+	start = jiffies;
+	do {
+		status = readl(port->regs.cidrt + CXL_CACHE_IDRT_STAT_OFFSET);
+		if (status & CXL_CACHE_IDRT_STAT_ERR_COMMIT)
+			return -EBUSY;
+
+		if (status & CXL_CACHE_IDRT_STAT_COMMITTED)
+			return 0;
+
+		end = jiffies;
+	} while (time_before(end, start + timeout));
+
+	return -ETIMEDOUT;
+}
+
+struct cxl_cache_idrt_entry {
+	struct cxl_port *port;
+	int port_num;
+	int id;
+};
+
+static int cxl_port_enable_idrt_entry(struct cxl_cache_idrt_entry *entry)
+{
+	struct cxl_port *port = entry->port;
+	int id = entry->id, port_num;
+	u32 entry_n;
+
+	entry_n = readl(port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
+	if (entry_n & CXL_CACHE_IDRT_TARGETN_VALID) {
+		port_num = FIELD_GET(CXL_CACHE_IDRT_TARGETN_PORT_MASK, entry_n);
+		if (port_num != entry->port_num) {
+			dev_err(&port->dev,
+				"Cache ID Route Table entry%d: Invalid port id %d, expected %d\n",
+				id, port_num, entry->port_num);
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	entry_n &= ~CXL_CACHE_IDRT_TARGETN_PORT_MASK;
+	entry_n |= FIELD_PREP(CXL_CACHE_IDRT_TARGETN_PORT_MASK, entry->port_num);
+	entry_n |= CXL_CACHE_IDRT_TARGETN_VALID;
+	writel(entry_n, port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
+
+	return cxl_port_commit_idrt(port);
+}
+
+static void free_cache_idrt_entry(void *data)
+{
+	struct cxl_cache_idrt_entry *entry = data;
+	struct cxl_port *port = entry->port;
+	int id = entry->id;
+	u32 cap, entry_n;
+
+	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
+	if (FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap) < id)
+		return;
+
+	entry_n = readl(port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
+	entry_n &= ~CXL_CACHE_IDRT_TARGETN_VALID;
+	writel(entry_n, port->regs.cidrt + CXL_CACHE_IDRT_TARGETN_OFFSET(id));
+
+	cxl_port_commit_idrt(port);
+
+	kfree(entry);
+}
+
+int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
+				     struct cxl_dport *dport,
+				     struct cxl_cachedev *cxlcd)
+{
+	struct cxl_cache_state *cstate = &cxlcd->cxlds->cstate;
+	int id = cstate->cache_id, rc;
+	u32 cap, max_hdmd;
+
+	cap = readl(port->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
+	if (FIELD_GET(CXL_CACHE_IDRT_CAP_CNT_MASK, cap) < id)
+		return -EINVAL;
+
+	if (is_cxl_root(parent_port_of(port))) {
+		max_hdmd = FIELD_GET(CXL_CACHE_IDRT_CAP_T2_MAX_MASK, cap);
+		if (cxlcd->cxlds->type == CXL_DEVTYPE_DEVMEM && cstate->hdmd)
+			port->nr_hdmd++;
+
+		if (port->nr_hdmd > max_hdmd) {
+			port->nr_hdmd--;
+			return -EINVAL;
+		}
+	}
+
+	struct cxl_cache_idrt_entry *entry __free(kfree) =
+		kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENXIO;
+
+	entry->port_num = dport->port_id;
+	entry->port = port;
+	entry->id = id;
+
+	rc = cxl_port_enable_idrt_entry(entry);
+	if (rc)
+		return rc;
+
+	return devm_add_action(&cxlcd->dev, free_cache_idrt_entry, entry);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_port_program_cache_idrt, "CXL");
+
 DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
 
 static int cxl_einj_inject(void *data, u64 type)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c147846855e2..1a2918aaee62 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -163,8 +163,15 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 /* CXL 3.2 8.2.4.28 CXL Cache ID Route Table Capability Structure */
 #define CXL_CACHE_IDRT_CAP_OFFSET 0x0
 #define   CXL_CACHE_IDRT_CAP_CNT_MASK GENMASK(4, 0)
+#define   CXL_CACHE_IDRT_CAP_T2_MAX_MASK GENMASK(11, 8)
+#define   CXL_CACHE_IDRT_CAP_COMMIT BIT(16)
+#define CXL_CACHE_IDRT_CTRL_OFFSET 0x4
+#define   CXL_CACHE_IDRT_CTRL_COMMIT BIT(0)
 #define CXL_CACHE_IDRT_STAT_OFFSET 0x8
 #define   CXL_CACHE_IDRT_STAT_COMMITTED BIT(0)
+#define   CXL_CACHE_IDRT_STAT_ERR_COMMIT BIT(0)
+#define   CXL_CACHE_IDRT_STAT_TIMEOUT_SCALE_MASK GENMASK(11, 8)
+#define   CXL_CACHE_IDRT_STAT_TIMEOUT_BASE_MASK GENMASK(15, 12)
 #define CXL_CACHE_IDRT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
 #define   CXL_CACHE_IDRT_TARGETN_VALID BIT(0)
 #define   CXL_CACHE_IDRT_TARGETN_PORT_MASK GENMASK(15, 8)
@@ -618,6 +625,7 @@ struct cxl_dax_region {
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
+ * @nr_hdmd: Number of HDM-D devices below port
  */
 struct cxl_port {
 	struct device dev;
@@ -643,6 +651,7 @@ struct cxl_port {
 	} cdat;
 	bool cdat_available;
 	long pci_latency;
+	int nr_hdmd;
 };
 
 /**
@@ -786,6 +795,7 @@ struct cxl_cache_state {
 	u32 unit;
 	u16 snoop_id;
 	int cache_id;
+	bool hdmd;
 };
 
 /**
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index c4862f7e6edc..d28222123102 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -28,4 +28,8 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
 
 int cxl_dport_setup_snoop_filter(struct cxl_dport *dport);
 int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds);
+
+int devm_cxl_port_program_cache_idrt(struct cxl_port *port,
+				     struct cxl_dport *dport,
+				     struct cxl_cachedev *cxlcd);
 #endif
-- 
2.34.1

