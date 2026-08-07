Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F83B2AA
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147131; cv=fail; b=jdwrqnfkDdRy6hwDvmpptBrHpht3BsrKqbFawpCJAOtZqnwzF6FbTlnFhE/6dP2ivtdDtvKERju1H6lytNRUfhGaentLyfqUpDiw/FcFxB0aPganAr01ERRmNTtzk29J4/FarPZkvfNQd8zP+SWoa4++su2GiLoiHMpV7NyY/HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147131; c=relaxed/simple;
	bh=kxrWPAkcSJIoGpeafjJWZU9QyA9VQRRBASo/CLjSDIM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XPs5ym+osDIhlqh5HsCxZDGjxXW6JM69q/u1uwAffzokUULce/tuAVmIY+JB7g7W7EJ2z2gMHQPwXb0aY9ac2ckiQouTo+NuDnan/V/VZHF6Ke0YaUt3a3obkaZU+FMc0H7WrXhBdlpGVN4qqo+hO5lldG8RGS2Is8yDklhKOCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0DqrGLF; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0DqrGLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786147130; x=1817683130;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kxrWPAkcSJIoGpeafjJWZU9QyA9VQRRBASo/CLjSDIM=;
  b=Y0DqrGLFCXYkJmbGDUEA419huYsE9sb/bR8s12EF2VscY3L9WO5j7x2b
   11iMmqmd/w/H6OXgYTrFxHeEpCeGY3jcxTxAJgnXrYF/5dIRhvc9dZkeW
   kuuIK1XgQY+BhtIPKEUCz8WS55chd1OZ2ehf1RyPEBpgo+pIVh5kfZEnG
   ugoav1+4ERZ5hnx7cQYRWpdccqFT+3VFHPCnwOIXHSE+bhjPpLTlcT5WM
   3VWYYY5EkwdlzjZ5huP0w8JqIi3VMDkApFPdwvnhIZd6hnMOG25Ip+KYD
   cYfNDiO8gXxk2OyNb0Jh/dv6t+vWBHKZFxshvu2WD1ClAokW8UBjqAvNh
   w==;
