Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB344848BB;
	Wed,  7 Oct 2026 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364048; cv=fail; b=HwVKpllNdrfsMJigF8/IwBGs93mRN9zpsSTpiGN/PoPCD0yhJuCFeZApSbd8fBXexIBk1JO38BNfsdXkBPcFC+1SBRiVBDbgbxMrrY5YFMQXw92YFnkz1h86TUoOlUgxuRUaI5w2LJDovUfhRGVsR5nx+6LWmcJZi5ADkgJ/ZmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364048; c=relaxed/simple;
	bh=LQBEK1BrtMNMX17XQSHMUsUWqiR//JmtDa+YHig+128=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hLEzaexFtubmfaCxXuWgtbm1WZXJQHqc+JPyUnVkWQPFXoZFqiziqSq42AhDh8AoqeZXHRBzW7E7Sg1AEn1hGCHRjjC8cPOyD3QNNuwegJK+csmb9ihuKFBZ4TAfsG8mYMT0cDi/eIWTVFV2vNQXJp0Uanpu/FJ2BzYckN+Auls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lk1HTy37; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lk1HTy37"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL4nlM/0/vs/91MFnGtZuRjMsnjEJ9z3C35tLl0FYzcNza9YnMbrIUUuuUMDXVTlvyctAWs9UWLKqz8hcr3iLC+60IwiWo35wNyjknOAtHTJQHdti1K5UQFtf7z8dLw/pidLJ1dOzCB6DyfymQDiGOHCtEw2dRbNrsCd/HFkjPQyUJ0xnk4RaHTvSIuKQGcHbaexGK7Gi/JmPS0Za7MDbRznkqF6/OxEjhyLgHhIL9mUg6rs17okn8iAPbgKiVNu9kK0y3SNw1lHnChZFiZSfvkBhB6vo4SzNwChMKR2ei05i3eTadFJxofcULdtbutJrXttiPXCxTOCj9f1X0NmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMpVM3xzu7RZc2q17rpVMxIbA+5VO/kZyPIHjljzs3s=;
 b=Pb6m8PTXwgrTF1hwBkawz9H5W2u1Ip5nQqxis7w4KBymqm5TpwwNBuaJPz86OBGMqlUR4fc6r0sxDNPSYGDnpgq8lmS8CrZgVqMDI/o9XTm+MwkXLn/FHgZKUgCMQ4Lyxfk8BNushHBYaWIUIkfEJlyaMhZc95wM6UwcuEWrVzY74gbWtEwQN4J1JefocZdFqZ3SCi6KH9vl0xQ0FVs3ouYo/Oze3LeV4+AUmw8Aeac7VWfratpaGzxzJzry6U+jXRPaHq3D4R78dKOCdKGwayNnElS8KcTZrGwORI9wD3I/nReJ360ZAjBSNiO21dAvQp/SGdQ/wifZGB9FiAsXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMpVM3xzu7RZc2q17rpVMxIbA+5VO/kZyPIHjljzs3s=;
 b=Lk1HTy373jA5Ib8QsxF3rRx5Bqt/yEZqdBdki3nijPZV1LtxzyDdqcCgOFHYE80qh05c3PKlAhIgmWmvtoLY+YZ3gflXPcA288yG6biR8sAnimSHUWHhxwbZ0UnMxHWqQOxst7dFkw0mi0CJ8wqCiK4/gb6eArslWzshDGvXzXPI9f55rwtW1WsHWwDO9wyZwyNuO2SUdzGW2MKjBSkYscELhuNnueAVySX13jIrdceUwFpV+0nvHhktXMn0AFxedkKAlehytSoV/BzxuoOMhtIUUgRDrhHPFgozrWhGiW7VwWqtXz9yWtRSyXZD7nuc5dIO2LcnGSwC8qmXtPu6IA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 09:06:01 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 09:06:01 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com
