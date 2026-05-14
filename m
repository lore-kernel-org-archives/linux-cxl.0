Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2738E5C5;
	Thu, 14 May 2026 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779201; cv=fail; b=PScRKvjZRrWNiZZaZMiRtblTITYzS0d71ySVUR3YKsGVIX021AIkWA6iDBE/l5lPCHR86yVCHFd5hieuNqcHqx7fdQsCqQOHWs/HJAfs8eFjiwqoBWgUASv7Snq3DwY+qhzQYbC8XU7OPyvRzBNuonU+lPdPGT7vwKUIsyOyavk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779201; c=relaxed/simple;
	bh=rdlUw8GgciYTH0jsYAJ+FR0WCGMYWBnSYqbd7/XbtDE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e4DDMlglJY976I0iKwqLzGETFDDhwVmNXjOa6dO7LRR/AAp4Z+Vwj9S5oWZKI5AEGpsaM70IQxkXCentBeNBgcJIe/9vWsIT1oIRYy5v48g8t9+xyJ8y6OyUNWfFQcY5dBjXg+LhW7qVRO6R6P8w7DdN9sNM43uekIS3bLep030=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRKVlwYe; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRKVlwYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778779200; x=1810315200;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rdlUw8GgciYTH0jsYAJ+FR0WCGMYWBnSYqbd7/XbtDE=;
  b=eRKVlwYechDZACimxY156iW8ar63DRDmvhbnlfdBfgiuIpwMp9wMEVat
   P+JB0oTNgEBRNn4e7EBxb4gYWkvun3Z4WKU1JxbQ9XazTkTpxh1TUAq5K
   zFcQ/gNb4MrkUxp+HtUP25ANzUFZqaWScls55F+lpLA7fz2LOsoz7FJCQ
   muSyOHz5s//5hXd0jNaa7IU6mfVL7wv1LmMa/ft7R8K1TChc1dLuIdWXg
   imU5gTn1f3YIyIKG6CZDF34w/pmlfVEZ2fVVMU0/a6z6Nc51hSbvgF4hb
   QlIliR3gSYttGAM1gid0YCqOLI/wwxDnjJmcctekv9FzAYSdlhhkjUkZw
   g==;
X-CSE-ConnectionGUID: i7GUQFXTSfiO8mUaOEsHPQ==
X-CSE-MsgGUID: CQe9IfYJRCuFmRsmVGToDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="67256039"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="67256039"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 10:19:59 -0700
X-CSE-ConnectionGUID: c4M2cXOKQ8WYvmng5CcnHQ==
X-CSE-MsgGUID: d6WhOoBSQTSwg5euqOODNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="238545921"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 10:19:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 10:19:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 10:19:58 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 10:19:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlRporNuIJbFBqAxWKyMhFBZNn4o8hyMNY10XKVth+HbX/I1p3/Z750dHe3F+Ylusd7VViU0ZMgPPPWCiVDGXFWYEMS9zv6n2sTA1OigqsH9LRH/+PFZbQsdKt4pHZ6519eBGdyfrkt1HTtlRDuzG4eFGxdZZSe++YT8m7KXTgISgLuDFsIlUnETCy4mtyTF9LevzDf4flGzKQq/RF4oGQbpJrwEPDBe8oCItmghFjCZFYNzfZYp+9Ozns46OmLrziwjQ6whz6K/gtJXveWIC5h7m4Jx5B1i6fscCbqVsOKxLHj3JhugG4nXnDu3VkfPJu/4MaNwomjVBDlVmT77PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSzR49sosafqYZ8/ZrNFRHDvfekbAgaHuV1iakdCKns=;
 b=ffLSSFLI8gIiCcYIHv939+yC1rk9wdcvXWA7EZmSgMk8xFH/7nMq6vPz3Z67zgYw9LvA1gu4kiJU+iMkpnhHeGdWbHXfcq0ALHDYvJi78gAQ8tvT23Ks54DGnei5WJqjHduZiDqcJFcujIXQHEqrFxw6KxembQUUfoHeHgAq76D+mENdWxeIG/cG6ruexQzKvaroQhnusPnNyQZLnDY83CzlN2uGtZDJoE4KixFtTTXDHYdDrpeb5zCPl/49wgXsjS8RtusctJpIXFFB4RJdMdojI8hTcdTOvACD7YaNSsuI+B3kH9mwcDyQupady65fJo4cd9+26utX1BFPal8y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 17:19:50 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%8]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 17:19:46 +0000
