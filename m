Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA92114658B;
	Thu,  6 Mar 2025 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291338; cv=fail; b=Whwkgy+c2Hn01+wVTxyQQTH5+8pd1AR+hONchU0kE8Ixo2bNrt43e6LoFRdnJJtQKLcXNxumlAr0mt78luTijlyvMS3UPjJOOL1889E+bm0+2f6V+A7kgnl7b9uiJeR/ylS+Af6B31DE0hFmgseNfG6xKcZc1pH8rhdEivTiXws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291338; c=relaxed/simple;
	bh=I4gdrzkp53vjlnMhLkJ4UJBSZRNg+7JDBeNJajW1Wpo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LnASdLRnOy8iPJdBCiScPaKNNnVBSx/ntUxet6TqjdaG0gBwGBXf2p7XHAHRrgjVYuTEM/fo9UzCkcgrqOnLczBACmXNXlhktrkwgNRPvg6IjT5k+zRqfkZ1EQVIK4JLxAVQlRIBt1eEWo+50gA+a0fYX3uSoc2/+QKATM1cW3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUdUCntm; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUdUCntm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741291337; x=1772827337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I4gdrzkp53vjlnMhLkJ4UJBSZRNg+7JDBeNJajW1Wpo=;
  b=LUdUCntmtSdOAXOcF5Tq++pJIT+DmJQnv97GeS1dbVWQpNvl2sIdAggp
   x4tSAfYQ4Lse2uPw/IYaAFzX3UqEdfaherdvclKOMtx3FbA/NBeUNfmbq
   akujY6Dw6muN3Pdbe8z5mVz5vohn06uMp9t284IxJMgm+2u7Rgi8IdoMX
   pp4dK6pugaeO4F+DDtzYvRsdhE+tvjHaSP2a2nnhWcHlnpC4Pny25uIfw
   OY9ndDW0jVMkZbkm/urME6DqH1Y437Gs+evTb2wZW3I7ujRXQ2QTr/qbd
   6dstdyXh9BtKRUqMffeTdjYD/xo/aNqEmPdBlx/jxKsa+2EmNjsaJwvcO
   A==;
X-CSE-ConnectionGUID: 4YkfOSOPRwC9hvmr0fjPiw==
X-CSE-MsgGUID: Fw7MKyR4QVC9MXob8aCw3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42463428"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42463428"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:02:15 -0800
X-CSE-ConnectionGUID: th0NXwxZRy2Xwpl9KzTPLg==
X-CSE-MsgGUID: pQVjWzEXSXmL28eX5h7qVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150049261"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:02:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 6 Mar 2025 12:02:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 12:02:14 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 12:02:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6lF5DITcNNGHc2EsKPXNzlPZGNjSXdipTjs2PF9JgxjnvLuZpu9evSw868fO8gxygXwrQPaG0CjEpBzY8JE/XURLUWCbVCH2TjrApr2hR8J/l1rtfptdJ8B8Mz8S8p/T7WSCKEu8Ri6vtudkenkZg+nnhMFYcofmL93kFNLwEsJfPHby8x3PVs6yNTXds8UFOJ0LYuNbBZprnS6X+hAr0O9/48gaAK7tgBGuGHeSOrPtDs9orGrsnm4MUgM1WaJROFl6jKqSGO6XrniqFuaP/hmmvDiMqtvivWFIGwEbx5ctkoAX43uOXXt6YRtfnFR0NTitj+2Sm5XSi+WY+vvdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0b/Axrk3q0P1LrfVEML9xPMuz0/cWBCYWe84oT5c0k=;
 b=eCE/s8ZjUiapy8e+krnqUPKJt6kqW7o3sAnPLEbILHOmKOT//47Qi2zkZj3rJiIAE3zpjrqJQ2JzQ7vC9LEI7w+jHSNYQk0DfEErc8H9jy4fr9DnveyoTde9O9qyyqHS3QXMcdsUTaWDhGEFWGx4smHBax8K8Wgj1DiUgfCJv2JtNvJJSWg+cD6gDsylt4k8Tp7Hc8S5USkahZlyZq1xrlAfLdt2N5/VEU3dc5hntp6Ap3z5NPAiqc86Xso2CKYXqzkpAxJNdgKt0pDVeafL40k9YMpfy85S9SxF0UPeig4oIPsWbQ/j0t2OyFaLGoH4VT9l3hxZXS8MqlOaKL8qKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5325.namprd11.prod.outlook.com (2603:10b6:5:390::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 20:01:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:01:43 +0000
