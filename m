Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839F16D9C2;
	Tue, 24 Jun 2025 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750743811; cv=fail; b=Q8wlRbai4gJPSrsMbgnyU3x1a0dcX1S1R1UUMTOpTamej5pfqFv9EmHo0pxdlHrgtb2byYxjme2CdMBndurc/2sc/wqmMMxFCqm5zOkLDA1MAxMPQRx8BGEBDNiBlmOrXjQgpzY9md9r8jFsW74/67T5aJ0aEFij5+ROQXQznck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750743811; c=relaxed/simple;
	bh=RY80uCYeGxxRbzC+0AsNEcr9KaB6rDlxhUe9+CKurfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CWc0rM9hguSVpAJRZnPi9rG3vuHNvNVo9Nt1pVebO+jLYqmadNN3Su5addBKGOYHk+vknXghwYrm43+H5xi/H7Ilj3POSO5/CT0nchk96QxOmXHGzk2Vyj0ZFRVAM0fc86rjrbRSwYpjqXqSuRvAwkEpw0FtA3VsxdA7qNGTp84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pUbZVNan; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pUbZVNan"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6Imv+FQGoKi61ppH7c3g+hTlASFh8zX+aEA6Mo+K9a3VxPPvvpBmtxd9LX3FWFQIszaoAVffoKi+SwTC50Z5u8f/SKrz8hDG3pMbvR07DeAHbFxItdSkSBfncknkAJryTkJbfn9LUxGheu4Z0BD+S5EOxPRnl0E3wVR1sf0gcXcv7nYYwehBSEiyNvTkR/OLYZrMe6NarHhuoItjvhQk44jhM4exM6Hl9ixZ4nVDRA1G7c+OkkVK3jLy7Vf6cG/GCVAiTXAdSMRwkWTnlpQ3y5tigFoSOz0FdRSX8HAi165+UXvhO+Qh+jKbl5YBk0BBvIybtnVoLHKLO1p1bLXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q8T1HZ6ztqfUx6iLo2JvT4ztGdu43ooMQPFx0ZxSM0=;
 b=pI1WXfjttfWoGc1x2FkfIa72yp8VCqGcg7IAXET/23kt3wbK8L32oL5jahIYSyQRtlFpeQ14le9eYuiBB+wSO+XTjtZUFInyyZSRMxTt56XId125dOepNJGupdkdQfCx8C2SemFoo6joWxsGi4euxEuZ5FJfQzmzy3clqb8tRr/UafzoQZfaQN2dwfAi7tB1GtwaSuKqtHzWZ81RUlqDZ4/Pcd9K608Pi1174mWG+jZSCYs2u8C8BGbG7Oftev2HH7XDptCS7ue/mwW5OnxHhNMcRCsZ3fzSZxJfNEmKZ5AI2mVGeuW5K6yS40dTqFIFtQoEM4AbOU888Byejnatgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q8T1HZ6ztqfUx6iLo2JvT4ztGdu43ooMQPFx0ZxSM0=;
 b=pUbZVNanyZ7RAtw669eejOnHOgdTVN8Rz5F2xxZNmMPtEcN+8vtF4vuJFeddYgmGIiYCut5UOM2xOPHxZvnuX50TWqCorVDgAOUIAAVaWOXqK7ZuSMAUTzzcypzh3dDzZOlq/KnPmKT9J9wANXm9DaofH50pV77CTSXemTeOh2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::987) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Tue, 24 Jun
 2025 05:43:27 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 05:43:20 +0000
