Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B52C9D
	for <linux-cxl@vger.kernel.org>; Tue, 23 Apr 2024 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833970; cv=fail; b=nZU76wjCSLEhJb7873u5lacAa7nUV/4s//APVTG5COZoIB9jIwdD35OfMP8vsULlhYnRR7dkA35eEl5xIVAHPSRfnrTejy+tmoVLXYjoDvFZgo1vf89kdnm4i57U81SYZniHM7lLN1Nwq+DLTTUjhER0/vDpb/pEXnbAy5wy/so=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833970; c=relaxed/simple;
	bh=gI18yVjM56/EQgnY3H6wQ48IvCy1JvNtW+kMEeK+A20=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BOkXHzA8+CccuVNOrXS8lyHXaTkSh0450q2U/mpizixfu07nA0RWWmmzvQ+dNHqVSQ0ihs25Xe8BzT4y8EeQd7eOX1dkIOPCNYEUVg5/XFt5usV1TkVkmCMNtnwpu20N/xix9Y5Pelug4tXTZGHyib+HJLxVtJEgTXqII9+CTh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJaGiErL; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJaGiErL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713833968; x=1745369968;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gI18yVjM56/EQgnY3H6wQ48IvCy1JvNtW+kMEeK+A20=;
  b=YJaGiErL0IfZ21HDqnDTGcv8wpafooe1dFp+AXsvrTh7nGEaC9DR6HmR
   Gm9XiaHvO7ucm9DFmLnpgSajUAZLzFrgZ/9NMCA4mQHJsoVqG5jcpk3p+
   4FYtByq12VUTBi1+Rq8kHQ36vUU26L8u48EnNSKzqIh6yRW2rBuwAleSP
   Glc8AFvFLwtq2/JF6ktsHtjo4uC9f4DoBOC5LZxDwtoIpDxzkgcEsX57i
   jse8BcfW0lTl0ceo23oHvvwqqYZkSiqg+lAuRuny0ek158F4rz0l/aDxK
   5ORwxYucuo0XFB2dtuBYNwFcf+R954gav8F4nusNFNDmE2DZ8TQF79qEx
   Q==;
