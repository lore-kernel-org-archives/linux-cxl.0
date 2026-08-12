Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F25396D14
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516168; cv=fail; b=gHLmTbLx5q1WtCp5NI1dTpFH1ojU6qlhFGpA5CmIb0KSX8hcez5XamBYT+BjuQzzyn33pCZM0QXPK8zDrKYcIFNQnT6XO8hcJQnLBpRR+ZXu268gTUggO0jal7xO9sSZr55ObqmIU+og+MyOZIi93Np9sryXhPT14t2xW/weChA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516168; c=relaxed/simple;
	bh=3+kbKxBdL4TfCB36Hb4A8Xrr43/qETSztpkj92x5nYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gWh9nFYlil3347OyYqGFG0j4cNoCX5SIOgGAlXYPDask712TApvVkZ9exheV7rGWinXMkIZBB+DeKIbCABsQ2Mq2X6Gz49omD7iWL9jVeM19e9UpWa2Aj+CW4XeqkuQyUV2+dmOu6bORpMBKBWxyPny/emUhb/0pNLm3lwhWexc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uL8Kv4qQ; arc=fail smtp.client-ip=52.101.56.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uL8Kv4qQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtH7Pcw6GLCkVt1RCyqtp1NMri9CBSm4TTTIqp1ybz4pzEMz+pBMltsb6PRmA3S5hk5pEHMuiIRpAwK/L5YBzVQPXAql4elLk8XGYEJwfUYSPuWknWVw25A/AP4gg+++9YBr35SJGbUzIbjsUu0DoXqgoWkYjMoFFWdLPohPpUmmtpUUKofvg40jqljmqURmHX7l1v1/pL9RCyOhBwitOF4tVJYNgdLg1vHHPogiJGSjq83J+AbZAWAuE5TZE0UbyDgL1TI+6GFefM/QOxw7GPQpaNPq2CyJqWBb221j/CRXchZ8sGH3pCTQOBhSvLw4KI60FpoMvCWS+rvFCNFrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye7GU1hU2spuyy1hsdkE8Zgjj2wqiivqZ58N7Cl0Rr0=;
 b=SczThF9/8zuiEjYhefUOfL5U7wTozR6FVZH1hHQZSZBy3ncMISufctBfp+U0RweezNqApNFDDttCjiRYJalNo20Yd0dpZo0+yf9a23O1DlG4ji4OUsZwax/oDMFZ4YjohFJp0Nc3LaYXxhEuvYU1eYMw0KaMoQPby4pA/zhylF9VwC8eaOkbmRSm3VC/zGSQZWtAkzN4uYVflBqopngvVtu4A+yoXst8UT+aAzCXObUjPSA4zk2YPZ4INwmBxmHP3KsqfqBcUguMxSxuvxOIgeZmvD0/VEl9YZYtGXhGar4hJ05sy/QuRJlMtWx+V5tWiAsNrmsNp/MFiJmdfjceoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye7GU1hU2spuyy1hsdkE8Zgjj2wqiivqZ58N7Cl0Rr0=;
 b=uL8Kv4qQ0Yq4PW8UjpH3pfJu5lWoaKhnMafKO+PjlQ6H0fIR6UjnL/pOwXAwipvWe6COoHVzLmQv9/qvuLDuEaE/DCAFk91spFoHl7KO3SaJzHjb3TQuA5425257x04pIzkYVuRu6weRZtR2BZzKNuM4Hw01qYsMynZmVXs2cA/iAWPm+gF3e5DT+0bWQYsKoM4rSOy3yrJYZJZoMhwsgvqb6j1mZvpW53eG2IdfmW6tbuP/ZoN1h0Zw1WymhyfzvSKgmcdQ6M8gGhQPacxGkCa4V7H3b+LR4nuaJgG5U89Hmm+tqk3t4UeX2XBWBbOpFJdZPw+BTOxcHyy3EXL+Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 06:29:13 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 06:29:13 +0000
Date: Wed, 12 Aug 2026 14:29:06 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	Robert Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org, xlpang@linux.alibaba.com, 
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH 0/8] cxl: Assorted fixes
Message-ID: <anwSLJXiwmUi8cCq@MWDK4CY14F>
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
 <ant-ttVtO_tFY_rt@aschofie-mobl2.lan>
 <f43fe1df-e7ed-40a8-882e-2963968c10cb@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f43fe1df-e7ed-40a8-882e-2963968c10cb@linux.alibaba.com>
