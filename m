Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEBC3403FE
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 02:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476046; cv=fail; b=G9EbcFu1hLUimtA3AZOZVVY3SKmdVvlIQH+st+/ymEAsnFunqHTNj1TQZ8tvkEM9tfKsgHtIvCJlbYr3/l0pWXLYDXZtQ71e9Qkrj1vl1uGJ0uFfUkGlv2JgbQb5sDy+Su9qtHKr2XbNpEjI2FiXI89Im1ARMDJKKjrP4h6ugzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476046; c=relaxed/simple;
	bh=4bIiLGqpmroygkKS2/nW56qzsM895lKs+wxpH9COceM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sf0lbQ0na8LhQ8IpUx42lymIaaqsOPjxmMZuHnApWwxOVXF5y+EtjilzAVTqAM8VjtWrOS+IFkb/LYt157RvX51rU+AIEnnv2kYMrMk99YVMg8t7K1MTgORclTX9Y3KiELgQ2hGUEneFsblgeWpORtMO3w9w6TCb4AzQL1MtJDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FI3Zzzsd; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FI3Zzzsd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783476044; x=1815012044;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4bIiLGqpmroygkKS2/nW56qzsM895lKs+wxpH9COceM=;
  b=FI3ZzzsdDQwAoiECSZ3rnGSHyR1XaK3OHmuyvk5JWHjH/9XO76D4NvH1
   MPRO+uo6evZ4duAcfClLtMCZp/aojICHqlTtocczBWWgTzc5/BZuw5SKj
   gWy+ITxXSTJJ8GssPi5Ca271conWnp3L9UXsEs57IZeTjFEBoYeZXBYIf
   b7605yy1HhK55HpZJNsTP4w+Iwu+wIMTNSLPES6S0DMNyiJhLNU5Qh0KN
   joc5XO1GOOnukpvYZ4Ckbkswukq9BgvHdxBMJkHZUF9Ow0+hPRQVOq+px
   R2/k7jYKy1bex42UMhkFeIGIn5n6ro4J077RzXr7FnbP+icdbINRSOXIw
   g==;
X-CSE-ConnectionGUID: p+Yp/ZkATCaFUGhZbjQ/+w==
X-CSE-MsgGUID: SU9CfDC9RbqmRYAoQ1vWMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94775917"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94775917"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:00:43 -0700
X-CSE-ConnectionGUID: nWWfwn8oQ9ajx5WE30CokQ==
X-CSE-MsgGUID: 1b/nGnPZRdKvIoRwLP9NkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="292339123"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:00:43 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:00:42 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 19:00:42 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:00:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ouz0lTuGKVg0v1LJ2EhrGLRtuxK3L6RwEfiAI/UWnB5Gb6lyQZRz/2O2L1CdmrEmHO7vG6Fj9Gx9OTVNltCpE1JMHu/cAwhKMs3p9OhKdAhsoIrSvQig7eSLyG71JKzYQKHG9aOmhNUlDZP8JBnga9atPH0l0z96fyfZBqLUQ9wEqEtEg/SwWigmZ/VE8vdyxNBXaJuG9QDTButARXgM33QR7rzHURPxj/N6car4hft2DgE+uW9fcTJ04zjRqCcTMTEN1HO/GXwEs4y5H+iDm9TAbPGAz/tAbZGxMKuI6gtiX7DkV+h43n8xs5cSZFL1L7RZxICRM1Dr3oVblOI8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUysUzniu3uRsq0rK0TJ2uUBj9KLEXEN60xsYoaJq4g=;
 b=TW9B0zJQwMvYUZ9b1AzA/mEi1Scn2qka6p+3iFwFuru9WFsuZXIYZJpjqyvCyqrRcRWEUQ2rq/iXdwPhSRaT5sLnHKdjPEk0EQhyAiSGEiGU1SKkcY2WFIa551cRpix8CwVmqCmnbIqbZmrbTh++G43LJmTJ1X7KZiwbAPhBxmLsb4oVorHtx27fJcY99suVdb7BIrhx08IysiyH0LSXIcRlwG62EW9/iLGb2RWc1DIoBKnk8jpylpGrGoiW7i9lPP0d8SvNPTl4Nc2m4xW5JpZgdjjiCDQycOa/pTpzRYx0+8viV7MGUC7yCxGoN1WgdLViELPOvXVz1o5nzPXB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA0PR11MB7305.namprd11.prod.outlook.com (2603:10b6:208:439::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 02:00:39 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 02:00:39 +0000
Date: Tue, 7 Jul 2026 19:00:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] cxl/region: Validate interleave selector bits
Message-ID: <ak2vPxUW0jzPebZ0@aschofie-mobl2.lan>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <5ac370e484caeb49c334d5a586a7ec8fc1b3dc38.1781199122.git.alison.schofield@intel.com>
 <aj5kbdsqLPge-rkT@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aj5kbdsqLPge-rkT@rric.localdomain>
