Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71B291E;
	Thu,  6 Feb 2025 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802874; cv=fail; b=rR/vMOJa+hv9qtXcsd8ToloBn43VK2fGiUOvSjr/QMU+ADAyMaVp0Oc2ZeueIvKUVFFVUz0HoGujfsTGRowJWLRVY2UPJe5MqyDzQkNEyrGwJvAnheu0UixeP+4rpWxWorJNl1gECDrwfpr2diTx+ncGWor6hU7SFOE7v8yluCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802874; c=relaxed/simple;
	bh=BfW3FvDKK0YBR489RYl5kO8JnFWLELyTAVsqbJkKx4A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p9K+AnNfesTRGDuE7y34eu0eF8vNEuAOZHI2Q/aOZ/oEitr2WcjJN75nmcc4AbBKUiSZenM9kpaxtVTU8LCavdDLH7goFYJQzC69bBxpzpSbAj8B148dpwLXZifYgg/lkVtZJJ8zrmqFV64BSOVaEeoPNkt/CEQwipfVf1M9GuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHndyp1M; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHndyp1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738802871; x=1770338871;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BfW3FvDKK0YBR489RYl5kO8JnFWLELyTAVsqbJkKx4A=;
  b=gHndyp1Mkclse48YIHVxRrWAzrRRrcplKSkoWAIS22UpamdDQOVT2oDv
   ditQmQcPjJ6LJ27vzWcBlXu9u9enkpyf1MtAVkap1ueX8yhdggstoDPSF
   gvG98zWFznFVAfLvBEtathQo5/yP3RY0NFpsJD79Dm6eof9hncMnmTm+t
   SG/4o5bTo/C6Q/ogIaNThKJcXsAO1iEwiIyHA5z6GpBYdgz61nA8kyyE9
   MMukZL6OHAb9DCeFypy2rpy+AfU6nc/jt2iIn2WE32sCUUjVZug/TAw1z
   e2hNOknJZGohMUcPZQCLjcpl6Qp8ZComxPJVQfj2hsgBaJb0X3QmOIwDR
   Q==;
X-CSE-ConnectionGUID: ulJ6ggwhS3KvtZD/+B6H8g==
X-CSE-MsgGUID: 2W4UHn4qTuaewl02HQkB9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56938731"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="56938731"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 16:47:50 -0800
X-CSE-ConnectionGUID: 81SqMDxySW+NiVKChoVdLA==
X-CSE-MsgGUID: ITl8rUUIQYCRiEbN9FvjFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; 
   d="scan'208";a="110895100"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 16:47:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 16:47:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 16:47:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 16:47:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMHk/FrPjv0UvCi36R55ZUk03Swyj/DVGHs89CpJED05iTvr7zWmy36SOSgcaxD1QxIYTFTUXBgXRTMVRSn5i7X/CqqHWmHqMdBinzbyZEzauJmsVZxWb1pV3T980NrlQ9iWIMvXdyjW+ZwHVTwQQ8FT7Vr29/8yL4qeppXginms0Q90qybnuXldn9/HHsaJc+9YEEXQaxtj6cVwk+9yMUQhaVhb3F7LMbwFDZM0XJkUhGOOZDmY16pcc9MWhBgReBOxTI362APfGDC14IQlfBPu7ydOvWvGq7LYeh4qfo/xFYnKxpygtcj+QdfqubzUWM9alBcEc+q/RE1PYkqj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3n1eOhQi+x7f43UNRZUZWnvsqTCCDXUpQyHZ1/TlE18=;
 b=cHN/xmPTVkVH8RLh2F/n3Yna8IJy0KvDb4jqY6vIhg+FXn4PrTh1jr91E56VTqMnbPPwswLy+wLYogHwSKJHfw58LpA4kYP+1OLN9mTyEQNlUFgihkbjbKD2JPfA4ggC1WrCxCugErZ3Iu/DaC2eWP5wEKqv3wOqXVA5AqMc5uiMEk7atcP1Td3ZS323LFeXUGLFlhVyJW59X/LPJjj5ZtPPuQ/l5MYpQ/If7D+GdV4mqwUq8DkYKhA8vN1ztLI20+cgROpNIxoSn/R0oQ935AItf24O/UBpUXz4pvvOmBqR27wE+01Wj8wY8CX5CGIyhkx7wPqKUwiIuoWuYTsRBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 00:47:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 00:47:19 +0000
