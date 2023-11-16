Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGBSmUHc"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B25A7
	for <linux-cxl@vger.kernel.org>; Thu, 16 Nov 2023 06:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700143733; x=1731679733;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Iao+AcClakc7jeBh2ZJTN24RjgQ9DKx24fVJHafyebo=;
  b=kGBSmUHccNgD/YPpZScF34AZ1a9gvPdbdII/6GeeLGw13NvgFR8UFYhC
   wnkioR7Iuf8alGVo282R0P+9e+htBM5MGE+xgpaGJQDgt798vZUMJDKxB
   1qlQREiWdaja6GpvJZpQjrL2xdEsXS96i4c9+Kvj3vLj1YvF0rEkTRA4o
   Tq7CAdfpEQbNfqUJm0aXQdrSIhMv4b6Lv3mV+Fj/+/rM4KxH9hL8vV7ZH
   PkQNAya3zhTMLlPkeIn3j5GnKdx4Qp6qEVJzjnoOGKn3Q1C4ipVF1HYOs
   nDISyHVoz1s2GlTjmeBvaF4FeWZPpaSj6UKYktOshE7M+rheaUV/is4ep
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="376137138"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="376137138"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 06:08:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="882759417"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="882759417"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 06:08:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 06:08:28 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 06:08:27 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 06:08:27 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 06:08:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9HQOaL7z2CUrVOhxHjL8g/7mKRkJvNhdk7uEHnoKP+q27lT8q47A9c1VHt06upjPUw8xWVBFYI4u4ePON630BnHXgtGqUcNgn7XOW9LmYCuR+06cavyVvlh5luvjOZa5FmYOlE651VsTenZEwl3Rgp5nmzeltmrfMDLKlutHxS3wNACCWFze2vG3H/TVJdC6k//dmN78YDcw1OwoJzJYpPcEnVFSluuRMx0g/2c7AfFkyMFJhKlH2BGvU28EvIyfqTWqRtGKorfc9RkhRnE9YejCQcRgi75f77wC1REYCuIs96fFROsqQji72VB0EVWyiw7kgH1IGyBRt8M0KtdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a2FNZv9w2OpoghvWMkxsKZ/ZtUcXBUJzAinaquPQfs=;
 b=UlLoBvySv/o6x7GCq6y8ZCUKVgMyme42eymEGDfxqpEeb+9Y/llq+RFPWlGw2nkMOxIQOsmHsMpVtlhscdtarf7OGRqfI8HSfQx9vJyFKhjVbemjfD2gRMa1ntnQ+lrj6W2J5bZlhYMxze7+fR44vo5s4kmH+5u+cMjq2P94EQvqxxOLqSs9V0D2fQMgm9YNRivlKF/552FVhv9jyD1WwkOeSef3j75DT/avm1Dtds02rPfJW2WhCLcc2XIc6g3dhI1bYyFmfKSTzrA3kBvQxSPeZ+DRYHOk4QZbDRhWgsqPGf2/X3duCgaDplqANj3d5+eLrEtD1uuq533sqR+U+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7037.namprd11.prod.outlook.com (2603:10b6:806:2ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Thu, 16 Nov
 2023 14:08:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce%5]) with mapi id 15.20.6977.029; Thu, 16 Nov 2023
 14:08:24 +0000
Date: Thu, 16 Nov 2023 06:08:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 4/4] cxl/pci: Add support for stand alone CXL Switch
 mailbox CCI
