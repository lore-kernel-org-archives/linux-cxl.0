Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B118B06
	for <linux-cxl@vger.kernel.org>; Mon, 30 Oct 2023 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ksZah2hN"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11D8C2
	for <linux-cxl@vger.kernel.org>; Mon, 30 Oct 2023 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698682714; x=1730218714;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OJjdfZteXZlkoUIjc29hg+EC7b4/zCelb09mvBVdpig=;
  b=ksZah2hNY7ziKQzES9x6YliXAjFmcbc7rAPCuVGQuc0xFTs+OCfGV606
   6PdveUWx+qJNee/D1oHtUBhly0wKIyC9NV9FciRG78fyvz2sTiXXvkz4x
   ckrq2PbQbLS7y/hGW8nRFQx0UFT6SXrVJ07BJ9dI6TLeCzIEMZdcuc14Z
   cw4lpVUzm4SYXoZ/tuEfr/uRFh73DM6D5G6IyV+u0xPVAnYomptnxiA9w
   f6xdQXNBDFL3Rp4okzF9/1/fdfryppZAjYFEV5kh0YkWNeQkPX6p7YJs/
   W280sfS7O+/Oux32LlkYMLYFjYbUAPK871q4olWdy+D/7Dt7tQZ/cQgRo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="454568406"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="454568406"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 09:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="795309573"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="795309573"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 09:18:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 09:18:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 09:18:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 09:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj6S8W9ba/tm23sS5j5yAwx3Q99txEjaNTadaryTFr0xMmQ0+l+Q/aye14sarNDZq9CtONZ1quQ3enYyHioa6lmYG5EWuE7jfk4pb3AV+fMyM4RKVlVuYCLvYvisvInkbLrNxwqrYNJtpsR0EdkDDy+0RavIE17fqNd84a/75LzxnA7pZt2OzhPNaUfG6SunQqx0bsnjmwm6b1OKxHicZNPyHsBTPPHrzIhEvoh0rDqU5BrWEtdXnz1h53FrUQeDIEFPKhoJ64ivqrQirj/m7yqPgSbAEnS6NTS6Q7ZcddxyDRSjwqgnNDESYKTgLwvUizRsiMtRFQ3LA7HaqE6/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJDonZZ4ptfHNFu3mFlqimlw3W54Ul7mQ/LbIb7hoq0=;
 b=i85xMPi1GMksnsbwWzgDmgynV9oWJuc/zPmSQAnazeGKwVsoMe9fADXPVCnyb4RT6WCdISBfEmB8Sw6674kOnzcQFUmsKU6dOIAkRPFYjpxC3LH2HHz+uf6uXQ1+o8DHbu9xfmwm05eSkf63huqJBvlbW6QdSYc35+B4mtQfcTuvFG+nHU6ZTbdpC8zIHgMDFWkDOAP48MntMM8+6KBgVc78DxXZ+9rvwohSOHZHkN2ekRthe6yUoBckWE4sp468Ig0dPC9Sp3EhCWm/zbRO8vlPpVcmFxxtxPHtJhWAWMIBfaFYBqLbT6ZFYB/svfIiY6k01Tg1t/zqTJ8DA9mMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 16:18:23 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::a353:a16f:7f8a:86aa]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::a353:a16f:7f8a:86aa%6]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 16:18:23 +0000
Message-ID: <10d61293-67da-472d-8e5d-a5b244c51170@intel.com>
Date: Mon, 30 Oct 2023 09:18:18 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v11 00/22] cxl: Add support for QTG ID retrieval for CXL
 subsystem