X-ClientProxiedBy: KUZPR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:d10:33::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad2e3b0-1c7a-4372-dd41-08def83b06ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|3023799007|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PGbpL+acHlntXKCsKZ6T1hCJXjUeB5v8PnOAzVK2koDEy7kVw+s0KbrUn0JnH0owlss89kyMl0rnnWfPAlahOSQ7yAKjefAvZcO+YtayHzNS7SEPLxYFleQHjLGd873zvWxjkt0hen6V7uLZjjrg/RRBD+QdA88hRUz9SmueB1OSNi06Nj56MB/lJZXGmzlbmYWwFtBTvsXsys+d8M9QqJRmYrF9PwAqs5dEt3Ahe41j0k0lOVS0mArNxSZkI67Zs2mh+q2CCXa4ukWEhYfRnyBioirlMgNAe78sRisWCpP+vVTA+03xttrXyUFhhFvqazrUiMW8jJk5NoG4Qu2GjLAsCVicdmVNviZcbxnAXZvWlHncn80bZWdOGDgzfxR+wWAg7HnEYroftwQ+L1JvqegazA6vwHk+slWsbflEoGjGB47+3cA7Pk+J357LLhE+KEFTS6HWeGkmy23cSllJeZf7+eCzulFv2UCzlOLZ89EMAElvOI8UQDCesrrAwG36gUnic9vapfIcP7vFx6SPIJBdklqHSz66pgbhBeLZuF+Fxkxh4F2vq0GC2LxO7rLBv1YGGMZUVVHM3KvO/FUBiRnZ6tGSaEyMFAjEb+H1AYWpa27tAAqp6icayDnFy8bHv0zjYat/0hWvLPDpcUVvEsinY6jda3SgWZ4dIcnIJs8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3BXWXJxb3FtZk9TdXBXSG5TaFZuYk1JdTF1NzgwRW5FL0FvdUc0WGNxeFBq?=
 =?utf-8?B?TG4xZmdIUHBhUGtHbmNZdHJTeDZJd2dvZ0tUOTlJaVFpcEFrd2VQMHdSSDJR?=
 =?utf-8?B?QjQzY0RqeE9vUThFdmg2ZEFFZmdZcE1XdzBxeHRNVHB2TDh2MENTMmtnL2ww?=
 =?utf-8?B?TUJNc3U2bHYrbWlvSml2eVJkN1hjZ044SXdaS3pKdC9GL2k5WjNmY1htcjRG?=
 =?utf-8?B?d3dQUjJmL0FGZmlYTTRDTHZ3R1V5OG54SjJ6WXZnNUQ4YUJXMDNWK0pYQ01G?=
 =?utf-8?B?MGd3MHBaRG5KbVZBUEM1Nno4MEhHN2tJV1RMQnBVMjhKMlR0eTJxY2JJbTJq?=
 =?utf-8?B?YWhIZFVNR3o4bktSQlZyOFM5aXBiY0I0QWNYQ1YwazI0ZHFJQmxGVXltWmtL?=
 =?utf-8?B?TWVXVUE2VEZnbmNGTFo0QjloRDM3OTRoWHVxWEx1a1ZpVkR1WTNXbmhHRTVK?=
 =?utf-8?B?bFY0VUl2V2ZWWHRiek9XVGxsaElnM3NZTUxDOEhVdm9UWlEvNW04TXJ5bTBk?=
 =?utf-8?B?VXlTa2FXRlB1RExLQ1Z5Y1p1NzIrZ08vU0toUk9mMUNmTy94Qm8zTW1tUHc3?=
 =?utf-8?B?bFpnc3Bsb1NLejdxL2NSL1l5b0NlZGlVcDNXbUd5WDFpdEMrcUJ2bmNlbnB3?=
 =?utf-8?B?N3NHK2lyQkhwNlRWQWdDWjh0THVSWUJ1U1pidnY4bVNUcDJ4VHpOQWQrbVZr?=
 =?utf-8?B?QXYvUUdlRERrUnpERUpHV1JzWkVycE5FN2NVQ2Vja1BnclhsMG5NN3hnQ0ky?=
 =?utf-8?B?N3laTzJ1UVBGOFJPOUNtN3ptbWdNRVY2Vm9POGhDMGJ5ak5yRXBTQkNLcFlo?=
 =?utf-8?B?SDU0S3BkSHlkb3gyTnRXcGJ4VlZuTWpEQnFQV3NwV1EvTDR0MjNrQWw0amJU?=
 =?utf-8?B?cHRBVzAycmpaYUVoUExwNDc1Q3czbDVveU1LdXdHVGlBMEswUnExQnBkQUpP?=
 =?utf-8?B?UlRrMUN6dVZteExCZGNpenY4UWFIT3I5NmtVUVRQdVRyaWozYjlxanB4VnZR?=
 =?utf-8?B?ajJWT2hpdklKWlk1SGx0dkJxMDBMOHJMbXpHYUxyTENxVVpVMTNiYktmeUtv?=
 =?utf-8?B?cjkxN2pKanlnMXhaeHUwOWxaNTFvaXBqVGxHZy9FMi9nMGcwWUtvaFk3Szc4?=
 =?utf-8?B?Q2g4VVFEYlJqMjkza002WENDZUUrdHhQSXNpa3VYVDlNWDZhcy9DNmc0bFRK?=
 =?utf-8?B?dHRqYVNpMmZ4UCtjSUUvQ0VRMElBdkFOeURCQXR2MFNGZkVVSFlMZHlMZlA5?=
 =?utf-8?B?NlVmL2srcWZEVjJlZGVIZy9QRTY1N0xVZ1NrY0g1NkFTclJDS3B0WW5EOS9D?=
 =?utf-8?B?WlduOVU2ZkFTeExuZEw3MXBCQm8yNUJWQTQ3TXFVMnJPL1lvS3pmdGp2Mjhm?=
 =?utf-8?B?S0ltOFFVb3I2R1lqRkNhOTFseHVvRzJIVHR1eXRrSGZYc3A4VnYzeW4yU1Jt?=
 =?utf-8?B?dkMxM3FPYTIyNEcyZDRuNDIxaGNnazYrNEVtMzN2WkhDMERVSFNlOXVzbmFs?=
 =?utf-8?B?dVRJbWZlQlVHb1MxZnFEcm90UlEwV25raUI4b0QrZXBERGNsVjFudWxSeWZz?=
 =?utf-8?B?OVhMdEVkUWpib2ptY0hNYWl1QVJVWGc3bTc2RGl3Qm9VYzhZcy9IVkRVVWNT?=
 =?utf-8?B?c3RRUFc1NklES2l1OWFuVzV2Y2pHUEhoU2tTc3BVUURlVzFvVVptclhFN0gr?=
 =?utf-8?B?aCtwOGdqcGZWT3YzWFdmSUdGMFZMVmVGb3pkSVNRZlhQd0xTemY2SFlXZ2Q2?=
 =?utf-8?B?ZkZCYVFTcE9RQnZ0bkVOM1pkWHNOcURESG5ka2xIUmdwVWFVZVBzNGlqci8v?=
 =?utf-8?B?OWJncjd1YnZYcHk5Z0VVYmYvVUZWalpWeHpBcENLejhFaU94bWhOMENRWWxV?=
 =?utf-8?B?TnI2dFZmTjJ0M21WSnRhbG5rUDZKSWdWa0p3bWlENmhsdG9LWG9id2lzZnY5?=
 =?utf-8?B?T3dwR20yR1Z4T0lsS0dqTTRGVElXV09nMG1UZTZOWHFoK0ZoOUhnajNER21k?=
 =?utf-8?B?cmkvbE5tWDFqSWtoMDZIaWdHVEdZMVJzL2FMZmVJQ3k0YWN6RzdRNC9qVEZ1?=
 =?utf-8?B?czhBMEFqb1NyM1JtZmZkMEliVHg3WXZIN2U4OFJRKy9XK2VyTzVYQ1JqeTZ6?=
 =?utf-8?B?LzBET21lZWk1VGlIY0U0SDJ5WWc3NmR1OURwOFl0d215akR4SW1yZkVBYU9E?=
 =?utf-8?B?R3VGYkFPL05iRDFHMU1sQ0dlWkRsUk5FRGdOUW5QVnVhM2ExRnJvS3J5L2Mx?=
 =?utf-8?B?MzBpKzh2N2g2amQyVTI3bjk5YnJPUCtwQVM2VTNMVEZBVGVjdm12UXF3UzJs?=
 =?utf-8?B?b3d6MTFvNWI3bEFueTVFQjVySEZQOU9ONDRtZE5CSTRNYkplUHM3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad2e3b0-1c7a-4372-dd41-08def83b06ac
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 06:29:13.6272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQzWQN7F9GPS+8T8JFRgGWY6lptt54XA9ufbWzQS3krnMKV3HeZTABQUcSmL0WHhwCXNaC4zfzWQGsnlhfIdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935