Date: Wed, 5 Feb 2025 16:47:17 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, <lsf-pc@lists.linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: CXL Boot to Bash - Section 2: The Drivers
Message-ID: <67a4069572eab_2d2c294d4@dwillia2-xfh.jf.intel.com.notmuch>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: MW4PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:303:b8::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc2e568-a5b0-4f7d-ff54-08dd4647cfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ctXTIr99x5UsHY5ONXNYy6Vm1dZQzVPhaAmRiQThd6kKTh85GyVBwnTmg7vg?=
 =?us-ascii?Q?/4I+WD66eg7weLpIj4RlRtevTytosrIpUClJlIapKKgOdU201wx5R9joJEeA?=
 =?us-ascii?Q?JXh1dZjI5n/7ZzDWdNoules1xFVaIbl2+evLEboY/WyjfcJPpN8p3wjX+ymo?=
 =?us-ascii?Q?z4OY9bdKaFP2B8D36bAUpab4sDLwCvUZwU1vNLZKtGzcMBoOOcLNLZrCzIdZ?=
 =?us-ascii?Q?Ir6BZtldBY8U3QS4d+F7M3FVwG7vZazwhDDjumk3Y/nhFgzyZiUU2UCBYZbg?=
 =?us-ascii?Q?ip8Prs8uuWSOKlekmmjx6MnroxsU4UsAUmrVh5QORW1KqKX8BwRehhEOMc/0?=
 =?us-ascii?Q?nD+RFyalvlegy3+CHaGKs1Ys/Tl9OHHHYr15q/hrQ9Aj6jM/RA2HAEXQxdYm?=
 =?us-ascii?Q?Qlt61K9Wc8FlbAx7WlBIsjwEz292/14ZYgOlvx1wt3EbYGj7Y15CRy+uL8Fk?=
 =?us-ascii?Q?AAdO9qJOrk7Leb0VnXDk9fVRylfLCI1TrHKK51RvCz6a6A8CMPZId+Ji5NqP?=
 =?us-ascii?Q?X+qlft2+G4KhBoSl4BShNdFtpDRkCO4xL/xU6dvwEXMOt8fWh6k+289ICrab?=
 =?us-ascii?Q?mHKcv0PriCllO+aYme0zJVlCw8z9QgT9yxF3DGYUTTTn4V0+sTs/IvGpNSyw?=
 =?us-ascii?Q?bCGfEtlniCzOlrwkIXrhQmlIlRhNE4VTvZ0XUIGsKkUJuvfJ1PZ+DDV2Nu0I?=
 =?us-ascii?Q?mGyLco6/Ib+UwsZslcd2uKA/d2pplisfWJ9yn6ge08zgzPIkuTZVz/ErqtF3?=
 =?us-ascii?Q?smRbUCf1+APbXHfvNanfL74Ll507/U49LDXTKJPEW+DLSlrIbINDBMoDiz4c?=
 =?us-ascii?Q?lh6ljHQP7RRgBrmOOVAegJYYLYu6Z1p1FkHr+a7+sXMiXQWF6EiI8IZ7sfCe?=
 =?us-ascii?Q?c9UqZgjuEi4fsRbqa3xa+TOjEyfceimlxuki3OiGGP1DBv0Hhj+eeZsPmKRa?=
 =?us-ascii?Q?KMlFxgq28uSpftmTGBjThjwWFIs7szkCnZ4GmQRVHjhctElAf+n1IwF8cdZd?=
 =?us-ascii?Q?Yq8CNC2yuIrRr2/BRc5c4L+UQ3e1jBL0iFPasJdfV1PNi2x4oddl5eEaJ3Ii?=
 =?us-ascii?Q?JYifT+elQpaWNZuWdoJIxMi5hqnMJYezlaIy2I335pMDPjCmLOBg0ny92j1i?=
 =?us-ascii?Q?6rFK9PJzAL5+xdprhSO91/5B0NaxsJhRs3qAbPY/rg2Rd8cyN7uZMRU7Sq8N?=
 =?us-ascii?Q?HHPDwG3B/7lKmVLF7JSUWc3WmOR3398uJbGg/B/D6Y8BUC8nzwdVmYoLrJsK?=
 =?us-ascii?Q?mDp9eqWkFcnzuyqkLeM8gfPgcN3FJ6Ew75OUNlX4JLAFCc16RSE2uSGdEXM5?=
 =?us-ascii?Q?gJuY/aDC0T5Nmh+9RA+xafGw4bcsvD1PTfvUD9urY/cgKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fKeL3Gulu3ZQJsCy7EaRzcNg0HiG5NzcnbJW650f7KaUzlq3KDNwXX2tCKNo?=
 =?us-ascii?Q?WmjPXzBuimYAgnBEErFGqLzP1oINtcJ8YtS8Ds0zqhf1QhfogONY9iO9XmpF?=
 =?us-ascii?Q?1K3dVH7sEm7bnTgCnekw5cdWNQdCC5MU3NGsmePRJoQWXry6vsygnFUvkkXQ?=
 =?us-ascii?Q?Q/twgQVoc7IT+Stat7eFp0edfILitzDQ7vXhcmto3iJeNvtxkNw40kFBNur8?=
 =?us-ascii?Q?pgCUT4Tmh3ThCjWdvP/OeBWyna8oDesow5SFp/rHXamlaQMSxVBdD53pfEfH?=
 =?us-ascii?Q?sYXtzgH9yfNxVSQnG1eGU17wh7UT5LOOfPjQamTAngIFR7pKXIX1RNmqXWPS?=
 =?us-ascii?Q?BHO2Ng+vOY9dNlIdZ9eLTakzvRn3WxL+MzlKjJvkl2dUktdZoIQo7jQHw9CM?=
 =?us-ascii?Q?biQR2IOak9YqeSW2hrF2fMlgAWfuMPdN/EjbvIHDjwxef1CiSElTMfala1I7?=
 =?us-ascii?Q?1WOnCu046TPLlsJXRb6bnZaBppnpCD+plxjssSU3I+RB0FZQHUCl5R8dQKbI?=
 =?us-ascii?Q?DG1QkxDm0wc2PdHlfU7zdG8KJqFYr6Oigw62u8YLwYDFNonnIWMnQXar4ycm?=
 =?us-ascii?Q?LXF1P3QYyVu5qJowXEHpVEl4P4jRspdwAISJjqnpqCDawPMpWScXaTpPc6DP?=
 =?us-ascii?Q?oeIOSelC4cFpSij4zbQv2/gKvTHYIZEuXndgHi7vkXn6bfTOqeTPizqVMHx9?=
 =?us-ascii?Q?gNcd2CcsqXqRZE/8xi98jBc4WKfDhj6YrEe8tGRGPoVo/8rE3kEW9QaXfYLL?=
 =?us-ascii?Q?r5oxVKLdQoFelL2LICz6OW7mrbLAuBEYZtyM/KKMm7wyrroLcouQ1ORREyn4?=
 =?us-ascii?Q?x0KGw8ow1qyekKKMAv067mRFyrWBHdLzOOt+oN7CMIR2QwudgeVnkJ2qIGOW?=
 =?us-ascii?Q?ovdvUTCSEq4XMpUUToENn1RERm9wytZdSQQieyLnv+rAgnlbWNQpTXeMeb+H?=
 =?us-ascii?Q?/Ucah2yXJFwWpvEXdVJ7zmW5oojE9GUmrWeLqdrgymbFnJVJY4kcv6CzFqht?=
 =?us-ascii?Q?BK9bGaocpxTYLEPgRzJbCiC4qxNQNI2xU7sI7oB2uk5H+nlrPGSZ/EsibJ65?=
 =?us-ascii?Q?R0rFO1nmnYpamLxpt+ynHVKvbmgdMgpd9MpFIganx2W6ZkmmMaZFW487ecJ8?=
 =?us-ascii?Q?0nlYXf4q95sp4sGvbd0OTfVeVcFUn3cv4d1Fsb3R2r5OWatEQpT2VbwZ6DlL?=
 =?us-ascii?Q?hhP/VPkm8364TFcx+9OUf5PGj339qPB5SdI/krcf4/ytT61Xri8FhJvBWShY?=
 =?us-ascii?Q?r07ZBSVXZNApIXcusdi/++1c8gpFo4WUNIBsy2MFIwJwIVtegVv++QI3xVaI?=
 =?us-ascii?Q?M7SA75lSQMzweYC6Onqsn9lD4qsr0sDb7z/szm2cB9wJ9kz/jU7Z/fZ00oWp?=
 =?us-ascii?Q?WUArm97/Wld7XkUfSMBjqRQAKAzA+FSrh0OWYa4yigc6bM1oTn4Qqy6hYmwa?=
 =?us-ascii?Q?COj/l3GJs0CvP7fN/4lhmWfwmuykxgmVa5Vrjsj/EIxyH6fBtyDwdXDcbjHg?=
 =?us-ascii?Q?ExAH1xGGX6hwzuM4qJQv6VTIOVsbqq2QZplCpLzl4Tk07gZPPvzAcySsgkYh?=
 =?us-ascii?Q?yvzBCpr4hrBolbp7KDe1cylJhHrz53x0dTBkUxsaLJ+B3cZ8JTjyTQ/7uNCZ?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc2e568-a5b0-4f7d-ff54-08dd4647cfa0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 00:47:19.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTnNsj4l8eOuFhz5MkaC/4Nm+FTo+y+Kw8unsD83RP5bGOTIJPTOBS2sZU0QykorcqDzecKrQJuKT0zOGzcL/pOQ2qQQkR/mKOjJ3doKVUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747