To: Gregory Price <gregory.price@memverge.com>
CC: <linux-cxl@vger.kernel.org>, Len Brown <lenb@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, "Rafael
 J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Hanjun
 Guo" <guohanjun@huawei.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
 <ZTruDdQabRcVAG4P@memverge.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZTruDdQabRcVAG4P@memverge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::34) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ecf10b-87df-467e-7a4c-08dbd963d6dc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRnMgIA+JiQzYPmEd6jhZ+zL2WFpxBfC4pzglLtMRtnihKX4bx5TrDH/nVAJ2jy7wcv5dFFE4qirmTwNZXUfyQYfqTnZQX+SS4ACmXGRd0ewGm2KaKH1QN40ojRneFyWvTPhD5hoOYBcjUhzdIvmiolKXeG4OUaW6TJ/vXZNg9bwPcCioUwhSZ9ckZ9+7ZMY/0yGHnDcDrukgRdjAfu/C3es8RHXil5Yyh+NUYg7CiQGKkRqIzkj9nrlbI3VwcE9Vm2W0iWPsYmv9sBqzAR7kDgajg9964TwK8UB6u2ptyWCy9sa9pR5jwZslheyBJ68DyvhvGYFXKEys74Ruj/pcXXMRSCF4PRi/G9VYIaIfJ0YlXzpGuhIcdh6U3qTxJ+GQpvLHMABtqRQyYkTveG8WNM5SGUbgLer05wA9CcmbU2TEG8QpK43oxIXrVBq6UAm+jMSustC1R2I2MXP+biXzUsfOp83iQIZbBqF2Nq5iy87Fuz+nsbrjNIpuPnWcttm3sAKS0SNfD6lATOicTMNY6Yx7faC6Td9A/FrsMxemiehKTkkWSqPoa6KeaH0gWgYk/LbDC62zaVPCIehic+3zftVIyrWBSX6Ns6qj7htlpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6916009)(31686004)(966005)(53546011)(6486002)(478600001)(6506007)(6512007)(38100700002)(6666004)(54906003)(31696002)(86362001)(36756003)(82960400001)(2906002)(4744005)(4326008)(41300700001)(107886003)(83380400001)(2616005)(26005)(5660300002)(66476007)(44832011)(316002)(66946007)(8936002)(66556008)(8676002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0l1THZibzFrMVhGSnkxbDBBaFVOQ2NuMWNPNUwzcHl3ZlFqNVVUM1lVQ29Z?=
 =?utf-8?B?RVQ5Zk1IL1UxLzJxbS9RVU5LTlB3YkFuQUJYM2QxdWVQUStYR0hNS0l2YzNi?=
 =?utf-8?B?YXNBa1d1U0hzdDhpdm9ieEpyMnI3eXQvKzBVMWplYWFlUm44SUFlcTFUUmlt?=
 =?utf-8?B?T3ZRSkJhMThRb0YvUXlwTWovSHFOTUpTS2JsaTFxVkVCK281RlozT0locytQ?=
 =?utf-8?B?d1owYmp4RktlZWYrTUlLTnU1K3Qwa09TdTdzNTFjMnVRNVpralNNUFN3YitM?=
 =?utf-8?B?dWZ6ZWQwZ2ZZSDVZaTFJSjdNV0xQdGNKMktGeUwrR2M3aGdhRFRNdnMrbnZ4?=
 =?utf-8?B?dVQvMFBvd205QzU2eWZMUzh3VlpDM3RPakZCUnJPcVl3K2w3R0FpdzlibVdr?=
 =?utf-8?B?bEgwbndDN2ptdE0vWmY1aDQvRXcxaTJSMkJSOHFzT0cvVTlKYXZaZjJHb3hF?=
 =?utf-8?B?YVVMd05INCtFcDRFenhKbXVVWGFkOU5NZHgzTHNSNjlZQVdOQ0NsVHQwdUIz?=
 =?utf-8?B?UkVqOSt6bzRmTlNVUm5Dby9oUU5QUE50c0tzMEZlQWgzam5YM3dJRlRrbWJW?=
 =?utf-8?B?Z0g5MjVUN202Rmt5WUVjU3ZSdTlUTnlNR3ZsK25FVWVjV0ZzbzNLZERjTkNm?=
 =?utf-8?B?aUdPRmU4TVNvNk9GTUI2cXB0WFp3RWhQa2NxUW4vYXdBNy9zVFVrUEMvWUNI?=
 =?utf-8?B?bVliVFZCNzlBV25lRzNRek85S25WbDVVOG5PU1dJZEMzQjhDMVJZVlZBRHRN?=
 =?utf-8?B?Ri8zYTNxb2x5WTFCVmpNUU4rdkg0QXRrbDM5M0RxSWRYYlplOWVyaWx4cmtq?=
 =?utf-8?B?cXdqOHJMSzBXS2tEbENWbmN1c1ZmbUQrRVBoOHBnRHkrSDBYbnF4QWYrNU0y?=
 =?utf-8?B?KzQzbll2YUYxbmpkakZob2VCSUhpZjdWS0ZRcVVXSU0xa3dKSTZuRktmQmN2?=
 =?utf-8?B?M1Q0SGdGN2RPSGJ2SG85YXZoaC9mK25TWjI4aUNLYkI2SWt5SklHL3B0Y09C?=
 =?utf-8?B?OHZDZVZOdy9uL2E0cWhCRkFBSWplaEhiVEs5dWNnZ0sraEFBSnhvem45M1FE?=
 =?utf-8?B?TnhicDdTQUFTeVhCYnRRejRHZStoSTRtbENac2ZqaStvVEtXQTZJZkovTHZx?=
 =?utf-8?B?a2ZYeElwc1RqOW5BM1E1QzlTcEdsMVhPbFhUY3NscTdPcDRIMG1yVkoxalJo?=
 =?utf-8?B?cFdEbkhaTkRIemt3N1J1czBUZzJPaDkwRjlmWk01d1NqUGFlTUdXOXRNSkMv?=
 =?utf-8?B?UWVSSmNuQk5nU09xZzlrWk5lOGRmcktPdnc3TnZFdURhUHFxelRsaDdoV3By?=
 =?utf-8?B?UU5qaG5VeEtrVlByakVGTUM1dUxlTGViVEdPcFo5UEg2V2NMb2gyZ0tINDNW?=
 =?utf-8?B?SE8yRTlzLys3VURKT3h5d0RVMkNaWE9pNkJ5S1FGbEp2TGhhTlptQ0JlODg1?=
 =?utf-8?B?OFVMV3EySjlsZHdwQ3N4NXkySFNBbWI0c0dYR20zNzZ2Qk95M0w3bFRLOW0x?=
 =?utf-8?B?QncrVDF6UzR2T2tWVnZDcmtYa2lSUzFXSVlmQjZVdE1CVWRhMmZnU016UzlB?=
 =?utf-8?B?ZndNYzh4eFNUTEVFeC9lNlZsdWdUWk1mekpuYUFGbm1HNWJxdGlOYU8ybUY3?=
 =?utf-8?B?dnFPa1k2TFE0NFZ0MGpob1JKQnhFbE9ya2QzTERsUHcwakxXWkhBcEZvWDRz?=
 =?utf-8?B?ZFJYdHg4ZlFRakg1Tm9PNzlzdDVUTExOS0JRZnBzTzBCaExJUTNIU2E1TU4x?=
 =?utf-8?B?cldWOFIwa0I4TGhDNStyeExNOC9rbUoxT29FNGpUKzgxSGdBbk9ZV3YwV0ZQ?=
 =?utf-8?B?bjl3d05SZmhZYjZBd2F3aVB6VnRoanJIcDVSeURpVXVqL0QxQTg2a0tUc1NZ?=
 =?utf-8?B?bXRvZTR1QTdiNzBmcDg2aVhhRDFiUUR2aVIwS3BVRFpUM1h0NU4vbzJHU0hG?=
 =?utf-8?B?N1ZkSEthRVdWdVdpb010Z2xobWNSaUdEeVZGb3M4a3hrMFhxeFJpcFYrNmRK?=
 =?utf-8?B?WFB2MGJPR0tUQVhuSzVoMllpeTNFOXMxR0hDYVg2TlBaNHdLSTVXV0tBWlF2?=
 =?utf-8?B?RXlTTXM1QnNhL1UzRUQ2bytra0tFWTdJREludWg5bzJUaGp3NTlLR2dveVVT?=
 =?utf-8?Q?icKJ7PwuTllGq1CBc10AuCmi+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ecf10b-87df-467e-7a4c-08dbd963d6dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:18:23.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXCBUC8GB9D6lvfjoB6Mo1WjZGWCwDJ7KkkZs94a++cefqEUccvo2wr6f931CG9F5PN2Xw5Mefuf9dxWxX8/Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com



On 10/26/23 15:54, Gregory Price wrote:
> On Thu, Oct 12, 2023 at 11:53:30AM -0700, Dave Jiang wrote:
>> cxl: Add support for QTG ID retrieval for CXL subsystem
>> v11:
>> - Add debug print for multiple DSMAS entries for a partition. (Jonathan)
>> - Change qos_class0 to qos_class. (Dan)
>> - Add verification of endpoint device's host bridge to root decoder targets. (Dan)
>> - See individual patches for additional changes.
>>
>> base-commit: 178e1ea6a68f12967ee0e9afc4d79a2939acd43c
>> ---
> 
> Was unable to find this base commit, but the following commit is needed
> to successfully build:
> 
> https://lore.kernel.org/linux-cxl/168677930330.2787985.15866363373310739456.stgit@djiang5-mobl3/
> 
> the remaining commits from that line (1-3/4) have made it upstream but
> this one has not yet.

It went into Rafael's tree, but not upstream yet. 

commit 178e1ea6a68f12967ee0e9afc4d79a2939acd43c (linux-pm/acpica)

> 
> ~Gregory
