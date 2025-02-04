Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0720DD4B
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695459; cv=fail; b=RqX/AkEy246A5WPv76n4RgLQv/tg2payYn9fePzz4GzVSf6MlpZv1f9FwCzi56Ug8s4rWlAnqwRu3mZQGwrVJAw6uQd3TyoT31dPbTPb1t+wlHrk9037ZhhZgJLtSBO3pddUk43F7eUrTFV/fnMFR3tYv8BkFy4plBf1H2pEp4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695459; c=relaxed/simple;
	bh=jdqWBI57/UdVZepkZObUSh7fUytm2GDG9V/7PWtRqnc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V33ZI2Fm+QyCRRGQVvrDGLO9E/DOlS6QqbDAZndSgFXGynDC18wZdEU8WhXTHx6v3rRpBFKMQQek3xn3ZZTYie33I2tDqLqWG2X4xpHRwzgk6jA5DWSYcwPOT27V2K8M/teHtc2ZhEtuvQ+G6jk4oYluL6R7N4FEW5eEHVmEPL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fk4omHcS; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fk4omHcS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738695457; x=1770231457;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jdqWBI57/UdVZepkZObUSh7fUytm2GDG9V/7PWtRqnc=;
  b=fk4omHcSYbfa1weaWfMX+jy27faAbNIXZ00tN/fFghCPaSBPSttPGgSJ
   VxOPx3mbx/HUR/ECCmYiVw5e0X9VEsxem6wxxdoc+Pf1zThEhp+2PGqe9
   9JFYjEqZzNh0jZ2Z+9hnkQ6QHQPJZuS8JehPa7mmDuW+Htz1zoVeqXLT/
   bmwwY5NF6vb6SqI77IJS/XM7tLHQykou9tfNer1aT0ZoyilNvkpE7k3zK
   A+Yr4yPa0Wu3cr93UCyeQQSnoxMNmitlVelFu3lRE8gaUA178Lq7jlAQO
   Nyu2KSMmqRKh0KTXo73fepL/y8lZS9OTE24QRh51eJJ9+e7wzzZRLCgWv
   Q==;
X-CSE-ConnectionGUID: /7U38aMLTz2BL5xiuR2j6A==
X-CSE-MsgGUID: mx5HU9aWRO+/3C2glZOoHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43157074"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="43157074"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 10:57:36 -0800
X-CSE-ConnectionGUID: LcgP+dMmSn2fKgkL6Sx2Xg==
X-CSE-MsgGUID: g0GnLoRKRS2g4gBKkeAsjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115716717"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 10:57:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 10:57:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 10:57:35 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 10:57:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckFsSKOuRGxDMTFSBTygwMnkXI3lpeLd4uNX9SeWuqj0E7naqMwbqgBjlh1LtGe9+gqa7e2Vp2SU85bzK9/Cl0+NJHwP5ZBVk0yJJArDHKmyMcbamWZ5IHMTIbqHDkmP/pr59+RCgcg/kLucwO7jjtaL9K6T3ez0WqY7GSjgXpLCTeoHLp0RVT8ed4KVY0dzw0OWQBp2rDl6aRd4IKHBMgTOYcOufjBpsSxJI8PtvwSq14Qj4BY2dsTQBgWhYB9O8Qwzc17S/Qd/XDsFNyTvu3g/s69ZsTwaopVoD9DPqE7Jdg065vscP1icuWIzAirx4kBKXbbnadsNhBoFwLO8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5IESM3VyQu6ibWa7tpXBE36jqNmsaMCTWC6gHZJRDk=;
 b=Za0aL9wN4x9ofvsAdbtDrH/RKenh+opJmrgCfZmBSCHMcXA9L56hMs3gSr2ywTa/txR+s7hX6BBamHZpCHFv8qNvtW2/ii7FsCW294UOSl2RqUxlmSn74biH3eJxDbrF1yEF9gskRO61J4h4oaaMZqSSURbeZfel05BJIc+EWa5IVrn/48notLCBtmWyt1Y0p6RGN3KyCNFSlBvx4qSM7phCMvH7WBzSl266/3UqW3Aa5xKqJkhI3JvDQvXzxBp/96y1M8X6qD743tov0LQOP+iR5JJ2FDlFi/ZtGXqdYHOtsb232TrGCO/TJs4BFazkdFslQ4vmPYQO15O0dGuIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV2PR11MB5998.namprd11.prod.outlook.com (2603:10b6:408:17e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 18:57:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 18:57:32 +0000
Date: Tue, 4 Feb 2025 10:57:29 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 5/6] cxl: Kill enum cxl_decoder_mode
Message-ID: <67a26319e928c_2d2c294da@dwillia2-xfh.jf.intel.com.notmuch>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
 <173864306972.668823.3327008645125276726.stgit@dwillia2-xfh.jf.intel.com>
 <20250204122338.0000284b@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204122338.0000284b@huawei.com>