Date: Tue, 24 Jun 2025 07:43:13 +0200
From: Robert Richter <rrichter@amd.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Gregory Price <gourry@gourry.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH] [HACK] drop zen5_init checks due to segfault
Message-ID: <aFo68StiDKzLjNdS@rric.localdomain>
References: <aCO1TGvrXajf1s4_@rric.localdomain>
 <20250617203320.1760101-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617203320.1760101-1-joshua.hahnjy@gmail.com>
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: ef2bc0a4-cfb3-439f-112a-08ddb2e20658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m0PQbS2kAaCjYR4nWsh4AAx/to2QYqdvLxxW4sbaheE7fzHtIfeFPYIk90+j?=
 =?us-ascii?Q?uieAx4b+nb84IUs+3rwlML8TjVrocPSId+a5cO2dc/uaxJSxqmHEcCzBXroI?=
 =?us-ascii?Q?IR76iTABF0n6bSDw+m7YGlRtfIzanUJeFU0JhwXldrXhrSAgaWdOluAKwY8+?=
 =?us-ascii?Q?yihmHqdeEXO5pIgvhY6xyS0YIj0AYM3noj9Udpau/4Syr7bOX3bajzpbQbkQ?=
 =?us-ascii?Q?DdUeqs6joCobZ3VcavDpwK0kut+stJpBJeh2DcJPZlAvUrJIcmHa7o03F32Z?=
 =?us-ascii?Q?qEnjn/+cRFF2Z1oItlu8ArUnf3owBHcaZH0lFlhiQOFNWPydnlDVJ47dRvpH?=
 =?us-ascii?Q?K5kxxgC0XJpsnsqcJpvqp5pmCoWCZ3/iamtzoI/hvy5GYWkza+CnUJomv1qN?=
 =?us-ascii?Q?7a3NJvzV9OeGVbg6KgqSzZNJdwh/BmPw0MJiOpaHQg/FPiTuLLIMS5f31h0U?=
 =?us-ascii?Q?1rfhZJ3kYGBceCf5H9NndhOXCvlMS4FPPHbeHlPRI93DszSX/a/0rTdxPe+m?=
 =?us-ascii?Q?sBYChhKuOZUCXYZZp+o43gqlKXE69Orsl2mfRZ/eabI6Q1mU5SGQSimxkjwO?=
 =?us-ascii?Q?hXDZYWdxt0Fj4QdSwgbMwQa1Knz0vCL+KdlO0MopNzpMl6oRaNelime47+Bt?=
 =?us-ascii?Q?oOgL7xsr73ljiteGqfLLbuln92x0afLevs9otuJotsrm8+rDkVDkZo3HO2gC?=
 =?us-ascii?Q?milYO2tXDO0c+YNdsLq/IuhpkCaLxy0Xw/57GE3VpEqiOL4PNoPPxuvNaJxe?=
 =?us-ascii?Q?RL+uDuei2NnCAoPtBpQM02iznZMyXYLqCUnfSK0Yln7Z0oRbqz4LWOZ1qu/t?=
 =?us-ascii?Q?BfDfq+wuR+SSHEWDx6OYDlM+Svh3Cj+OZSH6875x+yLclvJEg3SwJLyIhm3R?=
 =?us-ascii?Q?tNHww//LBs7YCyhTflGXTPlP7Em5wrkQGj3E9KrZ1DFj7xr6Aa5ZWpv77SqB?=
 =?us-ascii?Q?82WXmvMEXlUXNZ3s6Q/oVeqzVnOuUVlrbCRVKgpstc2eOwPBOwCG2RSBWR2C?=
 =?us-ascii?Q?MCKdM4r+qSjY1w53Z3xByCzCb3k/8rp6jxcBtX3zxvEQKDCRHABiWoINfUnL?=
 =?us-ascii?Q?X7vt4sriRAhfBG1edpRvcjEMyCgof8DVXOW9x+tPO+haYKnccUidILASp0+j?=
 =?us-ascii?Q?4OtTcaLFewbQ9umjOO9t/adoXqDXOkT/QohVEJHBsuseZojEctKB2wNQoJTw?=
 =?us-ascii?Q?5JQ/NKuo00+8HMpAuxnadba7RPkUgLx2vmy0/uFB0B/urdhWBm87psVCCsMW?=
 =?us-ascii?Q?QovD3C8Aol9Icedxsq28agbWl+I9GuMcnTMnWJa345Eys7BjKGCQMvgj5Wii?=
 =?us-ascii?Q?BwBHP0sH9aUvWyF+wKKkZNtExv3umwJiNzIUxb3ogPN+xLDp1w6TyFCWk6Bo?=
 =?us-ascii?Q?sPEJ0mmr5e4kt4sZwixjnYIiNpp596kY8oa0PlEPVLeIedoncezVLm2gwxfT?=
 =?us-ascii?Q?lCKz1ZJ7YnY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hvk7UZ2Yrxtkt1kZL3/o3zJZpSrof6QJPLZ3VczusGBw493Vj2O55+iWV0AQ?=
 =?us-ascii?Q?OGvFkOL7aNeyI3hsoHc9Ueh1nlm4a1ltlWky2MugLsWlrSfTfJM2yvfWWDqX?=
 =?us-ascii?Q?prPUP8fVrpUGxvBAd59vVy0q6Z5s9AhWVKVra3Upjqb27DhczMqkIaNkNfdC?=
 =?us-ascii?Q?RuV/7o2nZGgoPyvbiki+7J6X8KXhPz7XHWVX5FvyIxWnGIKpyN0kEUzUEcJt?=
 =?us-ascii?Q?2GtKlqWKSOaI1STaQGRfloFj9YE8LabTArkKBi8k9WAc/P0SpFqvCTuz2CnH?=
 =?us-ascii?Q?8VmKecVO+7ptkXa7GahRDHuaL+NB+mHJpTyvl+CRXqzQZHZBx3DibOUSJ+Rk?=
 =?us-ascii?Q?2dGAwcuQY+B45X77rehCe1ulI3UxguUadT9UvaFUpi+jNiOFnUpVm4BuOaEd?=
 =?us-ascii?Q?IBsqfk7VxsVDoKlBJWfiHCdb4egNt6Op56WypVWYN5rAAthTCPC+WhRTB/DB?=
 =?us-ascii?Q?/SkraLA8na4z4IXR2bdPxV3EPk1nqfIWT7HdJdHWZ4dMq+iCMrPVU1drrrJv?=
 =?us-ascii?Q?RfalZDTgX2tp1al7jHDzvKlg6zw969ml/2pDFsYyfx1REtq9mS5fKmiycgVx?=
 =?us-ascii?Q?Cj+NiH8rlCJ7YvCICUGcyM5Bq6OnUdI+rEpdbJCjTk0uw8vcnsuaRUxl7oL0?=
 =?us-ascii?Q?Zq3R0BWPMyzoxEz8KFCb+DVlE0/SQbZA+rqJ5D+wHu4eF+7vE/Ev2fTgr3g4?=
 =?us-ascii?Q?pgLvXEM8igP9h1p2VdEBB4zQX53gCGBSkeAinG0Hb3HHgXX4Ujyfyv0oDW5b?=
 =?us-ascii?Q?oEuFbNWM9Nva5oTLs2zYjcYmfMSGOC/7xTvfTEcU/AOO/BLkWPgbHwzTx1Zk?=
 =?us-ascii?Q?uk4xRsLEpr6yPMxoFbDKHYnzYMaWrAaypqFdlf4rTTpH6+CXfyJ8DkkXrCkf?=
 =?us-ascii?Q?qMjm9hwx2f9EJmQncAS2Hfop84TEXn81LQpAknx8sKaSDCc4shCV2HspD60C?=
 =?us-ascii?Q?gHhtNJQwjFGGshQsNOimfpM6jCuhmEtJDd5Db8AmDooD/V/bZDhEP5ZNAyGD?=
 =?us-ascii?Q?nnnYBDdDDTcPhuzd0oG1njWa8dZSADzTpP0B2wy3rC3A+oBGchTop0rO3FQ2?=
 =?us-ascii?Q?ZqY6H5UahYBMf89DbpcvSl8AscvW+e8CTfLqgncWCl0VMd/VPThi1t9PzvIL?=
 =?us-ascii?Q?qnvDheRHta+r60Hi3+y/rmngRTIBf9sjdrJTTWyotPoy3HX9r8d15RGHI1U3?=
 =?us-ascii?Q?qgp66/giAJbLhYGUHP4Bac3XDOCw6Y/phXrTZkW5mIud1YjmMIh6rCR23XNj?=
 =?us-ascii?Q?vFCU+6UbNjjZLb6C0jLOZoogAEwPxw9w2SXBanwyk+4M920GuBlh4HwF3T1y?=
 =?us-ascii?Q?pdzUKNShQuKLaXtu6FRb5hRXb/bOZ3r8IE+cl76UBBc5bnKeySrw82Q1Eiu9?=
 =?us-ascii?Q?HSWxUQoXQCXzaTAzebbBU6ngBYYsgUwqsR6+ns6/zpVhBvPa6ckN8fxGBRDT?=
 =?us-ascii?Q?zsM5sKn5fRrHZDTORD+8prpicYlXsUmmNouD6wbQGKz9mwZuolzD7X+VJaW1?=
 =?us-ascii?Q?IeCHmD7pz/TTwMquy75lyeJN/QM/h8SmIMzLdOMoRDOG1JcP66SxjFy/gxpm?=
 =?us-ascii?Q?HpixxDcz52h2t/kajJY/1QHpYwxL90g50XQFRa28?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2bc0a4-cfb3-439f-112a-08ddb2e20658
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 05:43:19.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ic8BnVTncLVKJVn9rypmRLNtCbyCGdKRltMmoNNJlr9M7PfV4QxrDu8ltEs8fZ/HNWCD/hDITACRonHAb2Yamg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF

