Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D13285C88;
	Mon, 15 Sep 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920761; cv=fail; b=oMKy43F21mgOHwSkvpdUUL0ovUimt7+3/JCZY6qTXalJ4oR89AwFwqEuk5+kKpN5lGa1ZoYdwz1/xIvk1TK4c0UcGry9EzCIQdHOZqavEAhdkzoyVornU/v88N+BeOU/Mb+2LoyjiGt6nZtTPWflKo3AyWm3TVuNuqih8rGObsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920761; c=relaxed/simple;
	bh=0YTFyaH12auwRJ+i7YQykLmW4UFukIIZ7+wl1aAe5zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y6HfVrLuIew+z+NsfJfwf8mu4STKBSlOXBpwPNEHWHanlR1iv0IvxWIuVoprLxlPMg+Y/Z/AoOzczt3DFh064czeuOFZJpVQzVOV9pIiF4RJYPR1jlvS2fcljJSWWoeF/Gk2lxytwmgIlMRH4ug83hzZMMwkcQDYS2skawyeG6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4agMFM94; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4agMFM94"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSegOFLT287PO6puerBFQjdAwHfg5yhdIiKla5is6ukrk/srIymXJzkDxSMTXf9aToA4MQYznX3+1ijjdKBYjZDcyJxcGgA/fliI6WdPOlWmV411EJk/Oic9l4bpQ8rB6Ivnwx/qS3QiUjXiRrKq9YI630d5YFpxZ7GBh7RyvmsfuWHty4om0gp7W0AdMYm39ZtAjiOy0HoKDferIo70wznRzXcziHT2ys2mi9u3UjEA/+KywfEtldgdBEw7O8M8if5TJyK61bCZU2DEKf2s/XJVJVm9CYORjgFs3LuJG0xqHmvdEkv+8LJOjn2mEx78Mnvf8yD5iiEAagazqI5LYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTiAibCb8L5xTysAuI0lO5eRqTC3bWDkmz0cF4oExTk=;
 b=SrHbjMZ0mJTpkDe+mOJ1iRzBvZFAVICaOrnh35o/UnKsRZMOlEQ6k4p9uEU5NAXiOqbaN1iwhXFi6VBs1A0h4ncyKttbHsz+qPnThXWOpKtoDsBSekLYBdg7akLw2nQIaMoQuNQcxjK2QMNdnjuDhfr3QSLr/eYDG0tk8RfhB7rS0xW4JKxl1gXuvfX6+CStUvfi6FxXf4RVyrzA6/fKHoxpLh270SaehQ3M0vf3616NdhtOCDpPMjvTb2dlLN+drGDtzPd6TR7ygLZZ6kwZiWgsJ/GKyF+Uwp7RLPVHtU9Jyga8j2pu+p7MGnGmYP4MyiB2qTfrX9rn/5npNYvPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTiAibCb8L5xTysAuI0lO5eRqTC3bWDkmz0cF4oExTk=;
 b=4agMFM94qsJX1suRfZhZ4gdIdwJX9Kl+3z6fQom3y3xNXrosbwd1pAPGi1sTI1flRVOv6rz56VRrPA7nJ+8CgfOeL9OoGzJg/Y2P5g5r316voHub9B8irLdDRT/HTlkazREEiG1AAKaSOFY3UIWq7iwgjKxfIepdyebBR5cgxYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.18; Mon, 15 Sep 2025 07:19:13 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 07:19:13 +0000
Date: Mon, 15 Sep 2025 09:19:07 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 02/11] cxl/region: Store HPA range in struct cxl_region
Message-ID: <aMe96yaXueRvTARq@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-3-rrichter@amd.com>
 <fd4fc0f6-03a9-4134-9703-60705ec6898c@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd4fc0f6-03a9-4134-9703-60705ec6898c@intel.com>
