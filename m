Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC26180047
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jul 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550036; cv=fail; b=n4fvH7OzU3SxPLlDCLGRH7pH0Yh6YUlbpxRyIyGKmJVfmairMV0LuvJk4twIwMX8imB0nb3Yvey1gYTRrKiCjl1VUL4P64x+xgAqlHE+UTAysXqhTmw+dPL5efAgvAJ2hPP/njnWq9p8FA38XmnG9pC1jMxG2T3W2inJ0Uy2FOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550036; c=relaxed/simple;
	bh=Sqq9hUlLoO7OroG1MNs1G2n/B8OSTt/gW7rKy5HZVBA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tcfagJ9mssTopG+PTUh3/cFWHBS2QfzZOLpUS03fS89QGmAbKS88GIOr/5bNWd7N7YecaAah7nBz39FpDXcbN6oqxORC7bFNKqDWpdaAFL0gKO6BiADZMSombP0GAuxQRI69g3JjdVqJwmVDTQrnpGYITHoWTi8mdWSMWjoDZhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fwGt3Owj; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fwGt3Owj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720550035; x=1752086035;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Sqq9hUlLoO7OroG1MNs1G2n/B8OSTt/gW7rKy5HZVBA=;
  b=fwGt3Owj7PZuSm5p68YptUtKbRfBdoE9fL2QHprPTnfd7lPH/cJEGr6t
   mhfi6p49tSE3jC5xGbjh97croO8WrDUJx+fnu8S1ZqYuauD7kHe6ihTCG
   Y88H04s5WFCKg31a6T+6ODNjnvM53NVwD+I44oVocQX63QfSBEYyySrWM
   isFax27yCazhYeD4IxbiYMzo0fK/f0r6Yh19E9+mic9zyZ8lapjuvEPkC
   oTMe59QbfW/my01kmLaxskNUct0v3sAITj3Na33Ba4K/bEB+C6iwLQyTw
   SLgSFpj93zbUS9o+nbW3DX7NEW9yTFjDnis55dc42nbNZ0IBg0XX0PPKW
   Q==;
X-CSE-ConnectionGUID: djtnCuezQYaoZS4kYS85hw==
X-CSE-MsgGUID: PQ08EKZbQVOF/T9+/HIx6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21644067"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="21644067"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 11:33:54 -0700
X-CSE-ConnectionGUID: vFPdjxcnSXmNR/rCQW6O5g==
X-CSE-MsgGUID: tfApJTlSQliTtNpC3e/E7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52892031"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jul 2024 11:33:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 11:33:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 11:33:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 11:33:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 11:33:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbn3K8Albdqm8c1hxTeng3CZRVYXEZMdkySh0ebl8jcOgqs9YMlNAK7Gmb0hgfnS5Z9wfDOlArLppTO4T2/PEaIX93buMb57xjouyY5r5KAmYDyFqF3J7+sw1D/SpFqQ5TEP4Wifjz6PzoQIVbVvwdeztJGxDatitKgaxkCz58SKe+S5S7gmscrd3H9Z7r1XulshAGWaIEEAov75McNsVFb2pLu+y926i2/rX+rtabLtU+Vm+5+JTwierv7elLfSEhFkexMXTmLNPr5SObZ4XDw79ebqq5fPULU3sbSqs29kAWTHrrBok08XGr6zDQYe+LOalKEjf/ksgyO0U4hXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fW3ifWxq8ox9PwBTD90gf1SXEwKMwM0iZbA1qEcmbWc=;
 b=RAKAm+nfjGFazoiRnQitftkQ2hniei4YG7DG5TZ9wLXxHfuEEW4QJaam8zXGAPKOAfphFDj2bv8ml82lZVA8cScrzmR6098OzCxOgQwNkTVyXF924y0Vim6Y//bxPSKxGsUnKdsL0l/Cg+mRLY+w/B1GQFwu4DwXJAAqYBGp6M4Y3G5H8Z18if4IUZ5wNOzE8VysoD/mDjX59XE2QBTGsyeWl2kvcCg/honauwkWJE7smZ2Wbi9LCs6zSL/E+j00uVg06G4s76Y4FW17LM9y5xqZsgNCXbY+ANUIDYmkT4AT+APdPEodL9nkaL3yZKv8KV4ukw0mFn/evGHTxApTUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4725.namprd11.prod.outlook.com (2603:10b6:208:263::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Tue, 9 Jul
 2024 18:33:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7741.027; Tue, 9 Jul 2024
 18:33:50 +0000