Message-ID: <655622531e942_46f029416@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231016125323.18318-1-Jonathan.Cameron@huawei.com>
 <20231016125323.18318-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231016125323.18318-5-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 86708371-f9ca-494f-03d5-08dbe6ad7ed4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70LEYgldvZTNC87WZ0aDp1jzPgnlHNd8JsBHK8hvMVPM+VlhTULDQUzfCfK/bZ9oLT1dsAdXZjjkSZXxoP/+9r+uF6VBo2VSyhjI4XsAskS9f/A1yLdL3eWl4QY0Pg9Q+Klfc/r2OhvsJUzngoGLhhS98tPvTywc4kyFELa7jznXvEjgGJbz903Ble4wrgs4PUy+ZkTlDpdhu8H1rgfCbyNVdo5dJlWkrSNiyB47xLey91T2dqhIhhBzPilrOzDdOYFcnIWwfc3lkKS5dxgIdzKsM1X5WKwYjXiYAROACXr6unNvmyD3wlfey9xgQiYqSAKfsThWka+rKnyadhqeOZeSmAXIC1XUqeGPvIVMN+j40YSjLKzQdN+1Gf5rAtoVSl/blT1G4YhIM2nJZFci1VU/P6g8ah5pi6fA6162K0qczw8PClwLVb2ocsLGrwIDs9R1rPJjc/zCiW1M1tIXDXo3UqLXBt+pTFicS0APWAWIq5R1PAu6wmJDzPj3rLa8aUntCuERgaOkZjc/gRyeVGeWceaFtTEmddejvjxE6u0t032eqaEhNtojhw7mPFwa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8676002)(4326008)(8936002)(6506007)(6486002)(110136005)(478600001)(86362001)(66946007)(316002)(6666004)(66556008)(66476007)(83380400001)(9686003)(6512007)(82960400001)(26005)(2906002)(30864003)(15650500001)(5660300002)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1LPLvSHCbForadSMZadi9lj4Oll6XMg3WhclT1tj0Vw9ORxEK/3ft8XjfE6J?=
 =?us-ascii?Q?MwwT1ld9sVecQX4jAZvd0/AiNODSc+bkEGlc1xHl3NzhPuLKJkVcScNdaHo5?=
 =?us-ascii?Q?1vqlBkWFjG9YQrzpVOI8btUNEdHXCiZlEVbw0AfJLukHg8yM5iTKO/S9eyXt?=
 =?us-ascii?Q?KX5SQOla5RPR7fqSVeN/L9DDgjDv4pQp9ehwY9qf6VnKMqytwqIohDCY4sOv?=
 =?us-ascii?Q?+s89scHPLJI0p2MI8MrHDSdXre519h68aDRe9+lRSaIxBnXES79+nyEHwRoF?=
 =?us-ascii?Q?WQlSvhp0+9/fIn3UJmaf3Dz/kG0SzDLtUwM0AmpYFZOXJNpvfkd+ZgfIl5Bh?=
 =?us-ascii?Q?MQjGcKk5EbSWLkvWAhqhCfx4RmN+xqFeJfGbNu0s8Qo42KWyoVb+dIPwroBy?=
 =?us-ascii?Q?xLLgb5sJjwF1+vnvBy3ss35Fk8VS3ieaGhLtFC1MAwTfgeJHtPUtXYwDmB4M?=
 =?us-ascii?Q?G6oK/XSAH9vEw79qeJZZ8Wy6VIXYUt4EmJyEDoj93bnGowOpBJfXlNM+qWYk?=
 =?us-ascii?Q?qu5GIIUMawsDR9Z0j/dmE4bSDXfvX8NgGLtCeF82jwyreHHaSiOnOjBry+H3?=
 =?us-ascii?Q?XvzZTOUQsklAecZU932ANJX+WSlsoUis8ipBRxATGTd7zgflqX4HHeoC1ZpE?=
 =?us-ascii?Q?Iea94tYTqUAYkspvHyrMzjk5nvOVNZyYzR2RhlqDyu/UlbEqcAsZCDZX1Un6?=
 =?us-ascii?Q?kR0/cY1WPRt1XoToOLvoFZBsxOpKEX+x+5zhPKwqM1P+QWvaZ2qh+VfYuOpY?=
 =?us-ascii?Q?O56mtQB5Hm0gYEbyMwBiIMBffpFQJ52TXmi+zQZPCt5J9+yLif4m2MlNJ58F?=
 =?us-ascii?Q?5PuxAYnQZg5S4UJfNth58O98NVR31+mW1v/60MG2ueWrf0qfdXAju7ZhG0ju?=
 =?us-ascii?Q?bwNNnFWHVY0VMUoPxAy7ijIdQICDZvhdbdQu+yL5EYHH3Wp8Yc3bsk4EFkvA?=
 =?us-ascii?Q?w1g7zqjgFXKUFh/Nc4W4ARa5q7J+bMMuXRoIDTu4MIIMawwhmCnOHn+G51Qx?=
 =?us-ascii?Q?tSI12nP/T2n/ElH9Evq5HxzU+U8/XruLd/fmQix3g1ZH0e2NPFrAaAEsTU16?=
 =?us-ascii?Q?b+Q3pIbNWr47Ph5CuIL5Th3VPCcBEaes2Zq/Y0IX2TjVVJ0hMCepqlFXfJys?=
 =?us-ascii?Q?Uo/6rJFnZI2AOO7vTulsRKXlPckQW0Y77GyDvmikzGPhs+w4jd2FAYHCYCN5?=
 =?us-ascii?Q?ME/85gE++qW2+1PPH1AAf6jTsJY9tOPQHNYjrQJNa94Va4sNw2Jk5Lc2mrF9?=
 =?us-ascii?Q?/gL+GnuvOC2SzfEBnGZ7PcfaJl0h0QAygACmhWDeeIlx0mUIoPBmIj8oGqXF?=
 =?us-ascii?Q?LpFRseOs2Nko0XiK+Xv24Q9A/hraP5dZEvGsHC663RZpPP3UVCAx1GOnvWF2?=
 =?us-ascii?Q?N+62N/T3b4brN/3j6k992kCpMilgQFcHCuXHVlCrdmsjgdRJp/BSdQ8UzeAH?=
 =?us-ascii?Q?sUNgLytNYvCpXfe57gRkPn51GOPFwQte9nhLSW8dV6fWcK6lp1JK9jhoj1SV?=
 =?us-ascii?Q?ocxb/Dym3yjH42JTntlbIi7GXZ2M3oV3Y9rkDEE5K1sJegNY5+BzkoVM55Ad?=
 =?us-ascii?Q?Te1jtutvlVvZekh6p2lk6Qi8z84UUetjJht1pwhYFpGxTJm4af5iUJjnr8Ki?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86708371-f9ca-494f-03d5-08dbe6ad7ed4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 14:08:23.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+WkGTCQZohhoI4r5ch0M926iBLHDjIvwBZ1xVh+X+PZJ3rzB34mUfoszLZzfcM5Jaod2JpmJFhbHGpTUhOxMi+qgmMnubfXaAudrMDB6E4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7037
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> CXL 3.0 defines a mailbox PCI function independent of any other CXL
> components. The intent is that instances of this mailbox will be found
> as additional PCI functions of upstream CXL switch ports.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Non RFC:
>  - Drop adding new commands.  For now kick the security model
>    questions into the long grass but using RAW comamnds only.
> ---
>  drivers/cxl/Kconfig          |  14 +++
>  drivers/cxl/Makefile         |   2 +
>  drivers/cxl/core/Makefile    |   1 +
>  drivers/cxl/core/core.h      |   9 ++
>  drivers/cxl/core/mbox.c      |   1 +
>  drivers/cxl/core/memdev.c    |  12 +--
>  drivers/cxl/core/regs.c      |   6 +-
>  drivers/cxl/core/switchdev.c | 129 ++++++++++++++++++++++++++
>  drivers/cxl/cxl.h            |   2 +-
>  drivers/cxl/cxlmbox.h        |   1 +
>  drivers/cxl/pci.c            |   7 +-
>  drivers/cxl/switch.h         |  19 ++++
>  drivers/cxl/switchdev.c      | 169 +++++++++++++++++++++++++++++++++++
>  13 files changed, 359 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 8ea1d340e438..2acf4073febc 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -153,5 +153,19 @@ config CXL_PMU
>  	  Say 'y/m' to enable a driver that will attach to performance
>  	  monitoring units and provide standard perf based interfaces.
>  
> +	  If unsure say 'm'.
> +
> +config CXL_SWITCH
> +	tristate "CXL switch mailbox access"
> +	help
> +	  The CXL r3.0 specification defines a "CXL switch CCI" sub-class in the
> +	  PCI "Serial" base class of devices. Device's identified by
> +	  this class code provide a mailbox interface to allow control of CXL
> +	  switch configuration over inband PCI.
> +
> +	  Say 'y/m' to enable a driver that will attach to CXL Switch CCI
> +	  devices enumerated by the CXL switch CCI class code for configuration
> +	  and management primarily via the mailbox interface.
> +