X-ClientProxiedBy: FR2P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 5548830f-f6f6-4c6b-9339-08ddf4282c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?439+xpaYSKYa3AVNb1dwPlrB6fd0YqitTuaLvUhy5bmyOTPMlfcumM6xBalI?=
 =?us-ascii?Q?2yF6ZCCEbnAq5HcBMVS6zJnnAw5+TuDfUSSNuKL4EBUDBSW4XUMu9tfII2xB?=
 =?us-ascii?Q?qskSt6D+qBZCDb46k30Wonsw7KuVSJX0CrmccVpUvPrboZgW7focIEW02PmH?=
 =?us-ascii?Q?g3VYOUq5vGuDM+vodSVNH5kINWqn82j9xylXbaJfqH8fFVncEp50FZwvTinw?=
 =?us-ascii?Q?foz4qJwrca/qdqNbWwa+dUf2AY3OjPStMQTdB0Doo0HvgeC6eevykmF4liP+?=
 =?us-ascii?Q?PVX+c8NwBZ+erZAUQVb/1DoyewSUvfuCUBsPjEF4vjN16PVKIAWKv4CpNUcd?=
 =?us-ascii?Q?pzOxiLVVjysTo8aCZvIKIhzVsQgQ5Qv9ZXj63Bf/eHhHKWfbEnfUxqGguwAj?=
 =?us-ascii?Q?e0hcPvGzMECOpp/V0KICt+aII/5SKssCC38f0nOJgXdmNLP0CEmWPwKZxXw1?=
 =?us-ascii?Q?ul3Jt215eg9J2t58Cgx1cw9v3UzktBMIotV/4/f7ETNcrglnWem139EVISMq?=
 =?us-ascii?Q?jx4x9WNMUu7Ozc2deqQlmNGke7zXhFsBU/UaMGdro78VSuYPKBtgA1MzbgYQ?=
 =?us-ascii?Q?/3s2T/GiQfTNTu1vpaccGdm74kKWhaIqunS/yhrjLo/kYPtDLQpgwQ9LKyYR?=
 =?us-ascii?Q?4R6PwOQrEdBsVhnXs3utrzMG8mQipr9n7UR7JPfo8r7bV5bAxFLmjMu2hibS?=
 =?us-ascii?Q?qpAJTjUIUt3ps6zmO1Phzzhni9KHRt076OSBNqB3HmrX9KJo9RG8DvdgT5Tp?=
 =?us-ascii?Q?EVEz0GGJEkkPSKjnjHB3dg+dwI6c1iD3lW+gL67v0qzdPPR/cotXp385vX/6?=
 =?us-ascii?Q?s88CBu9YprAZTl+Tko6+SRjkqvPUTbTA5s68IouenpCcJO5h7bl4qBsY7OY3?=
 =?us-ascii?Q?owHxpzuvYBcO70EPb5sOAYxlUdWGEKwV1yPhtjlQmtZpVkgIy8VwpYPQts0B?=
 =?us-ascii?Q?lFlZqXPgPk3P9GEF9oiIp/MKCbLfaM1ZEyZ+XMg/NwVn1DMMH+hPYsnbJncp?=
 =?us-ascii?Q?UTaOsB3y0fSIdaMsNiWpfMvcTJeNbY9UrJvumJa8/ZG36RXOJ8K1SbHEgknZ?=
 =?us-ascii?Q?VOGOdCnQ1L2fnW1nDnmw9ujcNc6ARAxg4wtQxPIOgCtl6N7SHwAd6Nh1KUVL?=
 =?us-ascii?Q?RmqYrLeLRsyP3eHyO2u29/YuRUJsWviEjvDR7tO6KKb0mbjHWkyajuy5Vaeb?=
 =?us-ascii?Q?N6XkvXR6mlOHiKNqVye+NQ3opObAU9z4NQvsf3Mquz/3BezyeVWsg7LIe5F/?=
 =?us-ascii?Q?59QULgSAoe3xqIKZlYoV8vhWL84jHtJ6FXs8gsfw+ZUIQKswWA0D0v8+7Wnq?=
 =?us-ascii?Q?qpXJeRSd4d9idCcogt4+9dQ/oj2IbKFSPgg5gY3O2lU2beeCzFtmPWql2Med?=
 =?us-ascii?Q?iXU1twYPD6uUhLIU3YywfEM7vvDaN4EldqTS4O6bZbruK9b97g6siUP1xiva?=
 =?us-ascii?Q?gzYUVapjkbI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UNqZmIAgYk9SHkYDrxzA561nDyniFwHIOSQuSJN1QTk54uoMBPKnzAAIErN+?=
 =?us-ascii?Q?TFt4+1coPyxLg8a1iWQjSjPyTXznKzH8A0Dbd1QHt5R5sboAUj1iNkjoyD08?=
 =?us-ascii?Q?pbfKOGfgCld4mj8hp5A9MvK+WjtRXEYaaPTc13877e+CtPKqt5a1Z7NXBXwt?=
 =?us-ascii?Q?O46FowLX2hctXCdy+qDvIQAce0PRm1TZagVPgv7mdoY7o90QsBkK4lp1ktqq?=
 =?us-ascii?Q?HsM+/SzV6Hc65fHN48E/Clnhui4zPbxSRR7bbpeu8hNxNdSCzIDaHDtq10W3?=
 =?us-ascii?Q?iNpJZuGh1SsXC1+nfrTPZN0WAex9jK5tV+AktGEASwgN83vXS3xv+G4YkciO?=
 =?us-ascii?Q?YUItomNNiiss4XRf0zG5FQP2iEd3RpyEyYsnz+1QseeHQjNL+6anEJj6f1o7?=
 =?us-ascii?Q?W8dETXe8vEYnsuhcr3K2hIaIeZw2yx4B28NHmBgW7X3STVYRnX35EperKWow?=
 =?us-ascii?Q?Dx0yJFhh45oRymzQzg1NPfSYySPSvJVgbJivRcJ40uSULFrZyXBj/nzc4KJ5?=
 =?us-ascii?Q?0y1askJCigwO95cH/d5QFJVgWPfu0b/NuFoRmzrZS3H5BXtm3EHWTgPuhlop?=
 =?us-ascii?Q?2hj8/POqg5u7+aCBg1QDekCtzfGIgkbKLde+3eIsjr0z83km/DmXY4uc3I67?=
 =?us-ascii?Q?yB26zUlh5m7IcIlYDeD6bweNPHsaI7cdRbSFbJVkTguSQpEwY3BCjpR4ZvK7?=
 =?us-ascii?Q?qBkxfo2p8jGuI595rrhj8qXqrRD6nz8TuxoduQmye+JTJ3u3vG0Dhc6fI+2O?=
 =?us-ascii?Q?2jSsuHdpqJ88oidT3P7+UJa1z+jmRBkGlhEdJgMPgUq+Vn86GjqsXXJikqId?=
 =?us-ascii?Q?tjlF9DD+bE6C+ELMh9UqowZKv5wOG5S2QnwGk9M/rfxWepYFL5tEN/tAS7nF?=
 =?us-ascii?Q?/8JbC0Q2Fi4p8ayFZe6oJNEhM5iiNWsIX4zPLTL8uQZF0Jzrf+cwS0U58eVs?=
 =?us-ascii?Q?MtFHRY9ehUfB/JP06tTVJaI94CL/1WWXt8+fpkCyRPXpsB4GRNy/qOPLvmTB?=
 =?us-ascii?Q?B9Kmmqc5C6Kd68KEWHqNE0j33p34lZ0QJXpEEtaCo140QiJMEiFxuwesr7qo?=
 =?us-ascii?Q?XxtB1H/uHkZWsZqtxkhZjqSIA9LW2X7isVLoZYW3zcnxWN94eXFdVxhVr6n4?=
 =?us-ascii?Q?WSsLLFPJSA74zp4Cvw4keTPmGLOa6hUOIPYIBArCPCkEvP5OLyUjzsDaQXiT?=
 =?us-ascii?Q?HnyqfUKaw1hNnlOV0IfwDq+5lxQ31/3H0vQ4mO4bDTsLCiPQv+WcFFDiZhH5?=
 =?us-ascii?Q?ksIbxAppp4rAI3zZ9EQpcwaJ6esxBp+KJYr8pKrNAR60OQ/EFMwLm9oAJW9G?=
 =?us-ascii?Q?oIyi5t6sdpgZp2GIrijFgYArZUNNgp8OsPY9Q7paEvRDB49sbt3L+9n8wasl?=
 =?us-ascii?Q?drzdngVJMeYvpFL9qOBPct70jRT514syE8nyh7Pr3f7SUVr6M0AcFtCj15Pr?=
 =?us-ascii?Q?YbIEC29wUsxVrYAG2Ct5P5byEj4dLf8TeccSxkI6/iv7L+iHkChb+UowpMe2?=
 =?us-ascii?Q?ylYD+b7Mg7eu0OKzOTbqHkqxRD2XUgqYPBRoxDoH7h1WFR2CWnPegZkcRlKL?=
 =?us-ascii?Q?4a+f8gIevCESBzW8NnXjAQ9VlPt0CQhOIEKtrlCx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5548830f-f6f6-4c6b-9339-08ddf4282c03
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:19:13.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0yhpwLLLG8408fUuT/CWR3bvw1IQSB9j4pK2366toC1mxgjL47E2Ues6jGkh9Hjd/+v4zAu8mksoy4ltqc9ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010

