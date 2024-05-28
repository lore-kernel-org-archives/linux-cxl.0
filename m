Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1817C6A
	for <linux-cxl@vger.kernel.org>; Tue, 28 May 2024 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937354; cv=fail; b=lH5dX5xx5k+gMV8/Un4mq0V+3gRGUS6Nl8zC+1kvkBet8IVuFRVMXZVHSZuINx90d6PyKwJxG+VXqS5K7dZND36HP95OWVyYtbXjEu6ACrS4/NC9AEL6Gc4tjc+otiWY62yc05Ml6EF9ZgjBFMfDICxsePmk/waSjRlt4Kz2HG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937354; c=relaxed/simple;
	bh=56VspWm9arVkxqrrjqDffj5uCFCbJVnLP28mkiB44xg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p5kZ7zRfDfIvZW54YX4ud/KIJ06UQ4ka2A1L8NbiGuXJMSzhY6ElakbhnPFBwDohKiaP++varTkKgoj8DaT2d/lcf3m16q7LFYWlhfECSJ0Fok9cjQpuu/04btjosxVzMHotNTFJuOuhlda6IyOyKnekSEUbsCkN1GsO5ubbyYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NldCVWZT; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NldCVWZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716937353; x=1748473353;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=56VspWm9arVkxqrrjqDffj5uCFCbJVnLP28mkiB44xg=;
  b=NldCVWZTIaKcom500EjIGke0fCxdxySVLswmF3muJLAqgXOZEKHsrXjv
   ZyKA0c4g9r4wkJG3doZ8SqYr21Hwb0uGCjHPD0vq4iTzV3ifigp5noABQ
   QPV96Q6CIHSOjt3Ye5wXJobTOACbEp3PYP9eLwIAHM7l1OR0/W5imbjIX
   tuQ6hnCr8VdeiflAV6VB+e1ln5zGRchBrprwecOTyH/zR38JPHWOshpKe
   vWzsMEIjzvJ3xGonzCIsKfoc1xlTDOxNvJLbbHUS952SnUOLBZ3tX+26j
   QvlxPG7lz+8VTFjat9l2/4KIaEcYa7vv3OjGWY46ohdzsofG47eoVVaAn
   A==;
X-CSE-ConnectionGUID: Y1IPl6qORTeKNY99ME6tVA==
X-CSE-MsgGUID: NP/zWmr6RUGZo420MU1QXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13188510"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13188510"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:02:32 -0700
X-CSE-ConnectionGUID: Y59im1yRSfGFSGQ+CiFkwA==
X-CSE-MsgGUID: MqYDc2GNSHKIqPVS7EUeXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="35172711"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 16:02:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 16:02:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 16:02:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 16:02:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 16:02:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz49rKmW9rQ+ZIMzForm04Xwl1qIvplrQIWQC5DcyiaFKXxMetMNSntJNgqsEX+BQoeIwHZ2/1wL2RU7eCuz6g14jA/C/FOSuIMcV4nX+lH5ywftpUssAX6omEMQsMkjtY3cdJwQNiABB+hVVHYYcHRedAjc7r67PqBjPGSMIzfNGII43igjIegtXfDk1px/it2m1Y+yjrFLSwJaTgJtTaa7RhEaUe3Lw1Ajn1ra/WjsTfvUUSOmdbe6dUVDqoqIVsZ70IoI1UdJcUDxvBs4d9DKbCAW1uXlwFtog+wS6X894Uynch2e58PwUhhW/7bS6738EgdOj9VKNPh3LnkfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBWhjxrwJwNPjuVyXtvO53pi3oN6tjNiaigwkcx5YUc=;
 b=cZOQ3dyRMlZCVffGzkRJY6BpPvwmn9MwAYSSsyvg2u/Tn+IHsshj02K3QMKAnvN4aGY9FFFnfyHUvwDnzCRhpEXBnfOqrBiSf6B6/Uql51Mo868WYKVM4CFQdi4aj5dsSYsxkcwdUtAGF/0PjWXuw1H2ZYdRONBqPS2RQi6Y+d6pOXcPRFiqDuUWQjE+xhwWPJ7lLpn/tqUaLwc0GVy9KcDgKMgKPNzA0Wrw3Sfoo0lSOqTRicQeNiY8N0q+Ug9eAfDVIQJUdZVjNlw/LUSUVKu49mcujHMgj5nU4EmCEmIA3Qnm2KcPzsj1FR6TZl2KKURK7GwNF7yfmKH8Mkh8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 23:02:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 23:02:28 +0000
