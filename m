Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02445187F
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716490059; cv=fail; b=lxw6WaI3L2GlkCBcjZNL6pALH0E4gbFM0RYL/HpIgedXJn4Q7NBe74ptjiLjtqfnWul6+v5L75xDIUTVAveCAKiB7b3BZ1hcHrbjNlhtfEUcC9Efa5zHxDuV9dnRaJ5X+35CY9D8CXW366TTuQMh2JDhcAXmo10kNSjQvOFBJvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716490059; c=relaxed/simple;
	bh=G5JDIQPq1JeDAS9Sm3nWRWKFDC+Z2oOfsTrFDsk7heg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DD1T9jr8IbBGRLri0hCMAvtU7+slQWJYaUzJWcIyI401WarwqxRmtV8QqbIhnP9XWhxQvfjVl5TY+dNAepmr6q5ojJIKyCMs46H/9C49uLkuigjo+RXb2+0ug+n/o8l4IYiMgoe/AFvu29bhHHIjFm1BSIRAYXo0pvtOzGe96r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+NCXocw; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+NCXocw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716490058; x=1748026058;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G5JDIQPq1JeDAS9Sm3nWRWKFDC+Z2oOfsTrFDsk7heg=;
  b=I+NCXocwnNnzW4ipF2/7ggraDfQQ1XpmDrK/HfO0k7zjxLpbqshw/b5m
   eUN6aAClCPOWfvhmU5YbX2RCoZ+729QdU/Ckbj3NOERNQpgi+r4xAvK4j
   /8BGSyl6ue8O8piGQANtA75lUYH17Q/RO00nhzaIPpd5c7sqRL3fYVaoJ
   uJEYWi4ZuRY+hCp3wmjeYvfjiG6cfbKrTjBd4ODAUxj0kGlWCxdwvuwY4
   sqDEPrm8tRxi5OLldvH5hoKl0CMLCdOV33KZZBW/mvhnjRW7CMPAPvKLB
   Mh9yaGPcIW0oLePPcFQ/HhUiUmujZWh1jpk7M3AbJcrR8sW1jOkfhhgbt
   A==;