X-OriginatorOrg: intel.com

Gregory Price wrote:
> (background reading as we build up complexity)

Thanks for this taxonomy!

> 
> Driver Management - Decoders, HPA/SPA, DAX, and RAS.
> 
> The Drivers
> ===========
> ----------------------
> The Story Up 'til Now.
> ----------------------
> 
> When we left the Platform arena, assuming we've configured with special
> purpose memory, we are left with an entry in the memory map like so:
> 
> BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] soft reserved
> /proc/iomem: c050000000-fcefffffff : Soft Reserved
> 
> This resource (see mm/resource.c) is left unused until a driver comes
> along to actually surface it to allocators (or some other interface).
> 
> In our case, the drivers involved (or at least the ones we'll reference)
> 
> drivers/base/     : device probing, memory (block) hotplug
> drivers/acpi/     : device hotplug
> drivers/acpi/numa : NUMA ACPI table info (SRAT, CEDT, HMAT, ...)
> drivers/pci/      : PCI device probing
> drivers/cxl/      : CXL device probing
> drivers/dax/      : cxl device to memory resource association
> 
> We don't necessarily care about the specifics of each driver, we'll
> focus on just the aspects that ultimately affect memory management.
> 
> -------------------------------
> Step 4: Basic build complexity.
> -------------------------------
> To make a long story short:
> 
> CXL Build Configurations:
>   CONFIG_CXL_ACPI
>   CONFIG_CXL_BUS
>   CONFIG_CXL_MEM
>   CONFIG_CXL_PCI
>   CONFIG_CXL_PORT
>   CONFIG_CXL_REGION
> 
> DAX Build Configurations:
>   CONFIG_DEV_DAX
>   CONFIG_DEV_DAX_CXL
>   CONFIG_DEV_DAX_KMEM
> 
> Without all of these enabled, your journey will end up cut short because
> some piece of the probe process will stop progressing.
> 
> The most common misconfiguration I run into is CONFIG_DEV_DAX_CXL not
> being enabled. You end up with memory regions without dax devices.
> 
> [/sys/bus/cxl/devices]# ls
> dax_region0  decoder0.0  decoder1.0  decoder2.0 .....
> dax_region1  decoder0.1  decoder1.1  decoder3.0 .....
> 
> ^^^ These dax regions require `CONFIG_DEV_DAX_CXL` enabled to fully
> surface as dax devices, which can then be converted to system ram.

At least for this problem the plan is to fall back to
CONFIG_DEV_DAX_HMEM [1] which skips all of the RAS and device
enumeration benefits and just shunts EFI_MEMORY_SP over to device_dax.

There is also the panic button of efi=nosoftreserve which is the flag of
surrender if the kernel fails to parse the CXL configuration.

I am otherwise open to suggestions about a better model for how to
handle a type of memory capacity that elicits diverging opinions on
whether it should be treated as System RAM, dedicated application
memory, or some kind of cold-memory swap target.

[1]: http://lore.kernel.org/cover.1737046620.git.nathan.fontenot@amd.com

> ---------------------------------------------------------------
> Step 5: The CXL driver associating devices and iomem resources.
> ---------------------------------------------------------------
> 
> The CXL driver wires up the following devices:
>    root        :  CXL root
>    portN       :  An intermediate or endpoint destination for accesses
>    memN        :  memory devices
> 
> 
> Each device in the heirarchy may have one or more decoders
>    decoderN.M  :  Address routing and translation devices
> 
> 
> The driver will also create additional objects and associations
>    regionN     :  device-to-iomem resource mapping
>    dax_regionN :  region-to-dax device mapping
> 
> 
> Most associations built by the driver are done by validating decoders
> against each other at each point in the heirarchy.
> 
>   Root decoders describe memory regions and route DMA to ports.
>   Intermediate decoders route DMA through CXL fabric.
>   Endpoint decoders translate addresses (Host to device).
> 
> 
> A Root port has 1 decoder per associated CFMW in the CEDT
>    decoder0.0  ->  `c050000000-fcefffffff   : Soft Reserved`
> 
> 
> A region (iomem resource mapping) can be created for these decoders
>    [/sys/bus/cxl/devices/region0]# cat resource size target0
>       0xc050000000   0x3ca0000000   decoder5.0
> 
> 
> A dax_region surfaces these regions as a dax device
>    [/sys/bus/cxl/devices/dax_region0/dax0.0]# cat resource
>       0xc050000000
> 
> 
> So in a simple environment with 1 device, we end up with a mapping
> that looks something like this.
> 
>      root      ---   decoder0.0  --- region0 -- dax_region0 -- dax0
>        |                |              |
>      port1     ---   decoder1.0        |
>        |                |              |
>      endpoint0 ---   decoder3.0--------/
> 
> 
> Much of the complexity in region creation stems from validating decoder
> programming and associating regions with targets (endpoint decoders).
> 
> The take-away from this section is the existence of "decoders", of which
> there may be an arbitrary number between the root and endpoint.
> 
> This will be relevant when we talk about RAS (Poison) and Interleave.

Good summary. I often look at this pile of objects and wonder "why so
complex", but then I look at the heroics of drivers/edac/. Compared to
that wide range of implementation specific quirks of various memory
controllers, the CXL object hierarchy does not look that bad.

> ---------------------------------------------------------------
> Step 6: DAX surfacing Memory Blocks - First bit of User Policy.
> ---------------------------------------------------------------
> 
> The last step in surfacing memory to allocators is to convert a dax
> device into memory blocks. On most default kernel builds, dax devices
> are not automatically converted to SystemRAM.

I thought most distributions are shipping with
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE, or the default online udev rule?
For example Fedora is CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y and RHEL is
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n, but with the udev hotplug rule.

> Policy Choices
>    userland policy:  daxctl
>    default-online :  CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
>                      or
> 		     CONFIG_MHP_DEFAULT_ONLINE_TYPE_*
> 		     or
> 		     memhp_default_state=*
> 
> To convert a dax device to SystemRAM utilizing daxctl:
> 
>   daxctl online-memory dax0.0 [--no-movable]

On RHEL at least it finds that udev already took care of it.

> 
>   By default the memory will online into ZONE_MOVABLE
>   The --no-movable option will online the memory in ZONE_NORMAL
> 
> 
> Alternatively, this can be done at Build or Boot time using
>   CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE   (v6.13 or below)
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE_*       (v6.14 or above)
>   memhp_default_state=*                  (boot param predating cxl)

Oh, TIL the new CONFIG_MHP_DEFAULT_ONLINE_TYPE_* option.

> 
> I will save the discussion of ZONE selection to the next section,
> which will cover more memory-hotplug specifics.
> 
> At this point, the memory blocks are exposed to the kernel mm allocators
> and may be used as normal System RAM.
> 
> 
> ---------------------------------------------------------
> Second bit of nuanced complexity: Memory Block Alignment.
> ---------------------------------------------------------
> In section 1, we introduced CEDT / CFMW and how they map to iomem
> resources.  In this section we discussed out we surface memory blocks
> to the kernel allocators.
> 
> However, at no time did platform, arch code, and driver communicate
> about the expected size of a memory block. In most cases, the size
> of a memory block is defined by the architecture - unaware of CXL.
> 
> On x86, for example, the heuristic for memory block size is:
>    1) user boot-arg value
>    2) Maximize size (up to 2GB) if operating on bare metal
>    3) Use smallest value that aligns with the end of memory
> 
> The problem is that [SOFT RESERVED] memory is not considered in the
> alignment calculation - and not all [SOFT RESERVED] memory *should*
> be considered for alignment.
> 
> In the case of our working example (real system, btw):
> 
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>    Window base address : 000000C050000000
>            Window size : 0000003CA0000000
> 
> The base is 256MB aligned (the minimum for the CXL Spec), and the
> window size is 512MB.  This results in a loss of almost a full memory
> block worth of memory (~1280MB on the front, and ~512MB on the back).
> 
> This is a loss of ~0.7% of capacity (1.5GB) for that region (121.25GB).

