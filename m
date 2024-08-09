Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF113AA38
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230839; cv=fail; b=CCmNe7Gq096UEYrIWSdgSGxiiXqgpWFpi1gBZqJHji43qXbQvuiuM0OLN7j2BAijvK/hMrk4srjS2/MegILbmtuQcr0GLnchLEh6lv99ik4c67T2SK3QxMsO93qEY2pDTw+3rEvk8dgLzoo124qxNddTj3gf9rO/ZViFAaoG9sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230839; c=relaxed/simple;
	bh=NvtwxH8j5mUlA0FL/Fwkw5+TsERe8CEmJhqtMXoFDmk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jcu09WwTwPnx7qUP2aiqyvsaI/IQwTY3IlkYlRc/L7N73NtR//pLDQ2801sgqTkKTNAyjt/WtEJBCC/WMGNMKUINKDcaXIdhsom0RB1w7BkqkGM71IILW6v9tyFDxG+JA/7uVy2qMlxvJU332/BoipTfO8kLZeRkdVgVsoQ2uFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTtrZ9Qs; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTtrZ9Qs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723230838; x=1754766838;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NvtwxH8j5mUlA0FL/Fwkw5+TsERe8CEmJhqtMXoFDmk=;
  b=HTtrZ9QsCioDLLPdFoKrfJNSZ6K9V4LtOr3xzliVWx1JinDhAq2qzTme
   jA4DVQMwqo/Dc/rWSPX6Dq8H44UOa6WYPsIQTmQcqio7CQIhdR4TAo1dz
   lBgL++FW5EKGlJNvCRZJDOZtxbz48EKXTKmv1FYDm3BVUGGhWUO+6nYUy
   r9JTcNEAvOmsx/952t/33itCHpyNu4+8XH29AGiqZaFNKij+TvdGLyThn
   1O8wMFXIxKLsdSCTMVWJ5e7ux00IQRQxxZ+m4wenY0GrYRQdBA/wkurER
   ZGNGWl4yZjDvZmDO0T2BWJ+SwMXwyi064vVmHgEO4oWwcBQ+j3KYDIPVZ
   w==;
