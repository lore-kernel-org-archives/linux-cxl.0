Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4A1BDEF
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664878; cv=fail; b=fcQFXMhOpUj1Mv+IQr+vETJVegeQJN/Y3aR3aXqBSTUohR4BazOoYIyJVkyz3r2W+nj2MQ05kk9iEAeaO/ggOOdyB5WeBV6P2MJ5uL6mAin6jxueCA9yTFVEg/8jEQqWHj+8Lb2mvV6ioAtp6XL4RCSCHL8vzM80qU2MLrz7WZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664878; c=relaxed/simple;
	bh=9b8nnNpYl2K+YMKT2R72dt9TBdNkQa5GeYkxwmLAiTc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FDsgvoA71gTc73y5kIVDi2uFWf3kJg+zy/0fne2+hzHx4xdyAzFvrxxU+1qauMRxA/W8xlrC3sUJsl7xtLEM05enauQfSv3TtP1lffRm6rJmA0LDBCd6sIHC04YtzBsUKbDp1aVCCwscgzGbC+lVulAJ0RCWyaM8TwB2mNjPRTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=caUJ3s+n; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caUJ3s+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718664877; x=1750200877;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9b8nnNpYl2K+YMKT2R72dt9TBdNkQa5GeYkxwmLAiTc=;
  b=caUJ3s+nYyFyxbl3CBe3fStddRQHKVdyP1e+HzF0Zyy5CFB4WM02dnAG
   wUC0N2ziFKRBQEH6V4YdpPyiVLH78yIJ22akOU7VMHSp97rLQlXqlxsvZ
   1wALMmks8rOn5MqWEAmfhNt4HMu5MeI2JrG4bdD+S87gaAMG+Vuky6dXm
   NDlXOSTbYJIIcXXD1Pb51KvGBAAZOKN2fDKFpPoLuYiV5KXZG/kRkFFiL
   MaE/HuGuzMcIX16xooyQ1L80Qdes1U8sCbtRulyo+uTI/u5GL5lxnHxBB
   gbwr5xyGIiI3c38ljEZPrLaTD5KUTvfFEQ1djwVB9zSNMkVXeA1DM8hOd
   Q==;
X-CSE-ConnectionGUID: I6ffj1o+TGyJtZd1yectOg==
X-CSE-MsgGUID: wmxVQ9bdQPuORQHjrEBVaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15385700"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15385700"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 15:54:36 -0700
X-CSE-ConnectionGUID: iwb4A1bVQgaOhQ4gGdODhw==
X-CSE-MsgGUID: AsRkOyx9TFa2DI+gCUe12g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="46286507"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 15:54:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 15:54:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 15:54:35 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 15:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C46SIZqo3NAaz044I/UFOW64u/UtNfyUZHzuaiqibE7Vt/fC5MjXIvTXy0iR1YluT91kE6nGK9IK1110/6bnOjjG/ouhqA+UO2DblHspsd3myWq/g0QgJL3Zzawnxcqpy8CONKuXwGCT0ARiJM6oW6YIgP4bWymnErwjqBXbg4OlWLWF7VWMvzn50/+fO6Cd/UyTQdigvutHp20MfdcOJC8In26sigC90Pi8xacrzhobxh8p9SpITgGsrs9KToFBaxHVYERgP5ep2KvBDSp8+ZWc088cUswKylqEsAG/0i2G0zAZHKpdihUJRO/1R+SUegtU0vRfXwvedR1QaNie6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QM/zC/FNVp1tOVSQVUmbM+y/gQbEgdpwx+nxj5HGfho=;
 b=Z7higMuF9LnLufXPL5nPeLYFIBsBUccKvBaWeUopTNNlA111YbaRNer22IV3ZxtCtCCWeLoWzL/sy6YRYA1PUWQAFINTdV/uqUV1PZGsz77XZ6tf67nHdEzHdeUnnlb/ul/7eJvcMbWd4egrcg4VFZv12IonQdTw6p3iwhgC68fM1wRo4rxYG9euT9DiwNj02yCyekcD1odYnPqUhj8sbCsvLA/5di5TS5GfmEU2NnZGPzqqRyAvvt+zgz/9vIK43sZQsLqDrCFV+cRncl11munqTsynjZLH7CCbC8pzN3lYyxV6h9f6ZZ9hsH1lPZ67LgaexjZXAE6Rcz2LErMTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 22:54:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Mon, 17 Jun 2024
 22:54:33 +0000