X-ClientProxiedBy: SJ0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::30) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA0PR11MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a0018e-db62-46a1-a20f-08dedc94b593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|4143699003|11063799006|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: P6Kp0x5S6AkeJ6PM29VUvKxQLukJBlPS0XpHfcJJUh4I/tkb5Vt1hNZm+2U/08KJQnTaqAkRKmwIsz+N1i5OQdw3lEXLG+bRBeYBsv2ehBaM9fJOOxkmdHY53Xj/HXd5ZTgZ5/NCgvF3t8CyE0fKGRRPzaXj5S83XmMKqcdoZqWWL/aLu8dqjI/OCnkg0J06ZPbkB2frJ71h32AI3qiCC6k6QqPjwbWrlpASyPFPZTwX1WGWW0SkB1lTXWZLBPpBrNv1woSWtCk/LM3C1Si+kq1NFT4tsAaSoJ3XgtTW1Hodk54pgQ2JyhpVr0eMGVgcTScq2JuUI+ReBST4Bssq++axgf9OHjfKPidZVUBF5ZT492qy7zdCWS1fYfWPWseoJLUk+57KzRPfbBy7uPeeD7IMYLgonramEK+utGyWjVQuUHTnK7gNJ01DH83VIFx2H099L+PWGtfLcX8tNWF/lGjpozFSpvoNBDZRZQ5H52ZS65jtZmnnI607DtRohdBDSKV+THbRynXXXdaJni6tuDq6CuasgaSOjh6pxOwKv8pAg2Iv6gLFAuiAMa2PKlCqINkQVYlYmfoxK//uy4K+zRHXZrpN1cT4VrmowHmX/dPzvxnPrQ6ln5xsts5rMl54dO8n4sYsARoNDChqknwiZq0+QTnX5nFWJtdIlwhwLz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yE72L0XoqsfLoydlMEzld5Q0KLUG1uisCUczuOKmBoShHjMM1DevcQsZu9UO?=
 =?us-ascii?Q?pUyqoC+n69oaNduhV4bjkFooP+l16j8fc9jzfv7atzVyPNG96BpaQ1hPr/gj?=
 =?us-ascii?Q?M8gq0A9stKAWLc+sOpAjuMaDHb0pcnBC89ToTmfBpYnO5by0dNz10hmq73Cd?=
 =?us-ascii?Q?800swW2CWv6Xsq9pitX0XaB4kNrFjEnmbYjMJ1AQxhnO1FPfEzFPuyiLUo4u?=
 =?us-ascii?Q?bdDVrFQnIQRkEnEoFwa9+MbVIqiocFBS32OTrmVy15qf1O26IzmaujFTXBuS?=
 =?us-ascii?Q?G4S+IlbgF4klXlXGGF+TJP0iwI4GZI0yNddDKl9LRFA869WseLfRKim6j7Bu?=
 =?us-ascii?Q?GYecLZ1Uf3sTHqIjfzxRPUweOnKuw5d8eItvaVHSUGk5VeU9ExJWiXp9cuYL?=
 =?us-ascii?Q?ZrOv2dHUg7V8qkz2PhYuS+qsBfh/goB1VqhDf7XFgYq87QiQp4Km8vCKsDbc?=
 =?us-ascii?Q?wjFQrLUg/ksXfph28emBi2rz8MtMgdS4grlRCZdxkHKGJq3jx3r6GXgCrpvr?=
 =?us-ascii?Q?FnE2HIb3NYdnkh733fgmfMKZruTN4lbrcf5IXh1VhrcqYEL0r5i8vSVLIfuF?=
 =?us-ascii?Q?obK3SWgYxEP7eYzRGyC2Oppf7qH5s7VDOtYQUsbW0BkcqZQ/Ux3kEYhsfVtr?=
 =?us-ascii?Q?3zofRQPGIig8qeUaWkInC6Y0leXyKxiWpxoELopciPQ7h1gsgKsi84GNwQ3x?=
 =?us-ascii?Q?3/mqtgrwknJtcTVOjkbFAW/cETKk67zAtQ+bYSxV9Kf3zloAbhUw/UcKsXWx?=
 =?us-ascii?Q?DDxIqkLAQkDfjDWeghMeRcUBp/iyd/TGce4gjam2NS6S58QfA67/enfh9Q/m?=
 =?us-ascii?Q?ydFZDJlk/TyX0UZvGuzyME7fMGEgzAmE8vpfqBHplzWskWsnyDtWEN0RHvXb?=
 =?us-ascii?Q?NUdL7pe79gnjzKolvLfCL9L/niDpMRPUgqcESzixprzsz4RgsBqBeAXOb8sQ?=
 =?us-ascii?Q?jAoFV8/c5uXKwBQZWokFwJIlQpW3W359K3UeaTlBlfFWU/TYAknFu3ygJFH7?=
 =?us-ascii?Q?YuslXd0+5Jl1CagLx1XYanWmzyvTHQnu6RDvvRVdo+ZxsfUzpTiGWZE+kCi7?=
 =?us-ascii?Q?2rBYWO3shhe437nQDx0f4ve4VR59YGBhzrB0zvU/biKJiDZsUeXcnstEaqHz?=
 =?us-ascii?Q?Yy+Q6J3t0vjczSWmZYHdwLq2EU8JqN5rnEW/o93YLxIdSBkoiGMWjHEFQ2lo?=
 =?us-ascii?Q?A92VwpbY5ibMXzeHebak/h1lMS6rw5jQgMse96YW2bBNQbVTuH37+hgwhMxw?=
 =?us-ascii?Q?5R/HBMwYUV47pfdpAFIZi1EFv1Enz4/Ozy2vte+vL5UeDW37/H9Rfkq3Zopv?=
 =?us-ascii?Q?zTyVJPOo6Evd82Hl7LuheiOV1NJw0CU7c6hkjqPP2d95H1MtmeCMCJ8RZV/L?=
 =?us-ascii?Q?SQZGRq4voRaX/6p3r2harOaiQQ0StVuH78kPOCJMbyQV9kvFC2FWcs7aseo8?=
 =?us-ascii?Q?7I2Q3dKKk7GRkMXINg+CeTefojsWRJfB+GAqy0E2hCvUc5eeSAbdR+yPo06D?=
 =?us-ascii?Q?EmC67Z+5jyV3cSmGAFwnRcBJouAnrq+X70G2XJFFvwml4x7tWLoftP/h/XoE?=
 =?us-ascii?Q?Y00zDNGAnvpTdWHZScBZbOlGS0RaplirtxMZ5Yy290I0npKFgLVDNDmDXyH5?=
 =?us-ascii?Q?vDpM4nHUmoCVdwX53zfLdIauxQwR0av6/0M5oGWOk2CTd8GLmwzPebVvnIwv?=
 =?us-ascii?Q?JygjvB3CRMV0Gpa0ZMOmbqh8dBT1CXQeNWBSn1RaojmCy1sQeDIolmF7Zj+z?=
 =?us-ascii?Q?DMuPXXVG6RJ8Jr01cCbmy1RBL9IeTv8=3D?=