Date: Tue, 28 May 2024 16:02:25 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH] cxl/test: Add missing vmalloc.h for
 tools/testing/cxl/test/mem.c
Message-ID: <665662815ea6d_195e2949a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240528225551.1025977-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528225551.1025977-1-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:303:8e::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 78af3bb4-ea89-43da-b566-08dc7f6a3ee5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlllMDlJM2Y2S01IT3ZYUkZWVm5jaU9IMlhSUkNSQXlRYnZxeTRkOG8wVS9M?=
 =?utf-8?B?cWx4TnVQTHVOODdJWHVrTTV1RDFJVkRUTDBjY0o5d2NjbzFUdDd0ZFIwYlZu?=
 =?utf-8?B?dHFIT1NoQU9NUnZGb1hrRmRJWk1kTUNneWd0Vkc3ODRsOUllWUM2VGtpWk1s?=
 =?utf-8?B?bGdRM01XeGdFL2lyZEdLejdwdmpiMGQzdERrVWpySlNQbHlHUm8wTVFGMGhJ?=
 =?utf-8?B?ZkFlMGc1UnovRVRlZ1ROc2t0azhLTGU1eGlTSWEyRFBtZzA4M21ySlhKZytk?=
 =?utf-8?B?bEdiWnRoaGRRN1pMeXNyMTJjUmZkMXp5bVVrR0g5RGlLUnBtTjBXNmhoZnlk?=
 =?utf-8?B?eE9heW1lNFZtc1N6NVNvM3FTcmlEUENkTnJBYWN1M1B4UGI2MTd4TkZRUHJr?=
 =?utf-8?B?c05MN1RBVE9mQzViTTJRSVpDNlJSK1pkNU91aWZkb09ZMlFPTjZDWW1QcENG?=
 =?utf-8?B?aXFySGpvd2RhSDdNT1haNmtuQjAxRDNnSm80ak9kbTdTYy9pWEszNHpiSVNp?=
 =?utf-8?B?SnJpQ1A0Snp0K25EOUlRY3E5WjZUd2dlaXNsVzk1U2VlOC9jeVRRdGFLT2ht?=
 =?utf-8?B?VWoxUUlvK1lpT0RBWjFqa0wrNFNZMnRwc0VLaS85V1ZrUGt1dy8ray8vRExG?=
 =?utf-8?B?NTRNck1DaW9DNG9ianlVUi9HcjlXSlNVMU5DVVF0SXJnYVFYaWtGUnFkS3hi?=
 =?utf-8?B?QmdPUmNEY0s5aUJZeW0yWTdPMXFzRnlmYnFRVXNSNEdyUTFnR013ZFQ2cEx3?=
 =?utf-8?B?S1RNRGlFQnlnaWtGbVhDRVFyeURDNHdkaW1NOEE3V0FTRlBYVzA5R0R3d0pK?=
 =?utf-8?B?SUgvQnp3L0dzaWM1eC9WZTVCSVY2ZmFVV20vTjZHWm9IYWxmSnZ4MkZJeTZD?=
 =?utf-8?B?bDl5Q05CNitSamdGYnh0QXFCZXdTa3ZibUxQZEQ4YzVhM1NzTWc2M0xxNnNO?=
 =?utf-8?B?MnEwSGJXa2hVejNjSlFLdnNPK0dsdHZ2dFlLb0F5WTJGT0NCVGlpbjJyOUxt?=
 =?utf-8?B?VEZxQ0Y4UnNySGpBQkhBWXN2dGZIY2FZUHg4OUt0NGhsRVYydlFjOHZiMXZI?=
 =?utf-8?B?cVp1QW43R01OMXM1c1R6dTk1WFJwQkV5WWZQOFdBcFdqV3JUR0NjQitNSmZP?=
 =?utf-8?B?R1V5SU9NZ3BOejh5SmRNUm55dytlSlBQN0Q1Mk9FbWEvd3NGT2wxUXBiQlUy?=
 =?utf-8?B?Z3BzM3g4TDNnQm5pMVpHaS9FdnM4ZXRvNzVOWjRLZkhtS3BPcDg2OU9tOC9L?=
 =?utf-8?B?R3h4cW5XOXlHTnFpVjk3VnBKZEVDSGt6b2RLVjlGV1lKblg1cHY4cnIvL3p2?=
 =?utf-8?B?Z2EyNzNwOFMreG5qMU11ck4ySUE4TXNUK3UvRXFab1Q3VzZzRkF1ckNhUzJ2?=
 =?utf-8?B?MTVyMWNlMDJ6djhtY2phN0lOeHhydVBHT0lGRGQrNmtxT0RJNkgxeUtXL1Bq?=
 =?utf-8?B?VWFFTGZ0aldTbS9DUnlVS1NXWVlVY2RlU0JxYktveFJiQkJJbVAxYVRkdTBr?=
 =?utf-8?B?M1RBcXM5ZmtkQmlrUlozK3A3RmtEOHA3YVNjRlVBa3R0ZFQxZ3VnaUlCcEth?=
 =?utf-8?B?YTl1NnBQNGtxbjlBTGJvcVpxR0N2VTlMd2NJMy9RRWZnZFpGcTNqT29IRW9R?=
 =?utf-8?B?UVhpcEYyNnh0dkVBbUEwTVA3RDBUVGRSUGg0WUlCaVRrV1UrS1IzUk5NeXFM?=
 =?utf-8?B?RlhTem9vbnAyck8yQitTdXJ2V2g4REtiY1AyaDNESlIyallycmVzdVZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXJsK3N0UG5nV2JPcVRUbEc0VGtBdmQ2U1RJYW5wZCtUUDZUdGlKR054M0xk?=
 =?utf-8?B?d0Z2YUplU3RYVVNQazBKdEdRM1FFcnQwYzB1ODV5YS8yNWZEM1czTkN3NmE3?=
 =?utf-8?B?dVNsNjRLeEIxWFROek1FVExpSTduTzdwblByckcxUmRnTlBWeWM4NFY3eXAw?=
 =?utf-8?B?NDcwajB0dHdtOGNiQU1wM2RWQzV3NFNyUHA3c0NHYjFHQnpjNHhyeWowV1RC?=
 =?utf-8?B?U2FyL2Myczc3SVN2bFRzVXVCbUxlZFdGZXpvZnYxT0ViYXVWbjhGdDFuUWly?=
 =?utf-8?B?OXlBSjM3Wlo1emt2N3FSKzdTUng2ZittRW10Vm5FL1lhUkEwcW41WkpwRUti?=
 =?utf-8?B?MExHSm5tOTdXWm9SWFNCaWc5OExEUVB1Nlo3WGdwNUVSM0Job3lnc2ZrNCtC?=
 =?utf-8?B?STdmcmh3bENaVkIvZnpCNFQ4MXlheXVlLzZVUXVyRExQMXY0UHdaVjhqQ2Fh?=
 =?utf-8?B?UFZvZE1JVWpib2JwSzlRM0RkbnM0RG5LUFkrQzd3M3FCd0JvdXJFbDQ1Yy8v?=
 =?utf-8?B?TWo1OHM5cERHWm56aWhQRlIrTEZvVXREeTF0VUhDQVJ3WEFDL2xIcXNtKzZG?=
 =?utf-8?B?U2FUTDZsblVtM0pEWERVQnZnbXZxaTJQODFRRnVPUGVXYmZQSkNaTjBaV0pX?=
 =?utf-8?B?S2hUUEJuUVhDT095Mm03VkQ4SnFtTzEzWG1MN1JJR0lTSnVLSTRJejBVR2t1?=
 =?utf-8?B?OXdaYldHVS9PSVlXa3VycGdxZjYzWWJsR2ZUbXlGMWMrRk9sY0Vwbk1xbjcv?=
 =?utf-8?B?cWs3Z0g5VW9rdTFVRXM2SDF2SlJQR0ZzdWNVbGhyS2ZQSU5nd0VOVExXTVh0?=
 =?utf-8?B?dE9EK2toS2I0c29zTTB2NHZJRUtXT1FSaStjWjhoZmNjNFVuaFFiMk9saWhz?=
 =?utf-8?B?Z1pCRmVWVW9JV0NXZFVLRGRFV0VBRmNHbDdyalR5RGZFTHA5ZW9vb0M0OEtk?=
 =?utf-8?B?WlQwVVdNZ0ZwZ0xuNkNQMklHeFJ6V3J4TVlSMUxHcjZ3N2txVHE3V2lQamV2?=
 =?utf-8?B?dmdQZzliY2ZWelFxSlZxaXNHSjJkb0FqaG00T3QrMlhDc0psVDRYOGtHMC9j?=
 =?utf-8?B?VGt5WTQxSStYcWQycmpmVlp3SDdBcUpJaEhid0ZEendoLzUwbnN6aEttcHZW?=
 =?utf-8?B?a2JhVnd0ZlJpekZ2TEdxZldhdG1GUzRXWjNmcWdaMVB0VUpSNTRLTWRHc2Jx?=
 =?utf-8?B?WmlNZG0xRW5wcUlQZ25SWTB6ZmkwSnhTSjF2NkJQWktsYjhKc1Y4Y01jakpJ?=
 =?utf-8?B?a0sxWWZPTHdoMDltbldyQkhBRW42ajRUSmNHaU43SHZlYU9mVm1TUUQ3cDc4?=
 =?utf-8?B?Y1d3UkhCZmJIOVhCMENRNStvMDFpU0s0OERWTG0raDM0ZnlBbVdYdWFwdTlx?=
 =?utf-8?B?QjRYSStYQnhNNjR3aHVGWkRreWlNODRpTjNRMk9pODBXem9wenFwUkNEL2sx?=
 =?utf-8?B?TGZJM2puOVh3VWhEYXQ4eTlTSUFPV0FrdVlPVlViTENYNnhmOWZKRCtaaDZ2?=
 =?utf-8?B?MS9KWTdqTFlhNFZuRUZiaVFvOEdjSWhzcHhDL0hEWGhrcktCamgvMjVoVDZw?=
 =?utf-8?B?RlVUVkVIb1JxMVB4VldKSmtmdGlySzA4QlRqaUs0dmZBK3FrRCs5YTJ0OEpI?=
 =?utf-8?B?azJiTElTV3VuRVZuelhOTGcwalZiWHJzZGpvYlI2amVPQjB5RDVPSHVFWktU?=
 =?utf-8?B?aTJueUdEdFJhMzJjUitZZEZVUzI4TFpkcEtoaHRvVjlkMDRGNEtVVzJmcmht?=
 =?utf-8?B?QUhVQnphclFnU0ZWVGFPNDRIWDdDblVKdjF1eldxZGl5VFVpM2kvSGVGbW1N?=
 =?utf-8?B?U0MyaTVwVWd2N0tpbVlJRGNGNUdpU1NZWmRKRWJxcEZHSkNWWTdrT2RYQTZX?=
 =?utf-8?B?REprYytmMUVqaHdoZXdCdXJNdlV1N25NblVMc2RJV1Z0eEY1MWlVME96MWdr?=
 =?utf-8?B?aTQ0allMTHVlVXpWSDFOcFBIM25aWkMxTk1neGI0NzFJTkUyU1hjUEVXMFVQ?=
 =?utf-8?B?N0FHbDQ5dCtGM0xaSW1xb3NSVVcwN0U0Y1F2SUtwSWxIeTc3L2VUZU02bmdj?=
 =?utf-8?B?SmZJK2VFQW5oczVSN3laOW04M0o0Q1FpS0tBbWllRlN1TlZHTEVwZ24veHVV?=
 =?utf-8?B?aUUwM1FPVDluRk1nc3k3YVp6VjVvZWkyUnltait5TkM1OXJPNlFiS28zVWlO?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78af3bb4-ea89-43da-b566-08dc7f6a3ee5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 23:02:27.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdgsuK51f9mUVpnJuzWGT6ZonTYohwOteRcZ0d+Tynn7UYr6hI80/gr/MmE8c5aoiG1dh4vvZ5ZdmugtHOMVDMK2xsfGbeskgFOQH7DnYpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> tools/testing/cxl/test/mem.c uses vmalloc() and vfree() but does not
> include linux/vmalloc.h. Kernel v6.10 made changes that causes the
> currently included headers not depend on vmalloc.h and therefore
> mem.c can no longer compile. Add linus/vmalloc.h to fix compile
> issue.
> 
>   CC [M]  tools/testing/cxl/test/mem.o
> tools/testing/cxl/test/mem.c: In function ‘label_area_release’:
> tools/testing/cxl/test/mem.c:1428:9: error: implicit declaration of function ‘vfree’; did you mean ‘kvfree’? [-Werror=implicit-function-declaration]
>  1428 |         vfree(lsa);
>       |         ^~~~~
>       |         kvfree
> tools/testing/cxl/test/mem.c: In function ‘cxl_mock_mem_probe’:
> tools/testing/cxl/test/mem.c:1466:22: error: implicit declaration of function ‘vmalloc’; did you mean ‘kmalloc’? [-Werror=implicit-function-declaration]
>  1466 |         mdata->lsa = vmalloc(LSA_SIZE);
>       |                      ^~~~~~~
>       |                      kmalloc
> 
> Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/mem.c | 1 +
>  1 file changed, 1 insertion(+)

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