Date: Tue, 9 Jul 2024 11:33:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Christoph Hellwig <hch@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Yee Li <seven.yi.lee@gmail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: Is there any plan to support CXL GPF in Linux
Message-ID: <668d828c33c87_102cc294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <CALX8JfQ1F+DJ1woPP=gFvnEyy4qHqGkN+94CKG5ONQy+L3C5_A@mail.gmail.com>
 <668c877f86daf_102cc2941b@dwillia2-xfh.jf.intel.com.notmuch>
 <ZozTTpbMjff82vO0@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZozTTpbMjff82vO0@infradead.org>
X-ClientProxiedBy: MW4PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:303:86::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eacffa9-ceae-49cd-cfc9-08dca045ad6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?01Wx5S1hDAHkRoGWR7SrvQRAhY/vrFCFuPVlG1/97loOKJ/8EHi1Gei7zpC/?=
 =?us-ascii?Q?d1neqqmD5xP2is2m80QFb/jIJVqyqDMJxxw46wJ3B8ytUPhc7O2IEQOAfTDE?=
 =?us-ascii?Q?G3ndIFlGj91lxuj8WLlEfpjyb09PRKmuV+Gst3jtNocLSEafci98rIPLO6ud?=
 =?us-ascii?Q?3U/m7eCJJNSZo9UuEvo+YxafmNHW888w8UOmTfuutpRp/KsUDRzKMJmfwVqQ?=
 =?us-ascii?Q?stpva10B7CqvLq59ifZtp0LGDgoFk3t9aPNiAdJng2iHKDjYe8AmO8gzKcI6?=
 =?us-ascii?Q?Q9pwRl+i403DlIzVdiOrXACe1VnEcc5+umhQrLkxfK2BTVpfvzgLYUGOQzbt?=
 =?us-ascii?Q?7sls47/DlAO9+HIQxJj9T0JPluaI+Y1KoZqaa6SzWcgPTDjW1yY/0+GOdjuB?=
 =?us-ascii?Q?Kt0+ZJAat3NsRf3g2TM8gh4IygC43v8v3Yvv8RCCOjRewNjMWXU6NkFGnUuu?=
 =?us-ascii?Q?bfvlboXVGKoLrTJTxFPz/6rT+WoB5/GsGM+KLnncnpmnxefaF0GkVV7qm8IT?=
 =?us-ascii?Q?qNShHtyUA5mi4uvroO5V6T3mh01/0OYZrbq2mRVhiGLhC/jJgwqF3dKGgIDI?=
 =?us-ascii?Q?HQHTyYpfizCv9Yh2ydtqmE3PZezbEnXAdXSqxU+eO8Q6IBqSzpLCBN7xj9Iw?=
 =?us-ascii?Q?GdOwYYPmPypK8pNIHN3l/PdS3Tc09FPFZiwgIZbUKBqfP/o93z4fhsmRUwuu?=
 =?us-ascii?Q?25L3YX/UuIOH704wpaclS/HeJ2B/M2OjKIn5DbX4RdAO1bM6bP+d62RKkLoZ?=
 =?us-ascii?Q?6ypOalHUcxjoHF298kD/l1lxTx4wEy4wHGWP3rJ/A3tfx30H3nS5828bjmCM?=
 =?us-ascii?Q?imgSUYbpkMztsvIvrD9v7lz9Q52vVOKab2n10E6K22VSu+CbaZXsPh+dK1WZ?=
 =?us-ascii?Q?oQnLJvfgIzzZ5qzQ55M1MVcUz2fGK+eYCpfYFzUFodm5I65PmCizrKyyYOud?=
 =?us-ascii?Q?C73zXMwWZef9LLtQcezvdwTeFukgbzSBJUzAC4ZDYZyIesW2+gOJl2Gp6gUZ?=
 =?us-ascii?Q?Bs/TEVaRkLq2EXfTYWQxTH4zoevzTdq1MSsjLByv9dAHd7iXvDl6frVOLi9w?=
 =?us-ascii?Q?XFKlibv/cjgHS03nSIYBGlHYdf65VlGRIyz9roYFrWrDKFAIWcTMY0ADvNIF?=
 =?us-ascii?Q?3QEOagF0P1WDiDz32+eSW1CexdIa7Q5Pa4qT2nL/+EzK0GbKb5QqNSrFNTIl?=
 =?us-ascii?Q?j0TrJmusH/qbcUwNCe70oP4VIMQsrPzOVFAmxAY1KxxMOyp3mEe1NJb9AP7+?=
 =?us-ascii?Q?qJuBNT029twEe34dogTzX4MgeiSYXMXzqGiOushV64DanHDGKoxTVNev0a1w?=
 =?us-ascii?Q?ENcsUlxbFeKZFyQht2/gcsry+IH0zvOYTF6oedx4MLSP4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O7HNgrzSwmfShEBs5hMK0f+P9mb7ujvgeulatlg84gwbAQQdM/XVqtQdq/OU?=
 =?us-ascii?Q?2uSY864KezfMHF1mi/bD2H6H/8W2mxQ+Q83vY76Y2rmJ9SrM79fKdCgsbZOl?=
 =?us-ascii?Q?Z4k+2Hf22ZSUtk6MM/H9bcS79r8PxCGwfPMyGN1S56lUBicDdKJzfDFqIWhj?=
 =?us-ascii?Q?ptuVafL/RDjpH8E56wxTOv78x2VmzVZnNfxG1A1Vg+URiAqdJgw1VNzlaus9?=
 =?us-ascii?Q?OBdl0ub1g2goaaUZ7huinn0HSe9ITDEnh/kGnPP1EF027REHYRKO/EDE4UJN?=
 =?us-ascii?Q?szi379+Z4rls5njrj7a5YR/6cb9l33u7rYulu8P4J+g56KN7tRSREnMc4kMD?=
 =?us-ascii?Q?odFuEo+BFvJnaziEIAspqhD+WSZgAhr4CLmsjyWQrXl+Dj5OMeIIdgXov7L/?=
 =?us-ascii?Q?g055aFCXdz8hP5mxfalF20IlmeLKcGBD8+jJXzHz2y5PmP+JlctqRsKJ2JyV?=
 =?us-ascii?Q?9EzqQGdz9/EeAV+XmpUmJJs/8Km/XvVuSzpfrlkdC8BIToTIYtcsgX5AGjbF?=
 =?us-ascii?Q?atSv5uJsrPI/gsVdYqJYj1V4KqJ5HN3MlJXKkdqKva/n06RZgwtwSbP85JtW?=
 =?us-ascii?Q?KJjD0G17li924B4Yk82whwFkcd4QoW/uVO4zjD5SvC3TJQkbDT2nf0d4AzuJ?=
 =?us-ascii?Q?yHSyjLs1JapPUjKr82Gy3Elu05jjtYHmpHASHbhcBhV0K91JCFVX/h/i7cnx?=
 =?us-ascii?Q?9NvZjvTZeHrWcOebMrhTXoLnGwulzyb7DnLcNmFTO1a5+E3dQIx0s1c+Tm9i?=
 =?us-ascii?Q?X3geM/oPREkNMS2bmN7MPbqGPy9ROHAcB73vqAbioHmnJnViffWMTU62cbQ6?=
 =?us-ascii?Q?bo7Io6N8lUlwMmEx2HymJsDDtCS0S8ve+dR6Dxvl3vs2QU4p7dpZl+oL12oM?=
 =?us-ascii?Q?0m9FfxiwPNWD+OPmKtLu3+A7AEWv5mAztWUN6GJIBOtdWPg6LW/1hYEK5Nf6?=
 =?us-ascii?Q?rwHySuS+tOu4B09mexvTreppJrmWOBT/Tgc+uk7Ct0qFJuKnJuH5gfv17VE9?=
 =?us-ascii?Q?5zoEToEo+GIj/GR6A8mhqLKOsuDz+Yj119V/uL/vwgUrRyTCpdRQ82i4ArM2?=
 =?us-ascii?Q?xQTNO/LZGAY/tbODG4wWO//8ZsyJsImNzY8mByozFwfLnSny9j8CA9yw+GMT?=
 =?us-ascii?Q?fE+DpC6opnVI5ahq04Gm+EAoS764zpN2qhdRg5aGBWn/uVUPGaJuRnR/Z08D?=
 =?us-ascii?Q?fuufLlOl/Eiq3Wg08NqASGfvs71mIfMlfm8QCpwebOnFmV1pCzpeXzRYtd3C?=
 =?us-ascii?Q?asDlK8KUNo9oVT3sQmibAeQu8mJSljUBs31fXh7o9iQDROaFD+cnQfzjcEbu?=
 =?us-ascii?Q?8Ss0VlqjetFSPQXU/AYiH5gYyeLAXZMGRjt/prFjrxsV/I+3MOKlYxUR8QzQ?=
 =?us-ascii?Q?/aMtqaqGT4EMrSDBZb2IMLVRjdZj2t5wr+dCC+tpU+tCMpykvqzTJZ8e2y5Q?=
 =?us-ascii?Q?ev2fsS+pWwv9fffxPa81XaCfqIstsbv+TP5zZ/3MwbfiT3ubPQa2WfvqM83q?=
 =?us-ascii?Q?opLkWkTlKVbvBt+QI1SDSgcug2QgY68IL6dDhGqC85Re6pMxF+re4NXLUqhq?=
 =?us-ascii?Q?v7rxHjA7NChxh6lMjcFlqwAmZSzgsaP00GNXlSOj1ukawkg0rvJquwP4HLkz?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eacffa9-ceae-49cd-cfc9-08dca045ad6f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 18:33:50.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHe0UJ7KesnuH0HTpiLW8iY5v5aXf0zUPVbTMpY4QLWRSvL0jtBW0WnkOhx40YvwsP77q7z0ywEfl9TIf4pcZLPG01PI67pJpMxorbMhsLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4725
