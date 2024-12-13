Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34357188CC9
	for <linux-cxl@vger.kernel.org>; Fri, 13 Dec 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734075725; cv=fail; b=GA/aOVw06llXWIWeEk9tTnQfVBNn+54LWUD4Lq9+XYMfC6Ig8G+eQHji2IcXDlMKUhtoZLrgXph7X4MI3AYcN9RxoiFKlT0uZ5NwgTdYsBO5Sr5jR4UDztJWk/KlIptCMi4Gpl/UcSvoxsVxQxUQpmwaYVCODlqtRysE7srEr0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734075725; c=relaxed/simple;
	bh=B4e3gPQF7qN4u/79b3x1lMPP7du05iTtXrRhN0NUU4s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l6qfZSzYEUQmONl3a+pc0UbNqfPx0NulXvqehQQ8OJRNxUxBjOap5hvuysb2E4hV0myXLXFi4/zP7gK0xCKdPEXBSUv7W6/5dSOWl7kcn380FlyOcB5WgOGCG5dRalPwMiNRzubpyeFpIBDlSSsNNPHjM5HnMb0EXZY8imyCNqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i3TJUqfg; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i3TJUqfg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU6f4nHVK5Hqo1GmM3K5qKQxymO6riN3BjQsXo2sijM6BbmB6+MUkvPbJFqYZkrCdTQQqc8AxzwQPRNbyyP3kpwxmXlgyjVk9JaUbqAB/9JkAv05vKZYzipUmyCdJipIVYyXLlvW7VRshSdbF0i1rDmB0B2jKiuCjF6V8hf9llTbxe7eVsoGPafwJp5Gups/Pz7uObs83a1rYribR9gEVmnICOgBhq8ys4v3vpKot0sXGpEq57E/LWMgo7RYP/Da8quFzfCQJR6xi/iQGCLZzoLht/NST601QsvJPVle8g3fNXJUDrkcTCf+D46D6Q5E5/gSiuIwbmkttvXV8PjALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJjb1yHwUTDkr65upBvf2oQWDcSqw+92huFQ8C4W7QQ=;
 b=wE3uQEeJp7GU66NcYOJ66D5TpoLDiFQlfw5+zaM3QzE8b0cb8sfZeHEgzN+Gx/+NjkJFUtlkKDaxi9esxImulxTOVl1jd+ltyEVMq+8p4wsshSFrHfLTqqaojEd6ovUMvqRnNhGCaHrd112IDDOTFAZjMFCfVWOCuRBS5xHidGsOFUS6QuTKHy9ObNlN+Qbq582eFA+8i4ZgwEuzlROrSvEmMD/bhB94jJzQytK+vHfH/h1OD6h4kTiTSrIJZR55n7W/5wajYadV+9GuuUKd9rwxxo4EoYcuDzPRJNSmcRfAS73ToAxw5zwwiK1a6YEke1CmjZKvnwtX2tQLa/xruA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJjb1yHwUTDkr65upBvf2oQWDcSqw+92huFQ8C4W7QQ=;
 b=i3TJUqfg/mxGoFlgNteBEBYsJxzlfh5alqkeNLhNNv1MlLB+rxVfmhFTJv+8HjQxuvW7vTyzvW9X2bcny8nt1N2AhUfyc7+pcM+BVJVcMy4uWZr00IVkfqhE0TSviMCMm5JXop2I/A/MdKsisR4pQ/fRbSadaFu89G6pWr1vHo9eZNNM9eQlMcksY9IOc0fy0+VmEkRNpVVc/fpIJRCaDpiWpEg4Irx2KFHA/uWCrIEPt25yK9mnr/CHNZBfD0A3kwM6ypUPtx0cjAvbmSiPMzBz0ERjYf6u95udyZdgyMhWI3HTZqNwl9V/tiTz5u/TamUqHJQyvuRmPUh4V39G3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 07:42:00 +0000
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85]) by SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85%7]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 07:42:00 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: linux-cxl@vger.kernel.org
Cc: vaslot@nvidia.com,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [RFC PATCH v1] cxl: add support for cxl reset
Date: Fri, 13 Dec 2024 07:41:43 +0000
Message-ID: <20241213074143.374-1-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::35) To SJ2PR12MB7963.namprd12.prod.outlook.com
 (2603:10b6:a03:4c1::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB7963:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dd85bf-091e-426e-ad97-08dd1b49a0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tTBmwuVC0uwd5P9I4ZEThi86TtoQXrNLcCJTSLox7P4Fq5qaRNforV+FW0AM?=
 =?us-ascii?Q?RBHrcnB06FylNqcctP5SOLIFYcKq661W4ZIPisiMm87k6xL3jnIlJI0b4y6w?=
 =?us-ascii?Q?Mfv3Dgr4imZaSNcBvSWHYf7pXm83p7rFlWbiy69o3tpk7eBV6IpheTHbNHik?=
 =?us-ascii?Q?ld0ihinbuAfuq9xAxLGzbQIs9XM7ZnBFDTpZsPRDH34kTsqDirHZrT9Cbhl4?=
 =?us-ascii?Q?HtPfCMIk7ulcpT5RGaVv2+eX1JEYPHRCQ3R1o4vBQH3ZQsGTwb35eMcNH1al?=
 =?us-ascii?Q?VOz3Uu7kfVnhP3wFRjwiunyYh8q79qz6+QkBOMOu6CWYC8tzLZWrAQgsK3Lx?=
 =?us-ascii?Q?qKPzHEFwrz+pw6/rRQVSpGkLWXwRwSIkPjqVUREJd0KdYU5hkEilj9ZoakbM?=
 =?us-ascii?Q?+OIPZhjwzexSlKVKWDG9NrKD3jfpchZKerGgowEKlLKa33e9sSbC/YEcGq/W?=
 =?us-ascii?Q?1Ls+EybUcStYUIwanvHWph0+ijaY/2tCCl3gNFLGYxk806A97HxrI9W3OsXj?=
 =?us-ascii?Q?waYLTgKJoK9WXheupaMbYLR0wLryuEz1pn8un6ZS9z2MlzxAzy5zspsZnzJN?=
 =?us-ascii?Q?XzGvyZCtnJ/Vz+0Ldb58im985ABqrTqvXd6a5mimoR91KpzsLLRnr+6CdBkf?=
 =?us-ascii?Q?CtKMoXcZ13kKkJImEYPPjpmXSffrMD936DhHMapsOBHpy/Q5hwIRLi/NhOTR?=
 =?us-ascii?Q?nL42ORS1T1bnue6yHGWue1NqGC4+74mGpoK2WV+Chll7fuanWCSM+r3qb1iQ?=
 =?us-ascii?Q?IpntoBfcTiEFiGH1muhHJxJNsDJcRKso5Q7/nq6W/p7RCmoweKlxqPIWkyzP?=
 =?us-ascii?Q?rxJ3IWwEaAqQ0ihkHTKAEQuNYaYaPV5XlK49PMMKxwtAZNk3bXk/XU1v85Lc?=
 =?us-ascii?Q?a0PD9b4Xd8rRieSVp8fZGZ4M5PCJ2848snUgl7Oh2Ago4r47/CQA/09qpL7h?=
 =?us-ascii?Q?OQxYED8cCE5oGOoNOHRQ/i3q+6I1p8gWslnnaByAbn9x3jXwh8C0OLeup7/a?=
 =?us-ascii?Q?Q/Jufs/fawFyCQBkq8c0gCFbVGbaxO9rOZtOvGGuf+nXPKovnSaDbHbyMYsD?=
 =?us-ascii?Q?LHMMwDgmbGUQcAOAgIpIrXPUaFt15/h9EvVZAuijcwDjb+EUZfWS4ci39O2g?=
 =?us-ascii?Q?wwzl7wgQtjBtXl2sQP69bTKLgfaNGPiRInJxyIVXCq3Ofvy9Iu/gLb1qMdZy?=
 =?us-ascii?Q?XvjxGWS7c7xJLnmtLZQ8bK+utr5YSrhKoVprIzOJlr8H1gf8NkyU1aEIGBej?=
 =?us-ascii?Q?jnbe7cVnANixDoONRvA7d68ytP4JCV7gh0iaiWz+Y7+cTFnjCRucROT+SHbv?=
 =?us-ascii?Q?Az8XW2woqoUYtTg9CTMLQcgMJtly7+0yk2oacKZ1VQrS0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7963.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qShAIGxlcQ8yif/BXQPTxFI+h7anx5r/6c40o24RmvpYtqocYvWLXER7NfXG?=
 =?us-ascii?Q?el2hLNztWBU5+ZNDn+Uf6UuWdrhAuCGcmAWfwvCCnqgxsxcZj04Dyst1yQ1I?=
 =?us-ascii?Q?NrkfGzd1TVj/14tvl9MyQTAl+Ow3zy8wwf4FL6d6MALVTAdswTwl+9KVG5x7?=
 =?us-ascii?Q?vHfJwhyT5y5++JdsOjOQBM81+n3hh0piIQ/vwSNiHDs5H5FiSPuOZRgnLML3?=
 =?us-ascii?Q?GKFiiOhiCVDkksQZF5ESXk5Gx3QP7mzr+16jyVbzeW6bbdWsGSvs1WZ3i65J?=
 =?us-ascii?Q?h7r2bf4cFR5iTjZrPLfoZF1DiYnYausMiNV+01/N82qkHgAcb2a5KIqt6kGo?=
 =?us-ascii?Q?Y4ylacr0u7nys5B7SZ+gvIbaOTu2aJ/PazKo6+zPTFWwARMP60gYcB3E+I8s?=
 =?us-ascii?Q?qQr/XRkCu2ecLM4u6770is5SP0gCzllW70UUjtDLxGcy2+XXQIIaxYNr2sBY?=
 =?us-ascii?Q?DYERL7eo3i4i+tQwSoa2ILRUs86cxeEz44VEeHuxhH228Vad86WbRbUeWA4o?=
 =?us-ascii?Q?35VRIYKJEah61i3HKf2W9J3dmVYSelPkicbIzMMbpMjVy78kMxhbJcdHKQde?=
 =?us-ascii?Q?RjgGblJg+GIJBYn9AWYBr8JfgJog1dINxA+6EBP0sPhw22h+2U5OhdQnFGF+?=
 =?us-ascii?Q?WRhLJnorE+ZWiiiNqUycrQRJDJHhU9/vE+6VvbQbxmmKx8Th5GR/Q+wzmwpA?=
 =?us-ascii?Q?IHicUVMIMzLnKWc7oS6pfUg+Ggc3gwWtrKSUL6lQL4Pvaz09D7ZQXO4WGs5v?=
 =?us-ascii?Q?2lx6C/Nk3RyNA4fStIHgRcWNCSp9JoVNTtvsaWR0ViVklcaQNLJGOQFuzF4+?=
 =?us-ascii?Q?swoa49Fdaa/8vl2aXnw4K/n+b/ZCZd4sspsRHy+iKzFOVZYed3fYLvSJlIfA?=
 =?us-ascii?Q?QgBB+psihZhKevJ0rJNf4MmirsUmq55XRkAYTEKVrlklnhk9npRvcKqEa/Wc?=
 =?us-ascii?Q?30O+rRY7/woYbg4O2XNt2YDRtyNaqFSacZ7pNZU2iBrbcV5kJcOgQrt2PBNq?=
 =?us-ascii?Q?WrUtIWZg9PeadJqolGHz30FBB7ArtmS95KCICYDfvblsZYErMg0KLzWcm42E?=
 =?us-ascii?Q?4IXmYvu8NuNy72kSigbWL4k2jK3VvaQLyai+jjHYfoDZA3fOKd4MKLArv8e/?=
 =?us-ascii?Q?REp2rDddB/VSR/Y83wkAh2jRFaT9JGEbAMNMr9RP1TlXyHDB8wro3TeNkz6b?=
 =?us-ascii?Q?DLgzWDyXdmTyA7rAqllxCR+6kcj+T27fMqOoYWVPtUuMZb6HUgjfWj3PR3R0?=
 =?us-ascii?Q?oamhNaHWRZhEJcdza0zrgkwUkFfW3kaHL08X/Vf9BDjVAXXPmwoCOgUPome0?=
 =?us-ascii?Q?j4i0+SD3drCc0cBY+21L3royF8Fk6PGaHF1OiQErx+9I0nLhwvVaSdvEs5vk?=
 =?us-ascii?Q?od1hkIzrPG+jrCGiEYt4xjfA7UsKf6+/4itsHEte7ncgU23t6iiV0YsCVmpt?=
 =?us-ascii?Q?jueMDjQZ1X71riD+HGEhojc7uF77xEzKzoRVCBE5AaLy0K0OWepxHt72UJDP?=
 =?us-ascii?Q?Q8lGrxEbHR2IwDHg24PUCotw9gMD2pkbwz55jhwdjAKghI+X90SEyHl0SiBS?=
 =?us-ascii?Q?4pSvfuXjQpAW96QiX5mWuYxptxs88RABuJ2CVpAZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dd85bf-091e-426e-ad97-08dd1b49a0fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7963.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 07:42:00.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q910YRul6tC1zmv0TdZJbKUVvyevyiPhYkRpDx1TAdPf+0xJ5Kjt/+aXHuca5liiomGcOnOENxwqouYLIz0Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947

Currently, there is a lack of support for the CXL Reset method for cxl
devices. This change adds the support and implements the common reset
steps as laid out by the CXL Spec v3.1 Sections 9.6 & 9.7.

For devices that support CXL Reset, cache lines are disabled and WB+I
is asserted. After waiting for cache invalid status, mem clr bit is
asserted and finally reset is initiated. After the recommended timeout
period, the reset status is checked and returned.

The patch has not been tested completely as the infrastructure is not
yet in place. As this is my first kernel patch, I am looking to get the
community feedback through the RFC ahead of time.

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
---
 drivers/pci/pci.c             | 184 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h           |   2 +-
 include/uapi/linux/pci_regs.h |  25 +++++
 3 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0b29ec6e8e5e..cf4fc027565e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5034,6 +5034,12 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
+static u16 cxl_device_dvsec(struct pci_dev *dev)
+{
+	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					 PCI_DVSEC_CXL_DEV);
+}
+
 static u16 cxl_port_dvsec(struct pci_dev *dev)
 {
 	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
@@ -5124,6 +5130,183 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
 	return rc;
 }
 
