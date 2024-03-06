Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BF137935
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709745382; cv=fail; b=qX31uaTNKX3WQYylaT2w8/5+S073Ve9ArWzOvcpN6XA7pqXB7THl3m4JPkX4p9qNYpPUKFtA4Hsev+I/o8eL0OdlE8jonh20gOgQx7cTBqnhg4MCgxGXId7TloslURCeBQ3d5Xzfp/W7cMQ9FPtEv2W2uJ9k6bfsjnrglEXQOgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709745382; c=relaxed/simple;
	bh=Gh3jfiSKnSN1xov5ue79ocPJrZoPgLWQsyBh5l+yjG4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QAuOKX18C9kb4Ik2LpWqDW/g0EARp81aTa2DxZTMisDUjlYeThXHXTxNDL2v/Ld1X5x1YiDAxuQWgsdR0/Rqbrivb/4uTs43a7VtuSOuf28lWp0dVm21aQgF5HAYLTVyhbLKfNqgJ8AW59njycqFbSQV5Ucowv4QKp/2OIw99Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQR5iGka; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQR5iGka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709745381; x=1741281381;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Gh3jfiSKnSN1xov5ue79ocPJrZoPgLWQsyBh5l+yjG4=;
  b=dQR5iGkaqh/bVxmnqQ/C9oKROPJxzfzQWAH19rCW59s0TIYs9IWIDxdQ
   kHhBsoGVIl8fm6Hcwwo14oe2c1w6RkMlMN64InlQbF2jcqYQXUJrCupmu
   /1o84D/DuzCl3mjjXkT8V//BFKpTaznulD4rqnBahp684YWsshD7mPOgv
   nty3Oz1wr9I3qde/CybLw1vxKnF8tEtXKVT1Tl2SKp2OMtwy9Lr5jXyXt
   6zTG6KVozHrNSoaz+5zi/EgOC5wocyKoiG3HEB8jYAN46N8fW2Uz1gb5M
   nmjpO3gaEqbi4qkbMq5sl0SSf8kf69Er9Fft9lyS4cJKOKicoSTtM5jPi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15512942"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="15512942"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 09:16:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9911708"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 09:16:15 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 09:16:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 09:16:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 09:16:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaFnVaUjYpuIZYsM5pmHHDdiyVVj+UM1VygpEM7Bcx6zRnzFVnJVuRN1H3+so+j+I0W4RPa3tAwNry0UKZeUguGER3OkSLb74sMNmkaNTdV8WFz7ipApokHcBdN79rpWk7m/ayAGiP8Nq1r8cR+P1pEhUacnt4sfUxeSnT1He8TXTZenKegjDhXxcL5pfj19G44EneWu/nVus9wUavfrKWcMkZP6jTIYXVpwQg8udrEEahJrPKkTv7WDdRYFcrgBAE/fWRR8riikKzyvJyOJJ6dgWUyL2J27RJcb+sFfmXVNCPBRzpHBvw8K5zdR++0Ro7hImTcAB4+p7ZsbTdHXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYk7jKGp/1G/K+bCBo6YncWTvUD2mFly70BudsC3Wro=;
 b=VdtLUp+tzdU6W2BeN7ROQBlD/js6214U66KAiDIJQ/o0+7ErkOddO6q3XvtpkSMiL4NpeKYL65tUBS6zDM4fd5JxEQcnMbZSLATtucVcnXTS1wO3CfhFDJI/hoHVx2T/OHA3Tz2CUPHm7LoIvfkagpbiPeqULIDXV9UoG/ONhXePM695fCMnSrFJRINn2xhp5kdMG2q4ImoBCYKoU/qulZTiYyIJLk3oX0OvpMjJcVGFDkb4X6N79h2Jz3Gjs8vS64qTFYpMlvXjYxodz3UWpLOM9qmEVFXG98g82geKO9FCLJkpV6XI3U9q5Oy8XZWmXjhm8JwoimXYly7B8ZrV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7254.namprd11.prod.outlook.com (2603:10b6:8:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 17:16:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 17:16:09 +0000
Date: Wed, 6 Mar 2024 09:16:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>
CC: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, Robert Richter
	<rrichter@amd.com>, Terry Bowman <Terry.Bowman@amd.com>,
	<dan.williams@intel.com>, <ming4.li@intel.com>
Subject: RE: Enabling internal errors for VH CXL devices: [was: Re: Questions
 about CXL RAS injection test in qemu]
Message-ID: <65e8a4d74a411_1ecd294f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240306112707.3116081-1-wangyuquan1236@phytium.com.cn>
 <20240306132359.00001956@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240306132359.00001956@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:303:dd::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef8dabf-5c59-4c93-3bdc-08dc3e011d9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJRFXusn2ljwOt3HjTrTeMEjDnpYw4VpGP9WD7SkeI6zpg7KXn+kUU3O9oGIZSN5iMT3I2BnCqjc9iPfJLz2IJGj3gKvJs2wWLtqG+oB1mQ56HeDo+MHTIEagXR/uQvpN5zbYT2AadE/lTX+R8TQF292de/csy2Yp0z2zf9VKBrV6PVOWbtDm/1qpoFseF+w0ZdZlRwy4QvoLsbXefmbysqvCoRAbZWGzlpXCyrE2g3oa4jNz0DHNKc1JP4tddd0nx3HmhYx47nkTooC4zuLBJcWLbZwQjAdlMzAAlhPGRKNnUZLf/RyNXTtf6cfSTH7Pvsd9mAifBnzww+H+uL9wHzGeSiaqjLwZMBKBuhJJIDIzQ+2ibyjNbhrYBiqesBzVW/b5ozLUgHD0E25o/lfvhdNjyKvnJTnKDvhcbhKY7EWzjAJLGx1j5JzW5WeIHn/I3zVDtlX/0byB+pPHYwXHkyT/iAB/AaTicIGmE6RZqFnvNOausUZHteUbn1wK8fDXeTERo/cyO9uaY1IaG6ixgVP07vNL+Hrw0VNfC0KLq6PGxwOS3bFxQqhjczz/zcnwV+QJpE8IA1gj1mHTagbu8yVP5jX+xSYCbUcN5BLmF2WMRtHDmvu9hJ3LXQ19kX8oJGVRFYwo5Z3CLkaAtl6cbegjiKFt3UXiAlc9UODk7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DCCxt6my0SLUS2ZjI4qlmztUdC4GFthpg3PaUxrCgwzqhZPfTgxnduLFFR0d?=
 =?us-ascii?Q?jNbE3+4mgE1WeqOdbnEv6f8bLKEt30/sk0t1yEc39uToEu1SbO1IDAUReymF?=
 =?us-ascii?Q?tMGO/zafYxlSKP6jZJk2YqgTGlJPjUVTOii4WAOa/2VEbj1m8KMNN1zmMwIZ?=
 =?us-ascii?Q?yNilRla65g4HZLT8yIDWXh7+13amHKVHBUyr6ikHiFKAR8Y2e3/b7AAlfL/p?=
 =?us-ascii?Q?cljHyaDhouwN9kn4zm33rXdG3N2MCu+oBkabwQDQ6o/kI5/7eMuHxfyRm3P1?=
 =?us-ascii?Q?4pJRULwzoXF/Qyiv7M1fnU3ppgZ8PM0dSejxiyqz5LtKN76mTGdohzK9jwVf?=
 =?us-ascii?Q?Bvm4JiwPYQUSb2Ydup1qsLkL2Smd/SJ8NijZOHBFTzM7CzW/ehQj//G0f03s?=
 =?us-ascii?Q?5JTBSdiV25oxRcM6KNVdTKxV6JQH0m5AedaEHnFp9ofPr+cUjwCbR0knfYZO?=
 =?us-ascii?Q?1XCFtdaoLAMrhjRmXc5RFeDkfvf7v5bCtxilOSlWHYZ2ndOIwv8XotooYyOL?=
 =?us-ascii?Q?IoC+FsY247UwIUR8Tiz+oJ6MmkilKc3qHp1xxwaJ6mVKPXvLnvq+BkZDB9GD?=
 =?us-ascii?Q?qoSPwffaB6tUnEk2aFjWIJXFWrwGKqFIpkGfcsbUYit5QF6uxj3hqP+/7O7/?=
 =?us-ascii?Q?ec9BN7xYIIrQ5Qef822te/sENmVNqbbcHETSul2+l0StJJ1D7U/PxDnljeT0?=
 =?us-ascii?Q?364yLwXzeW9Jq5C1haErhlmQliCdQ2au2LCqTRlE0ovOP+xSQttsH2tYs1lx?=
 =?us-ascii?Q?0cXS2TO6nx4Y/rZR+BtW9Gj8mwZ8DiAf0VcFV519JfeRxJl1gJzajXulWn6N?=
 =?us-ascii?Q?jQPjUzCehCBbxRonQtUhtsUKnrrD/CAIqFml+8PxVoE2fXC/hZ/F7bOoTvpZ?=
 =?us-ascii?Q?C2deqRVIeeO0Gt4y4NnKffSCofPPwU1J/iXjIz2yMmzpYmCEdTO79ItYgbqm?=
 =?us-ascii?Q?qWOnqB4stN4XrY0wVbede4bc2iCkOnltkIUVx8R9cY75Yt3si1XcX1bdLlRG?=
 =?us-ascii?Q?627IOkOP3e/3s+s/JzwjyL78R2htpv4N8BDRtYi4hJK5vJ4wEg9G/rioswn4?=
 =?us-ascii?Q?vOXpuTlnE3gR2gxbtOhKT4GfrJMqPprx2JPe0E4ksUTxaW7YKNUm5qJIxciP?=
 =?us-ascii?Q?ASz/9CPQnuHif3fUdp24qVE1QIlVCcjAwpdjzKzASOGXGDXXVjrLv+EgE5NH?=
 =?us-ascii?Q?3AjoNhAy7uQNmtLntLW4aQCT28x2gQH1Sinqw50CW3b5MJ6w0F6RacY2GaD4?=
 =?us-ascii?Q?oMTCgNTNZLNt0HIgz12zNhL3ZOdj0SlpbEGVr8fibIFMC/5n4tD0EnFDBY1h?=
 =?us-ascii?Q?PWg+EDW7g/wS/1TIflmnhcRFbqxvcnNk4Tw30C2P2D/opQScv6nyRaKWFOxr?=
 =?us-ascii?Q?6kKBOv4VmbyJLDL/IogoyBuh5rDtAAi1vOY56pgSMd7V/1TZykhq1xuNZfOR?=
 =?us-ascii?Q?dGWVggrhjEaNP24xgyqVVbv/dLQKxkV1Z/uy97uqhgubf6As3H/WMszE11xo?=
 =?us-ascii?Q?ULqdEx+CITjLyZyXqmk3Zzr9xz7n0FswuDTQdC2B/W+LHMPH7Cfz7biSXrts?=
 =?us-ascii?Q?KOPPMK7nVfgVdmPyew0nSS/sexlFYbnHQvV722m1ZWg9IYHp1s1uC4/gPgdK?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef8dabf-5c59-4c93-3bdc-08dc3e011d9e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:16:09.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY3imdhUkcXWWu40hkIVQJnikzpE/WEik9C+4MWdjpqi6IBwni3xnBH8TVDhRbdi2XAuRs0JojdJX9+EmhNFtW5cALy8OlfPUrWnotxUJ4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7254
X-OriginatorOrg: intel.com

[ add Li Ming ]

Jonathan Cameron wrote:
[..]
> Robert / Terry, I tracked down the patch where you enabled this for RCHs and there was
> some discussion on walking out on VH as well to enable this, but seems it
> never happened. Can you remember why?  Just kicked back for a future occasion?
> 

Li Ming has this patch below waiting in wings. Li Ming, this patch is
timely for this dicussion, care to send out the full series? I expect it
needs to be an RFC given concerns with integrating with the pending port
switch error handling work.

-- 8< --
From: Li Ming <ming4.li@intel.com>
Subject: [PATCH RFC v3 3/6] PCI/AER: Enable RCEC to report internal error for CXL root port
Date: Thu, 1 Feb 2024 05:58:08 +0000

Per CXL r3.1 section 12.2.2, RCEC is possible to log the CXL.cachemem
protocol errors detected by CXL root port as PCI_ERR_UNC_INTN or
PCI_ERR_COR_INTERNAL in AER Capability. So unmask PCI_ERR_UNC_INTN and
PCI_ERR_COR_INTERNAL for that case.

Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/pci/pcie/aer.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 42a3bd35a3e1..ef8fd77cb920 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -985,7 +985,7 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 
-	return (pcie_ports_native || host->native_aer);
+	return (pcie_ports_native || host->native_aer) && host->is_cxl;
 }
 
 static bool is_internal_error(struct aer_err_info *info)