On Wed, Aug 12, 2026 at 10:10:35AM +0800, Guixin Liu wrote:
> 
> 
> 在 2026/8/12 03:57, Alison Schofield 写道:
> > On Tue, Aug 11, 2026 at 07:36:00PM +0800, Guixin Liu wrote:
> > > This is a batch of fixes found while auditing drivers/cxl. They are
> > > independent of each other and can be applied individually or dropped in
> > > any combination; they are only sent together because they came out of the
> > > same pass over the code.
> > Hi Guixin Liu.
> > 
> > Thanks for taking a look at CXL and putting these fixes together. I
> > appreciate that the intent here is to make the individual fixes easy to
> > take or drop. From the maintainer side, though, a grab bag of independent
> > findings from an audit has somewhat the opposite effect. It leaves us
> > with the audit results and the homework. :)
> > 
> > We have been working through this kind of cleanup in focused functional
> > areas, like features, HDM enumeration, etc. Please take a similar approach
> > rather than collecting unrelated findings into a single series. Address
> > one area at a time.
> Sorry, this is my first time sending patch to cxl mailing list,
> I will pay attention to these next time, thanks.
> > 
> > As part of that work, please check mailing list traffic and cxl/next for
> > fixes that have already been posted or merged, and review the pre-existing
> > complaints reported by the Sashiko bot against your patchset:
> > https://sashiko.dev/#/patchset/20260811113608.2815625-1-kanie%40linux.alibaba.com
> Sure, I will check before,
> 
> but why dosen't Sashiko reply directly in the current email? I can't reply
> Sashiko.
> > Please also follow the conventions we use for fix commit messages. They
> > should not narrate the code change, but rather describe what happens today,
> > why that is wrong and its impact, then state how the patch fixes it.
> > For an example of switching from code narration to behavior description,
> > take a look at my recent reply to a commit message w similar issue:
> > https://lore.kernel.org/linux-cxl/ant2Z1mzHCrzmzXn@aschofie-mobl2.lan/
> Got that, thanks.
> 
> Best Regards,
> Guixin Liu