Date: Mon, 17 Jun 2024 15:54:31 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Adam Manzanares <a.manzanares@samsung.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Message-ID: <6670bea716fde_310129436@dwillia2-xfh.jf.intel.com.notmuch>
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
 <CGME20240617165830uscas1p12e867fc6ad52fa7cfa32955f3150dd6f@uscas1p1.samsung.com>
 <ZnBrA-tUc9sWCUYR@sjvm-adma01.eng.stellus.in>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZnBrA-tUc9sWCUYR@sjvm-adma01.eng.stellus.in>
X-ClientProxiedBy: MW4PR04CA0344.namprd04.prod.outlook.com
 (2603:10b6:303:8a::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: c42585f6-48ab-43df-e63f-08dc8f207461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QypEaGq/RhfEG3NNzC8TVDdSSvTdwl0pLf3bqjXZJGOGuxJ5sBkOqLJGw0gu?=
 =?us-ascii?Q?wE92armrVG6oZqrIzufR/w3BRNR0GMVVSAW3BC5J7jz43e+yJp+Ucpke+eBr?=
 =?us-ascii?Q?M4kv3SCvKGSF4+eY3u0VrIDfDhQQ5O/ogt0/WrnJSmCDKonl/nig0UU5DyHF?=
 =?us-ascii?Q?kQzzsntNTB9JQaxa/1YdwLL/DhZPGBQTeViIYHGl2iHJGuHWDy5T54EjWeqE?=
 =?us-ascii?Q?OyPQqOmQzTitYJOrPZTkrtr0xtDRueHaSxood0dmF16hbOB2+D9SmlEih9xg?=
 =?us-ascii?Q?Vws37fjZIRErFdo8ICrTLVrpMZ+Cdc95sK6+G0qxGX3R5+ioSCqfvJDUEn/o?=
 =?us-ascii?Q?toCAzbj7xkVxne6ZpkuPcKa0b/EDH/0aooPetePJsTP0AvTRDoAtkI34F/+l?=
 =?us-ascii?Q?OjzUg0TOqu0VZDCxat4qhgek+zKI/XDSTM+3lG4lAzv8ubs2SqjV2SczYbab?=
 =?us-ascii?Q?Sg+mggSQcWkoSca6tJmQqco/oJ0wzVt8UbAC0fA7csL9epEorpuT23KwyIIm?=
 =?us-ascii?Q?Uwe19zxQPAkJudGWbj+nreewOsEI7MddlOQJzsbfIsUCI54Y3FCyMyGP1TqH?=
 =?us-ascii?Q?/Q58qZGqMkJcVuKAGZIaOsDEpzl+IYhHC4nGPk/jojhXJg0XeC7uQwZKW8t/?=
 =?us-ascii?Q?FupBrqz12bW22pXOpsGHH22idIHSZq7Zuk7JGm221T/ToRAtex++dynjax8h?=
 =?us-ascii?Q?Zz0wYzYEm9e1fRSwxUZP3MA+mlFKCyPKAeDIBsZ45MGPXntOH6Ysuxbcbjbe?=
 =?us-ascii?Q?RclDr64cf5h7wMvfT5YrA2UGRDEdOF9As3J0guSev6SGdxpmYHAP+cTUL36G?=
 =?us-ascii?Q?ZBeb2Af/fgXEinXGjfl02MUCdXzaSyoI9DB3NIMVcRSbawbnbPA+WjOuB3xC?=
 =?us-ascii?Q?zXOKepfCe6nDDDESh1AHwxL+15ZZvZILFbqocIJkNY53wmFjoWfU8l0aGnhS?=
 =?us-ascii?Q?h9RaNjiDmdrQ4whWCQSi+emg2CYw9X87L52oF6GpHyeP+fKBvyxU97hoxGce?=
 =?us-ascii?Q?B0CCjvZl89A72Dkvd9nx8J8gjlq9bkfxQujUVZ2x/T13dNZZYky5fUCvUKSS?=
 =?us-ascii?Q?JBizkw2uyXsHEAY/SqdGXGWJA1vcq18saPEFIq0CSxMckNN83bnUij/BkS8g?=
 =?us-ascii?Q?uoHTmQLqaBeebKKtVyori0uFgIoJO/zuRJA2DfWmXOh6XiYDbXsdtB2e54g3?=
 =?us-ascii?Q?fZBujnAokERo01AM5bxoCG1ZxZGHYHieion5ZoCp10qell8+8u11fPAyuLnW?=
 =?us-ascii?Q?C2YtTuKKRBCDWI4qQjh1L2QFYwD4Qsfh92yHZbNd5xWFlZ3jWuIYNnMKoIey?=
 =?us-ascii?Q?lkBKTtUSv2UkZO/EvGfA0xy7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SkIg4NXGE//MQp/i9CCTFY6UFE1lS/2MdIHUjwQdWyxTnkKNziWaNFZyHsnv?=
 =?us-ascii?Q?PGvlvOOS6TCEhu0NKX0aqEUdmO+oQ9sZzV9NKDCaWsc+wPpc1TSZxMd7dINo?=
 =?us-ascii?Q?M1xpShlbkajO8Gy2Sk5KtNBylU4r8tRZnjcpZ6y0TwN0WART3kKAwTRhMVzm?=
 =?us-ascii?Q?e2IYmaPtQQ0u5HtsMjXb3dW8t78+LasEEOZUDA5IpZmJbOthe15Y5GZ3+xs8?=
 =?us-ascii?Q?UzTriu/I2EaxEdHLFrSilHF9fyrxHG5O7KItE92Prma7zzGYpcXu8xouLoY+?=
 =?us-ascii?Q?FnKjIIHf/ngmvnSeRPDpmbTkT0MURtdM6BDvczOW8Eor7by9cx9VGXjDyIYw?=
 =?us-ascii?Q?+NYKHDqYZmaGa+UlfwBa+DZd3jhioSRYrkBvyY7PEXQdj9tAZ167iQNeDElM?=
 =?us-ascii?Q?+tNGYY9gF5G+UM4TFZJcown3e9E8xfOi7EcOj4G/vFJ92wu9oyAK1Vw5QfFk?=
 =?us-ascii?Q?2JvQArTMRkivo/WiwlyFk0ZHLA4kHt+XP3YICbEOgLJu96/NGvt39ND4UTN1?=
 =?us-ascii?Q?9Ij7FNhBWdHtci9B3ytuvBypB0+8zTIRBNkcrHh8yQYdG3KrqLjWiHEVZ6z9?=
 =?us-ascii?Q?BWar0cQczHUcLQXI+B/rITka3VRAYH80asYcDupAk6CwVhN0EnWZEYQ1xKrr?=
 =?us-ascii?Q?jQljISGA58eX60fWtRT5EsoAQlaGUfherpTMR73fKPdkAn7tp1PJTuHzHZmN?=
 =?us-ascii?Q?IKRjmtV6GU3pixj9BsHP3ns1vxR62UpXnBKqQVI8/vwhKTkMTFNn4SP1IrJ1?=
 =?us-ascii?Q?37//pqTF4wjevFL30R/do3SJmjVJ9lKbaQkPuRFssNOnaNb//Ot12uDBy+kb?=
 =?us-ascii?Q?2L38yecy8oxsApMGBXGSB0vOS3fGAxG0Dqi9WQj3arUmRALJbxUqAKo1O25G?=
 =?us-ascii?Q?44UTQkTXlfWcVgc5PK9E9JIyyXxfGcrw6Iqlfvq7vVYpElTG1Gi7U4WVXdP6?=
 =?us-ascii?Q?yj8XBW3YgiXHBTVd812RrZimnwllIqiJmX3H58LvfyQXHMzn9wfRVQA8ILwC?=
 =?us-ascii?Q?FUHfN5ggcpYRVC7j9AXVCxNKwBDpKsh18x18cIFT9NaT/13xn1ZJOdFv4gUs?=
 =?us-ascii?Q?XS5POaY0g6BKiCgjYOo+0mFg24a1jBlN4oiinIPXSPnCT35H4vRVmi09ZYOj?=
 =?us-ascii?Q?seZNdgXqGvErr4I4IULRaBSFLYKN2J1zLCdUuO1On9MvlGzb1bY/wxMWhco6?=
 =?us-ascii?Q?Gi103ls6M5eL+gzm38sCy8svonH6M8AuTZGqb942PvM7WJdr3YZXi2UkzFup?=
 =?us-ascii?Q?Cjge+7PAQBRRq7yU4gxsxQMudpFZGvUR1WgFBAhdIt6JPeiAsedn29vE2WJ2?=
 =?us-ascii?Q?cLarZJdP7eqaRxega4ZuDuC3M8ZU6CKlAJwboBUy01R4lyOkuvOijZjdwBms?=
 =?us-ascii?Q?Wn6l5qG8tYhj/Y0qlUrvzFeqBXGx+Oz+HUwVCZOaMjQJeN+XBcqW2c0lnlnX?=
 =?us-ascii?Q?C+OwLOxAD2AIZ5uVvHPMJUtsHai2u880CZopYmCTKkZSrvRIRU9EeBUc2wSP?=
 =?us-ascii?Q?jMjPAlgcc0pZo3kRedrSlnNF4IGC9zWmm2KLutL7rXHf4cd6mrdAxOnZGDhV?=
 =?us-ascii?Q?PUvbBUtWPYErjQjHlKEU9EzUW1Onghg6QIW9lTIheyiySkF1Lyq0UT+Oj9lQ?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c42585f6-48ab-43df-e63f-08dc8f207461
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:54:33.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPEYq7NReWUCpr/9zrVmmbw4xDTOy729F+BprbJ98mLORjL1jEiLsEvB4R2Nl4cM7COkCMoceKZGO2FEb46qDCDvn2hf93XqfLulypc2gio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028
X-OriginatorOrg: intel.com

Adam Manzanares wrote:
> On Fri, May 24, 2024 at 05:53:49PM -0700, Dan Williams wrote:
> > Provide a survey of the work-in-progress maturity (implementation
> > status) of various aspects of the CXL subsystem.
> > 
> > Clarify that in addition to ongoing upkeep relative to specification
> > updates, there are some long running themes in the driver that respond
> > to the discovery of new corner cases (bugs) and new use cases (feature
> > extensions).
> > 
> > The primary audience is distribution maintainers, but it also serves as
> > a guide for kernel developers to understand what aspects of the CXL
> > subsystem need more help. It is a landing page to document ongoing
> > progress, and a guide to discern exposure to work-in-progress features.
> > 
[..]
> > +- [0] Known gap: Feature is on a medium to long term horizon to
> > +  implement.  If the specification has a feature that does even have a '0'
> 
> s/that does even have/that does not even have

got it.

[..]
> > +Mailbox commands
> > +----------------
> > +
> > +* [3] Firmware update
> > +* [3] Health / Alerts
> > +* [1] :ref:`Background commands <background-commands>`
> > +* [3] Santization
> 
> s/Santization/Sanitation

Hmm, no, "sanitation" appears nowhere in the spec.
