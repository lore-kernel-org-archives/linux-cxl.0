Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09F273188
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437066; cv=fail; b=RrkLhQIBrLmeOkXIbHQE3E8YB7Pw4d9JmquDpPAGMMh19gRRrA47u4rUw/YaDLnzkqUtdJLUN4ZBFLZrZjjkNsxtkxSP9oXEyhxwfb/ozXZ3HR8IduKGqXgqY05TofXgtKsnnfLT9fknV6YX+3btbPOcj1UGpPuYZrZQh0OaajI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437066; c=relaxed/simple;
	bh=CmJ5IqKtH3HVBuX5pjqu/EoIm2hIh3HLY03Bvu8YDWg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tMcFmAXHkpJcRk16Fp9cyz9BsSIy97Kclu1zHUYPWC7Z5iFSX//MNfOIowZFmVLCCbTEWZNY9qn0/bcBx+wFV9OwXRib/8bzIDuwBIiE6EMHlrlsj4KBOnUdVzRkqt2lXCbGYORy8US+cifVnCOc8yyYIAvwv7L08Clxle1zlPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IzyFwzjk; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IzyFwzjk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710437064; x=1741973064;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CmJ5IqKtH3HVBuX5pjqu/EoIm2hIh3HLY03Bvu8YDWg=;
  b=IzyFwzjkspLCTOGexnwx9yoALp/LW7iGw+56UkZAsJei39+2p4LYlXgy
   UupFvAmMX5y+QA4RRhePjZi0yzVEFa8dkliFstGoTY+sbJ9sCh1lqUxO2
   NpoONKRgWSc5BLgVtEx3oH6vuGBvHZGKHFfPWpokEFMMgQO5o6RaIKWHk
   paZ4dJaWYfIanINn2yBLfhyOl/ezmztwn9XM96xr5p+DOIBJB2gMlonXX
   dBvOUonR0bpfWb68EJwVmQGvc4jrwTnYgIAzI4mWA74iKPDeIupX45uPl
   opQRkY4XCxcId/2t5xXduzgrr6mQNK/I8/fFz78AlzcjK6tu7uscFETWT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="27743307"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="27743307"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 10:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="16834332"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 10:24:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 10:24:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 10:24:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 10:24:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 10:24:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rds44F9YIEt9CSUBCCPY7rZPMbgX9s7RnjHjfdAsPm+DgDBL9KKsII1BDzHZ7NGNC4ykRqAJ7QVr/vZ000YY958tSFWwlSpalD8UXAKWyXG/DzZMA5/a1xw8d5wZdHy5Z60lM3ylqqWJkrFt6kLvdngi+oIQfkapW3hIhITpQwTgZ7juzc1UxIsloUSynY993WEQFXFcCjTKII6HkbuX+13zsmVRNXUPSDZ1svDniwMYMKLdH4KpKZ01C/VnnoI/8WKAoR8f4s9io+0039Sd6smFoVa286aP4rOaPQhBqtVtD6nDXMuMTfuPdhQl2huNAlGHGJNi6GrERlatAIg4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lho34u0aJsgc7icFjw8kzKoX3vUj4yM6VhstMTW8Mlc=;
 b=jxjpxAbNDmpVeg5iR3VgSxkCW4D+O5SSjYK0WWcBduMizr7cQE+G3GsaI5iym7HOTep8qhCPsHAJZ6JJweeXYz2PCUzCQKOy2rQG2Ea6jFkWK8g6pKbhvqeAfLfaPHikg2h9aKsT05HcyTmDduTdNGbJOARkGGA6wRakojT6fwibE1J8zuMQBtZYpYGPXTav6QUmi4sDbYrtCFaFpnYUY+BOwl9eN2xGX79kuoflm93gU/YjqQ7IqiEepDUWRrfw+15PSu68VHO7hv9KL676CQijhpBvu88GbeJt7/qc62JAlRNLJouF4QcXbu0tdAFx0jiAA2dK/XeShW80R8Whww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7501.namprd11.prod.outlook.com (2603:10b6:a03:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 17:24:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 17:24:08 +0000
Date: Thu, 14 Mar 2024 10:24:05 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, <alison.schofield@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/trace: Initialize cxl_poison region name to NULL
Message-ID: <65f332b556705_13f3a294b0@iweiny-mobl.notmuch>
References: <20240314044301.2108650-1-alison.schofield@intel.com>
 <65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65f3016b8b0d9_1fe3d329441@iweiny-mobl.notmuch>
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbdaa2e-d5e3-4321-dea8-08dc444b8e9f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nG86JTIwNP6WoI5KxYFnGfp/fKW1h03d5AbzFYD830u9+taxWmemLuViJKW0UE9ftwMrrctPAyb1DJU6Kg3hZjNs7QGUHjGvzBhgiFnuBngfbjXRPrfznPjy3BVfFw9w2wse3X63hAeNzP8z7oeSCVLyAAxtPTkSA/UOeFTAKFuHgPdKPb/fz3C2+FQKbRWmlhk4OEbdZ6qiZu11+gLAcMz9LWPYfYMHZXm7O+83r1kBQwMU7jXPAivI6BGGKjfQarSnlSohQPd1K3Oj2G3a9sIUbEimxMvkXu0L2r0/voRtqP91Qb+XhO4bOVSy79Baj0SqB/7tarLlCnzzh6B20DDwTfW/K3LvpMrd7zX1SFDu3qbyVwJ4ZNWXePBN6ZxpQ1k9h3bqWh1fafjhkbr5W3ysg9kNGewRTK+zQZBWaB2bl6RxoB2JRrPO/6y5rhJ2NC04R0ycfMODisxsQUtlAgTj8WLj/eINvfB2g9aYezER5cYkT0JHaK2Ysfn6BP6cDSSks/lW/8uJSbQpumqN6cZX27R1yMVf0lDX9Xm93jAthipZVSbDISpPvezolueAlCOxiusGJ/xSwIzYHcoANsQ7MxdHh1nrhS/Ke9WnbrbfCvaM9V65xKNMFY9ZEhPLtKpqzdUQQHxLv/LBPCpq7kI89WXjwF4JvLduW/fGXKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HE8JP5vXgXqkNU/7qRVBU9JmdKXKYIpJ3M+IdiGB6g5rhBCZlcUXsyYe2Jdj?=
 =?us-ascii?Q?MaoyJnWILzNqjpovDwjIr13uBfMOFbk8LoNQUEnkx987QBYQOD63NkVQo3S5?=
 =?us-ascii?Q?fEHK26CsdglUa7AkdjdBWEVSuUGBZYteP+lfdAZBA0CaFwKMxafmkF+O8wGr?=
 =?us-ascii?Q?CcPvA4E/JAS9zMugd2VqNfzT5ZUNIGibfgciNK4OFV5R8wnpO3ZV0ettozbh?=
 =?us-ascii?Q?KsnobrbJfcOuxtVCbun/rGEmPLWsEX/gzpPFfM27GC3tFJKnULBOFjC+0Eee?=
 =?us-ascii?Q?G7f/5fAjTRGoQP/xcXUJeFC77JuJY74r82RtMNUfxAaFB9hHkgIbeR2Ftlz3?=
 =?us-ascii?Q?INtATwWzBAj6wCRyzHk7dBMGvMhXHa/NDYhwspkgBnN0PgWgRgofaS/gbcgo?=
 =?us-ascii?Q?tFjCFpURUSN9myyHL3KWd1r+iOjzXqbJj0ibE9hkHfT+0ZcpbYOcvNc4Ld3Y?=
 =?us-ascii?Q?tLHX2pRXKD3OedlYYKRapfatarJlyKeQfdtfZ++GCY85PvPyzBunSLZtmbqT?=
 =?us-ascii?Q?pARf/P9BFiBSNBYJF9Q25MDBfGaxrz+QHViJ/62h2xd7nBf6eSrvWzxN86GH?=
 =?us-ascii?Q?8q9kfVPw5ZPuKKCRrwQCEzpyie64U6xGJXwxBhHXRMDcCAE0KC4SFnpOv8QP?=
 =?us-ascii?Q?geIIGAoEhCPNdwCantACKZddx/2pd6wb1IZB6+isZc58dVbbDp3Ck8FNahAx?=
 =?us-ascii?Q?dwWIkUuVYw6GQo6f6fZIUJArZ8aVqRCpy6tniHYNAOmU3j1n7BOKlfAKISWN?=
 =?us-ascii?Q?YYBdpyvQzQcOWxZKS5bZ2xbRUYeq5F67QIYLkK4sggK0cDhKRnnYnrha39ai?=
 =?us-ascii?Q?xLdH6bBbLhBAHhzbwEyg35G87ZnkOG8XwSn1x+mo1U5jwzaOuzLKh2KgXQ99?=
 =?us-ascii?Q?jqHg94/+cW/X9a3vI83o0Kb7YYAMvrxsWETPG4qcMdTgDZBIp+w0oStxUIB9?=
 =?us-ascii?Q?Ir4UCi8r3n7mNLbfZHQ2BsdcFnaXy/I/Omaa1j4WnEkB95KpDsxipe+jzC6Y?=
 =?us-ascii?Q?k2INBzI8IOy0gPMfigJnTjf+pnjzDE2Sk6vxTMmIdT8dSD3vgTB8dUkd1qG4?=
 =?us-ascii?Q?Xm/Ohy4edRJeTbX7jTOgRLM0I+MwwJfXJuT0xu08zWveG+ddZ1OOqetyZzMm?=
 =?us-ascii?Q?YEMPY85DYquJQAEgpTOreo3G69Z0izV9k7GcAj9NGhhL8+j0Ia4Du7GsUBSw?=
 =?us-ascii?Q?i7zg+rOTu6N8P2w6BnqumVcZ9oZQwgNO/BVFwM6ICghKW7olwkXU5KySRsSl?=
 =?us-ascii?Q?miEd+LSo+/R+PmBUW5cCEX3IhTNw8Jn/5pB29+BtVQPzQ3wCXRGFD2dGL39a?=
 =?us-ascii?Q?PVE3ss29Lsfxbnlr+PmDoq3t4+3U8ufjHORjXeyaJBZyj5azN3M9d2M2ALo0?=
 =?us-ascii?Q?X4mycDR8iK2zdrQB8NOQlNQTw49tkO1SOGwaqyf9CGHofrxGhUzzsCSciQuC?=
 =?us-ascii?Q?NFXKg2ViMyw9CiNDoQORVKWpgNvDWMCd+VrOL+0+Ym0YFThUsmDTFKi/GZrc?=
 =?us-ascii?Q?PBmUK5MjThm2hPC5dfxSVGTxu4F+3CYznW96LaDPPonfjO9YORk7m5KaiaVO?=
 =?us-ascii?Q?EwwOUrFSVaFs7i56q8dGyRKKrKvlrtPKq63b4q7q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbdaa2e-d5e3-4321-dea8-08dc444b8e9f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 17:24:08.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKKEzSp72Ojlox1R3ul6fptAfbQ6yPgcVufo6XA/VEaewVm6PuIEkKTQ3MFNnVqTEX1cosiiafzXW2r1U8avRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7501
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h

[snip]

> > index bdf117a33744..bc5ca4d530d1 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -657,7 +657,7 @@ TRACE_EVENT(cxl_poison,
> >  		__string(host, dev_name(cxlmd->dev.parent))
> >  		__field(u64, serial)
> >  		__field(u8, trace_type)
> > -		__string(region, region)
> > +		__string(region, NULL)
> 
> Couldn't this be "" instead of NULL then remove the __assign_str() if
> region is NULL?
> 
> Ira
> 
> >  		__field(u64, overflow_ts)
> >  		__field(u64, hpa)
> >  		__field(u64, dpa)
> > 
> > base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> > -- 
> > 2.37.3
> > 
> 
> k

Apologies...  This is just a lost 'k' looking for it's home.  (emacs users
don't hate on me please...  :-)

Ira
