Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74041C60
	for <linux-cxl@vger.kernel.org>; Sat, 21 Sep 2024 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726914439; cv=fail; b=fLWMLqT0jw2+WgkHyfqaWyxsxoQeYgeTYGTuIMJKnm+ohkW34g1b/DI5+pMMZ4cfkkTz2QSN+d85wnYVRi4RtGZrt+m0ZXLxkA31rqG9pv57C2bfHwVfHump/ELBDXXqv6QtsgSRYtH+u+4xt76tRpZRlZccF817fokpiQ780/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726914439; c=relaxed/simple;
	bh=R67qq2sFgyPKQDXjZtANYqPectQGu6qVtExdZzTZ0lI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CzGqwZMUjiFkW1x5pcCayG/X1QdvH3yE+cDTdCMNrg/LmAIN7GB2Rd3AY2ollGtLG5dwvdur4tw7LXdQdLm+YeKj9Qch3F90Hui66hEj6VHspFXzlFuCo74oNGC4zV7Cg+KRkuoq7+EWkeOKuG0yJDAFlYWa3Sd76p8ocNwXud8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8f8Dw73; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8f8Dw73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726914438; x=1758450438;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R67qq2sFgyPKQDXjZtANYqPectQGu6qVtExdZzTZ0lI=;
  b=D8f8Dw73mVuqo8eLpbL5t0HMSLs6zh38UF2AfBizJw5bY9XcHEiXB4bG
   cP24x8zWwoUIF0lMnYATUJr1jiySQDK5/jTZZRbXdORuS9Apz7R2Hecnm
   BbAck1LQMcdnIYE9la8cCMMhFXjNMBTQQU0FjAwzgnyuIyubndzwS3Pvq
   +pcNIcaBF8ElJcF2+WOGOnVUL2Nkfxls+LBg9O4dIcj4xyeTHcAePydOp
   SE15DSzHJc5CR8xT37QNssXrwsfCAr2d6D0yRPFAxohj9pBvdPlTwnzod
   ltTPiWyYIq1wSK/TTlXmFbjQK7KdsDl9xwEh+5zwkv00HoVojuRAPQcAU
   A==;
X-CSE-ConnectionGUID: KII/qGJ0QnaK+CuPPDHFyA==
X-CSE-MsgGUID: O1R+9KogQTOGizQNJODN2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="29815074"
X-IronPort-AV: E=Sophos;i="6.10,246,1719903600"; 
   d="scan'208";a="29815074"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 03:27:15 -0700
X-CSE-ConnectionGUID: FvvbF+R2QGaW1AqPaxiNUQ==
X-CSE-MsgGUID: hhAnu0GWR4qPBMY43z1g+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,246,1719903600"; 
   d="scan'208";a="74958278"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2024 03:27:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 03:27:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 21 Sep 2024 03:27:14 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 21 Sep 2024 03:27:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 21 Sep 2024 03:27:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgN1cltx5mU+cHYiWSUwCQwANyGZEoWmOqrxTe7M4S8d43Z1OnB0GMfq3i7Fbyclu3F5tT0aWnkYyoXJTi0sgYOi5vhejoPnQt9vq7meqeN9hDD2RzdAl7RLxKTJM0aih5DpPQbwf4lUyIwDkk4mtl8F+So2etSgtlQb1Jxe8VRHl9nlnqul2rkXKxaQvL+T8wZVUR/w8pJLPXio2KJE9E1dOL+z6O2Zfj4MQi4P5nofbEfu1Z8pdvf2LoLg2CbQ+4YBjYzo63/IknOTmxMhsd07dD15RQ/Qc6Jpyk4en/sOZt3KQvE76X98y3ajGbx+Vl3pOzSrqsjK9CGLheRaMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHOL2328HuTlWoO56rtZ1hGJbZwj7Q/T11HvfFbSef4=;
 b=GvhcGeAQJitJVkuxFECidczkvIpJq3INFxqNRI4qFORBFs1MOHBxB9Wy/dn9d0hO5b+lQyYkc3wVr01C5Y5nhBtME28ri6P8fhOAYSwlzfzlbTgB7/jabn9KG6T+lTXzv/GdO0Hf7c3jgfWyoxhcEPyOi25uV17TkxtewYriBYDiAIfh1WrCVznOjsBj6RVzX4fw27VFHs01IoFtGraXuoo3U0dt9M6T9wD6kH86wPJZ8vKko6cM3A9vWEbXFfwlkvru16GctLdlF/3sYjsKkJFITKP3FfS/4j9qwrsIHA9+V9k1t3JQvf1RGgBYe0UulZWRCr1N+6MQ9FvivJxczg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Sat, 21 Sep
 2024 10:27:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%7]) with mapi id 15.20.7962.027; Sat, 21 Sep 2024
 10:27:06 +0000