Cc: kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/3] cxl/mem: Add explicit RAM region creation for providers
Date: Wed,  7 Oct 2026 17:05:38 +0800
Message-ID: <20261007090540.43817-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261007090540.43817-1-icheng@nvidia.com>
References: <20261007090540.43817-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 8695960f-8ee6-4698-3d42-08df24523582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Y1Av6I4yKMdTdCQpF6I4hS7Oy54zwLhqtzXaF+IsdGLdOE9wzrfkx7H+bXcBOZAYIvLTi9tsoGv0dKjNbLL78gKon7ees15b+jiBqdZWqoVVoiTEUw3VrQHxTszDiRX9ZdaMkSTPFrvxVn4ZrK2HthQSoJ/Ajcp4w+xBOx6x5mc+xN8jSU2voNEOM7LpI6UjLwR7xyt550XRrmrBqMz6ZUJgaUrRQXt3slVVR+pwZM/y8bjlQ7vKlbqpUnUNFKx1GH4liBA4MhUT/mXlQzBBHwE2Wij+dGjoYAzbMrueRt4J8KMZiMQdfPt21d06Jfr7EYPIn0lfNMiNgvLRQrtc+IeaZ5baZp0dGOQNO1e6rIH6jj9T3yrQG5fJj701yX5rAV/EoKSGazrnjs0Yf9WsXwMSVFk2SRbh2KgY2Jx/lSd9Vdz1YOeuoptc1ZDbs3f5Yc7xdKf10cXlulZr1y3vE9RfMnwwoZTi5wW0x5+YDqCQsxcoR6NlrNokrryj8SyzBKIlwCPZlIjmdohUhpz9SLKsctPHN3oAJqKD9EPeu3f/IVcQLfdhZchf2wZcWsU56jbP7Cnnv6HVGYWYDT90L5yxvcD2lljbTZUnQCo6a8rHkZ6wwOseoLwYBURBv3blndlS0cw5pmJlzrSzAFunV5lgHJFgqC3gv93FGLdYlBg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N7EwWhUf8HOiOj7VZYSx3GH9VgV1zOpxLBQ5O9RCBWkzfLJW1W0wWP1H6wUR?=
 =?us-ascii?Q?gWJ0J9zDCngnThxUNpViGRlr7m+x094rWsfZh331p/p5T8UiT7SufjhsdFgN?=
 =?us-ascii?Q?b1CMPlluQNye0Gsh8JnFAZhICA0ULvcnKGQTWyCM7wE/pq3FMT4QiXWR20yL?=
 =?us-ascii?Q?v7+6Py06MWtmGSsCcfW0G+JxA+AJ2t+2zNnCYpidIG8UdzrNfQeZjm+WoT35?=
 =?us-ascii?Q?o8cQxGuELNFIqQwp7OQT1oTqInPDQpa5zb1ZI8dlIremnGr2V3dvZrUNghpT?=
 =?us-ascii?Q?y+Jf13Y3xFLjFYHOzaTS73mlTcm6wsaxnkXUqFKpZA6t9ZmVqwX1NuYbopGs?=
 =?us-ascii?Q?PkNX1l5SwggrmcM2FSJW1HB0ZWjp1NhKkcqrom5lJ7FD8nDQaqRCWW3zSNEL?=
 =?us-ascii?Q?A1yK8qgP0Qi3qHlqPCQW1PdOcS4wn0qNVUlrfQBc1TV1AG+vvzKnMVVMttHG?=
 =?us-ascii?Q?jeBKAKr5vooyxeD/oxXaiDrA3yIG67w1Qw+CaQ9J7H9/oNnsj3ZxR4zlp0TB?=
 =?us-ascii?Q?SGCRFAM9dPSYTmKZvO2eh2y0aLcTzJYbosozAgWhmaQzulZ5UWUPNDBetSvr?=
 =?us-ascii?Q?2Agmi5SyxaNJ9uKIy+A2e2kqsZq6aniuVQFHXQSan0bwtAj/1jE+syqZ+V3T?=
 =?us-ascii?Q?Octr5WHi6n35HgjP3Ps/c/MwAYKUSlQUVZHi8FnwpecqwlnnE+Nixe3I0NI7?=
 =?us-ascii?Q?0w9jY5LQmp/kVTKHL6ZtCUVCbzauUfC7fr0eCjV3XtrmLPN17QWgigO0eXvF?=
 =?us-ascii?Q?b4QK4Bg+sDB52si1/wTnXgKHuvrFKGEge36La31Qadg5+A4fwemDSfZKYgnU?=
 =?us-ascii?Q?4RO/nRFVOPKJaSzdai9UT0vKiZqyVkhA5zLoMQxkYrGOnpKzo/B4aVsynf0U?=
 =?us-ascii?Q?l48P+Aib/mYrDOsQ0f/pKgDT4kOQeCbjrOpU1QNoyied/9LkJqtZBE7eVY7L?=
 =?us-ascii?Q?ieixYl+nSA24aqmNV0kvq0cEl0MdOAPFjrJ2NNiSu+uUTrDL7T8M8Y2H45/+?=
 =?us-ascii?Q?6B5arjj19GeXmYweEYu/SyK89MYmDyoI2ZmXoORPR21GDBTIA5q5w5hu5D15?=
 =?us-ascii?Q?WS1sZVjVzdruYOXHl5ROWlujmDZ+H7ixSZJaUIpuCV4B8AzVVFjTLGDO6/Xy?=
 =?us-ascii?Q?KJtKRHd+ImPjMtkAK/CkoKpUE+5HqYbQPQFL4b5dGJfTcd1B3H+WnYsdfWMq?=
 =?us-ascii?Q?suUEcVckhbXheXUx3XZLxJR7TvbD83eoy4sfJpunvY+9CT/t74NveJtD0UEM?=
 =?us-ascii?Q?GANZJ9buDPokqpV0LxP2FvPLvONqJXPJjWmk58zZsxNr8biWhxl1EAMtq3Hw?=
 =?us-ascii?Q?wKBRdlG0+QsUovj2qo+YSaryL1ZnWXTwOs2YvJ60AKTuE65xSkKRRKrOmWbP?=
 =?us-ascii?Q?yjQLzfCR6bfTkPnA1BQ8/vljj2PjIfB35zmJvlei63pX1PNwuMc+SFXF24f9?=
 =?us-ascii?Q?GfqX8cDadujd4qXlc4i1zm2UB67afxq1h1MciQ4o0n4h2VGvQG7Xg87Lvy6V?=
 =?us-ascii?Q?WAUGhK46ZLBOzapTLieu1wHhNMa99UBBLHX0BSmiWAE00A1R2YXxp+HIz1O0?=
 =?us-ascii?Q?4CcZljsPC5qDUHry01eM8ceKKfdmkfIaC85PBCeFmWQH4X4PZmqXvA8NQ04e?=
 =?us-ascii?Q?9yri1z0NPl2Yy0K4LcaCHKUCH29cRm0H/7VCDPiVtxxHabd/Eg8Zlzc9imoE?=
 =?us-ascii?Q?3tDEOPzzfNPsgshv+Cw6W/5I/fIOCQgOtrPD3JunsbdWea3YxPw9lv/s8RCK?=
 =?us-ascii?Q?Vs3h69AMXw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8695960f-8ee6-4698-3d42-08df24523582
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:06:01.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5q+55DTEuaXR2QjjPMZkZvCGHFlZ0Wyeb1CPHehAsH4RpAxqpTRDmaBh7qpwFHyZV+PYpoabZQDyFEjluf8yvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