X-CSE-ConnectionGUID: 2Ygq36R0SMiWbB9fwA9V2w==
X-CSE-MsgGUID: tbso99V9RGqLPZupBkeR2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9618696"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9618696"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 17:59:27 -0700
X-CSE-ConnectionGUID: tHfsDIS8SoCOTbcVGJowcQ==
X-CSE-MsgGUID: jWqT1lOCSL+shiuhuepzDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24066266"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 17:59:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 17:59:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 17:59:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 17:59:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 17:59:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkBBKNO7+l/RCe5XNdvvHYaKiwt6BvEG3gHRjJdcbmSg8mJroBVlj3fwAyNnv9+XCoVr+fkdJDTyM6onW3NKYiFNPRDEgEJsxVkkA6cGNaztkbGwV0762NuVNzIT9YYAqF7E8XxLembtjYmvgTvVYHIrbP3dI7pCEfO7ChNkHK/E6H74UelxLcm/6CtdnblN25ga3YJ462BG0ce9N/6cRo1+Iz9P9jvSLfcxmyjI7Oaku5r9IltYNscsFbZCOu9Htj2sXcRhS7BA0miFD+5I2O1ow1EYSDrm5k+A3xTQPh0bw4W5XT5zPoxxKrjGhJOsSFZKBGRwF+jaw/lICPTABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oZDM+XNA2z1nLUH2PFTuHJfhIgGVXtByWGJNWX0oK8=;
 b=Mofnj/gFxyuV7EaSqy5jzlUIEaHg762FBkWzysPL6WXvOKh09kvnRBVPBdMbDbDGMXXKQI8/qCtW5Os6xCeCo9r/MA59vpW8/2qkRO2tr4oZABAuAb16Bq89PBO3EA8nGMvYIIjVjbr3FvVsaaQmEeATgEfR1YiuktxzIeF/wvcNQCm3jNkVABRDSxGvBhKOW+8Q9XH7bCXpSvY9Q8bMQUI4GypQJv7JnLBVw/LlvDjJrjeQrkklzp4QoXpRrewfBvUi/9MGF4STJhC+sQRd6XZdSSCFbde+l2Hbvqyke7PYGMqXsFNasI2brUHPuMQEDkIy3rDeub9fr7L6QAQi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4994.namprd11.prod.outlook.com (2603:10b6:303:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 00:59:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 00:59:24 +0000
Date: Mon, 22 Apr 2024 17:59:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jim.harris@samsung.com>
CC: <linux-cxl@vger.kernel.org>, Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: RE: [PATCH v4 2/2] cxl/region: check interleave capability
Message-ID: <662707ea3fb4_6910294cf@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
 <20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
X-ClientProxiedBy: SJ0PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:334::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4994:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e3d69a-8478-42f7-4137-08dc63309e20
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LxKbaIIWWvWwpVZ2xZsdRLPmpXyaScLi9gfHglHDAjPaUvsrPxByfm9EmXHE?=
 =?us-ascii?Q?VyMTGImEKYk1oDpPPkqqQHsjJHzKhz0qC/9Q6BccrbyzAPg3tmCvqDmaudQj?=
 =?us-ascii?Q?c2Z5GluA6rJXfWZ5FRKN0MpZCfax9ZZgm+1Y8sP7pl1uT/Jz0QFL00DDFl1n?=
 =?us-ascii?Q?pH+iKj+PGVrg669ZgGDtUEPj72DAYmHcomiI3nt1QytmOtEsbfUpoGUrhhbB?=
 =?us-ascii?Q?+jyBHPqW/bnquHdkMTeJoDwd7K3lAN1oZ5c/TcVULIpZ/zLSjQHBblRw2Wj9?=
 =?us-ascii?Q?D6NFjeI3via7d9Iy88jt4UbxSOZnCQXJLZOHRPiIxvAd7sGHsPdFuzUtg5+w?=
 =?us-ascii?Q?mKE3zsHIquhRuSkB3b/Ptnck6r9fphYtF7GVeb4Z34QYlt5pod54FAaGwkb2?=
 =?us-ascii?Q?eYuznhahCYsmZ/XSELn4U1TyiDquP+zOH/MMBZEKPbuzdnqJl2GErZl3xo3g?=
 =?us-ascii?Q?9OL/NmSvRoi9BVJj+xCDywgyBYHE/gtQ1vA9DCzjjlMfFajSlUW36IeLCELw?=
 =?us-ascii?Q?sCyLJ12ENMHCYFUOKyCxRQelQHe9rdqlcDG42K53jC/ZK3e5IVST0XKWUZj2?=
 =?us-ascii?Q?njj1g1G8UYip9yqbOC8WLeD5KoHNBvFOzK9qUxHJdMh9XiYI1eKSXkTOaemz?=
 =?us-ascii?Q?tUsqbBa1LNAp+qRZU7c/kI/UQrmyeuF9CNKfDHNvZIqnOvm0f4QdwT5a9uVc?=
 =?us-ascii?Q?0ESdYPjiQTGDpr3gTQ/Uw//8FnFKEN5IkRl48eGyi2KP1PeaGFqNm5FcliCn?=
 =?us-ascii?Q?muzFrEMi3ijHaT0lRWlmwWLpMENjW9ErMAjOYKtASAUNe3RfZXlsCaXptBEa?=
 =?us-ascii?Q?stSMjEhxvvEheyDWmxKBNFlxnJjVzpiDt+IE8DwibyxB6QC+XunRsxxEPyGt?=
 =?us-ascii?Q?4TDnDNGXRBbLG3o4WHyqXrf7zJzdWOHLd7BYKMKydoH6HcVyDI70mdayFCyG?=
 =?us-ascii?Q?fxuTdYzkyTgaYfwnt89RQ9WGjyxzVcHNupILYJ1oZ0IoUF3WIwS5dQZlMVVd?=
 =?us-ascii?Q?bKIeKqhTsGg0+njotvKBGvLyg+xEOT8Pq66hOZ82tUx2tv3UiS61Qalj23kc?=
 =?us-ascii?Q?G+SJzR7A1JgzB3NXizRtk+msM4i7858MAv2Wl5HkDa6FLV937gWqvaU+foNy?=
 =?us-ascii?Q?WStCexwoz0CofZOTqZZLNT23MZ0wOegapChCqPvR2+eRaIG6tq83MQlBMHah?=
 =?us-ascii?Q?zi80AMXfxLIFvt3xMN4oR4X5AYMtWeagHRlvfy7anvfJ8diCi6YxEgJSMcyn?=
 =?us-ascii?Q?gvntDgu6Q7f31obz5l8KzyhCupaCq7wzm8pqvIubiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GTnp40UpkJxO1Op1/MrbwNB4RfeXhgCC5k+EIuMn0LBXPgcPAgh1k/bNrrMX?=
 =?us-ascii?Q?nAxZGpoHhcj0xw4rN9HuvcTFOgRBAswT1AayMOeOeMPCxjt/vlaE4UpK/lPO?=
 =?us-ascii?Q?/ROAI4zGbfLe/BJLTm1XjVnsgQG4XCHU0GjmUa89cTeRe5jiljdWZ0LxRj8H?=
 =?us-ascii?Q?pyJBTCeUFyVNiLXws0L6359gpTuWXSpPjSM/wRnEY/40i+72c2sgV4fdIjly?=
 =?us-ascii?Q?CAbwewfbd0/STpv3yBuPCXKSjPhwSlsnm4CRJRtYJNrc5xINXmz4KSuH/ANK?=
 =?us-ascii?Q?qsfNKnurbHKarMFmAA7UBpLQVx0p9AF0LCQRjwLH0MMnQqZswHF7dDAwGZyx?=
 =?us-ascii?Q?NImOQ8KhaH2BF/GNwcHyfcQ3hBH5XTqVTR2m+06lyCOyi+1iGwmfEYHPtbi3?=
 =?us-ascii?Q?Iw0Gi86/euSQI0PFSIpAv8i1EvrY4oEFIkKRRfwwe/Ko8nCYkjF4PlfsAtUy?=
 =?us-ascii?Q?rNpr3WqxhyV7AutA3i2HGSaTp/dby2gg8RBM005t3faH9arD1DdlnlGT6NHv?=
 =?us-ascii?Q?zXXYqiOtRa/rqzeNlQ74rH23fC1HC3ZflRR2W5iYC/hnqZ1yar5fvmsang9k?=
 =?us-ascii?Q?XaKvZCjg6qXzQAKtgL/GgUeNQO+Ovh5hMW7h27CLJ29zc21ZUHVo8rvmUX1T?=
 =?us-ascii?Q?siPDBLi7K3GANdFQ29p/1yYJKrM3XMuGFD4FdP3xHrMQ6lbaochJ0bbYPiG0?=
 =?us-ascii?Q?qpx5K5A5HMmn/G0nhmePxEuJUy5U5V6xbtae+UXarSwBFjNUWrdzVYc8JfCG?=
 =?us-ascii?Q?vkzTvB4sNuO2MRDrtcXWewTjpbCu3QVakqGk+THPUVxDF3tdeWqC6U0+pwjh?=
 =?us-ascii?Q?Ls1vcAwf6vsmEP4EQHB0xykhJc2FZqNtPzJXuZsmeM7aoQIRU6hrZuUnnM6X?=
 =?us-ascii?Q?eL0HAq7k7jidvkANnzjPTiRXhtEuDckIzusAsNQtlO+7qh5c7q9Aw6Ktz3X+?=
 =?us-ascii?Q?ZdInt6MkTox5xmQsJnLABHprLxyvpPrClJpw73CpiMRoykDUsnkaMebvF7AJ?=
 =?us-ascii?Q?4rLbaPe/LSgPY/f70obaucg3z43N5ZCIQDXr2OGRxD4C9OIc/y5/Sqxl0YWa?=
 =?us-ascii?Q?eqmt37fd8CaoxrsCR3MegJxFcxgVW3ut2E+lCS0tFMXFgKZS/b+AXFLfES0H?=
 =?us-ascii?Q?dwRHjTfuzjwgo5L63Uz2IPnioTRWJR6W8EbZhL/nP4+f67awZjmg8HHgJyVR?=
 =?us-ascii?Q?SesB7RKQQBiNitHsiOx0csLI1HLM5yB2Ml4QsBASm/GMUw9pOhJRakKAB6lO?=
 =?us-ascii?Q?F34oxDV8F00wnbtiRBJS8hzLhSu8JZSaIAIvJRGOU4z1hIUZNvBHxAmGtS4Q?=
 =?us-ascii?Q?rydx6L4ldckiVooKSuoixwDpp2a4wGpeuFyN/Uyx13/mXo6zsvUeUYh26PZA?=
 =?us-ascii?Q?ofriIbMyqgR3j+ZPGR/i568YtIcBYE/H73CPvsRBW9FT+r1E6W6L0ugm65fZ?=
 =?us-ascii?Q?Bqgsco0MMFclPUiGdJo53TGxnIjoYhJarqdY1Myrx+dV9pHro3bDU3moVpJ/?=
 =?us-ascii?Q?XKy13R4DqGnOntY4H3PxBKl6fAn6lGjW8+D1KROvkoNBcZBQ2oMItURRdyu9?=
 =?us-ascii?Q?2rZ1tlBC9Q06U/E1vFlDTDsWxjo/hpCUphQ9wt1Dhj3a6c8CK1RBSp1mWYIu?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e3d69a-8478-42f7-4137-08dc63309e20
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 00:59:24.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2vYhpoF8enR7DIaWJ7dxY3TJqiQwKGPyjMiZZUPhzFpACDRqH/aFj5IbvK6QOrVaZhnbVMSHgnnW1uwLeFaKIpnoVV+N2yX5NCG64LilCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4994
X-OriginatorOrg: intel.com

Yao Xingtao wrote:
> Since interleave capability is not verified, a target can successfully
> attach to a region even if it lacks support for the specified interleave
> ways or granularity.
> 
> When attempting to access memory, unexpected behavior occurs due to the
> incorrect conversion of HPA to a faulty DPA, leading to a segmentation
> fault, as observed when executing the command:
> $ numactl -m 2 ls

This is a QEMU specific statement, right?

That should be called out, because I suspect the behavior on hardware to
be different.

> According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
> Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
> Capability Register' indicate the capability to establish interleaving
> in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
> be attached to a region utilizing such interleave ways.
> 
> Additionally, bits 8 and 9 in the same register represent the capability
> of the bits used for interleaving in the address, commonly referred to as
> the interleave mask.

Perhaps replace "commonly referred to as" with "Linux tracks this in the
cxl_port interleave_mask"
 
> Regarding 'Decoder Protection':
> If IW is less than 8 (for interleave ways of 1, 2, 4, 8, 16), the
> interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1.
> 
> If the IW is greater than or equal to 8 (for interleave ways of 3, 6, 12),
> the interleave bits start at bit position IG + 8 and end at IG + IW - 1.
> 
> If the interleave mask is insufficient to cover the required interleave
> bits, the target cannot be attached to the region.
> 
> The above check does not apply to the host-bridges with single port and
> switches with single dport, because there does not have a instance of
> CXL HDM Decoder Capability Structure for them.
> 
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/hdm.c    |  5 +++
>  drivers/cxl/core/region.c | 70 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  drivers/cxl/cxlmem.h      |  1 +
>  4 files changed, 78 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 27fb4f9d489e..b201be4b8d76 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -80,6 +80,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(11, 8);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> +		cxlhdm->iw_cap_mask |= BIT(16);
>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..5c09652136c9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1210,6 +1210,60 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	struct cxl_switch_decoder *cxlsd;
> +	unsigned int interleave_mask;
> +	u8 eiw;
> +	u16 eig;
> +	int rc, high_pos, low_pos;
> +
> +	if (is_switch_decoder(&cxld->dev)) {
> +		cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +		if (cxlsd->passthrough)
> +			return 0;
> +	}
> +
> +	rc = ways_to_eiw(iw, &eiw);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cxlhdm->iw_cap_mask & BIT(iw)))