X-CSE-ConnectionGUID: Lglagp8cR6a3LIeAF5fPaw==
X-CSE-MsgGUID: gRBBFOa2QMi7JxF7C8WfcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21228012"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="21228012"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 12:13:57 -0700
X-CSE-ConnectionGUID: 71RfRmqWTweqMPbq41DBwQ==
X-CSE-MsgGUID: 6j0NYDvBR5S32R/zWEJ6Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="57565100"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 12:13:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 12:13:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 12:13:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 12:13:55 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 12:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIUmvnqpL+ueH0+xi/PYpe7rErtlF2R8JmfkD+kM1Q8qKfUirJcApKHEYZs8EXUMnHKKGU9CpgMLzix7qmk0r6TFvKis/wmljRG2HDb2gB6nH0nrtZUnWmdjH7XwfYt68vx6uHwdug6heBdnyh5ooxsPzRcACYwxWV95SvnRtJlRnpHS+TvZnEbZZPjGd9R0+H9vK4WA9qwaBirOBwZHPdh0MO2Z2ZdWCeSf7VvE125ITpc0r6GdMd7jpH9SfmsWqNuLYhw9kj+7i2KY5evTcg0SHJ9qk3FKSLiJX0rmbyFkZKRLj6LGChqN4CokgE1QPwYHJn9OWGj7737LqCJZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvtwxH8j5mUlA0FL/Fwkw5+TsERe8CEmJhqtMXoFDmk=;
 b=GXHYzEPRZeRGsH2bP0xzZDGykWdjzLHYMUOmWhGttQtN2R9yYDQDu9r5fG3zPiL9P0AGGmXvKZsBOnwec7U5E47s6F5apSmA2pFTVZ14UIcVBrrFVjcH2EZRp3S35grLi7UPPp8FQLe+zsybxpTqo2XsjmHa9DKZ6TkR4cjoSaxyE7fFawhYHkAPAAr9PKZCrgnK3MfppXNX3X1kxUhbijj2AsBDVbiUK/RmLkdkdUw7TRLAphzzGgTUvNSEp+iyXm8C7WW3TfISpfwycAyO8owwh95Pn+KETMWMgJyWppzxiz5s9iuDEn2TFT5+51EoFMBMQ5Vqi0XW6cpLPF8NZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6417.namprd11.prod.outlook.com (2603:10b6:208:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Fri, 9 Aug
 2024 19:13:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 19:13:48 +0000
Date: Fri, 9 Aug 2024 12:13:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yanfei Xu <yanfei.xu@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming4.li@intel.com>, <yanfei.xu@intel.com>
Subject: Re: [v2 3/4] cxl/pci: Check Mem_info_valid bit for each applicable
 DVSEC range
Message-ID: <66b66a69ac7f9_257529416@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
 <20240809093442.646545-4-yanfei.xu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240809093442.646545-4-yanfei.xu@intel.com>
X-ClientProxiedBy: MW4PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:303:83::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e91ff5-882b-4307-f029-08dcb8a765ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kOcAcmsKOHrLlOODTfr6vg5o8AygsuL4OnK5dIMOqM0vkrgkDbuCKW9/bUdf?=
 =?us-ascii?Q?Qo6BWQorvTPIczCf1Fb+am6wlgv+tM/Ag5AHzUuXkitb8TUymPwGrpn53Or7?=
 =?us-ascii?Q?qSI7Xl3VRGh5xgLr8QXlFzPr/lZRpytJfgAIj8XLAj798Xeyi0eHSmjI5Rvt?=
 =?us-ascii?Q?IH2/qTw5dhalOegZ07T3vCMG/173mxIzKAV9nNH6tP/KvMBopnuffBGqtwoZ?=
 =?us-ascii?Q?fYMC7M5ASu2L+LqD8TWP9jf+zrD7in0d09X4qnzOTiSgPj1kcmRSPNsELXDc?=
 =?us-ascii?Q?XrT+Tw7XvXidNQWbrkJH/6DLgVyjHuju1lFxdLCpCuIANrsrvK8+q1MEaJLT?=
 =?us-ascii?Q?ZCFpwCz+OPUZkvsJ0pVOQPR6nWT/Y9D1vplkom9sdrIzxaW9qOSrzBc1HwnK?=
 =?us-ascii?Q?XUP8nNHvsKfB3V+kX+psHVYkyJmyeQBMCvXyPTY1BvC286Cr3oCQ4v4U58/e?=
 =?us-ascii?Q?Ao/sUJYCdL/+PrIGOty6bk1l9Qu5DgYgzqZaq2CmG30gToA/TUz98FMWS/vV?=
 =?us-ascii?Q?vOa3I9+op6GEdYT228uaT2AKrsKHj6rE0mxbeCB/EQqwIJ2CLb3s5D5zsmXQ?=
 =?us-ascii?Q?uFBN2rHL4AONxe8Zi9j2apVO0dih1YS0lS/BiRAn8kI7jxClS1oIJiH0OmAi?=
 =?us-ascii?Q?zdFXdkfb5g/lsJM8gy6eJAhocUpnIeSSPOhcrB8kn1ld1d4YGGAa8uA4vFiS?=
 =?us-ascii?Q?QBBpB/H9GGO5SBK04GX+gfagNEaKXkyPG1UXw46lC/swqRW4VzDM6euC56ub?=
 =?us-ascii?Q?XzRuRxZycg+xyPtY1QzW+9amZilzZrPoqhooGtkhxbA27Xappp1TV6xzJCB0?=
 =?us-ascii?Q?g5OWrHdF3OTunIEI/6b4Gyej8HYaFd6G3enFJnq7DJHo1EaC0XNQ8snDcrPu?=
 =?us-ascii?Q?t8pPXBV5qFadpEKIwSeo0l+7vwPiTUflVZDk9tVvfITLw855YaCiykQQa+G3?=
 =?us-ascii?Q?Gg28C+rNv20/yeuVlv+BRUz3ckZl0vqeucyl62zMGa1KeQYd56FuzlcKAFC8?=
 =?us-ascii?Q?4X1MBqe2sTkl+H7FT5TV9XQpb/B22SQZnAvR6mf7JPLxZB9CKiex3L9puTop?=
 =?us-ascii?Q?ZwAZ2MV7JmQbSwjOAZm4tEoVisnm7qzZJWADBg6Wj86NhbqEi2D3UXlPchNo?=
 =?us-ascii?Q?9zTxVAzjbcW2rMgK2BS9CuySQF3lYFuqBAQ58tHkq5iw6GXHSfb2KIZacKI8?=
 =?us-ascii?Q?Lkc6jW6HUEofaVAZRvUvmNTX7MtF+AgQq7SNzIEX7YHHumgGiDKBej1KDpy9?=
 =?us-ascii?Q?NqkQV9QZCgV9tmsuk49Xc2aqsE5isbba3hf/7CAz06HouKkqD22l98YY8FoN?=
 =?us-ascii?Q?nqCPzfoqMHBQW5Zp3SWuX/c+pckRutF7DgYdaaKMYnxBTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x//ZqM6nhnScjX8VDuRlO86tmNMuJAmHBueb0/mWgY7pOS3zzGmP0xcMY3kD?=
 =?us-ascii?Q?CZTrIQbD2rojKidi/86UQ3+s3yZ4FgDJUysdM0Lf/xCLikyNBUVH7Dx5ygRE?=
 =?us-ascii?Q?SDbwADa4gkEfFej6mduhUI7iXBoHBtMOFPtIjr5TPOn34rIay88pD/waPjIn?=
 =?us-ascii?Q?vk+iDAl0HraTK46oXhR2rygWaHCY7teHk5clux64FOI9dQaIwjbK/dSJv7Wh?=
 =?us-ascii?Q?EnBZ3Tq5opZU0Qf0pPOeB69kUllhuC7krb5Kal0tInMYD3KkhE85OWkQoU6r?=
 =?us-ascii?Q?Ef3Qt7fwttxR4Y62rsnGjT2Qgpx+ykSyI2W/Ixldpl5N+CwaVWz5va4XOM7q?=
 =?us-ascii?Q?Cmf9qsiqRp3D37kjQpQd08jmbp3jIc+J48I+b8OANA0vXsMnUi4Yrs52uY/1?=
 =?us-ascii?Q?XdMMUWRH71yjFTC4QUPn4OmrBL9Ckmvmmi6OCQpIUvfU9AH5OPjiXQUWA2Cq?=
 =?us-ascii?Q?tnCAmOkLBRXVurqaQ6bvIISKdDB4IaeGgPH9JUDmFPuRqZc0ei4buIR7faGg?=
 =?us-ascii?Q?7J1N3SxDWscxhwNMjteEhJefDf9DMvAmMh4B/00zWZ0rdMZ6mNX6Ews1b1w9?=
 =?us-ascii?Q?TS3vglEgyXBAGpa4TskkVj18/s7h1c7dGmLDxUUWZCE0W7W5QJKQt7yyrF35?=
 =?us-ascii?Q?oIzCJkstkV6AM+gab6s5rUyWPB4w+cxpnklJ0wx1jhglW+bXeB8p8rgx5PJC?=
 =?us-ascii?Q?DfR2cPTOPmmBX8MRmYbGnacNYCjdzRZVe2qRt6wVTyC8aYVIn+dshBYOjint?=
 =?us-ascii?Q?xFcGfjIzf/FMIZsRt4MHmtrkoCaa8JrucFhhOz3rYNyh44AuxeNxAg0WPvQ9?=
 =?us-ascii?Q?XaNGVaF7qp44B8aj+p1/Cqm68S/3df5Be7DFYqOIzoWce6QEju6BkiMtfrdI?=
 =?us-ascii?Q?Gga/DTLV7ddyiNNPe2b8i4n6cfauyUnzSO5YVJmePVdjEkC9nn5iIBJpGTu9?=
 =?us-ascii?Q?7yQnZs4T679hXYwkjYdLNe2+zf1hUfRWhnAPd85z8ZLXM7yv8YEXui7K2VDC?=
 =?us-ascii?Q?8S7O3aLXZsYJuTMCbM9DOsHo4sjn5SyAa/91/IGzgWFZ0wODSiMN17EyTWRO?=
 =?us-ascii?Q?FDgNMm7zzqAQ+A5CGc3nu1f44VLNbTWDyTS2DTS/uV+SLebhQi6v6bn7ZxUC?=
 =?us-ascii?Q?jXzojMjp44fYgg9MkRa8UFY36kBj2qL3x4ZeBtW0clGjej3JPUWKl+1LrOhB?=
 =?us-ascii?Q?sGSYwlWnWc60KnY7gkn7SbcRGoS8s3bg5Nqlyc9Ius6b6OxSSZoBvXc1kw22?=
 =?us-ascii?Q?bYugjkX/VZn4GxKIHt3wHn0dK8XbZenF8U5rTxauUDwmx3HOMlujVht7Ff7B?=
 =?us-ascii?Q?n2N772ky10P2tzknlqD9jceSSpM3V9X7yzJ71c3TM+ZTbsIHBdboWlT0qpKu?=
 =?us-ascii?Q?SRtBEvZfEUw3ieKDPXHDQ9QLzzjRBxF4YvsK8OzpmgCW4JpDpnNW2b9YwlE2?=
 =?us-ascii?Q?v0qn9uGI5OwhPmI2rkhU5Phv/Ur7NTC4W3Wuxg7DXLPQAuus/TUmGVJko297?=
 =?us-ascii?Q?1pmI9XwHe/d6wA4kXK89TxWIhn55R3x995Jo8Mtz2TykNRO9VY1sTFT4OMdO?=
 =?us-ascii?Q?Fw9lOnmw0+euvcPlTPebbuoIUE63XVktZ3XIcHdD1tReOOk5c3DlJWC2bzvN?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e91ff5-882b-4307-f029-08dcb8a765ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 19:13:48.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khPYprHYwUljIIOGCZUb4PEkjmw14IafSvlE0JHK7+MkB+KA3Osh/wpJaCpjxrTVFT8lmoi8VG9k87LEthlDWdun6Mtg5iwO+3LCD0KG2iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6417
X-OriginatorOrg: intel.com

Yanfei Xu wrote:
> The right way is to checking Mem_info_valid bit for each applicable
> DVSEC range against HDM_COUNT, not only for the DVSEC range 1. Also
> the functions to check the Mem_info_valid bit are repeatedly
> implemented, drop the rough one.

Again, not a fix, as there is no evidence of a device in the wild that
initializes memory_info_valid of range1 on a different timescale than
range2.

A better description of this patch is something like:

"commit ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory
related info") added another implementation of waiting for
memory_info_valid without realizing it duplicated wait_for_valid()"

...I would also *only* do that cleanup and save changing the logic about
when it is called to a separate patch. Neither of those would be marked
as a fix because it depends on odd device behavior for it to be a
problem in practice.
