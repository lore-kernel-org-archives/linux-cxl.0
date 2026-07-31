Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A7143E079;
	Fri, 31 Jul 2026 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523986; cv=fail; b=BCnOgJoQt0vXyG3WAYQ2ogpthMPmC13FU/T9LDghKh+UK1ySepk3U3zb2uu/CWGo8vS5XIiJ7hO8RNOrLPAIJHqZEfXd3IM61a2eg3Dm0dyoy9DfVAC1jch5NB5VmaUzacUzCF9DB/21yQkX51inS6KJPGt8Qb+CN/CG8Q+8nVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523986; c=relaxed/simple;
	bh=N+L/hPYkxRjaNCPy8qNyb3yZd2zHjJv2BQMz4pCc1Ho=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a3YvChodg2WcmJC9IOHLy7d+aKeotbaqfiBpjmEfzpEniTdSyfQJuOd6lXZSnHzGJDY18U0CxJkEHxjj4M2w3eExrRQ4kWnKMtzK6JYfEPtHZD2Yo4tuB9PkCrQcc2tivWnsWCYLnmfp5gZ5oy54B22hGgHMkxbc7IxOonmKBE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpbC4UZI; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpbC4UZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785523982; x=1817059982;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N+L/hPYkxRjaNCPy8qNyb3yZd2zHjJv2BQMz4pCc1Ho=;
  b=dpbC4UZI1X63pyv9m0e/Q0MwDr8zYHZRpWqUZ/hqZV6BW4vArmprv0ia
   3GnuBA9x7+fA0m56l7P2J1e7t2eu3FqpUvEI3lOOENO0Ypngquy/1LLaI
   1u8/B/wKBDVBHXiq81OFgc1XhuPkf0Uau2uyACzorDtWt67l3yZ+ZyLq4
   i2QmkfUk8t5QczVsTSZW4jmD7LbwGFRiHrf/xpVLJA3QdPkdmjfCvZCQ+
   tdEMmlabiCwhBvRu6M0RiGg7fMOyGsQFPnfzkFw0eFzBaEjbEWYCjMEm/
   qKAMlaNj3VcYfeLVUxMrfgmJtF4/d7BckVI2qX+Z9zl+6o6aD+IkmP8hW
   A==;
X-CSE-ConnectionGUID: IPN6dcbbSCKg9l2nouj8lA==
X-CSE-MsgGUID: nAtGK8jESrO4V2fF5TgN1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="108951781"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="108951781"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 11:53:00 -0700
X-CSE-ConnectionGUID: 10xHqk8IRV2rjJZ1V4nO0A==
X-CSE-MsgGUID: Ofskz2OtRqq8dYiUkKUW1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="285251745"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 11:52:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 11:52:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 11:52:59 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 11:52:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVcxABBM6tZtoqcTGqc+J1I4uZC8mdufvG+CmdewS6SpRBSG923lP+So0C27fLdpuQEwnmCrk3I1kFMnTIlPyFJs8QyX2GYqulnSOOgtl1+cZIa0bcg/kLhs5x/qKPwKQ4n3Bnv4gWSEih3y5Hd0RRYxDYj4+wWrkJoY7bnev81pW9v/ILJCI8vtmqNmqqO8kegtBmG8joiEd1gvtbmPST5vHhB6GvVKqbDkrvTn4Lr+XkyAyO9uo0wpOvzq1+8toY2thyTZ+DTMensQG/Exi9/KewcdSfiWgTHsucOiT1tnokbQOchZnXrbcyMai4stAD8eUxUMddZMDQifV7nG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLf06QuP3Q8TTavs+xpmyai/EKJ1nzsk8AEifChDWCo=;
 b=bo85V45iGwy1yynQVrdB2SOPq5bboyMsLcylE1gHEMK7RTmD0oJP94tcWQnvTN8srriBl+1Ij9UNa+LAPGvvjcyuZJHQ0DHDZCRdVrg2pcmLJgf6EuAv8vUxf6jZm8tdk09ZB5B6VGAii2qGp9ZciCZCwQjxauZj8ZOyogF0m4df/6LxObfMH/LS8A3B7CoNWQj0IFdSqhfCdlZK3eiFyHPKy8IrlnKYWhvfU9AuV4FR9cKs0stkwKo2L/LjEOcmzInY/obi1VtkRNsqME7iQyUxa8a/pLe8a58E/qqfyWuxOgRjO4L6vLoasy0tpe8cdUD2GqDjdxMgak7KIH5iGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ5PPFD47FEA206.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::857) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 18:52:51 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 18:52:51 +0000