Is there anything in cxl_core.ko that the switch driver needs?

>  	  If unsure say 'm'.
>  endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index db321f48ba52..b98babe05abf 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -5,9 +5,11 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  obj-$(CONFIG_CXL_PORT) += cxl_port.o
> +obj-$(CONFIG_CXL_SWITCH) += cxl_switchdev.o
>  
>  cxl_mem-y := mem.o
>  cxl_pci-y := pci.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
>  cxl_port-y := port.o
> +cxl_switchdev-y := switchdev.o
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 1f66b5d4d935..562aa63d225f 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -13,5 +13,6 @@ cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
> +cxl_core-y += switchdev.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 5491d3a3c095..676b63193080 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -87,4 +87,13 @@ enum cxl_poison_trace_type {
>  	CXL_POISON_TRACE_CLEAR,
>  };
>  
> +/*
> + * An entire PCI topology full of devices should be enough for any
> + * config
> + */
> +#define CXL_MEM_MAX_DEVS 65536
> +
> +extern int cxl_mem_major;
> +extern struct ida cxl_memdev_ida;
> +extern struct rw_semaphore cxl_memdev_rwsem;
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index dc59c6d1f87f..9a2f38a8a45b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -9,6 +9,7 @@
>  #include <cxlmbox.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> +#include <cxlpci.h>
>  #include <cxl.h>
>  
>  #include "core.h"
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 15b540bec6fa..b233d6016c55 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -11,16 +11,10 @@
>  #include "trace.h"
>  #include "core.h"
>  
> -static DECLARE_RWSEM(cxl_memdev_rwsem);
> +DECLARE_RWSEM(cxl_memdev_rwsem);
>  
> -/*
> - * An entire PCI topology full of devices should be enough for any
> - * config
> - */
> -#define CXL_MEM_MAX_DEVS 65536
> -
> -static int cxl_mem_major;
> -static DEFINE_IDA(cxl_memdev_ida);
> +int cxl_mem_major;
> +DEFINE_IDA(cxl_memdev_ida);
>  
>  static void cxl_memdev_release(struct device *dev)
>  {
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index b783bf89d687..aeb97daaf9ee 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -268,7 +268,7 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
>  EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
>  
>  int cxl_map_mbox_regs(const struct cxl_register_map *map,
> -		      void __iomem **mbox_regs)
> +		      void __iomem **mbox_regs, void __iomem **status_regs)
>  {
>  	struct device *dev = map->dev;
>  	resource_size_t phys_addr = map->resource;
> @@ -277,10 +277,12 @@ int cxl_map_mbox_regs(const struct cxl_register_map *map,
>  		void __iomem **addr;
>  	} mapinfo[] = {
>  		{ &map->device_map.mbox, mbox_regs, },
> +		{ &map->device_map.status, status_regs, },
>  	};
> +	int limit = status_regs ? ARRAY_SIZE(mapinfo) : 1;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
> +	for (i = 0; i < limit; i++) {
>  		struct mapinfo *mi = &mapinfo[i];
>  		resource_size_t length;
>  		resource_size_t addr;
> diff --git a/drivers/cxl/core/switchdev.c b/drivers/cxl/core/switchdev.c
> new file mode 100644
> index 000000000000..72f6b81357d9
> --- /dev/null
> +++ b/drivers/cxl/core/switchdev.c

All of this core code mostly looks like something that could be replaced
by a miscdev. The medev ended up with not miscdev due to trying to
combine the lifetime of the memdev in sysfs with the chardev, but if
this is a chardev only interface then maybe it does not need to
duplicate the cxl_memdev template?

Alternatively if the operations that this is going to perform have a
formal sysfs ABI then maybe this does not need to bother with an chardev
at all.

I guess I am missing why Linux upstream wants this. It enables wider
testing, but to what end? What does the non-debug test bench version of
this driver look like?

[..]
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index dad80c5857f6..0f0d51730df8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -279,7 +279,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  int cxl_map_device_regs(const struct cxl_register_map *map,
>  			struct cxl_device_regs *regs);
>  int cxl_map_mbox_regs(const struct cxl_register_map *map,
> -		      void __iomem **mbox_reg);
> +		      void __iomem **mbox_reg, void __iomem **status_reg);
>  int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
>  		     struct cxl_register_map *map);
>  
> diff --git a/drivers/cxl/cxlmbox.h b/drivers/cxl/cxlmbox.h
> index 3861d97729e2..d444327ef78d 100644
> --- a/drivers/cxl/cxlmbox.h
> +++ b/drivers/cxl/cxlmbox.h
> @@ -155,6 +155,7 @@ static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
>  
>  enum cxl_opcode {
>  	CXL_MBOX_OP_INVALID		= 0x0000,
> +	CXL_MBOX_OP_GET_BG_CMD_STATUS	= 0x0002,
>  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>  	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>  	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 7bce4ae7cd10..da3d95a91a5e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -632,9 +632,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_map_mbox_regs(&map, &mds->mbox.mbox);
> +	/* Status register already mapped */
> +	rc = cxl_map_mbox_regs(&map, &mds->mbox.mbox, NULL);
>  	if (rc)
>  		return rc;
> +
> +	/* Connect up the status register access for the mbox */
> +	mds->mbox.status = cxlds->regs.status;
> +
>  	/*
>  	 * If the component registers can't be found, the cxl_pci driver may
>  	 * still be useful for management functions so don't return an error.
> diff --git a/drivers/cxl/switch.h b/drivers/cxl/switch.h
> new file mode 100644
> index 000000000000..14e8e1cb87e7
> --- /dev/null
> +++ b/drivers/cxl/switch.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __CXL_SWITCH_H__
> +#define __CXL_SWITCH_H__
> +
> +#include <linux/device.h>
> +#include <linux/cdev.h>
> +#include "cxlmbox.h"
> +
> +struct cxl_swdev {
> +	struct device dev;
> +	struct cdev cdev;
> +	struct cxl_mbox mbox;
> +	int id;
> +	bool dying;
> +};
> +
> +struct cxl_swdev *cxl_swdev_alloc(struct device *parent);
> +void cxl_swdev_shutdown(struct cxl_swdev *cxlswd);
> +#endif /* __CXL_SWITCH_H__ */
> diff --git a/drivers/cxl/switchdev.c b/drivers/cxl/switchdev.c
> new file mode 100644
> index 000000000000..ead003c718b8
> --- /dev/null
> +++ b/drivers/cxl/switchdev.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright(c) Huawei Technologies
> + * Based on cxl/pci.c Copyright(c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/moduleparam.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/sizes.h>
> +#include <linux/mutex.h>
> +#include <linux/list.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +#include "cxlpci.h"
> +#include "switch.h"
> +#include "cxl.h"
> +
> +static irqreturn_t cxl_swmb_mbox_irq(int irq, void *d)
> +{
> +	return cxl_mbox_irq(irq, d);
> +}
> +
> +static int cxl_swmb_setup_mailbox(struct cxl_mbox *mbox)
> +{

It feels like most of this function could be shared common setup code in
the library.

[..]
> +}
> +
> +
> +static int cxl_swmb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct cxl_register_map map;
> +	struct cxl_swdev *cxlswd;
> +	int rc;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
> +	cxlswd = cxl_swdev_alloc(&pdev->dev);
> +	if (IS_ERR(cxlswd))
> +		return PTR_ERR(cxlswd);
> +
> +	mutex_init(&cxlswd->mbox.mbox_mutex);
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	if (rc)
> +		return rc;
> +	rc = cxl_setup_regs(&map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_map_mbox_regs(&map, &cxlswd->mbox.mbox, &cxlswd->mbox.status);
> +	if (rc)
> +		return rc;
> +

I guess this points to the need to move CXL-style register enumeration
out of cxl_core.ko as well because users of the CCI-library
functionality care only about register enumeration and mailbox
operation. Then cxl_core.ko is trimmed to just medev, port, and region
concerns.

> +	cxlswd->mbox.dev = &pdev->dev;
> +
> +	rc = cxl_swmb_setup_mailbox(&cxlswd->mbox);
> +	if (rc)
> +		return rc;
> +
> +	pci_set_drvdata(pdev, cxlswd);
> +
> +	rc = cxl_enumerate_cmds(&cxlswd->mbox);
> +	if (rc)
> +		goto error_put_device;

This circles back to the concern about CCI command enumeration might
expand beyond the "CXL" usecase, so I think cci_enumerate_cmds() starts
to feel more natrual as part of this refactor.