Type-2 providers may need a region when FW supplies none.
Add devm_cxl_create_ram_region() so providers choose the size and
creation time after registering their memdev.

Reuse core DPA/HPA allocation, decoder setup and commit. Serialize
creation against sysfs decoder writes, unwind failures, and reset
SW-created mappings on detach.
Keep provider attachment separate.

CXL_REGION_F_LOCK also reflects FIXED CFMWS root windows. Restricting
the reset exemption to locked AUTO regions allows teardown of
user-created regions under those windows to reset programmable
downstream decoders, which previously remained committed. The root
window and HW-locked decoders remain protected.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1 -> v2:
- Replace implicit attach-time creation with an explicit API
- Accept caller-selected size instead of allocating all volatile
  capacity
---
 drivers/cxl/core/port.c   |   6 +
 drivers/cxl/core/region.c | 223 +++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxlmem.h      |   7 ++
 drivers/cxl/mem.c         |  31 ++++++
 include/cxl/cxl.h         |   1 +
 5 files changed, 263 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6024bc9c1376..741240021cc9 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -235,6 +235,9 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 	else
 		return -EINVAL;
 
+	/* Serialize partition selection with kernel region provisioning. */
+	guard(rwsem_write)(&cxl_rwsem.region);
+
 	rc = cxl_dpa_set_part(cxled, mode);
 	if (rc)
 		return rc;
