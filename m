Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2131.outbound.protection.outlook.com [40.107.244.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F216ABE3
	for <linux-cxl@vger.kernel.org>; Thu, 18 Apr 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463125; cv=fail; b=DwBjB+xA0YppenFl85YXo8iQpkAX2X+xPmEztahhUGRrFg1ibVECpMfA80JkRQPexUuk3cyWYdBJGeoGkXK413AJg9GBvuumIGGDhOrE4xc4454DsRh35XqsCJ5BCcc1uIR3A2nopv5k9LCyLGjar5VL/jrLqDwgDitgwUE97Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463125; c=relaxed/simple;
	bh=5ER2M9bKFMMX4e+sCL63frsucXgLbac3irNro+jPz1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G8TGu0uqjZua/Nss9gCHQAA4njkzgwoiHBr3J07zDZjAzCMEafng/AI68qmBYDFtk4+to3puW4eemBtzBKbSRmNnS/F2Yq6bOMogvvSGAKCK+6UIjq6GTin/IJS+uX0pVk7QhoS+zYnFTY6+S4z9Lh/PlMZ0LuHVEWDRAnyyxCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=iKyayCBM; arc=fail smtp.client-ip=40.107.244.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="iKyayCBM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3/kBZ8xFY9iuHdgjX6/ZT7UeehpLV8dNOYpUvZEgPN0RUGQYMBHxNygx33KAzyfiv+hdgNlvHUCjhtAOihWb0t9QmTcrceJfBI7MXsmlbjdWDB6t8/I58TLw1U8G7GGMnSzYVi7ygujgt8In0O0CgrlVbNDJlYxKU4Yj67NaV0l+u19qb1HvgPC6yQZzyjrNswkHr1ivvbe+YAPuMX/6kDjgnO32xOYWyYOu8+tjgI6cwSchYulMrIdVwOnyO9hg8nHvnWt1mEuZgpe3tSfbigHUfFI24gmf5t5zxnYUMXBpJwjYh77jhqLt7jbhtET1UWGyhGB2AeOmmrbCrlt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+jzjAz+E+p8ZoqISesL/6FzFgsFdhkxwoG8rFiKA38=;
 b=BaWgdABz6wa+6TpZkOPNYqjX4OEf1MncmtguGEEJ9Uoqedkd7mmEe9/ffcS5+5rwvgOeKno2AieKKtpBXo+poEo/GA8GfYzGlPYvRN2brhCXBQWbICCTO/LD28zzBdIqyYfh/bdeR046FhXgffNeN6LvZn0uWN/4UBQR5tHsPYXYBVmeskpJh0WCURyWRFY3729sdxmL+whHe9710V7mcIUF7uSsPNGeHkFkz1JziiiJaL208E7ndjeptCZsJR065dZkuCeIcup8a8JIEklWmbYh68Cs1I9lFXIPPZxmEUsTkpTF9q8/h2VEcakvhiWrsDirfllhXW55ALklYsQu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+jzjAz+E+p8ZoqISesL/6FzFgsFdhkxwoG8rFiKA38=;
 b=iKyayCBMmJP3sYp7iT6DP1VdRpncruTTbR3581cXwNsUXSXJ+KDATKTMaULn+LxBJIjgM/21N+3RacJxB+H9ahSnReP8oWWd0S4dTYEVjWsM055URl1QPVjrxUZ049D1WZqb9MDngBv/u2XqhjU7us8cz1GKXmSJpPAFB6+xgfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BL3PR17MB6164.namprd17.prod.outlook.com (2603:10b6:208:38c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 17:58:41 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 17:58:40 +0000
Date: Thu, 18 Apr 2024 13:58:41 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <ZiFfUQonwWdrEVNP@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-11-nifan.cxl@gmail.com>
 <Zhm7ssKVGdGlR9Iq@memverge.com>
 <Zh1lk8FWmf0oI7RM@debian>
 <20240416160056.0000325c@Huawei.com>
 <Zh6pNVIZFMQadmOm@debian>
 <20240417125951.00001db1@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417125951.00001db1@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BL3PR17MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 245fd504-6d06-4484-05e4-08dc5fd12e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTZCUi9rT0QyK25SL1NyVENaSis5WlNyUS9iL05OTHFHNDNROXZITzVvWEM3?=
 =?utf-8?B?N1lXTnNwNVVPWVNGOTdML29lOENOVXdpYWx3akpTM3gwRmtQWnh5UUlxMjRE?=
 =?utf-8?B?WVJiYk80V05FNDZRc0Jpd1ZCMXdGWjUzUWduU3RtUHVkS29QVHVqQXdyVWsr?=
 =?utf-8?B?UWNVSmRvWWFKeHkwZTZTTHI1L05QcnJGdFVoeUhieWQ1VmxxaUhINVpjUWZ0?=
 =?utf-8?B?Q3phcUxudWpnOEFBM3JIWEc1OWU1Z1krWktidWJ5Yzg5TmxqbkorU1EvMkIy?=
 =?utf-8?B?VWJ1bm03RnA1aGhrNXptaVRYMVhDNENPbVVsTVMzMFh4QnFJUmRmUkJGN2VU?=
 =?utf-8?B?aHYzbmwwM3VVdmI3VGFMdUlzOG0xY3FzVEdDL1ZCZThieExHMlVuRXJBaDZ6?=
 =?utf-8?B?ZldUOE8vbWI4VkswOFRuaXUrYVFMQmlXR1NMNkpPNnd0dm54bVg2b3ZlTFlI?=
 =?utf-8?B?ZmVNSEQ1Wk5aZlVBNzgrWTFzSmtCcUd4aTVETEdUYk5SUGw5OUx4c0RoMkVQ?=
 =?utf-8?B?ZTRhcXk3ZkYrc2MwV2dST3VGZWhXL2p2d3ozRkhnZVpzRUhNN2RyczlTZkVa?=
 =?utf-8?B?QnRPcFBXdVBOdHFXcGV2aEFlamdoczJ5aXdLWUlhVE9oY1hEdjlpSlZDbTR0?=
 =?utf-8?B?a0FLNDhwdXVKYUJvTi84eCtGQVlnS29XL2EzUWZ6YldVOTdqSlhrM0FpU3hj?=
 =?utf-8?B?ZS9aY2lUQlgybm1NSHdYc3BKYjl1SU5RSmZGbEt4N2ZEOHViS3VrUkZuYk1D?=
 =?utf-8?B?SlFIeFllZGk1VTlMVmlSdlpQbXJleHNhZ0FhMXRvQmlMaVpnVHUwcitKcWI3?=
 =?utf-8?B?KzR6Y1pkc0prYkNrU1R2UnNWVHBlNjZTbmU4SHVZeGYwWHE4bk9sdGRKVTBH?=
 =?utf-8?B?TG40eEJEWHZEMFhrTzB3YnVGMkRLWkllby9UaWFnSHJoQXBpNkxjMFhkS0tO?=
 =?utf-8?B?YytQbk1MVWQ0d3JaaURuL0EyVWpiL3ZmeGJVeVZzUTFXTWM0bWxxQVRtWEpS?=
 =?utf-8?B?aWI5RHpiZGsxRTE0cW9mSThRREx6WklHcjBoMXIyb0w2ZURPUGhnR2Nta1gw?=
 =?utf-8?B?WEtlenBPS2Q0VmRVKzRQSkU2S0FDUVNZb0xUa0tyL1piLzJOUHlPVnpaRCtO?=
 =?utf-8?B?WHhDV29SWXhkSHBhUGhuK3RGT2FrTW40TU5LVGR3T3JNSnAwMmZNMjk1OHl4?=
 =?utf-8?B?M05VWEI1c0svYUVPNDJ1QmZmeFFicUsrMFNMcUNOWjE1YnRsRFdOWEE4dTE5?=
 =?utf-8?B?djJncVBoZExDTysrMTN2Ukt3aERCdy9zTEFneEgrK3NSM1kwcTVSQ2lLWWNT?=
 =?utf-8?B?SDZjRTZpL1JZaHdlRXZhc2pHK0tsQ05RTGplbWltem5pOHVtVWVuL3pXbkFT?=
 =?utf-8?B?UkNrcEhHRzdDYlVuRWpySlRPdU9BR3d4WCtHMDJOQnpwaFRBM1VvbWFLZTBK?=
 =?utf-8?B?Ny9rcWt4cXI4VkFPUjh5MlJXMmhLdnpMMkQ4R0hSUGZIdzI2b2RGa09lM0dB?=
 =?utf-8?B?cUNKcDZJL2dLbzNPNkN5dzBmVWhsT2xGWU0vb1BLVWRaWmltZnAvdmU2U3dS?=
 =?utf-8?B?VVp6YksvWXRDUlNTajBDM2M0aitzZnkxT1F4Zm5GdVZ4bGh6L3RnNkJkc1ZV?=
 =?utf-8?B?eTB1VFBvTmxmbVVPRyt2MXBvenQzTzBPbGpHUTZxd2FaZDNoOXc2ZjdSbExo?=
 =?utf-8?B?cnNVdlh1ckdwQkNVK1JxcFU5UTgydTZpMDlIblNkMTF2QXJ4aVZRSjJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K25DdUdMNXd2dVMxaXNYY3d0cHJ5ajFVa1IwUEtDZkpxNG5aMVQzQjZ6OVFO?=
 =?utf-8?B?azM3amlPeEZmRlZEalh0TnBEU2tqUGh6YVl0UUk2Q2dhYWg4UlRrTlo0MEwv?=
 =?utf-8?B?bUhjZ2xoNjRuYXZIUXpBOXlsenVRRXVvQ2JSZUJMbXJHZWJxaVBLMm9ibGZo?=
 =?utf-8?B?UXAzMHNEYURTbmZ5aSt4RXhSUjltTnh6V3pTdU1wSTIvL2t2V2hGcnM2ZlZN?=
 =?utf-8?B?bjZ3NDhGLzArZXBUWm9ub1kzZ1RPaGxCTDE1ODNCb2l1SUo1YmwvcXFocWZQ?=
 =?utf-8?B?bnAzSWlnWTgwQm15RXVvU1dRRU9hYm1OUDAvRDdYOWN3SUpVdi9VR20wTjhW?=
 =?utf-8?B?UXlsbFIyakVlZVNMVDd3elRiK1JEclMxdnZoekJKamhPaUVReXgwRTJ2cll6?=
 =?utf-8?B?Z00wajBqc2x0UXUxRlBtWVp2Mm1QZjROcERRdnR6VkxXWGgvMzF0SlloRCsz?=
 =?utf-8?B?QzRoVDJ6T3VOeFhzWWEweDNDaVl1c0J1M2h1ck1HVUFuQWJsSmNEZ0FFQWNZ?=
 =?utf-8?B?T2NiZTQ4WWNTb2hVN3pRREVYOGxOOVNQZHYvY01DbEhNdWNOZkNTYTlWL2wv?=
 =?utf-8?B?M0hqbmNoS0kvSlNTT2RpeTVNU25mNHNuekcrQy9LUmJuZDlMZW5OUWtUTHd2?=
 =?utf-8?B?Q3NsU0JjQ2IxOXVIclo0TCtlc3NoSisvZGRCekR3VTkxZDZrNmZKT3cyQVRx?=
 =?utf-8?B?eU91MjBOK1htWWRZZFZOUU1vSVZVSWpwSXhpdG5YUGVzNEwwTFBEVlFPbmxX?=
 =?utf-8?B?OC9GUkVSZ3FaT0RNSGRSUmpFWktSalo2SUQ0UnRmV056UjNqNjRFT3BIMU50?=
 =?utf-8?B?dzFUL0gwdzBnV3NZRDB2cjE5cm51SGlsTmcyblRycXl1eWtGL1RzLzhTbzlX?=
 =?utf-8?B?YTFrN0hRMlJuYklHZFpIdzVuU01raXZTWHdzTDdJOVFON0dEWVd2K1R6SGtX?=
 =?utf-8?B?cDRIQzEreUtQVlh1TE9iaG1JUzlKdFFYUjlTNlR3TTlnK05wSVVpYjV3bnhl?=
 =?utf-8?B?ZnpucUJSNFIxaFdONERjTzI0RHVXYTRpMHdrRDYxdjBoRW5ST2IvOURmbU9a?=
 =?utf-8?B?akpYbGpIWE91OXMvT0hNS0cxVEp0SlJwNFZVY1ZKZmczRUhyZ2U0L251Z1lj?=
 =?utf-8?B?dFZhVnV5elB1ZUVnd1lZNWhFZ24wYkwwcmllYlNEclRoUWRYc2YwSEZMclpD?=
 =?utf-8?B?QzZVaHNmK3B2Q04rSnoxY2t3Z1pxNzkzQXFlbVhNOTZNbHhCOWVveTMyWXdi?=
 =?utf-8?B?WUVWZk56bnVXSnZiU2FPcXFpeW0vNHhvOWxrTDhidktkZ1l6bDhlNS9mYnpQ?=
 =?utf-8?B?RStIWXpVNG9aU2pMejVEb3lWVEZ0KzY5ejltcHZZNGdpQTFySXErSzIwa216?=
 =?utf-8?B?bXFROG4xVEV5WXF4RG42TmJSOE1FUy95Uk50UW04bVpSUWFwYUlIaXZEYkpw?=
 =?utf-8?B?UVQvYTVxd2tJQU0vd3hSaGtSYXRvNlVaa3BTRTNGQWsrbEl6K3d1b2lGZFA0?=
 =?utf-8?B?d1I4ZW1jMGpkM2tGdFNrNGhnTXo5dG5vb3dUbzhiSDVycUNLdFJOS0MrL0do?=
 =?utf-8?B?SzhBVHNUMkF4T0pLN2Q3bG16ZUxIRTlyMEN2MTQzT0lpN0xYUENDaEJjK3Z5?=
 =?utf-8?B?dVlDNDlSUmw5UWRCcnVKeVExWjF0OGJhbjQyNkJ5c3ArbjljbDZMMFA0U3FM?=
 =?utf-8?B?ZDlia29XYTBQc2g0ZngrRzVjbmZyYnprNk9hVUVkd3B1bzk1OVpWa3FudXRk?=
 =?utf-8?B?NlcwU2VwY3dSM3NmT3R3QmpGbU1wM1ZGaHBwdGdJbzEwOWhkREw2WnpseE04?=
 =?utf-8?B?eWZDbngzRmJ1Y2pSUjluR1FKNERtSURYMktOSk1obDJDc3dxMllzdzJVNDdh?=
 =?utf-8?B?T2JiN1VHZVd0OWtDbGZhQTBnSWxaaDNDdkFLL2wvTHNCVmR5aUR3cVhCNlJG?=
 =?utf-8?B?Y1lKQ0t3NmRZVlc1YVV5WlpjZ0F5RldyZ3pHRzNyMmw3WU9VZG1IRkcvRnZa?=
 =?utf-8?B?QzA4YnB3TEkyeHgzb2V6dXpkdHVTeUVDeHkwOGVNQkFWMlZUdTJETDlCbHVx?=
 =?utf-8?B?S1hWcGxzbXdubEhKM3EzMGQ4YlVNZ1hpOGgyN2JEbElLTFRHd2xLRGR2azlo?=
 =?utf-8?B?S29rWUI1aXptdVczVjhFOUkvRXJMNTBVb0tkLzc2aW8zUVJjc21iZ2hkRjVx?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245fd504-6d06-4484-05e4-08dc5fd12e20
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 17:58:40.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Qna1AkG1rYEN+K3EbGJGQhzY//zGCovy5CYii8bvQ1LkBc5lynA/SbykiZY6mht5w0DxxHJEHYKgnlyJCT9i7f4KKtWrLKul0cIVxJZkvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR17MB6164

On Wed, Apr 17, 2024 at 12:59:51PM +0100, Jonathan Cameron wrote:
> On Tue, 16 Apr 2024 09:37:09 -0700
> fan <nifan.cxl@gmail.com> wrote:
> 
> > 
> > Currently, we do not allow releasing an extent when it is still pending,
> > which aligns with the case you mentioned above "not release for reuse", I
> > think.
> > Can the second add mean a retry instead of reuse? 
> No - or at least the device should not be doing that.  The FM might try
> again, but only once it knows try 1 failed. For reasons of this aligning
> with MHD case where you definitely can't offer it to more than one host,
> I think we should not do it.  Whether we should put any effort into blocking
> it is a different question.  User error :)
> 
> Note, the host must not remove a log entry until it has dealt with it
> (sent a response) so there is no obvious reason to bother with a retry.
> Maybe a booting host would reject all offered extents (because it's not ready
> for them yet), but then I'd want the FM to explicitly decide to tell the device
> to offer gain.
> 

This might be the only time a forced-removal makes sense, considering
that removal of a pending add could be potentially catestrophic, but if
the FM knows the host is not coming up and never coming up, an
allocation stuck in pending would not be recoverable unless you
force-removed it.

> Whilst this is a custom interface, the equivalent FM API does say.
> 
> "The command, with selection policy Enable Shared Access, shall also fail with Invalid
> Input under the following conditions:
> • When the specified region is not Sharable
> • When the tagged capacity is already mapped to any Host ID via a non-Sharable
> region
> • When the tagged capacity cannot be added to the requested region due to deviceimposed
> restrictions
> • When the same tagged capacity is currently accessible by the same LD"
> 
> Little fuzzy because of the whole pending vs 'mapped / accessible' wording but
> I think intent is you can't send again until first one is dealt with.
> 
> Jonathan
> 
> > 
> > Fan
> > 
> > > 
> > >   
> > > > From the kernel side, if the first one is accepted, the second one will
> > > > get rejected, and there is no issue there.
> > > > If the first is reject for some reason, the second one can get
> > > > accepted or rejected and do not need to worry about the first one.
> > > > 
> > > > 
> > > > Fan
> > > >   
> > >   
> 
