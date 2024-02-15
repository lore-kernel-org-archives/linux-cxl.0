Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FCB4C69
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707967941; cv=fail; b=uDWJGTwII69pfgWMOK8QIVFelDY2spdZuriWFI/YCE1nTt3J6H8CMTO53WPGHBP/aPBNn6eD5MdmczXMx0+K3daWL5R0VCg/xIBBLteMgdtSZjQeQchQO4t3kQrrXhkJSxqCNdVsVtMiEo8Q423ffWyg4MdJCDJP7soboONr2b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707967941; c=relaxed/simple;
	bh=T8soL9LGt7FhKUaQCmeg2yPVvefdoQSI+ZWsP3jczzI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qtoePyLcFJc0zKZU6PS7VsbnIrJSyWF40cUOQ5krZCinONOHFFpxYcl0EuyO+956JPeGHz83DZHTDazykjc4zTfw7seCWrnOxt7pbEy6Pb6rpWD78IlJA3m4IQLqGL+73NVTP+ECg3+N1b9j80tZVN991ahwan4TQ0UcGXkdmlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lbXzQIJM; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lbXzQIJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707967938; x=1739503938;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=T8soL9LGt7FhKUaQCmeg2yPVvefdoQSI+ZWsP3jczzI=;
  b=lbXzQIJMUKIwDxbAsUHujXLUWN3deouJyn3SfK9p3VR0467MYpRBwLo2
   2CSJ2Q2kxDN9tdhBzlgK0e0kJx/zaVcgbNfBI7X8A68KL+SfRAfsj2/GK
   RGJwlrlOchtqITcECDw9GDd/sj0OY5JNwjsOVsoTRus92Vhr0ej9K900o
   fqZJtgjS0glwhWoZWNDsHN/gt6E+ns/LxNqb2dx8B1BjyOFYAB6U3dkXk
   Tl2leMp75/zjuBkR3pDhud94VFfM1WthRCl6k9yPEDlrmdcU7cv5BT8rh
   PLBr0Togqx9QFX/vgHwrigwdMkVDwK+tF7tjb9xzPJlyfx+lDMwx1COmr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13142533"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="13142533"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 19:32:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8144177"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 19:32:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 19:32:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 19:32:16 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 19:32:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 19:31:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvY4wVEBJNyR6GAaglDFx4UdM7O782zze9hvBMvO3ttSIr5L/OiAbYcEls5jmu5rtEjIedgsQZCAMcQ5G6nzHwgbn122g6/+qeVLJ5D7REIaQpVtHKM6NO1ltglUrSfVhx6ivd+87offY6c2lhEASB8oVR93LlPEZbffN/PciVjsBg3J5owvtOEIA8UfY/KNwMI/rJOidZ8NoeXwATCUKY94pTV21cMf7/r0efGcEJKCsWJH+zWF7gwgmLV/ADpY+v3h1yOOAyjRK/8/U3XtIvtW0xlqX2njVHJgUAZh8n6LmDNwsu2XdM7DZjfsMCvjYGS5tRuWupkZizkWIykyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyihrbUvqeAKJGrPyXAcg5yBMkVO0TpaitPqnisvfG8=;
 b=i+fqk1WjKnOXFTQ7dtckk25fQSNz8HYZynoXAHX2QbSdf0uyNMn6zVB0eMFsjm6PnOqnYs1QVGZRk6GL9bvsiebynOYrQYuwNQDItZdRaHZ8x7RY3LyU1fkNytG04TeRbb4k/FaN+4w2KxESfSQkH+Hy/e8T4aOiS+aborq9A8qK/tM8dfmOnY8kstDhuXp4moj6FBDxAr+a4RuPBruwfn/ZbxkSY8KD+kTpmJ6P9nRYxAbg8Y9j3XO7Oi2W/hjSuCMpMN2x9JvTk+o+j/DFEIRPOvXBbmr+JcVsg8mOAaLFNvoYOiuWiblDDclghq3GDoXKARz9ltUNz6767F/GQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 03:31:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 03:31:26 +0000
Date: Wed, 14 Feb 2024 19:31:23 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <sthanneeru.opensrc@micron.com>, <linux-cxl@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: Re: [RFC PATCH] cxl/pci: Set default timeout for background
 operations
