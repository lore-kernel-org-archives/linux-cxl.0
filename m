Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C68D423A8E
	for <linux-cxl@vger.kernel.org>; Mon,  9 Feb 2026 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665796; cv=fail; b=VTg6Xu26uji05rR+O/9iXOprGHdSm5TJ8AudTKIgEmFCAMk5HQIf28/wrWw4pplX0AscuzAcjcNPGOM9RGd5XSLY2zqe5sgguEzEq8EThHm/IDoijBqUNcWsU9YcvMAnGw3+lmKArjsK8CpMx2l7hTebUcXJxUc2xW+alPslY5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665796; c=relaxed/simple;
	bh=PiW/dh1CVv2fgQ2Zdnf11Ud/1NFTp3dpHmXJ+/NSKGw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N6bJAzKtq6VjeH4M7SvwFk/hR8M/psvMtdSnzN5nWouAKR5/UgUiyzYATA9qH/yspSnFbJ1dJTPHhM1syfrAHc1S+dCfmITaDPl3UHMmFE/ms4Qfca3/K19gr+6WXMlOvVqDpm/4do0pbxJZ7KDeds4T6qJW/THAx+2BZTFf31k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h54B0v0u; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h54B0v0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770665796; x=1802201796;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PiW/dh1CVv2fgQ2Zdnf11Ud/1NFTp3dpHmXJ+/NSKGw=;
  b=h54B0v0urr3tLHiYELAGSPb3kj/DV7YPvZMEpapIek1mJZLi2LBADRaw
   anVCGXCixsuJVV88Qam8HLjpK0oSXB3/LZYNedqwA8xyRgwUxJxIvp0Z8
   KO6uhJbypVkSKFRVvJVhF0HuMjkAgvyriQrOEFD0esWMpj3f3hQThjoCq
   MdbYRTQ8RXrNyTrByJe2N3eBvJdxQJRGjIpLj94Cd2zcuThb58JSSUWbw
   zk92qy6v8y1x3EYREhf8b/zhcB5Le1RjUDlBTffMf29EUihef57AAGQjM
   FVpWxc/0/XgDyCjA+bOiBsRGeMqLPWBvTR7reBJTqjHxcUB+Ftlwz0KWH
   Q==;
X-CSE-ConnectionGUID: HaWIdRq1SXmvayXe1JSS+g==
X-CSE-MsgGUID: eMC/vPM3S02NLdY59ueceg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="59352223"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="59352223"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:36:35 -0800
X-CSE-ConnectionGUID: NfBGpajCTeWrRPh7YW5FkA==
X-CSE-MsgGUID: HrJ5+f7yThKLI87eX3X27A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="211501454"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:36:35 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 11:36:34 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 11:36:34 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 11:36:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC3SPAXQD3EM3xLCA4I2Z5CW3e9z0R7W1z/g3949BQ1QT84CO8WaUmND0GpUTIpnwVt1vfyVMRwf6XB9LKbtB2B9gXJlKFFQKSAP1eY8sF9MEJAPTpAJCW3da+VVa2xpLD8fGGozQH6fl4PEWqdCgaRDtTnHjeRlWWfpRlxsuVf8fhpTlSAHw9VGlH5oQ+Ivfz7aOh1jWyDZzg8anPuLElo2Dl9rjKSKiViEb/yyAfZ9FDIH5/KlYbaWvGr1bVE1F2ZdNDH4ywZyi5kNSLGrDhF8qK1JSrjoqA8mXHSDH1fcnNcFbWidV3C5JZFWSs9mo933Kof1Eil7IlYPQewBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W2Xb9rbGBsDyKjeAB1F8Mdx/86vsF5p2aJAoKlqxfY=;
 b=c/5354AXnxQzE3LWzxgsr3xsnwkoWuMHBrvHcMeEfABeXAR4HlKS27HABR2zTswJKE7ZYEeTDFGG2p95mcErvBWGZSGlEbXpXzvd/QnNG7u87EJC2CKxewwURljkEpeDPcA84/uSxotMgMHRx1fBsehsGg8mlRFQxhbfkWBUCfP5EKsOqp8BeqAWxaEjsw7gyOvhwzuXs2Eq1e92OkxOorIuNwmGkDv8aqgxZrWxmEoagLnTOZNZywQdLAGV3+oZwRNNlDHiQUT8pj/FkrKo78enjkU83vjFXiQndZlx5/oTdR1yaKiq+dwK7W5XkYoouFoh9QXjU+1kTB0zaZuxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DS4PPFEE549A404.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 19:36:32 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2%2]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:36:29 +0000
