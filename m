Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515D1494A9
	for <linux-cxl@vger.kernel.org>; Tue, 17 Dec 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454943; cv=fail; b=Nqmm9VkE2l1P9ixBGE//vrjScTd4Dd1PFL3gFDcEtoJ01rhJxPtiSIeHAhpRpQ78YS/XKteiWbWY3sad16iZmiMDLKaGOWJh4yMIcuy8xvcoTg4hGERPA/hwkGaB97E1XV004mfScyjEmRukKqwI9rC4v0HjFfhkYRcuCjwjpOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454943; c=relaxed/simple;
	bh=qsPx+NTFfkNwuD9jEyrXe4V/25/EeUeYocT3T6m2/ag=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUT/A+OQtpsh7u+AKkGz/HpVEUU10Kz+36gorFEHspd096vq64OUIjb0UXsjpdpmAZxM6xDF9x+9tMYR8qw1cRmr7sKCBVV1OxNVvMYBwTYFW9LYlocufvC0OgS/LoBAdfuEAxL6crwGZ49aXYzBCTR2W1L9rLn4SJIue4mw/vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYMYTxNf; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYMYTxNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734454942; x=1765990942;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qsPx+NTFfkNwuD9jEyrXe4V/25/EeUeYocT3T6m2/ag=;
  b=FYMYTxNfQRrnXqWvdBYhwALApRquAhU3Rpji1krOmDRHvjOAb8Bg6tRG
   G+r9LnBImeR9tnpZUvHil4SzI+G//jILA+JMQ82Ukx1A2jzz+EKJKMsOe
   Krtv3NDKlIz8XKugnShTP/4bm/LOwXSTD8z+80x7lg5dwNTnWvBkL5BlQ
   pj62GuDKTDhuW5CqZ4d6KRYHHtottxHzuA7S2PfNCjFJeaLEHe+fFGDh5
   ykizbEfUHE2dD7oDrFjPFLzYBllkTCicI1phb1BfcLFIqNYeG/iymEa5u
   ZFlqf5qdMC7zQraklENdKBTBVrG5CJJGsr709XfCwWitA79Iae1bxa/uv
   A==;