Message-ID: <65cd858b3e5bc_5c76294dc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240207105349.301-1-sthanneeru.opensrc@micron.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207105349.301-1-sthanneeru.opensrc@micron.com>
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 389568a6-d0f6-4a59-27d9-08dc2dd696e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFyBXgc794gdzj3tHDj1ASSQUsMTrCdyWgxpCtROVkid2EHfaGUtOlqkTvONOfgpEvbEGSFkVyl7+nGql6YY5aUxFohH72bkjgRods3Z96m+rV/rp+fLRtxKj2qCI452E8t3Fk5jrtoKxSiLmjcvjKM55BExhkh6nF94Ls+gEWGY3qCtOD/n6EQFVXAM/VakJkom/rme0ebW8/OesET8oHupf//8l9logoGrkciaNw5F8cwU6vqMjhC+R1SA/152dOi0X68ySAw9iECxwLuVzNy1MQKChnx3VAz8TJjlb6K2U+SS/VfKCIrW3bzIDUxIMlLEwIQgUx399cQjInpXrx6oD0fVp+mkO701voEH3LiqEry61zWIrEQID6e+nZp/OzzmuhlrxVY7SRMjiRjBPjfd6Czb86aXkaEaGWhh/XOTjpiz6WTk47VzJ952vPSQetynTtSrRMmVW2JcTBeZTHtXmdOtMR0nh/eWbYjJVU5t6dvpNPpkyKdw7hPsxKBWTyL7TjUg1/ATEPCe/RO7UHDCHZ3M40v1ZPL3uM6Mnro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(26005)(316002)(41300700001)(6666004)(8676002)(8936002)(4326008)(66476007)(66556008)(478600001)(66946007)(9686003)(966005)(6486002)(6506007)(6512007)(38100700002)(82960400001)(86362001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmdmK0U5eEdMdXNMMERsY25yZ2UyUVM1dlFMMmc4dDkxUXh1S0RaK2lEclhi?=
 =?utf-8?B?emNxVTRjOVZBRmpzSGl4WUFJN3BibW1UQ1J3cm92SjdjWHdKUDQxZnVaMzBr?=
 =?utf-8?B?dWR2ZThOaGlQZmIyaklXcEZVRkpWWFhMMUYxSzBSUG1PajJYTk9FU2FOekN5?=
 =?utf-8?B?VkZicHRwZlBxTG84U3ZGN0pyYzdDTjF6cXhSZ2o3U3RHMWtMSW9kb2dWQXV4?=
 =?utf-8?B?cDhPc0ZMOTBNaHRTWVF1OE9QcDFyUGZ0NUExMXBhTzg2WVVZc3ZSNFk4b2pV?=
 =?utf-8?B?bSttc3Y5dVdEaTJZRVM3ZEl2dERqV3I4dEMxL2lGVHF4UXlnSCtudDJFUXVv?=
 =?utf-8?B?cHVONXRyLzVOb3Vpd1lHaUNqZiswaEpkNm1iSjBwVk05U1J6a2VZMjFTbks3?=
 =?utf-8?B?WVF4S09ZUmJkd09kYk5Sb3dXdkRQZXVZV2Rua1MzVEdBSmlIMWZzME91ZjF2?=
 =?utf-8?B?WjFqL1hsWkRIRENXQUZaZzQ3ZEFoeHRUVlpsKzFpL2htVWdRUXlLMVBxaWMv?=
 =?utf-8?B?Q0tWRFQvOXpwWUJ6empKZkRZTmZQajlhRVV2UmwxYXZ0bHpqajJUZzJQTFZs?=
 =?utf-8?B?N0JiVnh2WHpudjA3V2JBc1RxRkwzTkc4dzhJME1OQ3YrcmlrdzVEMXZkU0d5?=
 =?utf-8?B?YUNMTjBzUHZPbUNKS1B3bVg3Nm51RGthVm5JQ0NJZmV0cXlQQWU3YkpMNHp3?=
 =?utf-8?B?T0dyTVN5ZVRnKzlOanVQdENyUC9JTDEzVjJOWXg5NS9mNEVBVExPTnVndjhk?=
 =?utf-8?B?bDIzeTdzajJlNlRPZFFVbzJNTTdCMnp0VllzN0p1SDJUY2tEQU1CcEU0N1dR?=
 =?utf-8?B?eHBJYUZmVWU4VnVrc1ZxN2NUUkoyWWluQjREYUhjQmFkMXFxTGd5bUp4RGJZ?=
 =?utf-8?B?Y0tzZEUzMkZ1UlBrKy9ybFAxWEhLWkZFQy90L21ldzBqY2VIU3g1c0xjUHF4?=
 =?utf-8?B?MEZaVlg1OFdmRG8vUUlhZTRPaG42UEtIUzJtYW1zWFFCaVcwVGx1Sy96ay9I?=
 =?utf-8?B?TlhySnNYc09sYkRvSEppMWtpOVVxd3E0ZVZsVXVSZ0l3QVR6bUdWdXVpeEpM?=
 =?utf-8?B?RHZLSkhHeFQ4MXdJM0NlRWxFT1dnbm9LYlZKcnpvT3ZTVTdNMHViR0c2bDNl?=
 =?utf-8?B?bFB3Rjc2MGFpakJlcjlrN3NYSHFGZ1NSNndHY2JXTFBZbDhJVnlYRUdZa2I3?=
 =?utf-8?B?dDUwWjc5dFd1UFZPeW9ueXR5VWV5OWN0UTJGMzRBNURmUHJYNHd6OGFGQVNx?=
 =?utf-8?B?bmFSVE90TTBseTJsVVRVWkZ6b1hTby9zZllVUFMxWWdxOFVoZ2JocXgra1RT?=
 =?utf-8?B?NkZtN202Zjhqa29OL2lwOS9vRU03NmZObnk3TUY2MTV0OHhRVWY3QmFUTlI1?=
 =?utf-8?B?NStOaFRNMUxLUEo4QTBmYVltSWh4ZngwdGFVRnIzaEsyaFRRK3FRamloOERK?=
 =?utf-8?B?ZC9KUnJjdkhSUDJ3N2ZMclk2SEF2U2NWUTZ6bUs3ZmZnbFR6YWtlbXNFQzll?=
 =?utf-8?B?L3pNRTlRZyt2K0tRNEVsajZkdEJKd0tIWHY2YWxqZmh5QWdMVXpQdzZjSnpw?=
 =?utf-8?B?OHFkRC9IV25NdDhGYmZJTWltTzlEamZJbzBTUXJ4SVNiN09DZitDZDkyM2tr?=
 =?utf-8?B?VDIwTm4wVU5wWHJFbVhKZU5ZUXpTOUdmQ01jODA0dkNqS2J1Rk9neWtOdS9t?=
 =?utf-8?B?akJER3ZUK0l3TGJNUEZNSWh5czN5TElMNk85Y2dKU3pHUWVPQWVONXZSTmpG?=
 =?utf-8?B?cHBNRHdYSDFGNGwzOWhpQWdDblR1SUxiTkJBWFNPWTU1TmE5MnY1ZDhsYksz?=
 =?utf-8?B?cHNEQ2J3R2xLdnpyVGZHYm5USGIzS1JrRE5ZNG5rMytOb3FpdmJURHg3WE9j?=
 =?utf-8?B?VUwvRU9MaEVPME1ibHZDVU1sNjB1RDcrNTBIZldyRm9URTdraHk4Y09xeWpT?=
 =?utf-8?B?QjZuNi9wd3d3V2Z2bEZFa0c3UWRjdHNBOFVOVUg5UWN3Qkc5MFhVZXdiSEFC?=
 =?utf-8?B?a1YxdktNOTdMUWpzRFlKWHNrdkF6a2JiYmhKa016a29kK3M4UXpmdUhreGxP?=
 =?utf-8?B?RmdWa2dHdjBET2ZaTUxHbFc4TFIvMGxxaFg0bitCK28xc0dFWEVPQUxrbmZT?=
 =?utf-8?B?ZHg2QUg4U1R3SzRIcC9PNWtHVVZUaVF2ZnIyOVdlL3JVYjNvRUVvTGRoM3dS?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 389568a6-d0f6-4a59-27d9-08dc2dd696e7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 03:31:25.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfwbrxftZkOe4LIFsKby/uZfPgYs0jaac3tbf/2bd6R031u1d6c6+kmcPCL/LmcD2E0OgumZ0JbramMXxVvl9BZ33jai0yhx6zoV9K1Y+v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com