Date: Mon, 9 Feb 2026 13:39:53 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>
Subject: Re: [PATCH] cxl/region: Fix leakage in __construct_region()
Message-ID: <698a380971da0_c11ee1006a@iweiny-mobl.notmuch>
References: <20260202191330.245608-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260202191330.245608-1-dave@stgolabs.net>
X-ClientProxiedBy: BY3PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::29) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DS4PPFEE549A404:EE_
X-MS-Office365-Filtering-Correlation-Id: d307de5c-824c-42b6-433f-08de681285b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OQbTqEYyhwaM1y1qdcjapHgmDZa/KrXY/S6lbhiRUkbU49mAL5+pXo9nW1K1?=
 =?us-ascii?Q?27I7yvRkUkjQh8cM4Uy8jfHVQzjhQAqtXcchnPh9Dbz2R7xYpc/nwQhJYBjH?=
 =?us-ascii?Q?C95NqqIxp4I9y2NoMd6TL/LLgwxObZxDfnKG4U6cwDoZ5M5Z/L8nbYf2kp1U?=
 =?us-ascii?Q?kAOyDZpVCzcj3vsVDiFfganiORfq2Js9/4o66hxFR9UD5YYlDGF9EjrMpZIG?=
 =?us-ascii?Q?Co73M/Ss4zACmDBMD52yXVuXEKFfI67cS7IJ0ShUH9ivHVsZdMd8c99dyh1I?=
 =?us-ascii?Q?7GUkkWgNSAKxz6nvmATdnLXqsaGCZ6qC8/mgznyeYyG1yh4fQ3tvDeDdm/m+?=
 =?us-ascii?Q?deOnt/c8Ix5FxEDdp24LV5D7tp0fhjI9aYEHfZhOsHDnTuPV3IkaJnyEACez?=
 =?us-ascii?Q?Bc44hWdz6o8Lbckn6KLClVT75tbwnd6HSPS2Su7ypIUi53FKQsPp3GLkBLS2?=
 =?us-ascii?Q?VGRIgF2pE1JkC5BM6aOCdj+jhrZ36IPj5PHo+7/HxYcgq1NQ0oZGjWkM2XNF?=
 =?us-ascii?Q?WKkVAo6DAQyF1c1F5K1oXc14qv/NXFQkBdnDnOa8TRU9zNpUNyYAcoZozl1K?=
 =?us-ascii?Q?Q8EoEgovOiNiHKjES1ABo1VUYnNq5NwRCdG5ybOByAI6Sjh/Rxl1ip8wbQ1Y?=
 =?us-ascii?Q?3KlqPZ7vASP0AoDAUqENcQfZx8S30eEXAy1Mf/hJd8vs5O4I+xxwkXfirpDh?=
 =?us-ascii?Q?bU4kZUsztfB/2r8jnz/Wy2GdG+ly86OLhjWCn4aoS3Q2/mVrh6nAwfHaBsPS?=
 =?us-ascii?Q?KKJKEE9MakmdrCVH/hxEOOMRJAqKrkeYRzEBYuWTG/RIsf6A+9prKl+rtm/u?=
 =?us-ascii?Q?yW6dN0JTJu4pmMXrXtXlIUyBFlhoA17ior9hR2SSjedXTMsychSq9dOkOzbf?=
 =?us-ascii?Q?Fs0uhL9hXWoDApSmyq2Dxi9wumTAMrEoa6be3lhKEJ6DU0aSRPfBJ6zMXYnK?=
 =?us-ascii?Q?1zFdG1DXQ0UaJcSmI+ATYBco4bfu11B2zU+XyclxNuiGnAxDOiBRVXTSDQJ5?=
 =?us-ascii?Q?al920eLH38IH4qdO95tPcFI+u2cUVsLu2EORKZxYaV+d/u0Fs5x9VD9dif71?=
 =?us-ascii?Q?Inv+dO+vzWoG7+AjTr4lAh3l86SGI7o4z3qM/Ma56Ww5maFmLqfgC3rMWgnc?=
 =?us-ascii?Q?fd99FNywr57sUevv9ytAa/3USDuf52ltgDIBHGcZUcfWyx17uw9rajXzSyWT?=
 =?us-ascii?Q?f6R3ziQDxeDPH/OMP7UNO593kof2zxnc3/85vsFak1EYteISWkgCCmxv/HCx?=
 =?us-ascii?Q?Qf/myNHLSXkXnqJL0cWhxcMg8VnzrFVqkd+TRFPF2xD/h8pZoV2I1tZIo6Hn?=
 =?us-ascii?Q?JJUr4EP8LyVmKewze6R10Ta/g/BYq+jwTRhMAbJ/gH7MgkJhGBpBuaGXmQZb?=
 =?us-ascii?Q?lyYRXylu0DGEPzGfJPcJ19/74cFJcsF16LKAjQEGBrl6GSnQJV98eVLbbIi6?=
 =?us-ascii?Q?soyksK1StIpUczzQorMMPbWM6u43eB8Fn6rCAxAbAxpJBZpk7GVUWzetBVUe?=
 =?us-ascii?Q?mJkzUOTJboYthPEKHNjX1e+1+1yFvH7qtekM1JdVEph7zqrwLS63yXELXYtA?=
 =?us-ascii?Q?D+5VY38EFcBuWrPGYl0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIHep31TcJrOvTe4g5Pm0+O5R5+J7CwlCTb+wMY/TtTuo9QyVzM6ZW/sqHBm?=
 =?us-ascii?Q?yx26wp1lRgyiBBQvBP/E1z0GEbY9kF9cTAKNMniG7BdhRqaFWyinUX/S3gi1?=
 =?us-ascii?Q?HBo/K5q743H8KIKaUl5qfv0vs+6o19AzQjObN9/TN/wytJuFXxMYX+qu7RXm?=
 =?us-ascii?Q?JrCqoDTbUK3N3FOZu9Ye5Lf3Pjii5GaHPSRAM8yd3utWMyOJCe6SwB5NwB7r?=
 =?us-ascii?Q?Cz9MSQ9S634SQQjvIk3KEX2rpW450hY5YzxnMvr0U0tPQFM3xgLiC3BG4fhI?=
 =?us-ascii?Q?xW6a/vIwDEM6fq2QEoWFAcostNPqzMrA/80fVhPlhznH0ovNVqrA56e5eNIq?=
 =?us-ascii?Q?Ulo19xK/CIx6vjiN0372pcZjVGNBFyNatgZlc8H6lJML3WuMxsB4LCT4bDym?=
 =?us-ascii?Q?dufhcGcSyYBWAJzpZL94bHnigCsnHwD6wM4gbLIIYhTCsvfgF8iaP/oznNEa?=
 =?us-ascii?Q?LPSMn/7IH1BrdvQG8n6Zw32dRiZ4+uizTBRih4/zSiTVTVHviOb40I2/jtyY?=
 =?us-ascii?Q?UC7CiI0q5ejANcyIesZV7Sbeub17b9ej0K5FHuOkJbZmFndfNwhWg6LIDFRH?=
 =?us-ascii?Q?y58xM6CPRVPTpTGEMNE9xra1aK2pSkYwKIT6zC7Nk1BU9XnZORaH+bDJStjY?=
 =?us-ascii?Q?sGeWpQLVdkhbEcD9pSZflmpi3HYO41MeLzwsAI+LdSDdjufX3JtchqGqLtRA?=
 =?us-ascii?Q?S3u0KZM62u7qH/WekuEt+XhFtxpO2k+tDlRXM5Edh5aVRh5UXhobCiqO3gTR?=
 =?us-ascii?Q?2KzgOGP9iEfb97MddOlbuNsbjZmaEGUoQZtPoZWEqX+BG0snHaJCzYRDP52m?=
 =?us-ascii?Q?wzN+PErYhEV4iCkhO3WLaQdicc/ZUmLc5yA5fFQsrNaeI3d+Z2v9NCWTCXV6?=
 =?us-ascii?Q?UGtFxkbW6c0qN29gbk26OWwUAt+lxztVmUQiaFSP6Bz8ZAE9cFpoWAVorvCa?=
 =?us-ascii?Q?iWlhevzy76kKsl+1RnwY4SvaBkEkdRU+jQI70AyWtrUhRr0nrwDvAj9lXiFx?=
 =?us-ascii?Q?HpDofDrpKDofMa7d/S/kMHfKH+II0I3fM1LF8o2hwrJOEL0kiQkALCj5wxeK?=
 =?us-ascii?Q?GqVCW3WaAwOl1ZxZOowX5CQ4daLAjFDg5BSIGRP1m2DfUIR8ER+R/pLLPhT4?=
 =?us-ascii?Q?1WuznB2H1Y2Apl4fq8RHcpZnc+1RTnOy8h2q1nXZPY7lFGt77MB8nC3ccrM2?=
 =?us-ascii?Q?3n5vO48uXhsyTysH8R2HcTarioSupcc4v64t96OpB7CB0Y11SZUOIphKC7cN?=
 =?us-ascii?Q?EDpUwLfjYB57fo/NjWajOiY98sUmityBx+C6Kc/Y0ZLZarmRIetClqKSghw5?=
 =?us-ascii?Q?xz7U3tAKzZT4opUOw/23iF9BfM8W9/SgAorcz5lFEhipyktno0CZAiLCYSZm?=
 =?us-ascii?Q?QchNCrC5HyyHMH6Eye5oR69Cl9dCcJ1KgBR7ybOnD2w1ZLDiOjn0iGpUN2KS?=
 =?us-ascii?Q?wgrm3ZjfrkebM3Dwj/cw3VZDSMmZeRl90Ux0hIqhNUWwe4EFQHcMzgeL17Vy?=
 =?us-ascii?Q?XTB3z5e4vexXfbzW5x5lWuIyMV/fs4qkI7iZEfujMJYekZklBRLjU/BuRite?=
 =?us-ascii?Q?e9woSREnNVCWO+c2Z3YZtcNcFpo3RSy7WHBhhOweXmUb3yenlzskoDM5j13G?=
 =?us-ascii?Q?KtOwOfD3hLENH0BqM6/NK1UFHJoMMSzJl5Bb0o++TWOOgSoiW2a2glw44vje?=
 =?us-ascii?Q?0+8+k0ZbhNCR+eTA69v9GG9Es2ejzSR818kj/F89sK+OHiZT6p7RXBmuui+J?=
 =?us-ascii?Q?6y9bmAt00w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d307de5c-824c-42b6-433f-08de681285b8
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:36:29.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1YptPBSb56nv7ygDq17Jqs0YAPg1071C17aKdjtnQomLP594mAOm78njlbSp63o2Pvqt7bDujo/AD0I3CMUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFEE549A404
X-OriginatorOrg: intel.com

Davidlohr Bueso wrote:
> Failing the first sysfs_update_group() needs to explicitly
> kfree the resource as it is too early for cxl_region_iomem_release()
> to do so.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/region.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 96888d87a8df..28d70497283d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3795,8 +3795,10 @@ static int __construct_region(struct cxl_region *cxlr,
>  	}
>  
>  	rc = sysfs_update_group(&cxlr->dev.kobj, &cxl_region_group);
> -	if (rc)
> +	if (rc) {
> +		kfree(res);
>  		return rc;
> +	}
>  
>  	rc = insert_resource(cxlrd->res, res);
>  	if (rc) {

There is another call to sysfs_update_group() with potential failure after
the insert_resource().  Does that need to be handled?  Or is the resource
turned over to the root decoder at that point?

Assuming it is ok.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Ira