On 17.06.25 13:33:18, Joshua Hahn wrote:
> I was hoping for some help in understanding your explanation here -- I don't
> think I can see where the dependency appears. (In particular, I'm having
> trouble understanding where the efi_rts_wq dependnecy matters during the
> cxl_zen5_init function). 

Here a temporary patch with an explanation in the description:


From a540b814d48574b67a9aaa97a5d7536c61d4deda Mon Sep 17 00:00:00 2001
From: Robert Richter <rrichter@amd.com>
Date: Tue, 13 May 2025 15:02:16 +0200
Subject: [PATCH] cxl/acpi: Prepare use of EFI runtime services

In order to use EFI runtime services, esp. ACPI PRM which uses the
efi_rts_wq workqueue, initialize EFI before CXL ACPI.

There is a subsys_initcall order dependency if driver is builtin:

 subsys_initcall(cxl_acpi_init);
 subsys_initcall(efisubsys_init);

Prevent the efi_rts_wq workqueue being used by cxl_acpi_init() before
its allocation. Use subsys_initcall_sync(cxl_acpi_init) to always run
efisubsys_init() first.

Reported-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index a1a99ec3f12c..af750a8bd373 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -932,8 +932,12 @@ static void __exit cxl_acpi_exit(void)
 	cxl_bus_drain();
 }
 
-/* load before dax_hmem sees 'Soft Reserved' CXL ranges */
-subsys_initcall(cxl_acpi_init);
+/*
+ * Load before dax_hmem sees 'Soft Reserved' CXL ranges. Use
+ * subsys_initcall_sync() since there is an order dependency with
+ * subsys_initcall(efisubsys_init), which must run first.
+ */
+subsys_initcall_sync(cxl_acpi_init);
 
 /*
  * Arrange for host-bridge ports to be active synchronous with
-- 
2.39.5

