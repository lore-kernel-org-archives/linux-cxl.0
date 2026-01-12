Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7661123EAAD
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768248694; cv=fail; b=AjyhPuPWc8fK+xDCIlqLFLLgGsIE2DOTpGOklgQcYS4sRyzf/yhC357FZ0485vWPohp8BVyKZYO0OS9AA4cr91hzE93IGyvMwbJF8ocVN8B/GWVEy8OgRNU+3CCT4vjAPps1MKPh6+gi/l7O6S9LSeiXMYlDAdzgCAblEIO+A84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768248694; c=relaxed/simple;
	bh=vF3XPhSnj/Xk6KytRUsapZyuSAzmjgiAqyIymLxMYA4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MSfVzAhuoWgwOTIDU4/07uTekTLsUJQYuFRZJwp5xn/L+Cpy40LyAlOdhkPFZcvyG2u/Ld6adoRUNbQvQAFHLaGcb/hGOcnmiceS4wqON85dTz26Z4zpxCwh5LtYUl/RewXJedZr8Qh2SUdWbguJrC3oxRqBesTPXbV58iOl6LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wk6al/m8; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wk6al/m8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768248692; x=1799784692;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vF3XPhSnj/Xk6KytRUsapZyuSAzmjgiAqyIymLxMYA4=;
  b=Wk6al/m8Opmmearms+c137XrBS8GAxQ2Di1GeRNzGd3rxBqqJmdzvLjc
   BQW2CdLvH7lJ0J/1HNLGJgfov4jEmXy3SPJrh6cB4MbFQ1sMR7OSyyaQ0
   E0bH1+Umi4fbNEJwWdPrQyQ5i88e0j8cyXW3xikws/o4HnrFhNVTRzsJu
   obHqPnxILdQCw9Z/bddoYmafLVFYTK3IAhAG4mgzXe1wmUCTyfWna6BFp
   SFcZm2aMIOCBJlVUAJXAYGOOqT9+9FiMZCCrA0Jl8uyAXd9/Q8i439X9A
   ajOSeVt10WrK4LMVwmOAK/qpInF5ybp289hca9NQ1u/Y/2rBFj/4fMk/O
   g==;