X-Exchange-RoutingPolicyChecked: nFTA7Kr8gpXayxl9b4hq+0GKhPNmptZmpG/9U9F/HtY9SVBIEkehNTe+OUDSWUysBBr2iRt8uE2ajLxR7NxCkghsIYtfRRjl1ej0fRY7awLvZqwQqEI4t2aYwRyYg/t5E7JO9QDv3Zc4lG5I504cBGlrFWg7m3Khu6+GZM+qD4955KXsealEUN6CIWJGnUK86acVtrFOuftVrnZweuy+w1FB7e9x2D9GYQtC13+BkjCSldEOQwhpRy8ilX8unwaQvVYrGZLUMaZcCfh/9G7PVgsFNSGPnoFkiiX7z9J3Hn6VJfROLOC7F6piwP3unqBprW2uaegihntsrWQFOyoY3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a0018e-db62-46a1-a20f-08dedc94b593
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 02:00:39.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zsi3EClAiTKgRMdr76K5hkbfZfXvgeNVk/ptOw19DEXG+C8/oxBAuo4BkbF9iOmiUz//y3ZnGbnbykrSUXqrdWq/EHnnzFh+NpRUV4G4DDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7305
X-OriginatorOrg: intel.com

On Fri, Jun 26, 2026 at 01:37:17PM +0200, Robert Richter wrote:
> On 11.06.26 10:47:25, Alison Schofield wrote:
> > Multi-level interleaves are valid when each decoder level claims a
> > distinct portion of the region HPA selector. The existing setup is
> > too restrictive as it requires that each level's granularity must
> > equal the parent granularity multiplied by the parent ways. That
> > forces the root to sit at the innermost selector bit and rejects
> > legal layouts where the root claims an outer bit.
> > 
> > Add selector-bit accounting to cxl_port_setup_targets(). Accumulate
> > selector bits from the root toward the current port, reject overlap,
> > and reject any accumulated selector that does not fit within the
> > region selector.

