Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B781BD9C0;
	Thu, 31 Oct 2024 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410497; cv=fail; b=spXvpfgIPfAhmkb8qrn0J3g5RDcHCzdB3Gm3haUjBLN195BGoIoUFN67cAIQXWYtxiiVxS+s1RRThw86bdzuem9iQlpFzlU5sdx9c++ni/QKd0/WWVkyZSBy6OYqbCa4WhkOoz+KsaJJrPclL1OGeyt3OlD+lmPFkvq32QThfdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410497; c=relaxed/simple;
	bh=LAIUbJP6n18k+2vaI7aFLfNKBQ/jfNnH0c79lijvh44=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ft1bfXlwP08XIzAJEirvvdLhirlpmGyOjenpq5ftwsktjLeJJoP+n1Gxi3SUJo0wqH7qJ33IASoRjbkQFksKHIB/K3a5dwOLcZCjT1czlsAplwF4cyQHZnGz+q9elVCVFny19CgaA4G8+tac0ISanb8/LjyguCn+nGkZmoRelqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTsVPf9P; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTsVPf9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730410491; x=1761946491;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LAIUbJP6n18k+2vaI7aFLfNKBQ/jfNnH0c79lijvh44=;
  b=CTsVPf9Pu1kX0EiX6va9oiQ6tJoI9obDL1wmn1YJtiaS0FUtkK0N1VOe
   ACfgLgkVG3kqBC551b6T2bvzWv8cm0Q7KTG1Q2wPMWFIPJWUwn7cnUDM9
   S+pH7uWnV+ZkO63/kW/1lMe1Hsmfn0So5XF1bD6FzQ/C29vyEbJRxH98X
   RUs6E9GvyXw44GfUG3dxaAAfPHvDTZr8zEHTTSU+ccMs7eo/IaNUb0Cjm
   noRJfc5hAdLmqfcacdSC+GVyw27bCViEmh1l/6ceCRIk7MNMjonQLLGi6
   4U1Pmfq6SS6x+yzXMf+PksZvqjL0Ei9l6cK7vhp16/BOXqUoboF/uTAiM
   A==;
X-CSE-ConnectionGUID: hS2qDMeZQp+EDF6rHSjriA==
X-CSE-MsgGUID: ZLTZrciFR1O9yW0n0xvQbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41541944"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="41541944"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 14:34:50 -0700
X-CSE-ConnectionGUID: sHy8ijzGSuaMkFYltNDULA==
X-CSE-MsgGUID: XfsIyOG/SOiNvvhXHdImYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82440277"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 14:34:46 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 14:34:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 14:34:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 14:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uX0REdmoC4/mQfiTRSj+nfo36X+lcF9wPItqw9TsiDHaqozMxl1XCciWDQW45m1LDezQuUEKlINl9z7IX0suGXFZcSlnSzcvhsav7AWl0feiKydX4uo2l+fQQb184BhiMP/uWm1sDn5j2Az3DBpR7vSQA/EQkucyJq8i9YOVvp3DzlbgWtOyQbL5nGIJ3gn6LA36nuziX4boWhXmQAIOYEfyTn8fq/vqP+mzjAX23coqG7Sj8GDbvs6N0/FxZbOOc576nq3j3pyN7lvBqujlshX7DviK8KhXByl9kNNsrEhLCWl032vVfa+rBnEUuq2L/R6vl1G3asgE0KW0LbB8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuHmcGzlMUJxsIn7+EhS/amxKbN2tXsDvsgdo4qQihs=;
 b=UGPtIdeVKy0Ms8N5sKZVVAzTc3LDmNsJlzv7CTwCreqvf5M+vJbkQ+tVvjeA3hUgjUhXmbh77NOfqrCbK8qn2LNWA+iOBloWI4CBYJ94G+XcZ5Y0rQeFVTmu1FEH7E+d3Bg8il6X2FMg1x+/PFF2bEn1GkyUinafT7VswV/22nmcoNXdf7QEBR4FpKEQLUuz4Ktr6zuH4v1aAn7MqWOZ9rg/mw8WDkuB3DbNPxq1C+sbDk5rD+al0oi3cZxJF3XmqT+osxScOoWJNxm8OWsY8XAmf/Qiz5EsnHxzCqzcg6a2kwESELUsVBKjowe+xNxZHVHR4mQzFt1hZAvhtNuSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8796.namprd11.prod.outlook.com (2603:10b6:806:467::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 21:34:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%3]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 21:34:37 +0000
Date: Thu, 31 Oct 2024 16:34:30 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: metux <metux@gmx.de>, Ira Weiny <ira.weiny@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
	<rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
	<senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] printf: Add struct range print specifier
Message-ID: <6723f7e664470_7b1f129430@iweiny-mobl.notmuch>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
 <18854680-4ab7-4453-85ff-78351d4d4ec9@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <18854680-4ab7-4453-85ff-78351d4d4ec9@gmx.de>