Date: Fri, 31 Jul 2026 11:52:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <jic23@kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
	<kaihengf@nvidia.com>, <kobak@nvidia.com>, <vaslot@nvidia.com>,
	<mochs@nvidia.com>
Subject: Re: [PATCH v8 0/3] Support zero-sized HDM decoders
Message-ID: <amzu-kZU36ivFhZ0@aschofie-mobl2.lan>
References: <20260731064902.34127-1-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260731064902.34127-1-icheng@nvidia.com>
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ5PPFD47FEA206:EE_
X-MS-Office365-Filtering-Correlation-Id: 261d7127-8497-4cfa-d6ea-08deef34ec05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9jMac7YV+eu5dM/Mx4jCtXf29zFk5TJmWsF37FrSrTPpeutJWUFkQAY1vCsz7U9zvziPS7+t5ZN3wHVnmSftqZhrYmmvjILRVazJJdT+RUhZ/RFCvqJEYcEr2iSaoAarF5pBXnj/+1YpVikGVZL4gGvIIAvIjpxFL+UxO9y/zutzEEpqxy7+axQgPxr+NpYWPL2tcyJ76YSp6ELA2YRqE/psPIAn2gczLuagMIR1CWixpqnbKn7WyiBFuFEUeCFwstOgwEUdzQKG4msepCqZyoeUu6XrUFPPRXHrNJCkN02RFRuI/xhQ6yeDPPQ0kqqETvmeLOEneBOUQIs8gpG5ZcMqOGAHmwUUMxnmziF7RL7mWi3qI+swtHXevnPi63d8zwSkcy2X2hH9XcFVLuKjyg7tEpqjIlnTCWFL/+HLq9q68wn3hQVEZJg6MrkJ52SFRYJ07h5CSlZ+7RCKHFe8trKa9+1Lwkqeq/TboyUFGdK4A5eVA42VHCIAnhGYS328iQ8RZjeefTjHTetzvSgMh1vtL0EhqdOe0MQjHotN5EA47xFsxG2PVJy3h54XJuTpuSJaoe5uxzwvYmNPNNNn3F+ml4bVqoxIPdnDcTAIEA30DNOFZK4gsCJ0XpPPXbaiZp4Pce61iALXcQKMJFuwqiXY3TlTfHWwokIShL1xOUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YvQYWT+xOMAXmDdyEdPZeH04/N0ehksVe4hUqJ6s/f9kX0v7vns/frs/PE0X?=
 =?us-ascii?Q?WNNF6/BRiSw1dvV7+imJiUtq53BQcvcDTfYwj/SGFiV4e+EB4S+LKIhjcOkz?=
 =?us-ascii?Q?xFHIrGFy5nlTupUlG622eDqtV8zg65inIqoM1NswQp9BBYTUpSJbwYlgT3l0?=
 =?us-ascii?Q?tqY/2da3HCUFwiB1uRnWHHgiLl3lrvua2/9JQPBKmlsqiKkLe3GmiyinHNuo?=
 =?us-ascii?Q?OZrtZ1YgBj+4ldzesKdYWIMesaZ6Hcbmugif6hsGQ6IGwK+u1Gguvmno1vzk?=
 =?us-ascii?Q?dZEAd6M9/ZPkZ/tLDANFJz21pChzMjkxsyBwO3AULvt+6+KXDXGELgTI5rsz?=
 =?us-ascii?Q?Qiu9djr88l7/z8uj01EAYNJxGfg/l7Yf6diC+FiG/698Ayi4GvDj2E3h6lbJ?=
 =?us-ascii?Q?6s1HSfHY8YmSoD0UOrsv9pP4IRqCCf2PPllwsejJM0zikv77vS0EM81aP/q8?=
 =?us-ascii?Q?eb66AmTBTt4cH4t9RRIJfuivw83aB7XA0V14PnceiFzY51uN9ZAyZhpwHiOm?=
 =?us-ascii?Q?sSqG/hQu0CnCE88YlA5xAXiqxmsYr6eQAURZtL++7CWXoMUVRAJ/BNRZzuP8?=
 =?us-ascii?Q?N43IKHSafFm7uQ0IC1wgfZhzvQam/4qNni8MMMEZ10oH0kXnlhVkZMkQQnzG?=
 =?us-ascii?Q?MwnxavOOyAQLl/JQ2BRvEoBYl6LVOFmUh6f+v8ZP+rnfNwxoRrJrTnir6I80?=
 =?us-ascii?Q?j38UcahjUf1SncscU48LrW03/VldxbQ1qeR0mh/Q5zLVmS/2P51+9UUDU9fK?=
 =?us-ascii?Q?wm5J4muacWD/sAnwacQYOUTz4T8GQklkuds/qxG04L8RJK4iOypad2BY6agc?=
 =?us-ascii?Q?NguCU/AtWXkNdU2pCh/uKpK7sg0STJMBMO3sE0ghBOaoKaAXeA07Iylnsd7A?=
 =?us-ascii?Q?6coCQZE2+OHQw7RJ/v7xcPRIpM18T4EF5NJf4HCHCbyrgQ35ILXjI6qyPFV6?=
 =?us-ascii?Q?ZyzYfneoGRRoXvCNrT+Go4hYirujSWY8ok+XBmi0l+Uk4FHuX+MpQx2p+XNw?=
 =?us-ascii?Q?jLe7T0LdyH/Bc8s1Lfca2AJTM5soD2xpT8dW8YEvW4BXwHYyKYO1QVVUoFuF?=
 =?us-ascii?Q?TS3NcrsFhM4zcKv7pxAdN6tQtVtA9Od3cVw5q0J2mC8XHTLBEEGEBkKMlnaV?=
 =?us-ascii?Q?Lgnrcc6he6WLanj0/9JTqOYjHdoMkrg/Pyt1CMug1Q5AG9ebhY/M96T17St7?=
 =?us-ascii?Q?tvqb30fq5tBwqhOJduHEERyeC6wGKvdsaUkP6DRp+5bxYdiutVtind+waiUJ?=
 =?us-ascii?Q?sfWCcLRRZOnlbwtnoiIFMCZMQ7OsytjKA0KAbTbaIoXT9nCOIQ44U8WJHJhi?=
 =?us-ascii?Q?H7xgEyHHJo1/xD/ea5ouaqYfvGFnhN3J08HYMH77OAtEdkPDehgaaQk+eEkO?=
 =?us-ascii?Q?wfPfTZJhkPW23VibCNCLdhafASxTqwjTbI3UKTBX+RkrKP9EXesFkiHsBglZ?=
 =?us-ascii?Q?Zg7S6epE0ycuxKdqPZIxErFK2igO6kFdIKhRf/PxG5ky65VyvHDGKTzTT7Gy?=
 =?us-ascii?Q?a+WNnx8zef3IhhjH3//WAc5TPV85AM2pAmvUSodIWP1WGwtmN4p4XR4nmM/A?=
 =?us-ascii?Q?0AprD1kKp1KiZs7yjFyij2nOcOmbEBdz9w7ot9JKOQPHGjYddbm4myEbibNx?=
 =?us-ascii?Q?HhYy48HJyANIPu7I5lpigjbSk2E9HOg/k4Y/i8qduFXl4O4dPPxpe5gcTuZD?=
 =?us-ascii?Q?8QD9WJjtgNlZsNqvJIds1ehO0FlACjgJ+vdBNjkD4LXb0ZyNOeCKX5xIZW2E?=
 =?us-ascii?Q?8rFoS2tOcHjrGA1/N61T6kFRUFYBksw=3D?=