Hi Robert,

The question underneath several of your comments, whether the
implementation should move to selector-bit arithmetic, is answered in my
reply on Patch 3/6.

Below, the local comments on this patch.

> 
> I think this is the main goal of the patch, to introduce a
> selector-bit mask and use that to keep track of ways and
> granularities. We should remove as much as possible from the original
> code without introducing functional changes here. Subject and
> description should emphasize that more.

Agreed. In v3 (I hope that) this patch becomes a no-functional-change
refactor and the log say so explicitly.

> 
> > 
> > Preserve the existing same-granularity behavior using values derived
> > from the selector walk.
> > 
> > Block mixed-granularity attachments until position arithmetic is
> > updated by a later patch.
> > 
> > Originally-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 192 +++++++++++++++++++-------------------
> >  1 file changed, 96 insertions(+), 96 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e50dc716d4e8..c859c8661281 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1423,12 +1423,34 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> >  	return 0;
> >  }
> >  
> > +/**
> > + * get_selector() - Return the HPA selector mask for one level
> > + * @ways: interleave ways
> > + * @gran: interleave granularity in bytes
> > + *
> > + * Return: ``(ways - 1) * gran`` for power-of-2 interleaves, or the
> > + * selector for the power-of-2 component of a 6-way or 12-way interleave.
> > + *
> > + * A 3-way interleave consumes no HPA selector bits.
> > + */
> > +static inline u64 get_selector(int ways, int gran)
> > +{
> > +	if (!is_power_of_2(ways))
> > +		ways /= 3;
> > +
> > +	if (!is_power_of_2(ways) || !is_power_of_2(gran))
> > +		return 0;
> > +
> > +	return (u64)(ways - 1) * gran;
> > +}
> > +
> >  static int cxl_port_setup_targets(struct cxl_port *port,
> >  				  struct cxl_region *cxlr,
> >  				  struct cxl_endpoint_decoder *cxled)
> >  {
> >  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> > +	int distance, parent_distance;
> > +	int ig, iw, rc, pos = cxled->pos;
> >  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> >  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > @@ -1436,9 +1458,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	struct cxl_region_params *p = &cxlr->params;
> >  	struct cxl_decoder *cxld = cxl_rr->decoder;
> >  	struct cxl_switch_decoder *cxlsd;
> > -	struct cxl_port *iter = port;
> > -	u16 eig, peig;
> > -	u8 eiw, peiw;
> > +	u64 selector, cxlr_sel;
> > +	struct cxl_port *iter;
> > +	u16 eig;
> > +	u8 eiw;
> 
> That list of local vars is very long and we should factor out some of
> the code to helpers.
> 

Agreed. v3 factors the ancestor walk into a helper and moves the per-level
selector computation with it. That takes most of the locals with it.


> >  
> >  	/*
> >  	 * While root level decoders support x3, x6, x12, switch level
> > @@ -1452,28 +1475,66 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	}
> >  
> >  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> 
> That could be moved to the declaration section.

Done in v3.


> 
> > +	iw = cxl_rr->nr_targets;
> > +
> > +	if (iw > 8 || iw > cxlsd->nr_targets) {
> 
> And this can be moved up / merged with the power of 2 check before.
> 

Done in v3.


> > +		dev_dbg(&cxlr->dev,
> > +			"%s:%s:%s: ways: %d overflows targets: %d\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > +			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> > +		return -ENXIO;
> > +	}
> > +
> > +	/* Track selector bits already claimed by ancestor decoders */
> > +	selector = get_selector(cxlrd->cxlsd.cxld.interleave_ways,
> > +				cxlrd->cxlsd.cxld.interleave_granularity);
> > +
> > +	/* Track distances used in passthrough granularity and peer checks */
> > +	parent_distance = cxlrd->cxlsd.cxld.interleave_ways;
> > +	if (!is_power_of_2(parent_distance))
> > +		parent_distance /= 3;
> > +	distance = cxlrd->cxlsd.cxld.interleave_ways;
> 
> Better use only one var here. One can derived from the other once
> needed.
> 
> Actually, we do not really need it at all, see below.
> 

v3 keeps a single variable and derives the other form at its one
point of use. On whether we need it at all, deriving distance
purely from the selector bits works for the power-of-2 part but
the selectors cannot carry the factor 3 of a 3/6/12-way root, so a
value-space term survives. See Patch 3/6 reply.


> > +
> > +	for (iter = parent_port; !is_cxl_root(iter);
> 
> That could become a helper function get_parent_selectors() or so.
> 

Agreed, that's the helper mentioned above.




> > +	     iter = to_cxl_port(iter->dev.parent)) {
> > +		struct cxl_region_ref *cxl_rr_iter = cxl_rr_load(iter, cxlr);
> > +		struct cxl_decoder *cxld_iter = cxl_rr_iter->decoder;
> > +		u64 cxld_sel;
> > +
> > +		if (cxld_iter->interleave_ways == 1)
> > +			continue;
> > +
> > +		cxld_sel = get_selector(cxld_iter->interleave_ways,
> > +					cxld_iter->interleave_granularity);
> > +
> > +		if (cxld_sel & selector) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s:%s: overlapping selectors: %#llx:%#llx\n",
> > +				dev_name(iter->uport_dev),
> > +				dev_name(&iter->dev), cxld_sel, selector);
> > +			return -ENXIO;
> > +		}
> > +
> > +		selector |= cxld_sel;
> > +
> > +		parent_distance *= cxl_rr_iter->nr_targets;
> 
> The parent_distance could be derived from the parent selector and
> moved out of the loop to simplify factoring out this into a helper.
> 

