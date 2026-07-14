Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398B37F8A1;
	Tue, 14 Jul 2026 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998636; cv=fail; b=MlMfhGfOHTFYDbh7DlG3apGAS5r/NFkYQ43v4pBcdtq6/+HdQRPPW4pB2zW3mKPiqrSD0QnMrYPgJoiBMchMwuNK3ZHSH5F8PHIZFnDv9S0QDXCJRcHRr16Itwm8nP1SUoKRrZhX712C0kgE/mMZyUcQaih6Ve81cNLW4ZCdTPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998636; c=relaxed/simple;
	bh=jp6waulNFY+PKqxNtLiz0G5Yv4yinnTGp1/blgZ3KuM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NocUsMJQ+9YFUuf7mAwQcSjCCIDBV9gf8PpeH7sPetYV9JTMxKZRTwXGYlLEQYG7P11OsKZdx5rDNbpbsvkNaC/7sDFWBjZqEiVDns+N9g4l2b26In0BCS62QKDy88EEWtmNblOVRvX2BbBXaoT0tgYhbBcVGho/c+yKfoExhRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s5Duy5bX; arc=fail smtp.client-ip=52.101.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s5Duy5bX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsiOMoke49hQkN17J0dLciWy45EtF2qlHTy0+sYpZDUimdzALSeowBNITrE7bTqVl+iBP88mtKUWO0/sKcV0o3YaI9kY41cWQFi4ajLcmN8EMA/hYXr6IAZak0bBKFMvXzIAIpJ4Xf6JGrRPY8stb3t5RvG3ISNDebl9+6mhOLIxzqxBSazaZbqeuOJyK+s16tS7Llqmi+hXpNdNJnBzFdPpbknHBVZ2jrDrFmL8WJpY00spPqTcMsrA2Q47G94xE3cI2FIUhR0Zd9dgMNC6qoCOCxcrXc5KwTj6NT4QwHkax+EzQ0fKIc7BsgZPsZZncwnhHdZt222VOt7OzRibKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15+6ggWkckreDxzm90U0V4wbHS9O1YOU5Ld//+uBDX4=;
 b=llhsRh3RudDfX3WU/VJXMEqIB6MovOkt17TferMHRtHg15SL/A0oNwbPDG9w49AcbqR+ly0amXScYkAjCZQop0Gzmi75nrGa+RT1Jc0/67wHFW1yxO/kT6RmsoPqEBp3r+/tKUvK2UCP9U8wDfIxqo++LdNvEwkHEEc2FrOyGhRNtAQMTR2dmjJLPhTiSwm/5Fgrc3E24L/UPCU4yBBwBOkI+FUYqCdDB9nor8N9nH+QxRLbB0RZhN9Ep1XVLbEq3+Zlfdg5SPoF9c61Q6KQXakbAXTMDJ2M3MQlNva5qtTii6b7USMIDWf/v3P3hqCc0QFgcdp9/c13HC3KXtjGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15+6ggWkckreDxzm90U0V4wbHS9O1YOU5Ld//+uBDX4=;
 b=s5Duy5bXqmvhrH0FK1V2vWD6gRK5BejufFWjFOmQMH02b3n1041RJAOnVIHaw98jYexw/WT3Kr9QFYhqtUx9F1IyYwdHf5//ce4NRwVCdr9+K6FOdtSpkdty6x6Cc6bWKvU147sosohdQK9e31MIGcWNYMDO4Qq1+4KDdQobjWJ0Nislp35d9YIlk4PjXluGKHg1iGyi9wkVdvnL5LfVwFfsd6faeskUmePS7In0Qh21BErauuGHMyWnyYXyLSUch6SVEMfCH+JqCetflQ93AeexX7bydMxVylX4QH7jg5UI0gDJcVckr0Ee/R61BE0QwUerDHeTUsX9O5m1SAn25A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 03:10:31 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%4]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 03:10:31 +0000
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
	shiju.jose@huawei.com,
	alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] cxl/mbox: Serialize RAW Get/Set Feature commands