X-OriginatorOrg: intel.com

Christoph Hellwig wrote:
> On Mon, Jul 08, 2024 at 05:42:39PM -0700, Dan Williams wrote:
> > One thing that guide does not cover is what should OS software do with a
> > dirty shutdown failure. To my knowledge there is no specific plumbing
> > for handling NVME device write-cache failures beyond: "hope filesystem
> > logging and metadata checksums can recover a consistent filesystem".
> > 
> > I do agree that the driver has a responsibility to set switch timeout
> > values, but that is more an unfortunate complexity imposed by the spec.
> > Just set the max and rely on devices to minimize GPF response times to
> > avoid the worst case wait times that those timeouts imply. In any event,
> > enabling that is "up for grabs."
> 
> Why would anyone specifically care about a (presumably non-volatile) write
> cache failure?  A non-volatile write cache is simply part of the device
> and it's failure rate guarantee.  So any data lost from it will be
> recovered the same way as a media failure, SOC failure, interconnect
> failure, etc.

Right, my concern is that the CXL specification is over-specified here
in its suggestion that system-software manage the dirty-state each boot.
I assume that if an NVME device experienced a super-cap failure that
prevented its write-cache from being drained on power-loss that event
would be logged somewhere. If administrator did not react to that event,
the kernel would just keep using the device on the next boot as if
nothing happened.

So I am more trying to preclude complicated patches around
dirty-shutdown handling since Yee mentioned the recommendations in the
CXL driver writer's guide. I.e. do not follow that guide explicitly, and
the recommendation to tightly scope GPF timeouts also seem over
specified.
