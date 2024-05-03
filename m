Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C6D26A
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759538; cv=fail; b=XRqZowRzbk7b+y6KlPAa8RGnrSzQz20FlAHfs6i85j81v71IRz8G836lWg7Lt/s2n282pmM9VdPaCT1bkjS/tuiePYeUYNdiMwqCDMtHb2aQj77WLac+FVPQ87gOsLPPXnbTUyMMKAW69n/oAZBeHcymsApP0173vA/JuVr6nv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759538; c=relaxed/simple;
	bh=HQ7CUnCVTr0W51/GSpHlWsej9Qr4/hgZ0fthspEPAUM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qmk6+/trFYsdLFzA8zHNKvgC/NJP3uoi8DvHNSo9TWLNAtyjI9RYPeZQ8eWUeUouFvlo9moEVF0jSWo/0RFusO19cysE/kEm47vZ+r3vZSA3ekrkhM4yk5dVDPEj89oetDJ5ZPacp3r3qpqtw4+qFsJnbb+Es6FEyiie+yg+3do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfhxAujl; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfhxAujl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714759536; x=1746295536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HQ7CUnCVTr0W51/GSpHlWsej9Qr4/hgZ0fthspEPAUM=;
  b=SfhxAujlVDSdlpw/w9VPwT1QJy2KLSxPRw745tYQcVOl3G5tvmMRCxGh
   mvOX9Qr30oc/PMuz9nH3fWyjEAwJ6qPCDwUIAEXSaLZpbjzr9MlYZwDDB
   FVrpewseYT0jvD7JHoaxde78U5JHlqBvY0AmjqOBdENwpKsyrUZtwbH+d
   7U0Nw9gv0PXrHUhQAhtgSI4gzjlXNMTffafA2bHscPhPh98sEZuhm6H0d
   Qvn5R6WrZllBs1Vry3HoFhRgla8u3135WGIg3WAb5hFdNb+IdGEtaCZCC
   Jc2M5gk3XSFOvmdvxFWYfIf8CuzuY7gz4vho2Z2QuTBiPz1EYGgiuAveP
   A==;
