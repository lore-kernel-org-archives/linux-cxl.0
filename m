Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020E478E45;
	Thu,  2 Jul 2026 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983350; cv=fail; b=NZfx1bcSX7F+R2tbxfyI8IJqQddUzUy+TTwmuzEZU3izOhWiLEARjXuaWv+GkCkLoubxEkrZBREKPApRopfY3mCK6P6ICrRD83g1IEGK4pZuVQzghghFUbC3RG8sOKfkXAiTQmAKNosGnLO2yFIS17/pRVdrCZhCEMEDjTDMEcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983350; c=relaxed/simple;
	bh=B5LxpnE2/GXazolAdk0Ze/riptIcEnXQOySwETP3nIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cuBWPju71091gEZp8Ebf5NmgfoMTs/OoDrqtS/m/LMQAM3uc+BtFCBKvBEKFOsEXqJSCGIy/ijAXPOJ+82GF4LDStk6wyGkSn8OJFiZztoyzyiq/2HslpWZRa296HgrHJlNhY/uydxRqGjk7+OfeBS0e8gh9uhdlLXvaoBupz1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NM4ng0p5; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NM4ng0p5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJCtrPD4hA19n/STEj75VqzY7rMMukGJyCyYakvxndJXzb8oZABPfh/L8mavceoGRRWArEuDTxK32/26U4JfVp3+CDyOnX53lybCBfb4Jhz3It7dHXRT6BgWwanAU6t5M+XH8mE50tMnP6n1LidNWlCzqEvEFiRHdO0wycbhbLlRQt8Z+AxueNLyRaJ866NjzLnmDljVYPSnGwb5RNT5qEWBit9R1nHRdHSZ9yUlrnUQSOEnY3E2qSpGy19rhs3RSalzhxMUnZX8+zfo4S2M2T0Ku7tKQDboc+00gfLDxoEd2NWiRalBaPadGcrEi/uzEGcNsRZQuk2tbDYKPhI9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8X+tfZ1lBomtXYKmdfKI3WJOXFF1OKFFOmLWl+s+BeQ=;
 b=Uu50E0m4897RE46TSWpHjnMWScInLVRgSQxUAL4XIhiqlWROv+enpXUE0t4sZWBE+ZveZRYeI2kOfkBDVhdZigcrEzYbCdbEWEngVfiNcFz0dyPBOUuoF+eIzUb9bAV3SZTboubypy0n3zTlbPQQcXONvCYeospY0W7EHWyZbGR5k40Q1b5xPImpk8Zz4yfk8l5TLApG3ojUneg3b/h4b7bgUkBVbVW8Bw4PSoKOl8f7eJgJJ1ONUiIg76XDGBLUGH/8pTJShs4v8VcZXsFFvgsqxorUYw1IJd9rr6jyiKHCq7XNnAJaEy3W+SXHpySJjHpjzwrwB6oHK+E7xByGhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8X+tfZ1lBomtXYKmdfKI3WJOXFF1OKFFOmLWl+s+BeQ=;
 b=NM4ng0p50v4ArmpUUIgTUXPownBVF4M0juYsndnuIABvj14H44YEJvA8j0Adm2ENdIe28OWcHCq1LnFcPOMMMXvqh3KLZEvbwR/LibYHfZ1ZWlsHTr3IOT1RqQK7PgMG9jtS1HFMDbPQdFmO3k7PUTyJuUBH8SRUK216eo0q6xFqQI3dhOCEe+AtM7q1p/0zp99aHds+JsPLScUKfqGFHN95zbvRknM0zNnVkHcoAAVwZ1xpnh2/3Gkbxt7nyc//pvn9ZVWngZ0D3QdlQWnH8JMcdmk5OdGHBIG6LsyxYTTqBKWNoz9rFpmi1eJ+DZSbHMdrW+YiRgWd1U9faghDfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 09:09:04 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 09:09:04 +0000
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
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2 1/5] cxl/features: Reject feature offset that overflows 16-bit field
Date: Thu,  2 Jul 2026 17:08:45 +0800
Message-ID: <20260702090849.47501-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260702090849.47501-1-icheng@nvidia.com>
References: <20260702090849.47501-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: db18f2f5-e4f8-4aa2-646b-08ded8199048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4qXpE6Gkk6aX7WKH2FjMpmJmICiYNGduViARJnEbcqTsoj+ahSPkqGn4lkFE6XpJDZElMUT29W6EsEaGKiXe96+gYSFVMYEi6/67E7BTCb8yc1Hxg/umw8z5qHrLWLoUri5kloFxvGYL93660b2XDQSoTahOl7VnwMnp6oTIbs9N647e1vnhY/KfVYoad3rw82+XN/+YColdkny+3+bWQSQRVyzG88P1OOKZ5fBK/r4BiFSBscIdPQYPCxS2r4ktbr6/ibQZ4FcaT+YZSwLr7WSrOu4dihAAdnoKAYg9zLjECgPKYZ5HQ/M9XVJzr849p9Vd2zSYcEZ4bzpu3nAonz97I5Xift2ZVmDeo0p7UYA/I/aIyBZPQn2hsS94fe97fUuuhimng7NmNHyxGW7fSo4UodtDEBg+kMIbPdAjXqfgV65tIaE+PuUKqEuK/wYgYKEX4rOykEqkkbAlI/E16omG06ebuDCi6Xnc+i6V6LVrVWXo6fYyQKFNJv8WBAHFAlH0o4n/6j+Mtz/xzKxn59gkkWgQf4l+Qen8CU3J6DO4yTVvULA6CXy4ZSBWtd1ZaH5eE4To69HzSs1q2dak/55f+O1EaMpf/ZcxkY1okxVUxuO1dI4v08CRnYzWGq+Zx19fFLTKNzbOiMvrDQ10m0nnwprgFwrAiV8k19FgEZ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aezb6RruS+WzM8PquIseGeKP4yw/SYwBXtrXmnF++/UQ64LOPW+sk7PtfCtO?=
 =?us-ascii?Q?ZRxukB1T5cy4SwaQLozct+wYCj9QepnTLyvrcAe50/nYy5cqAqg5Wrv03d53?=
 =?us-ascii?Q?ikbEFLefcF+sBk5aomzt1zIiYT8KMbaHXmj4X4kSQunuw7k91rfLFxmoi/zN?=
 =?us-ascii?Q?0Y010yue52nQTuDAJ2M5xfjR9KPsq/ewOzTwwuIT+d0gfvN1zXyAW15gyWuZ?=
 =?us-ascii?Q?tncp0PhUN0R5nH3MqMh/F6MS2VyrKLtpzMhwvmSiRcNUINjl017HusdxwIvD?=
 =?us-ascii?Q?jUaZxFi4V8rmgs5B372u6Qodnv4mFiht09JQECkiudISyARH2hW0pDiRLQ1E?=
 =?us-ascii?Q?G2f+KGoZ2MB5YbTdFtrpOkPD6jPsCFzfQ/Wri5krhEHntyc8aLnUCEEHuysm?=
 =?us-ascii?Q?AyVnvPrbtTsvxCbdFUIIQz3iS75ZiI20G0o5TSGOpJH7FeMSIUvrJ9qmr04h?=
 =?us-ascii?Q?/D9Iw2/yNdZ++qAKXQxas7STu2hPzrySfEpkC3qk+W67jCp3XvVDF1rzO1l9?=
 =?us-ascii?Q?U93smdERbanABP2L6PQr3JqkJpzq5syoW7WVw5ixOJQRIO7Srqnj1eqPAgNa?=
 =?us-ascii?Q?847vVH5v/UDWbBOQPsxuqHoICfRku/juL7Qvvjb94Wuo/wroCunrJjcr2G4F?=
 =?us-ascii?Q?IX8BqvoP36wSrUXqANeoFwIJfGwqc+SbWljMBY4rhb1jzmPWiaFC5jPbv9v3?=
 =?us-ascii?Q?KiF52mlYfSDIzBx4KwW6gQu2FQxMW2dWWi+PjeOpiMcm7VfGyRayonFR8igZ?=
 =?us-ascii?Q?s0lGoVkyTPmuT6UWZ+abb2HaGXV6nLfBOLg7R2ZbOeyCLZCoPA0m2uGn7Ol9?=
 =?us-ascii?Q?gsWI+Ahu8G9TkdNJISp/wUjgttfVFawKDkJAo4NzJ+78AYq/XML7eO15gWgh?=
 =?us-ascii?Q?Xu+OM6E/6WESLoq7QI5g7wbiez8KvLUGds38RLMgcKkDwY61h0NE0otRwUHh?=
 =?us-ascii?Q?N2jDaHoC44t3Ec3P771kWu2SYSqw+k4XDZKssqBtsmEdP5uhSSscYjry9no1?=
 =?us-ascii?Q?fdmiM1QjdgDn3MhyolBMkwIgBkfPvTu8RtX9mOxyRpES+pn197/bcAvDeCbD?=
 =?us-ascii?Q?nr0zfoYEJcKSOPFF3zKCpy9b0LirtVQSDq2xqWyrDd/U54lQESEQQJGArCuV?=
 =?us-ascii?Q?tglZSa4lAHkdwTKRJ98iYQUKW2CqEwihRW8H+Xbw0y0j0O1sxm/Ea2fuvcro?=
 =?us-ascii?Q?THYJr9lrJ1EOVCQXjwwl00wbU3uJkfBcuOzOwsV4ezBx9Yax6hu1ZxEZJQ3o?=
 =?us-ascii?Q?o5rAM6ehv6yQJaDAOSRD6A6Jfn1zI3okPawOg6baY25Bu+DRWk0CXZT1fGAV?=
 =?us-ascii?Q?0A6FnAo7iezsReNPbqUBYdpMGsN/rkksq2HpYd/ae4Zh9CHswJ4H82xgVivY?=
 =?us-ascii?Q?gsGG4rQBM2niOjo41Cvk3xK+310N4DyiR9LbZzgbnCoiEFtYNxYpK9+WyRbP?=
 =?us-ascii?Q?2NjgMtYJFYxgUiL7k9bzW+CB5zgRyfHxvrVTTUOnIBSruDHXW+sI5mEMQ7HT?=
 =?us-ascii?Q?x261PGMO0HqNZvqMMXbihTe5IIPC/pz1Z+95Z86NIwUOMKNnLjSlwI2rrUud?=
 =?us-ascii?Q?/PLJFWN20KxqRQl4ZUUwiM6pE7D1p+pV4Y72DS+OVKYZpBYig9qxqqdMjD5P?=
 =?us-ascii?Q?uR8ITbpbgJzMA+5Hc+dNrF1TA1U4Af8wANXRhKILMqAocxb1npqhxomwTi6l?=
 =?us-ascii?Q?pILjz3MxyhNfYn2iCXwYoxlOZ2Y6iOwSjP6OMAu0XIDA9Jod?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db18f2f5-e4f8-4aa2-646b-08ded8199048
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:09:04.5817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VztTZXth3hWXPLDSvslplmFEalREUeBWbI75jInOveOfJz3XKaLroEQVIW0wBBiTApC0yU7YGw2dtrTSdgq4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