Date: Tue, 14 Jul 2026 11:10:10 +0800
Message-ID: <20260714031010.14834-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 69686f81-80ef-449c-0c2e-08dee155755c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	03HFujTNX6k/debfB0eaACvYNyGJLc+qKW30b7ZUDvAtyLUzEW2u3ZfmsQA8fP0qKhriXZzXO28zxiDx2nGTxExddBQxEvOxpZc/8UOM3N9sRTrWVcDlgIFxvvKz//UJ1FxWYs9GqGlb00nzAvNC7oYJsXINLH9Uj5AtshAlbDO/MB7MBC0WVenAQR0t8qWr34Q+3jziXw8Dt/ACxz3ddUQ4MZxrCPcypP4mWPtLB+m55x4bnwf/wV+zRhjakt99gnPsuijITbra165yVQKgG0ZP9rX0JG85ChBo6LbFPF0Y2vXdm8gjlku6qf91gyp2NTpOXA8E0b8aE8QJrO+ANqxo+2HtWev1i+3nBuIydjcGZ1qBOgxzvAR4xsghjlipYMl84KKe7aQJK9H6qHEPr9MzSxTp2hR6XmeI9lq7ev+91HNii2p/oT/SE2pCEwRvF/4hg8h3sQ/y+Sqb04S/CgevQ2Hj32darOVthKERbvAjQwE9AgaJNcJe/QRrmmuFOjbITGrR/LgfaOJoTB2BEhAvv5Yq1OJm/2SnP5GC1tVJfNYW/bhs6ZoQFw0hcRRL3LtSBjMB87/w3Qy6PEWIJ28jpNvsp/HOhNuwnwCszNRNII7vxg8Q5z4cDucDCD2D93HgBg3PtVfT5AxI6c3L7OVNs0KovOm6zZeHF28UxQ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ty5dX49GaHFtu4B1EnS0TuICEWn4xSlik1JX5bJqOij1p3BhpOpbZhUf+Zw6?=
 =?us-ascii?Q?rgaMV6Tvr3Mpbfs2VcGffsa8zGKkI9m+/XTPiusCyE/qmcliIsuF8HTlbsR0?=
 =?us-ascii?Q?u457jSOczKDBEF8jkwcbE1+7YwJ2Zkp6hv22+Po4KEwlN8gbQpSfuIU74Eio?=
 =?us-ascii?Q?kVNM+uNXsbVFJJng/VG9z8lMw5aXMSSv4udJ9hVIlksAw5WLFYt0TVyWwsfX?=
 =?us-ascii?Q?QVnqdZadwAloxiL9a6WnLSWSZ4c/xzamLgAsNXxuQagnBIbxdTk1PUbNArZ8?=
 =?us-ascii?Q?Fivhv1nK/PryYCo9p3vVErUTuB7ANUoI5VdejyrDWkgGFpARUCQ+R17Lhkii?=
 =?us-ascii?Q?/ApY8w7oid9Y+un44qGHmJ7FxnjmvxA7jDZ1DPRjS1pkrDliI14h2xAb+vQm?=
 =?us-ascii?Q?xU2C0IWRi85fAYiUAuncY62ocAPboYo7+PscdttnGjoRqirbv1FvmXBMtsuy?=
 =?us-ascii?Q?OpWzqqYyruW4iQnEjgtblXc/8PKaB7/aeyFR2UpILUS7OKbpcprAieTByFEu?=
 =?us-ascii?Q?STCn1yd0aGpVNSMJwr6tIt4l5yknZIGvz0T4/aoCQOaeDKheQJnsoDGUj4dD?=
 =?us-ascii?Q?QLoPAERJjmnAIG0RWI7S0MGVevtq4/Dto2kyGJewpwgUIXfzLGXhe1MJaaJL?=
 =?us-ascii?Q?TvDGOkYDA7pB9U7e9wYpH5yfheCnY0Uc4bhmg8c3nKG80stn8I139Ghj/j5k?=
 =?us-ascii?Q?F6NqRigaGJOy35Y059HC7xTK6WDXdJZlzKo5O3ON3l7GKCOGG22GbTjLz421?=
 =?us-ascii?Q?5NRsunFFkl/dA4mrmbjC/xLHwb8KDs228M51MmMddurgFUnphF0DoawsA9pS?=
 =?us-ascii?Q?I+HUWp+9GDgJTYwTxbln++MM4Rl/GXbEVUVNeEknTsvB9AAkQ4okJHgUBmMZ?=
 =?us-ascii?Q?P2jvVTbuWpu1FCl2QydgylF2Lm5F2mTvPwHj4gKAK7sWd+dCzJ/3fiaT9EpP?=
 =?us-ascii?Q?o0yoNbL+Delnkk0rAIUFDu2jCF5rEqRAwmY5RnWvrvfHeWQ8dIm1nwE+GZcJ?=
 =?us-ascii?Q?kj/6UDRiqm6Qk+sCW+NGOkiAXPFj2Xt2Wyyp1sVbYS4dFAvSjYBkjL1VcWDc?=
 =?us-ascii?Q?9KgisscADXfdnzcOveazs2sIKurSpXmuYX9Ag8zkSbUSRbl6XJiWokJ6iv22?=
 =?us-ascii?Q?5cMS1GU+eZeFaaIWYyW6lwUfa0e8A03lSG8lB6whLkxI64bUKjp4OIxzvkik?=
 =?us-ascii?Q?QsGBL5p59PyvEF1xHTsWAKcxkeAy91XD4dw7Yy8rFxv5Pxmj2YLxShMit/8E?=
 =?us-ascii?Q?/ism4NFGCaJ1SySDpZGLe9VU4IANzIdIDkwmzOyaP/mlmgePS4EPYsuyecCK?=
 =?us-ascii?Q?yYZLg9cjfFxPi+4V0TzmqzSxpzWAzqyvyRGRo8TPJDu93+MH25pTuU7G1U5L?=
 =?us-ascii?Q?HWOwRHg6SVXm8stiRdqTPAJZHmvZoAaVNHcoaCSpvj8Cd88MyoCUj+tWlR8l?=
 =?us-ascii?Q?uCcSFpeRO/UsV7d1aZX53bhkcNGciLkNTS+nA6XRW6TEU6SVJZOO36BeHc+1?=
 =?us-ascii?Q?VPsg8muyGRB2MZDL1IvNnoKuR1pBVFIj13dNWyNBBbxv4zRoxZDASotldmCM?=
 =?us-ascii?Q?Xa8hlwodxOI8BYvbWtwPodOqG7/DelRvGfB2kyjrKj9PadBt+5FNCeOadU1E?=
 =?us-ascii?Q?IGwor85tMiPl6+akPrsUOvI6De8WnyCP5BhNxD0InIBZPAlKw+bZcAbpOWkP?=
 =?us-ascii?Q?IwYThXk7+iZlJooMgKORKIhiwddzOs6gYvusue5bh0kFKaQJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69686f81-80ef-449c-0c2e-08dee155755c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2376.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 03:10:30.9489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuP7aU6iSr9zMQqBwsysZ0SNPbO3aXIMhexqAKdY1j++CQTfN265mp+OInEsRJZf80hJFshExPb3z8HguPYMyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888

