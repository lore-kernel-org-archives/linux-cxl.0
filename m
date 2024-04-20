Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383A1CA8F
	for <linux-cxl@vger.kernel.org>; Sat, 20 Apr 2024 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713645356; cv=fail; b=NsVYGL6KmlDgtsmSV9nrciBcyGNGF8e5w3gQPBxq4ZI9NqRJt0NRwQMlGsWrNwwgeYG3OvB1IOTbfwHwrLk9o6p4lrprpEjMkf8+89FQ0mMnGT7eof0iFaQmbYhB2e9GBpj2vHPDKRQfvCz/XDkgyQIlD/zZmTmMuAf0wzzAdB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713645356; c=relaxed/simple;
	bh=rx8NiZHhM1xCiujyTnlo/eJdAszv1fACIqhiUc6ivtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oHA44Uma59ncREqOkKN8SYFfy5pahzQ16snatMgvLpnqn3qNCw2SONPXXVLy05thO53weVjGD18S938n63pdW0KGXO8csatUAB1IAaraePwbByijxrdzCtVhbs2IwGfuSRbG/UsJNyc9dOilXwoOjRLuRKpAjFBVPZiHF8mMJss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=UHW6+sYV; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="UHW6+sYV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahWWNS7Tg99peCzbxquHJpNREpKuual7uI56Wy1veGZA8luC5Vn4gAFbfXjvJ+QWVhXQUTBhii01hyrBYE/OQahr8LPJRwhMgBm8lqOLqyAJx2eJ9SX099Us7SH41RmtThKeNKgh/JUy6oENcl6+e6gXQeupg/DR3y+jOWpwmSmQeW7/U2lr6lqkxT8TeuhyhfxY9Xn/+DRR2Z//T9kyB64n+idRUpnNjUlbdTJsp/6gsvgTPb5kkjZtRZoiEska+5SQXymZPe+ZA3y8BzD7F3sj7jkxWOXdKns/C/IAaxPm5WUK4KAYv5aRZ7DzdulUJxTVvU0ed2Q22yxbvZ2+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5HAht4It66XfuUGp2JkLgdLwwdbtZ4fnKgCyfnPbo4=;
 b=etc/Bs149H1CA34/Z/xFGecCuljanMdjmKFwwsDv3P4IT/we83VJvKi3jH4vJbgVcrQPpOcJZQr04UpEIBjGtKvjMAAaInMunA+u7OLcS5epJuhzHea54EbUZAawtMqvTf/kSAiCH+xA86L/rC/CVQUSantko9rhH969e4FY+GIeFhsqKGyRt1e1jctl8nz9cM6uvJjBPmfjWAHETglv7Kaz2oGzOkHABN4H1zIdaC0PyRoL4X3aVrOY/cv9FLVWh+kUH+T4jm5uc6oqhooHvQTm7im0/tVdZefGpquAZaU0MopBz4NZcogBysS58xVdjQTYpNwub/f7+iEIvknY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5HAht4It66XfuUGp2JkLgdLwwdbtZ4fnKgCyfnPbo4=;
 b=UHW6+sYVVPdEh4NrcUH4+c1J+pFk6a+pCNGmi0yHKkZTd+NOpwMV/KxyPRYAsXpMP5z9w83kmv/uoS4E0klIRT4cwX3+8lVLAyYXCYes3OB+ftn0qyN1vWZzX9lNyVDD5kboKv+cA5kO8C1id33MWr9zG8SYlVforWLlXafS1+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4809.namprd17.prod.outlook.com (2603:10b6:303:10a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Sat, 20 Apr
 2024 20:35:50 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Sat, 20 Apr 2024
 20:35:50 +0000
Date: Sat, 20 Apr 2024 16:35:46 -0400
From: Gregory Price <gregory.price@memverge.com>
To: fan <nifan.cxl@gmail.com>
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	fan.ni@samsung.com
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <ZiQnIkYjY3ngRLAi@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <ZiK25Log7LmtBffa@memverge.com>
 <ZiK7QtVxutwDys4K@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiK7QtVxutwDys4K@debian>
X-ClientProxiedBy: SJ0PR03CA0283.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::18) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: 3634ceb7-a272-45e6-51a5-08dc6179775c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rUaxBuyn0THTp4hyW7MrfYHOKUqNpKb4Sdm5Lgx0p6PQF1b1kXDgobOdHQ5C?=
 =?us-ascii?Q?k63FjsaxTqe1RyvJ3go4D7kfkOjOM2TMxV5Gsyf48ez3kFoeJZySY3nJb2H9?=
 =?us-ascii?Q?3l+7eLLUXNV3M4RNYwlQl18SibLYO81dCr/C/ACm5ALe3mpL0pA6uyeK0iTz?=
 =?us-ascii?Q?HDf+41Uln+cfSOkspD3Ay3OkfPDBaJf6Q/2CDTtu5rDViUNv1U2ZSHpMpz1N?=
 =?us-ascii?Q?ur7zSXe7HehiS2+Fy6Kj20WgSTjeSRo8E29PQN8ugNWnuTa7or6gBHOt5pWw?=
 =?us-ascii?Q?Ybj+mxqjfYg6T/88p2l6IWEoMeK/9nSpisnsi1uGqPJfik79KcXGUtMUlpl+?=
 =?us-ascii?Q?QRAH9Ctg+hlEJb9HPbbNujqbCw6nUBf60+MdAYy7WdZWNmNjjWNSLuoz+kF0?=
 =?us-ascii?Q?kQ8mATGOdLDly7tME1yMVL+ffP1Jhm1SUVtChQLJtu5Iu9VlhBKIpZTaerNF?=
 =?us-ascii?Q?VDulOIsXJMhRtdERRY70NMw4IMVF/dpj1nfJTxl+44JbGs92igbiRX8pKUBt?=
 =?us-ascii?Q?rBP9R/9ZGnTTYP26RpxrZtvH5vzs/mc/BlhM69jkvp26nwdFpieYiDwvv9Fc?=
 =?us-ascii?Q?8JZ2i6cLdSWqj05FgXTSTA1mtixToBvY+VSkSS0kEGKs5/WZwyK53AQXCJ5n?=
 =?us-ascii?Q?0Y/hYPlRwoydnJsybn32+7ob6fSN+WVwFuYHXZpvArUvfypk2bbaJnW//zz8?=
 =?us-ascii?Q?wMaYwHes/NK47qm+MBvfIn4s7rz/w+HQ9Hqxtl43aU/KzayzLGZMZIR7rtUZ?=
 =?us-ascii?Q?IvUOYwZ94nOV0z9Ye6DF2P0q1rBQycYuKAIc7r+3bqeXoAxDLdNH89S3mkRF?=
 =?us-ascii?Q?qU2Rh3jHUp6gv0RxsEfX90x0GfjQsIjI1+F5o7R6TrFaVnA/bMcJ+AUqxZ95?=
 =?us-ascii?Q?n51xdLYDLsKela2U/tinE3rDarUsHw1EDXSRdTgOBe20nY0BAo8s8QiGKxFC?=
 =?us-ascii?Q?W+A8IOQdZwf5NGLKyoQvQnSA5yfYmA5ueA/j88hddACZDQxzSUunOCZ5fgpU?=
 =?us-ascii?Q?2SaJXiCSWZwCascfx4TBhDgBMSB6di5sXQytFcf+HmxpLnEBNDlEMJdXUthI?=
 =?us-ascii?Q?8PlJC8YKVVxL2zry2YgXNA1eehl/PbR+opwo99ZkG4AxiKclEdbpQK5JgYER?=
 =?us-ascii?Q?ZKnuJTPWo4iCI1rZfUBi86y8a44U4lyCvpNwsP5Zdj+Nqcg44jWyXoctJp/7?=
 =?us-ascii?Q?lT8BFlHlDvzQ2pE1oiWlb4Mpp6RP6FOr699a4P1O0Rt7E4qm/ck+Fiew8Nk2?=
 =?us-ascii?Q?ml/IRG3wzu9ZSUxNjXDf/eftKe19Zh0tHAbTUe2qpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h2JVhmbN06qArieLHIaZS/+5pESAJJDqaMNhbvQCFwcybRZWakOxJmFoJ0ci?=
 =?us-ascii?Q?x4NeDyw2RSwyVoK6oI/8q5t+R2Djuk8R5vcJVhQXCRV64utPbqqBP1IVhXQs?=
 =?us-ascii?Q?uACFPbPPpkRmRR8WOiIKwEZ64Ojcw46DN65Wo3Y9bwE6y4JaWjJaMQWeXhtb?=
 =?us-ascii?Q?uMT0tHGJxGCnywhbbmwCuxApMqMeTMrr0AzS4DirM+DaUxSA4gU20uW97JT/?=
 =?us-ascii?Q?8vaS1pHDhD7h62TsikbcwaBe1npiXEl2xvRzTbnGYOE93WSfv6C0KqsdM9vk?=
 =?us-ascii?Q?9OASx+eFLGFU/FASpyROpWwzO5rZswE/qKwGyWwYYA42epGBvuP2eaumRwSz?=
 =?us-ascii?Q?OsB6UgNvi4ubLqRljGj5BOHuNJsXNJ1oddIBtR5EW8jlK9TaHfWsK/qgRlXj?=
 =?us-ascii?Q?DoCi6Mba4DnqAAbAPl17DJzHwL59Ax7JtkvnRDbH7xp+8A9HHgFphtmuRK8B?=
 =?us-ascii?Q?qwj59fRziXbKQgMAWAdOtPwNDtvLD6dRNWQovpjYbRv2dBj2wPNkvu21cAtd?=
 =?us-ascii?Q?szPnpBdBM70fMe+GhQiSfPEKjc9eFbwjXOjBiscbAJxKDE0BjBaZ/4ZrSa5L?=
 =?us-ascii?Q?J7wNnzjVRojxtc7rJQiwL7p2MpjHS08fdcwkDONiI7ks74vWmkviKpmvHbQv?=
 =?us-ascii?Q?9XQdRGF1+Uv0+b0perjxY45Obt++ftxNMiE3lRELI0N5509F/Ko9MCKCqhSZ?=
 =?us-ascii?Q?cGKGLnyS8GVWFtQcPL2/NRZ6D/EnKJfVcqZky5lvyVA2soibhNQCm/bZaQUk?=
 =?us-ascii?Q?Q4IpBpvfBlj6iZf4bW3VipJymUGHVUTpJvxlTJg3eJbelWoxAaG2HSfYaLdC?=
 =?us-ascii?Q?KMXDEslkBpDhWEHiW2gbTdwsYibvPeGyOVTksbJ1rQ8qE/5kYevaf3mQMhT8?=
 =?us-ascii?Q?1S37Izcb5iLG2X6Ah4XIKhDLHp1r+FYCoDGjlHQ3N+1QF9eNHK1FKK01Y6nW?=
 =?us-ascii?Q?uFjgEaRZEZsPhdVIpR2n+K0mEo/86ixZdGFsiznxIxxTYCBYIWsJ9E2jhryK?=
 =?us-ascii?Q?4FN2rL5G9OxpkdKI0zX/k8lUNxrZfXaAYNMAduncvFs6Mk63WtI7py0/IyGm?=
 =?us-ascii?Q?hi73RZBEoTGNifk673a071u8W26pt1cdTWD2oA+hw3k2+M7ifUzVi3vPhWVP?=
 =?us-ascii?Q?umrTnVL8LTc4V2Yf4BPiIrG8JjQemjhZMl75ouzvAgzGBJkdUvlyjTrQQeUx?=
 =?us-ascii?Q?zilWwRbpDFe4JlvCKdxgp7NGcwUG7Bv66aOkKp08jo1wQ6VfjtSEsn+r81bc?=
 =?us-ascii?Q?2Yb18DHsWATW2SF/GR/j0kaAfsm9mySLI8ndLIXSKk1wG+TyLTXeK2MWoY12?=
 =?us-ascii?Q?Smt9N1uRv5J+zIuIKGkXzRi+gQgdkr6X40P5smMNgMdyjHb+e42HDs7Ufk8j?=
 =?us-ascii?Q?GXheaMF51s+RuZO9BKferq3JPUkh9a+BrQB76zyAZcr4XqD2BQ4O0x8fXY4C?=
 =?us-ascii?Q?N6Ng1Vg64kXK6xcla6lluNcMTH/IRdllcZGcbsWP3mZ7Igw2N0aJedKRZ7fh?=
 =?us-ascii?Q?vYekJoRkV66frgZHuCHpr1YCmjg7X5tFDtNqoXDMp4mz3M6goka3TOx67e0p?=
 =?us-ascii?Q?D+gQzw8FAx0fuuskD6bvOKRsQQoqIBOZXJzGmh2+eZNz9nV96gNz9KlTYCR1?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3634ceb7-a272-45e6-51a5-08dc6179775c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 20:35:50.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtCQ/iL8TqxYj56Kg/1zkLK6ohDpgOSK8iTl8a/XH2FMSlUail40qIg4qfzYvcW0pU3rBrhePt1LRfhOpB9Fe84TFR6HmHthBRLGrGBJtJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4809