X-CSE-ConnectionGUID: 5GAu3qgqSbqVgE+wqcr7SQ==
X-CSE-MsgGUID: 28KYtQWVTCmjHXzzqw8rDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="90576594"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="90576594"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:58:49 -0700
X-CSE-ConnectionGUID: 0zF60Yb1TM+0I0hjLUUJ7A==
X-CSE-MsgGUID: KRFHqycnR9WCQIv+xSe0CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="263147013"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:58:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:58:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 16:58:47 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.15)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMf9PvNVJP5+cjC94BfKWtl/p5+5c0MYJ1LXQt9Xed/QZdFa1omD3AwYMqNEZh7KTJVRgapPy7tJBchBozYSAk37+gG9wB2pw3oujZzwhY5uvcxUrKxdP7cTrM6r2q48NthendSbD1kZrzcohtWsREFm4DJFCriMJNqcExo6UmeJ0AwQe7GleHZV8Edo8n5eaAziiU5Bq6N2ZiakUQzS6p8WF1ucgUfqjQthG2G5wqNke7OZuBQvMX2HVhLdV0b9xSPR6PKKiu8NAijXs26DJnB3deQidsBZI53kj+CZefyu737ymHLBbrTU1kG0GB33gIAG6vZoi1fZ++KHG7f9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnvfaSdy7s7oSQZMV8t9/VJDrcRjDUfjmuojpWg2LxQ=;
 b=I+96LlQ36bK4DCgYv3Eh+/fKYjd+7F4NA42+Lq9HNE3AeFELsgiwAdrMgxRXbkYB1Tjf/UV3VF2cHQFkdEngHJR81hU3BXPLcmn3/7OvmPLOQvKj/ipMEd1fHs0NNOdE2NQ9wt7Z5gvVhhj94tMzlVbbhy8EXObtt/9CqwyjXHR2jEXewb5M1JDXxX5/dnGNEE/co/+Sg1+ukgoSYgZF/5vR0wiaTCnwSc9penanuFOBADu7EOOhzKoV6+3+T4ZurK0Yr/JF46jXnfYAFksqEYejzwf0qr7TLHJ4jBKDZ0OWkXcFUKvvl3kWh6xsxEZSHbeLbcvul0IE2kzT833HXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS6PR11MB400772.namprd11.prod.outlook.com (2603:10b6:8:528::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 23:58:46 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 23:58:46 +0000
Date: Fri, 7 Aug 2026 16:58:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Dan
 Williams" <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v4 4/4] cxl/hdm: Restore commit_end when decoder
 enumeration fails
Message-ID: <anZxMpz1fecMZpj1@aschofie-mobl2.lan>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <3b2d66e380cb00b1365911a59f32739580d82563.1784595445.git.alison.schofield@intel.com>
 <45af7537-5cf9-4673-8b18-6169ee214853@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <45af7537-5cf9-4673-8b18-6169ee214853@intel.com>
X-ClientProxiedBy: SJ2P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS6PR11MB400772:EE_
X-MS-Office365-Filtering-Correlation-Id: 92dc9043-56d7-45fc-5602-08def4dfd150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|4143699003|3023799007|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5QesXlkroXuC4fwJWGfAHaPvqRS13/P1zL7odF6HHZkzc4XISuZofiDUhWtBz8oh2aatELPLNHy4rXKLzIDBBMI5c4b6tY3cjPzpx3aUUHlLFCyd962WSZ/0EdBHuvfULYnEkYdbUAArjvVpcXAA/SbcgjGj/OkP9OjanYfbpnJU6G10MSgL3LC5C3rpX0ErNav7+MXVHRPqqFemMuxesVTiSxJUgsDuKpcrY3Q0Ks6XgiVgthwaHKv3L28lgSoR0lIuKX2LGs3e8Cm89Xho4N1C56sBSsHWXWTHtbfyAwkZa7dfH1Vzgau/IU6WPPwk+dFPVRtB3aA0Reh8VtnGzoAy/0jHOTNk44woBpkVZFiNqEJL/7yBDCc3L/TbJrcTrpHOS0YsSeTVEJwpi8/66Z9GRrKMOjnktoJRD67foUnRN78gl9RssN/n81oBVmCPzak8CLAF0xdhDbHqRzYWoYpusFaYTL+6GNabHtdzzCAN4jYM0v0snIZvD3mnmbosfhQVP9RVsCSWukRd6G38nrPxqxOR3OpPDPxUse+CRGZrYMAnQT/YAi/BtOY5fpvVHnyfDB9J2SZl8EYupOjDul+9ynSL4lsyDyMhgcG1UdP4OhLiz/csGGaXLjNRyvEJwA34/cQb0m2PHNipUu/I+2IwDBCtgfjY+A5ZGTkjEDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(4143699003)(3023799007)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tH4wy7CSLa2Jurjg7U3CLkcHg50OGKZrmMIstAUOrSpYa+FAkFW0FiZ/MCGn?=
 =?us-ascii?Q?UDfOTuSj3yOuEK9zVB2ZdNpfiZ1Y6tUATkjvpr9gOJrEgekSePnAtuoWgl2d?=
 =?us-ascii?Q?7x1pgP4qwRmZVazTQoGsS2bGTvhFjr2AT25GIXRCFZKcALYNDrxKEHZAu1ZX?=
 =?us-ascii?Q?fRGpXxZ/O/4atgllUfMNrY58+gUJDRHvLhopuhRQy4aSmzKnGDT0oE/AES76?=
 =?us-ascii?Q?D8Fta4nF+JortIXYFreDhE+pHPl9C4wbDNepDn+9QIZllGsPd7tTXABRk1ou?=
 =?us-ascii?Q?5I2octVB0HocM+nOIa6w5uXBoOTKqRUObUERCyNcG0eLfe4dYuxQN2dGIqRV?=
 =?us-ascii?Q?DWYLX4YtjChibNWUWaMYkMRHuzmEHd9H+oVLLaKFVZnmmfKdyrx3nZJ3NwWA?=
 =?us-ascii?Q?WlbSLlyONTdBDBBWa/6jL/ow9vuyZU0oX0cQ3Qw6cb+sNfxymcKxGzoVCslp?=
 =?us-ascii?Q?LUSAQOVyoBiCLLA8v8W405u9r4VNYnjct+DJr17neml0dSuRW9eZsSp/vHvf?=
 =?us-ascii?Q?FJRJxxzD3lQHF5a9CUNyngzAXJOrLUIGdR3R65e9lFjh327RAsBTG6CGEy/B?=
 =?us-ascii?Q?2dNOCVqjY6mvLgY65tfEZ92N73om14mn8aizyT9TjrsbAOlOMfFWEkfL7Dc9?=
 =?us-ascii?Q?MIoSCcCYR7syrSfRBMBrqzcNVqfkh4t6oiSpfRGVEmT6ppNrG4sjjaFBN09g?=
 =?us-ascii?Q?4rMKl4TcDqkX7x4zDO4IOVx2KqKoYKWUSnNx66rmXq8cO2EwsICgRwxdnhWn?=
 =?us-ascii?Q?jXYely5diplzkfweI9eUnUpExIpm0YjYrJbgku2rWSmIxMm6UYRBaTFMYZ6E?=
 =?us-ascii?Q?LjAJmKIieT5+9LzqunXapvvlmB8GCBsVVj3XIJUkQtr77ahAGd13nHYv5gvk?=
 =?us-ascii?Q?U+aXziFGLcAbM1x60wx8SxLiMbCbcqlRpzoPrRUaab32uMcU/qHSM6lFpX39?=
 =?us-ascii?Q?lalHmp8DL8Ec9IYcwb0QF2YBmrATDl6hlVNjynMVpg68MOZj4NLibSHXztlr?=
 =?us-ascii?Q?fZ1miAybuqyGuUrsrQq6U0e40tTxs3yQ2dGzqiy2aI5SP4j2eJpWRG7jT8Wb?=
 =?us-ascii?Q?3UFyN9BXbHbxqp9+0KZU6xKFzhj3r83a6/QPPTGG3TqEr5MUFjUA7VgJn5fe?=
 =?us-ascii?Q?0l3DmIAV7Of9W01nYP0hugZFD/zC+2YxtBvvZgRHRKpl9jk5YSeFKRgzn8av?=
 =?us-ascii?Q?ZIicqNfLQmp6Xv6M+ThyfpQ3Ogfsk/5VLGt84w5MAhMEOqDEDQfkCtLJe4ZO?=
 =?us-ascii?Q?/2zsS7xRm8rIibsPoNIDL2jgj0w1xPtnjDaust1bynOX2EXswyiA0T7LrYZg?=
 =?us-ascii?Q?1DWoHpf2s9nzNUnY0spJI325FEHJNp5Thf4/bqZ/UiqatQ8q7FfO557Y6M3/?=
 =?us-ascii?Q?ryJe4M566nYTf85BSdYuOLkhvBEPZsg3SKSJ+a+tB65z77fRVnJ27aAfMJdT?=
 =?us-ascii?Q?IFuScCMkE/zH3MhR7/MvwkWROKsNPlFfebqOxH3wj76vKRMxYgQKIxcOV4y9?=
 =?us-ascii?Q?NMGWic/YCPpRMPNONVMew32wxY1T2uv2J0AStH1eh/HQ72Yu1RkGbs/dl0Dp?=
 =?us-ascii?Q?O8jKBImeGa1omVWGQlKstn9ORJ9CKtyS2vRKn9/5CgbS1uhysIzPLeYEqEFD?=
 =?us-ascii?Q?CMAkN9U3EqlYCgvbkpvT2fa1l99Wf2+xQYBBvlwra0Tpu4m/WC0BWQJBlr1R?=
 =?us-ascii?Q?HSr7IT46u1WsgqnHlYodHBI7pZ0P0DA/t4klLZZV+edDx8rbHEIkoRciesyR?=
 =?us-ascii?Q?GB9Zm4AldCiIUjA2RzkppEYr1YDt3qg=3D?=
X-Exchange-RoutingPolicyChecked: F1Y4uU0cUpz26VdNfehybVGRyYS2qhW7dQqCo5nh4jvvUNrjxGM7HnqmNFVuW9l5Arn7QE0icKkTRpbEX+bxCF3ttdIKOhXeuYIvOeKH+Xd+ag71K1fP8HM+R1Zr0IM8eqLjfhaYec29K0A5FolraLtSvrJy/ceOsMOyTyVgELu+nyjPe5+wzqj8mi6WxnlryFbQFi2uCpOY9iLpx3HriEmbFUudGfjHtL7t3xFfDf7xNRNfQOtk9uaWRVKr9yScJjKnaIfHhkrDhYI4QWplRXCqVJ6yai+WLORNJkHrZDK/5RKnLh4xofmU3jer49t5hspIuygvnr9mAOf9k1rNMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dc9043-56d7-45fc-5602-08def4dfd150
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 23:58:46.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etat5SVmLBukEsR4R9l8jVJCtg5PJVGlZunLkbUk/c8x8lNA/iGhpp6UoJt5T4Vq2TFgOHgynQojsBdE7BZ68lRv/cOXqIVuC+M8WmTTcXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB400772
X-OriginatorOrg: intel.com

On Tue, Jul 21, 2026 at 08:12:39AM -0700, Dave Jiang wrote:
> 
> 
> On 7/20/26 6:59 PM, Alison Schofield wrote:
> > commit_end tracks the highest committed decoder on a port. It gets
> > advanced before decoder enumeration is complete, so a later failure
> > leaves it pointing at a decoder that was never added. The next probe
> > then rejects decoder0 as out of order and enumeration fails.
> > 
> > Reset commit_end to the none committed baseline once the decoders are
> 
> s/none committed/uncommitted/ ?

Done, thanks!

> 
> > torn down, so a subsequent probe rebuilds it from scratch. Register
> > the reset before the decoders are added so that on unwind it runs
> > after every decoder has been unregistered. This prevents commit_end
> > from dropping below the highest committed decoder still registered and
> > exposing an inconsistent value to a concurrent reader.
> > 
> > Protect the commit_end advance in the DVSEC emulation path against
> > concurrent readers, matching the register-programmed path.
> > 
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> 
> > ---
> >  drivers/cxl/core/hdm.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 077aface1a2a..7d4ba7fa30fa 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -955,7 +955,8 @@ static int cxl_setup_hdm_decoder_from_dvsec(
> >  	 * change the range registers at run time.
> >  	 */
> >  	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> > -	port->commit_end = cxld->id;
> > +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> > +		port->commit_end = cxld->id;
> >  
> >  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
> >  	if (rc) {
> > @@ -1181,6 +1182,14 @@ static void cxl_settle_decoders(struct cxl_hdm *cxlhdm)
> >  		msleep(20);
> >  }
> >  
> > +static void cxl_reset_commit_end(void *data)
> > +{
> > +	struct cxl_port *port = data;
> > +
> > +	guard(rwsem_write)(&cxl_rwsem.region);
> > +	port->commit_end = -1;
> > +}
> > +
> >  /**
> >   * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
> >   * @cxlhdm: Structure to populate with HDM capabilities
> > @@ -1191,13 +1200,21 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >  {
> >  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> >  	struct cxl_port *port = cxlhdm->port;
> > -	int i;
> >  	u64 dpa_base = 0;
> > +	int i, rc;
> >  
> >  	cxl_settle_decoders(cxlhdm);
> >  
> > +	/*
> > +	 * Reset commit_end after all decoders have been torn down so a
> > +	 * subsequent probe rebuilds it from scratch.
> > +	 */
> > +	rc = devm_add_action(&port->dev, cxl_reset_commit_end, port);
> > +	if (rc)
> > +		return rc;
> > +
> >  	for (i = 0; i < cxlhdm->decoder_count; i++) {
> > -		int rc, target_count = cxlhdm->target_count;
> > +		int target_count = cxlhdm->target_count;
> >  		struct cxl_decoder *cxld;
> >  
> >  		if (is_cxl_endpoint(port)) {
> 