cxl_get_feature() and cxl_set_feature() build the mailbox command's
offset as cpu_to_le16(offset + data_rcvd_size/data_sent_size), but never
check the sum fits in the 16-bit field. Via fwctl, a user-supplied
offset plus count/op_size summing over 65535 silently wraps, steering
the device to the wrong feature offset.

Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - refactor the guard to "size > U16_MAX - offset", the addition is
      performed in size_t, so on 32-bit arch a large user-supplied size
wrpas the  sum and bypasses the check. The substraction form can't
misbehave since offset is a u16, making U16_MAX - offset always
well-defined.
---
 drivers/cxl/core/features.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 85185af46b72..c3d5f88a4e04 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -237,6 +237,9 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 	if (!feat_out || !feat_out_size)
 		return 0;
 
+	if (feat_out_size > U16_MAX - offset)
+		return 0;
+
 	size_out = min(feat_out_size, cxl_mbox->payload_size);
 	uuid_copy(&pi.uuid, feat_uuid);
 	pi.selection = selection;
@@ -287,6 +290,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 	if (return_code)
 		*return_code = CXL_MBOX_CMD_RC_INPUT;
 
+	if (feat_data_size > U16_MAX - offset)
+		return -EINVAL;
+
 	struct cxl_mbox_set_feat_in *pi __free(kfree) =
 			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
 	if (!pi)
-- 
2.43.0