@@ -276,6 +279,9 @@ static ssize_t dpa_size_store(struct device *dev, struct device_attribute *attr,
 	if (!IS_ALIGNED(size, SZ_256M))
 		return -EINVAL;
 
+	/* Keep the free/allocate sequence atomic against region setup. */
+	guard(rwsem_write)(&cxl_rwsem.region);
+
 	rc = cxl_dpa_free(cxled);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7a64a730587d..4cfa0a644481 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -250,7 +250,9 @@ static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 	struct cxl_region_params *p = &cxlr->params;
 	int i;
 
-	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
+	/* Provider ownership must not suppress reset of software-created regions. */
+	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags) &&
+	    test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
 		return;
 
 	/*
@@ -374,14 +376,12 @@ static int queue_reset(struct cxl_region *cxlr)
 	return 0;
 }
 
-static int __commit(struct cxl_region *cxlr)
+static int cxl_region_commit(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	/* Already in the requested state? */
 	if (p->state >= CXL_CONFIG_COMMIT)
@@ -408,6 +408,18 @@ static int __commit(struct cxl_region *cxlr)
 	return 0;
 }
 
+static int __commit(struct cxl_region *cxlr)
+{
+	int rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem);
+	if (rc)
+		return rc;
+
+	return cxl_region_commit(cxlr);
+}
+
 static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t len)
 {
@@ -4111,6 +4123,207 @@ static int first_mapped_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
+static int match_free_endpoint_decoder(struct device *dev, const void *data)
+{
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_decoder *cxld;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	lockdep_assert_held_write(&cxl_rwsem.region);
+	lockdep_assert_held(&cxl_rwsem.dpa);
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxld = &cxled->cxld;
+	if (cxled->state != CXL_DECODER_STATE_MANUAL || cxled->dpa_res ||
+	    cxld->region || (cxld->flags & CXL_DECODER_F_RESET_MASK) ||
+	    !cxld->commit || !cxld->reset)
+		return 0;
+
+	if (cxld->id != port->hdm_end + 1 ||
+	    cxld->id != cxl_num_decoders_committed(port))
+		return 0;
+
+	return !device_for_each_child_reverse_from(dev->parent, dev, NULL,
+						  check_commit_order);
+}
+
+static int cxl_configure_ram_region(struct cxl_region *cxlr,
+				    struct cxl_memdev *cxlmd, u64 size)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_decoder *cxld;
+	struct cxl_region *detach;
+	struct device *dev;
+	struct range hpa_range;
+	int part, ways, granularity, pos, rc;
+
+	down_write(&cxl_rwsem.region);
+
+	dev = device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
+	if (dev) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	down_read(&cxl_rwsem.dpa);
+	dev = device_find_child(&endpoint->dev, NULL,
+				match_free_endpoint_decoder);
+	up_read(&cxl_rwsem.dpa);
+	if (!dev) {
+		rc = -ENOSPC;
+		goto out;
+	}
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxld = &cxled->cxld;
+	part = cxled->part;
+	pos = cxled->pos;
+	ways = cxld->interleave_ways;
+	granularity = cxld->interleave_granularity;
+	hpa_range = cxld->hpa_range;
+
+	rc = cxl_dpa_set_part(cxled, CXL_PARTMODE_RAM);
+	if (rc)
+		goto out;
+	rc = cxl_dpa_alloc(cxled, size);
+	if (rc)
+		goto restore;
+
+	rc = set_interleave_ways(cxlr, 1);
+	if (rc)
+		goto free_dpa;
+	rc = set_interleave_granularity(cxlr,
+					cxlr->cxlrd->cxlsd.cxld.interleave_granularity);
+	if (rc)
+		goto free_dpa;
+	rc = alloc_hpa(cxlr, size);
+	if (rc)
+		goto free_dpa;
+
+	down_read(&cxl_rwsem.dpa);
+	rc = cxl_region_attach(cxlr, cxled, 0);
+	up_read(&cxl_rwsem.dpa);
+	if (rc)
+		goto detach;
+	rc = cxl_region_commit(cxlr);
+	if (rc)
+		goto detach;
+
+	/* Added after DPA reservation so decode is reset before DPA release. */
+	get_device(&cxlr->dev);
+	rc = devm_add_action(&endpoint->dev, endpoint_unregister_region, cxlr);
+	if (!rc)
+		goto out;
+	put_device(&cxlr->dev);
+
+detach:
+	down_read(&cxl_rwsem.dpa);
+	detach = __cxl_decoder_detach(cxlr, cxled, 0, DETACH_ONLY);
+	if (detach)
+		put_device(&detach->dev);
+	up_read(&cxl_rwsem.dpa);
+free_dpa:
+	cxl_dpa_free(cxled);
+restore:
+	down_write(&cxl_rwsem.dpa);
+	cxled->part = part;
+	up_write(&cxl_rwsem.dpa);
+	cxled->pos = pos;
+	cxld->interleave_ways = ways;
+	cxld->interleave_granularity = granularity;
+	cxld->hpa_range = hpa_range;
+out:
+	put_device(dev);
+	up_write(&cxl_rwsem.region);
+	return rc;
+}
+
+struct cxl_ram_region_context {
+	struct cxl_memdev *cxlmd;
+	u64 size;
+	int rc;
+};
+
+static int create_memdev_ram_region(struct device *dev, void *data)
+{
+	struct cxl_ram_region_context *ctx = data;
+	struct cxl_port *endpoint = ctx->cxlmd->endpoint;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_decoder *cxld;
+	struct cxl_region *cxlr;
+	enum cxl_decoder_type type;
+	unsigned long caps;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxlrd = to_cxl_root_decoder(dev);
+	cxlsd = &cxlrd->cxlsd;
+	cxld = &cxlsd->cxld;
+	type = ctx->cxlmd->cxlds->type == CXL_DEVTYPE_CLASSMEM ?
+		CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM;
+	caps = CXL_DECODER_F_RAM | (type == CXL_DECODER_DEVMEM ?
+		CXL_DECODER_F_TYPE2 : CXL_DECODER_F_TYPE3);
+	if ((cxld->flags & caps) != caps || cxld->interleave_ways != 1 ||
+	    cxlsd->nr_targets != 1 || !cxlsd->target[0] ||
+	    cxlsd->target[0]->dport_dev != endpoint->host_bridge ||
+	    !cxlrd->res || cxlrd->cache_size ||
+	    (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING))
+		return 0;
+
+	guard(mutex)(&cxlrd->regions_lock);
+	do {
+		cxlr = __create_region(cxlrd, CXL_PARTMODE_RAM,
+				       atomic_read(&cxlrd->region_id), type);
+	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
+	if (IS_ERR(cxlr)) {
+		ctx->rc = PTR_ERR(cxlr);
+		return ctx->rc == -ENXIO ? 0 : ctx->rc;
+	}
+
+	ctx->rc = cxl_configure_ram_region(cxlr, ctx->cxlmd, ctx->size);
+	if (!ctx->rc)
+		return 1;
+
+	/* Region unregistration acquires cxl_rwsem.region internally. */
+	unregister_region(cxlr);
+
+	/* Retry HPA window exhaustion; endpoint and DPA failures are terminal. */
+	return ctx->rc == -ERANGE ? 0 : ctx->rc;
+}
+
+int cxl_memdev_create_ram_region(struct cxl_memdev *cxlmd, u64 size)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_ram_region_context ctx = {
+		.cxlmd = cxlmd,
+		.size = size,
+		.rc = -ENXIO,
+	};
+
+	device_lock_assert(&cxlmd->dev);
+	if (!size || !IS_ALIGNED(size, SZ_256M))
+		return -EINVAL;
+	if (IS_ERR_OR_NULL(endpoint))
+		return -ENXIO;
+
+	guard(device)(&endpoint->dev);
+	if (!endpoint->dev.driver || endpoint->dead)
+		return -ENXIO;
+
+	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
+	if (!root)
+		return -ENXIO;
+
+	device_for_each_child(&root->port.dev, &ctx, create_memdev_ram_region);
+	return ctx.rc;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_create_ram_region, "cxl_mem");
+
 static int unregister_memdev_region(struct device *dev, void *data)
 {
 	struct cxl_endpoint_decoder *cxled;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8c050bc308bd..9f074007dbf8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -123,9 +123,16 @@ struct cxl_attach_region {
 };
 
 #ifdef CONFIG_CXL_REGION
+int cxl_memdev_create_ram_region(struct cxl_memdev *cxlmd, u64 size);
 int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct range *hpa_range);
 int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd);
 #else