X-CSE-ConnectionGUID: aYGwlkvYQDOEB8GW25pYag==
X-CSE-MsgGUID: u9y04pEUTICPweI2x8Ttgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14394267"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="14394267"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 11:05:36 -0700
X-CSE-ConnectionGUID: zS/Awl8MQ7qDdcoq+oZMiw==
X-CSE-MsgGUID: +vsNS5KXRpuH8g5VjH+PPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="64962641"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 May 2024 11:05:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 May 2024 11:05:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 3 May 2024 11:05:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 11:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYl+5mRSVLIVmNtgKsPdoWmVayP0frhy0Sh3yT1OKY5JD8sZWacjyaVOpsnFKV4J9myInbj7FQBjwDM4HkcMwRUW7GQwOmP4d4Hlac+k9d//lzUfmbrIQj5/TKtLmywLfleO5VhcCLuBc50NiWQcB9Whtm/zl9LmJA10aV5ZmrTy1rb9K2xae83OWLH0yIMOiwf7ysORzmG+CdQWxdsjb57tvAdybmbuLcghVANkhPRV7FqPuXEVukM2TeM+vHXRzht2B8TTMe3Xv9Hr9P13XO812KTwgOC7qjX2USTZ2lc0B2fxeMgXP5rxUvk/5fL2IBJrrjM40HuOE53lNisdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lo0k3f0e/UrYT8MBUWc/C4QdDDgo1NteE5S6VkmuuY=;
 b=Qzc6oz8bhgo2XFyr2OqJhPOdPzIXLvO/28kUaXww9t8iwGlj627nuybeJ3zCaNk4/Dw2iufLCs+OlwtaBAkvqCDumOFUH26NAVeHoiNVzjYYEfbHn0V3xPo34bcVm8nDj5+kDi7dEPsl9G1q4inNo/UPVqgs+m/QAXjvtFc1ayF6c3N+hQVhHMOrWNl6ClR2xR1e4edycRcO6E2D5Ru2zQOH8UN/ASBAxYEr9WppYuIJ3IWP/DECxjBnldb275MC7ryGiLa350sBYqIg30MUxak7MmlFkgjT/iLcgBLTdV3rDXRj/jDySjWKsXv53dGPCluJI2khGuF2qOZWSzL3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5894.namprd11.prod.outlook.com (2603:10b6:a03:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 18:05:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Fri, 3 May 2024
 18:05:32 +0000
Date: Fri, 3 May 2024 11:05:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Shiyang Ruan" <ruansy.fnst@fujitsu.com>, Jonathan Cameron
	<Jonathan.Cameron@huwei.com>
Subject: Re: [PATCH v6 4/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <66352769c2394_1aefb29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1714496730.git.alison.schofield@intel.com>
 <dd8d708b7a7ebfb64a27020a5eb338091336b34d.1714496730.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dd8d708b7a7ebfb64a27020a5eb338091336b34d.1714496730.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0356.namprd03.prod.outlook.com
 (2603:10b6:303:dc::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 750f0a76-ad84-4d55-43bd-08dc6b9b9fa2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8885F6a5nF+tpSCyLKozHOFaj7MEQNpmoZB6z6Pp4XuoOeFflU9iy3EYwcJv?=
 =?us-ascii?Q?24CF6gKaveB8O88w4ExX1PGkxGFljR/hRah4ZRI/OhYwnSNUrSLMSDdIpFYT?=
 =?us-ascii?Q?WF/aQrZVOLN9yGACLdOa1mjPm8jEuAzj2ehMMs1CjVYYJlCa2usGWtEFsRAq?=
 =?us-ascii?Q?qgtrPzF7OL5+nj4L0wBrNxMnIGRJ0ISvvfRCXYSPJWsJOXV56e12gN5+smTq?=
 =?us-ascii?Q?wo1OyWjFHvrdbkUK06Lie9k20gQfJjnw4m50FuSqwIS+6pFxklozt2rK+SKP?=
 =?us-ascii?Q?L5jqdIXto4OcRQLeTnyu7Lv4CJ0fEH4xvb7uwhTRhDwaYTlGs6LXmbsN2Lcl?=
 =?us-ascii?Q?2li3i/cdYHqPJxM58CLRGEaeq4TFfjO7PV0pN8Y2OulBbrrLFtydryOY1swt?=
 =?us-ascii?Q?oSgCz/SA64rhet7Qxm3gJLuMuR4bBU90LxTHxBvkOtbjGtlYH8CkS11Hdmn2?=
 =?us-ascii?Q?CBqJQywDk/JeAFXWLTj8RugyqoMV0amkGqkUxKayb2pi+JhHhYbW2zeXKmuo?=
 =?us-ascii?Q?4KPPGuAEi7KpZj6m91A+35A+Z38K7nQb+P8wFjkjSVaj/OYfMtWgOKER/Ik8?=
 =?us-ascii?Q?WxCts0Aq2gZ5JF0vzHXRXwrqbzePlwOt5ZD+pUVvmgEZyHBv2BEm2s+SoM+n?=
 =?us-ascii?Q?ex4o7cYj4L+333+kcKPGeXhVIPKuwzTzmSRi7UU2wDnzAoo2Yl3vjz/9OXej?=
 =?us-ascii?Q?vxBaousBO7asl+JBRwH/iOScymRlQFZupZqL3xZNVPltHDIO/Jb2otup12il?=
 =?us-ascii?Q?zU3v6L/rrz7KklGk5jiDGCc3fUhoHqclX4qyGqMqfB3Q6eeo/U/grsnIlbij?=
 =?us-ascii?Q?zyMYV3HGM0/0vDipY0SBTaUi1rC7jID6O2slYcaYJEmITy9os5rHYWLHFVT1?=
 =?us-ascii?Q?+pa59t8JAjBMRmnhCiooSPJrJ36d8D8nVbAu5sSxRxDCn67oK0om4LCw3j+M?=
 =?us-ascii?Q?Sqanqck77Z6dmw6pibzQzydgp8KIRRKwuEkfig4bqOte1mG/HMoKhtFfLNPI?=
 =?us-ascii?Q?NrwKuWFzsj8/jwbX1StipPRptt1oohzHA3MNjs0gJocg6wAfsVAwuxOB8GSX?=
 =?us-ascii?Q?2HV7zKupkewnB7r66sYlHv0EzNRz10zNaYLCM0rmXW/qBjtC3fLp1+wdAjou?=
 =?us-ascii?Q?SF1XFCOS26itDAuu2Dyu7y8DgkNIu/r/wJS/HiSS76E2HJ+Rtej07LX/KETA?=
 =?us-ascii?Q?HGeBBCGm1igmRalPZTOgabRrUbEm9Hbu0ej2iKE1k51PxB/BuQhLoY/wZX4m?=
 =?us-ascii?Q?Cs+u1MPdzRf+4BPqiM0gbyL+pqYfRswbEmwHF5mEYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WF65ajdPkS2HAEECjPwy1k1siqN5W4yqo4MV689FR3zVLQwRFH6K39kYq7/4?=
 =?us-ascii?Q?5MSfvtZod9WQmq398PR5kl9brHPx4O4boJWTaXSfeL7jFD0wY87bMIZgy2gO?=
 =?us-ascii?Q?qIUhnmmFZZO7YpU8S0qB22n9klnJu9CjdrBtalQ1DWq8KR/+sAzALLGyvYBN?=
 =?us-ascii?Q?uYI0+sYmd+6B7lU+oWyqA42xJoQgoB99HJ6xtiWNDJxIxvdXkGfbhp4umXCx?=
 =?us-ascii?Q?tCGkVbkSLKhCbrFZSPS92qcd0hd1qdG+OaeyKUM2GfmnClZhhHa+ICFVVC+5?=
 =?us-ascii?Q?B/1Y0R/7NHwy+Llundlya/yt2b3br8hHab+VLAPoMAVJIUTM2P4JpmGiRR+8?=
 =?us-ascii?Q?1EgtRJoMMP7lBCfawlJhvMdGvIOoNsycLoFkXn3GDicGCMeAzgO/r82J+Xae?=
 =?us-ascii?Q?OKjuKO9U8FnyDjea24CkGLhj4tzdPURwvJDVArpouLrCGvzWjrcknvAfOob8?=
 =?us-ascii?Q?MeQiMp8kYj4RfHyXkMJ4q2t63yKJqvgft4Au0ionxwcNLXp/8OyC/WCe2w/z?=
 =?us-ascii?Q?wC6tO+OXNrspbJQf+ppFmN1Ji3slHNMOnxhNGCdPxWBNfij5b1O90YMcXdKw?=
 =?us-ascii?Q?laKXd6Pkh7rSHCZY6BNEHqMTtFoUS8SWptdesan6Vd/lDTv44kjmbaTlOKVO?=
 =?us-ascii?Q?56I8SJ/jQvmDap5aFWeZefOgX4A0gUjI5x5ZSdMUS0CShUQNZOMvs/4AN1C9?=
 =?us-ascii?Q?V1QtuerfxVJVW4cT48SDxQ0CojidWa0tB083ndz3QnWTez3xasOTELMOEr0X?=
 =?us-ascii?Q?d/RSyT3E3IsmTMwGAju+QAye56prBOTdrPdawZf6vfdnO7i+eo9dPsOh3sTp?=
 =?us-ascii?Q?FIDyYrJOEVPHuEZ32tCMe0lwifr1ZqE2aFYlz5RN125J28uJq82cGSGBjNkM?=
 =?us-ascii?Q?UfrI1JBO+XmjOXM8KCX5x8WLujb28iyiE/uPihvvyHKOjH2WM/YeZ58yCQ6p?=
 =?us-ascii?Q?uTEMQk1eenxXkpp8UOh7/gbfRKA0PZcBlp5BHluG7UMkWTCW7sVlZMToTLC7?=
 =?us-ascii?Q?syIUr8qOeja9cuubec3kcha+/G/v5s9CaXVDkXccQ1h8BbDQZuHF7pQdwn0+?=
 =?us-ascii?Q?LSbcV3msAjC46DNaNhQAXEeYD3yRz4bouFMeIqY3vjDM5X1SrKOjENe6rFWc?=
 =?us-ascii?Q?POl5Ye3tGu31n5AFt/EkEXANWGFZjfSPQmma7oW0Wf0KAaV61egGQxpzxMwa?=
 =?us-ascii?Q?CZQbr8PC94MD8eVwShPDKfBr845w9Ih9ROaTqGQpl2QwzEtJ1twXWAi9l2IM?=
 =?us-ascii?Q?Gd9hsJRsCW7i7RSH9hu5+HgSc4yRgXSQFh0gkkHofT2jnTHwZFEap6r+YmPo?=
 =?us-ascii?Q?Jg11MQZQGl+I9DMVpuETnPkkF+4M49Mp5C19pBI8uMUzC7xe+PNk+4LmNkWT?=
 =?us-ascii?Q?HA4ivtDLkN32zX+/0Xd8Bj5ILS0wDxKUvFBN2PRXpFBOtfJb5ziJFiOM2fjM?=
 =?us-ascii?Q?KuJkoOKM9TE9RtpZilHpLFLO4wKGcs+Ox1yOrbkOxSOUSHG57a5hEUHR7mb4?=
 =?us-ascii?Q?o+ENp56LdmxLbUnaBVjLbYK9HRrWGc3YmUaXZBmPgTdqrFSTEFobUBbVsQHT?=
 =?us-ascii?Q?vDMkoOaIC6oBB8++UG8AETBY2sa/m4Cd1YOw6UfuHcNHniwEeXEC4vTTYXsl?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 750f0a76-ad84-4d55-43bd-08dc6b9b9fa2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 18:05:32.4835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPAGdCiBTLeDw6JcwGrKVuj7Y4hFxqywiCuYcKUILkqOEzOiz8L7Ej7QW3wBkVYmJLW+eHXR/0TofodjFEJbKFCWhSPqCkuh6NfHfx+tqf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5894
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> User space may need to know which region, if any, maps the DPAs
> (device physical addresses) reported in a cxl_general_media or
> cxl_dram event. Since the mapping can change, the kernel provides
> this information at the time the event occurs. This informs user
> space that at event <timestamp> this <region> mapped this <DPA>
> to this <HPA>.
> 
> Add the same region info that is included in the cxl_poison trace
> event: the DPA->HPA translation, region name, and region uuid.
> 
> The new fields are inserted in the trace event and no existing
> fields are modified. If the DPA is not mapped, user will see:
> hpa=ULLONG_MAX, region="", and uuid=0
> 
> This work must be protected by dpa_rwsem & region_rwsem since
> it is looking up region mappings.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
[..]
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 03fa6d50d46f..5342755777cc 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -91,11 +91,21 @@ struct cxl_event_mem_module {
>  	u8 reserved[0x3d];
>  } __packed;
>  
> +/*
> + * General Media or DRAM Event Common Fields
> + * - provides common access to phys_addr
> + */
> +struct cxl_event_common {
> +	struct cxl_event_record_hdr hdr;
> +	__le64 phys_addr;
> +} __packed;
> +
>  union cxl_event {
>  	struct cxl_event_generic generic;
>  	struct cxl_event_gen_media gen_media;
>  	struct cxl_event_dram dram;
>  	struct cxl_event_mem_module mem_module;
> +	struct cxl_event_common common;

I think we should rename this. As I was doing one last once-over my
brain went "wait, there's no physical address in the Common Event
Record".

So at a minimum call this "media_hdr" to match the style of
cxl_event_record_hdr.

Now I say "minimum" because 'struct cxl_event_gen_media' and 'struct
cxl_event_dram' should be including that struct in their definition to
make it impossible that they have different definitions. I.e. I am not a
fan of creating a new 'struct cxl_event_media_hdr' that is only consumed
by 'union cxl_event'.

The "maximum" would be to combine these definitions into one common
flexible format to maximize shared definitions, something like the
below, but the thrash it would cause is probably on the same order as
just adding a 'struct cxl_event_media_hdr media_hdr' member to existing
'struct cxl_event_gen_media' and 'struct cxl_event_dram', fixup all the
users and call it a day,

struct cxl_event_media {
        struct cxl_event_record_hdr hdr;
        struct_group_tagged(cxl_event_media_hdr, media_hdr,
                __le64 phys_addr,
                u8 descriptor,
                u8 type,
                u8 transaction_type,
                u8 validity_flags[2],
                u8 channel,
                u8 rank,
        };
        union { 
                struct_group(general,
                        u8 device[3],
                        u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE],
                        u8 gen_reserved[46],
                );
                struct_group(media,
                        u8 nibble_mask[3],
                        u8 bank_group,
                        u8 bank,
                        u8 row[3],
                        u8 column[2],
                        u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE],
                        u8 dram_reserved[0x17],
                );
        };
} __packed;