Date: Sat, 21 Sep 2024 12:26:59 +0200
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v8 0/3] cxl: Region bandwidth calculation for targets
 with shared upstream link
Message-ID: <66ee9f72e5529_edc0294e6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240904001316.1688225-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240904001316.1688225-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:303:16d::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ad132c-943d-47a2-c5ad-08dcda27f128
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iEpnHQbJbuCxqznuG9WT9Jal/GjEHzIdYA3rZd1tfFD08oyv3zeXBYJJK5mk?=
 =?us-ascii?Q?1d+FxA6rUsP3JLnKeVshAdS8TefNFTEZYxo6sj7qJRu2HFA3PQUSt0FrH4sM?=
 =?us-ascii?Q?nI9Z7lryDC1qA5xFViG/JsGbtmOov23rCHbizuluoF8D3RYFGSXHPHOs6Bzo?=
 =?us-ascii?Q?I1Wj5C3vTuYBOUaDWEG9QVaGR0+GDYAbpt493hMyCXAdAi5wbGXW3ZBKFIOn?=
 =?us-ascii?Q?SL489iex8aFey56yzldRetFsLA+ziYlUiqnG6SWaFKvaJOEJVVWjmXsqoJDb?=
 =?us-ascii?Q?a5jMf0cZi+5W+qdG3mEYWwvbpEo9N/QBciIEglnTQAog3sPPDmK7Y8laJ4l3?=
 =?us-ascii?Q?ItoULFtoIn26ljN7kVD1fkynAzKvCIHieJILSdf/ux2riQaS6iw4OGub47QL?=
 =?us-ascii?Q?4E32KQqLP9jMca01E6mZL+lIsIiYnokBYlieOXBv7nN4IEZuUKHyErhpMmFf?=
 =?us-ascii?Q?0Yg5r+3rPj2DBDpXJ3h0q9/iwPu7tVLCRzAbK1l/QT5MDIEoS6/8EpypM2m1?=
 =?us-ascii?Q?K860cSWyAYtbo/+z80ik7yO7byvxn/RqWv340ifB4T/Z7sYlQ3sJ2YLRneHO?=
 =?us-ascii?Q?Lr1r/ZhMAce/6+UoAAJ77CoD6bDV+ysgqU875x+j8ZilByAR3z/fXMJlYr1h?=
 =?us-ascii?Q?MpXXJl3MHo/oL5VRJfAznOtIlhkzrtXV5qeqZEVhRBTZidluSna6hO1UZynS?=
 =?us-ascii?Q?+3Jbz0qZ+hX/B4mrp/lMq8EfzbbcYMl7XqR0Uowt9CnkHNaEEeo20of5BWCq?=
 =?us-ascii?Q?zriM7Du5K95vywDL/Lo2ULhlepU2YgdWRTIrV5UOFLclqrqlDEPOVxvjRtLx?=
 =?us-ascii?Q?Q+vDQWkC01FDZ0+JuTnsHf1CIXZU+zed3Pb4d+EbX9Bfh2a7f/f03v1GCjVv?=
 =?us-ascii?Q?+dKx4YzpDlQmW0X0/tSh0gT5BLegt+Vg5npKzUrfA/0KJir4xjPX4wGkOw57?=
 =?us-ascii?Q?NJDR6AklGOcaB1lVnl/kzeXS9RhfVZJA0jTAbxHqrsoACnqpESch7WLhmL9P?=
 =?us-ascii?Q?6aHDbXgZrb6h31M3jLJKgHOqc0s3fUrMEqAWYG8s3T7y9YdLPc8JaU6ztX8F?=
 =?us-ascii?Q?QedtUfCfgF1kQhuzdI00UkA2c3sL39h+odc0TUhWdjtlIWsJmf9bmK/aviIu?=
 =?us-ascii?Q?2vkhAerO9GNLW4lt/KmpQyscxjGU4vKFOTNRXx5bZVsSY2zBCqCArJi4qT6d?=
 =?us-ascii?Q?d3ZbN59po8FpmH+gEzDDWPZZCwvlt3jPVs2njaxxcOj1X3FvW/p6EkwxXxYZ?=
 =?us-ascii?Q?AxUegnTnJMwAcvIzqFWfGf81IVFbXlmKt160SPUKOg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ioewjuaJdyua3b2YvZbYcovZn7fnxavP8PNyZ3lJ4nTGX6IqSjHsjM6Ekrph?=
 =?us-ascii?Q?FvPZv3i51IYD+WQr9DsAmtCv7XLuvwmBDt7Ei2icppNRG1EaNk24JFOg52vJ?=
 =?us-ascii?Q?bE59nftUM8pY7tk+K25U/9eW4G2ceodljwOpPwXlaD+bQw68zuHuNxgb65ej?=
 =?us-ascii?Q?AU1HFcgYyQkKoE4S5/bb563gR6yqN1Ab9RdBcGq6VpLK1pAcZtpIlI2HUAV7?=
 =?us-ascii?Q?V0WMswaywpgGKQvbhbo5yZBoiWgke4piSgLRDfkv1o+hFTe6aMhJcaq8f3X3?=
 =?us-ascii?Q?Q2hD4rvZe3yEO/8+srrDlijoy6dtZnW+wHP0IuIQk5ulF/NfKjPnnu1dF3T/?=
 =?us-ascii?Q?Skl++0VS1v6rZyZCidKpXaHYVU4zDo0Dd8I9gEJVNhPeQ1Mth0xzaaFwYZnS?=
 =?us-ascii?Q?27fY/I0pSncizOpjeSVNWwVmB7N4amZEj/q5YNCz2XoS8iBR4Xcv6dLgK3H+?=
 =?us-ascii?Q?ROZ+BYOGi4ezpdXBUdnMLbPuCa39RCtWFx5ZkWEcm9O7G8gaRL3luREyhbXN?=
 =?us-ascii?Q?V14/NirlmkS9FasdkubORQB1zRqOG6vHxkXXysknrj46ecO9c2NhC8sDEctI?=
 =?us-ascii?Q?IQ5ia8zwahKePI9zef21wShKtgDZy35alvxnKzP7G/Ogge80HFIWRpzFFtk3?=
 =?us-ascii?Q?1WzNRH8ghxyWCsG6+DQ5AG3CquC6Vkpg9XDZWAxT1LtBp4xWGSlVjcyqO5o9?=
 =?us-ascii?Q?CNua4oW4/5E6u5teiTdVicav8LYby0Wqje4o/SoyVDo1S/8tfO9+cs71/iFt?=
 =?us-ascii?Q?wR8Z4QIsvmwpse5tBSX/Xi3AKFsR5RTMO3UpgAekhNTsrpd2htOEGqV59eVv?=
 =?us-ascii?Q?lAgqTMXtEaily2yuPvQJAGxJKiQL6M4cGjgTDbWf2FgJwfGec1gddPRnwaDc?=
 =?us-ascii?Q?88PwEBN7qCrJTrqkREWcudKCs6G4bRTrU8j5Tjg9xdkouC1niNEelBbHGcxP?=
 =?us-ascii?Q?j0W3UUwikUay6UpSfrdj1O7Mg8u5SfZ5CUkrM3jvaoV2rBIIEBThU2/caI9b?=
 =?us-ascii?Q?gXwgxcT2NRK1Cb5iO5dVRH0U6Ie29Rth4hqq9CdLm7HiU0t3k6KsixWz/a31?=
 =?us-ascii?Q?9Df1dhIiGz3iDY55juQBn8LcZTpJqbx2tJqgoLxYtsIg/kIixAGrJvnXBoi3?=
 =?us-ascii?Q?0ZYliyEqFhEzOJPOKP2ChNXFq3IPCpx1vTWC8q0D2w3o6GFa5G6JMRZ9Wqcc?=
 =?us-ascii?Q?af3EJZuQ5ZNLx9bDsTDeIpt3AnUPKyqJi4w5iRqIUFsro921T0acRjK7BbD7?=
 =?us-ascii?Q?FToHHIJN/gpToaTw8c/tCzhLx6l00vMbaZl1xZwFrM5wD673b/4zbqvPmFJX?=
 =?us-ascii?Q?IqzANDLuCD+R1CnV5saP2wk7DEh7eEMWFFP4drox4dgeiNdsM6hn78ncWoiY?=
 =?us-ascii?Q?WDrF5bCvhf3AQc/b5uygeCrVzxx70TZem43ZTaO+huMrEE3H7x4pCOH8Qus9?=
 =?us-ascii?Q?z9bw07oElevPRM4aEll7gFUNiV7DKpxDhURaW66zNd3CpCwbvq2tWEfBoPAs?=
 =?us-ascii?Q?okT7RIPYzp3DyUxgWmJEo7JMizHbXnPLpGbU8XQNgsED1DQhHtYRtuteRrIr?=
 =?us-ascii?Q?DBQgxhuJ3g2/z4p1InrxsQydA7pQ5X7tO/UQq95wvLYCOxN4pGY9mEqjsU3O?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ad132c-943d-47a2-c5ad-08dcda27f128
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 10:27:06.8187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moeF6Gvkj5eg/ubnI1JJzJ3RLxEXM3jepbXwep1YiWnAYYhSys5XBxHtjZqmLbjrJvlfDXy6vONT2x+wyZg/b42z7fuUDOsB2pu6tgVs5Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> v8:
> - Fixed kbot warning
> - Fix checking incorrect return value (Alison)
> - Remove goto from cxl_region-shared_upstream_bandwidth_update() (Alison)
> - Add ** for kdoc comment (Alison)
> - Fixup documentation texts (Jonathan)
> - Rebase against v6.11-rc
> 
> This series provides recalculation of the CXL region bandwidth when the targets have
> shared upstream link by walking the toplogy from bottom up and clamp the bandwdith
> as the code traverses up the tree. An example topology:
> 
>  An example topology from Jonathan:
> 
>                  CFMWS 0
>                    |
>           _________|_________
>          |                   |
>      ACPI0017-0            ACPI0017-1
>    GP0/HB0/ACPI0016-0   GP1/HB1/ACPI0016-1
>      |          |        |           |
>     RP0        RP1      RP2         RP3
>      |          |        |           |
>    SW 0       SW 1     SW 2        SW 3
>    |   |      |   |    |   |       |   |
>   EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
> 
>  Computation for the example topology:
> 
>  Min (GP0 to CPU BW,
>       Min(SW 0 Upstream Link to RP0 BW,
>           Min(SW0SSLBIS for SW0DSP0 (EP0), EP0 DSLBIS, EP0 Upstream Link) +
>           Min(SW0SSLBIS for SW0DSP1 (EP1), EP1 DSLBIS, EP1 Upstream link)) +
>       Min(SW 1 Upstream Link to RP1 BW,
>           Min(SW1SSLBIS for SW1DSP0 (EP2), EP2 DSLBIS, EP2 Upstream Link) +
>           Min(SW1SSLBIS for SW1DSP1 (EP3), EP3 DSLBIS, EP3 Upstream link))) +
>  Min (GP1 to CPU BW,
>       Min(SW 2 Upstream Link to RP2 BW,
>           Min(SW2SSLBIS for SW2DSP0 (EP4), EP4 DSLBIS, EP4 Upstream Link) +
>           Min(SW2SSLBIS for SW2DSP1 (EP5), EP5 DSLBIS, EP5 Upstream link)) +
>       Min(SW 3 Upstream Link to RP3 BW,
>           Min(SW3SSLBIS for SW3DSP0 (EP6), EP6 DSLBIS, EP6 Upstream Link) +
>           Min(SW3SSLBIS for SW3DSP1 (EP7), EP7 DSLBIS, EP7 Upstream link))))
> 
> ---
> 
> Dave Jiang (3):
>       cxl: Preserve the CDAT access_coordinate for an endpoint
>       cxl: Calculate region bandwidth of targets with shared upstream link
>       cxl: Add documentation to explain the shared link bandwidth calculation

For the series:

Acked-by: Dan Williams <dan.j.williams@intel.com>

I still believe it should be possible to disperse this into port
enumeration code. On the other hand this is off on the side in cdat.c
and has no reason to wait another cycle for that feeling to be proven
out.

Forgive the delay in circling back to this.