Date: Thu, 6 Mar 2025 12:01:40 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 06/14] cxl/region: Avoid duplicate call of
 cxl_find_decoder_early()
Message-ID: <67c9ff24afcbb_1a772947f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-7-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-7-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:303:b4::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5325:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b65140-a935-4fba-892d-08dd5ce9b798
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0zUgZ9MFPPNF9VrhUBoxQ/3pzp2jyrhnusRx1ytRm/7HMJ+3LjFejSZr8UlT?=
 =?us-ascii?Q?/WcFefgNezvX+E6YlTPCtMo8MqbdRP+v2E1xiMJ/qzq8J8l9n5Ee18GKtTFa?=
 =?us-ascii?Q?Qgiqr8jdbbCD5m1Y3IlmXWj7ErWcsKDFEVhXOBXEBZuDfAEkaZI1Y9ah9oeY?=
 =?us-ascii?Q?g4xGcb0c5geLOK61GL0ztWkv3+uWwlWp+iP8p6vK316mooWcwC3p/P5LHmLW?=
 =?us-ascii?Q?yY+nVx+UKUie7VAS6oQk00tUomMpgQeKGU+ovddSbnBCjWg4aYfnOGijNkJ2?=
 =?us-ascii?Q?T0Mg/nGhdxO5KdbBn/hWhx+1eHh46WIvI7Gkfu120I1r+Zmwrisk1qjQU9Sz?=
 =?us-ascii?Q?7xt8/2S6DJ0ifWOxRzCqFxQH8bEY8J07y2a792SoSrSPMmezL139VXacCcnB?=
 =?us-ascii?Q?yA8h0pRsKvUMeUaCVYC5EnHVlK1km8HkOh2tCVSJbLZa61NHZU2uK561JMJh?=
 =?us-ascii?Q?sRbVA18dxJbrBKMpy3kiwZxcJvrRml96gbhXxizBPcLOd4vB7rS4P/er7SCv?=
 =?us-ascii?Q?saEx0wRHRXgiv3EkAEoW9wFd6RdD8l5PSVzRrwrlR/L4DNPA3p/QNCiuoBD/?=
 =?us-ascii?Q?6gsn0T0ng6qWflwf1/Ymo+oX7UtwilCfR4AKIeeF+40uPiIxWmkg4spjOlPK?=
 =?us-ascii?Q?z0IfDqXVYdbFven/o92UFo9ihxQJZezN7m6ta6Dzm8NTK2xLs31Nw36S/S3E?=
 =?us-ascii?Q?Zpdu8JSQUX9ZrTW17PGz373601taoydsKapc0iUSGSSvcdsWyMXhK63YmOIh?=
 =?us-ascii?Q?OiY/wUF2oiKaCUzHfJ89crr5LiUQoQ2YQMkls43hK27Cw7mggBUaFUio3yZS?=
 =?us-ascii?Q?bRRevunqSbTM9+aGJmPk4LUou0AV8ojV1siBmJqF3C+B5066qj856ADumm0L?=
 =?us-ascii?Q?PYKiYVvKbT+k+WExZ9Igy9PZHBf3VCq12R7dTtK8drBh+9fEstB2vIZAhllD?=
 =?us-ascii?Q?bSzD3WbAI7bQI9K061IkO0BjmFdrg18i/x/j9xNoi/y9lPM+ofiCUs+Zki10?=
 =?us-ascii?Q?8M62WNWYafxwMWZLesRBTgNFCWapgES7TNGYVQp3oAbRXJ3LUwAvPU2N2DOn?=
 =?us-ascii?Q?jg9zWSNAA4crPSffDFtshdjZCKNIThPaFZRQd5aLxpdAnSctt/Vqlf1EGg8s?=
 =?us-ascii?Q?xoFPepSgS7Y6JLkt13rRy61Z+Qid6l039qIcCvBsoddTCmmkquKw0nlroJQT?=
 =?us-ascii?Q?rPE/+MiVl70Q46pAcVcuif0uhQEmE9Qh4xH1TiHf8VHbpmpg9VprdCwR1kd7?=
 =?us-ascii?Q?a8peMDT/Dkiq1hKlPE/wNjotzxie1JJn0AOo6lsEy26rdplcP4PpdRq+nns7?=
 =?us-ascii?Q?7DbovETTqPzQYvdRcgopM31AEStFP+Y6P7bJs3i3JgBsiMRaCj96tbItBMvW?=
 =?us-ascii?Q?MWMisTesVHMoGubvvl6Lr4p/E0z1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CGIrKz2hu5W1Q7JrOoriIU8kU5ceZ0n4+Q+C38QxCQxJkXww9jD85HdKHSKe?=
 =?us-ascii?Q?YYvlnTnVoB4LVtBF9MQADpgDCKle+IDtybBJf7cRvHWfnXHsEsiJHLoPVlVS?=
 =?us-ascii?Q?UUHaq88GARh7AHFKpcvbas5l8Sx5EqEnkfM0aExgirm+Tq1t1xZC70w1OAAG?=
 =?us-ascii?Q?DmO9u85zq/9tnMSV6LxqTiExV5FDz5eRJyxVUExYrCj2RwTkm266mekPMdty?=
 =?us-ascii?Q?T6oOpoqWbrn1lmDD4ZUIYecFfVcKjQ/M3oUfmBjE7Gf8fAGQjFYUHX50PSey?=
 =?us-ascii?Q?BiWBn4V5gnOmATl8dRdHkZmGNekO9RFk2RAo0XezPpgXsR3BMwdqtB2DDUbx?=
 =?us-ascii?Q?N+6FzIBGPN/1kliiOky8rU//Zco6S4xT1CIjlCFAMF4g7dDUCqIHo1wmgp1A?=
 =?us-ascii?Q?dpEGtrd/ZG/FSKJszlnXv0ZT+8KA9bty2bgg3KgcCgAMXZtP5iFZ1n6f1miX?=
 =?us-ascii?Q?9iNpeGNFOD9Ha5KIXqMiXJ+vwAoxGa7QNdBH5yBDTEjCPSaaqdCX7mSjiofv?=
 =?us-ascii?Q?0Y/cN10iJT7wRBgKus5DkydLUCpDwqw9wA36Ufsk+GNEWPGbJUrxZM3pkUDd?=
 =?us-ascii?Q?qzrFoH4lwCs0/s2Y//0+hRmYdixEgHoWBZpQ1GvE4q8VTsOdDeEDcQ2cvUVu?=
 =?us-ascii?Q?saZiOHuIsL8MLmq0IXzWqX13jc55oEroaukLXGxS9tpGKitvQ6eGGYx5boaR?=
 =?us-ascii?Q?mHDRXkDkLCApxkfXVX4BYxtymHCFJ8yNhFf4c1SrwzaexeUxsojd5fGp+/u8?=
 =?us-ascii?Q?YGlvH45PQjwftGXFonI1cCc11y+KH2txmH4dGl7bq/P2VhfNh6QwasVAmVxS?=
 =?us-ascii?Q?rn8DJDwM5Ee4uWHVGJDi979FqvVxT1EQJ55J77cxxvYbd/XhCnwbumdUzr4P?=
 =?us-ascii?Q?pN6VajQFljmsO6p5/8GBLEg0Sb/f3AuS2+zwUKqjYltVgxzOIHqAYjbT+Rbe?=
 =?us-ascii?Q?o2YDieaOVGPdYOh4bkavPwplekHNmMhW0fSqmesnDaaNWbgG7s0hRu7o1p8k?=
 =?us-ascii?Q?HzGaQaCCaY84mLTdQZmtm2Z1wcH2lxtmtNSG9JzXyfzR7yIPUc9QtRyZvbOb?=
 =?us-ascii?Q?o/SyX4N1QYo49EDp8AQC040wKVbcEUv1YiITWSdpvP48TEq9MeSTKC0xVtS9?=
 =?us-ascii?Q?y4ChzUsjq44TamvFuukw9pF3u6jKte8oinCoC/NOf3SHECeVsh2kriWLDlPn?=
 =?us-ascii?Q?IhpJ87vJrRDsDUzQssKJvKslEMQ7jXIYVBgEFhn3NKmaFrsFxtrl/jCbXmGM?=
 =?us-ascii?Q?OE8Hstly0/FA3y8sWolDyY2W+8gGDH+nOweexMv8JVgkEBm8wy6ZFIm0Cpvr?=
 =?us-ascii?Q?mllPMBt4sT4dX3UCLHL6dtFVMRKKULJWMcmWTQvBxkgvng0YUuw4rnmUKOOV?=
 =?us-ascii?Q?syysqSIExuduNR68r7+vS6PBYsTfLbe89Pnt0xzwP87Nz6OtHjcEFVokpWQC?=
 =?us-ascii?Q?PoHN1SmL4gcHpbrNb3dEj4NiInPc6z119358lSFFcj1R1mg4f5iI6dDgIg4y?=
 =?us-ascii?Q?8qu2VNwmwWFf1RRiIskYpfiir3RV7WydVIMKXqF9XXOt65eIVtrvZWqWisSG?=
 =?us-ascii?Q?tpKxJ5zwbGcaUoBsVr/i46lc/wpzNkDSicZA9MwDRKGgvOM0NN2H8DrA8t7N?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b65140-a935-4fba-892d-08dd5ce9b798
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:01:43.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nR3DRpBF2dQ7EzldaJeSC1DattDtEaoVtcI7O+yUEJDxvCbXSSaDBn5TXe2AiNufAgg/tX1PgxoBlXxNrpLf2Yaq7BFRMfZ1LlhKT3EERgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5325
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Function cxl_find_decoder_early() is called twice, in
> alloc_region_ref() and cxl_rr_alloc_decoder(). Both functions are
> subsequently called from cxl_port_attach_region(). Make the decoder a
> function argument to both which avoids a duplicate call of
> cxl_find_decoder_early().
> 
> Moving the call out of alloc_region_ref() also moves it out of the
> xa_for_each() loop in there. Now, cxld is determined no longer only
> for each auto-generated region, but now once for all regions
> regardless of auto-generated or not. This is fine as the cxld argument
> is needed for all regions in cxl_rr_alloc_decoder() and an error would
> be returned otherwise anyway. So it is better to determine the decoder
> in front of all this and fail early if missing instead of running
> through all that code with multiple calls of cxl_find_decoder_early().
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)

The change of order makes some sense, but now none of the naming makes
any sense.

So, if you pickup the cxl_port_pick_region_decoder() rename, that
implies an allocation. Then it follows that cxl_rr_alloc_decoder()
should be renamed to something like cxl_rr_assign_decoder(), because the
"alloc" was what cxl_region_find_decoder() was doing in that function.

That also would imply that cxl_rr_assign_decoder() cannot fail if all
the allocation work is done ahead of time.
