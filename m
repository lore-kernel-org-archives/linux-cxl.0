Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61D39FE7
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMDvL5kk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704815768; x=1736351768;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UbDmqOOJ3sz1sfiQfkMxp5B0erpsC9b82ofHQn6bfWo=;
  b=CMDvL5kkldsnQiQPo2+I0YdphPJ/i63xk1DKOsN2E4UseZvbS0w1J7pP
   dLI1mvRjrfG5d1Byckipkx3Hk7hreVpDFQbfexTD7K2D4dFzQz1oeV2uT
   x0tq0R18Af0o69xieGqHwgPxkEFGRe+7uyGLpZg1Ftl0n0FzSBoO46Bmy
   /IbGLDpSGTW4KnxpREpE9dm6h9a6uJUv7zDrGu7ryCQ7NrBQMlrCPrwbP
   FoK8xK8otxiwTf7PfGHgYWLGv8okeVzboGuSF4vcRGH8o9Czs63dWyIGy
   FTWCAIdhVO++rfZvIZoc0CbVrJQVFGUxVg5b+2rCcml4todaDhpq5aG3L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19741996"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="19741996"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 07:56:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872280524"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="872280524"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 07:56:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 07:56:07 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 07:56:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 07:56:06 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 07:56:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlB/TBARHFstgSpHq9c5D5NQ+/l2agFvrDkI06/XpfKkajUOoTkAwzUfHjXwb++3L8K0odXSTRrGjPmybtTPjAD4CfApyVLImyR8o2vR68EU9iikD0/AjRUrsIkZTdsYTwRaocOUcBtpSOknM2hhGGWJh+a9GuQBzg/j44nUmLkRAh8qmsLQe0j/EmM67gTSperQhlrNzoiBlhRqCFcKodK5UdxvsAsraBvynBXqJGZzwW1dzrasPWS7m4xzMC2bWRkE3SS94OFVUcl5lUpb0vpV7gUIv0F6ZCk/WlpYemLmL64IamNItn+CbC8zArPHtZnSZp73y71Kdc2A1NwYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ7dWMktPXcpiWp6InA6HezzhuYRJO5nH7g0mjfpcYM=;
 b=EFu+R1nfjryuQ5q8NtMB5+BocvMigoPQUYK9vjgAHnGoIZ88yKdForXpvnwehj0GP+NyRvw6b42M+x9yWigtNkuoO2qs9/FBdzj6U40G/L1v+5D9kw9En+hBcQ6Wa0jpvzBBSJpCV3wCq1fabxPHPpcqDHv/ZlLt1ek2tSWUQLKz754SnNMUrSkOg+rLehboGInPiT/u8cOuFujBfsG5TLC+J/gM1Jcuq1fOkHwFlv+JBV2HBRh+iyoVaXyM9JUoEVhpznqNcOXmbppkulg80qQ1hIvf0P1fNSlpBp28lPD2aVP/7PobVK3fvMBOSZ0JvlpjOfdZ4iNnDQ1Ydu1CWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW4PR11MB6715.namprd11.prod.outlook.com (2603:10b6:303:20e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 15:55:59 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:55:59 +0000
Message-ID: <ea787557-952b-4322-8e13-c18abf5b4603@intel.com>
Date: Tue, 9 Jan 2024 08:55:56 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 3/3] cxl: Add memory hotplug notifier for cxl region
To: "Huang, Ying" <ying.huang@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	<linux-cxl@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441211484.3574076.5894396662836000435.stgit@djiang5-mobl3>
 <87r0is9v6o.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240108121538.00001369@Huawei.com>
 <38be52cf-a4ea-402c-9b14-47a80427f0c8@intel.com>
 <87wmsj8d70.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <87wmsj8d70.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW4PR11MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef26fec-75bc-4b32-57c0-08dc112b78dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rjtFaHAVe72tuTwVgilFb0hy4Myde91nmh/JaaqiV2npMuf/8itI5l+4ehRO2aypXhsYPRksgjgfzwwy5Lvoffq1nhxnpioVLMCszSsLTF3L6smmfgQRx3D3Vowoi/Kw2+OSQpWjyM8D7C+qfeW62/bf03K/sZKXzPGFbIPOZX1sfMhGkWToPiwca23xbhCQr3XnZvYNM8v4h+Wg+VTBYOdqSFfoeEP2vUfBn0syzndP+zJ4as5Mhe8Utp8gUuE7NC4lvT8kUTKfTOX+hrb3UolCNWXalc6TmQQRYUgQ6FyYxvtyaGUSJAZt+BokGJo8Mg7Dix5ov2dpHWJWF1Em5XNiJsZT3+WMDNSwT04JN2ofkK1QLLu/xUPLjH4FKMqrOAzH4p/jxI5L3NpebFGrVZAlNQ9ALfp7Qg7GSavcBCu8f9TIg704Aa7TPDC3P8+JOsNZxILLq8JXVYHI8BA7ZHhn7knhlEgoynGruOLuko31+p8NB2roFY9USZ2PeGckiP7rFCSDTfl9WTuNTtNujMG01xrd02zu1A0A8+Y4RkcioxKNq6+fXhv7WQbqBvbsqHyLQNXww7gznOxQZFMnNVsMSYkzMQ4wxEgwhDglznG37PN/3ImFUyZFXv2+AZH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(2616005)(26005)(6486002)(53546011)(6512007)(6506007)(6666004)(478600001)(38100700002)(82960400001)(36756003)(31696002)(86362001)(31686004)(83380400001)(2906002)(8676002)(316002)(8936002)(66946007)(66476007)(37006003)(54906003)(44832011)(5660300002)(66556008)(6862004)(6636002)(4326008)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzdxd0xKR0hqSXNNRHZzT0lGV1MwNWNYS0Q1WVJTNzliUktiYytrODZad3VD?=
 =?utf-8?B?Ris2QnVaSGFlcDFCdVNySE1nc09NdEZZMUtxV2pJMzg5Rm96enhVOGpmWjVn?=
 =?utf-8?B?RDd1N3JDZnFmaWpSZWhlK2svdGFMZGVKelhIOFpIR1g4QlUyNyt0SldhN0Ey?=
 =?utf-8?B?VlhNSG1FQkVkekh2U3ZpU1ViUnM1alZ1ZHFEd05XM1FZa2d5QXZCNHRtcFJv?=
 =?utf-8?B?aHY3Q2xVVnlnTGxhRExraGlPb0E3NlZDQUlFWFJQNzBXWnExRXhZb3p1RUEy?=
 =?utf-8?B?Um0zT2N3ZTdIS01yb245Tm11WE00MGRMZ2J2eVJWeHE2eWJnTm81UHhoaTV2?=
 =?utf-8?B?RUhoby94QitQeFd2TlRRTEhUb0p1STJQYXl0bS81ejFXL2djVThUaGVGUU5K?=
 =?utf-8?B?N3hrMnBZemdYNnpOb1pYaHZLRXpJWGZsU0g1V094ck5ncXp1UEVOYjNIa3NS?=
 =?utf-8?B?cTZYQmVkeHJVbFo2MCtiUHBNRzZUTHJPOFcyZjMxMk0wTGdHSTZWUld6UEI2?=
 =?utf-8?B?OVBhNHorY1FIMk1CNVpOZWkyL1FCMlZkdWFxbXptakFCeUVLcnRtaU81Q0lC?=
 =?utf-8?B?SnhjOURPenlEY1E0U1BDWlpsTG9leDEwakNzbnlvVDJBN0k3cXhjeUNwcGQ0?=
 =?utf-8?B?Q08vUXp0Y01iT2ROOVU0TXQ3N0Zqb1d6a0RXbVYxVHhsVUtnQkcyZzBrcnBH?=
 =?utf-8?B?NE9DVFkySi9hT2x3TkZxK1VELzZDaDZzSG9WaWRsYzJzd2orbmJucysyZGw4?=
 =?utf-8?B?U0R6THlIamQxc3NxOVM0Y1lCOEtVOWt4bGp5eHhUazdoTkhlczB6TGdMdC94?=
 =?utf-8?B?WW8vemQ0cnNZT09nQXFLZXhCd2trZDl0WktJaUtoM1duaHllZVQ5ajN3S3NS?=
 =?utf-8?B?WlN6VTM5dmdFRVNkOSt6eEpGSzJzUHZBM01RRy84b09wMjFaS2tjWkwvQUpz?=
 =?utf-8?B?V2FDUGRpYlNvUEczbGtuajl3V21hVmEwMEk1VldhZGsvcFl3d1N5c2Q4Ly96?=
 =?utf-8?B?TVV5bzhsSG1pTGpORmU0cXhSSnhKTG9QUWxzTGxvMHQ5eEFJalp3eHpSbWR3?=
 =?utf-8?B?R2htbXE2K2tkT0pORzNNZEZValhyRFNLM1NsS1YvWmlnMEVUTzdvK1BaZElw?=
 =?utf-8?B?eTQ4WWlvbncyT05kNDZiNXUrc3lxR0U1Z3g3cHR3NzhHMUY4bWhEeXc1L3VX?=
 =?utf-8?B?Rkdyb1p3bVBqQmg2VHVkS1l4ZE5GVWZBeVI2NDZ5dGJEaUZpbHJYeDhzdHFD?=
 =?utf-8?B?WGgyc0xYK2dVaEtMdU50ZkVLRmFjcEpqVk5keG5QbkZJY3FkZ0llY1lNWUpM?=
 =?utf-8?B?bjRVN2lFVGlpNFlXNnF2UENSOXVQalJONFdReWRCWTRyS3hjZGxjcmloVlU3?=
 =?utf-8?B?SWd1WW9QZHViSzZqTzFNN25DYkV5bDV1R3pKcWdIK2ZiUjZEOFpWbmhidFcw?=
 =?utf-8?B?TTZpTUNNdmhLUUxkYXR4a2NORXI1WVUxRGJoV0pnMkx6VGZ1TmVpZSsybWVF?=
 =?utf-8?B?dWE5R1REMk9qMDY5RHU5Y2FXSjRkQnZZTjg5bFU4S1VSZm8zZXhUeGNVVXdo?=
 =?utf-8?B?djNFeGo2RlhjR09jNXBkWGU3MU5pSVFMMVlEeHg1RWNPc0MzdnQ5R1pRODN0?=
 =?utf-8?B?cmRsc0dhelRQRGFzV3UvOUFqU3F0NUtWdlp5dkltT1owRlNlVm1rVExnNHZX?=
 =?utf-8?B?T0pnZ0pDZHplN1kzcEUydTBXOWRzck11UGUreHk1Y0lpL1JMOFFFZVY1MVla?=
 =?utf-8?B?dTV0LzFsdFZLQmErQWV4V1hBekxPYmNwMCtITnY1bTNGb2RZU0k2ZFR3L1A4?=
 =?utf-8?B?RW5SMENBMDBBdW1sRzJidU5hVnNIT1BTSVdiOHkxM1hJeGRxUmhoSW0yR1hT?=
 =?utf-8?B?cHhSOUdFMWFKNmxZM2x0UmtoS0pkN1dsUzA1Q20waS9qQi9pZFVXVEt0SWk4?=
 =?utf-8?B?SmZKYmM5WXB5cTA0dngvT0dpOXZDU3hPK2VLOFY4Y0s4M1dpbktvV054MktO?=
 =?utf-8?B?TURXY3NuRnJuSGtOQmxHVVYzTHd0MmNQV1p6ZThhL3FKVjgzc3pTR1c4T2ZZ?=
 =?utf-8?B?TUwzdkJTcGpFTVN4T2FKZjFQNjQ3YTFVMCsvV1JjRzNDdGo5dk1VZElLZUdq?=
 =?utf-8?Q?/MIvevCDYnHkdKk20lwWtBbKw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef26fec-75bc-4b32-57c0-08dc112b78dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:55:59.0851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c08Jmf/jBblgmeP02u1V6A0mZWHCJ87AGpjw7HcjJVuGDKFADXX7Lzf1Y4BBkS3nKfjiCijBEVwBjmJq8mKPgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6715