sthanneeru.opensrc@ wrote:
> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> 
> The CXL 3.0 specification outlines background operations,
> and support for handling these operations was added in following patch.
> 
> Link: https://lore.kernel.org/all/20230523170927.20685-5-dave@stgolabs.net/
> 
> Mailbox commands like ‘Log Populate’ use background operations
> to complete the execution of the command.
> This can lead to a timeout, since there is currently no option
> in the ioctl cxl_send_command structure to specify
> a timeout value. The default values being zero can lead
> to the driver reporting false negatives to the application.
> 
> This patch aims to establish default values, enabling mailbox commands
> that operate in the background to continue functioning even
> if a timeout is not set in the userspace application.

The reason there are no defaults is because userspace is not allowed to
issue background commands. The CXL background command definition is
awkward in that it allows a single command to monopolize the mailbox for
an indefinite amount of time.

Instead, the approach taken with Firmware Update and Sanitize is that a
kernel sysfs ABI mediates access to the mailbox and facilitates bounded 
timeslices between command submissions. It effectively allows the kernel
to manage fairness and more importantly preempt userspace if it needs to
issue its own commands.

I assume you are only seeing this lack of a default due to building with
CONFIG_CXL_MEM_RAW_COMMANDS=y? If yes, "raw" means "raw" and the kernel
is mostly taken out of the loop of saving userspace from itself.

All that said, ugh, "Log Populate" has no facility to time bound the
population of the log. I do not think it is tenable for Linux to
surrender mailbox access for an indefinite uninterruptible amount of
time... unless you want to handle "Log Populate" like Sanitize where the
unbounded background operation is tolerated because the device is taken
offline?