X-ClientProxiedBy: SA1P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV2PR11MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: de887a33-fa68-4309-3fcb-08dd454dc7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mGc31GaYtLeWRB+hX+rPxjj3YIdlEbJdQSrDFKQSA+hdfuSUwwD7L0X4NHFN?=
 =?us-ascii?Q?xX50BSetlcMjp0nCXCTCqP9chMGlPhAugtg0Od253LaW+3tPlFWyo6PgJtCH?=
 =?us-ascii?Q?454Zey9CeWUKFwJ5UYFIqzQVATLsFTI6FJ2zM9NLl0zGX2n9l6HxOwq73Z55?=
 =?us-ascii?Q?tTU/nbg5+QnEhrSP9lVrkniwcFQTHtbLYEixUp1nTsnFdIGKhdyQWfnrgrhY?=
 =?us-ascii?Q?9OK/Tq3jJsc7Oq4pa7o+DS3iGRDXlmIyDd8C+HwesPCznoNAnHmwODLe3MZQ?=
 =?us-ascii?Q?fU7BEwn0OG3FcIxxzKj9J4fvnqUT9BQ3e1x1HJtYBNczWwYYa26tLxpXX9jf?=
 =?us-ascii?Q?YKzTTbENDJFR0RU73oQdMyIHq2wnLN3l/ln9P+aLhUhoxhB8ODlhW1kkylOW?=
 =?us-ascii?Q?crboOvZSPd7ZcbWsf4K7VJtrSGbROJPMteU7Wbb56nHg8oC8gjGV/ZX1CgY3?=
 =?us-ascii?Q?rmOh7JO3+0hE9Qc3Sicw5ZX1ZnUx3yvIc4IIvDkxa+7kjdwIA81HaMQVThF3?=
 =?us-ascii?Q?CXuWagB8yPI9/Wj9Qms7nyuNagcdAEICd1i04zNofV7THBKoyosi+iws0JOU?=
 =?us-ascii?Q?eK/GvOZDtLXVwZvH34yttzm1GCB37TRyVtd9Ira9iufYfd1B2Iksi/PUS5Wm?=
 =?us-ascii?Q?qy3LmRhHbqHpSfexAV6G0u5AGb3DIe/mA2d7pFDADxpkgiRnw1hEfwqbvTni?=
 =?us-ascii?Q?ddmbgxJrOfj9YKN1d5tOm7IE27SCuB9+SZpf3fgR8Lb9wOAb2+wGExA6OeEL?=
 =?us-ascii?Q?ANe3XEsPYAexgxQDUdfifm5w2LKS6La4oxUxmgWI2C/6cuo2frSOfZY1ZPcd?=
 =?us-ascii?Q?zYzPdObFZSwusDxysuoyudPvRMRS0RMAp5BHcxxvxDUIKKkB6Bq941Nu67FM?=
 =?us-ascii?Q?1JhWqlKZSvmv0TjCED7pidtFHo4Mv49gmYQ5EpUuSJeJbpyoFe4ecg/WtmH4?=
 =?us-ascii?Q?cPedo8VNsiUnZ0ggEqso8dILbaYJLJ1uTwyiQiIZ9UZF9zYLbBCK8Lme2nvT?=
 =?us-ascii?Q?du06iD5WvuWzt9JKMc5C7UfOCMNND0+oZEDxjagDamkwlrFT8W4eFOpY06ZP?=
 =?us-ascii?Q?GL/3hoNJm53QQQ+nOvOR+nI7dpTwvo7B2jXqkiOL4ucgYnoCulMW6UAZccMr?=
 =?us-ascii?Q?ectzHDKxbyh5oIKmQnIUdeKnl8JLaQ9Zz/x4SNLKoio7G47fyTYQh3oeGJeP?=
 =?us-ascii?Q?wlwuUP3kdhkY102R6qcuWmorlWQjXbPXEJuPDQ7zRScxiFEQEe1v/f21sx+f?=
 =?us-ascii?Q?/ZhzALRHg1iq1eubdRBM9Wjc4cwn9jMtagyti4fzuC2r/2w4R71IBjgs2hQx?=
 =?us-ascii?Q?DefVjyA1j1gDA0lXESF21eMp7RbT52T1X54V4lqstQEEWM5mWjJWPyhuvC2j?=
 =?us-ascii?Q?uLCcsKRRSOlUdSauRuY2ZOcPzzKN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cf9EQGApi/mw1a/OkoNNN/97t/GAJFFPZOmKkcUocbnYf7i5NVC0pPM9X1DS?=
 =?us-ascii?Q?wzqoLD415adxcPeiRfi0ReSj1sOmqHLewRz5/hBjFlZrMb95IcHK54tMWmRt?=
 =?us-ascii?Q?4dTMkoGhnhk1S6evZg8xERExaByMV/lQ3YAkUlJeNfysV39iLcfB5iXL+ytf?=
 =?us-ascii?Q?8Qb93eVrcd9RgCSopbpwcyeKnSs9ECl9UaExSeX716ddtdT2oN84SKtLJV6w?=
 =?us-ascii?Q?nB/nzEqRbaPyB4Yuya6oFpAJ99tgWFIY20/Z/dxyKRk0VPNI07rIbm3R+m3l?=
 =?us-ascii?Q?tgoxXbO+o89GBjhyJvb3dK4i0GHhJcjbXGKKL3Gkra6iIm5GbNq0i2sbAfCc?=
 =?us-ascii?Q?vo/mhkqsTe9z9ZaDzMuh8ixLP6XSYLD5bYTQW2lDNKoRdtjMfS0u0eMyr5z2?=
 =?us-ascii?Q?xVd/1SI6fr8hZ7sBjtzgDhn40Fr8YMIyMNoa5qJBQwAPV7auGhinnQ/CrA3O?=
 =?us-ascii?Q?uCxw1trgg1KZ6z1V4N7Kgg94ejoj2jNyn4nb4hLGFjsr4f10cCRCP3I2lOR8?=
 =?us-ascii?Q?fHATPdt9YP6AQ0TXUC+1ukkNbzUIRZnlztXZxz/TyzLAx31wgkGrq65tOI8Q?=
 =?us-ascii?Q?bGmEp5TVolKor8xAeuwJupPOavUo1mhRzO9K6uMIMDRBF9+FF06y11y2IdO9?=
 =?us-ascii?Q?z/RCzR3OR33Fuu6H7MX7R5fcNg2LGUkSVSJq4JjotYTb9O4wdUKcZ8vasztH?=
 =?us-ascii?Q?Z1rRpxnR6XoSeOggWvg+MFEkH5Cn+NEtCMcXfrgOM9Ay+8IPV4o7s2ofIF+Q?=
 =?us-ascii?Q?ME4uWo1C9wCVtF5hulvF0Txk1iXfkQX0vw+G1JsuH+9WjIf8pMN5+5mcunvq?=
 =?us-ascii?Q?hiYRhBulh2okMbnd+2vG870PLe+xvm/JpTyNS37T6b+37Wk/SHrlyVt9wyZf?=
 =?us-ascii?Q?pKGCsK2aMHe/t4mQdCq/LPgAcnmhzUk/WwRMxN9olDO5mQwhmkE0BFjsyN9x?=
 =?us-ascii?Q?aRBg1HF/wlHhEKdQ8NE2ahAK5lvL23AU6/eR1MKpYCnv8/042ljmum0JabX4?=
 =?us-ascii?Q?NLFkDaH37SJNlmywSmkSEsjqzy8/Df1FYjJXQn/UGaVGWvno+9LuU5oZAdO2?=
 =?us-ascii?Q?zUllVyfH8BfL/wC6PM8QFbq+n7JDXRIp5MCr3jt20BLZqcKVjw2L83ImeQk6?=
 =?us-ascii?Q?YVqdyrtoZW6iKYCiF2btFR+jONQ5XDjeeruXPdesm9//9WQ+BFRPX9NHpAIW?=
 =?us-ascii?Q?87l/SRg14RACH6km4M0wprzpuzTpv/2V5QdnX/lVmvr+S/ZHPsfaEu9tJrHp?=
 =?us-ascii?Q?jYQHeWDz8CzXwMTEEI7nlP+2qSEHJtEffz0SNFbERteRWDHe6VJfghf2qGWn?=
 =?us-ascii?Q?dcmDjWrLdS7OFBt3T4H47xXpL22njjQyWIOBmkf2VOFnci3OPtZRNYnr5nf0?=
 =?us-ascii?Q?S4/1pAABRqKbnZoxwQ5UBrF6MgipnDXbmkI0CBX0NAjn8yChQW0TU2DcDHpj?=
 =?us-ascii?Q?/Frwh5/+aAsi8iTzqN5Mhit0CPQOzC0QtndpTDQVVVKUXZ1tGuRVG4+gx3AI?=
 =?us-ascii?Q?WEjSm5i4n+v9m8igZdqhmCONbHWCjLXuPssrnjWXVrRbewkYO4eGT/nV+kvq?=
 =?us-ascii?Q?UAaGLb2zlKyUObAUmXWq8AF/bF0ebzrcPkdSp0n8WEwaiQtWvrFlits72wbk?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de887a33-fa68-4309-3fcb-08dd454dc7e4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 18:57:32.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOnwFMTzRWZBe+/600sE8xNNTnxFyyv2kJmqFZ5AvL9Zrgv4ZkpvX6zYsAZNTCT0d5vSwd0rfwm7+BFrbPGy713gIumnpy0RXOMZ03HuTjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5998
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 03 Feb 2025 20:24:29 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> > tracked in the partition, and no code paths have dependencies on the
> > mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> > can be cleaned up, specifically this ambiguity on whether the operation
> > mode implied anything about the partition order.
> > 
> > Endpoint decoders simply reference their assigned partition where the
> > operational mode can be retrieved as partition mode.
> > 
> > With this in place PMEM can now be partition0 which happens today when
> > the RAM capacity size is zero. Dynamic RAM can appear above PMEM when
> > DCD arrives, etc. Code sequences that hard coded the "PMEM after RAM"
> > assumption can now just iterate partitions and consult the partition
> > mode after the fact.
> > 
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> One trivial equality check inline to tidy up otherwise nice.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[..]
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 78ecb88bad7e..d705dec1471e 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -359,7 +359,6 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> 
> > -int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> > -		     enum cxl_decoder_mode mode)
> > +int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
> > +		     enum cxl_partition_mode mode)
> >  {
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >  	struct device *dev = &cxled->cxld.dev;
> > -
> > -	switch (mode) {
> > -	case CXL_DECODER_RAM:
> > -	case CXL_DECODER_PMEM:
> > -		break;
> > -	default:
> > -		dev_dbg(dev, "unsupported mode: %d\n", mode);
> > -		return -EINVAL;
> > -	}
> > +	int part;
> >  
> >  	guard(rwsem_write)(&cxl_dpa_rwsem);
> >  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> >  		return -EBUSY;
> >  
> > -	/*
> > -	 * Only allow modes that are supported by the current partition
> > -	 * configuration
> > -	 */
> > -	if (mode == CXL_DECODER_PMEM && !cxl_pmem_size(cxlds)) {
> > -		dev_dbg(dev, "no available pmem capacity\n");
> > -		return -ENXIO;
> > +	for (part = 0; part < cxlds->nr_partitions; part++)
> > +		if (cxlds->part[part].mode == mode)
> > +			break;
> > +
> > +	if (part >= cxlds->nr_partitions) {
> 
> How would it be greater?

It would never be greater in this context, this is just a personal
coding style preference for ">=" identifying the opposite set of numbers
from "<" rather than "==".