This feels like an example, of "hey platform vendors, I understand
that spec grants you the freedom to misalign, please refrain from taking
advantage of that freedom".

> 
> [1] has been proposed to allow for drivers (specifically ACPI) to advise
> the memory hotplug system on the suggested alignment, and for arch code
> to choose how to utilize this advisement.
> 
> [1] https://lore.kernel.org/linux-mm/20250127153405.3379117-1-gourry@gourry.net/
> 
> 
> --------------------------------------------------------------------
> The Complexity story up til now (what's likely to show up in slides)
> --------------------------------------------------------------------
> Platform and BIOS:
>   May configure all the devices prior to kernel hand-off.
>   May or may not support reconfiguring / hotplug.
> BIOS and EFI:
>   EFI_MEMORY_SP              - used to defer management to drivers
> Kernel Build and Boot:
>   CONFIG_EFI_SOFT_RESERVE=n  - Will always result in CXL as SystemRAM
>   nosoftreserve              - Will always result in CXL as SystemRAM
>   kexec                      - SystemRAM configs carry over to target
> Driver Build Options Required
>   CONFIG_CXL_ACPI
>   CONFIG_CXL_BUS
>   CONFIG_CXL_MEM
>   CONFIG_CXL_PCI
>   CONFIG_CXL_PORT
>   CONFIG_CXL_REGION
>   CONFIG_DEV_DAX
>   CONFIG_DEV_DAX_CXL
>   CONFIG_DEV_DAX_KMEM
> User Policy
>   CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE (<=v6.13)
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE       (>=v6.14)
>   memhp_default_state                  (boot param)
>   daxctl online-memory daxN.Y          (userland)

    memory hotlpug udev rule		 (userland)

> Nuances
>   Early-boot resource re-use
>   Memory Block Alignment
> 
> --------------------------------------------------------------------
> Next Up:
>    Memory (Block) Hotplug - Zones and Kernel Use of CXL
>    RAS - Poison, MCE, and why you probably want CXL=ZONE_MOVABLE
>    Interleave - RAS and Region Management (Hotplug-ability)

Really appreciate you organizing all of this information.