Date: Thu, 14 May 2026 10:19:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <djbw@kernel.org>,
	<guoren@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is
 not ready
Message-ID: <agYEL3qFef-wqHB_@aschofie-mobl2.lan>
References: <20260514023238.49984-1-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260514023238.49984-1-cp0613@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7dbe66-b85c-446f-056e-08deb1dcff41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: aYIV0F4YHtmdxz46lNZxBQ2raDzj+RTt39xCP0xS0vsIj8u1HV7SzIarEROR6sqr1p4RyzG+3v/7IU2rzo0ZBoWI6iVjMiZJR3sMC1KBL2cUsg8Tz+4q3z0o6UPGJIlqXBluGPQV1bgS1C+DO/ECAiMHm1ysxESFK1ZTR9jeI8LrNZUSUa41NIuNF2kReMfrL0x28QB24NJvvtHtSysU8mcAgTfQQWsqgj+UEYi12RipQ04/YlF6MoKCGeDWD89cqCZRUKCzrkODIdegrLJbDOcgDeWBl5R/xk/zCVAzFCg3TbtFKrYpY/SQ+AEuI/47oC7tx4MfjVJCmUex3GH3siatZuOJTqrz8VqE6AU8hh7WXP2HEj2TqD1Gcnh1eLvQEgII2PjqEiH5fjlC6ReBfFhK/Tb6lTHugWjY4fgO2uAA3C3FsneNxVF5PNM4ZC/+4vaAyAqtwxaDAFGu1kCFvsryqNnT/cAcHtYnIE+fNwiE7IRD/00Jub1Cau2VqjkeLQM67r72GYYJNWw+HQohdhx3PiTCcZsY1GEVaOrij910Sz3N3lOs4c1pLCGL+PI64yJSm0Ae7jiAWnA8vXnZ9aGDoRQyvMyWNJ6Td7vLE5sYvQpZZGTEywPE5JIE+s6bea5WTL/TplWPvJ1eG77vc+l0BZQFEQsdIUeG0o9wk7nAXqkXgknnkVm0WNcuYtUO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ltLYi5JaRcS7PjMm81L0ZT69SCNIWZSU5X89/n61owLdovXaazp1M3QQ4QYN?=
 =?us-ascii?Q?TgQIb65QktqWr2TJ11Fdbda2lI0EXuJv7pCb6c8959S6yfFvc/d4DXlFRba9?=
 =?us-ascii?Q?VBZuAQt91Zeee1D04b0WiefcLFILUIDzk9kgG+MMCI+lsOv9QDOtAqTP4CKi?=
 =?us-ascii?Q?nBIlftBm/rFm2bmtXBIDsg6Fr11lqRSukjl5lNpd7ZgIbqHKA2Wx1xHYeHWB?=
 =?us-ascii?Q?V3A1QutMV7fEVOhOlXDQZ7Do3dIMbwul/fiGEE8XVkLx8hPUUwt+NbXTNqIq?=
 =?us-ascii?Q?gN9vFyeph+HZ0Dy+OWlgW/5SESwBU89YepNzww7jvW+HS82dF5NJrD1YS8Sa?=
 =?us-ascii?Q?rZhLOdm54BGz/daS0RXlE3UMTQns9EhuR6CkYMTfS3x/TzucMmxPkVUhBJeW?=
 =?us-ascii?Q?aJhGIUB3zY4DCR6sQDIL50rLkNYVJ/hOwzlINFDIOqZNHJIU4VLS9LT0sFeF?=
 =?us-ascii?Q?UyfOS8pRDE3LKrH3ZnTb0H8nDjkKu9GNsiwp0M4GkS/A2wnrjniiO8FaeVrp?=
 =?us-ascii?Q?/9Q4Q2sg+WjuuyGA7SHW8boL3HnQkXyzdKItClqHPyF7YTRf9roBxCpxK+jY?=
 =?us-ascii?Q?XsAa2Od9w/C1DH7QpkLuEefgYcquXNRoUNCXbFjcm3lPSvDwSEAL5tTUUz0H?=
 =?us-ascii?Q?evlC0RgFxS3Kks8j1vp+pS8MK0mY6aiKVMycSMIuBLx9p6hT3xwEF++nX1IA?=
 =?us-ascii?Q?Fo1yVOdVqm4FifPdI9sAoPyh915yyn/mQuz2zDwx9QRsXeAwc25ck71S4vZd?=
 =?us-ascii?Q?tzcz4q22r7O6VoydEaPXWDDKHDdmZfwmpw1S/4OJ697mGVHPMHmrLh47fksC?=
 =?us-ascii?Q?O2HytuI3yq/4WNq/7DrYJE4T+iVHxSf9o/kS8DlHi4RjKUG5qZjFjvzN3JDX?=
 =?us-ascii?Q?sFPYEwls87n2lQMhTn/9s6yxV3Yh2f1GP0/EXa1iDO6LupJaTwleQcQHPHpG?=
 =?us-ascii?Q?QVNsTwABCMVJXHxeYqKJIYTknRsNAUTF4nrTYkCpFk3tPzf1dMV9isTLAf6y?=
 =?us-ascii?Q?KqBMgrZTTLNVVln1bZwBsrUu2Jb4t3OdYDHRvAdNoZd8fe5FOiOwGRVmjsdL?=
 =?us-ascii?Q?6J91N63Fv5ToXNDVzVEstd601t4/g2SyksX1oTFgL5KFGMXE/LDgeCfV5tHs?=
 =?us-ascii?Q?ZGSoK50E4fSY5nUG0RxK73auAkiw7yGugvjQ8MIdwLzUlPVRlGb0L1g8JwLa?=
 =?us-ascii?Q?9quILju5XOhlm98Xqj4RAdstMySkiLpMXVjGUfiGbbKxHU1iZihMLQ0/rIAi?=
 =?us-ascii?Q?sWjTD1HL9fuONoFHwt3X5lm7MPGF7rns933fazC4gUrQVgaH9B4iW/UOiGV2?=
 =?us-ascii?Q?ZxJmStWdb91EbQCLAZbWSoELExSpaMS92cKKlUU2Fl+XsctVET7p39/dAfpS?=
 =?us-ascii?Q?UvcRHleHFf7dCyQZFakRPfOpFMRhBUBG4q0+SkyHBuUVnCKhAoOGCsh30ZeW?=
 =?us-ascii?Q?Jb1wyZm2ZK3hmdrp9+zV48GCHaSDI7Mr28kBmFQlLu9x2fdxRhYg2p09uf4g?=
 =?us-ascii?Q?M4ErFtvB6B3yy0TXz5pzGO8ycODJLb48aEOq/ak4jNANLLjHksrvi+NoIAq2?=
 =?us-ascii?Q?ETWxSsd0QNeXXyG7FtC65PNqwhxyisDY68wBjVoupyk6E4VQwRRUWdS4bSdw?=
 =?us-ascii?Q?WPKYNQc69BMtTJA0Rxjt6/iO4aHv1Vyf3do3aAieWy/31mWN1mqt9G6pbvu6?=
 =?us-ascii?Q?rz92t07cI6aCpRgc0+Uu4rF27k2dYCEGtxrnKCgD1c/q7AJ626WVR3klZsJE?=
 =?us-ascii?Q?2BKoAuS3WhMwqcfoD0DI3OK3aHjBU6k=3D?=