X-Exchange-RoutingPolicyChecked: c8IXO14N26Cr5PN1PAkgBT6qT/nC3hW8Mu7cQQz9IiWXsOGcfh0G69PEcNflM9vBIes9FpGFt6PJdZUKOGeUGX/GwYFjeqBG+bRyjFwGrXRdSrEdYJY1zhs1Lr7Mk+JE3LZ3mQ7YfoAQNLUHAlIGj0O4O6V/+//VJt/DnbJhevCMVY0OJ8zFr7cm92IEoc9CFdgv54PajEzc93b0Q2hGg79Ix8E2wdIntU11MdNP3Hbxve7BQys1OF+W1z58LeHsYqh2zbHxyli0F5kUJvYvQImaMw7/5gPTaaQzsDW7O4BAdsdu1nVzLMokwPUGftC/z7HgndbXIo5QCWwlU7abJg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 261d7127-8497-4cfa-d6ea-08deef34ec05
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:52:51.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qp1t5A/h368YrutCCnqrFtmAsup1F4XjknAb2NBWCV5ThKisG5qGUWuj5eQNCx9i/pMu4m5TcTuBlFfNZix9astVj6FyJ2hrmFQyMKIonDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD47FEA206
X-OriginatorOrg: intel.com

On Fri, Jul 31, 2026 at 02:48:59PM +0800, Richard Cheng wrote:

skip...

> 
> Full cxl suite with mock_zero_size_decoders off -- no failures:
> """
> $ sudo env "PATH=$PATH" meson test -C build --suite cxl \
>     --num-processes 1 -t 6 --print-errorlogs
>  1/16 ndctl:cxl / cxl-topology.sh       OK                7.81s
>  2/16 ndctl:cxl / cxl-region-sysfs.sh   OK                5.28s
>  3/16 ndctl:cxl / cxl-labels.sh         OK                3.27s
>  4/16 ndctl:cxl / cxl-create-region.sh  OK               10.70s
>  5/16 ndctl:cxl / cxl-xor-region.sh     OK                5.76s
>  6/16 ndctl:cxl / cxl-events.sh         OK                2.77s
>  7/16 ndctl:cxl / cxl-sanitize.sh       OK                5.73s
>  8/16 ndctl:cxl / cxl-destroy-region.sh OK                4.16s
>  9/16 ndctl:cxl / cxl-qos-class.sh      OK                3.25s
> 10/16 ndctl:cxl / cxl-translate.sh      OK                0.94s
> 11/16 ndctl:cxl / cxl-elc.sh            OK                4.21s
> 12/16 ndctl:cxl / cxl-dax-hmem.sh       OK                4.56s
> 13/16 ndctl:cxl / cxl-region-replay.sh  OK                8.66s
> 14/16 ndctl:cxl / cxl-security.sh       SKIP              0.02s
> 15/16 ndctl:cxl / cxl-features.sh       OK                1.42s
> 16/16 ndctl:cxl / cxl-poison.sh         SKIP             11.23s

Hi Richard,

Curious about the SKIPs.

I'm running this w the base commit you noted, and no skips, so no
functional worry. This must be environment. Guessing you're hitting
the first do_skip of cxl-poison.sh, no CONFIG_TRACING. Maybe the
keyutils for cxl-security.sh.

Please take a look and see if you can update your environment.
Poison one is obvious, since this series is touching poison. Security
one is less obvious, but as Anisa recently showed us w DCD, a seemingly
unrelated test can uncover latent issues.

-- Alison