On Fri, Apr 19, 2024 at 11:43:14AM -0700, fan wrote:
> On Fri, Apr 19, 2024 at 02:24:36PM -0400, Gregory Price wrote:
> > 
> > added review to all patches, will hopefully be able to add a Tested-by
> > tag early next week, along with a v1 RFC for MHD bit-tracking.
> > 
> > We've been testing v5/v6 for a bit, so I expect as soon as we get the
> > MHD code ported over to v7 i'll ship a tested-by tag pretty quick.
> > 
> > The super-set release will complicate a few things but this doesn't
> > look like a blocker on our end, just a change to how we track bits in a
> > shared bit/bytemap.
> > 
> 
> Hi Gregory,
> Thanks for reviewing the patches so quickly. 
> 
> No pressure, but look forward to your MHD work. :)
> 
> Fan

Starting to get into versioniong hell a bit, since the Niagara work was
based off of jonathan's branch and the mhd-dcd work needs some of the
extentions from that branch - while this branch is based on master.

Probably we'll need to wait for a new cxl dated branch to try and sus
out the pain points before we push an RFC.  I would not want to have
conflicting commits for something like this for example:

https://lore.kernel.org/qemu-devel/20230901012914.226527-2-gregory.price@memverge.com/

We get merge conflicts here because this is behind that patch. So
pushing up an RFC in this state would be mostly useless to everyone.

~Gregory