X-Exchange-RoutingPolicyChecked: WeA0Ht2nPqOS4owz4uULJIj8cbS1s+jpt1xEz8htOHns7arITBHZYCK/q2yZgNkljt1oxBOCdKV9jSl8WRXaOZOtKcbUKnHFlCII9cvhAtS/F75GuaGfVoN8976lmnZMfn2G4aAGiwEVhj5m9AkKkjlZwJC3dCCsgjaWE/NFHloP/dtFMNzhg0IaoiuLTGIk2VnqZR3cUnl4V8P0WwoMetYg8xafSdhSDQ6+muDOAjLkkksyYpuyU2N8Szd02Y+FCcnnWL4WvlG1TvJo7gVBNnwf/q7y3RPYHBn8h1Y0REkYp+d4YmDgD3XRwVuQQLsnsqNWqsssLeYS+7dzFcKgYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7dbe66-b85c-446f-056e-08deb1dcff41
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 17:19:46.7910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDaSbk6Y2xL2OxeAC2W//I/+mlSI0aJtOFIXUdlTDCPs8EipjNJow1BKtuUOpRqtwVLNmA0r3YIo+WAG4gYNIsUQ9VWCogp7oaGf3zW6nOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
X-OriginatorOrg: intel.com

On Thu, May 14, 2026 at 10:32:38AM +0800, Chen Pei wrote:
> On some platforms (e.g., RISC-V and ARM64) that use the generic
> pci_acpi_scan_root() implementation, cxl_acpi_probe may run before
> acpi_pci_root driver has bound to ACPI0016 (CXL host bridge) devices.
> In this case, acpi_pci_find_root() returns NULL, causing
> to_cxl_host_bridge() to skip the device silently. This results in
> incomplete CXL port enumeration on first boot.
> 
> Fix this by detecting the case where an ACPI0016 device exists but its
> PCI root bridge is not yet ready, and returning -EPROBE_DEFER to trigger
> a deferred probe retry.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Hi Chen Pei,

