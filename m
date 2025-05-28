Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADDB35947;
	Wed, 28 May 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445807; cv=fail; b=AAjWZuAS37UbrbgSvoItclshBirDlBjNIgMnwZGC5jvbVutAeafKw1x4ozwCRQ8yf2+48YtYR6BTGzzyASh9VxM3rW0zm6cRTlrLZ5BwrgK/Kr+idwku/gZtDiU3QWG3dfvf7128ZNhVRjMpccry7kijAOkukdmHG1VTM3lViYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445807; c=relaxed/simple;
	bh=2tuzlxWDkpT5Hn275OOOUT1zMVbkMBB9qzMPMpZo/XI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JpJbrOsIC+no6rLaZ6Id9OI+rWD0xV/qZcLS5r1cIHN+3BC2+dR9YO9n/7e9aGa5t6huNHbz+6BiUlkUJbyfGkuLG4jZII0OqiXopeedimB0OHT1bnm12d5nv1kjVxyJ0e5/0YnRMAtWk1ADb7oy0v9DF6RANlTxAwBoTfw80kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XcYhzudc; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcYhzudc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748445805; x=1779981805;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2tuzlxWDkpT5Hn275OOOUT1zMVbkMBB9qzMPMpZo/XI=;
  b=XcYhzudcADingZoYz8KCGhF6t8L83FncNBQAA9QaJnTqE7G/uYYhbwzb
   IHjif9Y610rMi4H8Ws5xivs1yDpW00OV1t0gd0gwvf9NonvDZXTzWS+0u
   yfc2HykdL1gQBKfTsDrhzhE2mkz+yRIVO/CNDQ4zZ4DzEx+yrwcDTdLY/
   awTS34MBqJZZxm+3g4PhuiqmnlIRaool57kpKj9VN6ETK+ndJr9L2zH23
   Ojyrxs1UqnEuJNV/A6h+jdz+iri7UcsAtn8NYxJNa4osC/9UQeTCP1WRE
   vzeStyIP8FRTRrfvLOJVhrc0QCeMLL+S6gXV0ROqe0W715jqwGZJis28O
   g==;
X-CSE-ConnectionGUID: 9emOmpViRkiiQL8awrdHwQ==
X-CSE-MsgGUID: 9gqyUo7GSaG08FGJauLVyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61109577"
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="61109577"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:23:14 -0700
X-CSE-ConnectionGUID: BPzc3aVrT++j76el2kSL2A==
X-CSE-MsgGUID: jtA08U6yRwivnX2/xA4vZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,321,1739865600"; 
   d="scan'208";a="143251952"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 08:23:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 08:23:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 08:23:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.71)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 08:23:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWGgv+YMxsToFSgCT+RTani0EO3LR0zIvTogvjK6YLT3/VZ/U4hj5gUBHubYvUyfckigNNdI1QqQUL4o4ERfAc/LnyJoXvwQHk3KY7zrCm9THF0ToHvXJZ1+sThvX8xr3DjZAFrtKe9oTHiZ+3tk2+aRL2visDwkcFMUuvhGJGvdfMkYD0g8o+8bqdZekdWHEtRPkeep+jJC4p/sm+64a3ALYlK8fW9LeefkHzxvtiOrY3YLSVmiJ5SdYS0BhlJGcoK8Hnh9yDEQnbdGsGI0rg88yQrUwuC6fV1CiJ5BphJHv567D4+hvLwEwu/KYuF4L6ChYFE1GwXgUn93P1a+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGSUis9mK5T671C7ZEdAtFaAm1fh3G1pDD1R4U7kb5c=;
 b=F1LkDx+ieF6DLY4Jw164LY2Q3z5XZpBWsLkEgdRq+ZQ5qIl2uTvP2kIPAK/KWsK8VLEaEAgzwJVPMPvV8WiFRoB/zi2DWXvFRSjaGURyAAZ5KLZa1CnQsb/W6FSERNMyeOellMFkuHi6lxqDzeLrxOtvay0qFxDwG5XUlI/1pnecIkA3fB8HbgEl3hLZ4AVqmbwSwyUf8LYoTQ39gtWY7WYN2FLv1np+dHQNfd1qwtczrzL5AMYg4NTdwRbvEeMllW4qN3EbgwBn8OTqFK9iBKivZsBRcPP0A9yltuXZg7t4AH5rwSxU6qPy+tLd70kMc+7eesw4F/tgGoR65t35lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by MW5PR11MB5809.namprd11.prod.outlook.com (2603:10b6:303:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 28 May
 2025 15:22:39 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 15:22:39 +0000
Date: Wed, 28 May 2025 08:22:35 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiju Jose <shiju.jose@huawei.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, Fan Ni
	<fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH next] cxl: fix return value in
 cxlctl_validate_set_features()