X-CSE-ConnectionGUID: 6SRnlbm/Qq2+oq/y9lmj9A==
X-CSE-MsgGUID: B7SjUQccRXaYugLK6b1NwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="38212526"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38212526"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 11:47:38 -0700
X-CSE-ConnectionGUID: XRsb3j4CQ6i/DuYZFD3pnA==
X-CSE-MsgGUID: iXmh4s8tSAaf2G6fwRJbRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33782031"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 11:47:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 11:47:37 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 11:47:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 11:47:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 11:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bt4pN0brtp/lLVGQJ4Yj3PQW5fGriFDng2icCN/oJkJPOD7vg3ZsL4IKGd1WL5iGiF+XhKeI8XLZMdqsWNRsNi/d88eOfMk2f0t6X6q/JOTN3L3Y1G0UQKhdeAL0d60oNITzTTyy+V2O/gXb6UEevIq5UiVfz3yfmmvdPSlk4zFlzANWHvFgjR5UUpHRqyr6BnJNiiIARG9LRSxzoTCs+zluf+MwaWNZodHb/lLoYup4upIHos/muj9fb7GV/Ts1nvUtnn0yL8wCVmabm7ps7Bx3pd0pknR8+wozAOXIqqzM0B46r6reCJXviDxiKQu/7uAQtOScB3VOfTEWzlSjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KGO7LQlBYVlZZpVKV21YR9pmI0moK8Z9fjmCDKZbgw=;
 b=PbteBYOq9GnXI+mg2dAEBoTb5z+ghjYJ96Ecrpv5eWrIJyhUGzI4/KnhHraj+widYxC7b3xZ3md3gtzAPtliKWCySwAk7mOzvTRqIZlXm/3twfYtPzW+6+mjZN76tvHuwnSmn/KhGgjyNTWlE7Wqyq4lyJEFfukeWnr1e4N3rnq5qLw4OyADWZbB66gbZOkZmpf83tz3flKx7Z175JIYiqoBSIh3b4DYuQvT2xXY8sssgfz/T7WUq1G0YNKhBolH0yT2klKVZc8M1HLN8Ua8jzCNzQG8HfrX9v5WG8Ou9MXXemMlDr1G/ZFw5IvVmzbQLkMgDMANT4YcJtsV9BGuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6607.namprd11.prod.outlook.com (2603:10b6:510:1b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Thu, 23 May
 2024 18:47:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 18:47:28 +0000
Date: Thu, 23 May 2024 11:47:26 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>, Dan Williams
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] cxl/region: check interleave capability
Message-ID: <664f8f3e79edd_18c429471@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
 <20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
 <662707ea3fb4_6910294cf@dwillia2-xfh.jf.intel.com.notmuch>
 <OSZPR01MB64533E9B5F137904A2CBA83E8D112@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <OSZPR01MB64530A99BD2ED390DF59F01D8DE12@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSZPR01MB64530A99BD2ED390DF59F01D8DE12@OSZPR01MB6453.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:303:8f::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: e2821802-1415-4afd-a49a-08dc7b58cbda
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2jhTCKsVXdg0drZhjBekULaSSLwFtWH6+vIRYr3WVXkQU+lQC1/oFjOMTfsd?=
 =?us-ascii?Q?T0+Xy2Ez65VcZbvjO6qEZGiTE2D9w2H3zHoOPJh45LOAuQcrOQt7eDHiY3oQ?=
 =?us-ascii?Q?ycD18ISk6p18W12cnpAkEY8hQbDsWWKq6gBcIVw9r60vRbI1AhmmXMl8T+tG?=
 =?us-ascii?Q?VOIg6E+St3lqdvPs2uig6Ot85RzrJJju08lzrTwAAs2AXzgJD1F41Az8Y5SA?=
 =?us-ascii?Q?fXbNChLobtGzv65mNcFFJrAvvzh+cnS4EtrRX6pc46HPrb35oiaxIshfo2mB?=
 =?us-ascii?Q?PCmZREwOZmFKkUExMmni1aMpL/5wDxYrpvaml3UKQvzLGjM3eIUP7Ex2EGUK?=
 =?us-ascii?Q?dL6HDn3bT3nJ+s28q8vRIEHCSZ3s2iM8lBBc71tdZzFE16pP5wAlXr6fU7D+?=
 =?us-ascii?Q?xfI+vA0GrWWtivGEU4Mz4WC7pagCebDjVWfLll1LZhXt/5simJVBPXe9XYCJ?=
 =?us-ascii?Q?f4MTc73GvWJXhowwu/blAjcL6mzmzcTYu9Gag7g0DiHQZc9POM2HKMIDCGQ8?=
 =?us-ascii?Q?mIPR0BM+rlu+CV/9lteOoOchZ0UJj7aRJ8g9QSibcaacpUD2cFQViuy/URJp?=
 =?us-ascii?Q?0SdVyMLv/+7HYb1Qa1Q08gLa58KpGMsRWM73X4XWP6Y2kfhu2zbQkgtqdwCq?=
 =?us-ascii?Q?2gPaoN403rJ76iVsUV0lNZr2CfBdVtDr8niwdpuL8AxDAzyKKMOx1NIuEjb5?=
 =?us-ascii?Q?X7xs2atIlzwpZYqnWaCqtlZ8Uc4TBwSo7UEK3GUV2nJ8koqaegzUnWX0lOdR?=
 =?us-ascii?Q?1vW8wA8KZp4HPPeh4+l0ieZyLMYc2vxG10VHqzrbXBFzeTRIJpdisIwFo1ra?=
 =?us-ascii?Q?lHoljaK3/r6TbJiwFYB816uc/ok/mqFFYsw/f4dWTdbDTZppu0taYejiWqQY?=
 =?us-ascii?Q?bATY8nCmRWM+AkCpaJtLJaP3jLzOHa6tLUAdYc6ZQUbPf3G5VP4nDjVeU7gY?=
 =?us-ascii?Q?DKil6IXUyk3ghHeoYhlw8zbyT3uL6MyIy3xetQyq6DtSPUA11jrUrWO0i7ae?=
 =?us-ascii?Q?nciI7O15O4SCfyGTsjxuVXnmXEl1QWBMOmosa459L0qJSmDBqD4lcm6Ljysh?=
 =?us-ascii?Q?SMuQ/gtyR1I75Div45ElQTUME7eIsM8PMsbCXlr32qvIGf0G8y3mHjYTyH2w?=
 =?us-ascii?Q?PoJ1iupzndnmM0k/2vmgmuQcNebt65JKQwhqeRaa3mtKWycCQQA8ucoPkTBO?=
 =?us-ascii?Q?4xd3vNey7/4Rs2qT3lmMIabrRZESDvSkz6i58RNfeLljJ3pj8t9pEvjyn5GA?=
 =?us-ascii?Q?tsym6WoOjxauw22OBRo24vsfHPwYRU5IkEQC2FRZSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWabIWUVuzL71ZnzWUFFTi92OUfPkTtgXVQzQqoQMC5XUcL2L8Amig7I2eIk?=
 =?us-ascii?Q?KnOG4xDr4eWoymnNMtH6HdVa+Gvgt0bAPsJ1Q1uq7KhNVk3/iq88km8aPTYt?=
 =?us-ascii?Q?jQF7RvnVoRlF8xukZuXgoAXnUJNsxXBlLUIfbay+/SvFD1HyXRK3Hy0O2EvO?=
 =?us-ascii?Q?woq1m4VHeJjjArjbwHgZleYmy3RbTFQaDWctlL9XC27pk60Jjru84ySpBDY/?=
 =?us-ascii?Q?wRZmv5icWoHFGPgG1//FFBOUzsZxTzrFjESjnX0csNBU3ZEpz+dfJFOa44Tg?=
 =?us-ascii?Q?+h3/iz9XvrBeUTNLb9DjTqZuhDqE0llw9eP9OGq8O7cGv5AvI70F6PJllGI5?=
 =?us-ascii?Q?dmFTL9l94WRjPXP2Ci/fHtZ+SS1Iv0l49I7TqxbRHxkpGFQKCAdZh1rQPmYa?=
 =?us-ascii?Q?2rxGYBFBbCyXr/7EqPfaYsk4KjlTUbUpGAfznfYTol/pN9W9730v82Td1xYT?=
 =?us-ascii?Q?dH/MNRNtom5lF3CVeCd7Y4r5rD7Lhch+dmcUu8h34BTCRShpyhk0mLsZsbI7?=
 =?us-ascii?Q?nAUkk3SthOrvfpOFJfkWw2GuLysKixFU/+X6Ih/bDO91OAeD16DatKZZ1ODf?=
 =?us-ascii?Q?IZdamhIaOuzl9v2IKPuArWHp4LYPBJBkoaRyVKLi5l/xaFfyd9SJYffqjih4?=
 =?us-ascii?Q?iVM+/cwqGnhzlW08XKOu5XoeZzjYg4ouaBNkl3yKVk0WYWDsaDxJyeZrrK+I?=
 =?us-ascii?Q?BR4kBeyENOSsJO6KSGUwTAaojSFvQzuQAm5Fds10iTVltnfnXW9Vin5YGwaF?=
 =?us-ascii?Q?DNPtUlaCxtrmyvT4feyf6WNb0CmS5CjutIxGfVDYsqIZ7uL1ZOuwoXjDxq1p?=
 =?us-ascii?Q?BF2S5j9QxJb7FPd9mShgXj+VwSIVCwl4FYk1laRv9QfY/7hGjXuFXJLJnL/H?=
 =?us-ascii?Q?2AGc8R1Tone8lbCH1qYAgLgXBZojMs9Az4xlywnzEV24DvdAQKCP4yD+E1qA?=
 =?us-ascii?Q?/HIWK42Y0/txMt0uFyzKlHOB/zSiYsu8Ybq2XjHY5Zs0+/50MNPxfRlzYMLe?=
 =?us-ascii?Q?Ty2uz4ULr1OoVAFw6lO6YXdUZJrE0SbCJki8T+8r5WCeEUcVXIK1Ig9wSQZW?=
 =?us-ascii?Q?MtxrdKM9zJr1qEiAFz/Ss1dGmAnT8M5ES58Pg2hbxle/QY1DoxbQiNQCI3Rx?=
 =?us-ascii?Q?e6HL9S6PWnVufunssos/ltO+QN9w26ZgocYBTwLA8dn581+ycCYC/H+w85V6?=
 =?us-ascii?Q?GgW69i4fQCzQTIhfF3fvUHpjLI5OJ3I0e5E2Uuns6eui3ZhdE5BWUeUFFGP4?=
 =?us-ascii?Q?lfzbznCu6JuTdrljONZ5HI91jK8DQJOBlV7rPEVkhShMbOUGKEiy1syKjQZ0?=
 =?us-ascii?Q?jXjOPBaIIgOPdAVWhIJd871h5211NFUqBDOYalq+om4l6ibp/OGEQjYO3vRY?=
 =?us-ascii?Q?WJaGa3AKNNH1pzojHzhfyGlWguxiEb4+K5A+knvLeF1TaU87cx6p3tp6GR4f?=
 =?us-ascii?Q?+x4zHOQSxjJswhU0QZmqkSMHLicuW4CKRwyNkEKL37inmbULzrpaQe/QqZFy?=
 =?us-ascii?Q?XXY6hwvdQMhp4hwNJWXAStndHueE/y147f0lq4SRXsctyIqbOLl8eIo57ey7?=
 =?us-ascii?Q?EGvPqTv/1Ma7LpqTKHkzZLja6IzfwnM+JLehPqEgQQKe5KlmEma2kMkNaemD?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2821802-1415-4afd-a49a-08dc7b58cbda
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:47:28.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SQD9Ku4IL0VT4RKQQILy4dHYmnHwSpcF8EtwXSYSYBHN5zxjoZ694D6/JMimbRT7dRLzAtjrZNpb+L0tH9Aun7Ad5YU051bFdRN76N62wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6607
X-OriginatorOrg: intel.com