X-CSE-ConnectionGUID: JaTuyJYsR6GEyoAHhSuiLQ==
X-CSE-MsgGUID: aJR9Q5ATTkyjAeoEPNhPOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="68536642"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="68536642"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 12:11:32 -0800
X-CSE-ConnectionGUID: J0sxlE8VT4yaIApnqY/kYw==
X-CSE-MsgGUID: nmplyX+KTi6VHEl8pL6Vmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="203390706"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 12:11:32 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 12:11:31 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 12:11:31 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 12:11:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyFP/fqt5nppRsoS8fk63yEkN/zY79MeXQIKYEtzbApN8jYopli6ouhGURv1mk3X9uImsG/mh9HFmd2Yxb69G8KGXskeZadIPaUJRaaRvuhZbDB5gYmzei4h4bMg15aflqha1roJ/rhiiI53xx2bWq2l6Hj/qGRYgL99RVEEtsxSHhoCiA9lrpXy3+8JwBKJ7RRFZJmIlHi9YBj5/yYKPePeCySpmwF8NA0fWBN8AnniALyuJk91XFx1oGNwiBW5tJhuXVn7RzQqKEBLRGfkQ0Yw6Ih7VjLUkGTIhUuj0VOtgZUoFSuKYR/U59ItIy9FyZvLWhEWgUjlS7b5DAo9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMo+JDezXRYu+FdB846Jpna7fJ+6G/xNaPJzOhDpG9k=;
 b=AnJAoeMBwF/fG4h1FTMqc9lmP5FsadmEmnlMCk/OXX26mt7iUxcIHQgAe/l89nHBTnxJOo2HGkvgK0jCVw5P3VfTH8K9umBkRN5IT5VcQo4YeZdP05vEtetyB40Px0fyCQb9PfZq0voKVjrl4turnKZIwq/13QEQZh0SANF6qFcoHQ5JIdbwRyRNyCwz8K6K41B7ggk69IUEpC0h89VCEo9kbMEdloL0fzSNekY9xfMVF0vx+CVu2ocw+3uMFWFn/RAnARc/GZt0jKjodCF8/A37e3jj5aAJ5eHrZeLtP022vS2NWRlxIQLDr9ogKkufQoI049x9RKRMzfCyoMvw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CO1PR11MB5025.namprd11.prod.outlook.com (2603:10b6:303:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 20:11:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 20:11:28 +0000
Date: Mon, 12 Jan 2026 12:11:24 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/core: Fix cxl_dport debugfs EINJ entries
Message-ID: <aWVVbGuq1Ap4hqpK@aschofie-mobl2.lan>
References: <6e9fb657-8264-4028-92e2-5428e2695bf1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6e9fb657-8264-4028-92e2-5428e2695bf1@amd.com>
X-ClientProxiedBy: SJ0PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CO1PR11MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: b4dbfcaf-94f7-4c5d-114c-08de5216c4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mG4YrbElkMYA3Gu4RINPnqlL+cerIQiUvwWExH6FSxoSqyI5BFgdXOovGEQU?=
 =?us-ascii?Q?Ij8LIIg1FUc0bUHYUtkjNbZ7xIon4bYKNywnXQHpG22UbXBSC3wLyicvNwBf?=
 =?us-ascii?Q?+CqZuARLvPf7JDjE5SMtjTEBYL1Y6bFIInPzmPynuHF4wpC9zgDPOL/nLhuf?=
 =?us-ascii?Q?yMWsJX/UJQOlcji2JVBxGaSrN9mZDEx0b1C5xHnS/QjxpUMH9t00ErZNUvvl?=
 =?us-ascii?Q?Q8qqpZ0kuSEmRJkD94wBjaubfjwcCEs2Zu5gdCCt4IfOC8FG6JRAyAoviG4m?=
 =?us-ascii?Q?MPm0Y4sEmRQs5NK22nU5I2qINOwqtj/RzqSAy2WQSsAgIksZdXaKBnRS0x3V?=
 =?us-ascii?Q?LDXECTyCt0zt2MosIB2KEC0a2gMlx8gTHQlCJHmQogaAxCaFNxkYod5gx9fZ?=
 =?us-ascii?Q?SnwQMmwEtNzJiOwTH0NAlS1504dc96tYV+s9vcWEl7J3NY1tcerFgixGOABz?=
 =?us-ascii?Q?kvZ3ZnnYwOa93LPJfjmddT5/R2sCzH1qbZtw1f3hsVhTXEdy9oDigu5zc0tI?=
 =?us-ascii?Q?j3m53mrgRfNOcgSHRQjxnObGPzM23lw50DckUNpLZk9kSn7WZA/Er6Yv6BXS?=
 =?us-ascii?Q?oLdE8S+H+cQEvTYdKn0ajy80Bb+Qo5Tsuv1S3esJSvUbu2vGcjvZPKt8/Zkt?=
 =?us-ascii?Q?9B0X52T6or3Yo+Hyn3Dqmw4ih8ZxmFj2tpHlAwzAM+/KpRDMvYInqWqYpkV/?=
 =?us-ascii?Q?yHXCWwqiX4k7z/+NJ5GUr/1gPciFf3HSWq26f+purAFjzJdus927rC1wamd7?=
 =?us-ascii?Q?7l7db6SalJah44FvkY4jEAXxojQ7lWCUyCX9buR6uTZNvHmJco39EQK64cRD?=
 =?us-ascii?Q?Qpi0OxyxQgyScjP4v7q7RuMSADceVb1Mv9TMrPqp6HD7/0XG4FZDggMJ0UwS?=
 =?us-ascii?Q?3Y24PFdsKKk+mU3pjH9I76tBZLi8uY0ApCRnITuOgR5mOVUsoLwydDjdH3bQ?=
 =?us-ascii?Q?bLlI5iiVlGlNBbOS21tPJsNUy4PqYT/aMYF2bdLgVScPHg0+Odk9Y6R4bNia?=
 =?us-ascii?Q?c55vwLHedNhUyOKArafpnd1qf/Kj/tSElThZ1Dnxvl/EWAbBJUV/l9WUZoF/?=
 =?us-ascii?Q?n7KJbYf5HIhcmgH4N82trazT2cdEvUgXb01Y7k4FCrF4nhCPg+VBVCZdYXJE?=
 =?us-ascii?Q?vfxJ5S1BEXuWz/EpxxXVXHeeZ1HGnQtT3lrV4TOBQWAQTTqLI7UDZaKQMCeX?=
 =?us-ascii?Q?RPSdhOmg4ZR6576CeULfBDF/ef6ZL9n6x73uyu/QAwB4aFcXxEmeiRLQ967i?=
 =?us-ascii?Q?UfquvrJ/cGhKN+AHIoIOnXRuWYXRQBtFKZYH3ddgSknnj8efNSyUze/SYvh7?=
 =?us-ascii?Q?klsIBAbQBsswJMmlf4knCu9fRWx1V6PsB1ARkl5DQYyMioqh++/KzrN7Ya9q?=
 =?us-ascii?Q?IHOmoR0TXqT4G53+ZhH/adeCfI3+SW5WW8fHSIXPHH1Uhs4OuZ9QC4BMxN7H?=
 =?us-ascii?Q?9AlSu9p2jL8NNROPA9rsnN7yw4TByMhb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nfyu4cZaul7P6SBmYmYAf7JScRvZ1wajCIx/VAT8VMoCXexMnsQO4n1u2vWx?=
 =?us-ascii?Q?5KPebYP49WWudUxAKqV+31zN67uoAHkc6HvFUG+mWVN35IzCtOcYniPDNctM?=
 =?us-ascii?Q?LeyxLuP6vP/hh8SJJG4Kkx1nmeE1nUcDlunAf6TIDR8BZMPXCf5ODtiWrLYM?=
 =?us-ascii?Q?emEq+OeIY3aT7cnCF2Jwgv9c12K+RvvCtCMXd4J+K2mpKCYA6yajP65Tew+w?=
 =?us-ascii?Q?xDJcByqAhglJqerdY9E8n9iWnX3s4VUT3DnOqEdExvVIYTdmRhpPvrm/yucf?=
 =?us-ascii?Q?XK2WiNomCyIUlC56nRHrFDGDGwT8G3clKX4h9INBrKitg3Fx1z+PBFeltLQ0?=
 =?us-ascii?Q?HRQz5JoBNt1Mazf9Z4SNvqR4UahQBCBR0HA/skPVzzjiuje+xblaCEiqBPxo?=
 =?us-ascii?Q?MS3kWy6DKuVvU4x5Op3iRrx5RftCDgk3bxuGmjGg4edl7akQO5E6MyIhmLVf?=
 =?us-ascii?Q?lCpzptenePO7SKDJLO/1FptvjbM108CSUTSf3OCW/cqD0w8RFWbADJkeHYjJ?=
 =?us-ascii?Q?rJNjHrZnoGrdZYb3iF+/O33TzUX6AHooZ8AbUaTgaceFIumzLa3sI618WutQ?=
 =?us-ascii?Q?EKwPc4t1Vezd1rpZFhyZcm24qfj3fta+PPADRQUGJMXlpoVl+Id8y7/kcveU?=
 =?us-ascii?Q?qpLrff5hukVfF/WPlorQfrp/Yd0UeGENAI43vZQZ0e8XND04SraTqNOUO9jF?=
 =?us-ascii?Q?8H8RG4VGvPuewWjs8hXJuAAeE2PJ5U8h5VydfevBnyO+8RK4WCFH3ZJ0lA7A?=
 =?us-ascii?Q?BovUhdGj7Ek/WB5Y3F+SyrSdCuCg+sckXRtPoQHC2dKrmTj/5GkvqM2P8lkl?=
 =?us-ascii?Q?FUxatzbuXj6wbnc82VwTishrSJvcyJlfGg15e3vcLP3O5O9k0V4PE3AWO8I5?=
 =?us-ascii?Q?2fG1zL5jKNCsVu2xdvs8gzuJPDPH2zO5steT2v5IpO1JsKCg9ugizt8pgTSU?=
 =?us-ascii?Q?AsVJBUpS7lc6Tt+aZa8wV7hhSQZmvvsFedPVe+QraWIH2Q6ZSrBb6OLrP+yD?=
 =?us-ascii?Q?rrzyGGpSzzETWko41xtG4DcLKmDAPVMxzlshenvJ788Q4PeWOYylStNiR4F3?=
 =?us-ascii?Q?tntOd0Kz5Ra1ygJx8bVRz24o2+Hb7Z6ZzJDAjI+xBGA3FmF3ZAZRgdv9foRy?=
 =?us-ascii?Q?WUOu9qXxWeyVbOmI/4Qy6SviKlsbzhBH4vau4+X/QBOzIzENbQbs92iHOrAm?=
 =?us-ascii?Q?iGjvh7Xw8IGeSNaynKonhPi93aXdauTPxgTpISClgc6ANAfit1my/JVgNIW6?=
 =?us-ascii?Q?BFicocEcSbhpqdmNUCaepc6FijHkJNA0wbufhD9hzH8SaaWTqOsv7oV3jfVp?=
 =?us-ascii?Q?h0J/nvwGlXKvzKOE99I7V1KFnN0WtW5G0o1sp10+15Ouxp/kbkoCP9GhKjKo?=
 =?us-ascii?Q?+BNBVgh9x/Tu1nGCXpWkU1GXGuMQ0UHJBBd23mRboBQ8NhuDybmcXjTGpOzX?=
 =?us-ascii?Q?RoVKVMpKgiutslz3ualW5TOT5K9gkAvPuttJDwvUxgKMQRGO58d0qo95ta82?=
 =?us-ascii?Q?WclrQB02+1ev+HVwZbCUid+tRpnFby7CaO6qvwcXaJjObWyEf+q5HiqZlAy9?=
 =?us-ascii?Q?B+9WKuAis1TnkkIsBU5Pze889apPZ6fYeXMzbCQ0DjKSbyr+XlLx1hce5t71?=
 =?us-ascii?Q?dFGPudt5wMJh7xOEfX62msg9k+4HjnNlHg08DDD6kKe5BazamZ/qVkAyBLXK?=
 =?us-ascii?Q?RLmYDi9fA8jim3P96+Xi1rBKwy/KZney2DTT3PfOlDPyywCHX0yV5woxliTy?=
 =?us-ascii?Q?YHOB274E/ISWlI9gF3/Y5aSySt5rWtA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dbfcaf-94f7-4c5d-114c-08de5216c4d0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 20:11:28.0889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IZ8EhiHGuh+2RWGa+rzfmL3Oj7m9wyQr1Rf8YTeHUSl4abKRN5CPycZCKyfdiynZm5w0U0hC5sjxFY4fL6LrRIEKO8BlIJBppZ0SHrb28s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
X-OriginatorOrg: intel.com

On Fri, Jan 09, 2026 at 07:57:38AM -0600, Cheatham, Benjamin wrote:
> Protocol error injection is only valid for CXL 2.0+ root ports and CXL
> 1.1 memory-mapped downstream ports as per the ACPI v6.5 spec (Table
> 8-31). The core code currently creates an 'einj_inject' file in CXL debugfs
> for all CXL 1.1 downstream ports and all PCI CXL 2.0+ downstream ports.
> This results in debugfs EINJ files that won't work due to platform/spec
> restrictions.
> 
> Fix by limiting 'einj_inject' file creation to only CXL 1.1 dports and
> CXL 2.0+ root ports. Update the comment above the check to more accurately
> represent the requirements expected by the EINJ module and ACPI spec.
> 
> Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