Dave Jiang's patch [1] adds feat_mutex to serialize kernel-managed Get
and Set Feature operations. However, the RAW command path calls
mbox_send() directly and bypasses cxl_get_feature() and
cxl_set_feature().

Take feat_mutex around each RAW Get and Set Feature mailbox send. This
prevents individual RAW Feature commands from interleaving with
kernel-managed Feature helper loops. Other RAW commands are unchanged.

[1]:
https://lore.kernel.org/linux-cxl/20260709155841.1895915-1-dave.jiang@intel.com/
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/mbox.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0370ac39ec4a..55b0c3ac1ede 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -599,6 +599,8 @@ static int handle_mailbox_cmd_from_user(struct cxl_mailbox *cxl_mbox,
 					u32 *retval)
 {
 	struct device *dev = cxl_mbox->host;
+	bool is_feature_cmd = mbox_cmd->opcode == CXL_MBOX_OP_GET_FEATURE ||
+			      mbox_cmd->opcode == CXL_MBOX_OP_SET_FEATURE;
 	int rc;
 
 	dev_dbg(dev,
@@ -608,7 +610,11 @@ static int handle_mailbox_cmd_from_user(struct cxl_mailbox *cxl_mbox,
 		cxl_mem_opcode_to_name(mbox_cmd->opcode),
 		mbox_cmd->opcode, mbox_cmd->size_in);
 
+	if (is_feature_cmd)
+		mutex_lock(&cxl_mbox->feat_mutex);
 	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
+	if (is_feature_cmd)
+		mutex_unlock(&cxl_mbox->feat_mutex);
 	if (rc)
 		goto out;
 
-- 
2.43.0