Xingtao Yao (Fujitsu) wrote:
> ping.

Forgive the delay.

> 
> > >  static int cxl_port_setup_targets(struct cxl_port *port,
> > >  				  struct cxl_region *cxlr,
> > >  				  struct cxl_endpoint_decoder *cxled)
> > > @@ -1360,6 +1414,14 @@ static int cxl_port_setup_targets(struct cxl_port
> *port,
> > >  			return -ENXIO;
> > >  		}
> > >  	} else {
> > > +		rc = check_interleave_cap(cxld, iw, ig);
> >
> > This seems too late to be doing the check. check_interleave_cap() only
> > needs to operate on all the 'struct cxl_port' instances between the
> > endpoint and the root. That check can be done be walking ports at
> > cxl_region_attach() time, no need to wait until switch decoders are
> > being allocated.
> 
> I think we could not get the info of iw and ig for switch decoders
> while walking ports from endpoint to root, they were set only in
> cxl_port_setup_targets().

So the reason I wanted as much validation as possible to move from
cxl_region_setup_targets() to cxl_region_attach_position() is to move
setup failures closer to the device that caused the problem. Otherwise
cxl_region_setup_targets() will fail only when the last device was added
and the overall check is performed.

> Is the above understanding correct? if so, the interleave capability
> check cannot be performed at the timing you specified.

I think @iw can be validated early because cxl_port_attach_region()
knows how many downstream targets have been assigned to that port and
can validate when the number of targets exceeds the decoder capability.

For @ig though you are right, it is more difficult given the dependency
on "parent_ig". So, maybe a compromise is to validate that nr_targets
does not violate cxlhdm->target_count at cxl_region_attach_position()
time, but then do the granularity validation in
cxl_region_setup_targets() as you have it.