X-CSE-ConnectionGUID: JflKZu8aQjKDAtNK+hgETg==
X-CSE-MsgGUID: xY1KEZWwQFu7lwO8/Qd64Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34770911"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34770911"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 09:02:20 -0800
X-CSE-ConnectionGUID: yx0kX939RT6TbVs66wGtEw==
X-CSE-MsgGUID: pqxLmAX7Qke8y3eZUcNTYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98032884"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 09:02:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 09:02:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 09:02:19 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 09:02:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obUu3OU+YpwEEAdqPfuipHLndS6YBMhkZtWO/Tx8FOY+LdLUaRDeUx5e5i8ckmG8KrTHSATkNxGGxpMjtSTC+ddydeeXSXlCPg5L7eSl7F/b056XIV++DZPjW3UznHLYWDqGrg2c6mmXkDmxOvaw4qoWKxxFmd9qUkyxw+wBvaZtEedxoi3f8hNi+7lGQ5Jx8Kql9JJKPF1xkZ6aABZBLrZ09jtBAQQCpgoX6EcUQh4MGsepAWRt+8S7rZtqg2PHYWuAAlJYS/jN2N2GS02Ym9FKYpnoUGIQcksfQyP8pUSR0vFxgxeqHsOSD7EDuHhcQXD39212LwVVoWQucVANlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfGarDt9zG8LmtJg5Xm2uYoHTHDncHB96/9hYyKhaRc=;
 b=vauB/v8Sq+Vb6p06T6DKeToSW8k+eUj+Wex4FkDe5oSH+kKNE9qgonR1RrkujDpx0zXQo8RrN2lEPLKwBE3qLm8S5N0dN3Qkzo2Iwx5bswe6xkyhRlFhRB5XlBw9k/wXQMFOs9FWFpEquXw5az4dND83ERulIxjLt2RWECot5QeTls8bVgfX4TLxXvAEGzcP2lMra+oTaoJbXEI8g/oH2kRmzgaQ3EdxuaCPYXFQFUlgjXFvtiXI0DOjA6umANVi5ehHDV6q8U0xmKm31ez3HAcOSYELSxIIx4V+R6Q7W6QyxP0xd/Jm4Hi9J6zCz+j+dVHdoe+3V7HC0IGkFCGOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6739.namprd11.prod.outlook.com (2603:10b6:303:20b::19)
 by DS7PR11MB6224.namprd11.prod.outlook.com (2603:10b6:8:97::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.12; Tue, 17 Dec 2024 17:02:15 +0000
Received: from MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24]) by MW4PR11MB6739.namprd11.prod.outlook.com
 ([fe80::a7ad:a6e8:fced:3f24%7]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 17:02:13 +0000
Date: Tue, 17 Dec 2024 11:02:10 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>, <linux-cxl@vger.kernel.org>
CC: <vaslot@nvidia.com>, Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [RFC PATCH v1] cxl: add support for cxl reset
Message-ID: <6761ae926757a_2a169f2940@iweiny-mobl.notmuch>
References: <20241213074143.374-1-smadhavan@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241213074143.374-1-smadhavan@nvidia.com>
X-ClientProxiedBy: MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::23) To MW4PR11MB6739.namprd11.prod.outlook.com
 (2603:10b6:303:20b::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6739:EE_|DS7PR11MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: df25cc3f-d6d9-4212-b209-08dd1ebc8d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EhcLxKA22EnDEMJ6NTMCHLybM4kuT/EJeP6e5hif0/VhCEBNI2mmptj052s8?=
 =?us-ascii?Q?9GMYa7ZVoPVLHvoGvk75/mwQjdKIXkIID1iv2vR9QO0C6Psp0IFwKg3GrR/2?=
 =?us-ascii?Q?WUzZukHuNWa554/3TB43OrtfMiSaETexpRjOF5MXpsGIYGS4r651ZqQmVgr/?=
 =?us-ascii?Q?oOClebWv2u9WgzsKa1yjJTCV8NZFLX5guH91YJ/Mzv8fFM8AinhxkkRzykYc?=
 =?us-ascii?Q?PW9avp5KAvQdooWbxhly5rvVLIKkQZ61ouU17eP33wlANJiW8dtnu3cmbL6d?=
 =?us-ascii?Q?RRoO7IDRH5P/StYiivgejIQN+GsuY6p7UmFzZ1sEUayNrSL8CQQU6Q5xVBGX?=
 =?us-ascii?Q?Zuz71LrizcNB93/6Y04ctvzbjW/O60YFaEjspDV7sOP9UZ3Y1zx3hrNjUHiU?=
 =?us-ascii?Q?a50ex3Er9j4bCrYgGeELppgX37q/ErpWNHEfDlWBLvof3zqfeBtXNbLotfjY?=
 =?us-ascii?Q?GiXwc66laHeGYbuKc3ZZ+sn+lwTnvEZOUG95vW2HsZcHZ3Wqaqe3xPZXwxxp?=
 =?us-ascii?Q?c+G7l+IKbVvMq+eRlYbSzlJQZ7fGFRuyVExgvy64NZJ/0OdO7eZugn+pIivf?=
 =?us-ascii?Q?diXSCjEC6pXSDMMsruA4ACXrJgjOM/0GRm9sTpCzYgcj8fEOk15aVd3sVx+3?=
 =?us-ascii?Q?xdRTy9i5yPgnMUYGWcOB5nwgMFk+i3lGyyAMjNsI+CLeCrskhR8e7ePS0kYh?=
 =?us-ascii?Q?6TFKX1vedq9j9T/Gw/hvVwGTLnXJ55ncefPYTuCwYGE8hRnz0TnDaCmHHZIL?=
 =?us-ascii?Q?IXUUT4qsSSJxa4tjSdfv5KSERFqtrVIxL8WCkxF0T71dSxz+aZLPBeWWYbuB?=
 =?us-ascii?Q?x5aEg3uXvqLkT/GSXt+uWEyuySKKUXWa1g+w9SOJqNnyfL5fxX9vz1PYW8tb?=
 =?us-ascii?Q?QrdZxmemWufTxChVvpvDa5It6LmyJU2MjtwRnDJYzVnqYih9m/6CpZGDTEeN?=
 =?us-ascii?Q?NeVMN5GR3yt3654GMclNGKdddZD5gn1GLUVPX253lklsbHp619B0DTrIapvQ?=
 =?us-ascii?Q?bM2i2XqihKLpgXg13QFESwglI2nhkDZdaIoZVQdkqOouCHRAIQ2VY8Xz7j6V?=
 =?us-ascii?Q?L3C8bc0NoAjkJqYzTItrEV9qchvICsMW2GP0UesgR4wZbZ8LgIJnySiXU8yM?=
 =?us-ascii?Q?ulnFYyCI3o57Jwyp15gHorXYUiJO5fNl7mJwTOteXzPj0jDBhPIuxAxoV3xR?=
 =?us-ascii?Q?waO+9l4PiUQEOkrcgVjNdu/mDt1f4PJmJsSyvzEw9DMFHWx/Fs8Gqx2dIBqc?=
 =?us-ascii?Q?OrNKux462q9g2/PL1vPq1teXH/zc7Buz0SGpfZSTSqfdqVOqHoE2Nc6PhI6B?=
 =?us-ascii?Q?VSGTIezJhdY1maNfB+xgpGpIVrGsZETNntWjZqqPL4FaBxbE3lb/LrLi0WAW?=
 =?us-ascii?Q?nbAadue2JQOi2ekPqQm7JnhpuZbL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?asPUzxv5KBjz5PyNojuPDEc4o0fpUGBj7nsqsEBQcyFRInxQmxLQdOodvKVK?=
 =?us-ascii?Q?t8dQQ9s3JSq3N4oxZ40HtZxxsVHiGvtDKD/T6MMS0ri6u4DKpm798Xuo015K?=
 =?us-ascii?Q?ZzuaZmdjrB1xp95iKJpVj+ImGYkOW66BG9UC7VxW7fEEbX+kONAZpBdQ+HBd?=
 =?us-ascii?Q?3c28S7vULZ/wFMlD6ooPDxCf5k0pR2Q7b0X2TWZsem51E7To430ldIAQKY3M?=
 =?us-ascii?Q?5h8XJKN6SvxsEET0/yLMKIGS4HT0rRBz63Mz+H8iA3gb5a/6NYltgqk0XtSd?=
 =?us-ascii?Q?/RPGfN3e4SgC72fpaSv8SdkKxMQwgFNfOIcmMPZewzxs3lSBWoH1SsR+oYtd?=
 =?us-ascii?Q?Iecu1xoT5i1CQsQ1mvx+xCAjSrHtEtqY9kxV7iUEpS1IYDWJ9OZJhHGUdL1H?=
 =?us-ascii?Q?snxO5KdCel7IX3kbNE5xOX2IEAJB6Z8LpUcABOYj8oYmi07w+bzEnhBVxx+b?=
 =?us-ascii?Q?GJWtPOTCWfJy65F183iZDPjHIPGlibSZ0vU0fRoO1Tt96RkkRPVI/BFP8+86?=
 =?us-ascii?Q?gWOBFed/9vn3V34d1r7cIlj0RVrv3bX4u4X+uUGg/K4O2HXbegWldbeNXur3?=
 =?us-ascii?Q?oopp3AB4kCsQSyHYbbNk0r9EJgY2l8TjfTwnfsDo8wqYHBO3wTCnhakQKkkM?=
 =?us-ascii?Q?P4igDZXBHxDl8tkgIVIs0rXlCJho4PTr8KxBlMSwxrh5D1r2l4J1uxDw5wzD?=
 =?us-ascii?Q?DP3sGxSvvJK3Sdu8UkWu+cM3hnkQkgM+Cs50uWSsIsM8EscFuClNoBs2K3ex?=
 =?us-ascii?Q?hk9f6/5Z4mo2BHH/CzqXMxEmAaU5tZWpMgI33Q/ROQuV06NhdlUsZkqXk6/Z?=
 =?us-ascii?Q?fbwAIR+e0bYhmrdbNQDyF7/p2+cI9UwthNTFAPxLJxCUNMv82+guT74Js+7R?=
 =?us-ascii?Q?VH8SMiPhR6pcwG88jR+lLmMlRWPLrTB5LmkddYK0Nq8huI5cNBGAxkA8zMqX?=
 =?us-ascii?Q?S/7xTdd1AEpXt9VsHaHyS+9vt5yKhkN+eJ9F44elB4whso9rXsK/vKhoyTya?=
 =?us-ascii?Q?pB8f9kE5Ce+ydrO+HReLVE7w5QsHFiJUUIbiYgIa2Ow7XgjyhU7KAJCdc/vy?=
 =?us-ascii?Q?vExyVnXD1NE7eEIbeZBVecQD24YFKj/xkVPIg/THKZ/bzbXW0Q31NFCP8HD9?=
 =?us-ascii?Q?SFexZp3+4nOtM9C24ffM7+0UMIyVHk8tsmQF1YZryqbyxH31y5+HKtsubRap?=
 =?us-ascii?Q?SOkrUVD/IyKO2NGgUvXwnAjcz3JwChRC5xo3EvTQ60IynNkhLdnLG5D49aPr?=
 =?us-ascii?Q?KJBL5QVg78FIN3xy1UbOgrn4NuES+t5GaI9F5PslnDatZ+MXZXWJAl7N9rRh?=
 =?us-ascii?Q?m05DobSoCenDZHBK80vXmatniJcls4NW7f3J/YEexHBdoQv7yYtlJVZZwqtg?=
 =?us-ascii?Q?6+1rgAu74AMpWM1EScbdyv/kjr5h907VBQ5+5oWF/qvX/nyAD9OzyairFlW1?=
 =?us-ascii?Q?bXoEwLu08Ay8+N01qALA+Qp8Q3BXnB9l1MZgPUP2NxfdKgAmELlcu3GOnqed?=
 =?us-ascii?Q?6uuhazFtaZeZHw+wW+PZOZZ5tQsMfSpvCYvkCEfWKPNVjQ7jpGZ20HoXGlFC?=
 =?us-ascii?Q?F6ctXXkrEO9ZZhtL36BwrWNfyhRiDqFHlwXxRreX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df25cc3f-d6d9-4212-b209-08dd1ebc8d4f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 17:02:13.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQLIuMmU5VkrFwKwUqn9fo41Iyua5v4qJU29Eh3AOV0WLqnfotglf91VQTiHxlQHTApynNRtv3fmj/uieAyEfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6224
X-OriginatorOrg: intel.com

Srirangan Madhavan wrote:
> Currently, there is a lack of support for the CXL Reset method for cxl
> devices. This change adds the support and implements the common reset
> steps as laid out by the CXL Spec v3.1 Sections 9.6 & 9.7.

I'm not sure what the use case for this support is.  Do you have a use
case in mind?

What happens if there are current cxl regions mapped to the device being
reset?  I don't think it is enough to flush the caches.  Section 9.7
talks about system software requirements for the HDMs.  How are those
requirements met with this patch?

I think some more detail on the use case and how this functionality is to
be used will clear up some of these questions.

Ira

> 
> For devices that support CXL Reset, cache lines are disabled and WB+I
> is asserted. After waiting for cache invalid status, mem clr bit is
> asserted and finally reset is initiated. After the recommended timeout
> period, the reset status is checked and returned.
> 
> The patch has not been tested completely as the infrastructure is not
> yet in place. As this is my first kernel patch, I am looking to get the
> community feedback through the RFC ahead of time.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/pci/pci.c             | 184 ++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |   2 +-
>  include/uapi/linux/pci_regs.h |  25 +++++
>  3 files changed, 210 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 0b29ec6e8e5e..cf4fc027565e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5034,6 +5034,12 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>  }
>  
> +static u16 cxl_device_dvsec(struct pci_dev *dev)
> +{
> +	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					 PCI_DVSEC_CXL_DEV);
> +}
> +
>  static u16 cxl_port_dvsec(struct pci_dev *dev)
>  {
>  	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> @@ -5124,6 +5130,183 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return rc;
>  }
>  
> +static int cxl_reset_prepare(struct pci_dev *dev, u16 dvsec)
> +{
> +	u16 reg, val, cap;
> +	int rc;
> +	u32 timeout_us = 100, timeout_tot_us = 10000;
> +
> +	/*
> +	 * Wait for any pending transactions.
> +	 * Assuming this does cxl.io stuff.
> +	 */
> +	if (!pci_wait_for_pending_transaction(dev))
> +		pci_err(dev, "timed out waiting for pending transaction; performing cxl reset anyway\n");
> +
> +	/*
> +	 * Disable caching and then write back and invalidate lines.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE))
> +		return 0;
> +
> +	/*
> +	 * Disable cache.
> +	 * WB and invalidate cahce if capability is advertised.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	val = reg | PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING;
> +
> +	if (cap & PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE)
> +		val = reg | PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE;
> +	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +			      val);
> +
> +	/*
> +	 * From Section 9.6: "Software may leverage the cache size reported in
> +	 * the DVSEC CXL Capability2 register to compute a suitable timeout
> +	 * value".
> +	 * Given there is no conversion factor for cache size -> timeout,
> +	 * setting timer for default 10ms.
> +	 */
> +	do {
> +		if (timeout_tot_us < 0)
> +			return -ETIMEDOUT;
> +		usleep_range(timeout_us, timeout_us+1);
> +		timeout_tot_us -= timeout_us;
> +		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +					  &reg);
> +		if (rc)
> +			return rc;
> +	} while (!(reg & PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID));
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset_init - initiate a cxl reset
> + * @dev: device to reset
> + *
> + * Initiate a cxl reset.
> + */
> +static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
> +{
> +	u16 reg, val;
> +	u32 timeout_ms;
> +	int rc;
> +	u32 reset_timeouts_ms[] = {10, 100, 1000, 10000, 100000};
> +
> +	/*
> +	 * Check if CXL Reset MEM CLR is supported.
> +	 * TODO: Add check to do MEM CLR only if requested.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +
> +	if (reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR) {
> +		rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +					  &reg);
> +		if (rc)
> +			return rc;
> +
> +		val = reg | PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE;
> +		pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				      val);
> +	}
> +
> +	/*
> +	 * Read timeout value
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	timeout_ms = reset_timeouts_ms[FIELD_GET(PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK, reg)];
> +
> +	/*
> +	 * Write reset config
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +
> +	val = reg | PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST;
> +	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +			      val);
> +
> +	/*
> +	 *  Wait till timeout and then check reset status is complete.
> +	 */
> +	msleep(timeout_ms);
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVSTATUS2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	if (reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR ||
> +	    ~reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE)
> +		return -ETIMEDOUT;
> +
> +	/*
> +	 * Revert cashing disable.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +				  &reg);
> +	if (rc)
> +		return rc;
> +	val = (reg & (~PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING));
> +	pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,
> +			      val);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset - initiate a cxl reset
> + * @dev: device to reset
> + * @probe: if true, return 0 if device can be reset this way
> + *
> + * Initiate a cxl reset on @dev.
> + */
> +static int cxl_reset(struct pci_dev *dev, bool probe)
> +{
> +	u16 dvsec, reg;
> +	int rc;
> +
> +	dvsec = cxl_device_dvsec(dev);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	/*
> +	 * Check if CXL Reset is supported.
> +	 */
> +	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,
> +				  &reg);
> +	if (rc)
> +		return -ENOTTY;
> +
> +	if (~(reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	rc = cxl_reset_prepare(dev, dvsec);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_reset_init(dev, dvsec);
> +}
> +
>  void pci_dev_lock(struct pci_dev *dev)
>  {
>  	/* block PM suspend, driver probe, etc. */
> @@ -5210,6 +5393,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
>  	{ pci_dev_acpi_reset, .name = "acpi" },
>  	{ pcie_reset_flr, .name = "flr" },
>  	{ pci_af_flr, .name = "af_flr" },
> +	{ cxl_reset, .name = "cxl_reset" },
>  	{ pci_pm_reset, .name = "pm" },
>  	{ pci_reset_bus_function, .name = "bus" },
>  	{ cxl_reset_bus_function, .name = "cxl_bus" },
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index db9b47ce3eef..60bacca8e379 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,7 +51,7 @@
>  			       PCI_STATUS_PARITY)
>  
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
>  
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1601c7ed5fab..ec5b408a0789 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1209,6 +1209,31 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>  
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +#define PCI_DVSEC_CXL_DEV				0
> +#define PCI_DVSEC_CXL_DEVCAP				0x0a
> +#define PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE		0x00000001
> +#define PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE	0x00000040
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST			0x00000080
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_IND	0x8
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_TIMEOUT_MASK	0x00000700
> +#define PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR		0x00000800
> +#define PCI_DVSEC_CXL_DEVCTL				0x0c
> +#define PCI_DVSEC_CXL_DEVCTL2				0x10
> +#define PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING		0x1
> +#define PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDATE	0x2
> +#define PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST		0x4
> +#define PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE	0x8
> +#define PCI_DVSEC_CXL_DEVSTATUS2			0x12
> +#define PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID		0x1
> +#define PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE		0x2
> +#define PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR		0x4
> +#define PCI_DVSEC_CXL_DEVCAP2				0x16
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT		0x0000000F
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_0		0x0
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_1		0x40
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE_UNIT_2		0x400
> +#define PCI_DVSEC_CXL_DEVCAP2_CACHE_SIZE(x)		(((x) & 0x0000FF00) >> 8)
> +
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> -- 
> 2.25.1
> 
> 