As Richard suggested, this fails for the mock platform in cxl-test.
(stack trace appended at end)

With this diff applied on top of your patch, it works for cxl-test
AND I think it works for your case too. With real hardware,
ACPI_COMPANION returns the device, and with the mock platform,
ACPI_COMPANION returns NULL and the defer check is skipped.

Try it out, and note that I didn't consider if any of the comments
need updating.


diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 9952d0cff903..ec037668afba 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -631,7 +631,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	struct acpi_pci_root *pci_root;
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
-	struct acpi_device *adev = to_acpi_device(match);
+	struct acpi_device *adev = ACPI_COMPANION(match);
 	struct acpi_device *hb;
 
 	/*
@@ -639,7 +639,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	 * found the PCI root yet (driver not probed), defer the probe
 	 * to allow acpi_pci_root to bind first.
 	 */
-	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
+	if (adev && strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
 	    !acpi_pci_find_root(adev->handle)) {
 		dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
 		return -EPROBE_DEFER;
@@ -701,7 +701,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 {
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
-	struct acpi_device *adev = to_acpi_device(match);
+	struct acpi_device *adev = ACPI_COMPANION(match);
 	struct acpi_device *hb;
 	struct acpi_pci_root *pci_root;
 	struct cxl_dport *dport;
@@ -711,8 +711,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	resource_size_t component_reg_phys;
 	int rc;
 
-	/* Same deferral check as in add_host_bridge_dport() */
-	if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
+	if (adev && strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
 	    !acpi_pci_find_root(adev->handle)) {
 		dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
 		return -EPROBE_DEFER;

==========

Failure loading cxl-test module:

[    6.523556] calling  cxl_test_init+0x0/0xff0 [cxl_test] @ 622
[    6.524952] BUG: kernel NULL pointer dereference, address: 0000000000000091
[    6.526022] #PF: supervisor read access in kernel mode
[    6.526988] #PF: error_code(0x0000) - not-present page
[    6.527855] PGD 0 P4D 0 
[    6.528331] Oops: Oops: 0000 [#1] SMP NOPTI
[    6.529268] CPU: 3 UID: 0 PID: 622 Comm: systemd-modules Tainted: G           O        7.1.0-rc1+ #212 PREEMPT(lazy) 
[    6.530655] Tainted: [O]=OOT_MODULE
[    6.531238] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    6.532321] RIP: 0010:acpi_device_hid+0x18/0x30
[    6.533008] Code: cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 8b 87 98 00 00 00 48 81 c7 98 00 00 00 48 39 f8 74 0e 48 85 c0 74 09 <48> 8b 40 10 c3 cc cc cc cc 48 c7 c0 ad c9 a7 82 c3 cc cc cc cc 0f
[    6.535011] RSP: 0018:ffffc90002077870 EFLAGS: 00010206
[    6.535729] RAX: 0000000000000081 RBX: ffff8882000eb010 RCX: ffffffffa00504f0
[    6.536514] RDX: ffff88800199acc8 RSI: ffff888006ca6000 RDI: ffff8882000eae48
[    6.537284] RBP: ffffc900020778c0 R08: ffffffffa0e67491 R09: 0000000000000040
[    6.538122] R10: ffff888203667c00 R11: ffffffff835ccf70 R12: ffff888006ba3010
[    6.538961] R13: ffff888006ca6000 R14: 0000000000000000 R15: ffff888006ca6000
[    6.539777] FS:  00007f9001205480(0000) GS:ffff8880fa501000(0000) knlGS:0000000000000000
[    6.540639] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.541313] CR2: 0000000000000091 CR3: 0000000007037003 CR4: 0000000000370ef0
[    6.542125] Call Trace:
[    6.542540]  <TASK>
[    6.542903]  ? add_host_bridge_dport+0x23/0x200 [cxl_acpi]
[    6.543538]  ? klist_next+0xb0/0x170
[    6.544019]  ? __pfx_add_host_bridge_dport+0x10/0x10 [cxl_acpi]
[    6.544716]  bus_for_each_dev+0x65/0xa0
[    6.545204]  cxl_acpi_probe+0xe5/0x2d0 [cxl_acpi]
[    6.545758]  ? acpi_dev_pm_attach+0x20/0xf0
[    6.546300]  platform_probe+0x3a/0x70
[    6.546834]  really_probe+0xda/0x3e0
[    6.547302]  ? __pfx___device_attach_driver+0x10/0x10
[    6.547913]  __driver_probe_device+0x10b/0x1a0
[    6.548422]  driver_probe_device+0x1f/0x90
[    6.548949]  __device_attach_driver+0x8f/0x130
[    6.549448]  bus_for_each_drv+0x73/0xb0
[    6.549947]  __device_attach+0xb1/0x1c0
[    6.550371]  device_initial_probe+0x43/0x50
[    6.550882]  bus_probe_device+0x29/0x90
[    6.551340]  device_add+0x682/0x860
[    6.551836]  ? dev_set_name+0x3e/0x50
[    6.552282]  platform_device_add+0x176/0x260
[    6.552820]  cxl_test_init+0x80c/0xff0 [cxl_test]
[    6.553348]  ? __pfx_cxl_test_init+0x10/0x10 [cxl_test]
[    6.553954]  do_one_initcall+0x46/0x220
[    6.554411]  do_init_module+0x63/0x240
[    6.554926]  load_module+0x2826/0x2b40
[    6.555410]  ? kernel_read+0x3f/0x50
[    6.555931]  ? kernel_read_file+0x27b/0x2f0
[    6.556414]  init_module_from_file+0xbc/0xf0
[    6.556964]  __x64_sys_finit_module+0x267/0x380
[    6.557473]  x64_sys_call+0x1d68/0x2010
[    6.557958]  do_syscall_64+0x5a/0x470
[    6.558399]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[    6.558981] RIP: 0033:0x7f900110b27d
[    6.559405] Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 73 cb 0e 00 f7 d8 64 89 01 48
[    6.561245] RSP: 002b:00007fff4b386268 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    6.562035] RAX: ffffffffffffffda RBX: 000055b7253f34b0 RCX: 00007f900110b27d
[    6.562779] RDX: 0000000000000000 RSI: 00007f900178f43c RDI: 000000000000000c
[    6.563473] RBP: 00007f900178f43c R08: 0000000000000000 R09: 000055b7253f8f80
[    6.564187] R10: 000000000000000c R11: 0000000000000246 R12: 0000000000020000
[    6.564918] R13: 000055b7253f4cc0 R14: 0000000000000000 R15: 000055b7253f97c0
[    6.565601]  </TASK>
[    6.565895] Modules linked in: cxl_test(O+) cxl_acpi(O) cxl_pmem(O) cxl_mem(O) cxl_port(O) cxl_mock(O) cxl_core(O) fwctl libnvdimm
[    6.566999] CR2: 0000000000000091
[    6.567417] ---[ end trace 0000000000000000 ]---
[    6.567990] RIP: 0010:acpi_device_hid+0x18/0x30
[    6.568661] Code: cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 8b 87 98 00 00 00 48 81 c7 98 00 00 00 48 39 f8 74 0e 48 85 c0 74 09 <48> 8b 40 10 c3 cc cc cc cc 48 c7 c0 ad c9 a7 82 c3 cc cc cc cc 0f
[    6.573628] RSP: 0018:ffffc90002077870 EFLAGS: 00010206
[    6.575230] RAX: 0000000000000081 RBX: ffff8882000eb010 RCX: ffffffffa00504f0
[    6.577279] RDX: ffff88800199acc8 RSI: ffff888006ca6000 RDI: ffff8882000eae48
[    6.579343] RBP: ffffc900020778c0 R08: ffffffffa0e67491 R09: 0000000000000040
[    6.581407] R10: ffff888203667c00 R11: ffffffff835ccf70 R12: ffff888006ba3010
[    6.583237] R13: ffff888006ca6000 R14: 0000000000000000 R15: ffff888006ca6000
[    6.584595] FS:  00007f9001205480(0000) GS:ffff8880fa501000(0000) knlGS:0000000000000000
[    6.586087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.587256] CR2: 0000000000000091 CR3: 0000000007037003 CR4: 0000000000370ef0
[    6.588634] note: systemd-modules[622] exited with irqs disabled