+static int cxl_reset_prepare(struct pci_dev *dev, u16 dvsec)
+{
+	u16 reg, val, cap;
+	int rc;
+	u32 timeout_us = 100, timeout_tot_us = 10000;
+
+	/*
+	 * Wait for any pending transactions.
+	 * Assuming this does cxl.io stuff.
+	 */
+	if (!pci_wait_for_pending_transaction(dev))
+		pci_err(dev, "timed out waiting for pending transaction; performing cxl reset anyway\n");
+
+	/*
+	 * Disable caching and then write back and invalidate lines.
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
+				  &cap);
+	if (rc)
+		return rc;
+
+	if (!(cap & PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE))
+		return 0;
+
+	/*
+	 * Disable cache.
+	 * WB and invalidate cahce if capability is advertised.
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+				  &reg);
+	if (rc)
+		return rc;
+	val = reg | PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING;
+
+	if (cap & PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE)
+		val = reg | PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE;
+	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+			      val);
+
+	/*
+	 * From Section 9.6: "Software may leverage the cache size reported in
+	 * the DVSEC CXL Capability2 register to compute a suitable timeout
+	 * value".
+	 * Given there is no conversion factor for cache size -> timeout,
+	 * setting timer for default 10ms.
+	 */
+	do {
+		if (timeout_tot_us < 0)
+			return -ETIMEDOUT;
+		usleep_range(timeout_us, timeout_us+1);
+		timeout_tot_us -= timeout_us;
+		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+					  &reg);
+		if (rc)
+			return rc;
+	} while (!(reg & PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID));
+
+	return 0;
+}
+
+/**
+ * cxl_reset_init - initiate a cxl reset
+ * @dev: device to reset
+ *
+ * Initiate a cxl reset.
+ */
+static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
+{
+	u16 reg, val;
+	u32 timeout_ms;
+	int rc;
+	u32 reset_timeouts_ms[] = {10, 100, 1000, 10000, 100000};
+
+	/*
+	 * Check if CXL Reset MEM CLR is supported.
+	 * TODO: Add check to do MEM CLR only if requested.
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
+				  &reg);
+	if (rc)
+		return rc;
+
+	if (reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR) {
+		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+					  &reg);
+		if (rc)
+			return rc;
+
+		val = reg | PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE;
+		pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+				      val);
+	}
+
+	/*
+	 * Read timeout value
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
+				  &reg);
+	if (rc)
+		return rc;
+	timeout_ms = reset_timeouts_ms[FIELD_GET(PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK, reg)];
+
+	/*
+	 * Write reset config
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+				  &reg);
+	if (rc)
+		return rc;
+
+	val = reg | PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST;
+	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+			      val);
+
+	/*
+	 *  Wait till timeout and then check reset status is complete.
+	 */
+	msleep(timeout_ms);
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVSTATUS2,
+				  &reg);
+	if (rc)
+		return rc;
+	if (reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR ||
+	    ~reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE)
+		return -ETIMEDOUT;
+
+	/*
+	 * Revert cashing disable.
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+				  &reg);
+	if (rc)
+		return rc;
+	val = (reg & (~PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING));
+	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
+			      val);
+
+	return 0;
+}
+
+/**
+ * cxl_reset - initiate a cxl reset
+ * @dev: device to reset
+ * @probe: if true, return 0 if device can be reset this way
+ *
+ * Initiate a cxl reset on @dev.
+ */
+static int cxl_reset(struct pci_dev *dev, bool probe)
+{
+	u16 dvsec, reg;
+	int rc;
+
+	dvsec = cxl_device_dvsec(dev);
+	if (!dvsec)
+		return -ENOTTY;
+
+	/*
+	 * Check if CXL Reset is supported.
+	 */
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
+				  &reg);
+	if (rc)
+		return -ENOTTY;
+
+	if (~(reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	rc = cxl_reset_prepare(dev, dvsec);
+	if (rc)
+		return rc;
+
+	return cxl_reset_init(dev, dvsec);
+}
+
 void pci_dev_lock(struct pci_dev *dev)
 {
 	/* block PM suspend, driver probe, etc. */
@@ -5210,6 +5393,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_dev_acpi_reset, .name = "acpi" },
 	{ pcie_reset_flr, .name = "flr" },
 	{ pci_af_flr, .name = "af_flr" },
+	{ cxl_reset, .name = "cxl_reset" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
 	{ cxl_reset_bus_function, .name = "cxl_bus" },
diff --git a/include/linux/pci.h b/include/linux/pci.h
index db9b47ce3eef..60bacca8e379 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 8
+#define PCI_NUM_RESET_METHODS 9
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1601c7ed5fab..ec5b408a0789 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1209,6 +1209,31 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
 /* Compute Express Link (CXL r3.1, sec 8.1.5) */
+#define PCI_DVSEC_CXL_DEV				0
+#define PCI_DVSEC_CXL_DEVCAP				0x0a
+#define PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE		0x00000001
+#define PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE	0x00000040
+#define PCI_DVSEC_CXL_DEVCAP_CXL_RST			0x00000080
+#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_IND	0x8
+#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK	0x00000700
+#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR		0x00000800
+#define PCI_DVSEC_CXL_DEVCTL				0x0c
+#define PCI_DVSEC_CXL_DEVCTL2				0x10
+#define PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING		0x1
+#define PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE	0x2
+#define PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST		0x4
+#define PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE	0x8
+#define PCI_DVSEC_CXL_DEVSTATUS2			0x12
+#define PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID		0x1
+#define PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE		0x2
+#define PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR		0x4
+#define PCI_DVSEC_CXL_DEVCAP2				0x16
+#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT		0x0000000F
+#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_0		0x0
+#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_1		0x40
+#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_2		0x400
+#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE(x)		(((x) & 0x0000FF00) >> 8)
+
 #define PCI_DVSEC_CXL_PORT				3
 #define PCI_DVSEC_CXL_PORT_CTL				0x0c
 #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
-- 
2.25.1