Message-ID: <aDcqO5hlGrRXzIPT@aschofie-mobl2.lan>
References: <aDbFPSCujpJLY1if@stanley.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aDbFPSCujpJLY1if@stanley.mountain>
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|MW5PR11MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: e3064544-a4d6-48f7-f0b5-08dd9dfb7b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T7u/vHUZBb2YjRTxhS6X+98MmtwBvCxcJWL+JJPPNG2+SXrZr26OyhgvcHO0?=
 =?us-ascii?Q?U75+2SPw+tlORNnf9jQ3j4dhI7ZPwRdw2qBexFxjVkf3Z8FLhbXhsDPCfyf3?=
 =?us-ascii?Q?KkZdX13lP2x+fH+FsJl4bYDkxD+wJFpKqXVEphKoWniValQAIqqE2NVrZNGx?=
 =?us-ascii?Q?OJNxkLeIdDce4LEdAq5xBbzBnUSToYLT/tRzf0610fzgG1F7pahfXZZIonhs?=
 =?us-ascii?Q?Va4q1w+po89zyC2Lnt0cb7alVneNHsHvXenahzaSRCYfis5M811HMNfpdI29?=
 =?us-ascii?Q?wLc6La6K04GBO28cl6fq99kjboicnboyGzcSVJALzHMmDIdoqBIGozcI5Wx0?=
 =?us-ascii?Q?GqTqYtSAT5wh67eOEcKorduxsTjGkWwfYWm1gSWaZ7MtWVGWsgeG482NsTev?=
 =?us-ascii?Q?5VcUU94XxRy9WV2DUmm4swR8LbXMns8m8Dk9gf+ghPf2msaItdrxmNBDof0b?=
 =?us-ascii?Q?+a/+elspKzWcbrykkw1lLapUpmOSy4ou1iuB/1o964lskSKt5UlqcDxNVFLb?=
 =?us-ascii?Q?KQmojF6meKa9fN5qsTxy3FR7BAmB8keq+tVsL3xL8IeL9EFe3Xx5JFmoie0X?=
 =?us-ascii?Q?vT052O8N2oouEfddVf41fbHyb1xGR5OHR+balxTkEiMvp1FpnFVelywUIwVl?=
 =?us-ascii?Q?Q/gI2oi9hcM8lcQbphJ6l/bcErPqWsrxLN0TdUKe1E/WA6O+kC+0Qw0QOCn9?=
 =?us-ascii?Q?zAqRowrkL3yEMWL8i6DEZzYI19c61RuhWsvgDxZ93p30vnHVfQPXRQbPgOK0?=
 =?us-ascii?Q?JrwPIFucYFYRp1JDaKHKfDUANymq1v7BNfsgaJLP8mDJAT9RBi9ip3SY2YAh?=
 =?us-ascii?Q?0zhunx8uGnWDj1Xw84p/nM5kq5NzxCR+O/1FH5APvsEupkNTPZdmh5BtkEnd?=
 =?us-ascii?Q?+qD62j7XeLjhIZXvUwI4zuaI9dQyeHfr5fKMyw4InoVWMktp88h7DakkdYmX?=
 =?us-ascii?Q?mtV3N0w17PRHvi3UUixE7lbF95OjzRJVMVC5m1LnUoJllX1DD0W+z/wqtqdU?=
 =?us-ascii?Q?LlQK1C9I5WMiEoLPF8yQ3o6uQSpklettPxbauZKWD1xz+kuofjpv+b3ObMlP?=
 =?us-ascii?Q?viMCEjhEFiyq27WTPsxzf/KpBZNOxo2rMC1ksjvqn/D2zMlvmeKlHbYSoKVi?=
 =?us-ascii?Q?ZWMLnu8f75rPFraVjflXbTHJFbItH895q6Zz8dXYi8muiGusvJq8mmLZr/Is?=
 =?us-ascii?Q?xYChRRFaWxO508zS74ZLVtZhQJ009TeauZiXgJ1vTLm3upYx0lwo5QJcDeHn?=
 =?us-ascii?Q?3/E7J8Hy/CGvZ0ycLRJpoyhJ1vlzlhPrp7qBMLAlpDBki23vpqn8p33pgzka?=
 =?us-ascii?Q?9PULOqtVWt3c7esZEe/qt4BOT5ISrpnvLvFqPUvPOOAmEekHGC+fGXFdFSdH?=
 =?us-ascii?Q?GB+2/xghHq22Vp5/gzwKKQ8OwGQOxY3OhEFOOuyAGUHQPOFnScOHY7jiwH0S?=
 =?us-ascii?Q?/5U9Z35JTiY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3kKMYDAk9dpilV4+HJU3iI8rnwyAlPAGYYrtJGysglCh4HkU+/NjryiL9P6z?=
 =?us-ascii?Q?zY6yzSbY+ZR/SaIs7xPpYcUlY8gdA93L5Xwf1Qo0gxaMGfAUsRpkwNXpN9xo?=
 =?us-ascii?Q?fhqawzXB45FqeYp9JWo32ycNHi1qhLD3ayza3nG5VV/7zOkZ40McRxt0C7hr?=
 =?us-ascii?Q?0pltYy0avJ1v9DHr++DstVA+8/2aXWESHYDwJRGKdt++0R0+SqUw+WGNFxiS?=
 =?us-ascii?Q?LLLxZ/E8oJZtMfCt3nW005SWEDTVVfwmaz94Xzorm634kk6lpZT+zdKGtDDr?=
 =?us-ascii?Q?uUC121Ru7QU+NX7T3MNt7KeYTRjPFzgpdn4jIFgyeNALIDS3mcNg9U0/625S?=
 =?us-ascii?Q?UHMB3WfmuJfgjxqGK40fIb9WOdzhZzLyTiRl4KRHYzFyPX8g4Fqp/nNHjND2?=
 =?us-ascii?Q?tSp4tiu7mpuJqbiKSddKdHypNZ4mYxlaZ2eliRM2TdAJ0Kk6muqBlq76eW3Y?=
 =?us-ascii?Q?Yrv5+eYcsBCAMtzeOzaSsDZfUcZNtH3c1djsUNY3z5vpiouhKWXZs1z7JozH?=
 =?us-ascii?Q?kn19j4SFoP3RAys5AQmeIy0H9cCdhiTmwm/xF3hvUtZPgnV+jvVR4xytqmIN?=
 =?us-ascii?Q?0lT4/LUE0O/MV8J4bPL741KffrneKGyX6jImVo7Tij49w3TJDfny6Gr3NCwX?=
 =?us-ascii?Q?ta177j7oloveKebC9HV76B0nD3naCRkLEGrjCBMzYP8BoBQJeaiHjI4D3uVv?=
 =?us-ascii?Q?5xaPM4Y/PQ8NSKw9S7dVnoLPs/640+oxerW7BznnDxqc70AkO3m2My2rBJ2A?=
 =?us-ascii?Q?cd/BKLTPYG25UcYUqWOOgE8SMi7aPgaGT7qtg01nlGrSxG+lEEXi73F1mrR3?=
 =?us-ascii?Q?2AwvSjYcupuceyiVIsiYFHbZ1CCSEVDWzP5FS0HOjOUYBQBpYrzEpspubA7h?=
 =?us-ascii?Q?SpQd6zGs53hZBObJcU9CkLp29IwLdZKxq6fdI7j2U08ug63RZkYCb87HHIsI?=
 =?us-ascii?Q?TTz/wTBVs+i3ta+WVGQnPmkeWaLEdwFY7FhPz/5pyuddUovAIZYbbj6MeVdG?=
 =?us-ascii?Q?ZrNQE6B5EKt04Bb3UVR6hUtA1iyQHqZ+Jj3GJFNU7IBEKN1CAOsK+WEfDFZG?=
 =?us-ascii?Q?Na4Po5ABMr9aa08NUFTaZwhbmOw76eHJr2XzL6j9pG29tSwAG/4diN89vrSS?=
 =?us-ascii?Q?3/+4rraQ44H6uYEVezVA2kfImX4fdPZpeUtKVzjC/KNwOHPaI3syIAdN19qz?=
 =?us-ascii?Q?TmqwuG5eqh+EMeQtpOTJc/e5XhfIyeCTSBUgP4XyVvwtQVJHFjCnaQTo8+HB?=
 =?us-ascii?Q?7Y5wQOCRfxg552bhTdQWWvsmxRsa8F2twcq0+P882wCFCQg3o1zgv0BfdGpY?=
 =?us-ascii?Q?JAdn1AIIbFEVYVcAK3Ga2/Hf88aGERfH9QgJwBCzU1045USG3Pq3iZ1MTWAb?=
 =?us-ascii?Q?91ei1MQaNuiAzhZqmhWGVAZLoU51756hd18w/6czXrG+PeYnUcoGPU/U6gRi?=
 =?us-ascii?Q?ham6Q7zlUQDNW3TvoZLVZYi2uueJyacx1Quw5uqhD7wMAujg+m7nBJh2x8rw?=
 =?us-ascii?Q?OLw2c6dQZjI6MsJMXKwOu7I9S2ATDFxpMFCQPhJLP7MQ3SvDuaIx69Jzm/S0?=
 =?us-ascii?Q?sHp/JwEMAQrM0zUmynssB3dTDLLNGof/UgIjPG6st2dF7uiY5He/Yr8SEnes?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3064544-a4d6-48f7-f0b5-08dd9dfb7b9e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 15:22:39.5781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PK3btjwY4D5KHM+D3SckimT/Lolue7y3busQbDGMw+enZ75v/QkhseR8pQAiIi8dwO/x/idpYVPbl+18dWA7l/VfnA33jHL5H5+3T18EsEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5809
X-OriginatorOrg: intel.com

On Wed, May 28, 2025 at 11:11:41AM +0300, Dan Carpenter wrote:
> The cxlctl_validate_set_features() function is type bool.  It's supposed
> to return true for valid requests and false for invalid.  However, this
> error path returns ERR_PTR(-EINVAL) which is true when it was intended to
> return false.

Shiju - Can you trace this one through and add the impact statement?
Wondering if this is going to fail gracefully, or badly, further 
down this path?

> 
> Fixes: f76e0bbc8bc3 ("cxl: Update prototype of function get_support_feature_info()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/cxl/core/features.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 6f2eae1eb126..7c750599ea69 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -544,7 +544,7 @@ static bool cxlctl_validate_set_features(struct cxl_features_state *cxlfs,
>  	u32 flags;
>  
>  	if (rpc_in->op_size < sizeof(uuid_t))
> -		return ERR_PTR(-EINVAL);
> +		return false;
>  
>  	feat = cxl_feature_info(cxlfs, &rpc_in->set_feat_in.uuid);
>  	if (IS_ERR(feat))
> -- 
> 2.47.2
> 