@@ -1041,8 +1041,14 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
 {
 	bool *handles_cxl = data;
 
-	if (!*handles_cxl)
-		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
+	if (!*handles_cxl) {
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END &&
+		    is_cxl_mem_dev(dev) && cxl_error_is_native(dev))
+			*handles_cxl = true;
+		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
+		    cxl_error_is_native(dev))
+			*handles_cxl = true;
+	}
 
 	/* Non-zero terminates iteration */
 	return *handles_cxl;
@@ -1054,13 +1060,18 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
 
 	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
 	    pcie_aer_is_native(rcec))
-		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
+		pcie_walk_rcec_all(rcec, handles_cxl_error_iter, &handles_cxl);
 
 	return handles_cxl;
 }
 
-static void cxl_rch_enable_rcec(struct pci_dev *rcec)
+static void cxl_enable_rcec(struct pci_dev *rcec)
 {
+	/*
+	 * Enable RCEC's internal error report for two cases:
+	 * 1. RCiEP detected CXL.cachemem protocol errors
+	 * 2. CXL root port detected CXL.cachemem protocol errors.
+	 */
 	if (!handles_cxl_errors(rcec))
 		return;
 
@@ -1069,7 +1080,7 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
 }
 
 #else
-static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
+static inline void cxl_enable_rcec(struct pci_dev *dev) { }
 static inline void cxl_rch_handle_error(struct pci_dev *dev,
 					struct aer_err_info *info) { }
 #endif
@@ -1494,7 +1505,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
-	cxl_rch_enable_rcec(port);
+	cxl_enable_rcec(port);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
-- 
2.40.1