For power-of-2 levels, yes, and v3 does that as part of the
helper split. The x3 caveat above applies here too.



> > +		distance *= cxl_rr_iter->nr_targets;
> > +	}
> > +
> > +	distance *= iw;
> 
> The decoder's selectors are the next lower bits below the parent
> selectors, so iw and ig could be directly calculated from that. I
> think that very much simplifies the code.
> 
> There are those 3 selectors we just need to keep track of: switch
> selector, region selector and parent selector. With that everything
> else can be determined, e.g. iw and ig.
> 
> If we create helper functions to get all 3 selectors, this function
> will be much smaller. That also moves away error checks to that
> helpers.

This is the core of the selector-model question answered in Path 3/6 reply.

Short version: v3 takes the helper structure and adds the root decoder's
selectors to the validation walk (your follow-up), but keeps iw/ig/position
derivation in ways/gran value space, because the selector bits cannot
represent the factor 3.

> 
> > +
> > +	/* Accumulated bits must fit within the region selector */
> > +	cxlr_sel = get_selector(p->interleave_ways, p->interleave_granularity);
> > +	if ((cxlr_sel & selector) != selector) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s:%s: invalid selectors: cxlr %#llx accum %#llx\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > +			cxlr_sel, selector);
> > +		return -ENXIO;
> > +	}
> > +
> >  	if (cxl_rr->nr_targets_set) {
> > -		int i, distance = 1;
> > -		struct cxl_region_ref *cxl_rr_iter;
> > -
> > -		/*
> > -		 * The "distance" between peer downstream ports represents which
> > -		 * endpoint positions in the region interleave a given port can
> > -		 * host.
> > -		 *
> > -		 * For example, at the root of a hierarchy the distance is
> > -		 * always 1 as every index targets a different host-bridge. At
> > -		 * each subsequent switch level those ports map every Nth region
> > -		 * position where N is the width of the switch == distance.
> > -		 */
> > -		do {
> > -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> > -			distance *= cxl_rr_iter->nr_targets;
> > -			iter = to_cxl_port(iter->dev.parent);
> > -		} while (!is_cxl_root(iter));
> > -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> > -
> > -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> > +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> >  			if (ep->dport == cxlsd->target[i]) {
> >  				rc = check_last_peer(cxled, ep, cxl_rr,
> >  						     distance);
> > @@ -1484,84 +1545,18 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		goto add_target;
> >  	}
> >  
> > -	if (is_cxl_root(parent_port)) {
> > -		/*
> > -		 * Root decoder IG is always set to value in CFMWS which
> > -		 * may be different than this region's IG.  We can use the
> > -		 * region's IG here since interleave_granularity_store()
> > -		 * does not allow interleaved host-bridges with
> > -		 * root IG != region IG.
> > -		 */
> > -		parent_ig = p->interleave_granularity;
> > -		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
> > -		/*
> > -		 * For purposes of address bit routing, use power-of-2 math for
> > -		 * switch ports.
> > -		 */
> > -		if (!is_power_of_2(parent_iw))
> > -			parent_iw /= 3;
> > -	} else {
> > -		struct cxl_region_ref *parent_rr;
> > -		struct cxl_decoder *parent_cxld;
> > +	ig = p->interleave_granularity * parent_distance;
> >  
> > -		parent_rr = cxl_rr_load(parent_port, cxlr);
> > -		parent_cxld = parent_rr->decoder;
> > -		parent_ig = parent_cxld->interleave_granularity;
> > -		parent_iw = parent_cxld->interleave_ways;
> > -	}
> > -
> > -	rc = granularity_to_eig(parent_ig, &peig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> > -			dev_name(parent_port->uport_dev),
> > -			dev_name(&parent_port->dev), parent_ig);
> > -		return rc;
> > -	}
> > -
> > -	rc = ways_to_eiw(parent_iw, &peiw);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
> > -			dev_name(parent_port->uport_dev),
> > -			dev_name(&parent_port->dev), parent_iw);
> > -		return rc;
> > -	}
> > -
> > -	iw = cxl_rr->nr_targets;
> >  	rc = ways_to_eiw(iw, &eiw);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> > -		return rc;
> > -	}
> > -
> > -	/*
> > -	 * Interleave granularity is a multiple of @parent_port granularity.
> > -	 * Multiplier is the parent port interleave ways.
> > -	 */
> > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > +	if (!rc)
> > +		rc = granularity_to_eig(ig, &eig);
> >  	if (rc) {
> >  		dev_dbg(&cxlr->dev,
> > -			"%s: invalid granularity calculation (%d * %d)\n",
> > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > +			"%s:%s: derived ig %d not a valid granularity (iw %d)\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev), ig, iw);
> >  		return rc;
> >  	}
> 
> That is just a value check which could be reworked to check the
> selector instead. Could be a helper function.
> 
> We should consider adding the selector to struct of cxld and only
> check it once it is finally converted to ig and iw after setup is
> done.

The check moves into a helper in v3.

About a stored selector in struct cxl_decoder, I don't think it fits
the model. When a consumer show up w need, then consider it.

> 
> >  
> > -	rc = eig_to_granularity(eig, &ig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			256 << eig);
> > -		return rc;
> > -	}
> > -
> > -	if (iw > 8 || iw > cxlsd->nr_targets) {
> > -		dev_dbg(&cxlr->dev,
> > -			"%s:%s:%s: ways: %d overflows targets: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> > -		return -ENXIO;
> > -	}
> > -
> >  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> >  		if (cxld->interleave_ways != iw ||
> >  		    (iw > 1 && cxld->interleave_granularity != ig) ||
> > @@ -2067,6 +2062,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -ENXIO;
> >  	}
> >  
> > +	/* Keep this patch bisectable until position arithmetic is updated */
> > +	if (cxlrd->cxlsd.cxld.interleave_granularity >
> > +	    p->interleave_granularity)
> > +		return -ENXIO;
> > +
> 
> Hmm, that looks odd, even if it's only temporary. Could you explain
> why that is needed here.

Your follow-up answered most of this. This patch makes the selector
walk *pass* for mixed-granularity layouts that the old equality rule
rejected, while position arithmetic doesn't handle them until 3/6.
Without the temporary gate, a bisect landing between the two patches
could assemble a mixed-gran region with wrong endpoint positions. The
gate keeps every commit in the series correct on its own. It is removed
in 3/6 when the position math catches up.

I think that's all on this patch.

-- Alison

> 
> Thanks,
> 
> -Robert
> 
> >  	if (p->nr_targets >= p->interleave_ways) {
> >  		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
> >  			p->nr_targets);
> > -- 
> > 2.37.3
> > 