On 12.09.25 10:17:14, Dave Jiang wrote:
> 
> 
> On 9/12/25 7:45 AM, Robert Richter wrote:
> > Each region has a known host physical address (HPA) range it is
> > assigned to. Endpoint decoders assigned to a region share the same HPA
> > range. The region's address range is the system's physical address
> > (SPA) range.
> > 
> > Endpoint decoders in systems that need address translation use HPAs
> > which are not SPAs. To make the SPA range accessible to the endpoint
> > decoders, store and track the region's SPA range in struct cxl_region.
> > Introduce the @hpa_range member to the struct. Now, the SPA range of
> > an endpoint decoder can be determined based on its assigned region.
> > 
> > Patch is a prerequisite to implement address translation which uses
> > struct cxl_region to store all relevant region and interleaving
> > parameters.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Just a nit below. Otherwise looks ok
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> > ---
> >  drivers/cxl/core/region.c | 17 +++++++++++++++++
> >  drivers/cxl/cxl.h         |  2 ++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 2c37c060d983..777d04870180 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -664,6 +664,11 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
> >  		return PTR_ERR(res);
> >  	}
> >  
> > +	cxlr->hpa_range = (struct range) {
> > +		.start = res->start,
> > +		.end = res->end,
> > +	};
> > +
> >  	p->res = res;
> >  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
> >  
> > @@ -700,8 +705,14 @@ static int free_hpa(struct cxl_region *cxlr)
> >  	if (p->state >= CXL_CONFIG_ACTIVE)
> >  		return -EBUSY;
> >  
> > +	cxlr->hpa_range = (struct range) {
> > +		.start = 0,
> > +		.end = -1,
> > +	};
> > +
> >  	cxl_region_iomem_release(cxlr);
> >  	p->state = CXL_CONFIG_IDLE;
> > +
> 
> stray blank line
> >  	return 0;
> >  }

This small cleanup was intended and separates the return from other
statements to better group the code in (sort of) blocks. It is not
worth separate patch and it is common practice to have small cleanups
in the area of code that is changed. That allows small style fixes to
the code while reworking it, but avoids separate code cleanups causing
extra efforts, conflicts and the risk of changing stable code.

Anyway, let me know if you want me remove the change.

Thanks,

-Robert