+static inline int cxl_memdev_create_ram_region(struct cxl_memdev *cxlmd,
+					       u64 size)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd,
 					   struct range *hpa_range)
 {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index aa08d88ab104..00bd7d9fe561 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -241,6 +241,37 @@ struct cxl_memdev *devm_cxl_register_mem(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_register_mem, "CXL");
 
+/**
+ * devm_cxl_create_ram_region - Create a provider-owned RAM region
+ * @cxlmd: provider-owned memdev returned by devm_cxl_register_mem()
+ * @size: requested region size in bytes, a nonzero multiple of 256 MiB
+ *
+ * Reserve @size bytes of volatile DPA and HPA, establish a single-target
+ * decoder path, and commit it. The caller chooses the size; this helper does
+ * not consume the device's entire capacity or replace an existing region.
+ * Obtain the resulting HPA range separately with devm_cxl_attach_mem_region().
+ *
+ * Requires an unused programmable endpoint decoder and a compatible
+ * non-interleaved root window without normalized addressing or an extended
+ * linear cache. Persistent memory provisioning is outside this helper.
+ *
+ * The region is removed and its software-programmed decoders are reset when
+ * the endpoint detaches. Failure unwinds the new allocations and leaves the
+ * memdev registered. Returns zero on success or a negative errno.
+ */
+int devm_cxl_create_ram_region(struct cxl_memdev *cxlmd, u64 size)
+{
+	if (!cxlmd->attach || !size)
+		return -EINVAL;
+
+	guard(device)(&cxlmd->dev);
+	if (!cxlmd->dev.driver || !cxlmd->cxlds)
+		return -ENXIO;
+
+	return cxl_memdev_create_ram_region(cxlmd, size);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_create_ram_region, "CXL");
+
 /**
  * devm_cxl_attach_mem_region - Attach a registered memdev to its region
  * @cxlmd: provider-owned memdev returned by devm_cxl_register_mem()
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 3019e3ea5f09..b873bd0cfacd 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -225,6 +225,7 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 	})
 
 struct cxl_memdev *devm_cxl_register_mem(struct cxl_dev_state *cxlds);
+int devm_cxl_create_ram_region(struct cxl_memdev *cxlmd, u64 size);
 int devm_cxl_attach_mem_region(struct cxl_memdev *cxlmd, struct range *hpa_range);
 struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 				      struct range *range);
-- 
2.43.0