X-ClientProxiedBy: MW4PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:303:b9::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e6b5eb-ded5-4d80-0cfd-08dcf9f3d1e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fZxxCVa+BeHv2wRq3UrZfmUdAxxNIxru4lhTpdHfyxxLyiIvoAO+M7SpaSTt?=
 =?us-ascii?Q?5BRls27NwSOnXd3/Ab7mcM4Rrc/OQRclDQylk66r5Rx4TAqpiTaCOhCGyTmJ?=
 =?us-ascii?Q?Gto7xXs1DW3RY+EgSJBUDWeJvi1XqyaD8sl9oaOePnlg8b4q6NhEtOoT/ji0?=
 =?us-ascii?Q?glqLFJKiysFki1D3o0Hro600Eo2c7/QSSpDyID0tHNZ/x+60CNmoRtKvscpo?=
 =?us-ascii?Q?WAkU5aoLVh9fiT0evm6slLxuiETm5G2hYcg+MIFajBUqv8GgJJem/ydQPKqM?=
 =?us-ascii?Q?aAN/25QGBIDrpXRSeQ5uSV8s1pTwRF7D4sw3soMG2X4xJGDG+/gD6ixyHga+?=
 =?us-ascii?Q?RTy3cuiOKE0onynxZkCtj/ygooT7cfrlkeXK0Kr0LgvovsARRhGNaGpzi7er?=
 =?us-ascii?Q?bFti6i4MJxHkLr5Q5enPg2ObQCshFuLBH2pbuJX7XjSMDJ/cDzw4obaRceux?=
 =?us-ascii?Q?5++T9qjHkKXCWLnlHAPYpa5duO1N3HxEEzUJHJur7DiOsDj0+gDOfpI+Oebw?=
 =?us-ascii?Q?oDBhVFu81keh6XnBHWaMH6eVTsrcK7UgUBhjBAGMD1P2wYaYwZ45OQKudQDT?=
 =?us-ascii?Q?+o5vEk+jQVcvCdGpSsywWByMorihrIG7AOBYfvvDb5tsjcp7jfhmWUYwJPmf?=
 =?us-ascii?Q?Ti615aPAjyunhdZuazfAR5t6zg40GqwyaNHKDyTI4xfCI3puWiN7B41mF6JG?=
 =?us-ascii?Q?rg19tO4TtYfWVCom4Q/BR4IDCaM5+deoJzAXOz9niH6C+oak/gPTB+jbohlo?=
 =?us-ascii?Q?ZbnsYCKerugsulUm5YUEOXAsdn04WsrWokbtdc5KDBYHt2GumYIjQ2pjHKYe?=
 =?us-ascii?Q?dz1ZaLqF0iWHHHK3f7ujg3IuS5XjeNfRkYNb+itc/6RAVGxuklQYFIag8eX+?=
 =?us-ascii?Q?MytpPwjBVaczNixl0HIkrG8NBTc2YhXEWu7LdFH5XShXk5C7lL1lx4zacvoQ?=
 =?us-ascii?Q?ATn5ddllf3ek3JvqVtRu9LkN0u2x247ddFZN/G4bbqifYtNJ9dzLV2itfM57?=
 =?us-ascii?Q?9EnP1nAOv0Bia6HJ/VXt3ujBc6Iz4Nz7WtNorjUC3O1ap2Pe/3quXssT+LD7?=
 =?us-ascii?Q?y8/wb+r/NcuAWkR9PEfqE6yqZzA99YKA1TBRZp1NprAEi4Dy1p380M+jVSjH?=
 =?us-ascii?Q?+Gnb+IGjde0QO1WqI+nyjvnBtMRdiGw7IEyqcD0dgtfB7Uts5xc1CdlNwPNc?=
 =?us-ascii?Q?7GXbvKalorAz6uGX0tbRz2g2CW/UTDtwgMx5uAMJ/V1gugQFweIrJss/cefK?=
 =?us-ascii?Q?9PFAgnd/5CASN/5Qov73KErrBNTbzcnl9ewaITVHjYsjVHDyZW4RQByv8MYu?=
 =?us-ascii?Q?WldxlxblMYh6rtweXuT/3o/GQcdVVGmCS6LLv3H5+7uMwyPTnJyNg7j/+3vt?=
 =?us-ascii?Q?Gbr+yM8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KrapXK2hz1qw2zqwvkaGifmaVflDhDI1sjYl07DfElssdNaf46NoA7+amn3W?=
 =?us-ascii?Q?luDoQF4W5XgZpZ/nUeRPjr72voc+buKTk3YR4haTUvT9HbT3JTlSUkIp8ukB?=
 =?us-ascii?Q?Gcf6UER1XKsXWUbSu31i4YM8Cw11plkca0Ug0XLWUKqzRiTWZKt8EL/RBk5U?=
 =?us-ascii?Q?IVvHTDDCGbs54hxC3W8jjrUhcDDPDO4ZfKDJVXY/YdDob62cuOkBsfSA4lHt?=
 =?us-ascii?Q?7T/g+4W9NHqcYxIBNtu5FLyMs7zP0KmRYrmrPqSyFmX9bq8GSQR5MXpdk6hj?=
 =?us-ascii?Q?j0MUiJEaOopE8b3fBAQp4d5mE/onpWGnS47tWtWJxJcIPQE5ESEtn4QYEErt?=
 =?us-ascii?Q?FqJQEWu3dGx83irCJcegEBPQA1Ut5lkJb0GrXG9tJhlBAwyQTmMIrmJ5YFPl?=
 =?us-ascii?Q?GPNsct0ryBCXEYtqVVzN2r5N77mrbh6FnJcjDMjpWbgXHvjpK56IIrv3O40l?=
 =?us-ascii?Q?W58cIGumbjSkFh9eF4QdD4/WLZfB9CrLAOtMKRMKeKgfeH/tUCrLSbJQrsu6?=
 =?us-ascii?Q?rfYO+IhoYUiTrkYtlYy4FsM1i8JUmtHU28Gp7jBZv+5KomN4lQliDaUzZDt0?=
 =?us-ascii?Q?zhBwR1ECXqDpcp79xcdSE8Keq0v5cjGx7CuPBgChzYDbH0HpRyIO60eOqK4Y?=
 =?us-ascii?Q?A/bsnLG8afm//KW91HqQrhqbDeZedzsgulIrRe7pBC+LEEW0q5BjsZh1gGLy?=
 =?us-ascii?Q?o+gSUPfeZVRD7Kh5kFDrDhZzJH/4tAo2g5r/E0cZyNGOL5MuzJhozYZe88sJ?=
 =?us-ascii?Q?jJZE9VIZRyiDbj9A1VL6jvuDvRnP60iWT8XdTD/cxoEXHOzNx8+FaJLrXSpZ?=
 =?us-ascii?Q?sUkptdNBIX2Yh3CzcypzzKNnb1E+TLW+ebq1bic4agFrgXlKqUvoguvsoE4Z?=
 =?us-ascii?Q?Lifbh5K2y07bowu3y7W6UvJY4kmAYPw//ysBG2DQlBiLbiPsyNa8XB+/6l5A?=
 =?us-ascii?Q?9dNyMe208wW1BbG/0FycE0DQUXkBMQ/0lESxrbG/nmENmREkgPG7ka0PQAbZ?=
 =?us-ascii?Q?urIlEO23JmA4XcNTVZA4oWjtGaO+rVFz8NzBPaBQJrpWAUF3Jb51zrh19zCB?=
 =?us-ascii?Q?OypMkZzFqPJmG+uQ6SPsjUB2jAfj685Rcp27YlyFYuXP6FihgCMmZC4hmULn?=
 =?us-ascii?Q?YXcJn1R7TvUPYvpZfWW12lgrsKdXlGwFYIo9j/oOiK1SdexZK+Lg/PhbjMb8?=
 =?us-ascii?Q?7otZzbDu+rUO2w/i31zSgbZ/22yRmwvJvz1qmfZXusmkbdYDUsl4flyirTyg?=
 =?us-ascii?Q?Mk8jEkp4hZ0wKDb3XHyvzuTkbd6RksgPt9NLEZ6mzCUqs+wdGJbjEQejJjze?=
 =?us-ascii?Q?+QBNomMH/1hEUKTmd54/4kOgylWcckKtX1MUIQUST1krWoc6TQKAFs/Wr+vx?=
 =?us-ascii?Q?PxzJf7LnzVW8HI3YTP6qIXf9ibJ8mzc1K0DokBR3qhUwUmlpT6PX00lzXVzy?=
 =?us-ascii?Q?5ZzjfMme1GF0166Un3Yfmx9Ccb1vkxC0N+gStWKRwWiNK986HzRUhleplNcD?=
 =?us-ascii?Q?tOIuxQWttC6S1sc2EZLtd9nB6X1vG9cyRhvprH4Gm6Qr2d1/qNfUwvRcaULQ?=
 =?us-ascii?Q?aWm3KQTUUfV61LkKXfw1n0vI9X/nzgxOLAjIg7Rw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e6b5eb-ded5-4d80-0cfd-08dcf9f3d1e7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 21:34:37.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAOugliBMd35x0Qr/M1dSDyCQqq8oih3Qqq11nyQnSxwMnPdJ5xVuF77z9gDIliWktf3PRykDhIw3m+ZV2Ozcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8796
X-OriginatorOrg: intel.com

metux wrote:
> On 26.10.24 02:46, Ira Weiny wrote:
> > Support for the Compute Express Link (CXL) Dynamic Capacity Devices
> > (DCD) have grown a number of uses to print struct range.[1]  Support for
> > a printf specifier '%pra' was being worked within a large series and has
> > garnered a number of comments and discussion.
> 
> This is just printing out hex dump of a memory range, correct ?

No.  This prints the struct range values not the data.

> 
> What I'm looking for quite some time is a sane way for dumping structs
> in a human readable form (field: value pairs, using their actual types
> eg. int vs string, ...).
>
> Any idea to do that in a generic way ?
> (potentially using debug info ?)
> 

For printing buffers less than 64 bytes look at:[1]

 %*ph

or bigger buffers

print_hex_dump()

Ira

[1] https://www.kernel.org/doc/html/latest/core-api/printk-formats.html