X-OriginatorOrg: intel.com



On 1/8/24 19:15, Huang, Ying wrote:
> Dave Jiang <dave.jiang@intel.com> writes:
> 
>> On 1/8/24 05:15, Jonathan Cameron wrote:
>>> On Mon, 08 Jan 2024 14:49:03 +0800
>>> "Huang, Ying" <ying.huang@intel.com> wrote:
>>>
>>>> Dave Jiang <dave.jiang@intel.com> writes:

<snip>

>>>>> +
>>>>> +	node_set_perf_attrs(nid, &cxlr->coord, 0);
>>>>> +	node_set_perf_attrs(nid, &cxlr->coord, 1);  
>>>>
>>>> And this.
>>>>
>>>> But I don't think it's good to remove access level 1.  According to
>>>> commit b9fffe47212c ("node: Add access1 class to represent CPU to memory
>>>> characteristics").  Access level 1 is for performance from CPU to
>>>> memory.  So, we should keep access level 1.  For CXL memory device,
>>>> access level 0 and access level 1 should be equivalent.  Will the code
>>>> be used for something like GPU connected via CXL?  Where the access
>>>> level 0 may be for the performance from GPU to the memory.
>>>>
>>> I disagree. They are no more equivalent than they are on any other complex system.
>>>
>>> e.g. A CXL root port being described using generic Port infrastructure may be
>>> on a different die (IO dies are a common architecture) in the package
>>> than the CPU cores and that IO die may well have generic initiators that
>>> are much nearer than the CPU cores.
>>>
>>> In those cases access0 will cover initators on the IO die but access1 will
>>> cover the nearest CPU cores (initiators).
>>>
>>> Both should arguably be there for CXL memory as both are as relevant as
>>> they are for any other memory.
>>>
>>> If / when we get some GPUs etc on CXL that are initiators this will all
>>> get a lot more fun but for now we can kick that into the long grass.
>>
>>
>> With the current way of storing HMAT targets information, only the
>> best performance data is stored (access0). The existing HMAT handling
>> code also sets the access1 if the associated initiator node contains a
>> CPU for conventional memory. The current calculated full CXL path is
>> the access0 data. I think what's missing is the check to see if the
>> associated initiator node is also a CPU node and sets access1
>> conditionally based on that. Maybe if that conditional gets added then
>> that is ok for what we have now?
> 
> We do need access1 to put NUMA nodes into appropriate memory tiers, just
> like we have done in hmat.c.  Because default memory tiers are defined
> with performance from CPU to the device.  Is it possible to get access1
> always?

Let me take a look and see how to get this done. I think we'll need to define 2 access classes for the generic target numbers (instead of currently only 1) so we can store the access0 for generic port and access1 for generic port.