Hi Guixin,

I think some of your fixes are already addressed.
For what I've known, the first 2 patches are already covered in my patch series

https://lore.kernel.org/linux-cxl/20260708074228.43654-1-icheng@nvidia.com/

Best regards,
Richard Cheng.


> > This up-front triage is becoming increasingly important as we see more
> > AI-assisted audits and fix submissions. Without it, maintainers end up
> > determining whether each finding is still present, already being
> > addressed, significant enough to fix, and where it fits with ongoing
> > work. That review burden does not scale with the volume of AI-generated
> > findings.
> > 
> > Rather than reworking this series as a whole, please apply this feedback
> > to focused CXL fixes you submit going forward.
> > 
> > Thanks,
> > Alison
> > 
> > > Guixin Liu (8):
> > >    cxl/features: Validate the fwctl RPC input length
> > >    cxl/features: Bound the Get Feature output by the user output buffer
> > >    cxl/core: Fix dport use-after-free via the einj_inject debugfs file
> > >    cxl/pci: Fix NULL pointer dereference in reset detection
> > >    cxl/hdm: Fix out of bounds read of the decoder target list
> > >    cxl/cdat: Fix uninitialized stack use in endpoint bandwidth gathering
> > >    cxl/mce: Validate the memdev and endpoint before use
> > >    cxl/region: Unregister the pmem region bridge on setup failure
> > > 
> > >   drivers/cxl/core/cdat.c        |  6 +++---
> > >   drivers/cxl/core/features.c    | 15 ++++++++++++++-
> > >   drivers/cxl/core/hdm.c         | 12 ++++++++++++
> > >   drivers/cxl/core/mce.c         |  8 ++++++--
> > >   drivers/cxl/core/pci.c         |  8 ++++++++
> > >   drivers/cxl/core/port.c        | 18 ++++++++++++++----
> > >   drivers/cxl/core/region_pmem.c |  6 ++++--
> > >   7 files changed, 61 insertions(+), 12 deletions(-)
> > > 
> > > 
> > > base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
> > > -- 
> > > 2.43.7
> > > 
> 
> 