Would be nice to just write this as:

   if (!test_bit(iw, &cxlhdm->iw_cap_mask))

...requires making iw_cap_mask an 'unsigned long', but that's worth it
to me.

> +		return -EOPNOTSUPP;

This should be -ENXIO like all the other hardware mismatch /
misconfiguration errors in cxl_region_attach().

> +
> +	rc = granularity_to_eig(ig, &eig);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Per CXL specification (8.2.3.20.13 Decoder Protection in r3.1)
> +	 * if IW < 8, the interleave bits start at bit position IG + 8, and
> +	 * end at IG + IW + 8 - 1.
> +	 * if IW >= 8, the interleave bits start at bit position IG + 8, and
> +	 * end at IG + IW - 1.
> +	 */
> +	if (eiw >= 8)
> +		high_pos = eiw + eig - 1;
> +	else
> +		high_pos = eiw + eig + 7;
> +	low_pos = eig + 8;
> +	/*
> +	 * when the IW is 0 or 8 (interlave way is 1 or 3), the low_pos is
> +	 * larger than high_pos, since the target is in the target list of a
> +	 * passthrough decoder, the following check is ignored.
> +	 */
> +	if (low_pos > high_pos)
> +		return 0;
> +
> +	interleave_mask = GENMASK(high_pos, low_pos);
> +	if (interleave_mask & ~cxlhdm->interleave_mask)
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1360,6 +1414,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  			return -ENXIO;
>  		}
>  	} else {
> +		rc = check_interleave_cap(cxld, iw, ig);

This seems too late to be doing the check. check_interleave_cap() only
needs to operate on all the 'struct cxl_port' instances between the
endpoint and the root. That check can be done be walking ports at
cxl_region_attach() time, no need to wait until switch decoders are
being allocated.
